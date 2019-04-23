Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7A2C10F03
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 21:27:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EF9E218D3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 21:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFVbYWgi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EF9E218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pc3K2qxnzDqQt
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 07:27:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=changbin.du@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="YFVbYWgi"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pTg13HRRzDqCW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 02:39:09 +1000 (AEST)
Received: by mail-pl1-x641.google.com with SMTP id w23so7810143ply.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 09:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lKxrWq0DPWG2/ldiM614YNjWwPB+5TI6uHMpmONkiyA=;
 b=YFVbYWginTf8h5S0SDoTIVMpULpvCv6OKgMCGQDqwtjfHm8OF/amq8OwLtdHLRayBO
 BCBf0R5V6HXNxNjhfmUM5Z8W06HJKkSxtFC9rcQDXItwQ7sd1GLz5KFJNjvtjDhcCNIH
 /RJgCoDHVfa38Ky54CEuElWSUFLSK24t+ehRe+DHGfbWNSN1iU/aWSdUg48jiuxGOvbj
 PO+h0uNSBBAa78wGa8VboKo+0yvcd/nLNWy6MN9Ac9C8Rb5MdAZOsqGBZ70yJUEdDhP/
 SXpMj7o4tL0x2dxs68n7Rjm7Q08Cs0yd7ZrASV1VvAeSQiWYwohAAtRwixx0GvD0zyRc
 HAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lKxrWq0DPWG2/ldiM614YNjWwPB+5TI6uHMpmONkiyA=;
 b=ChgZ7eDvw1H7cSp99jOwfDTEYX7WKy29tXMo5evjWNtoJ6XBRNAJ/xunymYY0UhpJo
 vJN8gvG7PSsPAepJHVWuj3QywUAb3FgLcuiXN87d543torus6mVgIIFcdl6ZZ3TP8/6B
 GMcP5e2EUNUrVK6ddrhY+7gfCjCuzb5rLqEfWnVGNJyZr4TvFScGrWMR5f/tEPqUNdbx
 5zYfCrookX4HnRw03Jv4KGlGmSPdUia3lhCbgyw+0zCv0LIwsJCK3/xu5FdtkWK+tE4g
 a71orHXh6q9ARthT2fcuzD5vN+Q8e3IaH9rJAst5Ku+SQ3nYFUbDhQChzLPItLO/5kad
 RvzA==
X-Gm-Message-State: APjAAAWwzBspc/MTTlMoNOmx/46o9eLr18xAuDzLXoYETzyFdp28kYYb
 FZW+/5Ag+ivhdG4xmGbtBOA=
X-Google-Smtp-Source: APXvYqyyiuJdfDhtn9sySZr3o/D6USw7potnUz8aWY3bi/Zm3hnxy6EcWxCQcMDnbzEmguum4Hqo4Q==
X-Received: by 2002:a17:902:e490:: with SMTP id
 cj16mr27318962plb.156.1556037547194; 
 Tue, 23 Apr 2019 09:39:07 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
 by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.39.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 23 Apr 2019 09:39:06 -0700 (PDT)
From: Changbin Du <changbin.du@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v4 60/63] Documentation: x86: convert x86_64/5level-paging.txt
 to reST
Date: Wed, 24 Apr 2019 00:29:29 +0800
Message-Id: <20190423162932.21428-61-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190423162932.21428-1-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 24 Apr 2019 05:41:34 +1000
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
---
 .../{5level-paging.txt => 5level-paging.rst}     | 16 +++++++++++-----
 Documentation/x86/x86_64/index.rst               |  1 +
 2 files changed, 12 insertions(+), 5 deletions(-)
 rename Documentation/x86/x86_64/{5level-paging.txt => 5level-paging.rst} (91%)

diff --git a/Documentation/x86/x86_64/5level-paging.txt b/Documentation/x86/x86_64/5level-paging.rst
similarity index 91%
rename from Documentation/x86/x86_64/5level-paging.txt
rename to Documentation/x86/x86_64/5level-paging.rst
index 2432a5ef86d9..ab88a4514163 100644
--- a/Documentation/x86/x86_64/5level-paging.txt
+++ b/Documentation/x86/x86_64/5level-paging.rst
@@ -1,5 +1,11 @@
-== Overview ==
+.. SPDX-License-Identifier: GPL-2.0
 
+==============
+5-level paging
+==============
+
+Overview
+========
 Original x86-64 was limited by 4-level paing to 256 TiB of virtual address
 space and 64 TiB of physical address space. We are already bumping into
 this limit: some vendors offers servers with 64 TiB of memory today.
@@ -16,16 +22,17 @@ QEMU 2.9 and later support 5-level paging.
 Virtual memory layout for 5-level paging is described in
 Documentation/x86/x86_64/mm.txt
 
-== Enabling 5-level paging ==
 
+Enabling 5-level paging
+=======================
 CONFIG_X86_5LEVEL=y enables the feature.
 
 Kernel with CONFIG_X86_5LEVEL=y still able to boot on 4-level hardware.
 In this case additional page table level -- p4d -- will be folded at
 runtime.
 
-== User-space and large virtual address space ==
-
+User-space and large virtual address space
+==========================================
 On x86, 5-level paging enables 56-bit userspace virtual address space.
 Not all user space is ready to handle wide addresses. It's known that
 at least some JIT compilers use higher bits in pointers to encode their
@@ -58,4 +65,3 @@ One important case we need to handle here is interaction with MPX.
 MPX (without MAWA extension) cannot handle addresses above 47-bit, so we
 need to make sure that MPX cannot be enabled we already have VMA above
 the boundary and forbid creating such VMAs once MPX is enabled.
-
diff --git a/Documentation/x86/x86_64/index.rst b/Documentation/x86/x86_64/index.rst
index 4b65d29ef459..7b8c82151358 100644
--- a/Documentation/x86/x86_64/index.rst
+++ b/Documentation/x86/x86_64/index.rst
@@ -10,3 +10,4 @@ x86_64 Support
    boot-options
    uefi
    mm
+   5level-paging
-- 
2.20.1

