Return-Path: <SRS0=Z4Cu=QL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AF6C282C4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 14:51:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2D252087C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 14:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBc5wowY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2D252087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43tVz73X1dzDq5c
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 01:51:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZBc5wowY"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43tVFc4089zDqDD
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 01:19:16 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id y126so1155pfb.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Feb 2019 06:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=nJyyt3qXEhXknG41C1/UjEisewU5CcNM35uYBASzKvI=;
 b=ZBc5wowYCV/XUtLupAiTrMolZWcqLKhHJKklUM7CepnEIVN/r2vXtJYONcr8kU9lR3
 uXQcmDKO2DdAq+NTBggbEfsYd6ytiNn9ANE+ZtyzJuQWPcrGxqO/a+jD38evn5fzUPfU
 JpCuQqHl8/ygrJWN7+XUAk61ofpN2OppIzndrPQa+VnEt/yJjU+7Wtn6U32qYoRli9SU
 JzCZcFb+ZJoZHW03wNACfjaTlHKH8EQxRmwDkblVVooOoivbVdKAJokuxZ4fjx5wg4JF
 /krGxVq4TqmAjLu6kRIaC43lV7eOls94f7WcU7T5bhKE0ZgMcHq4GHxzwjEohR1Ii+Cw
 eg3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=nJyyt3qXEhXknG41C1/UjEisewU5CcNM35uYBASzKvI=;
 b=CTam2armOsbozp5U0Va4zp9E6fnO+0Oz9YS4SNVJhdMEDU6N45mck22u/nVQ5E5cnQ
 tLVitllblumpR+OZL7jdxhmG+LsAsS0QI3Z7wjRCWaint3CfmcYmMD7HVbtjX8xTJixz
 YJWdxpHGs75kfpXbxQSwStiuhMGB8e/Eh7ryNhVB+hBb4tHSYbMUBLjbLTvuJRqWBF5j
 dE2JucQqQdsw4U16eQ2x8JfY+wYRFe316RNoTEboOeFiBl7/WDfRgBprxwiLhf0y1XsZ
 QbbYKym/XH3AbpZnBmyXnTwsG0Uv6m8qx+SaMBS/WJLmILcwbCh4ipwqhHONM/hDYhkI
 dB/w==
X-Gm-Message-State: AJcUukcJCm3tj/RtRjSHyYh7Pzf0MkARkS/bdBNkrqjQkmaltY+5FOyQ
 2thp1yWRt6TUDKSpmKpJUoxhh8x7
X-Google-Smtp-Source: ALg8bN433BOTRxZamx/LQSydZC06NGxKwXL8Zd7UnaiwNPkwxjevL8PkTSU07dUvyj62wNxLK5kqlw==
X-Received: by 2002:a65:41c2:: with SMTP id b2mr46063878pgq.67.1549289954197; 
 Mon, 04 Feb 2019 06:19:14 -0800 (PST)
Received: from roar.local0.net ([210.185.78.69])
 by smtp.gmail.com with ESMTPSA id h9sm226230pgd.53.2019.02.04.06.19.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 04 Feb 2019 06:19:13 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 16/17] powerpc/64s/exception: move exception-64s.h code to
 exception-64s.S where it is used
Date: Tue,  5 Feb 2019 00:18:27 +1000
Message-Id: <20190204141828.13043-17-npiggin@gmail.com>
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

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/exception-64s.h | 429 -----------------------
 arch/powerpc/kernel/exceptions-64s.S     | 429 +++++++++++++++++++++++
 2 files changed, 429 insertions(+), 429 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 3eb8f9a4eac8..d9f48831fbd0 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -149,435 +149,6 @@
 	RFI_FLUSH_SLOT;							\
 	hrfid;								\
 	b	hrfi_flush_fallback
