Return-Path: <SRS0=Z4Cu=QL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA601C282C4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 14:32:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38DA42083B
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 14:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="stIDIZot"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38DA42083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43tVXj0X9mzDqJK
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 01:32:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="stIDIZot"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43tVF96pxGzDqGC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 01:18:53 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id e5so6867582plb.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Feb 2019 06:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=qfyEGvCPk6eaokwDcofqrtEfSMKtMor9xtai06bhwkk=;
 b=stIDIZotqLntLYfoQ4anxSmHUAIX65PicdHw8zFhmK3oQAVIYmL+2CRZ5JUVC3CKKo
 T6j1t3PK+Aby01vTLiKAYF6Jh6kr4zoFeCSDNNk8xaGfuHlC9eTp1vFLLMeam2ZCy2KM
 AU72KfSvxDstVTbJcAkpJJjNsemskXhYjdknyq3Fnj8I8Gz059cuW+lKBWuTYby4c0TF
 Idp2ECjx+iCdY6wx2/I4V1jh4dMA9T5uMEDA2Li3L8I+ZJGCs/VXETzyxDmRfTvrbWfd
 E8t6GNX71eUtHrlzXohnpmbxdOGwzCUe3I4UUJ8zoPYGnEC6Lowtc9fhxwZ7hkHd11Yj
 Emtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=qfyEGvCPk6eaokwDcofqrtEfSMKtMor9xtai06bhwkk=;
 b=o6HYvJWHrgMUU83pt5nEwElCQSGul5bGR6M6rptpvsZD3sOC+BsqgieJ5A6hFLQNif
 UYz/mUUeo9aqKmRhSvI9xMf/QYDeR/QGf3Is2/NkyO6To/VZQT34qmLu9LmNnTyeEdj4
 /vSfExf+zvgYbWtnAI/y+Hy6/wmtAv3J8FkImk/tG9yovYQ0hwZUXt/5aiOaqH4OPfEY
 vdn5zqdpYBVIv/yYfN9OSQ3EP5W0N+ACQBMWSe/Bo7Mu0fREeCI0S+KD0LH0//E+sBa9
 WtC71jYg+IfFYo3MIBaBJO6IAEISe+6MrEBwohDAjyQdftap0rYRQLADCWqmfGKQM/1K
 lRmg==
X-Gm-Message-State: AJcUukedLO+TivLzvUdPY0MnWKou2HyTCTejFAW8jqB2U8FJSESL9uml
 aCmmSOydvMbuKU5t15xl/fhnzmNU
X-Google-Smtp-Source: ALg8bN5d3oekkhV/YDyH9qmE5LOVB3HnS0aEdj77g0rKSDkamj3cgrjKbq+Xjm3ztz5+QLSrI/zZnQ==
X-Received: by 2002:a17:902:8d94:: with SMTP id
 v20mr51465247plo.194.1549289931741; 
 Mon, 04 Feb 2019 06:18:51 -0800 (PST)
Received: from roar.local0.net ([210.185.78.69])
 by smtp.gmail.com with ESMTPSA id h9sm226230pgd.53.2019.02.04.06.18.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 04 Feb 2019 06:18:51 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 06/17] powerpc/64s/exception: consolidate maskable and
 non-maskable prologs
Date: Tue,  5 Feb 2019 00:18:17 +1000
Message-Id: <20190204141828.13043-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190204141828.13043-1-npiggin@gmail.com>
References: <20190204141828.13043-1-npiggin@gmail.com>
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
Cc: Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Conditionally expand the soft-masking test if a mask is passed in.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/exception-64s.h | 113 +++++++++--------------
 arch/powerpc/kernel/exceptions-64s.S     |   8 +-
 2 files changed, 49 insertions(+), 72 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 62502c8f6b18..adfbc5a0f267 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -238,7 +238,7 @@
 #define EXCEPTION_RELON_PROLOG(area, label, hsrr, kvm, vec)		\
 	SET_SCRATCH0(r13);		/* save r13 */			\
 	EXCEPTION_PROLOG_0(area);					\
-	EXCEPTION_PROLOG_1 hsrr, area, kvm, vec ;			\
+	EXCEPTION_PROLOG_1 hsrr, area, kvm, vec, 0 ;			\
 	EXCEPTION_PROLOG_2_VIRT label, hsrr
 
 /* Exception register prefixes */
@@ -309,73 +309,50 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	std	r10,area+EX_R10(r13);	/* save r10 - r12 */		\
 	OPT_GET_SPR(r10, SPRN_CFAR, CPU_FTR_CFAR)
 
