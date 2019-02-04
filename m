Return-Path: <SRS0=Z4Cu=QL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300ECC282CC
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 14:30:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2A162083B
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 14:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXb/kZFd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2A162083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43tVV85PcPzDqJl
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 01:30:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="aXb/kZFd"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43tVF74gClzDqG8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 01:18:51 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id m1so6327742pgq.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Feb 2019 06:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=9V48haWeecKj8sWSflijxKtjHApK1MCW2oYyRc93nOo=;
 b=aXb/kZFdxXv2NyZyLlzNaMmN4qGL8sNrWWQO7XE2hq7eUenGEMEqSFvpurQaCJSrEx
 aQj9L93t8CFLQIa9YtIXzfce0AH2bO/VYyjeyN/A1ruF6krVnTtQdQE/3fVdWu7R4XnW
 0ZuN7fw/8Vo25NKcaARd1RdGJKk8frxaJ/7CFYK7mCYDejwuqWXKUXyCwiX3dKwW68NE
 Hi8Xlvi6j8K28Vq0wD34kOh6r+TjGd+KQyF/e0A5VTfbClTW9xvtsJ3O0NFfRQiMx+qJ
 NKLntwENAgodCt7NavpVR0afHjLhfQWjqY5gNxitWivjjepeQ0AFP9l+tt17MUNYPOyM
 rFiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=9V48haWeecKj8sWSflijxKtjHApK1MCW2oYyRc93nOo=;
 b=MIUnCSs0muMkph3BBc6kjM1FvC60NvGw4LtImYkarhjuHfFutrU9qMcal9uJxkEcWc
 UzkFLvPDuPVsoRgkGlUAWQPcrS9m0teQ6Md/qQ91bA59MRKGNuJkFJpgwfh8cxzXVeRa
 GjRbZVX7UCzaEfCqTuvPs12a4yyQLkVEiA654wU4IjawSP+GhoMfsuBQ12NeCuHq/x9T
 4SC8sDt0hHkYco3uthA/LXk5o9ZhiQ/2w+TPbwy5Qv4pijParHcdtCBSG/nNfTn6wJ3v
 TcPrshhrV+7aLRdbk2OQn0RHKKSLEjwhVurhpHH3ZGcamXgfJ6w9Ks8CnwEMFVsmU+0U
 sF/g==
X-Gm-Message-State: AHQUAubB69jnIpoNzfxlY2NzTHgrJiLEMukVssPZp1j/1/t0Ba3uGfEq
 GEbMRl44wYmEPkZQMWGsj082NLeg
X-Google-Smtp-Source: AHgI3IZECKsrsOkmNmLk7UfEMXQEphYM1Ro17YD77FSbqmdw+UllRRBxhK6beFBgvsTRisJmkBLnEw==
X-Received: by 2002:a63:1119:: with SMTP id g25mr2883941pgl.430.1549289929414; 
 Mon, 04 Feb 2019 06:18:49 -0800 (PST)
Received: from roar.local0.net ([210.185.78.69])
 by smtp.gmail.com with ESMTPSA id h9sm226230pgd.53.2019.02.04.06.18.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 04 Feb 2019 06:18:48 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 05/17] powerpc/64s/exception: remove the "extra" macro
 parameter
Date: Tue,  5 Feb 2019 00:18:16 +1000
Message-Id: <20190204141828.13043-6-npiggin@gmail.com>
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

Rather than pass in the soft-masking and KVM tests via macro that is
passed to another macro to expand it, switch to usig gas macros and
conditionally expand the soft-masking and KVM tests.

The system reset with its idle test is open coded as it is a one-off.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/exception-64s.h | 158 ++++++++++-------------
 arch/powerpc/kernel/exceptions-64s.S     |  65 ++++++----
 2 files changed, 107 insertions(+), 116 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 7f6358654263..62502c8f6b18 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -235,10 +235,10 @@
  * rfid. Save CTR in case we're CONFIG_RELOCATABLE, in which case
  * EXCEPTION_PROLOG_2_VIRT will be using CTR.
  */
