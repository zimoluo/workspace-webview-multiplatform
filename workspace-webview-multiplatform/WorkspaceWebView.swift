//
//  WorkspaceWebView.swift
//  workspace-webview
//
//  Created by Zimo Luo on 9/20/25.
//

import SwiftUI
import WebKit

struct WorkspaceWebView: View {
    @State private var page = WebPage()

    let htmlFileName: String = "index"
    let subdirectory: String = "HTML"

    var body: some View {
        ZStack {
            page.themeColor.ignoresSafeArea()

            WebView(page)
                .onAppear {
                    loadLocalHTML()
                }
                .webViewContentBackground(.hidden)
                .ignoresSafeArea(.container, edges: .bottom)
                .scrollDisabled(true)
        }
    }

    private func loadLocalHTML() {
        guard let htmlURL = Bundle.main.url(
            forResource: htmlFileName,
            withExtension: "html",
            subdirectory: subdirectory
        ) else {
            print("Couldn’t find \(htmlFileName).html in bundle (subdir: \(subdirectory))")
            return
        }

        do {
            let html = try String(contentsOf: htmlURL, encoding: .utf8)
            let baseURL = htmlURL.deletingLastPathComponent()
            page.load(html: html, baseURL: baseURL)
        } catch {
            print("Failed to read HTML file: \(error)")
        }
    }
}
