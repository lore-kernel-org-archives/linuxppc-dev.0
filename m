Return-Path: <SRS0=Z4Cu=QL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41727C282C4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 14:28:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B455214DA
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 14:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OU1JS2fz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B455214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43tVS76dQXzDqJc
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 01:28:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="OU1JS2fz"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43tVF4698nzDqCw
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 01:18:48 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id s1so514339plp.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Feb 2019 06:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=auM2CCgJ8InCW0vlkPe/E5ZUJJ+VmWGEKYymi6dZgVo=;
 b=OU1JS2fzP740rwV0IHG5ptRyS8seQSCe1THhW6IkeTw33D75VYY7BhEHLZhlEaue5E
 10LeM2uzBYXeQZKxZnGTsVzejlxBqEtRbyCD3HTRmI6cI8jju945MoyW7rCXV3n/KxxL
 QRHTM9q9MKLhRkpSMJDjnhGVjNIpgWLl3ziaydwtbUJTIPc5qrpu6DfqxZCetGtYb1Wk
 DstxlrFYHLIuFaqZpKzBArm1ufz0+0zc1xuZxVAeCTAgNgYL9uO1xRB9Pg6XtMjXGuez
 /tFvTN45y9m65NHlY25rOAP43pRuPHnbwduvBAtGFnWAJoQ/6orC4RjunMXZHzbhqYfj
 5PSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=auM2CCgJ8InCW0vlkPe/E5ZUJJ+VmWGEKYymi6dZgVo=;
 b=LD7em0n6hLeArFjyAmS2BdaH4R58HIYRpVRWqsCMrLgRtxcEh2wOrNvxk2kN52Hryu
 u8mIUZsoLT4ZBu80lQekxCmsknj93IpIlWe50vNdsYsOwWGsrv7YJ6yrh1pFz7pZsWPB
 KuUaih6n3G26tQIhtV+DFeh3wSThnfUu0hLpbejLiexrCVFm+TUJty2xN5DRv+dvh2Wd
 9gKr6btrxdqfT4jh33p56Sh/LldfZMQ7Z0JKNOkWiRYPH9bb2lsq/4uVmo1OI0UdSWgs
 zWmFG3+Q5PDBWAnC7wtQ/6uJ6Fxr/cjIGSHylk2oXkxFhi9QSi3JU0unKvYctyffZFw8
 rZrA==
X-Gm-Message-State: AHQUAuaJPb4emWPiIDTnSpuiuy3TBCXbxwB3wsJ5Msygn0VaGrjtHsK9
 xk3Rt5V/u6GEAnd2rUYizq6ov6DU
X-Google-Smtp-Source: AHgI3IaklcZpJmv8C8qeWAQBdVvgmDZvTCNMF7jebcaG3mj68E/ox1fnNFTLMUvJyNkrFb1nDyPMig==
X-Received: by 2002:a17:902:8497:: with SMTP id
 c23mr11627969plo.64.1549289926885; 
 Mon, 04 Feb 2019 06:18:46 -0800 (PST)
Received: from roar.local0.net ([210.185.78.69])
 by smtp.gmail.com with ESMTPSA id h9sm226230pgd.53.2019.02.04.06.18.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 04 Feb 2019 06:18:46 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 04/17] powerpc/64s/exception: move and tidy EXCEPTION_PROLOG_2
 variants
Date: Tue,  5 Feb 2019 00:18:15 +1000
Message-Id: <20190204141828.13043-5-npiggin@gmail.com>
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

- Re-name the macros to _REAL and _VIRT suffixes rather than no and
  _RELON suffix.

- Move the macro definitions together in the file.

- Move RELOCATABLE ifdef inside the _VIRT macro.

Further consolidation between variants does not buy much here.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/exception-64s.h | 87 ++++++++++++------------
 arch/powerpc/kernel/exceptions-64s.S     |  6 +-
 2 files changed, 45 insertions(+), 48 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index aa19c95e7cfa..7f6358654263 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -174,8 +174,33 @@
 	ori	reg,reg,(ABS_ADDR(label))@l;				\
 	addis	reg,reg,(ABS_ADDR(label))@h
 