-#define EXCEPTION_RELON_PROLOG(area, label, hsrr, extra, vec)		\
+#define EXCEPTION_RELON_PROLOG(area, label, hsrr, kvm, vec)		\
 	SET_SCRATCH0(r13);		/* save r13 */			\
 	EXCEPTION_PROLOG_0(area);					\
-	EXCEPTION_PROLOG_1(area, extra, vec);				\
+	EXCEPTION_PROLOG_1 hsrr, area, kvm, vec ;			\
 	EXCEPTION_PROLOG_2_VIRT label, hsrr
 
 /* Exception register prefixes */
@@ -325,31 +325,58 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 /*
  * This version of the EXCEPTION_PROLOG_1 will carry
  * addition parameter called "bitmask" to support
- * checking of the interrupt maskable level in the SOFTEN_TEST.
+ * checking of the interrupt maskable level.
  * Intended to be used in MASKABLE_EXCPETION_* macros.
  */
-#define MASKABLE_EXCEPTION_PROLOG_1(area, extra, vec, bitmask)			\
-	__EXCEPTION_PROLOG_1_PRE(area);					\
-	extra(vec, bitmask);						\
-	__EXCEPTION_PROLOG_1_POST(area)
+.macro MASKABLE_EXCEPTION_PROLOG_1 hsrr, area, kvm, vec, bitmask
+	__EXCEPTION_PROLOG_1_PRE(\area\())
+	.if \kvm
+		KVMTEST \hsrr \vec
+	.endif
+
+	lbz	r10,PACAIRQSOFTMASK(r13)
+	andi.	r10,r10,\bitmask
+	/* This associates vector numbers with bits in paca->irq_happened */
+	.if \vec == 0x500 || \vec == 0xea0
+	li	r10,PACA_IRQ_EE
+	.elseif \vec == 0x900 || \vec == 0xea0
+	li	r10,PACA_IRQ_DEC
+	.elseif \vec == 0xa00 || \vec == 0xe80
+	li	r10,PACA_IRQ_DBELL
+	.elseif \vec == 0xe60
+	li	r10,PACA_IRQ_HMI
+	.elseif \vec == 0xf00
+	li	r10,PACA_IRQ_PMI
+	.else
+	.abort "Bad maskable vector"
+	.endif
+
+	.if \hsrr
+	bne	masked_Hinterrupt
+	.else
+	bne	masked_interrupt
+	.endif
+
+	__EXCEPTION_PROLOG_1_POST(\area\())
+.endm
 
 /*
  * This version of the EXCEPTION_PROLOG_1 is intended
  * to be used in STD_EXCEPTION* macros
  */
-#define _EXCEPTION_PROLOG_1(area, extra, vec)				\
-	__EXCEPTION_PROLOG_1_PRE(area);					\
-	extra(vec);							\
-	__EXCEPTION_PROLOG_1_POST(area)
-
-#define EXCEPTION_PROLOG_1(area, extra, vec)				\
-	_EXCEPTION_PROLOG_1(area, extra, vec)
+.macro EXCEPTION_PROLOG_1 hsrr, area, kvm, vec
+	__EXCEPTION_PROLOG_1_PRE(\area\())
+	.if \kvm
+		KVMTEST \hsrr \vec
+	.endif
+	__EXCEPTION_PROLOG_1_POST(\area\())
+.endm
 
-#define EXCEPTION_PROLOG(area, label, h, extra, vec)			\
+#define EXCEPTION_PROLOG(area, label, hsrr, kvm, vec)			\
 	SET_SCRATCH0(r13);		/* save r13 */			\
 	EXCEPTION_PROLOG_0(area);					\
-	EXCEPTION_PROLOG_1(area, extra, vec);				\
-	EXCEPTION_PROLOG_2_REAL label, h, 1
+	EXCEPTION_PROLOG_1 hsrr, area, kvm, vec ;			\
+	EXCEPTION_PROLOG_2_REAL label, hsrr, 1
 
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 /*
@@ -415,10 +442,10 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 #endif
 
 /* Do not enable RI */
