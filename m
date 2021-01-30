Return-Path: <SRS0=oKDD=HB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0308C433E0
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Jan 2021 13:49:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BD9B64DD8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Jan 2021 13:49:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BD9B64DD8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DSbCs2NYkzDr22
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 Jan 2021 00:49:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1032;
 helo=mail-pj1-x1032.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=PJz6AFNn; dkim-atps=neutral
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DSZLS0d3MzDrVP
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Jan 2021 00:09:51 +1100 (AEDT)
Received: by mail-pj1-x1032.google.com with SMTP id md11so7231022pjb.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jan 2021 05:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6ZbOOFc6ESbxnPuTHMCEsVBYIKEf8Pxx6o7RfcJq0es=;
 b=PJz6AFNnzShzw5MCxz4qDs43hIzex3+PzLAyKozU6ZHZI19+xrUvP5FdFOPGNa35xl
 j+YQQed5yAswKKRsrU6kL2mkgIgh8SEk+Rh+A5gmjRjgVMLWRmPizQCdUT/gMVta08+v
 PZDiVm5uBx/XipL9yae+o5oAP92rDpuPrHD2Zf+iOE3qWviB+2+g3IytEHa04t1nELQD
 fP9dCUJSFZHM4jH/LfJHa2bkBfmrICTspDacKTLWOS6nlNKzIA/Q/NcagPdFmSagc1SG
 kJg+hKMfpgZSmjBJ4Ozwlb990Rc20Z+Aldr3YckqHOB6IwHm+Fiye9DN4U6mpKlxhnmI
 n+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6ZbOOFc6ESbxnPuTHMCEsVBYIKEf8Pxx6o7RfcJq0es=;
 b=K5kgk7CkzqO7IGAQmRhrqujporg182S59hfPG5yFDjtmES21wvc0UZRQB5OLNA9phs
 Wp3vyTLtO3sy2+ZUUixOvunpnYxp536KA3Hz2XDgac9e/Guba94x/umeAltqhn6aInUF
 kj82WmyL9las1Cbx1mtvEN0MRGjxTJnSgbD9jbZWoLpw3n5xInxv3Tcun/h7reXTGkGL
 fNHuudQWkFmb4D7LO9dhTuq1BfqV6hUmYLAoZFrI9s5QQ0CRkbmVGEnQJcl1w3hMcF8f
 DcVHkZ2xqoFE+kynvcgqKMRotF4XbvW7pLrziCH+dB4A5uWGGTOO1B8RtJJNtb386+I+
 rM2w==
X-Gm-Message-State: AOAM531oAMkjU+OxucfpzziE09K6y57MsDqQKMs4HY6tk0U5QquJoPQg
 GfdilVO000NJ/8LCEmTqtFxhNKpR35g=
X-Google-Smtp-Source: ABdhPJxxUan1vsEcB4sfNIbQzSwiPg3JPhW/H8Ja+YpSJ3riU3dQcLxsU8q0V+pUFvv58cul5o6x9Q==
X-Received: by 2002:a17:90a:b282:: with SMTP id
 c2mr9011244pjr.54.1612012186709; 
 Sat, 30 Jan 2021 05:09:46 -0800 (PST)
Received: from bobo.ozlabs.ibm.com
 (192.156.221.203.dial.dynamic.acc50-nort-cbr.comindico.com.au.
 [203.221.156.192])
 by smtp.gmail.com with ESMTPSA id y16sm12102240pgg.20.2021.01.30.05.09.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Jan 2021 05:09:46 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v7 12/42] powerpc/64s: add do_bad_page_fault_segv handler
Date: Sat, 30 Jan 2021 23:08:22 +1000
Message-Id: <20210130130852.2952424-13-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210130130852.2952424-1-npiggin@gmail.com>
References: <20210130130852.2952424-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This function acts like an interrupt handler so it needs to follow
the standard interrupt handler function signature which will be
introduced in a future change.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/bug.h       | 1 +
 arch/powerpc/kernel/exceptions-64s.S | 4 +---
 arch/powerpc/mm/fault.c              | 7 +++++++
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/bug.h
index 4220789b9a97..8f09ddae9305 100644
--- a/arch/powerpc/include/asm/bug.h
+++ b/arch/powerpc/include/asm/bug.h
@@ -114,6 +114,7 @@ struct pt_regs;
 long do_page_fault(struct pt_regs *);
 void bad_page_fault(struct pt_regs *, int);
 void __bad_page_fault(struct pt_regs *regs, int sig);
+void do_bad_page_fault_segv(struct pt_regs *regs);
 extern void _exception(int, struct pt_regs *, int, unsigned long);
 extern void _exception_pkey(struct pt_regs *, unsigned long, int);
 extern void die(const char *, struct pt_regs *, long);
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 839dcb94eea7..b90d3cde14cf 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -2151,9 +2151,7 @@ EXC_COMMON_BEGIN(h_data_storage_common)
 	GEN_COMMON h_data_storage
 	addi    r3,r1,STACK_FRAME_OVERHEAD
 BEGIN_MMU_FTR_SECTION
-	ld	r4,_DAR(r1)
-	li	r5,SIGSEGV
-	bl      bad_page_fault
+	bl      do_bad_page_fault_segv
 MMU_FTR_SECTION_ELSE
 	bl      unknown_exception
 ALT_MMU_FTR_SECTION_END_IFSET(MMU_FTR_TYPE_RADIX)
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 5dd3248b47c7..e476d7701413 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -615,3 +615,10 @@ void bad_page_fault(struct pt_regs *regs, int sig)
 	else
 		__bad_page_fault(regs, sig);
 }
+
+#ifdef CONFIG_PPC_BOOK3S_64
+void do_bad_page_fault_segv(struct pt_regs *regs)
+{
+	bad_page_fault(regs, SIGSEGV);
+}
+#endif
-- 
2.23.0

