Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900E5C10F03
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 20:37:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07D89218B0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 20:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pGKEzzrj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07D89218B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pZxs0XBKzDqS3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 06:37:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=changbin.du@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="pGKEzzrj"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pTZj2bsMzDqHh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 02:35:25 +1000 (AEST)
Received: by mail-pl1-x641.google.com with SMTP id o5so3462295pls.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 09:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ic7Mz9ZN66lX6qBzL4R/C06u702++iEG8zGQWvLykvo=;
 b=pGKEzzrj8OrzEBxn5nOXdnc5T2C6n2D/v+oO6JGzhQKyWqhAN3MzW+BkdIakK7jaeT
 jeBzkyAfHSIVHrUg93WK1IRsOTLY38UX+P9zG/0idBhOPjDQW8pWhZeLbmH7mXoY6+3t
 YqaSqk+foyb6lCSU9gKFasVpPBSmdQu4hQW6aOn29tb+qy6/ZNXnNYTs3cNN6cvPmst0
 V8MMaAlZkNlgaFBh68Nhp1LMMZyRIncBFyu3rj3Wnxe9b9/nyvJeW+x0qs+1q7RDNJpv
 k2yM6JK6D9u9WXTAqy8Fl+k6r9qh30o5aeX20c+fMrhqmuyp7ytn0oaybTL/TrpzSSKG
 FU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ic7Mz9ZN66lX6qBzL4R/C06u702++iEG8zGQWvLykvo=;
 b=naEJkZ3McmrvnIctEkTOBjd4qHQ/0m/DcMNyGLwYFO1ZlUbcoNNDlww+CyP3ks5yzC
 CFnclCEogp0MzFRc5JwoC6MGi+AggNbexXLg30Q8CBPgrqruqzM6Uoh9hFg+aRQH+PYV
 Jx0eG8b1iXwHU9lowLn859sjHeAGNDtAGIJVF6NDponfD6cqJAGaTAl1IaGpjo7gQwnE
 bQrPLnK44uE7+98d5LkETZFTnaXyxohPsSgFbUpLhl+P/ljt14poYJYQ4Vhfr6Kf3F2L
 EufGsrL0kqwgN76q6bqIq3Ljuao92ACMF2OasJBgMrsUuJ2qriiGfLv4KT4q7/DtIN/l
 FkSw==
X-Gm-Message-State: APjAAAVT0FL0RgDTU8ei5X7VXZJPlTNM1tF3XsK9rLx51Nk4GG2V6qcx
 /AP6xMHT1etosqFPkj7hJX4=
X-Google-Smtp-Source: APXvYqyLEwwLyCN3ZpGrjGmn4YGJeRqIGRw6sIoisL487VVT0eEVJORTD5KLeCS430OsaIfJnNvY/w==
X-Received: by 2002:a17:902:8349:: with SMTP id
 z9mr9532556pln.144.1556037323164; 
 Tue, 23 Apr 2019 09:35:23 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
 by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.35.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 23 Apr 2019 09:35:22 -0700 (PDT)
From: Changbin Du <changbin.du@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v4 30/63] Documentation: PCI: convert acpi-info.txt to reST
Date: Wed, 24 Apr 2019 00:28:59 +0800
Message-Id: <20190423162932.21428-31-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190423162932.21428-1-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 24 Apr 2019 05:41:31 +1000
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: fenghua.yu@intel.com, mchehab+samsung@kernel.org, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org, x86@kernel.org,
 rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 mingo@redhat.com, Bjorn Helgaas <bhelgaas@google.com>, tglx@linutronix.de,
 linuxppc-dev@lists.ozlabs.org, Changbin Du <changbin.du@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 Documentation/PCI/{acpi-info.txt => acpi-info.rst} | 11 ++++++++---
 Documentation/PCI/index.rst                        |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)
 rename Documentation/PCI/{acpi-info.txt => acpi-info.rst} (97%)

diff --git a/Documentation/PCI/acpi-info.txt b/Documentation/PCI/acpi-info.rst
similarity index 97%
rename from Documentation/PCI/acpi-info.txt
rename to Documentation/PCI/acpi-info.rst
index 3ffa3b03970e..f7dabb7ca255 100644
--- a/Documentation/PCI/acpi-info.txt
+++ b/Documentation/PCI/acpi-info.rst
@@ -1,4 +1,8 @@
-		ACPI considerations for PCI host bridges
+.. SPDX-License-Identifier: GPL-2.0
+
+========================================
+ACPI considerations for PCI host bridges
+========================================
 
 The general rule is that the ACPI namespace should describe everything the
 OS might use unless there's another way for the OS to find it [1, 2].
@@ -135,8 +139,9 @@ address always corresponds to bus 0, even if the bus range below the bridge
 
     Extended Address Space Descriptor (.4)
     General Flags: Bit [0] Consumer/Producer:
-	1–This device consumes this resource
-	0–This device produces and consumes this resource
+
+        * 1 – This device consumes this resource
+        * 0 – This device produces and consumes this resource
 
 [5] ACPI 6.2, sec 19.6.43:
     ResourceUsage specifies whether the Memory range is consumed by
diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
index 1b25bcc1edca..c877a369481d 100644
--- a/Documentation/PCI/index.rst
+++ b/Documentation/PCI/index.rst
@@ -12,3 +12,4 @@ Linux PCI Bus Subsystem
    PCIEBUS-HOWTO
    pci-iov-howto
    MSI-HOWTO
+   acpi-info
-- 
2.20.1