-#define EXCEPTION_PROLOG_NORI(area, label, h, extra, vec)		\
+#define EXCEPTION_PROLOG_NORI(area, label, hsrr, kvm, vec)		\
 	EXCEPTION_PROLOG_0(area);					\
-	EXCEPTION_PROLOG_1(area, extra, vec);				\
-	EXCEPTION_PROLOG_2_REAL label, h, 0
+	EXCEPTION_PROLOG_1 hsrr, area, kvm, vec ;			\
+	EXCEPTION_PROLOG_2_REAL label, hsrr, 0
 
 #ifdef CONFIG_KVM_BOOK3S_64_HANDLER
 .macro KVMTEST hsrr, n
@@ -480,8 +507,6 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 .endm
 #endif
 
-#define NOTEST(n)
-
 #define EXCEPTION_PROLOG_COMMON_1()					   \
 	std	r9,_CCR(r1);		/* save CR in stackframe	*/ \
 	std	r11,_NIP(r1);		/* save SRR0 in stackframe	*/ \
@@ -564,7 +589,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
  * Exception vectors.
  */
 #define STD_EXCEPTION(vec, label)				\
-	EXCEPTION_PROLOG(PACA_EXGEN, label, EXC_STD, KVMTEST_PR, vec);
+	EXCEPTION_PROLOG(PACA_EXGEN, label, EXC_STD, 1, vec);
 
 /* Version of above for when we have to branch out-of-line */
 #define __OOL_EXCEPTION(vec, label, hdlr)			\
@@ -573,112 +598,69 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	b hdlr
 
 #define STD_EXCEPTION_OOL(vec, label)				\
-	EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST_PR, vec);	\
+	EXCEPTION_PROLOG_1 EXC_STD, PACA_EXGEN, 1, vec ;	\
 	EXCEPTION_PROLOG_2_REAL label, EXC_STD, 1
 
 #define STD_EXCEPTION_HV(loc, vec, label)			\
-	EXCEPTION_PROLOG(PACA_EXGEN, label, EXC_HV, KVMTEST_HV, vec)
+	EXCEPTION_PROLOG(PACA_EXGEN, label, EXC_HV, 1, vec)
 
 #define STD_EXCEPTION_HV_OOL(vec, label)			\
-	EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST_HV, vec);	\
+	EXCEPTION_PROLOG_1 EXC_HV, PACA_EXGEN, 1, vec ;		\
 	EXCEPTION_PROLOG_2_REAL label, EXC_HV, 1
 
 #define STD_RELON_EXCEPTION(loc, vec, label)		\
 	/* No guest interrupts come through here */	\
-	EXCEPTION_RELON_PROLOG(PACA_EXGEN, label, EXC_STD, NOTEST, vec)
+	EXCEPTION_RELON_PROLOG(PACA_EXGEN, label, EXC_STD, 0, vec)
 
 #define STD_RELON_EXCEPTION_OOL(vec, label)			\
-	EXCEPTION_PROLOG_1(PACA_EXGEN, NOTEST, vec);		\
+	EXCEPTION_PROLOG_1 EXC_STD, PACA_EXGEN, 0, vec ;	\
 	EXCEPTION_PROLOG_2_VIRT label, EXC_STD
 
-#define STD_RELON_EXCEPTION_HV(loc, vec, label)		\
-	EXCEPTION_RELON_PROLOG(PACA_EXGEN, label, EXC_HV, KVMTEST_HV, vec)
+#define STD_RELON_EXCEPTION_HV(loc, vec, label)			\
+	EXCEPTION_RELON_PROLOG(PACA_EXGEN, label, EXC_HV, 1, vec)
 
 #define STD_RELON_EXCEPTION_HV_OOL(vec, label)			\
-	EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST_HV, vec);	\
+	EXCEPTION_PROLOG_1 EXC_HV, PACA_EXGEN, 1, vec;		\
 	EXCEPTION_PROLOG_2_VIRT label, EXC_HV
 