-#define __EXCEPTION_PROLOG_1_PRE(area)					\
-	OPT_SAVE_REG_TO_PACA(area+EX_PPR, r9, CPU_FTR_HAS_PPR);		\
-	OPT_SAVE_REG_TO_PACA(area+EX_CFAR, r10, CPU_FTR_CFAR);		\
-	INTERRUPT_TO_KERNEL;						\
-	SAVE_CTR(r10, area);						\
+.macro EXCEPTION_PROLOG_1 hsrr, area, kvm, vec, bitmask
+	OPT_SAVE_REG_TO_PACA(\area\()+EX_PPR, r9, CPU_FTR_HAS_PPR)
+	OPT_SAVE_REG_TO_PACA(\area\()+EX_CFAR, r10, CPU_FTR_CFAR)
+	INTERRUPT_TO_KERNEL
+	SAVE_CTR(r10, \area\())
 	mfcr	r9
-
-#define __EXCEPTION_PROLOG_1_POST(area)					\
-	std	r11,area+EX_R11(r13);					\
-	std	r12,area+EX_R12(r13);					\
-	GET_SCRATCH0(r10);						\
-	std	r10,area+EX_R13(r13)
-
-/*
- * This version of the EXCEPTION_PROLOG_1 will carry
- * addition parameter called "bitmask" to support
- * checking of the interrupt maskable level.
- * Intended to be used in MASKABLE_EXCPETION_* macros.
- */
-.macro MASKABLE_EXCEPTION_PROLOG_1 hsrr, area, kvm, vec, bitmask
-	__EXCEPTION_PROLOG_1_PRE(\area\())
 	.if \kvm
 		KVMTEST \hsrr \vec
 	.endif
-
-	lbz	r10,PACAIRQSOFTMASK(r13)
-	andi.	r10,r10,\bitmask
-	/* This associates vector numbers with bits in paca->irq_happened */
-	.if \vec == 0x500 || \vec == 0xea0
-	li	r10,PACA_IRQ_EE
-	.elseif \vec == 0x900 || \vec == 0xea0
-	li	r10,PACA_IRQ_DEC
-	.elseif \vec == 0xa00 || \vec == 0xe80
-	li	r10,PACA_IRQ_DBELL
-	.elseif \vec == 0xe60
-	li	r10,PACA_IRQ_HMI
-	.elseif \vec == 0xf00
-	li	r10,PACA_IRQ_PMI
-	.else
-	.abort "Bad maskable vector"
+	.if \bitmask
+		lbz	r10,PACAIRQSOFTMASK(r13)
+		andi.	r10,r10,\bitmask
+		/* Associate vector numbers with bits in paca->irq_happened */
+		.if \vec == 0x500 || \vec == 0xea0
+		li	r10,PACA_IRQ_EE
+		.elseif \vec == 0x900 || \vec == 0xea0
+		li	r10,PACA_IRQ_DEC
+		.elseif \vec == 0xa00 || \vec == 0xe80
+		li	r10,PACA_IRQ_DBELL
+		.elseif \vec == 0xe60
+		li	r10,PACA_IRQ_HMI
+		.elseif \vec == 0xf00
+		li	r10,PACA_IRQ_PMI
+		.else
+		.abort "Bad maskable vector"
+		.endif
+
+		.if \hsrr
+		bne	masked_Hinterrupt
+		.else
+		bne	masked_interrupt
+		.endif
 	.endif
 
-	.if \hsrr
-	bne	masked_Hinterrupt
-	.else
-	bne	masked_interrupt
-	.endif
-
-	__EXCEPTION_PROLOG_1_POST(\area\())
-.endm
-
-/*
- * This version of the EXCEPTION_PROLOG_1 is intended
- * to be used in STD_EXCEPTION* macros
- */
-.macro EXCEPTION_PROLOG_1 hsrr, area, kvm, vec
-	__EXCEPTION_PROLOG_1_PRE(\area\())
-	.if \kvm
-		KVMTEST \hsrr \vec
-	.endif
-	__EXCEPTION_PROLOG_1_POST(\area\())
+	std	r11,\area\()+EX_R11(r13)
+	std	r12,\area\()+EX_R12(r13)
+	GET_SCRATCH0(r10)
+	std	r10,\area\()+EX_R13(r13)
 .endm
 
 #define EXCEPTION_PROLOG(area, label, hsrr, kvm, vec)			\
 	SET_SCRATCH0(r13);		/* save r13 */			\
 	EXCEPTION_PROLOG_0(area);					\
-	EXCEPTION_PROLOG_1 hsrr, area, kvm, vec ;			\
+	EXCEPTION_PROLOG_1 hsrr, area, kvm, vec, 0 ;			\
 	EXCEPTION_PROLOG_2_REAL label, hsrr, 1
 
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
@@ -444,7 +421,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 /* Do not enable RI */
 #define EXCEPTION_PROLOG_NORI(area, label, hsrr, kvm, vec)		\
 	EXCEPTION_PROLOG_0(area);					\
