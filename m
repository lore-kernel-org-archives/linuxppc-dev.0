Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E90C282DD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 21:11:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24C37218D2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 21:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WuDeX39f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24C37218D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pbjC1PGCzDqQm
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 07:11:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=changbin.du@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="WuDeX39f"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pTf12FVdzDq9H
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 02:38:17 +1000 (AEST)
Received: by mail-pl1-x644.google.com with SMTP id w23so7809085ply.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 09:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dk9nZS7LGFvUdGAy8fxGcY6/ybb9v25OpTL3KOWjoH8=;
 b=WuDeX39fX4agIFCWjj2UXkCBdilJHadtSLMPWebq4Rj2dKnTXDHt5SlLFppnzcYLAC
 IkHNgWFVDFCM6f6sjsBx8ibu+xMEAVZpoGFT5IQBWVe4suxYdu8w1079KziAV/6Pqb3t
 YhOttilmfQn7oq1+Mv6OJSscb7S/HL6OkoXbSbUpW2cqTjYEcpdXeP+4tyG6F02sE218
 SvYtBt4/x+9oA4EYl80+mohhEypZ3F/AZxj2R1e8kDRDGXBykEawe/OMqrGR0n9ffQua
 IcCBGLqzCUNI6XWPuUtXgBlLgX+BdRkPPordmbYhbf+OQqOZ32e265qxgnK8Mq8dlJiW
 pbkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dk9nZS7LGFvUdGAy8fxGcY6/ybb9v25OpTL3KOWjoH8=;
 b=iCvVMYEC/Ujl34vYV9cNasIHnOnKOwcPc6UZjGXsR4rjXU1Avo6nZnQsKyTArqKHKm
 YbvpKOvzYUTPvq6MD/OSF6AknhZwDFVOaanb2rMiGF2U+sBl2hbzRJYL8XfHOalkah0h
 6+IfN230hk3Aam7TodC+6EMTK/agW7wPcM538qZZSjg62iEhse6C9A7jfubp8U9nhG99
 05c2gdEyk6TH44ioECmT/hj1848S/fvupIh9uzbSMC5A+JwouA9TULTRITDlkgu433Kd
 XBfJ5MBACoLVzJFlvUDlzy+ucD1TYt20e6gVFuSlluWiPbBctt4cW1I00l3Bp0Jpfqhw
 9ACA==
X-Gm-Message-State: APjAAAWpCsgCKzVX5l1zpoysnOkcbzOqAYyW7kqfjrm6PVFOLYTA6kp7
 ELpVhHVCJ3jguYDsUdmNPvw=
X-Google-Smtp-Source: APXvYqw1PBt2NhuOso4l/c8zot051+AWjvFK/viNfPGzVPsV033yeEPBb8FPDNcm0y9d3R/Xkb9RdA==
X-Received: by 2002:a17:902:c1:: with SMTP id
 a59mr26257460pla.176.1556037495088; 
 Tue, 23 Apr 2019 09:38:15 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
 by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.38.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 23 Apr 2019 09:38:14 -0700 (PDT)
From: Changbin Du <changbin.du@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v4 50/63] Documentation: x86: convert
 amd-memory-encryption.txt to reST
Date: Wed, 24 Apr 2019 00:29:19 +0800
Message-Id: <20190423162932.21428-51-changbin.du@gmail.com>
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
 ...ory-encryption.txt => amd-memory-encryption.rst} | 13 ++++++++++---
 Documentation/x86/index.rst                         |  1 +
 2 files changed, 11 insertions(+), 3 deletions(-)
 rename Documentation/x86/{amd-memory-encryption.txt => amd-memory-encryption.rst} (94%)

diff --git a/Documentation/x86/amd-memory-encryption.txt b/Documentation/x86/amd-memory-encryption.rst
similarity index 94%
rename from Documentation/x86/amd-memory-encryption.txt
rename to Documentation/x86/amd-memory-encryption.rst
index afc41f544dab..c48d452d0718 100644
--- a/Documentation/x86/amd-memory-encryption.txt
+++ b/Documentation/x86/amd-memory-encryption.rst
@@ -1,3 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================
+AMD Memory Encryption
+=====================
+
 Secure Memory Encryption (SME) and Secure Encrypted Virtualization (SEV) are
 features found on AMD processors.
 
@@ -34,7 +40,7 @@ is operating in 64-bit or 32-bit PAE mode, in all other modes the SEV hardware
 forces the memory encryption bit to 1.
 
 Support for SME and SEV can be determined through the CPUID instruction. The
-CPUID function 0x8000001f reports information related to SME:
+CPUID function 0x8000001f reports information related to SME::
 
 	0x8000001f[eax]:
 		Bit[0] indicates support for SME
@@ -48,14 +54,14 @@ CPUID function 0x8000001f reports information related to SME:
 			   addresses)
 
 If support for SME is present, MSR 0xc00100010 (MSR_K8_SYSCFG) can be used to
-determine if SME is enabled and/or to enable memory encryption:
+determine if SME is enabled and/or to enable memory encryption::
 
 	0xc0010010:
 		Bit[23]   0 = memory encryption features are disabled
 			  1 = memory encryption features are enabled
 
 If SEV is supported, MSR 0xc0010131 (MSR_AMD64_SEV) can be used to determine if
-SEV is active:
+SEV is active::
 
 	0xc0010131:
 		Bit[0]	  0 = memory encryption is not active
@@ -68,6 +74,7 @@ requirements for the system.  If this bit is not set upon Linux startup then
 Linux itself will not set it and memory encryption will not be possible.
 
 The state of SME in the Linux kernel can be documented as follows:
+
 	- Supported:
 	  The CPU supports SME (determined through CPUID instruction).
 
diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index 20091d3e5d97..a0426ab156bd 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -20,3 +20,4 @@ Linux x86 Support
    pat
    protection-keys
    intel_mpx
+   amd-memory-encryption
-- 
2.20.1