-.macro SOFTEN_TEST hsrr, vec, bitmask
-	lbz	r10, PACAIRQSOFTMASK(r13)
-	andi.	r10, r10, \bitmask
-	/* This associates vector numbers with bits in paca->irq_happened */
-	.if \vec == 0x500 || \vec == 0xea0
-	li	r10, PACA_IRQ_EE
-	.elseif \vec == 0x900 || \vec == 0xea0
-	li	r10, PACA_IRQ_DEC
-	.elseif \vec == 0xa00 || \vec == 0xe80
-	li	r10, PACA_IRQ_DBELL
-	.elseif \vec == 0xe60
-	li	r10, PACA_IRQ_HMI
-	.elseif \vec == 0xf00
-	li	r10, PACA_IRQ_PMI
-	.else
-	.abort "Bad maskable vector"
-	.endif
-
-
-	.if \hsrr
-	bne	masked_Hinterrupt
-	.else
-	bne	masked_interrupt
-	.endif
-.endm
-
-#define SOFTEN_TEST_PR(vec, bitmask)					\
-	KVMTEST EXC_STD, vec ;						\
-	SOFTEN_TEST EXC_STD, vec, bitmask
-
-#define SOFTEN_TEST_HV(vec, bitmask)					\
-	KVMTEST EXC_HV, vec ;						\
-	SOFTEN_TEST EXC_HV, vec, bitmask
-
-#define KVMTEST_PR(vec)							\
-	KVMTEST EXC_STD, vec
-
-#define KVMTEST_HV(vec)							\
-	KVMTEST EXC_HV, vec
-
-#define SOFTEN_NOTEST_PR(vec, bitmask)	SOFTEN_TEST EXC_STD, vec, bitmask
-#define SOFTEN_NOTEST_HV(vec, bitmask)	SOFTEN_TEST EXC_HV, vec, bitmask
-
-#define __MASKABLE_EXCEPTION(vec, label, h, extra, bitmask)		\
+#define __MASKABLE_EXCEPTION(vec, label, hsrr, kvm, bitmask)		\
 	SET_SCRATCH0(r13);    /* save r13 */				\
 	EXCEPTION_PROLOG_0(PACA_EXGEN);					\
-	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, extra, vec, bitmask);	\
-	EXCEPTION_PROLOG_2_REAL label, h, 1
+	MASKABLE_EXCEPTION_PROLOG_1 hsrr, PACA_EXGEN, kvm, vec, bitmask ; \
+	EXCEPTION_PROLOG_2_REAL label, hsrr, 1
 
 #define MASKABLE_EXCEPTION(vec, label, bitmask)				\
-	__MASKABLE_EXCEPTION(vec, label, EXC_STD, SOFTEN_TEST_PR, bitmask)
+	__MASKABLE_EXCEPTION(vec, label, EXC_STD, 1, bitmask)
 
 #define MASKABLE_EXCEPTION_OOL(vec, label, bitmask)			\
-	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_PR, vec, bitmask);\
+	MASKABLE_EXCEPTION_PROLOG_1 EXC_STD, PACA_EXGEN, 1, vec, bitmask ; \
 	EXCEPTION_PROLOG_2_REAL label, EXC_STD, 1
 
 #define MASKABLE_EXCEPTION_HV(vec, label, bitmask)			\
-	__MASKABLE_EXCEPTION(vec, label, EXC_HV, SOFTEN_TEST_HV, bitmask)
+	__MASKABLE_EXCEPTION(vec, label, EXC_HV, 1, bitmask)
 
 #define MASKABLE_EXCEPTION_HV_OOL(vec, label, bitmask)			\
-	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_HV, vec, bitmask);\
+	MASKABLE_EXCEPTION_PROLOG_1 EXC_HV, PACA_EXGEN, 1, vec, bitmask ; \
 	EXCEPTION_PROLOG_2_REAL label, EXC_HV, 1
 
