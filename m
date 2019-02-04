Return-Path: <SRS0=Z4Cu=QL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D243C282C4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 14:23:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D18772082E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 14:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e56+Riov"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D18772082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43tVLs0g7nzDqGQ
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 01:23:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="e56+Riov"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43tVF06ZZ3zDqCw
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 01:18:44 +1100 (AEDT)
Received: by mail-pl1-x644.google.com with SMTP id b5so1891plr.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Feb 2019 06:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=0mb8XL+4k9cGCVBoYA8Pi+xA5XjCHhwjG282d98RjxA=;
 b=e56+RioveVjO5HD8uqm30GOaDJXDH1KvspCCWXM2aWz3hpjGj+FbKCFLgL7DORtKs4
 C6hys/ncgTHy/c3jNiGYg3OjKHD+Vgp3qkmMXV7MmeOmzWECijVppO00KLvIesvmQN2E
 BHIFWSTQ1azqsdNYDYrDNegDTCt7ktT9qeaa78MnZegMNbbmt1M4LxGMNfwEnEXM0nB+
 CXA59ZFMS5KcHlAax5M3DwoEc7Ga4UKqUckdxE5hvk7n1zQFjZEAoHgVe46Kb0My5LA7
 AGx0z9qKeNraQ0OUGaBBnmEkuf3XRbgWY31Bh0HS9dnJx9lKT//LoYikusSwgkXcEf4F
 s3aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=0mb8XL+4k9cGCVBoYA8Pi+xA5XjCHhwjG282d98RjxA=;
 b=qzHsl7g4bLt3J7dodqkCFsJU7tAs2y2KKhE1T5emyW8Sf+KUL+HTJlLnGcKdNnfZ1s
 QPyJ3DxvCLYDdW49UIygcwwkydPyPcmYP1XiBbvLcviCseTCVCRp9bsShmK/qznn767g
 Bp5SbTbuE2h2K8vmy5qWWxfVpJIurRdlTUnC5PudyoGCyUYTqnhbaK6L7kvg1/e9IzNt
 GZSlHkCrbVW5ql+wR2+eD0s/yPuiX3TJS95niUq6GenhV1hqsNP3PcLx7huitYo/o0uJ
 WRASr0XYbw7DfDTVxqxKBESXZ0YvkHi5MVqanF0A3YitrJD+fiJcHCUnwxcF7clM5z5/
 nf/w==
X-Gm-Message-State: AJcUukcqnGrOA44AylyCkhCdryA39Kj/f/xphcMcY/AOZOxYvtu952LM
 rRHm/dEcZ3Rq/PvUZ23Z2kbDcmjQ
X-Google-Smtp-Source: ALg8bN4gO+Q/ZmixM6XchaGiusBXGWymbAFCWkQ7VshqkabNRDw+IKQZbsN80C2b2s+cnQt7HeUh/g==
X-Received: by 2002:a17:902:8a91:: with SMTP id
 p17mr51912364plo.316.1549289922617; 
 Mon, 04 Feb 2019 06:18:42 -0800 (PST)
Received: from roar.local0.net ([210.185.78.69])
 by smtp.gmail.com with ESMTPSA id h9sm226230pgd.53.2019.02.04.06.18.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 04 Feb 2019 06:18:42 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 02/17] powerpc/64s/exception: remove H concatenation for
 EXC_HV variants
Date: Tue,  5 Feb 2019 00:18:13 +1000
Message-Id: <20190204141828.13043-3-npiggin@gmail.com>
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

Replace all instances of this with gas macros that test the hsrr
parameter and use the appropriate register names / labels.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/exception-64s.h | 333 +++++++++++++----------
 arch/powerpc/include/asm/head-64.h       |   8 +-
 arch/powerpc/kernel/exceptions-64s.S     |  85 +++---
 3 files changed, 247 insertions(+), 179 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index f78ff225cb64..230328724314 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -67,6 +67,8 @@
  */
 #define EX_R3		EX_DAR
 
+#ifdef __ASSEMBLY__
+
 #define STF_ENTRY_BARRIER_SLOT						\
 	STF_ENTRY_BARRIER_FIXUP_SECTION;				\
 	nop;								\
@@ -148,38 +150,6 @@
 	hrfid;								\
 	b	hrfi_flush_fallback
 