-	EXCEPTION_PROLOG_1 hsrr, area, kvm, vec ;			\
+	EXCEPTION_PROLOG_1 hsrr, area, kvm, vec, 0 ;			\
 	EXCEPTION_PROLOG_2_REAL label, hsrr, 0
 
 #ifdef CONFIG_KVM_BOOK3S_64_HANDLER
@@ -598,14 +575,14 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	b hdlr
 
 #define STD_EXCEPTION_OOL(vec, label)				\
-	EXCEPTION_PROLOG_1 EXC_STD, PACA_EXGEN, 1, vec ;	\
+	EXCEPTION_PROLOG_1 EXC_STD, PACA_EXGEN, 1, vec, 0 ;	\
 	EXCEPTION_PROLOG_2_REAL label, EXC_STD, 1
 
 #define STD_EXCEPTION_HV(loc, vec, label)			\
 	EXCEPTION_PROLOG(PACA_EXGEN, label, EXC_HV, 1, vec)
 
 #define STD_EXCEPTION_HV_OOL(vec, label)			\
-	EXCEPTION_PROLOG_1 EXC_HV, PACA_EXGEN, 1, vec ;		\
+	EXCEPTION_PROLOG_1 EXC_HV, PACA_EXGEN, 1, vec, 0 ;	\
 	EXCEPTION_PROLOG_2_REAL label, EXC_HV, 1
 
 #define STD_RELON_EXCEPTION(loc, vec, label)		\
@@ -613,54 +590,54 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	EXCEPTION_RELON_PROLOG(PACA_EXGEN, label, EXC_STD, 0, vec)
 
 #define STD_RELON_EXCEPTION_OOL(vec, label)			\
-	EXCEPTION_PROLOG_1 EXC_STD, PACA_EXGEN, 0, vec ;	\
+	EXCEPTION_PROLOG_1 EXC_STD, PACA_EXGEN, 0, vec, 0 ;	\
 	EXCEPTION_PROLOG_2_VIRT label, EXC_STD
 
 #define STD_RELON_EXCEPTION_HV(loc, vec, label)			\
 	EXCEPTION_RELON_PROLOG(PACA_EXGEN, label, EXC_HV, 1, vec)
 
 #define STD_RELON_EXCEPTION_HV_OOL(vec, label)			\
-	EXCEPTION_PROLOG_1 EXC_HV, PACA_EXGEN, 1, vec;		\
+	EXCEPTION_PROLOG_1 EXC_HV, PACA_EXGEN, 1, vec, 0 ;	\
 	EXCEPTION_PROLOG_2_VIRT label, EXC_HV
 
 #define __MASKABLE_EXCEPTION(vec, label, hsrr, kvm, bitmask)		\
 	SET_SCRATCH0(r13);    /* save r13 */				\
 	EXCEPTION_PROLOG_0(PACA_EXGEN);					\
-	MASKABLE_EXCEPTION_PROLOG_1 hsrr, PACA_EXGEN, kvm, vec, bitmask ; \
+	EXCEPTION_PROLOG_1 hsrr, PACA_EXGEN, kvm, vec, bitmask ;	\
 	EXCEPTION_PROLOG_2_REAL label, hsrr, 1
 
 #define MASKABLE_EXCEPTION(vec, label, bitmask)				\
 	__MASKABLE_EXCEPTION(vec, label, EXC_STD, 1, bitmask)
 
 #define MASKABLE_EXCEPTION_OOL(vec, label, bitmask)			\
-	MASKABLE_EXCEPTION_PROLOG_1 EXC_STD, PACA_EXGEN, 1, vec, bitmask ; \
+	EXCEPTION_PROLOG_1 EXC_STD, PACA_EXGEN, 1, vec, bitmask ;	\
 	EXCEPTION_PROLOG_2_REAL label, EXC_STD, 1
 
 #define MASKABLE_EXCEPTION_HV(vec, label, bitmask)			\
 	__MASKABLE_EXCEPTION(vec, label, EXC_HV, 1, bitmask)
 
 #define MASKABLE_EXCEPTION_HV_OOL(vec, label, bitmask)			\
-	MASKABLE_EXCEPTION_PROLOG_1 EXC_HV, PACA_EXGEN, 1, vec, bitmask ; \
+	EXCEPTION_PROLOG_1 EXC_HV, PACA_EXGEN, 1, vec, bitmask ;	\
 	EXCEPTION_PROLOG_2_REAL label, EXC_HV, 1
 
 #define __MASKABLE_RELON_EXCEPTION(vec, label, hsrr, kvm, bitmask)	\
 	SET_SCRATCH0(r13);    /* save r13 */				\
 	EXCEPTION_PROLOG_0(PACA_EXGEN);					\