+.macro EXCEPTION_PROLOG_2_REAL label, hsrr, set_ri
+	ld	r10,PACAKMSR(r13)	/* get MSR value for kernel */
+	.if ! \set_ri
+	xori	r10,r10,MSR_RI		/* Clear MSR_RI */
+	.endif
+	.if \hsrr
+	mfspr	r11,SPRN_HSRR0		/* save HSRR0 */
+	.else
+	mfspr	r11,SPRN_SRR0		/* save SRR0 */
+	.endif
+	LOAD_HANDLER(r12, \label\())
+	.if \hsrr
+	mtspr	SPRN_HSRR0,r12
+	mfspr	r12,SPRN_HSRR1		/* and HSRR1 */
+	mtspr	SPRN_HSRR1,r10
+	HRFI_TO_KERNEL
+	.else
+	mtspr	SPRN_SRR0,r12
+	mfspr	r12,SPRN_SRR1		/* and SRR1 */
+	mtspr	SPRN_SRR1,r10
+	RFI_TO_KERNEL
+	.endif
+	b	.	/* prevent speculative execution */
+.endm
+
+.macro EXCEPTION_PROLOG_2_VIRT label, hsrr
 #ifdef CONFIG_RELOCATABLE
-.macro EXCEPTION_PROLOG_2_RELON label, hsrr
 	.if \hsrr
 	mfspr	r11,SPRN_HSRR0	/* save HSRR0 */
 	.else
@@ -191,10 +216,7 @@
 	li	r10,MSR_RI
 	mtmsrd 	r10,1		/* Set RI (EE=0) */
 	bctr
-.endm
 #else
-/* If not relocatable, we can jump directly -- and save messing with LR */
-.macro EXCEPTION_PROLOG_2_RELON label, hsrr
 	.if \hsrr
 	mfspr	r11,SPRN_HSRR0		/* save HSRR0 */
 	mfspr	r12,SPRN_HSRR1		/* and HSRR1 */
@@ -205,19 +227,19 @@
 	li	r10,MSR_RI
 	mtmsrd 	r10,1			/* Set RI (EE=0) */
 	b	label
-.endm
 #endif
+.endm
 
 /*
  * As EXCEPTION_PROLOG(), except we've already got relocation on so no need to
- * rfid. Save LR in case we're CONFIG_RELOCATABLE, in which case
- * EXCEPTION_PROLOG_2_RELON will be using LR.
+ * rfid. Save CTR in case we're CONFIG_RELOCATABLE, in which case
+ * EXCEPTION_PROLOG_2_VIRT will be using CTR.
  */
 #define EXCEPTION_RELON_PROLOG(area, label, hsrr, extra, vec)		\
 	SET_SCRATCH0(r13);		/* save r13 */			\
 	EXCEPTION_PROLOG_0(area);					\
 	EXCEPTION_PROLOG_1(area, extra, vec);				\
-	EXCEPTION_PROLOG_2_RELON label, hsrr
+	EXCEPTION_PROLOG_2_VIRT label, hsrr
 
 /* Exception register prefixes */
 #define EXC_HV		1
@@ -323,36 +345,11 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 #define EXCEPTION_PROLOG_1(area, extra, vec)				\
 	_EXCEPTION_PROLOG_1(area, extra, vec)
 