-#ifdef CONFIG_RELOCATABLE
-#define __EXCEPTION_PROLOG_2_RELON(label, h)				\
-	mfspr	r11,SPRN_##h##SRR0;	/* save SRR0 */			\
-	LOAD_HANDLER(r12,label);					\
-	mtctr	r12;							\
-	mfspr	r12,SPRN_##h##SRR1;	/* and SRR1 */			\
-	li	r10,MSR_RI;						\
-	mtmsrd 	r10,1;			/* Set RI (EE=0) */		\
-	bctr;
-#else
-/* If not relocatable, we can jump directly -- and save messing with LR */
-#define __EXCEPTION_PROLOG_2_RELON(label, h)				\
-	mfspr	r11,SPRN_##h##SRR0;	/* save SRR0 */			\
-	mfspr	r12,SPRN_##h##SRR1;	/* and SRR1 */			\
-	li	r10,MSR_RI;						\
-	mtmsrd 	r10,1;			/* Set RI (EE=0) */		\
-	b	label;
-#endif
-#define EXCEPTION_PROLOG_2_RELON(label, h)				\
-	__EXCEPTION_PROLOG_2_RELON(label, h)
-
-/*
- * As EXCEPTION_PROLOG(), except we've already got relocation on so no need to
- * rfid. Save LR in case we're CONFIG_RELOCATABLE, in which case
- * EXCEPTION_PROLOG_2_RELON will be using LR.
- */
-#define EXCEPTION_RELON_PROLOG(area, label, h, extra, vec)		\
-	SET_SCRATCH0(r13);		/* save r13 */			\
-	EXCEPTION_PROLOG_0(area);					\
-	EXCEPTION_PROLOG_1(area, extra, vec);				\
-	EXCEPTION_PROLOG_2_RELON(label, h)
-
 /*
  * We're short on space and time in the exception prolog, so we can't
  * use the normal LOAD_REG_IMMEDIATE macro to load the address of label.
@@ -204,9 +174,54 @@
 	ori	reg,reg,(ABS_ADDR(label))@l;				\
 	addis	reg,reg,(ABS_ADDR(label))@h
 
+#ifdef CONFIG_RELOCATABLE
+.macro EXCEPTION_PROLOG_2_RELON label, hsrr
+	.if \hsrr
+	mfspr	r11,SPRN_HSRR0	/* save HSRR0 */
+	.else
+	mfspr	r11,SPRN_SRR0	/* save SRR0 */
+	.endif
+	LOAD_HANDLER(r12, \label\())
+	mtctr	r12
+	.if \hsrr
+	mfspr	r12,SPRN_HSRR1	/* and HSRR1 */
+	.else
+	mfspr	r12,SPRN_SRR1	/* and HSRR1 */
+	.endif
+	li	r10,MSR_RI
+	mtmsrd 	r10,1		/* Set RI (EE=0) */
+	bctr
+.endm
+#else
+/* If not relocatable, we can jump directly -- and save messing with LR */
+.macro EXCEPTION_PROLOG_2_RELON label, hsrr
+	.if \hsrr
+	mfspr	r11,SPRN_HSRR0		/* save HSRR0 */
+	mfspr	r12,SPRN_HSRR1		/* and HSRR1 */
+	.else
+	mfspr	r11,SPRN_SRR0		/* save SRR0 */
+	mfspr	r12,SPRN_SRR1		/* and SRR1 */
+	.endif
+	li	r10,MSR_RI
+	mtmsrd 	r10,1			/* Set RI (EE=0) */
+	b	label
+.endm
+#endif
+
+/*
+ * As EXCEPTION_PROLOG(), except we've already got relocation on so no need to
+ * rfid. Save LR in case we're CONFIG_RELOCATABLE, in which case
+ * EXCEPTION_PROLOG_2_RELON will be using LR.
+ */
+#define EXCEPTION_RELON_PROLOG(area, label, hsrr, extra, vec)		\
+	SET_SCRATCH0(r13);		/* save r13 */			\
+	EXCEPTION_PROLOG_0(area);					\
+	EXCEPTION_PROLOG_1(area, extra, vec);				\
+	EXCEPTION_PROLOG_2_RELON label, hsrr
+
 /* Exception register prefixes */