-	MASKABLE_EXCEPTION_PROLOG_1 hsrr, PACA_EXGEN, kvm, vec, bitmask ; \
+	EXCEPTION_PROLOG_1 hsrr, PACA_EXGEN, kvm, vec, bitmask ;	\
 	EXCEPTION_PROLOG_2_VIRT label, hsrr
 
 #define MASKABLE_RELON_EXCEPTION(vec, label, bitmask)			\
 	__MASKABLE_RELON_EXCEPTION(vec, label, EXC_STD, 0, bitmask)
 
 #define MASKABLE_RELON_EXCEPTION_OOL(vec, label, bitmask)		\
-	MASKABLE_EXCEPTION_PROLOG_1 EXC_STD, PACA_EXGEN, 0, vec, bitmask ; \
+	EXCEPTION_PROLOG_1 EXC_STD, PACA_EXGEN, 0, vec, bitmask ;	\
 	EXCEPTION_PROLOG_2_REAL label, EXC_STD, 1
 
 #define MASKABLE_RELON_EXCEPTION_HV(vec, label, bitmask)		\
 	__MASKABLE_RELON_EXCEPTION(vec, label, EXC_HV, 1, bitmask)
 
 #define MASKABLE_RELON_EXCEPTION_HV_OOL(vec, label, bitmask)		\
-	MASKABLE_EXCEPTION_PROLOG_1 EXC_HV, PACA_EXGEN, 1, vec, bitmask ; \
+	EXCEPTION_PROLOG_1 EXC_HV, PACA_EXGEN, 1, vec, bitmask ;	\
 	EXCEPTION_PROLOG_2_VIRT label, EXC_HV
 
 /*
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index dc2c794f529d..fd6c4748cfa2 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -260,7 +260,7 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
 EXC_REAL_END(machine_check, 0x200, 0x100)
 EXC_VIRT_NONE(0x4200, 0x100)
 TRAMP_REAL_BEGIN(machine_check_common_early)
-	EXCEPTION_PROLOG_1 EXC_HV, PACA_EXMC, 0, 0x200
+	EXCEPTION_PROLOG_1 EXC_HV, PACA_EXMC, 0, 0x200, 0
 	/*
 	 * Register contents:
 	 * R13		= PACA
@@ -344,7 +344,7 @@ BEGIN_FTR_SECTION
 	b	machine_check_common_early
 END_FTR_SECTION_IFCLR(CPU_FTR_HVMODE)
 machine_check_pSeries_0:
-	EXCEPTION_PROLOG_1 EXC_STD, PACA_EXMC, 1, 0x200
+	EXCEPTION_PROLOG_1 EXC_STD, PACA_EXMC, 1, 0x200, 0
 	/*
 	 * MSR_RI is not enabled, because PACA_EXMC is being used, so a
 	 * nested machine check corrupts it. machine_check_common enables
@@ -1039,7 +1039,7 @@ __TRAMP_REAL_OOL_MASKABLE_HV(hmi_exception, 0xe60, IRQS_DISABLED)
 EXC_VIRT_NONE(0x4e60, 0x20)
 TRAMP_KVM_HV(PACA_EXGEN, 0xe60)
 TRAMP_REAL_BEGIN(hmi_exception_early)
-	EXCEPTION_PROLOG_1 EXC_HV, PACA_EXGEN, 1, 0xe60
+	EXCEPTION_PROLOG_1 EXC_HV, PACA_EXGEN, 1, 0xe60, 0
 	mr	r10,r1			/* Save r1 */
 	ld	r1,PACAEMERGSP(r13)	/* Use emergency stack for realmode */
 	subi	r1,r1,INT_FRAME_SIZE	/* alloc stack frame		*/
@@ -1240,7 +1240,7 @@ EXC_VIRT_NONE(0x5400, 0x100)
 EXC_REAL_BEGIN(denorm_exception_hv, 0x1500, 0x100)
 	mtspr	SPRN_SPRG_HSCRATCH0,r13
 	EXCEPTION_PROLOG_0(PACA_EXGEN)
-	EXCEPTION_PROLOG_1 EXC_HV, PACA_EXGEN, 0, 0x1500
+	EXCEPTION_PROLOG_1 EXC_HV, PACA_EXGEN, 0, 0x1500, 0
 
 #ifdef CONFIG_PPC_DENORMALISATION
 	mfspr	r10,SPRN_HSRR1
-- 
2.18.0