-#define __MASKABLE_RELON_EXCEPTION(vec, label, h, extra, bitmask)	\
+#define __MASKABLE_RELON_EXCEPTION(vec, label, hsrr, kvm, bitmask)	\
 	SET_SCRATCH0(r13);    /* save r13 */				\
 	EXCEPTION_PROLOG_0(PACA_EXGEN);					\
-	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, extra, vec, bitmask);	\
-	EXCEPTION_PROLOG_2_VIRT label, h
+	MASKABLE_EXCEPTION_PROLOG_1 hsrr, PACA_EXGEN, kvm, vec, bitmask ; \
+	EXCEPTION_PROLOG_2_VIRT label, hsrr
 
 #define MASKABLE_RELON_EXCEPTION(vec, label, bitmask)			\
-	__MASKABLE_RELON_EXCEPTION(vec, label, EXC_STD, SOFTEN_NOTEST_PR, bitmask)
+	__MASKABLE_RELON_EXCEPTION(vec, label, EXC_STD, 0, bitmask)
 
 #define MASKABLE_RELON_EXCEPTION_OOL(vec, label, bitmask)		\
-	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_NOTEST_PR, vec, bitmask);\
+	MASKABLE_EXCEPTION_PROLOG_1 EXC_STD, PACA_EXGEN, 0, vec, bitmask ; \
 	EXCEPTION_PROLOG_2_REAL label, EXC_STD, 1
 
 #define MASKABLE_RELON_EXCEPTION_HV(vec, label, bitmask)		\
-	__MASKABLE_RELON_EXCEPTION(vec, label, EXC_HV, SOFTEN_TEST_HV, bitmask)
+	__MASKABLE_RELON_EXCEPTION(vec, label, EXC_HV, 1, bitmask)
 
 #define MASKABLE_RELON_EXCEPTION_HV_OOL(vec, label, bitmask)		\
-	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_HV, vec, bitmask);\
+	MASKABLE_EXCEPTION_PROLOG_1 EXC_HV, PACA_EXGEN, 1, vec, bitmask ; \
 	EXCEPTION_PROLOG_2_VIRT label, EXC_HV
 
 /*
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 73445b0d6cbf..dc2c794f529d 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -98,6 +98,17 @@ __start_interrupts:
 EXC_VIRT_NONE(0x4000, 0x100)
 
 
+EXC_REAL_BEGIN(system_reset, 0x100, 0x100)
+	SET_SCRATCH0(r13)
+	EXCEPTION_PROLOG_0(PACA_EXNMI)
+
+	/* This is EXCEPTION_PROLOG_1 with the idle feature section added */
+	OPT_SAVE_REG_TO_PACA(PACA_EXNMI+EX_PPR, r9, CPU_FTR_HAS_PPR)
+	OPT_SAVE_REG_TO_PACA(PACA_EXNMI+EX_CFAR, r10, CPU_FTR_CFAR)
+	INTERRUPT_TO_KERNEL
+	SAVE_CTR(r10, PACA_EXNMI)
+	mfcr	r9
+
 #ifdef CONFIG_PPC_P7_NAP
 	/*
 	 * If running native on arch 2.06 or later, check if we are waking up
@@ -107,28 +118,26 @@ EXC_VIRT_NONE(0x4000, 0x100)
 	 * but we branch to the 0xc000... address so we can turn on relocation
 	 * with mtmsr.
 	 */
-#define IDLETEST(n)							\
-	BEGIN_FTR_SECTION ;						\
-	mfspr	r10,SPRN_SRR1 ;						\
-	rlwinm.	r10,r10,47-31,30,31 ;					\
-	beq-	1f ;							\
-	cmpwi	cr3,r10,2 ;						\
-	BRANCH_TO_C000(r10, system_reset_idle_common) ;			\
-1:									\
-	KVMTEST_PR(n) ;							\
-	END_FTR_SECTION_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
-#else
-#define IDLETEST NOTEST
+	BEGIN_FTR_SECTION
+	mfspr	r10,SPRN_SRR1
+	rlwinm.	r10,r10,47-31,30,31
+	beq-	1f
+	cmpwi	cr3,r10,2
+	BRANCH_TO_C000(r10, system_reset_idle_common)
+1:
 #endif
 