-#define EXC_HV	H
-#define EXC_STD
+#define EXC_HV		1
+#define EXC_STD		0
 
 #if defined(CONFIG_RELOCATABLE)
 /*
@@ -308,43 +323,57 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 #define EXCEPTION_PROLOG_1(area, extra, vec)				\
 	_EXCEPTION_PROLOG_1(area, extra, vec)
 
-#define __EXCEPTION_PROLOG_2(label, h)					\
-	ld	r10,PACAKMSR(r13);	/* get MSR value for kernel */	\
-	mfspr	r11,SPRN_##h##SRR0;	/* save SRR0 */			\
-	LOAD_HANDLER(r12,label);					\
-	mtspr	SPRN_##h##SRR0,r12;					\
-	mfspr	r12,SPRN_##h##SRR1;	/* and SRR1 */			\
-	mtspr	SPRN_##h##SRR1,r10;					\
-	h##RFI_TO_KERNEL;						\
+.macro EXCEPTION_PROLOG_2 label, hsrr
+	ld	r10,PACAKMSR(r13)	/* get MSR value for kernel */
+	.if \hsrr
+	mfspr	r11,SPRN_HSRR0		/* save HSRR0 */
+	.else
+	mfspr	r11,SPRN_SRR0		/* save SRR0 */
+	.endif
+	LOAD_HANDLER(r12,\label\())
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
 	b	.	/* prevent speculative execution */
-#define EXCEPTION_PROLOG_2(label, h)					\
-	__EXCEPTION_PROLOG_2(label, h)
+.endm
 
 /* _NORI variant keeps MSR_RI clear */
-#define __EXCEPTION_PROLOG_2_NORI(label, h)				\
-	ld	r10,PACAKMSR(r13);	/* get MSR value for kernel */	\
-	xori	r10,r10,MSR_RI;		/* Clear MSR_RI */		\
-	mfspr	r11,SPRN_##h##SRR0;	/* save SRR0 */			\
-	LOAD_HANDLER(r12,label);					\
-	mtspr	SPRN_##h##SRR0,r12;					\
-	mfspr	r12,SPRN_##h##SRR1;	/* and SRR1 */			\
-	mtspr	SPRN_##h##SRR1,r10;					\
-	h##RFI_TO_KERNEL;						\
+.macro EXCEPTION_PROLOG_2_NORI label, hsrr
+	ld	r10,PACAKMSR(r13)	/* get MSR value for kernel */
+	xori	r10,r10,MSR_RI		/* Clear MSR_RI */
+	.if \hsrr
+	mfspr	r11,SPRN_HSRR0		/* save HSRR0 */
+	.else
+	mfspr	r11,SPRN_SRR0		/* save SRR0 */
+	.endif
+	LOAD_HANDLER(r12,\label\())
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
 	b	.	/* prevent speculative execution */
-
-#define EXCEPTION_PROLOG_2_NORI(label, h)				\
-	__EXCEPTION_PROLOG_2_NORI(label, h)
+.endm
 
 #define EXCEPTION_PROLOG(area, label, h, extra, vec)			\
 	SET_SCRATCH0(r13);		/* save r13 */			\
 	EXCEPTION_PROLOG_0(area);					\
 	EXCEPTION_PROLOG_1(area, extra, vec);				\