-
-/*
- * We're short on space and time in the exception prolog, so we can't
- * use the normal LOAD_REG_IMMEDIATE macro to load the address of label.
- * Instead we get the base of the kernel from paca->kernelbase and or in the low
- * part of label. This requires that the label be within 64KB of kernelbase, and
- * that kernelbase be 64K aligned.
- */
-#define LOAD_HANDLER(reg, label)					\
-	ld	reg,PACAKBASE(r13);	/* get high part of &label */	\
-	ori	reg,reg,FIXED_SYMBOL_ABS_ADDR(label)
-
-#define __LOAD_HANDLER(reg, label)					\
-	ld	reg,PACAKBASE(r13);					\
-	ori	reg,reg,(ABS_ADDR(label))@l
-
-/*
- * Branches from unrelocated code (e.g., interrupts) to labels outside
- * head-y require >64K offsets.
- */
-#define __LOAD_FAR_HANDLER(reg, label)					\
-	ld	reg,PACAKBASE(r13);					\
-	ori	reg,reg,(ABS_ADDR(label))@l;				\
-	addis	reg,reg,(ABS_ADDR(label))@h
-
-/* Exception register prefixes */
-#define EXC_HV		1
-#define EXC_STD		0
-
-#if defined(CONFIG_RELOCATABLE)
-/*
- * If we support interrupts with relocation on AND we're a relocatable kernel,
- * we need to use CTR to get to the 2nd level handler.  So, save/restore it
- * when required.
- */
-#define SAVE_CTR(reg, area)	mfctr	reg ; 	std	reg,area+EX_CTR(r13)
-#define GET_CTR(reg, area) 			ld	reg,area+EX_CTR(r13)
-#define RESTORE_CTR(reg, area)	ld	reg,area+EX_CTR(r13) ; mtctr reg
-#else
-/* ...else CTR is unused and in register. */
-#define SAVE_CTR(reg, area)
-#define GET_CTR(reg, area) 	mfctr	reg
-#define RESTORE_CTR(reg, area)
-#endif
-
-/*
- * PPR save/restore macros used in exceptions_64s.S  
- * Used for P7 or later processors
- */
-#define SAVE_PPR(area, ra)						\
-BEGIN_FTR_SECTION_NESTED(940)						\
-	ld	ra,area+EX_PPR(r13);	/* Read PPR from paca */	\
-	std	ra,_PPR(r1);						\
-END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,940)
-
-#define RESTORE_PPR_PACA(area, ra)					\
-BEGIN_FTR_SECTION_NESTED(941)						\
-	ld	ra,area+EX_PPR(r13);					\
-	mtspr	SPRN_PPR,ra;						\
-END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,941)
-
-/*
- * Get an SPR into a register if the CPU has the given feature
- */
-#define OPT_GET_SPR(ra, spr, ftr)					\
-BEGIN_FTR_SECTION_NESTED(943)						\
-	mfspr	ra,spr;							\
-END_FTR_SECTION_NESTED(ftr,ftr,943)
-
-/*
- * Set an SPR from a register if the CPU has the given feature
- */
-#define OPT_SET_SPR(ra, spr, ftr)					\
-BEGIN_FTR_SECTION_NESTED(943)						\
-	mtspr	spr,ra;							\
-END_FTR_SECTION_NESTED(ftr,ftr,943)
-
-/*
- * Save a register to the PACA if the CPU has the given feature
- */
-#define OPT_SAVE_REG_TO_PACA(offset, ra, ftr)				\
-BEGIN_FTR_SECTION_NESTED(943)						\
-	std	ra,offset(r13);						\
-END_FTR_SECTION_NESTED(ftr,ftr,943)
-
-.macro EXCEPTION_PROLOG_0 area
-	GET_PACA(r13)
-	std	r9,\area\()+EX_R9(r13)		/* save r9 */
-	OPT_GET_SPR(r9, SPRN_PPR, CPU_FTR_HAS_PPR)
-	HMT_MEDIUM
-	std	r10,\area\()+EX_R10(r13)	/* save r10 - r12 */
-	OPT_GET_SPR(r10, SPRN_CFAR, CPU_FTR_CFAR)
-.endm
-
-.macro EXCEPTION_PROLOG_1 hsrr, area, kvm, vec, bitmask
-	OPT_SAVE_REG_TO_PACA(\area\()+EX_PPR, r9, CPU_FTR_HAS_PPR)
-	OPT_SAVE_REG_TO_PACA(\area\()+EX_CFAR, r10, CPU_FTR_CFAR)
-	INTERRUPT_TO_KERNEL
-	SAVE_CTR(r10, \area\())
-	mfcr	r9
-	.if \kvm
-		KVMTEST \hsrr \vec
-	.endif
-	.if \bitmask
-		lbz	r10,PACAIRQSOFTMASK(r13)
-		andi.	r10,r10,\bitmask
-		/* Associate vector numbers with bits in paca->irq_happened */
-		.if \vec == 0x500 || \vec == 0xea0
-		li	r10,PACA_IRQ_EE
-		.elseif \vec == 0x900 || \vec == 0xea0
-		li	r10,PACA_IRQ_DEC
-		.elseif \vec == 0xa00 || \vec == 0xe80
-		li	r10,PACA_IRQ_DBELL
-		.elseif \vec == 0xe60
-		li	r10,PACA_IRQ_HMI
-		.elseif \vec == 0xf00
-		li	r10,PACA_IRQ_PMI
-		.else
-		.abort "Bad maskable vector"
-		.endif
-
-		.if \hsrr
-		bne	masked_Hinterrupt
-		.else
-		bne	masked_interrupt
-		.endif
-	.endif
-
-	std	r11,\area\()+EX_R11(r13)
-	std	r12,\area\()+EX_R12(r13)
-	GET_SCRATCH0(r10)
-	std	r10,\area\()+EX_R13(r13)
-.endm
-
-.macro EXCEPTION_PROLOG_2_REAL label, hsrr, set_ri
-	ld	r10,PACAKMSR(r13)	/* get MSR value for kernel */
-	.if ! \set_ri
-	xori	r10,r10,MSR_RI		/* Clear MSR_RI */
-	.endif
-	.if \hsrr
-	mfspr	r11,SPRN_HSRR0		/* save HSRR0 */
-	.else
-	mfspr	r11,SPRN_SRR0		/* save SRR0 */
-	.endif
-	LOAD_HANDLER(r12, \label\())
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
-.macro EXCEPTION_PROLOG_2_VIRT label, hsrr
-#ifdef CONFIG_RELOCATABLE
-	.if \hsrr
-	mfspr	r11,SPRN_HSRR0	/* save HSRR0 */
-	.else
-	mfspr	r11,SPRN_SRR0	/* save SRR0 */
-	.endif
-	LOAD_HANDLER(r12, \label\())
-	mtctr	r12
-	.if \hsrr
-	mfspr	r12,SPRN_HSRR1	/* and HSRR1 */
-	.else
-	mfspr	r12,SPRN_SRR1	/* and HSRR1 */
-	.endif
-	li	r10,MSR_RI
-	mtmsrd 	r10,1		/* Set RI (EE=0) */
-	bctr
-#else
-	.if \hsrr
-	mfspr	r11,SPRN_HSRR0		/* save HSRR0 */
-	mfspr	r12,SPRN_HSRR1		/* and HSRR1 */
-	.else
-	mfspr	r11,SPRN_SRR0		/* save SRR0 */
-	mfspr	r12,SPRN_SRR1		/* and SRR1 */
-	.endif
-	li	r10,MSR_RI
-	mtmsrd 	r10,1			/* Set RI (EE=0) */
-	b	label
-#endif
-.endm
-
-/*
- * Branch to label using its 0xC000 address. This results in instruction
- * address suitable for MSR[IR]=0 or 1, which allows relocation to be turned
- * on using mtmsr rather than rfid.
- *
- * This could set the 0xc bits for !RELOCATABLE as an immediate, rather than
- * load KBASE for a slight optimisation.
- */
-#define BRANCH_TO_C000(reg, label)					\
-	__LOAD_HANDLER(reg, label);					\
-	mtctr	reg;							\
-	bctr
-
-#ifdef CONFIG_RELOCATABLE
-#define BRANCH_TO_COMMON(reg, label)					\
-	__LOAD_HANDLER(reg, label);					\
-	mtctr	reg;							\
-	bctr
-
-#define BRANCH_LINK_TO_FAR(label)					\
-	__LOAD_FAR_HANDLER(r12, label);					\
-	mtctr	r12;							\
-	bctrl
-
-#else
-#define BRANCH_TO_COMMON(reg, label)					\
-	b	label
-
-#define BRANCH_LINK_TO_FAR(label)					\
-	bl	label
-#endif
-
-#ifdef CONFIG_KVM_BOOK3S_64_HANDLER
-
-#ifdef CONFIG_RELOCATABLE
-/*
- * KVM requires __LOAD_FAR_HANDLER.
- *
- * __BRANCH_TO_KVM_EXIT branches are also a special case because they
- * explicitly use r9 then reload it from PACA before branching. Hence
- * the double-underscore.
- */
-#define __BRANCH_TO_KVM_EXIT(area, label)				\
-	mfctr	r9;							\
-	std	r9,HSTATE_SCRATCH1(r13);				\
-	__LOAD_FAR_HANDLER(r9, label);					\
-	mtctr	r9;							\
-	ld	r9,area+EX_R9(r13);					\
-	bctr
-
-#else
-#define __BRANCH_TO_KVM_EXIT(area, label)				\
-	ld	r9,area+EX_R9(r13);					\
-	b	label
-#endif
-
-#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
-/*
- * If hv is possible, interrupts come into to the hv version
- * of the kvmppc_interrupt code, which then jumps to the PR handler,
- * kvmppc_interrupt_pr, if the guest is a PR guest.
- */
-#define kvmppc_interrupt kvmppc_interrupt_hv
-#else
-#define kvmppc_interrupt kvmppc_interrupt_pr
-#endif
-
-.macro KVMTEST hsrr, n
-	lbz	r10,HSTATE_IN_GUEST(r13)
-	cmpwi	r10,0
-	.if \hsrr
-	bne	do_kvm_H\n
-	.else
-	bne	do_kvm_\n
-	.endif
-.endm
-
-.macro KVM_HANDLER area, hsrr, n, skip
-	.if \skip
-	cmpwi	r10,KVM_GUEST_MODE_SKIP
-	beq	89f
-	.else
-	BEGIN_FTR_SECTION_NESTED(947)
-	ld	r10,\area+EX_CFAR(r13)
-	std	r10,HSTATE_CFAR(r13)
-	END_FTR_SECTION_NESTED(CPU_FTR_CFAR,CPU_FTR_CFAR,947)
-	.endif
-
-	BEGIN_FTR_SECTION_NESTED(948)
-	ld	r10,\area+EX_PPR(r13)
-	std	r10,HSTATE_PPR(r13)
-	END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,948)
-	ld	r10,\area+EX_R10(r13)
-	std	r12,HSTATE_SCRATCH0(r13)
-	sldi	r12,r9,32
-	/* HSRR variants have the 0x2 bit added to their trap number */
-	.if \hsrr
-	ori	r12,r12,(\n + 0x2)
-	.else
-	ori	r12,r12,(\n)
-	.endif
-	/* This reloads r9 before branching to kvmppc_interrupt */
-	__BRANCH_TO_KVM_EXIT(\area, kvmppc_interrupt)
-
-	.if \skip
-89:	mtocrf	0x80,r9
-	ld	r9,\area+EX_R9(r13)
-	ld	r10,\area+EX_R10(r13)
-	.if \hsrr
-	b	kvmppc_skip_Hinterrupt
-	.else
-	b	kvmppc_skip_interrupt
-	.endif
-	.endif
-.endm
-
-#else
-.macro KVMTEST hsrr, n
-.endm
-.macro KVM_HANDLER area, hsrr, n, skip
-.endm
-#endif
-
-#define EXCEPTION_PROLOG_COMMON_1()					   \
-	std	r9,_CCR(r1);		/* save CR in stackframe	*/ \
-	std	r11,_NIP(r1);		/* save SRR0 in stackframe	*/ \
-	std	r12,_MSR(r1);		/* save SRR1 in stackframe	*/ \
-	std	r10,0(r1);		/* make stack chain pointer	*/ \
-	std	r0,GPR0(r1);		/* save r0 in stackframe	*/ \
-	std	r10,GPR1(r1);		/* save r1 in stackframe	*/ \
-
-
-/*
- * The common exception prolog is used for all except a few exceptions
- * such as a segment miss on a kernel address.  We have to be prepared
- * to take another exception from the point where we first touch the
- * kernel stack onwards.
- *
- * On entry r13 points to the paca, r9-r13 are saved in the paca,
- * r9 contains the saved CR, r11 and r12 contain the saved SRR0 and
- * SRR1, and relocation is on.
- */
-#define EXCEPTION_PROLOG_COMMON(n, area)				   \
-	andi.	r10,r12,MSR_PR;		/* See if coming from user	*/ \
-	mr	r10,r1;			/* Save r1			*/ \
-	subi	r1,r1,INT_FRAME_SIZE;	/* alloc frame on kernel stack	*/ \
-	beq-	1f;							   \
-	ld	r1,PACAKSAVE(r13);	/* kernel stack to use		*/ \
-1:	cmpdi	cr1,r1,-INT_FRAME_SIZE;	/* check if r1 is in userspace	*/ \
-	blt+	cr1,3f;			/* abort if it is		*/ \
-	li	r1,(n);			/* will be reloaded later	*/ \
-	sth	r1,PACA_TRAP_SAVE(r13);					   \
-	std	r3,area+EX_R3(r13);					   \
-	addi	r3,r13,area;		/* r3 -> where regs are saved*/	   \
-	RESTORE_CTR(r1, area);						   \
-	b	bad_stack;						   \
-3:	EXCEPTION_PROLOG_COMMON_1();					   \
-	beq	4f;			/* if from kernel mode		*/ \
-	ACCOUNT_CPU_USER_ENTRY(r13, r9, r10);				   \
-	SAVE_PPR(area, r9);						   \
-4:	EXCEPTION_PROLOG_COMMON_2(area)					   \
-	EXCEPTION_PROLOG_COMMON_3(n)					   \
-	ACCOUNT_STOLEN_TIME
-
-/* Save original regs values from save area to stack frame. */
-#define EXCEPTION_PROLOG_COMMON_2(area)					   \
-	ld	r9,area+EX_R9(r13);	/* move r9, r10 to stackframe	*/ \
-	ld	r10,area+EX_R10(r13);					   \
-	std	r9,GPR9(r1);						   \
-	std	r10,GPR10(r1);						   \
-	ld	r9,area+EX_R11(r13);	/* move r11 - r13 to stackframe	*/ \
-	ld	r10,area+EX_R12(r13);					   \
-	ld	r11,area+EX_R13(r13);					   \
-	std	r9,GPR11(r1);						   \
-	std	r10,GPR12(r1);						   \
-	std	r11,GPR13(r1);						   \
-	BEGIN_FTR_SECTION_NESTED(66);					   \
-	ld	r10,area+EX_CFAR(r13);					   \
-	std	r10,ORIG_GPR3(r1);					   \
-	END_FTR_SECTION_NESTED(CPU_FTR_CFAR, CPU_FTR_CFAR, 66);		   \
-	GET_CTR(r10, area);						   \
-	std	r10,_CTR(r1);
-
-#define EXCEPTION_PROLOG_COMMON_3(n)					   \
-	std	r2,GPR2(r1);		/* save r2 in stackframe	*/ \
-	SAVE_4GPRS(3, r1);		/* save r3 - r6 in stackframe   */ \
-	SAVE_2GPRS(7, r1);		/* save r7, r8 in stackframe	*/ \
-	mflr	r9;			/* Get LR, later save to stack	*/ \
-	ld	r2,PACATOC(r13);	/* get kernel TOC into r2	*/ \
-	std	r9,_LINK(r1);						   \
-	lbz	r10,PACAIRQSOFTMASK(r13);				   \
-	mfspr	r11,SPRN_XER;		/* save XER in stackframe	*/ \
-	std	r10,SOFTE(r1);						   \
-	std	r11,_XER(r1);						   \
-	li	r9,(n)+1;						   \
-	std	r9,_TRAP(r1);		/* set trap number		*/ \
-	li	r10,0;							   \
-	ld	r11,exception_marker@toc(r2);				   \
-	std	r10,RESULT(r1);		/* clear regs->result		*/ \
-	std	r11,STACK_FRAME_OVERHEAD-16(r1); /* mark the frame	*/
-
-#define RUNLATCH_ON				\
-BEGIN_FTR_SECTION				\
-	CURRENT_THREAD_INFO(r3, r1);		\
-	ld	r4,TI_LOCAL_FLAGS(r3);		\
-	andi.	r0,r4,_TLF_RUNLATCH;		\
-	beql	ppc64_runlatch_on_trampoline;	\
-END_FTR_SECTION_IFSET(CPU_FTR_CTRL)
-
-#define EXCEPTION_COMMON(area, trap)				\
-	EXCEPTION_PROLOG_COMMON(trap, area);			\
-
-/*
- * Exception where stack is already set in r1, r1 is saved in r10
- */
-#define EXCEPTION_COMMON_STACK(area, trap)			\
-	EXCEPTION_PROLOG_COMMON_1();				\
-	EXCEPTION_PROLOG_COMMON_2(area);			\
-	EXCEPTION_PROLOG_COMMON_3(trap)
-
-/*
- * When the idle code in power4_idle puts the CPU into NAP mode,
- * it has to do so in a loop, and relies on the external interrupt
- * and decrementer interrupt entry code to get it out of the loop.
- * It sets the _TLF_NAPPING bit in current_thread_info()->local_flags
- * to signal that it is in the loop and needs help to get out.
- */
-#ifdef CONFIG_PPC_970_NAP
-#define FINISH_NAP				\
-BEGIN_FTR_SECTION				\
-	CURRENT_THREAD_INFO(r11, r1);		\
-	ld	r9,TI_LOCAL_FLAGS(r11);		\
-	andi.	r10,r9,_TLF_NAPPING;		\
-	bnel	power4_fixup_nap;		\
-END_FTR_SECTION_IFSET(CPU_FTR_CAN_NAP)
-#else
-#define FINISH_NAP
-#endif
-
 #endif /* __ASSEMBLY__ */
 
 #endif	/* _ASM_POWERPC_EXCEPTION_H */
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 06eade08ff29..8d19afa09776 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -20,6 +20,435 @@
 #include <asm/head-64.h>
 #include <asm/feature-fixups.h>
 