-EXC_REAL_BEGIN(system_reset, 0x100, 0x100)
-	SET_SCRATCH0(r13)
+	KVMTEST EXC_STD 0x100
+	std	r11,PACA_EXNMI+EX_R11(r13)
+	std	r12,PACA_EXNMI+EX_R12(r13)
+	GET_SCRATCH0(r10)
+	std	r10,PACA_EXNMI+EX_R13(r13)
+
+	EXCEPTION_PROLOG_2_REAL system_reset_common, EXC_STD, 0
 	/*
 	 * MSR_RI is not enabled, because PACA_EXNMI and nmi stack is
 	 * being used, so a nested NMI exception would corrupt it.
 	 */
-	EXCEPTION_PROLOG_NORI(PACA_EXNMI, system_reset_common, EXC_STD,
-			      IDLETEST, 0x100)
 
 EXC_REAL_END(system_reset, 0x100, 0x100)
 EXC_VIRT_NONE(0x4100, 0x100)
@@ -232,7 +241,7 @@ TRAMP_REAL_BEGIN(system_reset_fwnmi)
 	SET_SCRATCH0(r13)		/* save r13 */
 	/* See comment at system_reset exception */
 	EXCEPTION_PROLOG_NORI(PACA_EXNMI, system_reset_common, EXC_STD,
-			      NOTEST, 0x100)
+			      0, 0x100)
 #endif /* CONFIG_PPC_PSERIES */
 
 
@@ -251,7 +260,7 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
 EXC_REAL_END(machine_check, 0x200, 0x100)
 EXC_VIRT_NONE(0x4200, 0x100)
 TRAMP_REAL_BEGIN(machine_check_common_early)
-	EXCEPTION_PROLOG_1(PACA_EXMC, NOTEST, 0x200)
+	EXCEPTION_PROLOG_1 EXC_HV, PACA_EXMC, 0, 0x200
 	/*
 	 * Register contents:
 	 * R13		= PACA
@@ -335,7 +344,7 @@ BEGIN_FTR_SECTION
 	b	machine_check_common_early
 END_FTR_SECTION_IFCLR(CPU_FTR_HVMODE)
 machine_check_pSeries_0:
-	EXCEPTION_PROLOG_1(PACA_EXMC, KVMTEST_PR, 0x200)
+	EXCEPTION_PROLOG_1 EXC_STD, PACA_EXMC, 1, 0x200
 	/*
 	 * MSR_RI is not enabled, because PACA_EXMC is being used, so a
 	 * nested machine check corrupts it. machine_check_common enables
@@ -596,11 +605,11 @@ ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_TYPE_RADIX)
 
 
 EXC_REAL_BEGIN(data_access_slb, 0x380, 0x80)
-EXCEPTION_PROLOG(PACA_EXSLB, data_access_slb_common, EXC_STD, KVMTEST_PR, 0x380);
+EXCEPTION_PROLOG(PACA_EXSLB, data_access_slb_common, EXC_STD, 1, 0x380);
 EXC_REAL_END(data_access_slb, 0x380, 0x80)
 
 EXC_VIRT_BEGIN(data_access_slb, 0x4380, 0x80)
-EXCEPTION_RELON_PROLOG(PACA_EXSLB, data_access_slb_common, EXC_STD, NOTEST, 0x380);
+EXCEPTION_RELON_PROLOG(PACA_EXSLB, data_access_slb_common, EXC_STD, 0, 0x380);
 EXC_VIRT_END(data_access_slb, 0x4380, 0x80)
 
 TRAMP_KVM_SKIP(PACA_EXSLB, 0x380)
@@ -648,11 +657,11 @@ ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_TYPE_RADIX)
 
 
 EXC_REAL_BEGIN(instruction_access_slb, 0x480, 0x80)
-EXCEPTION_PROLOG(PACA_EXSLB, instruction_access_slb_common, EXC_STD, KVMTEST_PR, 0x480);
+EXCEPTION_PROLOG(PACA_EXSLB, instruction_access_slb_common, EXC_STD, 1, 0x480);
 EXC_REAL_END(instruction_access_slb, 0x480, 0x80)
 
 EXC_VIRT_BEGIN(instruction_access_slb, 0x4480, 0x80)
-EXCEPTION_RELON_PROLOG(PACA_EXSLB, instruction_access_slb_common, EXC_STD, NOTEST, 0x480);
+EXCEPTION_RELON_PROLOG(PACA_EXSLB, instruction_access_slb_common, EXC_STD, 0, 0x480);
 EXC_VIRT_END(instruction_access_slb, 0x4480, 0x80)
 
 TRAMP_KVM(PACA_EXSLB, 0x480)
@@ -694,7 +703,7 @@ hardware_interrupt_relon_hv:
 					    IRQS_DISABLED)
 	FTR_SECTION_ELSE
 		__MASKABLE_RELON_EXCEPTION(0x500, hardware_interrupt_common,
-					   EXC_STD, SOFTEN_TEST_PR, IRQS_DISABLED)
+					   EXC_STD, 1, IRQS_DISABLED)
 	ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
 EXC_VIRT_END(hardware_interrupt, 0x4500, 0x100)
 
@@ -867,7 +876,7 @@ EXC_COMMON(trap_0b_common, 0xb00, unknown_exception)
 	GET_PACA(r13);							\
 	std	r10,PACA_EXGEN+EX_R10(r13);				\
 	INTERRUPT_TO_KERNEL;						\
-	KVMTEST_PR(0xc00); /* uses r10, branch to do_kvm_0xc00_system_call */ \
+	KVMTEST EXC_STD 0xc00 ; /* uses r10, branch to do_kvm_0xc00_system_call */ \
 	HMT_MEDIUM;							\
 	mfctr	r9;
 