-	EXCEPTION_PROLOG_2(label, h)
-
-#define __KVMTEST(h, n)							\
-	lbz	r10,HSTATE_IN_GUEST(r13);				\
-	cmpwi	r10,0;							\
-	bne	do_kvm_##h##n
+	EXCEPTION_PROLOG_2 label, h
 
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 /*
@@ -413,52 +442,66 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 #define EXCEPTION_PROLOG_NORI(area, label, h, extra, vec)		\
 	EXCEPTION_PROLOG_0(area);					\
 	EXCEPTION_PROLOG_1(area, extra, vec);				\
-	EXCEPTION_PROLOG_2_NORI(label, h)
-
-
-#define __KVM_HANDLER(area, h, n)					\
-	BEGIN_FTR_SECTION_NESTED(947)					\
-	ld	r10,area+EX_CFAR(r13);					\
-	std	r10,HSTATE_CFAR(r13);					\
-	END_FTR_SECTION_NESTED(CPU_FTR_CFAR,CPU_FTR_CFAR,947);		\
-	BEGIN_FTR_SECTION_NESTED(948)					\
-	ld	r10,area+EX_PPR(r13);					\
-	std	r10,HSTATE_PPR(r13);					\
-	END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,948);	\
-	ld	r10,area+EX_R10(r13);					\
-	std	r12,HSTATE_SCRATCH0(r13);				\
-	sldi	r12,r9,32;						\
-	ori	r12,r12,(n);						\
-	/* This reloads r9 before branching to kvmppc_interrupt */	\
-	__BRANCH_TO_KVM_EXIT(area, kvmppc_interrupt)
-
-#define __KVM_HANDLER_SKIP(area, h, n)					\
-	cmpwi	r10,KVM_GUEST_MODE_SKIP;				\
-	beq	89f;							\
-	BEGIN_FTR_SECTION_NESTED(948)					\
-	ld	r10,area+EX_PPR(r13);					\
-	std	r10,HSTATE_PPR(r13);					\
-	END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,948);	\
-	ld	r10,area+EX_R10(r13);					\
-	std	r12,HSTATE_SCRATCH0(r13);				\
-	sldi	r12,r9,32;						\
-	ori	r12,r12,(n);						\
-	/* This reloads r9 before branching to kvmppc_interrupt */	\
-	__BRANCH_TO_KVM_EXIT(area, kvmppc_interrupt);			\
-89:	mtocrf	0x80,r9;						\
-	ld	r9,area+EX_R9(r13);					\
-	ld	r10,area+EX_R10(r13);					\
-	b	kvmppc_skip_##h##interrupt
+	EXCEPTION_PROLOG_2_NORI label, h
 
 #ifdef CONFIG_KVM_BOOK3S_64_HANDLER
-#define KVMTEST(h, n)			__KVMTEST(h, n)
-#define KVM_HANDLER(area, h, n)		__KVM_HANDLER(area, h, n)
-#define KVM_HANDLER_SKIP(area, h, n)	__KVM_HANDLER_SKIP(area, h, n)
+.macro KVMTEST hsrr, n
+	lbz	r10,HSTATE_IN_GUEST(r13)
+	cmpwi	r10,0
+	.if \hsrr
+	bne	do_kvm_H\n
+	.else
+	bne	do_kvm_\n
+	.endif
+.endm
+
+.macro KVM_HANDLER area, hsrr, n
+	BEGIN_FTR_SECTION_NESTED(947)
+	ld	r10,\area+EX_CFAR(r13)
+	std	r10,HSTATE_CFAR(r13)
+	END_FTR_SECTION_NESTED(CPU_FTR_CFAR,CPU_FTR_CFAR,947)
+	BEGIN_FTR_SECTION_NESTED(948)
+	ld	r10,\area+EX_PPR(r13)
+	std	r10,HSTATE_PPR(r13)
+	END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,948)
+	ld	r10,\area+EX_R10(r13)
+	std	r12,HSTATE_SCRATCH0(r13)
+	sldi	r12,r9,32
+	ori	r12,r12,(\n)
+	/* This reloads r9 before branching to kvmppc_interrupt */
+	__BRANCH_TO_KVM_EXIT(\area, kvmppc_interrupt)
+.endm
+
+.macro KVM_HANDLER_SKIP area, hsrr, n
+	cmpwi	r10,KVM_GUEST_MODE_SKIP
+	beq	89f
+	BEGIN_FTR_SECTION_NESTED(948)
+	ld	r10,\area+EX_PPR(r13)
+	std	r10,HSTATE_PPR(r13)
+	END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,948)
+	ld	r10,\area+EX_R10(r13)
+	std	r12,HSTATE_SCRATCH0(r13)
+	sldi	r12,r9,32
+	ori	r12,r12,(\n)
+	/* This reloads r9 before branching to kvmppc_interrupt */
+	__BRANCH_TO_KVM_EXIT(\area, kvmppc_interrupt)
+89:	mtocrf	0x80,r9
+	ld	r9,\area+EX_R9(r13)
+	ld	r10,\area+EX_R10(r13)
+	.if \hsrr
+	b	kvmppc_skip_Hinterrupt
+	.else
+	b	kvmppc_skip_interrupt
+	.endif
+.endm
 
 #else