-.macro EXCEPTION_PROLOG_2 label, hsrr, set_ri
-	ld	r10,PACAKMSR(r13)	/* get MSR value for kernel */
-	.if ! \set_ri
-	xori	r10,r10,MSR_RI		/* Clear MSR_RI */
-	.endif
-	.if \hsrr
-	mfspr	r11,SPRN_HSRR0		/* save HSRR0 */
-	.else
-	mfspr	r11,SPRN_SRR0		/* save SRR0 */
-	.endif
-	LOAD_HANDLER(r12,\label\())
-	.if \hsrr
-	mtspr	SPRN_HSRR0,r12
-	mfspr	r12,SPRN_HSRR1		/* and HSRR1 */
-	mtspr	SPRN_HSRR1,r10
-	HRFI_TO_KERNEL
-	.else
-	mtspr	SPRN_SRR0,r12
-	mfspr	r12,SPRN_SRR1		/* and SRR1 */
-	mtspr	SPRN_SRR1,r10
-	RFI_TO_KERNEL
-	.endif
-	b	.	/* prevent speculative execution */
-.endm
-
 #define EXCEPTION_PROLOG(area, label, h, extra, vec)			\
 	SET_SCRATCH0(r13);		/* save r13 */			\
 	EXCEPTION_PROLOG_0(area);					\
 	EXCEPTION_PROLOG_1(area, extra, vec);				\
-	EXCEPTION_PROLOG_2 label, h, 1
+	EXCEPTION_PROLOG_2_REAL label, h, 1
 
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 /*
@@ -421,7 +418,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 #define EXCEPTION_PROLOG_NORI(area, label, h, extra, vec)		\
 	EXCEPTION_PROLOG_0(area);					\
 	EXCEPTION_PROLOG_1(area, extra, vec);				\
-	EXCEPTION_PROLOG_2 label, h, 0
+	EXCEPTION_PROLOG_2_REAL label, h, 0
 
 #ifdef CONFIG_KVM_BOOK3S_64_HANDLER
 .macro KVMTEST hsrr, n
@@ -577,14 +574,14 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 
 #define STD_EXCEPTION_OOL(vec, label)				\
 	EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST_PR, vec);	\
-	EXCEPTION_PROLOG_2 label, EXC_STD, 1
+	EXCEPTION_PROLOG_2_REAL label, EXC_STD, 1
 
 #define STD_EXCEPTION_HV(loc, vec, label)			\
 	EXCEPTION_PROLOG(PACA_EXGEN, label, EXC_HV, KVMTEST_HV, vec)
 
 #define STD_EXCEPTION_HV_OOL(vec, label)			\
 	EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST_HV, vec);	\
-	EXCEPTION_PROLOG_2 label, EXC_HV, 1
+	EXCEPTION_PROLOG_2_REAL label, EXC_HV, 1
 
 #define STD_RELON_EXCEPTION(loc, vec, label)		\
 	/* No guest interrupts come through here */	\
@@ -592,14 +589,14 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 
 #define STD_RELON_EXCEPTION_OOL(vec, label)			\
 	EXCEPTION_PROLOG_1(PACA_EXGEN, NOTEST, vec);		\
-	EXCEPTION_PROLOG_2_RELON label, EXC_STD
+	EXCEPTION_PROLOG_2_VIRT label, EXC_STD
 
 #define STD_RELON_EXCEPTION_HV(loc, vec, label)		\
 	EXCEPTION_RELON_PROLOG(PACA_EXGEN, label, EXC_HV, KVMTEST_HV, vec)
 
 #define STD_RELON_EXCEPTION_HV_OOL(vec, label)			\
 	EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST_HV, vec);	\
-	EXCEPTION_PROLOG_2_RELON label, EXC_HV
+	EXCEPTION_PROLOG_2_VIRT label, EXC_HV
 
 .macro SOFTEN_TEST hsrr, vec, bitmask
 	lbz	r10, PACAIRQSOFTMASK(r13)
@@ -648,41 +645,41 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	SET_SCRATCH0(r13);    /* save r13 */				\
 	EXCEPTION_PROLOG_0(PACA_EXGEN);					\
 	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, extra, vec, bitmask);	\
-	EXCEPTION_PROLOG_2 label, h, 1
+	EXCEPTION_PROLOG_2_REAL label, h, 1
 
 #define MASKABLE_EXCEPTION(vec, label, bitmask)				\
 	__MASKABLE_EXCEPTION(vec, label, EXC_STD, SOFTEN_TEST_PR, bitmask)
 
 #define MASKABLE_EXCEPTION_OOL(vec, label, bitmask)			\
 	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_PR, vec, bitmask);\