@@ -1030,7 +1039,7 @@ __TRAMP_REAL_OOL_MASKABLE_HV(hmi_exception, 0xe60, IRQS_DISABLED)
 EXC_VIRT_NONE(0x4e60, 0x20)
 TRAMP_KVM_HV(PACA_EXGEN, 0xe60)
 TRAMP_REAL_BEGIN(hmi_exception_early)
-	EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST_HV, 0xe60)
+	EXCEPTION_PROLOG_1 EXC_HV, PACA_EXGEN, 1, 0xe60
 	mr	r10,r1			/* Save r1 */
 	ld	r1,PACAEMERGSP(r13)	/* Use emergency stack for realmode */
 	subi	r1,r1,INT_FRAME_SIZE	/* alloc stack frame		*/
@@ -1231,7 +1240,7 @@ EXC_VIRT_NONE(0x5400, 0x100)
 EXC_REAL_BEGIN(denorm_exception_hv, 0x1500, 0x100)
 	mtspr	SPRN_SPRG_HSCRATCH0,r13
 	EXCEPTION_PROLOG_0(PACA_EXGEN)
-	EXCEPTION_PROLOG_1(PACA_EXGEN, NOTEST, 0x1500)
+	EXCEPTION_PROLOG_1 EXC_HV, PACA_EXGEN, 0, 0x1500
 
 #ifdef CONFIG_PPC_DENORMALISATION
 	mfspr	r10,SPRN_HSRR1
@@ -1239,7 +1248,7 @@ EXC_REAL_BEGIN(denorm_exception_hv, 0x1500, 0x100)
 	bne+	denorm_assist
 #endif
 
-	KVMTEST_HV(0x1500)
+	KVMTEST EXC_HV 0x1500
 	EXCEPTION_PROLOG_2_REAL denorm_common, EXC_HV, 1
 EXC_REAL_END(denorm_exception_hv, 0x1500, 0x100)
 
-- 
2.18.0