-#define KVMTEST(h, n)
-#define KVM_HANDLER(area, h, n)
-#define KVM_HANDLER_SKIP(area, h, n)
+.macro KVMTEST hsrr, n
+.endm
+.macro KVM_HANDLER area, hsrr, n
+.endm
+.macro KVM_HANDLER_SKIP area, hsrr, n
+.endm
 #endif
 
 #define NOTEST(n)
@@ -555,14 +598,14 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 
 #define STD_EXCEPTION_OOL(vec, label)				\
 	EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST_PR, vec);	\
-	EXCEPTION_PROLOG_2(label, EXC_STD)
+	EXCEPTION_PROLOG_2 label, EXC_STD
 
 #define STD_EXCEPTION_HV(loc, vec, label)			\
 	EXCEPTION_PROLOG(PACA_EXGEN, label, EXC_HV, KVMTEST_HV, vec)
 
 #define STD_EXCEPTION_HV_OOL(vec, label)			\
 	EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST_HV, vec);	\
-	EXCEPTION_PROLOG_2(label, EXC_HV)
+	EXCEPTION_PROLOG_2 label, EXC_HV
 
 #define STD_RELON_EXCEPTION(loc, vec, label)		\
 	/* No guest interrupts come through here */	\
@@ -570,89 +613,97 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 
 #define STD_RELON_EXCEPTION_OOL(vec, label)			\
 	EXCEPTION_PROLOG_1(PACA_EXGEN, NOTEST, vec);		\
-	EXCEPTION_PROLOG_2_RELON(label, EXC_STD)
+	EXCEPTION_PROLOG_2_RELON label, EXC_STD
 
 #define STD_RELON_EXCEPTION_HV(loc, vec, label)		\
 	EXCEPTION_RELON_PROLOG(PACA_EXGEN, label, EXC_HV, KVMTEST_HV, vec)
 
 #define STD_RELON_EXCEPTION_HV_OOL(vec, label)			\
 	EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST_HV, vec);	\
-	EXCEPTION_PROLOG_2_RELON(label, EXC_HV)
-
-/* This associate vector numbers with bits in paca->irq_happened */
-#define SOFTEN_VALUE_0x500	PACA_IRQ_EE
-#define SOFTEN_VALUE_0x900	PACA_IRQ_DEC
-#define SOFTEN_VALUE_0x980	PACA_IRQ_DEC
-#define SOFTEN_VALUE_0xa00	PACA_IRQ_DBELL
-#define SOFTEN_VALUE_0xe80	PACA_IRQ_DBELL
-#define SOFTEN_VALUE_0xe60	PACA_IRQ_HMI
-#define SOFTEN_VALUE_0xea0	PACA_IRQ_EE
-#define SOFTEN_VALUE_0xf00	PACA_IRQ_PMI
-
-#define __SOFTEN_TEST(h, vec, bitmask)					\
-	lbz	r10,PACAIRQSOFTMASK(r13);				\
-	andi.	r10,r10,bitmask;					\
-	li	r10,SOFTEN_VALUE_##vec;					\
-	bne	masked_##h##interrupt
-
-#define _SOFTEN_TEST(h, vec, bitmask)	__SOFTEN_TEST(h, vec, bitmask)
+	EXCEPTION_PROLOG_2_RELON label, EXC_HV
+
+.macro SOFTEN_TEST hsrr, vec, bitmask
+	lbz	r10, PACAIRQSOFTMASK(r13)
+	andi.	r10, r10, \bitmask
+	/* This associates vector numbers with bits in paca->irq_happened */
+	.if \vec == 0x500 || \vec == 0xea0
+	li	r10, PACA_IRQ_EE
+	.elseif \vec == 0x900 || \vec == 0xea0
+	li	r10, PACA_IRQ_DEC
+	.elseif \vec == 0xa00 || \vec == 0xe80
+	li	r10, PACA_IRQ_DBELL
+	.elseif \vec == 0xe60
+	li	r10, PACA_IRQ_HMI
+	.elseif \vec == 0xf00
+	li	r10, PACA_IRQ_PMI
+	.else
+	.abort "Bad maskable vector"
+	.endif
+
+
+	.if \hsrr
+	bne	masked_Hinterrupt
+	.else
+	bne	masked_interrupt
+	.endif
+.endm
 
 #define SOFTEN_TEST_PR(vec, bitmask)					\