+/*
+ * We're short on space and time in the exception prolog, so we can't
+ * use the normal LOAD_REG_IMMEDIATE macro to load the address of label.
+ * Instead we get the base of the kernel from paca->kernelbase and or in the low
+ * part of label. This requires that the label be within 64KB of kernelbase, and
+ * that kernelbase be 64K aligned.
+ */
+#define LOAD_HANDLER(reg, label)					\
+	ld	reg,PACAKBASE(r13);	/* get high part of &label */	\
+	ori	reg,reg,FIXED_SYMBOL_ABS_ADDR(label)
+
+#define __LOAD_HANDLER(reg, label)					\
+	ld	reg,PACAKBASE(r13);					\
+	ori	reg,reg,(ABS_ADDR(label))@l
+
+/*
+ * Branches from unrelocated code (e.g., interrupts) to labels outside
+ * head-y require >64K offsets.
+ */
+#define __LOAD_FAR_HANDLER(reg, label)					\
+	ld	reg,PACAKBASE(r13);					\
+	ori	reg,reg,(ABS_ADDR(label))@l;				\
+	addis	reg,reg,(ABS_ADDR(label))@h
+
+/*
+ * Branch to label using its 0xC000 address. This results in instruction
+ * address suitable for MSR[IR]=0 or 1, which allows relocation to be turned
+ * on using mtmsr rather than rfid.
+ *
+ * This could set the 0xc bits for !RELOCATABLE as an immediate, rather than
+ * load KBASE for a slight optimisation.
+ */
+#define BRANCH_TO_C000(reg, label)					\
+	__LOAD_HANDLER(reg, label);					\
+	mtctr	reg;							\
+	bctr
+
+#ifdef CONFIG_RELOCATABLE
+#define BRANCH_TO_COMMON(reg, label)					\
+	__LOAD_HANDLER(reg, label);					\
+	mtctr	reg;							\
+	bctr
+
+#define BRANCH_LINK_TO_FAR(label)					\
+	__LOAD_FAR_HANDLER(r12, label);					\
+	mtctr	r12;							\
+	bctrl
+
+#else
+#define BRANCH_TO_COMMON(reg, label)					\
+	b	label
+
+#define BRANCH_LINK_TO_FAR(label)					\
+	bl	label
+#endif
+
+/* Exception register prefixes */
+#define EXC_HV		1
+#define EXC_STD		0
+
+#if defined(CONFIG_RELOCATABLE)
+/*
+ * If we support interrupts with relocation on AND we're a relocatable kernel,
+ * we need to use CTR to get to the 2nd level handler.  So, save/restore it
+ * when required.
+ */
+#define SAVE_CTR(reg, area)	mfctr	reg ; 	std	reg,area+EX_CTR(r13)
+#define GET_CTR(reg, area) 			ld	reg,area+EX_CTR(r13)
+#define RESTORE_CTR(reg, area)	ld	reg,area+EX_CTR(r13) ; mtctr reg
+#else
+/* ...else CTR is unused and in register. */
+#define SAVE_CTR(reg, area)
+#define GET_CTR(reg, area) 	mfctr	reg
+#define RESTORE_CTR(reg, area)
+#endif
+
+/*
+ * PPR save/restore macros used in exceptions_64s.S
+ * Used for P7 or later processors
+ */
+#define SAVE_PPR(area, ra)						\
+BEGIN_FTR_SECTION_NESTED(940)						\
+	ld	ra,area+EX_PPR(r13);	/* Read PPR from paca */	\
+	std	ra,_PPR(r1);						\
+END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,940)
+
+#define RESTORE_PPR_PACA(area, ra)					\
+BEGIN_FTR_SECTION_NESTED(941)						\
+	ld	ra,area+EX_PPR(r13);					\
+	mtspr	SPRN_PPR,ra;						\
+END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,941)
+
+/*
+ * Get an SPR into a register if the CPU has the given feature
+ */
+#define OPT_GET_SPR(ra, spr, ftr)					\
+BEGIN_FTR_SECTION_NESTED(943)						\
+	mfspr	ra,spr;							\
+END_FTR_SECTION_NESTED(ftr,ftr,943)
+
+/*
+ * Set an SPR from a register if the CPU has the given feature
+ */
+#define OPT_SET_SPR(ra, spr, ftr)					\
+BEGIN_FTR_SECTION_NESTED(943)						\
+	mtspr	spr,ra;							\
+END_FTR_SECTION_NESTED(ftr,ftr,943)
+
+/*
+ * Save a register to the PACA if the CPU has the given feature
+ */
+#define OPT_SAVE_REG_TO_PACA(offset, ra, ftr)				\
+BEGIN_FTR_SECTION_NESTED(943)						\
+	std	ra,offset(r13);						\
+END_FTR_SECTION_NESTED(ftr,ftr,943)
+
+.macro EXCEPTION_PROLOG_0 area
+	GET_PACA(r13)
+	std	r9,\area\()+EX_R9(r13)		/* save r9 */
+	OPT_GET_SPR(r9, SPRN_PPR, CPU_FTR_HAS_PPR)
+	HMT_MEDIUM
+	std	r10,\area\()+EX_R10(r13)	/* save r10 - r12 */
+	OPT_GET_SPR(r10, SPRN_CFAR, CPU_FTR_CFAR)
+.endm
+
+.macro EXCEPTION_PROLOG_1 hsrr, area, kvm, vec, bitmask
+	OPT_SAVE_REG_TO_PACA(\area\()+EX_PPR, r9, CPU_FTR_HAS_PPR)
+	OPT_SAVE_REG_TO_PACA(\area\()+EX_CFAR, r10, CPU_FTR_CFAR)
+	INTERRUPT_TO_KERNEL
+	SAVE_CTR(r10, \area\())
+	mfcr	r9
+	.if \kvm
+		KVMTEST \hsrr \vec
+	.endif
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
+	.endif
+
+	std	r11,\area\()+EX_R11(r13)
+	std	r12,\area\()+EX_R12(r13)
+	GET_SCRATCH0(r10)
+	std	r10,\area\()+EX_R13(r13)
+.endm
+
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
+#ifdef CONFIG_RELOCATABLE
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
+#else
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
+#endif
+.endm
+
+#ifdef CONFIG_KVM_BOOK3S_64_HANDLER
+
+#ifdef CONFIG_RELOCATABLE
+/*
+ * KVM requires __LOAD_FAR_HANDLER.
+ *
+ * __BRANCH_TO_KVM_EXIT branches are also a special case because they
+ * explicitly use r9 then reload it from PACA before branching. Hence
+ * the double-underscore.
+ */
+#define __BRANCH_TO_KVM_EXIT(area, label)				\
+	mfctr	r9;							\
+	std	r9,HSTATE_SCRATCH1(r13);				\
+	__LOAD_FAR_HANDLER(r9, label);					\
+	mtctr	r9;							\
+	ld	r9,area+EX_R9(r13);					\
+	bctr
+
+#else
+#define __BRANCH_TO_KVM_EXIT(area, label)				\
+	ld	r9,area+EX_R9(r13);					\
+	b	label
+#endif
+
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+/*
+ * If hv is possible, interrupts come into to the hv version
+ * of the kvmppc_interrupt code, which then jumps to the PR handler,
+ * kvmppc_interrupt_pr, if the guest is a PR guest.
+ */
+#define kvmppc_interrupt kvmppc_interrupt_hv
+#else
+#define kvmppc_interrupt kvmppc_interrupt_pr
+#endif
+
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
+.macro KVM_HANDLER area, hsrr, n, skip
+	.if \skip
+	cmpwi	r10,KVM_GUEST_MODE_SKIP
+	beq	89f
+	.else
+	BEGIN_FTR_SECTION_NESTED(947)
+	ld	r10,\area+EX_CFAR(r13)
+	std	r10,HSTATE_CFAR(r13)
+	END_FTR_SECTION_NESTED(CPU_FTR_CFAR,CPU_FTR_CFAR,947)
+	.endif
+
+	BEGIN_FTR_SECTION_NESTED(948)
+	ld	r10,\area+EX_PPR(r13)
+	std	r10,HSTATE_PPR(r13)
+	END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,948)
+	ld	r10,\area+EX_R10(r13)
+	std	r12,HSTATE_SCRATCH0(r13)
+	sldi	r12,r9,32
+	/* HSRR variants have the 0x2 bit added to their trap number */
+	.if \hsrr
+	ori	r12,r12,(\n + 0x2)
+	.else
+	ori	r12,r12,(\n)
+	.endif
+	/* This reloads r9 before branching to kvmppc_interrupt */
+	__BRANCH_TO_KVM_EXIT(\area, kvmppc_interrupt)
+
+	.if \skip
+89:	mtocrf	0x80,r9
+	ld	r9,\area+EX_R9(r13)
+	ld	r10,\area+EX_R10(r13)
+	.if \hsrr
+	b	kvmppc_skip_Hinterrupt
+	.else
+	b	kvmppc_skip_interrupt
+	.endif
+	.endif
+.endm
+
+#else
+.macro KVMTEST hsrr, n
+.endm
+.macro KVM_HANDLER area, hsrr, n, skip
+.endm
+#endif
+
+#define EXCEPTION_PROLOG_COMMON_1()					   \
+	std	r9,_CCR(r1);		/* save CR in stackframe	*/ \
+	std	r11,_NIP(r1);		/* save SRR0 in stackframe	*/ \
+	std	r12,_MSR(r1);		/* save SRR1 in stackframe	*/ \
+	std	r10,0(r1);		/* make stack chain pointer	*/ \
+	std	r0,GPR0(r1);		/* save r0 in stackframe	*/ \
+	std	r10,GPR1(r1);		/* save r1 in stackframe	*/ \
+
+
+/*
+ * The common exception prolog is used for all except a few exceptions
+ * such as a segment miss on a kernel address.  We have to be prepared
+ * to take another exception from the point where we first touch the
+ * kernel stack onwards.
+ *
+ * On entry r13 points to the paca, r9-r13 are saved in the paca,
+ * r9 contains the saved CR, r11 and r12 contain the saved SRR0 and
+ * SRR1, and relocation is on.
+ */
+#define EXCEPTION_PROLOG_COMMON(n, area)				   \
+	andi.	r10,r12,MSR_PR;		/* See if coming from user	*/ \
+	mr	r10,r1;			/* Save r1			*/ \
+	subi	r1,r1,INT_FRAME_SIZE;	/* alloc frame on kernel stack	*/ \
+	beq-	1f;							   \
+	ld	r1,PACAKSAVE(r13);	/* kernel stack to use		*/ \
+1:	cmpdi	cr1,r1,-INT_FRAME_SIZE;	/* check if r1 is in userspace	*/ \
+	blt+	cr1,3f;			/* abort if it is		*/ \
+	li	r1,(n);			/* will be reloaded later	*/ \
+	sth	r1,PACA_TRAP_SAVE(r13);					   \
+	std	r3,area+EX_R3(r13);					   \
+	addi	r3,r13,area;		/* r3 -> where regs are saved*/	   \
+	RESTORE_CTR(r1, area);						   \
+	b	bad_stack;						   \
+3:	EXCEPTION_PROLOG_COMMON_1();					   \
+	beq	4f;			/* if from kernel mode		*/ \
+	ACCOUNT_CPU_USER_ENTRY(r13, r9, r10);				   \
+	SAVE_PPR(area, r9);						   \
+4:	EXCEPTION_PROLOG_COMMON_2(area)					   \
+	EXCEPTION_PROLOG_COMMON_3(n)					   \
+	ACCOUNT_STOLEN_TIME
+
+/* Save original regs values from save area to stack frame. */
+#define EXCEPTION_PROLOG_COMMON_2(area)					   \
+	ld	r9,area+EX_R9(r13);	/* move r9, r10 to stackframe	*/ \
+	ld	r10,area+EX_R10(r13);					   \
+	std	r9,GPR9(r1);						   \
+	std	r10,GPR10(r1);						   \
+	ld	r9,area+EX_R11(r13);	/* move r11 - r13 to stackframe	*/ \
+	ld	r10,area+EX_R12(r13);					   \
+	ld	r11,area+EX_R13(r13);					   \
+	std	r9,GPR11(r1);						   \
+	std	r10,GPR12(r1);						   \
+	std	r11,GPR13(r1);						   \
+	BEGIN_FTR_SECTION_NESTED(66);					   \
+	ld	r10,area+EX_CFAR(r13);					   \
+	std	r10,ORIG_GPR3(r1);					   \
+	END_FTR_SECTION_NESTED(CPU_FTR_CFAR, CPU_FTR_CFAR, 66);		   \
+	GET_CTR(r10, area);						   \
+	std	r10,_CTR(r1);
+
+#define EXCEPTION_PROLOG_COMMON_3(n)					   \
+	std	r2,GPR2(r1);		/* save r2 in stackframe	*/ \
+	SAVE_4GPRS(3, r1);		/* save r3 - r6 in stackframe   */ \
+	SAVE_2GPRS(7, r1);		/* save r7, r8 in stackframe	*/ \
+	mflr	r9;			/* Get LR, later save to stack	*/ \
+	ld	r2,PACATOC(r13);	/* get kernel TOC into r2	*/ \
+	std	r9,_LINK(r1);						   \
+	lbz	r10,PACAIRQSOFTMASK(r13);				   \
+	mfspr	r11,SPRN_XER;		/* save XER in stackframe	*/ \
+	std	r10,SOFTE(r1);						   \
+	std	r11,_XER(r1);						   \
+	li	r9,(n)+1;						   \
+	std	r9,_TRAP(r1);		/* set trap number		*/ \
+	li	r10,0;							   \
+	ld	r11,exception_marker@toc(r2);				   \
+	std	r10,RESULT(r1);		/* clear regs->result		*/ \
+	std	r11,STACK_FRAME_OVERHEAD-16(r1); /* mark the frame	*/
+
+#define EXCEPTION_COMMON(area, trap)				\
+	EXCEPTION_PROLOG_COMMON(trap, area);			\
+
+/*
+ * Exception where stack is already set in r1, r1 is saved in r10
+ */
+#define EXCEPTION_COMMON_STACK(area, trap)			\
+	EXCEPTION_PROLOG_COMMON_1();				\
+	EXCEPTION_PROLOG_COMMON_2(area);			\
+	EXCEPTION_PROLOG_COMMON_3(trap)
+
+#define RUNLATCH_ON				\
+BEGIN_FTR_SECTION				\
+	CURRENT_THREAD_INFO(r3, r1);		\
+	ld	r4,TI_LOCAL_FLAGS(r3);		\
+	andi.	r0,r4,_TLF_RUNLATCH;		\
+	beql	ppc64_runlatch_on_trampoline;	\
+END_FTR_SECTION_IFSET(CPU_FTR_CTRL)
+
+/*
+ * When the idle code in power4_idle puts the CPU into NAP mode,
+ * it has to do so in a loop, and relies on the external interrupt
+ * and decrementer interrupt entry code to get it out of the loop.
+ * It sets the _TLF_NAPPING bit in current_thread_info()->local_flags
+ * to signal that it is in the loop and needs help to get out.
+ */
+#ifdef CONFIG_PPC_970_NAP
+#define FINISH_NAP				\
+BEGIN_FTR_SECTION				\
+	CURRENT_THREAD_INFO(r11, r1);		\
+	ld	r9,TI_LOCAL_FLAGS(r11);		\
+	andi.	r10,r9,_TLF_NAPPING;		\
+	bnel	power4_fixup_nap;		\
+END_FTR_SECTION_IFSET(CPU_FTR_CAN_NAP)
+#else
+#define FINISH_NAP
+#endif
+
+
 /*
  * There are a few constraints to be concerned with.
  * - Real mode exceptions code/data must be located at their physical location.
-- 
2.18.0

