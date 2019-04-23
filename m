Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103C7C10F03
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 21:13:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80E26218B0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 21:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tZM1unYF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80E26218B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pbkx4lNZzDqQN
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 07:12:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=changbin.du@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="tZM1unYF"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pTf60kS2zDqCW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 02:38:22 +1000 (AEST)
Received: by mail-pl1-x644.google.com with SMTP id w24so7803242plp.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 09:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BwOUj6DWdN3iA6cgbfDcU43ryEgaCKSsuoVnmmfiYvA=;
 b=tZM1unYFIvpmzxfXqjgBWrIpWgbO8x5mlykfx+g4MiugNXXuijOBS+GqTikW1jKISg
 NqobuFafddCTQ+JIalIIwlL/53URcdBC7xTCiDmpjINgapHqmNCJzE2JcD/hic8MCXjs
 J7lRe1dsM3gh7O9yeZ92LWe0HTlO5TB/UXku2jJCSQB0Aiftz843llCpdJMI0FHRhIau
 yfF0XOKkDQxNqQF8AsjcMHZhvC7sTZfCyOGsEgyMqcGF5CQA0n6LRL4NueQXTNRXaLXB
 iMex/UtWgt+ezQ5BcIFCg/bJRpA/3VavSiTIc41ALjvbX41Vpnr3z+6BR/x5j3xWLkpQ
 0zQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BwOUj6DWdN3iA6cgbfDcU43ryEgaCKSsuoVnmmfiYvA=;
 b=Tjy51UU7hXsH3FBMdZCRgoDCCMR4jTWrLkWK966Gk1WmS3fmbxPEN0m0K6tlYdQqx7
 JfVDb0kGCnbPSZpCgUwAxMhCC0A2mpI7z9zGgr8sjzH7/k3RnPBlpTMRWku+bA5k75Uf
 yXpk+VBbPuWbiW4mlIrKqvlQ8RphcRbZkAAKeoAewQymo3knkDSRIbyRN8CkT9QTIfQ0
 FdmDoLRWo1xc0xyRyQdu8WRpgbE6ZEH2xllK7+SXND/qLeAdkROS54zLSPLq+zDxSeV0
 4jiRJUB7E17bnl7NGnO3WevnM4pzO5cWpsUI/X3BKbM9NegGiJsBdMgNKixUMbJq5Lfs
 l74g==
X-Gm-Message-State: APjAAAV6YVtugOxNiQNPUuUzi0c5czaCW9ZKbPMG2QMO+sAt+34ff6pS
 fOuzvTJglv+kj1LGYT9a4Bg=
X-Google-Smtp-Source: APXvYqxfrRmUBhbHmsyN9wfFEdmN2iUGu9aAXAAk0gi4wFiCEZM64Aodt63M+ExKCVyPBtCEBGcXlA==
X-Received: by 2002:a17:902:9686:: with SMTP id
 n6mr27708241plp.282.1556037500432; 
 Tue, 23 Apr 2019 09:38:20 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
 by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.38.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 23 Apr 2019 09:38:19 -0700 (PDT)
From: Changbin Du <changbin.du@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v4 51/63] Documentation: x86: convert pti.txt to reST
Date: Wed, 24 Apr 2019 00:29:20 +0800
Message-Id: <20190423162932.21428-52-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190423162932.21428-1-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 24 Apr 2019 05:41:33 +1000
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
 Documentation/x86/index.rst            |  1 +
 Documentation/x86/{pti.txt => pti.rst} | 19 ++++++++++++++-----
 2 files changed, 15 insertions(+), 5 deletions(-)
 rename Documentation/x86/{pti.txt => pti.rst} (95%)

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index a0426ab156bd..1c675cef14d7 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -21,3 +21,4 @@ Linux x86 Support
    protection-keys
    intel_mpx
    amd-memory-encryption
+   pti
diff --git a/Documentation/x86/pti.txt b/Documentation/x86/pti.rst
similarity index 95%
rename from Documentation/x86/pti.txt
rename to Documentation/x86/pti.rst
index 5cd58439ad2d..44b98f99ca8a 100644
--- a/Documentation/x86/pti.txt
+++ b/Documentation/x86/pti.rst
@@ -1,9 +1,15 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========================
+Page Table Isolation (PTI)
+==========================
+
 Overview
 ========
 
-Page Table Isolation (pti, previously known as KAISER[1]) is a
+Page Table Isolation (pti, previously known as KAISER [1]_) is a
 countermeasure against attacks on the shared user/kernel address
-space such as the "Meltdown" approach[2].
+space such as the "Meltdown" approach [2]_.
 
 To mitigate this class of attacks, we create an independent set of
 page tables for use only when running userspace applications.  When
@@ -60,6 +66,7 @@ Protection against side-channel attacks is important.  But,
 this protection comes at a cost:
 
 1. Increased Memory Use
+
   a. Each process now needs an order-1 PGD instead of order-0.
      (Consumes an additional 4k per process).
   b. The 'cpu_entry_area' structure must be 2MB in size and 2MB
@@ -68,6 +75,7 @@ this protection comes at a cost:
      is decompressed, but no space in the kernel image itself.
 
 2. Runtime Cost
+
   a. CR3 manipulation to switch between the page table copies
      must be done at interrupt, syscall, and exception entry
      and exit (it can be skipped when the kernel is interrupted,
@@ -142,8 +150,9 @@ ideally doing all of these in parallel:
    interrupted, including nested NMIs.  Using "-c" boosts the rate of
    NMIs, and using two -c with separate counters encourages nested NMIs
    and less deterministic behavior.
+   ::
 
-	while true; do perf record -c 10000 -e instructions,cycles -a sleep 10; done
+      while true; do perf record -c 10000 -e instructions,cycles -a sleep 10; done
 
 4. Launch a KVM virtual machine.
 5. Run 32-bit binaries on systems supporting the SYSCALL instruction.
@@ -182,5 +191,5 @@ that are worth noting here.
    tended to be TLB invalidation issues.  Usually invalidating
    the wrong PCID, or otherwise missing an invalidation.
 
-1. https://gruss.cc/files/kaiser.pdf
-2. https://meltdownattack.com/meltdown.pdf
+.. [1] https://gruss.cc/files/kaiser.pdf
+.. [2] https://meltdownattack.com/meltdown.pdf
-- 
2.20.1