-	KVMTEST(EXC_STD, vec);						\
-	_SOFTEN_TEST(EXC_STD, vec, bitmask)
+	KVMTEST EXC_STD, vec ;						\
+	SOFTEN_TEST EXC_STD, vec, bitmask
 
 #define SOFTEN_TEST_HV(vec, bitmask)					\
-	KVMTEST(EXC_HV, vec);						\
-	_SOFTEN_TEST(EXC_HV, vec, bitmask)
+	KVMTEST EXC_HV, vec ;						\
+	SOFTEN_TEST EXC_HV, vec, bitmask
 
 #define KVMTEST_PR(vec)							\
-	KVMTEST(EXC_STD, vec)
+	KVMTEST EXC_STD, vec
 
 #define KVMTEST_HV(vec)							\
-	KVMTEST(EXC_HV, vec)
+	KVMTEST EXC_HV, vec
 
-#define SOFTEN_NOTEST_PR(vec, bitmask)	_SOFTEN_TEST(EXC_STD, vec, bitmask)
-#define SOFTEN_NOTEST_HV(vec, bitmask)	_SOFTEN_TEST(EXC_HV, vec, bitmask)
+#define SOFTEN_NOTEST_PR(vec, bitmask)	SOFTEN_TEST EXC_STD, vec, bitmask
+#define SOFTEN_NOTEST_HV(vec, bitmask)	SOFTEN_TEST EXC_HV, vec, bitmask
 
 #define __MASKABLE_EXCEPTION(vec, label, h, extra, bitmask)		\
 	SET_SCRATCH0(r13);    /* save r13 */				\
 	EXCEPTION_PROLOG_0(PACA_EXGEN);					\
 	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, extra, vec, bitmask);	\
-	EXCEPTION_PROLOG_2(label, h)
+	EXCEPTION_PROLOG_2 label, h
 
 #define MASKABLE_EXCEPTION(vec, label, bitmask)				\
 	__MASKABLE_EXCEPTION(vec, label, EXC_STD, SOFTEN_TEST_PR, bitmask)
 
 #define MASKABLE_EXCEPTION_OOL(vec, label, bitmask)			\
 	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_PR, vec, bitmask);\
-	EXCEPTION_PROLOG_2(label, EXC_STD)
+	EXCEPTION_PROLOG_2 label, EXC_STD
 
 #define MASKABLE_EXCEPTION_HV(vec, label, bitmask)			\
 	__MASKABLE_EXCEPTION(vec, label, EXC_HV, SOFTEN_TEST_HV, bitmask)
 
 #define MASKABLE_EXCEPTION_HV_OOL(vec, label, bitmask)			\
 	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_HV, vec, bitmask);\
-	EXCEPTION_PROLOG_2(label, EXC_HV)
+	EXCEPTION_PROLOG_2 label, EXC_HV
 
 #define __MASKABLE_RELON_EXCEPTION(vec, label, h, extra, bitmask)	\
 	SET_SCRATCH0(r13);    /* save r13 */				\
 	EXCEPTION_PROLOG_0(PACA_EXGEN);					\
 	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, extra, vec, bitmask);	\
-	EXCEPTION_PROLOG_2_RELON(label, h)
+	EXCEPTION_PROLOG_2_RELON label, h
 
 #define MASKABLE_RELON_EXCEPTION(vec, label, bitmask)			\
 	__MASKABLE_RELON_EXCEPTION(vec, label, EXC_STD, SOFTEN_NOTEST_PR, bitmask)
 
 #define MASKABLE_RELON_EXCEPTION_OOL(vec, label, bitmask)		\
 	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_NOTEST_PR, vec, bitmask);\
-	EXCEPTION_PROLOG_2(label, EXC_STD)
+	EXCEPTION_PROLOG_2 label, EXC_STD
 
 #define MASKABLE_RELON_EXCEPTION_HV(vec, label, bitmask)		\
 	__MASKABLE_RELON_EXCEPTION(vec, label, EXC_HV, SOFTEN_TEST_HV, bitmask)
 
 #define MASKABLE_RELON_EXCEPTION_HV_OOL(vec, label, bitmask)		\
 	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_HV, vec, bitmask);\