-	EXCEPTION_PROLOG_2 label, EXC_STD, 1
+	EXCEPTION_PROLOG_2_REAL label, EXC_STD, 1
 
 #define MASKABLE_EXCEPTION_HV(vec, label, bitmask)			\
 	__MASKABLE_EXCEPTION(vec, label, EXC_HV, SOFTEN_TEST_HV, bitmask)
 
 #define MASKABLE_EXCEPTION_HV_OOL(vec, label, bitmask)			\
 	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_HV, vec, bitmask);\
-	EXCEPTION_PROLOG_2 label, EXC_HV, 1
+	EXCEPTION_PROLOG_2_REAL label, EXC_HV, 1
 
 #define __MASKABLE_RELON_EXCEPTION(vec, label, h, extra, bitmask)	\
 	SET_SCRATCH0(r13);    /* save r13 */				\
 	EXCEPTION_PROLOG_0(PACA_EXGEN);					\
 	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, extra, vec, bitmask);	\
-	EXCEPTION_PROLOG_2_RELON label, h
+	EXCEPTION_PROLOG_2_VIRT label, h
 
 #define MASKABLE_RELON_EXCEPTION(vec, label, bitmask)			\
 	__MASKABLE_RELON_EXCEPTION(vec, label, EXC_STD, SOFTEN_NOTEST_PR, bitmask)
 
 #define MASKABLE_RELON_EXCEPTION_OOL(vec, label, bitmask)		\
 	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_NOTEST_PR, vec, bitmask);\
-	EXCEPTION_PROLOG_2 label, EXC_STD, 1
+	EXCEPTION_PROLOG_2_REAL label, EXC_STD, 1
 
 #define MASKABLE_RELON_EXCEPTION_HV(vec, label, bitmask)		\
 	__MASKABLE_RELON_EXCEPTION(vec, label, EXC_HV, SOFTEN_TEST_HV, bitmask)
 
 #define MASKABLE_RELON_EXCEPTION_HV_OOL(vec, label, bitmask)		\
 	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_HV, vec, bitmask);\
-	EXCEPTION_PROLOG_2_RELON label, EXC_HV
+	EXCEPTION_PROLOG_2_VIRT label, EXC_HV
 
 /*
  * Our exception common code can be passed various "additions"
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 384439ef5c77..73445b0d6cbf 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -341,7 +341,7 @@ machine_check_pSeries_0:
 	 * nested machine check corrupts it. machine_check_common enables
 	 * MSR_RI.
 	 */
-	EXCEPTION_PROLOG_2 machine_check_common, EXC_STD, 0
+	EXCEPTION_PROLOG_2_REAL machine_check_common, EXC_STD, 0
 
 TRAMP_KVM_SKIP(PACA_EXMC, 0x200)
 
@@ -1240,7 +1240,7 @@ EXC_REAL_BEGIN(denorm_exception_hv, 0x1500, 0x100)
 #endif
 
 	KVMTEST_HV(0x1500)
-	EXCEPTION_PROLOG_2 denorm_common, EXC_HV, 1
+	EXCEPTION_PROLOG_2_REAL denorm_common, EXC_HV, 1
 EXC_REAL_END(denorm_exception_hv, 0x1500, 0x100)
 
 #ifdef CONFIG_PPC_DENORMALISATION
@@ -1362,7 +1362,7 @@ EXC_VIRT_NONE(0x5800, 0x100)
 	std	r12,PACA_EXGEN+EX_R12(r13);		\
 	GET_SCRATCH0(r10);				\
 	std	r10,PACA_EXGEN+EX_R13(r13);		\
-	EXCEPTION_PROLOG_2 soft_nmi_common, _H, 1
+	EXCEPTION_PROLOG_2_REAL soft_nmi_common, _H, 1
 
 /*
  * Branch to soft_nmi_interrupt using the emergency stack. The emergency
-- 
2.18.0