-	EXCEPTION_PROLOG_2_RELON(label, EXC_HV)
+	EXCEPTION_PROLOG_2_RELON label, EXC_HV
 
 /*
  * Our exception common code can be passed various "additions"
@@ -730,4 +781,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_CAN_NAP)
 #define FINISH_NAP
 #endif
 
+#endif /* __ASSEMBLY__ */
+
 #endif	/* _ASM_POWERPC_EXCEPTION_H */
diff --git a/arch/powerpc/include/asm/head-64.h b/arch/powerpc/include/asm/head-64.h
index e34b3d06bf61..4767d6c7b8fa 100644
--- a/arch/powerpc/include/asm/head-64.h
+++ b/arch/powerpc/include/asm/head-64.h
@@ -387,22 +387,22 @@ end_##sname:
 
 #define TRAMP_KVM(area, n)						\
 	TRAMP_KVM_BEGIN(do_kvm_##n);					\
-	KVM_HANDLER(area, EXC_STD, n);					\
+	KVM_HANDLER area, EXC_STD, n
 
 #define TRAMP_KVM_SKIP(area, n)						\
 	TRAMP_KVM_BEGIN(do_kvm_##n);					\
-	KVM_HANDLER_SKIP(area, EXC_STD, n);				\
+	KVM_HANDLER_SKIP area, EXC_STD, n
 
 /*
  * HV variant exceptions get the 0x2 bit added to their trap number.
  */
 #define TRAMP_KVM_HV(area, n)						\
 	TRAMP_KVM_BEGIN(do_kvm_H##n);					\
-	KVM_HANDLER(area, EXC_HV, n + 0x2);				\
+	KVM_HANDLER area, EXC_HV, n + 0x2
 
 #define TRAMP_KVM_HV_SKIP(area, n)					\
 	TRAMP_KVM_BEGIN(do_kvm_H##n);					\
-	KVM_HANDLER_SKIP(area, EXC_HV, n + 0x2);			\
+	KVM_HANDLER_SKIP area, EXC_HV, n + 0x2
 
 #define EXC_COMMON(name, realvec, hdlr)					\
 	EXC_COMMON_BEGIN(name);						\
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 9e253ce27e08..a50598c295f2 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -341,7 +341,7 @@ machine_check_pSeries_0:
 	 * nested machine check corrupts it. machine_check_common enables
 	 * MSR_RI.
 	 */
-	EXCEPTION_PROLOG_2_NORI(machine_check_common, EXC_STD)
+	EXCEPTION_PROLOG_2_NORI machine_check_common, EXC_STD
 
 TRAMP_KVM_SKIP(PACA_EXMC, 0x200)
 
@@ -974,7 +974,7 @@ TRAMP_KVM_BEGIN(do_kvm_0xc00)
 	SET_SCRATCH0(r10)
 	std	r9,PACA_EXGEN+EX_R9(r13)
 	mfcr	r9
-	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0xc00)
+	KVM_HANDLER PACA_EXGEN, EXC_STD, 0xc00
 #endif
 
 
@@ -1240,7 +1240,7 @@ EXC_REAL_BEGIN(denorm_exception_hv, 0x1500, 0x100)
 #endif
 
 	KVMTEST_HV(0x1500)
-	EXCEPTION_PROLOG_2(denorm_common, EXC_HV)
+	EXCEPTION_PROLOG_2 denorm_common, EXC_HV
 EXC_REAL_END(denorm_exception_hv, 0x1500, 0x100)
 
 #ifdef CONFIG_PPC_DENORMALISATION
@@ -1362,7 +1362,7 @@ EXC_VIRT_NONE(0x5800, 0x100)
 	std	r12,PACA_EXGEN+EX_R12(r13);		\
 	GET_SCRATCH0(r10);				\
 	std	r10,PACA_EXGEN+EX_R13(r13);		\
-	EXCEPTION_PROLOG_2(soft_nmi_common, _H)
+	EXCEPTION_PROLOG_2 soft_nmi_common, _H
 
 /*
  * Branch to soft_nmi_interrupt using the emergency stack. The emergency
@@ -1397,35 +1397,50 @@ EXC_COMMON_BEGIN(soft_nmi_common)
  * - Else it is one of PACA_IRQ_MUST_HARD_MASK, so hard disable and return.
  * This is called with r10 containing the value to OR to the paca field.
  */
-#define MASKED_INTERRUPT(_H)				\
-masked_##_H##interrupt:					\
-	std	r11,PACA_EXGEN+EX_R11(r13);		\
-	lbz	r11,PACAIRQHAPPENED(r13);		\
-	or	r11,r11,r10;				\
-	stb	r11,PACAIRQHAPPENED(r13);		\
-	cmpwi	r10,PACA_IRQ_DEC;			\
-	bne	1f;					\
-	lis	r10,0x7fff;				\
-	ori	r10,r10,0xffff;				\
-	mtspr	SPRN_DEC,r10;				\
-	b	MASKED_DEC_HANDLER_LABEL;		\
-1:	andi.	r10,r10,PACA_IRQ_MUST_HARD_MASK;	\
-	beq	2f;					\
-	mfspr	r10,SPRN_##_H##SRR1;			\
-	xori	r10,r10,MSR_EE; /* clear MSR_EE */	\
-	mtspr	SPRN_##_H##SRR1,r10;			\
-	ori	r11,r11,PACA_IRQ_HARD_DIS;		\
-	stb	r11,PACAIRQHAPPENED(r13);		\
-2:	/* done */					\
-	mtcrf	0x80,r9;				\
-	std	r1,PACAR1(r13);				\
-	ld	r9,PACA_EXGEN+EX_R9(r13);		\
-	ld	r10,PACA_EXGEN+EX_R10(r13);		\
-	ld	r11,PACA_EXGEN+EX_R11(r13);		\
-	/* returns to kernel where r13 must be set up, so don't restore it */ \
-	##_H##RFI_TO_KERNEL;				\
-	b	.;					\
-	MASKED_DEC_HANDLER(_H)
+.macro MASKED_INTERRUPT hsrr
+	.if \hsrr
+masked_Hinterrupt:
+	.else
+masked_interrupt:
+	.endif
+	std	r11,PACA_EXGEN+EX_R11(r13)
+	lbz	r11,PACAIRQHAPPENED(r13)
+	or	r11,r11,r10
+	stb	r11,PACAIRQHAPPENED(r13)
+	cmpwi	r10,PACA_IRQ_DEC
+	bne	1f
+	lis	r10,0x7fff
+	ori	r10,r10,0xffff
+	mtspr	SPRN_DEC,r10
+	b	MASKED_DEC_HANDLER_LABEL
+1:	andi.	r10,r10,PACA_IRQ_MUST_HARD_MASK
+	beq	2f
+	.if \hsrr
+	mfspr	r10,SPRN_HSRR1
+	xori	r10,r10,MSR_EE	/* clear MSR_EE */
+	mtspr	SPRN_HSRR1,r10
+	.else
+	mfspr	r10,SPRN_SRR1
+	xori	r10,r10,MSR_EE	/* clear MSR_EE */
+	mtspr	SPRN_SRR1,r10
+	.endif
+	ori	r11,r11,PACA_IRQ_HARD_DIS
+	stb	r11,PACAIRQHAPPENED(r13)
+2:	/* done */
+	mtcrf	0x80,r9
+	std	r1,PACAR1(r13)
+	ld	r9,PACA_EXGEN+EX_R9(r13)
+	ld	r10,PACA_EXGEN+EX_R10(r13)
+	ld	r11,PACA_EXGEN+EX_R11(r13)
+	/* returns to kernel where r13 must be set up, so don't restore it */
+	.if \hsrr
+	HRFI_TO_KERNEL
+	.else
+	RFI_TO_KERNEL
+	.endif
+	b	.
+	MASKED_DEC_HANDLER(\hsrr\())
+.endm
 
 TRAMP_REAL_BEGIN(stf_barrier_fallback)
 	std	r9,PACA_EXRFI+EX_R9(r13)
@@ -1532,8 +1547,8 @@ TRAMP_REAL_BEGIN(hrfi_flush_fallback)
  * cannot reach these if they are put there.
  */
 USE_FIXED_SECTION(virt_trampolines)
-	MASKED_INTERRUPT()
-	MASKED_INTERRUPT(H)
+	MASKED_INTERRUPT EXC_STD
+	MASKED_INTERRUPT EXC_HV
 
 #ifdef CONFIG_KVM_BOOK3S_64_HANDLER
 TRAMP_REAL_BEGIN(kvmppc_skip_interrupt)
-- 
2.18.0

