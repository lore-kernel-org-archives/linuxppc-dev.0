Return-Path: <SRS0=xfkn=QI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0043C169C4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Feb 2019 01:40:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B6FF20869
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Feb 2019 01:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bvgnrj1s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B6FF20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43rKYW2FSJzDqg8
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Feb 2019 12:40:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Bvgnrj1s"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43rKWc0tN3zDqWq
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Feb 2019 12:38:51 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id gn14so2335355plb.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2019 17:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=CDWZ1XPjtySLKTRFaATzHNO+4J2Hus8LAbLgADuOQDU=;
 b=Bvgnrj1s6T7f6khR/0+Ht/41EmK87zoyh/qYrivBXsSsHsxYfFWA1+CutWBWFecCBk
 SfKHBdmZA26zudao9zPLY4kN9wCSNKfpJKPym1MRPh+NdSpwz7iTXGuaEMm71qsFGHtd
 p6f1Hh8nhMc2ZAT+a84ZZaddyv8CpKFojKKauT91+wquYKrfZuG87Ycr0zqxTbE8WVp5
 F9VInG5cPl8cnv55PP4X909FvhPmXhDzWbXpF2oqv4+4kQyuTSWcvI3hxJxsyzOZ9Z07
 AD/czREeCANV1dUwuYQpRT6eyZksAe5vp/khJ4IGWk6ueBpO75l5CgZWrgAG1XgpmRrm
 hiyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=CDWZ1XPjtySLKTRFaATzHNO+4J2Hus8LAbLgADuOQDU=;
 b=gf7GVXUx5gHSSAaph8xgbjCPb4B8QhnhotQ0RKhrLZ1RGvLl6WJrIwVCUHiGvIbUwg
 MzMpuXy+kvk0aFf8tc0lJgfUBh3eggYsWiaBhA4NZ7WEu6LuoFelYXEOK9vgb06Sh7IV
 +WH5wxee4Iz5iVhyCh7qoGyjG0CpY5uCqjG9BkSaL6KtyK93W/61YmybKh7Lu467UhO2
 e3rjWGEMrNe3Cl+ytmbF7vwD2EjWDe5kHNte7ItI52rZ6x4siH4UaqyFa6tF0xYyLnQu
 pmguDy2tAYCZ1OfyvZSBZCrVnUgNMXYAjoQjIjPqC0nNotjE7l9Y5TjA7+tGSKGLt8b7
 k4Ng==
X-Gm-Message-State: AJcUukcGs63yz9NbQc3UvbdHhAeTVcgG8hSPjzDEqq0VIt5byefDGvAu
 RD2mKSTpTSMIEnYZaHYUfE2kJ92U
X-Google-Smtp-Source: ALg8bN4K7cofvWqB7agrS9zz6++w8nIAnNRv6DzIIUQzbTGG4lZ8N8z5Tyej/yN3K0y6WAOdjq/sIQ==
X-Received: by 2002:a17:902:765:: with SMTP id
 92mr37342719pli.242.1548985128055; 
 Thu, 31 Jan 2019 17:38:48 -0800 (PST)
Received: from roar.local0.net (193-116-119-184.tpgi.com.au. [193.116.119.184])
 by smtp.gmail.com with ESMTPSA id h19sm7323610pfn.114.2019.01.31.17.38.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 31 Jan 2019 17:38:46 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH RFC v2] powerpc/64s: rewriting interrupt entry code
Date: Fri,  1 Feb 2019 11:37:15 +1000
Message-Id: <20190201013715.27216-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.18.0
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

Finally got around to making this more or less work. I didn't quite
know where it would end up, so I haven't got patches in clean pieces
yet. But for this RFC I would rather consider the end result from a
higher level (mainly of kernel/exceptions-64s.S new style of macros).

There are two motivations for this. First of all removing some of the
CPP spaghetti of nested macros and macro parameters that themseves are
passed other defines and things. It's totally non-linear and several
levels of indirection to work out what is going on or how to change
anything in 64s.h.

Improving this is done by instead using gas .macros. These have two
really nice properties that you can't do with CPP: first is that you
can conditionally expand parts of them based on expressions; second is
that you can modify parts of them using CPP. Oh also another one --
they do not have to all be put onto one line and separated with ';'!
Nice.

[ Not sure I like asm with indentations but maybe not used to it.
  Might change that back to flat because there is not _too_ much
  nesting. ]

Anyway, it sounds wonderful, but the reality is there's still some
twisty code when you actually implment everything. Some non-linear
indirections I've put in are "additions" for masked handlers (e.g.,
mask EE for some, branch to soft-NMI watchdog for others), and one
to be able to override the stack.

Other than those, it's quite linear albeit complex, you can step
through the macros to see what code will come out.

Generated code is very different too for hopefully some good reasons.
Mostly ignore that for now. I kind of didn't know how the macros
would turn out without implementing the code changes I wanted, but
I'll go back and try to do at least some bits incrementally.

One significant and not so nice thing is that registers are not in
the same place between different handlers. SRR0 may be in r18 in
one handler, and r19 in another. The reason for this is that different
handlers want to load different variety of registers initially, but
I want to save off scratch registers in contiguous ranges to allow
coalesing in the store queue. Interrupt entry has a lot of stores
to save regs, and then it'll go and call something with a spinlock
or atomic_add_unless and have to wait for them.

So symbolic registers are assigned a number for each interrupt when
they are defined. It's a bit ugly so I'm thinking about it. The other
option to keep this optimization is to instead store registers to
different locations in the scratch save area (so SRR0 would always be
r18, but r18 may be saved at EXGEN+32 or EXGEN+40), although that is
a lot more ugliness to do the saving and still frustrates code
sharing, but it may give a nicer result.

Thanks,
Nick
---
 include/asm/exception-64s.h |  622 -------
 include/asm/hw_irq.h        |   93 -
 include/asm/ppc_asm.h       |   14 
 include/asm/ptrace.h        |    3 
 kernel/dbell.c              |    3 
 kernel/entry_64.S           |    6 
 kernel/exceptions-64s.S     | 3622 ++++++++++++++++++++++++++++++++++----------
 kernel/irq.c                |   18 
 kernel/time.c               |   66 
 kernel/traps.c              |   17 
 mm/fault.c                  |   10 
 perf/core-book3s.c          |   13 
 12 files changed, 2997 insertions(+), 1490 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 3b4767ed3ec5..4be71c2504fc 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -24,48 +24,18 @@
  *  as published by the Free Software Foundation; either version
  *  2 of the License, or (at your option) any later version.
  */
-/*
- * The following macros define the code that appears as
- * the prologue to each of the exception handlers.  They
- * are split into two parts to allow a single kernel binary
- * to be used for pSeries and iSeries.
- *
- * We make as much of the exception code common between native
- * exception handlers (including pSeries LPAR) and iSeries LPAR
- * implementations as possible.
- */
-#include <asm/head-64.h>
-#include <asm/feature-fixups.h>
 
-/* PACA save area offsets (exgen, exmc, etc) */
-#define EX_R9		0
-#define EX_R10		8
-#define EX_R11		16
-#define EX_R12		24
-#define EX_R13		32
-#define EX_DAR		40
-#define EX_DSISR	48
-#define EX_CCR		52
-#define EX_CFAR		56
-#define EX_PPR		64
-#if defined(CONFIG_RELOCATABLE)
-#define EX_CTR		72
-#define EX_SIZE		10	/* size in u64 units */
-#else
-#define EX_SIZE		9	/* size in u64 units */
-#endif
+#include <asm/head-64.h>
 
 /*
- * maximum recursive depth of MCE exceptions
+ * Size of register save areas in paca
  */
-#define MAX_MCE_DEPTH	4
+#define EX_SIZE		12
 
 /*
- * EX_R3 is only used by the bad_stack handler. bad_stack reloads and
- * saves DAR from SPRN_DAR, and EX_DAR is not used. So EX_R3 can overlap
- * with EX_DAR.
+ * maximum recursive depth of MCE exceptions
  */
-#define EX_R3		EX_DAR
+#define MAX_MCE_DEPTH	4
 
 #define STF_ENTRY_BARRIER_SLOT						\
 	STF_ENTRY_BARRIER_FIXUP_SECTION;				\
@@ -148,586 +118,4 @@
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
-/*
- * We're short on space and time in the exception prolog, so we can't
- * use the normal LOAD_REG_IMMEDIATE macro to load the address of label.
- * Instead we get the base of the kernel from paca->kernelbase and or in the low
- * part of label. This requires that the label be within 64KB of kernelbase, and
- * that kernelbase be 64K aligned.
- */
-#define LOAD_HANDLER(reg, label)					\
-	ld	reg,PACAKBASE(r13);	/* get high part of &label */	\
-	ori	reg,reg,FIXED_SYMBOL_ABS_ADDR(label);
-
-#define __LOAD_HANDLER(reg, label)					\
-	ld	reg,PACAKBASE(r13);					\
-	ori	reg,reg,(ABS_ADDR(label))@l;
-
-/*
- * Branches from unrelocated code (e.g., interrupts) to labels outside
- * head-y require >64K offsets.
- */
-#define __LOAD_FAR_HANDLER(reg, label)					\
-	ld	reg,PACAKBASE(r13);					\
-	ori	reg,reg,(ABS_ADDR(label))@l;				\
-	addis	reg,reg,(ABS_ADDR(label))@h;
-
-/* Exception register prefixes */
-#define EXC_HV	H
-#define EXC_STD
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
-#define EXCEPTION_PROLOG_0(area)					\
-	GET_PACA(r13);							\
-	std	r9,area+EX_R9(r13);	/* save r9 */			\
-	OPT_GET_SPR(r9, SPRN_PPR, CPU_FTR_HAS_PPR);			\
-	HMT_MEDIUM;							\
-	std	r10,area+EX_R10(r13);	/* save r10 - r12 */		\
-	OPT_GET_SPR(r10, SPRN_CFAR, CPU_FTR_CFAR)
-
-#define __EXCEPTION_PROLOG_1_PRE(area)					\
-	OPT_SAVE_REG_TO_PACA(area+EX_PPR, r9, CPU_FTR_HAS_PPR);		\
-	OPT_SAVE_REG_TO_PACA(area+EX_CFAR, r10, CPU_FTR_CFAR);		\
-	INTERRUPT_TO_KERNEL;						\
-	SAVE_CTR(r10, area);						\
-	mfcr	r9;
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
- * checking of the interrupt maskable level in the SOFTEN_TEST.
- * Intended to be used in MASKABLE_EXCPETION_* macros.
- */
-#define MASKABLE_EXCEPTION_PROLOG_1(area, extra, vec, bitmask)			\
-	__EXCEPTION_PROLOG_1_PRE(area);					\
-	extra(vec, bitmask);						\
-	__EXCEPTION_PROLOG_1_POST(area);
-
-/*
- * This version of the EXCEPTION_PROLOG_1 is intended
- * to be used in STD_EXCEPTION* macros
- */
-#define _EXCEPTION_PROLOG_1(area, extra, vec)				\
-	__EXCEPTION_PROLOG_1_PRE(area);					\
-	extra(vec);							\
-	__EXCEPTION_PROLOG_1_POST(area);
-
-#define EXCEPTION_PROLOG_1(area, extra, vec)				\
-	_EXCEPTION_PROLOG_1(area, extra, vec)
-
-#define __EXCEPTION_PROLOG_2(label, h)					\
-	ld	r10,PACAKMSR(r13);	/* get MSR value for kernel */	\
-	mfspr	r11,SPRN_##h##SRR0;	/* save SRR0 */			\
-	LOAD_HANDLER(r12,label)						\
-	mtspr	SPRN_##h##SRR0,r12;					\
-	mfspr	r12,SPRN_##h##SRR1;	/* and SRR1 */			\
-	mtspr	SPRN_##h##SRR1,r10;					\
-	h##RFI_TO_KERNEL;						\
-	b	.	/* prevent speculative execution */
-#define EXCEPTION_PROLOG_2(label, h)					\
-	__EXCEPTION_PROLOG_2(label, h)
-
-/* _NORI variant keeps MSR_RI clear */
-#define __EXCEPTION_PROLOG_2_NORI(label, h)				\
-	ld	r10,PACAKMSR(r13);	/* get MSR value for kernel */	\
-	xori	r10,r10,MSR_RI;		/* Clear MSR_RI */		\
-	mfspr	r11,SPRN_##h##SRR0;	/* save SRR0 */			\
-	LOAD_HANDLER(r12,label)						\
-	mtspr	SPRN_##h##SRR0,r12;					\
-	mfspr	r12,SPRN_##h##SRR1;	/* and SRR1 */			\
-	mtspr	SPRN_##h##SRR1,r10;					\
-	h##RFI_TO_KERNEL;						\
-	b	.	/* prevent speculative execution */
-
-#define EXCEPTION_PROLOG_2_NORI(label, h)				\
-	__EXCEPTION_PROLOG_2_NORI(label, h)
-
-#define EXCEPTION_PROLOG(area, label, h, extra, vec)			\
-	SET_SCRATCH0(r13);		/* save r13 */			\
-	EXCEPTION_PROLOG_0(area);					\
-	EXCEPTION_PROLOG_1(area, extra, vec);				\
-	EXCEPTION_PROLOG_2(label, h);
-
-#define __KVMTEST(h, n)							\
-	lbz	r10,HSTATE_IN_GUEST(r13);				\
-	cmpwi	r10,0;							\
-	bne	do_kvm_##h##n
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
-#define BRANCH_TO_COMMON(reg, label)					\
-	b	label
-
-#define BRANCH_LINK_TO_FAR(label)					\
-	bl	label
-
-#define __BRANCH_TO_KVM_EXIT(area, label)				\
-	ld	r9,area+EX_R9(r13);					\
-	b	label
-
-#endif
-
-/* Do not enable RI */
-#define EXCEPTION_PROLOG_NORI(area, label, h, extra, vec)		\
-	EXCEPTION_PROLOG_0(area);					\
-	EXCEPTION_PROLOG_1(area, extra, vec);				\
-	EXCEPTION_PROLOG_2_NORI(label, h);
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
-
-#ifdef CONFIG_KVM_BOOK3S_64_HANDLER
-#define KVMTEST(h, n)			__KVMTEST(h, n)
-#define KVM_HANDLER(area, h, n)		__KVM_HANDLER(area, h, n)
-#define KVM_HANDLER_SKIP(area, h, n)	__KVM_HANDLER_SKIP(area, h, n)
-
-#else
-#define KVMTEST(h, n)
-#define KVM_HANDLER(area, h, n)
-#define KVM_HANDLER_SKIP(area, h, n)
-#endif
-
-#define NOTEST(n)
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
-/*
- * Exception vectors.
- */
-#define STD_EXCEPTION(vec, label)				\
-	EXCEPTION_PROLOG(PACA_EXGEN, label, EXC_STD, KVMTEST_PR, vec);
-
-/* Version of above for when we have to branch out-of-line */
-#define __OOL_EXCEPTION(vec, label, hdlr)			\
-	SET_SCRATCH0(r13)					\
-	EXCEPTION_PROLOG_0(PACA_EXGEN)				\
-	b hdlr;
-
-#define STD_EXCEPTION_OOL(vec, label)				\
-	EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST_PR, vec);	\
-	EXCEPTION_PROLOG_2(label, EXC_STD)
-
-#define STD_EXCEPTION_HV(loc, vec, label)			\
-	EXCEPTION_PROLOG(PACA_EXGEN, label, EXC_HV, KVMTEST_HV, vec);
-
-#define STD_EXCEPTION_HV_OOL(vec, label)			\
-	EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST_HV, vec);	\
-	EXCEPTION_PROLOG_2(label, EXC_HV)
-
-#define STD_RELON_EXCEPTION(loc, vec, label)		\
-	/* No guest interrupts come through here */	\
-	EXCEPTION_RELON_PROLOG(PACA_EXGEN, label, EXC_STD, NOTEST, vec);
-
-#define STD_RELON_EXCEPTION_OOL(vec, label)			\
-	EXCEPTION_PROLOG_1(PACA_EXGEN, NOTEST, vec);		\
-	EXCEPTION_PROLOG_2_RELON(label, EXC_STD)
-
-#define STD_RELON_EXCEPTION_HV(loc, vec, label)		\
-	EXCEPTION_RELON_PROLOG(PACA_EXGEN, label, EXC_HV, KVMTEST_HV, vec);
-
-#define STD_RELON_EXCEPTION_HV_OOL(vec, label)			\
-	EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST_HV, vec);	\
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
-
-#define SOFTEN_TEST_PR(vec, bitmask)					\
-	KVMTEST(EXC_STD, vec);						\
-	_SOFTEN_TEST(EXC_STD, vec, bitmask)
-
-#define SOFTEN_TEST_HV(vec, bitmask)					\
-	KVMTEST(EXC_HV, vec);						\
-	_SOFTEN_TEST(EXC_HV, vec, bitmask)
-
-#define KVMTEST_PR(vec)							\
-	KVMTEST(EXC_STD, vec)
-
-#define KVMTEST_HV(vec)							\
-	KVMTEST(EXC_HV, vec)
-
-#define SOFTEN_NOTEST_PR(vec, bitmask)	_SOFTEN_TEST(EXC_STD, vec, bitmask)
-#define SOFTEN_NOTEST_HV(vec, bitmask)	_SOFTEN_TEST(EXC_HV, vec, bitmask)
-
-#define __MASKABLE_EXCEPTION(vec, label, h, extra, bitmask)		\
-	SET_SCRATCH0(r13);    /* save r13 */				\
-	EXCEPTION_PROLOG_0(PACA_EXGEN);					\
-	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, extra, vec, bitmask);	\
-	EXCEPTION_PROLOG_2(label, h);
-
-#define MASKABLE_EXCEPTION(vec, label, bitmask)				\
-	__MASKABLE_EXCEPTION(vec, label, EXC_STD, SOFTEN_TEST_PR, bitmask)
-
-#define MASKABLE_EXCEPTION_OOL(vec, label, bitmask)			\
-	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_PR, vec, bitmask);\
-	EXCEPTION_PROLOG_2(label, EXC_STD)
-
-#define MASKABLE_EXCEPTION_HV(vec, label, bitmask)			\
-	__MASKABLE_EXCEPTION(vec, label, EXC_HV, SOFTEN_TEST_HV, bitmask)
-
-#define MASKABLE_EXCEPTION_HV_OOL(vec, label, bitmask)			\
-	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_HV, vec, bitmask);\
-	EXCEPTION_PROLOG_2(label, EXC_HV)
-
-#define __MASKABLE_RELON_EXCEPTION(vec, label, h, extra, bitmask)	\
-	SET_SCRATCH0(r13);    /* save r13 */				\
-	EXCEPTION_PROLOG_0(PACA_EXGEN);					\
-	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, extra, vec, bitmask);	\
-	EXCEPTION_PROLOG_2_RELON(label, h)
-
-#define MASKABLE_RELON_EXCEPTION(vec, label, bitmask)			\
-	__MASKABLE_RELON_EXCEPTION(vec, label, EXC_STD, SOFTEN_NOTEST_PR, bitmask)
-
-#define MASKABLE_RELON_EXCEPTION_OOL(vec, label, bitmask)		\
-	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_NOTEST_PR, vec, bitmask);\
-	EXCEPTION_PROLOG_2(label, EXC_STD);
-
-#define MASKABLE_RELON_EXCEPTION_HV(vec, label, bitmask)		\
-	__MASKABLE_RELON_EXCEPTION(vec, label, EXC_HV, SOFTEN_TEST_HV, bitmask)
-
-#define MASKABLE_RELON_EXCEPTION_HV_OOL(vec, label, bitmask)		\
-	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_HV, vec, bitmask);\
-	EXCEPTION_PROLOG_2_RELON(label, EXC_HV)
-
-/*
- * Our exception common code can be passed various "additions"
- * to specify the behaviour of interrupts, whether to kick the
- * runlatch, etc...
- */
-
-/*
- * This addition reconciles our actual IRQ state with the various software
- * flags that track it. This may call C code.
- */
-#define ADD_RECONCILE	RECONCILE_IRQ_STATE(r10,r11)
-
-#define ADD_NVGPRS				\
-	bl	save_nvgprs
-
-#define RUNLATCH_ON				\
-BEGIN_FTR_SECTION				\
-	CURRENT_THREAD_INFO(r3, r1);		\
-	ld	r4,TI_LOCAL_FLAGS(r3);		\
-	andi.	r0,r4,_TLF_RUNLATCH;		\
-	beql	ppc64_runlatch_on_trampoline;	\
-END_FTR_SECTION_IFSET(CPU_FTR_CTRL)
-
-#define EXCEPTION_COMMON(area, trap, label, hdlr, ret, additions) \
-	EXCEPTION_PROLOG_COMMON(trap, area);			\
-	/* Volatile regs are potentially clobbered here */	\
-	additions;						\
-	addi	r3,r1,STACK_FRAME_OVERHEAD;			\
-	bl	hdlr;						\
-	b	ret
-
-/*
- * Exception where stack is already set in r1, r1 is saved in r10, and it
- * continues rather than returns.
- */
-#define EXCEPTION_COMMON_NORET_STACK(area, trap, label, hdlr, additions) \
-	EXCEPTION_PROLOG_COMMON_1();				\
-	EXCEPTION_PROLOG_COMMON_2(area);			\
-	EXCEPTION_PROLOG_COMMON_3(trap);			\
-	/* Volatile regs are potentially clobbered here */	\
-	additions;						\
-	addi	r3,r1,STACK_FRAME_OVERHEAD;			\
-	bl	hdlr
-
-#define STD_EXCEPTION_COMMON(trap, label, hdlr)			\
-	EXCEPTION_COMMON(PACA_EXGEN, trap, label, hdlr,		\
-		ret_from_except, ADD_NVGPRS;ADD_RECONCILE)
-
-/*
- * Like STD_EXCEPTION_COMMON, but for exceptions that can occur
- * in the idle task and therefore need the special idle handling
- * (finish nap and runlatch)
- */
-#define STD_EXCEPTION_COMMON_ASYNC(trap, label, hdlr)		\
-	EXCEPTION_COMMON(PACA_EXGEN, trap, label, hdlr,		\
-		ret_from_except_lite, FINISH_NAP;ADD_RECONCILE;RUNLATCH_ON)
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
 #endif	/* _ASM_POWERPC_EXCEPTION_H */
diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index 32a18f2f49bc..e84a9d415c5e 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -19,7 +19,11 @@
  *
  * This bits are set when interrupts occur while soft-disabled
  * and allow a proper replay. Additionally, PACA_IRQ_HARD_DIS
- * is set whenever we manually hard disable.
+ * is set whenever we manually hard disable. Async interrupts
+ * do not set HARD_DIS because that value is not cleared on return,
+ * which would mess up state. Those handlers should not
+ * enable interrupts, though they may do a special hard enable to
+ * to allow PMU interrupts through the soft disable.
  */
 #define PACA_IRQ_HARD_DIS	0x01
 #define PACA_IRQ_DBELL		0x02
@@ -54,7 +58,8 @@
 extern void replay_system_reset(void);
 extern void __replay_interrupt(unsigned int vector);
 
-extern void timer_interrupt(struct pt_regs *);
+extern void timer_interrupt(struct pt_regs *regs);
+extern void timer_interrupt_new(struct pt_regs *regs, u64 tb);
 extern void timer_broadcast_interrupt(void);
 extern void performance_monitor_exception(struct pt_regs *regs);
 extern void WatchdogException(struct pt_regs *regs);
@@ -248,21 +253,55 @@ static inline bool arch_irqs_disabled(void)
 
 static inline bool lazy_irq_pending(void)
 {
+#ifdef CONFIG_PPC_IRQ_SOFT_MASK_DEBUG
+	BUG_ON(mfmsr() & MSR_EE);
+#endif
 	return !!(get_paca()->irq_happened & ~PACA_IRQ_HARD_DIS);
 }
 
+bool power_pmu_running(void);
+
 /*
- * This is called by asynchronous interrupts to conditionally
- * re-enable hard interrupts after having cleared the source
- * of the interrupt. They are kept disabled if there is a different
- * soft-masked interrupt pending that requires hard masking.
+ * This is called by asynchronous interrupts to check whether to
+ * conditionally re-enable hard interrupts after having cleared
+ * the source of the interrupt. They are kept disabled if there
+ * is a different soft-masked interrupt pending that requires hard
+ * masking.
  */
-static inline void may_hard_irq_enable(void)
+static inline bool may_hard_irq_enable(void)
 {
-	if (!(get_paca()->irq_happened & PACA_IRQ_MUST_HARD_MASK)) {
-		get_paca()->irq_happened &= ~PACA_IRQ_HARD_DIS;
-		__hard_irq_enable();
-	}
+#ifdef CONFIG_PPC_IRQ_SOFT_MASK_DEBUG
+	BUG_ON(mfmsr() & MSR_EE);
+#endif
+#ifdef CONFIG_PERF_EVENTS
+	if (!power_pmu_running())
+		return false;
+
+	if (get_paca()->irq_happened & PACA_IRQ_MUST_HARD_MASK)
+		return false;
+
+	return true;
+#else
+	return false;
+#endif
+}
+
+/*
+ * Do the hard enabling, only call this if may_hard_irq_enable is true.
+ */
+static inline void do_hard_irq_enable(void)
+{
+#ifdef CONFIG_PPC_IRQ_SOFT_MASK_DEBUG
+	WARN_ON(irq_soft_mask_return() != IRQS_ALL_DISABLED);
+	WARN_ON(get_paca()->irq_happened & PACA_IRQ_HARD_DIS);
+	WARN_ON(get_paca()->irq_happened & PACA_IRQ_MUST_HARD_MASK);
+	BUG_ON(mfmsr() & MSR_EE);
+#endif
+	/*
+	 * This allows PMI interrupts (and watchdog soft-NMIs) through.
+	 * There is no other reason to enable this way.
+	 */
+	__hard_irq_enable();
 }
 
 static inline bool arch_irq_disabled_regs(struct pt_regs *regs)
@@ -270,6 +309,26 @@ static inline bool arch_irq_disabled_regs(struct pt_regs *regs)
 	return (regs->softe & IRQS_DISABLED);
 }
 
+/*
+ * This will re-enable IRQs after taking an interrupt, if the interrupted
+ * code also had IRQs on. Used for any non-trivial synchronous exceptions.
+ */
+static inline void maybe_irqs_enable_after_interrupt(struct pt_regs *regs)
+{
+#ifdef CONFIG_PPC_IRQ_SOFT_MASK_DEBUG
+	WARN_ON(!arch_irqs_disabled());
+	WARN_ON(mfmsr() & MSR_EE);
+#endif
+	if (!arch_irq_disabled_regs(regs)) {
+#ifdef CONFIG_PPC_IRQ_SOFT_MASK_DEBUG
+		WARN_ON(local_paca->irq_happened & PACA_IRQ_HARD_DIS);
+#endif
+		local_paca->irq_happened |= PACA_IRQ_HARD_DIS;
+		arch_local_irq_enable();
+	}
+}
+/* XXX Book3E */
+
 extern bool prep_irq_for_idle(void);
 extern bool prep_irq_for_idle_irqsoff(void);
 extern void irq_set_pending_from_srr1(unsigned long srr1);
@@ -349,6 +408,18 @@ static inline bool arch_irq_disabled_regs(struct pt_regs *regs)
 	return !(regs->msr & MSR_EE);
 }
 
+/*
+ * This will re-enable IRQs after taking an interrupt, if the interrupted
+ * code also had IRQs on. Used for any non-trivial synchronous exceptions.
+ *
+ * Must be #define due to local_irq_enable
+ */
+#define maybe_irqs_enable_after_interrupt(regs)			\
+	do {							\
+		if (!arch_irq_disabled_regs(regs))		\
+			local_irq_enable();			\
+	} while (0)
+
 static inline void may_hard_irq_enable(void) { }
 
 #endif /* CONFIG_PPC64 */
diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index e0637730a8e7..7621c5759eaf 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -24,17 +24,21 @@
 
 #ifndef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
 #define ACCOUNT_CPU_USER_ENTRY(ptr, ra, rb)
+#define ACCOUNT_CPU_USER_ENTRY_TB(ptr, tb, ra, rb)
 #define ACCOUNT_CPU_USER_EXIT(ptr, ra, rb)
 #define ACCOUNT_STOLEN_TIME
 #else
-#define ACCOUNT_CPU_USER_ENTRY(ptr, ra, rb)				\
-	MFTB(ra);			/* get timebase */		\
+#define ACCOUNT_CPU_USER_ENTRY_TB(ptr, tb, ra, rb)			\
 	PPC_LL	rb, ACCOUNT_STARTTIME_USER(ptr);			\
-	PPC_STL	ra, ACCOUNT_STARTTIME(ptr);				\
-	subf	rb,rb,ra;		/* subtract start value */	\
+	PPC_STL	tb, ACCOUNT_STARTTIME(ptr);				\
+	subf	rb,rb,tb;		/* subtract start value */	\
 	PPC_LL	ra, ACCOUNT_USER_TIME(ptr);				\
 	add	ra,ra,rb;		/* add on to user time */	\
-	PPC_STL	ra, ACCOUNT_USER_TIME(ptr);				\
+	PPC_STL	ra, ACCOUNT_USER_TIME(ptr)
+
+#define ACCOUNT_CPU_USER_ENTRY(ptr, ra, rb)				\
+	MFTB(ra);			/* get timebase */		\
+	ACCOUNT_CPU_USER_ENTRY_TB(ptr, ra, ra, rb)
 
 #define ACCOUNT_CPU_USER_EXIT(ptr, ra, rb)				\
 	MFTB(ra);			/* get timebase */		\
diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index 0b8a735b6d85..0cf7c0211f49 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -74,8 +74,9 @@ struct pt_regs
 #define KERNEL_REDZONE_SIZE	288
 
 #define STACK_FRAME_OVERHEAD	112	/* size of minimum stack frame */
+#define STACK_FRAME_CR_SAVE	1	/* Location of CR in stack frame */
 #define STACK_FRAME_LR_SAVE	2	/* Location of LR in stack frame */
-#define STACK_FRAME_REGS_MARKER	ASM_CONST(0x7265677368657265)
+#define STACK_FRAME_REGS_MARKER	ASM_CONST(0x72656773)
 #define STACK_INT_FRAME_SIZE	(sizeof(struct pt_regs) + \
 				 STACK_FRAME_OVERHEAD + KERNEL_REDZONE_SIZE)
 #define STACK_FRAME_MARKER	12
diff --git a/arch/powerpc/kernel/dbell.c b/arch/powerpc/kernel/dbell.c
index b6fe883b1016..fe04ca572b6a 100644
--- a/arch/powerpc/kernel/dbell.c
+++ b/arch/powerpc/kernel/dbell.c
@@ -84,7 +84,8 @@ void doorbell_exception(struct pt_regs *regs)
 
 	ppc_msgsync();
 
-	may_hard_irq_enable();
+	if (may_hard_irq_enable())
+		do_hard_irq_enable();
 
 	kvmppc_set_host_ipi(smp_processor_id(), 0);
 	__this_cpu_inc(irq_stat.doorbell_irqs);
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 435927f549c4..2010c2b185ff 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -470,6 +470,9 @@ _ASM_NOKPROBE_SYMBOL(save_nvgprs);
  * register state on the stack so that it can be copied to the child.
  */
 
+/*
+ * XXX: this could unconditional save nvgprs
+ */
 _GLOBAL(ppc_fork)
 	bl	save_nvgprs
 	bl	sys_fork
@@ -1091,7 +1094,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 1:	cmpwi	cr0,r3,0x900
 	bne	1f
 	addi	r3,r1,STACK_FRAME_OVERHEAD;
-	bl	timer_interrupt
+	mftb	r4
+	bl	timer_interrupt_new
 	b	ret_from_except
 #ifdef CONFIG_PPC_DOORBELL
 1:
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 9e253ce27e08..0c99bfeffeb7 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -20,6 +20,896 @@
 #include <asm/head-64.h>
 #include <asm/feature-fixups.h>
 
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
+/*
+ * We're short on space and time in the exception prolog, so we can't
+ * use the normal LOAD_REG_IMMEDIATE macro to load the address of label.
+ * Instead we get the base of the kernel from paca->kernelbase and or in the low
+ * part of label. This requires that the label be within 64KB of kernelbase, and
+ * that kernelbase be 64K aligned.
+ */
+#define LOAD_HANDLER(reg, label)					\
+	ld	reg,PACAKBASE(r13);	/* get high part of &label */	\
+	ori	reg,reg,FIXED_SYMBOL_ABS_ADDR(label);
+
+#define __LOAD_HANDLER(reg, label)					\
+	ld	reg,PACAKBASE(r13);					\
+	ori	reg,reg,(ABS_ADDR(label))@l;
+
+/*
+ * Branches from unrelocated code (e.g., interrupts) to labels outside
+ * head-y require >64K offsets.
+ */
+#define __LOAD_FAR_HANDLER(reg, label)					\
+	ld	reg,PACAKBASE(r13);					\
+	ori	reg,reg,(ABS_ADDR(label))@l;				\
+	addis	reg,reg,(ABS_ADDR(label))@h;
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
+#define BRANCH_TO_COMMON(reg, label)					\
+	b	label
+
+#define BRANCH_LINK_TO_FAR(label)					\
+	bl	label
+
+#define __BRANCH_TO_KVM_EXIT(area, label)				\
+	ld	r9,area+EX_R9(r13);					\
+	b	label
+
+#endif
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
+
+
+#define SAVE_REG	16	/* Begin saving registers from here */
+
+#define IVEC		.L_\name\()_vec
+#define ISIZE		.L_\name\()_size
+#define IREAL		.L_\name\()_virt
+#define IVIRT		.L_\name\()_real
+#define IAREA		.L_\name\()_area
+#define IINTS_ON	.L_\name\()_ints_on
+#define IASYNC		.L_\name\()_async
+#define IMASK		.L_\name\()_mask
+#define IKVM_REAL	.L_\name\()_kvm_real
+#define IKVM_VIRT	.L_\name\()_kvm_virt
+#define IISIDE		.L_\name\()_iside
+
+#define ICFAR		.L_\name\()_CFAR
+#define IPPR		.L_\name\()_PPR
+#define ITB		.L_\name\()_TB
+#define ICR		.L_\name\()_CR
+#define ILR		.L_\name\()_LR
+#define IR13		.L_\name\()_R13
+#define ISRR0		.L_\name\()_SRR0
+#define ISRR1		.L_\name\()_SRR1
+#define IDATA		.L_\name\()_DATA
+#define IDAR		.L_\name\()_DAR
+#define IDSISR		.L_\name\()_DSISR
+#define ISCRATCH	.L_\name\()_SCRATCH
+#define IHSRR		.L_\name\()_hsrr
+#define IHSRR_HVMODE	.L_\name\()_hsrr_hvmode
+#define IREGS_USED	.L_\name\()_regs_used
+
+#define IARG_TB		.L_\name\()_arg_TB
+
+#define IREG_CFAR	.L_\name\()_REG_CFAR
+#define IREG_PPR	.L_\name\()_REG_PPR
+#define IREG_TB		.L_\name\()_REG_TB
+#define IREG_STACK	.L_\name\()_REG_STACK
+#define IREG_CR		.L_\name\()_REG_CR
+#define IREG_LR		.L_\name\()_REG_LR
+#define IREG_R13	.L_\name\()_REG_R13
+#define IREG_SRR0	.L_\name\()_REG_SRR0
+#define IREG_SRR1	.L_\name\()_REG_SRR1
+#define IREG_DAR	.L_\name\()_REG_DAR
+#define IREG_DSISR	.L_\name\()_REG_DSISR
+#define IREG_SCRATCH	.L_\name\()_REG_SCRATCH
+
+/*
+ * Indirect branches use LR because that's a more useful register (can
+ * call/ret)
+ * bclr 20,0,1 is used rather than blr in this case, so as not to destroy
+ * the link stack predictor.
+ * XXX: have to make sure this actually performs properly on real CPUs.
+ * XXX: this may not be as helpful as I thought.
+ */
+
+.macro INT_DEFINE name
+
+	/* Expand the setup macro definitions */
+	int_define_\name\() \name
+
+	SAVE_NR=0
+	.if ICFAR
+		IREG_CFAR=SAVE_REG+SAVE_NR
+		SAVE_NR=SAVE_NR+1
+	.endif
+	.if IPPR
+		IREG_PPR=SAVE_REG+SAVE_NR
+		SAVE_NR=SAVE_NR+1
+	.endif
+
+	/* This puts tb in argument list only if we asked for it */
+	.if ITB
+		IARG_TB=1
+	.else
+		IARG_TB=0
+	.endif
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
+	ITB=1
+#endif
+	.if ITB
+		IREG_TB=SAVE_REG+SAVE_NR
+		SAVE_NR=SAVE_NR+1
+	.endif
+
+	.if !IREAL
+		IKVM_REAL=0
+	.endif
+	.if !IVIRT
+		IKVM_VIRT=0
+	.endif
+	.if IHSRR
+		.ifndef IHSRR_HVMODE
+			IHSRR_HVMODE=0
+		.endif
+	.else
+		IHSRR_HVMODE=0
+	.endif
+
+	IREG_STACK=SAVE_REG+SAVE_NR
+	SAVE_NR=SAVE_NR+1
+
+	IREG_SRR0=SAVE_REG+SAVE_NR
+	SAVE_NR=SAVE_NR+1
+	IREG_SRR1=SAVE_REG+SAVE_NR
+	SAVE_NR=SAVE_NR+1
+
+	.if IDATA
+		.if IDAR
+			IREG_DAR=SAVE_REG+SAVE_NR
+			SAVE_NR=SAVE_NR+1
+		.endif
+		.if IDSISR
+			IREG_DSISR=SAVE_REG+SAVE_NR
+			SAVE_NR=SAVE_NR+1
+		.endif
+	.else
+		IISIDE=0
+		IDAR=0
+		IDSISR=0
+	.endif
+	IREG_CR=SAVE_REG+SAVE_NR
+	SAVE_NR=SAVE_NR+1
+	IREG_LR=SAVE_REG+SAVE_NR
+	SAVE_NR=SAVE_NR+1
+	IREG_R13=SAVE_REG+SAVE_NR
+	SAVE_NR=SAVE_NR+1
+	IREG_SCRATCH=SAVE_REG+SAVE_NR
+	SAVE_NR=SAVE_NR+1
+
+	IREGS_USED=SAVE_NR
+.endm
+
+.macro	INT_ENTRY name virt
+	NR_SAVED=0
+	SET_SCRATCH0(r13)		/* save r13 */
+	GET_PACA(r13)
+
+	nr = IREGS_USED - NR_SAVED
+	.if nr > 4
+		nr = 4
+	.endif
+	.rept nr
+		std	SAVE_REG+NR_SAVED,IAREA+(NR_SAVED*8)(r13)
+		NR_SAVED=NR_SAVED+1
+	.endr
+
+	.if ICFAR
+		OPT_GET_SPR(IREG_CFAR, SPRN_CFAR, CPU_FTR_CFAR)
+	.endif
+
+	.if (ISIZE == 0x20)
+		.if \virt
+			b	\name\()_virt_tramp
+			.pushsection ".head.text.virt_trampolines"
+			\name\()_virt_tramp:
+		.else
+			b	\name\()_real_tramp
+			.pushsection ".head.text.real_trampolines"
+			\name\()_real_tramp:
+		.endif
+	.endif
+
+	.if IPPR
+		OPT_GET_SPR(IREG_PPR, SPRN_PPR, CPU_FTR_HAS_PPR)
+	.endif
+	.if ITB
+		mftb	IREG_TB
+	.endif
+
+	/* kernel stack to use (can be overidden by updating the reg) */
+	ld	IREG_STACK,PACAKSAVE(r13)
+
+	INTERRUPT_TO_KERNEL
+
+	nr = IREGS_USED - NR_SAVED
+	.rept nr
+		std	SAVE_REG+NR_SAVED,IAREA+(NR_SAVED*8)(r13)
+		NR_SAVED=NR_SAVED+1
+	.endr
+
+	/*
+	 * Rather than load all the non-NTC sprs now into non-volatiles,
+	 * may be faster to load them with volatile gprs right after we
+	 * save them off. The problem is that comes after user/kernel
+	 * branch to set up the stack, so a mispredict there would have
+	 * to re-load SPRs. Must test.
+	 */
+	.if IHSRR
+		.if IHSRR_HVMODE
+			BEGIN_FTR_SECTION
+			mfspr	IREG_SRR0,SPRN_HSRR0
+			mfspr	IREG_SRR1,SPRN_HSRR1
+			FTR_SECTION_ELSE
+			mfspr	IREG_SRR0,SPRN_SRR0
+			mfspr	IREG_SRR1,SPRN_SRR1
+			ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
+		.else
+			mfspr	IREG_SRR0,SPRN_HSRR0
+			mfspr	IREG_SRR1,SPRN_HSRR1
+		.endif
+	.else
+		mfspr	IREG_SRR0,SPRN_SRR0
+		mfspr	IREG_SRR1,SPRN_SRR1
+	.endif
+
+	.if IDATA
+		.if IDAR
+			.if IISIDE
+				mr	IREG_DAR,IREG_SRR0
+			.else
+				.if IHSRR
+					mfspr	IREG_DAR,SPRN_HDAR
+				.else
+					mfspr	IREG_DAR,SPRN_DAR
+				.endif
+			.endif
+		.endif
+		.if IDSISR && !IISIDE
+			.if IHSRR
+				mfspr	IREG_DSISR,SPRN_HDSISR
+			.else
+				mfspr	IREG_DSISR,SPRN_DSISR
+			.endif
+		.endif
+	.endif
+
+	GET_SCRATCH0(IREG_R13)
+
+	mfcr	IREG_CR
+	mflr	IREG_LR
+
+	/*
+	 * IDSISR equivalent comes from SRR1 for i-side interrupts
+	 */
+	.if IDATA && IDSISR && IISIDE
+		andis.	IREG_DSISR,IREG_SRR1,DSISR_SRR1_MATCH_64S@h
+	.endif
+
+#ifdef CONFIG_RELOCATABLE
+	.if \virt
+		LOAD_HANDLER(IREG_SCRATCH,\name\()_virt)
+	.else
+		LOAD_HANDLER(IREG_SCRATCH,\name\()_real)
+	.endif
+	mtlr	IREG_SCRATCH
+	bclr	20,0,1
+#else /* CONFIG_RELOCATABLE */
+	.if \virt
+		b	\name\()_virt
+	.else
+		LOAD_HANDLER(IREG_SCRATCH,\name\()_real)
+		mtlr	IREG_SCRATCH
+		bclr	20,0,1
+	.endif
+#endif /* CONFIG_RELOCATABLE */
+
+	.if (ISIZE == 0x20)
+		.popsection
+	.endif
+.endm
+
+
+.macro INT_ENTRY_RESTORE name
+	mtcr	IREG_CR
+	mtlr	IREG_LR
+
+	nr = IREGS_USED
+	i = 0
+	.rept nr
+		ld	SAVE_REG+i,IAREA+(i*8)(r13)
+		i = i + 1
+	.endr
+.endm
+
+.macro INT_KVM_TEST reg srr1 label
+#if defined(CONFIG_KVM_BOOK3S_PR_POSSIBLE)
+	lbz	\reg,HSTATE_IN_GUEST(r13)
+	cmpwi	\reg,0
+	bne	\label
+#elif defined(CONFIG_KVM_BOOK3S_HV_POSSIBLE)
+BEGIN_FTR_SECTION
+	rldicl.	\reg,\srr1,(64-MSR_HV_LG),63
+	beq	\label
+END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
+#endif
+.endm
+
+.macro INT_RESTORE_REGS name
+	/*
+	 * Restore NVGPRs
+	 */
+	nr = IREGS_USED
+	i = 0
+	.rept nr
+		ld	SAVE_REG+i,IAREA+(i*8)(r13)
+		i = i + 1
+	.endr
+.endm
+
+.macro INT_SETUP_C name
+	lbz	IREG_SCRATCH,PACAIRQSOFTMASK(r13)
+	std	IREG_SCRATCH,SOFTE(IREG_STACK)
+	li	IREG_SCRATCH,IRQS_ALL_DISABLED
+	stb	IREG_SCRATCH,PACAIRQSOFTMASK(r13)
+
+	/* XXX: Virt CPU accounting for these cases */
+
+	.if IPPR
+		HMT_MEDIUM
+	.endif
+
+	SAVE_8GPRS(0, IREG_STACK)	/* save r0 - r7 in stackframe	*/
+	ld	r2,PACATOC(r13)		/* get kernel TOC into r2 early	*/
+	mfctr	r4
+	mfspr	r5,SPRN_XER
+	li	r0,IVEC + 1
+	/* Load directly rather than dependent load from TOC */
+	lis	r3,(STACK_FRAME_REGS_MARKER)@ha
+	addi	r3,r3,(STACK_FRAME_REGS_MARKER)@l
+
+	/* XXX: clear RESULT? */
+
+	/*
+	 * Set up the stack frame. Unwinder wants backchain, regshere marker,
+	 * link, trap, nip. We do some extra stores to try to store adjacent
+	 * blocks (TODO rearrange int frame layout to optimise stores).
+	 */
+	std	r1,0(IREG_STACK)
+	std	IREG_SRR0,_NIP(IREG_STACK)
+	std	IREG_SRR1,_MSR(IREG_STACK)
+	std	r0,_TRAP(IREG_STACK)	/* set trap number		*/
+	std	r3,STACK_FRAME_MARKER*8(IREG_STACK) /* mark the frame	*/
+	std	r4,_CTR(IREG_STACK)
+	std	IREG_LR,_LINK(IREG_STACK) /* save LR in stackframe	*/
+	std	r5,_XER(IREG_STACK)
+	std	IREG_CR,_CCR(IREG_STACK) /* save CR in stackframe	*/
+	/* Stack is set up now */
+	mr	r1,IREG_STACK		/* Now swap in r1 */
+
+	SAVE_4GPRS(8, r1)		/* save r8 - r11 in stackframe  */
+	std	r12,GPR12(r1)
+	std	IREG_R13,GPR13(r1)
+
+	.if ICFAR
+		std	IREG_CFAR,ORIG_GPR3(r1)
+	.endif
+	.if IPPR
+		std	IREG_PPR,_PPR(r1)
+	.endif
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+.endm
+
+
+.macro INT_COMMON name stack_addition=0
+	.if IREAL
+	.balign IFETCH_ALIGN_BYTES
+DEFINE_FIXED_SYMBOL(\name\()_real)
+\name\()_real:
+	.if IKVM_REAL
+		INT_KVM_TEST IREG_SCRATCH, IREG_SRR1, \name\()_kvm
+	.endif
+	ld	IREG_SCRATCH,PACAKMSR(r13)	/* MSR value for kernel */
+	mtmsrd	IREG_SCRATCH,0		/* This turns relocation on */
+	/*
+	 * Real-mode handlers run with MSR[RI] on here, because it comes
+	 * for free. Virt could as well, but we sacrifice a small amount
+	 * of recoverable window to avoid the mtmsrd L=1 for performance.
+	 */
+
+	.if IVIRT && IKVM_VIRT
+		/* Have to skip past a virt test */
+		b	.L_\name\()_virt_nokvm
+	.endif
+	.endif /* IREAL */
+
+	.if IVIRT
+	.balign IFETCH_ALIGN_BYTES
+DEFINE_FIXED_SYMBOL(\name\()_virt)
+\name\()_virt:
+	.if IKVM_VIRT
+		INT_KVM_TEST IREG_SCRATCH, IREG_SRR1, \name\()_kvm
+.L_\name\()_virt_nokvm:
+	.endif
+	.endif /* IVIRT */
+
+	andi.	IREG_SCRATCH,IREG_SRR1,MSR_PR
+	cmpdi	cr2,IREG_SCRATCH,0		/* Kernel test in NV CR2 */
+	bne	cr2,1f
+
+	/* Came from kernel */
+#ifdef CONFIG_BUG
+	.if \stack_addition == 0
+		/* Ensure r1 is within our stack region */
+		xor	IREG_SCRATCH,r1,IREG_STACK
+		srdi	IREG_SCRATCH,IREG_SCRATCH,THREAD_SHIFT
+100:		tdnei	IREG_SCRATCH,0
+		EMIT_BUG_ENTRY 100b,__FILE__,__LINE__,0
+	.endif
+#endif
+	/* Can reuse IREG_STACK now */
+	lbz	IREG_SCRATCH,PACAIRQSOFTMASK(r13)
+	.if IMASK
+		andi.	IREG_STACK,IREG_SCRATCH,IMASK
+		bne-	\name\()_masked_interrupt
+	.endif
+
+#ifdef CONFIG_TRACE_IRQFLAGS
+	.if !IINTS_ON
+		andi.	IREG_STACK,IREG_SCRATCH,IRQS_DISABLED
+		cmpdi	cr3,IREG_STACK,IRQS_DISABLED /* IRQs disabled in NV CR3 */
+	.endif
+#endif
+
+	subi	IREG_STACK,r1,INT_FRAME_SIZE
+	std	IREG_SCRATCH,SOFTE(IREG_STACK)
+	.if !IINTS_ON
+		ori	IREG_SCRATCH,IREG_SCRATCH,IRQS_DISABLED
+		stb	IREG_SCRATCH,PACAIRQSOFTMASK(r13)
+	.endif
+
+	b	2f
+
+1:	/* Came from user */
+#ifdef CONFIG_BUG
+	lbz	IREG_SCRATCH,PACAIRQSOFTMASK(r13)
+100:	tdnei	IREG_SCRATCH,IRQS_ENABLED
+	EMIT_BUG_ENTRY 100b,__FILE__,__LINE__,1
+	lbz	IREG_SCRATCH,PACAIRQHAPPENED(r13)
+100:	tdnei	IREG_SCRATCH,0
+	EMIT_BUG_ENTRY 100b,__FILE__,__LINE__,1
+#endif
+#ifdef CONFIG_TRACE_IRQFLAGS
+	.if !IINTS_ON
+		crclr	4*cr3+eq
+	.endif
+#endif
+
+	/*
+	 * Exit to user could disable soft-irqs which would allow us
+	 * to avoid this store for user.
+	 */
+	.if !IINTS_ON
+		li	IREG_SCRATCH,IRQS_ALL_DISABLED
+		stb	IREG_SCRATCH,PACAIRQSOFTMASK(r13)
+	.endif
+
+	li	IREG_SCRATCH,IRQS_ENABLED
+	std	IREG_SCRATCH,SOFTE(IREG_STACK)
+
+2:	/* Kernel annd user continue here */
+
+	/*
+	 * Handler can optionally override IREG_STACK
+	 */
+	.if \stack_addition
+		\name\()_stack_addition \name
+	.endif
+
+	.if IPPR
+	/*
+	 * This is a MTSPR PPR so must come after any mfspr. Good idea to
+	 * set it before enabling EE or RI, but have to be careful colliding
+	 * with mtmsrd
+	 */
+		HMT_MEDIUM
+	.endif
+
+	/*
+	 * Storing to stack using a different register is usually a bad idea
+	 * because it can fool the load-hit-store machinery. In this case,
+	 * the syscall should be long enough that the store will have got to
+	 * cache before we exit. We want to avoid swapping the r1 pointer
+	 * before the frame is set up, so as a crash will have a good
+	 * chance of walking the stack.
+	 */
+	SAVE_8GPRS(0, IREG_STACK)	/* save r0 - r7 in stackframe	*/
+
+	ld	r2,PACATOC(r13)		/* get kernel TOC into r2 early	*/
+	mfctr	r4
+	mfspr	r5,SPRN_XER
+	li	r0,IVEC + 1
+	/* Load directly rather than dependent load from TOC */
+	lis	r3,(STACK_FRAME_REGS_MARKER)@ha
+	addi	r3,r3,(STACK_FRAME_REGS_MARKER)@l
+
+	/*
+	 * Set up the stack frame. Unwinder wants backchain, regshere marker,
+	 * link, trap, nip. We do some extra stores to try to store adjacent
+	 * blocks (TODO rearrange int frame layout to optimise stores).
+	 */
+	std	r1,0(IREG_STACK)
+	std	IREG_SRR0,_NIP(IREG_STACK)
+	std	IREG_SRR1,_MSR(IREG_STACK)
+	std	r0,_TRAP(IREG_STACK)	/* set trap number		*/
+	std	r3,STACK_FRAME_MARKER*8(IREG_STACK) /* mark the frame	*/
+	std	r4,_CTR(IREG_STACK)
+	std	IREG_LR,_LINK(IREG_STACK) /* save LR in stackframe	*/
+	std	r5,_XER(IREG_STACK)
+	std	IREG_CR,_CCR(IREG_STACK) /* save CR in stackframe	*/
+	/* Stack is set up now */
+	mr	r1,IREG_STACK		/* Now swap in r1 */
+
+	SAVE_4GPRS(8, r1)		/* save r8 - r11 in stackframe  */
+	std	r12,GPR12(r1)
+	std	IREG_R13,GPR13(r1)
+
+	li	r12,0			/* r12 is a zero */
+
+	/*
+	 * All volatiles saved away now, and stack and TOC set up.
+	 * May call into C now.
+	 */
+#ifdef CONFIG_PPC_SPLPAR
+BEGIN_FW_FTR_SECTION
+	beq	cr2,1f
+	/* from user - see if there are any DTL entries to process */
+	ld	r10,PACALPPACAPTR(r13)	/* get ptr to VPA */
+	ld	r11,PACA_DTL_RIDX(r13)	/* get log read index */
+	addi	r10,r10,LPPACA_DTLIDX
+	LDX_BE	r10,0,r10		/* get log write index */
+	cmpd    r11,r10
+	bnel	tramp_accumulate_stolen_time
+1:
+END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
+#endif
+
+	.if IASYNC
+	/* XXX: initial boot should put runlatch on to avoid this hitting */
+		beq	cr2,1f
+		FINISH_NAP
+		RUNLATCH_ON
+1:
+	.endif
+
+#ifdef CONFIG_TRACE_IRQFLAGS
+	/*
+	 * If ints are to be immediately switched back on, not much point
+	 * in turning them off.
+	 */
+	.if !IINTS_ON
+#ifdef CONFIG_IRQSOFF_TRACER
+		beq	cr3,1f
+		TRACE_DISABLE_INTS /* clobbers volatile registers */
+1:
+#else
+		bnel	cr3,trace_hardirqs_off
+#endif
+	.endif
+#endif
+
+	/* Finish pt_regs */
+	.if IDAR
+		std	IREG_DAR,_DAR(r1)
+	.endif
+	.if IDSISR
+		std	IREG_DSISR,_DSISR(r1)
+	.endif
+
+	std	r12,RESULT(r1)		/* clear regs->result		*/
+
+	/* Set regs */
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	i = 0
+	.if IARG_TB
+		mr	4 + i,IREG_TB
+		i = i + 1
+	.endif
+	.if IDAR
+		mr	4 + i,IREG_DAR
+		i = i + 1
+	.endif
+	.if IDSISR
+		mr	4 + i,IREG_DSISR
+		i = i + 1
+	.endif
+
+	/*
+	 * NTC mfsprs (TB, CFAR, PPR) stores go last, to avoid tying up store
+	 * queue resources while dependencies aren't met. Should to more
+	 * pipe analysis on this.
+	 */
+	.if ICFAR
+		mr	r9,IREG_CFAR
+	.endif
+	.if IPPR
+		mr	r10,IREG_PPR
+	.endif
+	.if IARG_TB
+		mr	r11,IREG_TB
+	.endif
+
+	INT_RESTORE_REGS \name
+
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
+	beq	cr2,1f
+	ACCOUNT_CPU_USER_ENTRY_TB(r13, r11, r9, r10)
+1:
+#endif
+
+	.if ICFAR
+		std	r9,ORIG_GPR3(r1)
+	.endif
+	.if IPPR
+		std	r10,_PPR(r1)
+	.endif
+
+	.if !IINTS_ON
+		/*
+		 * HSRR interrupts run with MSR[RI] unchaged, so it does
+		 * not need to be cleared. Handlers that specify IINTS_ON
+		 * must do their own enable and should combine it with
+		 * MSR[EE] enable.
+		 */
+		.if IHSRR && IHSRR_HVMODE
+			BEGIN_FTR_SECTION
+			nop
+			nop
+			FTR_SECTION_ELSE
+			ori	r9,r12,MSR_RI
+			mtmsrd	r9,1
+			ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
+		.else
+			ori	r9,r12,MSR_RI
+			mtmsrd	r9,1
+		.endif
+	.endif
+.endm
+
+.macro INT_MASKED name happened addition=0
+\name\()_masked_interrupt:
+	std	r1,PACAR1(r13)
+	lbz	IREG_SCRATCH,PACAIRQHAPPENED(r13)
+	ori	IREG_SCRATCH,IREG_SCRATCH,\happened
+	stb	IREG_SCRATCH,PACAIRQHAPPENED(r13)
+
+	.if \addition
+		\name\()_masked_addition \name
+	.endif
+
+	INT_ENTRY_RESTORE \name
+	.if IHSRR
+		.if IHSRR_HVMODE
+			BEGIN_FTR_SECTION
+			HRFI_TO_KERNEL
+			FTR_SECTION_ELSE
+			RFI_TO_KERNEL
+			ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
+		.else
+			HRFI_TO_KERNEL
+		.endif
+	.else
+		RFI_TO_KERNEL
+	.endif
+.endm
+
+.macro INT_REPLAY name addition=0
+\name\()_replay:
+	nr = IREGS_USED
+	i = 0
+	.rept nr
+		std	SAVE_REG+i,IAREA+(i*8)(r13)
+		i = i + 1
+	.endr
+
+	.if ICFAR
+		OPT_GET_SPR(IREG_CFAR, SPRN_CFAR, CPU_FTR_CFAR)
+	.endif
+	.if ITB
+		mftb	IREG_TB
+	.endif
+	OPT_GET_SPR(IREG_PPR, SPRN_PPR, CPU_FTR_HAS_PPR)
+	mflr	IREG_LR
+	mr	IREG_SRR0,r11
+	mr	IREG_SRR1,r12
+	mr	IREG_STACK,r1
+	mr	IREG_CR,r9
+	.if \addition
+		\name\()_replay_addition \name
+	.endif
+	b	\name\()_virt
+.endm
+
+/*
+ * The KVM handler currently sets up the KVM calling convention and restores
+ * other clobbered registers before calling. This is suboptimal because
+ * we already have things set up, so KVM should be taught to use these
+ * registers and save area directly.
+ */
+.macro INT_KVM name skip
+#ifdef CONFIG_KVM_BOOK3S_64_HANDLER
+	.balign IFETCH_ALIGN_BYTES
+DEFINE_FIXED_SYMBOL(\name\()_kvm)
+\name\()_kvm:
+	.if \skip
+		cmpwi	IREG_SCRATCH,KVM_GUEST_MODE_SKIP
+		beq	1f
+	.endif
+
+	HMT_MEDIUM /* XXX: where to put this? (see above) */
+
+	.if ICFAR
+		std	IREG_CFAR,HSTATE_CFAR(r13)
+	.else
+		li	IREG_SCRATCH,0	/* No CFAR, set it to 0 */
+		std	IREG_SCRATCH,HSTATE_CFAR(r13)
+	.endif
+	.if IPPR
+		std	IREG_PPR,HSTATE_PPR(r13)
+	.else
+		mfspr	IREG_SCRATCH,SPRN_PPR
+		std	IREG_SCRATCH,HSTATE_PPR(r13)
+	.endif
+
+	INT_ENTRY_RESTORE \name
+
+	/*
+	 * Switch to KVM interrupt convention. KVM should be updated to use
+	 * Linux interrupt convention
+	 */
+	std	r12,HSTATE_SCRATCH0(r13)
+#ifdef CONFIG_RELOCATABLE
+	mfctr	r12
+	std	r12,HSTATE_SCRATCH1(r13)
+#endif
+	mfcr	r12
+	sldi	r12,r12,32
+	.if IHSRR
+		ori	r12,r12,IVEC + 0x2
+	.else
+		ori	r12,r12,IVEC
+	.endif
+	b	kvmppc_interrupt
+
+	.if \skip
+1:		addi	IREG_SRR0,IREG_SRR0,4
+		.if IHSRR
+			mtspr	SPRN_HSRR0,IREG_SRR0
+			INT_ENTRY_RESTORE \name
+			GET_SCRATCH0(r13)
+			HRFI_TO_KERNEL
+		.else
+			mtspr	SPRN_SRR0,IREG_SRR0
+			INT_ENTRY_RESTORE \name
+			GET_SCRATCH0(r13)
+			RFI_TO_KERNEL
+		.endif
+	.endif
+#endif
+.endm
+
 /*
  * There are a few constraints to be concerned with.
  * - Real mode exceptions code/data must be located at their physical location.
@@ -94,10 +984,53 @@ USE_FIXED_SECTION(real_vectors)
 	.globl __start_interrupts
 __start_interrupts:
 
-/* No virt vectors corresponding with 0x0..0x100 */
-EXC_VIRT_NONE(0x4000, 0x100)
 
+.macro int_define_system_reset name
+/*
+ * System Reset (SRESET or NMI) is a non-maskable, asynchronous interrupt
+ * always taken in real-mode. It is caused by:
+ * - Wake from power-saving state, on powernv.
+ * - A non-maskable IPI originating from another CPU.
+ * - A crash/debug signal injected from BMC/firmware or hypervisor.
+ *
+ * Handling:
+ * Testing for power-save wakeup as optimally as possible first, in this
+ * case, volatile registers don't need to be kept. If not a powersave wakeup,
+ * then it's a regular handler, however it uses its own stack and PACA save
+ * area to preserve the regular kernel environment for debugging.
+ *
+ * The high level exception handler in the powernv/pseries platform code
+ * decides whether it's an IPI or crash/debug.
+ *
+ * KVM:
+ * This may be taken while in a guest, so a KVM test is required. KVM can do
+ * a powersave sleep in guest contetxt e.g., due to H_CEDE. That case is
+ * handled by the power save wakeup code.
+ */
+	IVEC=0x100
+	ISIZE=0x100
+	IREAL=1
+	IVIRT=0
+#ifdef CONFIG_KVM_BOOK3S_64_HANDLER
+	IKVM_REAL=1
+#else
+	IKVM_REAL=0
+#endif
+	IINTS_ON=0
+	IHSRR=0
+	IAREA=PACA_EXNMI
+	IINTS=0
+	IASYNC=0	/* XXX: sreset and mce are actually async */
+	IMASK=0
+	ICFAR=1
+	IPPR=1
+	ITB=0
+	IDATA=0
+.endm
+
+INT_DEFINE system_reset
 
+EXC_REAL_BEGIN(system_reset, 0x100, 0x100)
 #ifdef CONFIG_PPC_P7_NAP
 	/*
 	 * If running native on arch 2.06 or later, check if we are waking up
@@ -105,57 +1038,69 @@ EXC_VIRT_NONE(0x4000, 0x100)
 	 * bits 46:47. A non-0 value indicates that we are coming from a power
 	 * saving state. The idle wakeup handler initially runs in real mode,
 	 * but we branch to the 0xc000... address so we can turn on relocation
-	 * with mtmsr.
+	 * with mtmsrd later, after SPRs are restored.
+	 *
+	 * Careful to minimise cost for the fast path (idle wakeup) while
+	 * also avoiding clobbering CFAR for the non-idle case. Once we know
+	 * it is an idle wake, volatiles don't matter, which is why we use
+	 * those here, and then re-do the entry in case of non-idle (without
+	 * branching for the non-idle case, to keep CFAR).
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
+	BEGIN_FTR_SECTION
+	SET_SCRATCH0(r13)
+	GET_PACA(r13)
+	std	r12,PACA_EXNMI+0*8(r13)
+	std	r4,PACA_EXNMI+1*8(r13)
+	std	r5,PACA_EXNMI+2*8(r13)
+	mfspr	r12,SPRN_SRR1
+	mfocrf	r4,0x80
+	rlwinm.	r5,r12,47-31,30,31
+	bne+	system_reset_idle_wake
+	/* Restore all regs to allow the regular INT_ENTRY to work */
+	mtocrf	0x80,r4
+	ld	r12,PACA_EXNMI+0*8(r13)
+	ld	r4,PACA_EXNMI+1*8(r13)
+	ld	r5,PACA_EXNMI+2*8(r13)
+	GET_SCRATCH0(r13)
 	END_FTR_SECTION_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
-#else
-#define IDLETEST NOTEST
 #endif
-
-EXC_REAL_BEGIN(system_reset, 0x100, 0x100)
-	SET_SCRATCH0(r13)
-	/*
-	 * MSR_RI is not enabled, because PACA_EXNMI and nmi stack is
-	 * being used, so a nested NMI exception would corrupt it.
-	 */
-	EXCEPTION_PROLOG_NORI(PACA_EXNMI, system_reset_common, EXC_STD,
-			      IDLETEST, 0x100)
-
+	INT_ENTRY	system_reset,0 /* real */
 EXC_REAL_END(system_reset, 0x100, 0x100)
-EXC_VIRT_NONE(0x4100, 0x100)
-TRAMP_KVM(PACA_EXNMI, 0x100)
+
+EXC_VIRT_NONE(0x4000, 0x100)
 
 #ifdef CONFIG_PPC_P7_NAP
+TRAMP_REAL_BEGIN(system_reset_idle_wake)
+	cmpwi	cr3,r5,2
+	BRANCH_TO_C000(r12, system_reset_idle_common)
+
 EXC_COMMON_BEGIN(system_reset_idle_common)
-	mfspr	r12,SPRN_SRR1
 	b	pnv_powersave_wakeup
 #endif
 
-/*
- * Set IRQS_ALL_DISABLED unconditionally so arch_irqs_disabled does
- * the right thing. We do not want to reconcile because that goes
- * through irq tracing which we don't want in NMI.
- *
- * Save PACAIRQHAPPENED because some code will do a hard disable
- * (e.g., xmon). So we want to restore this back to where it was
- * when we return. DAR is unused in the stack, so save it there.
- */
-#define ADD_RECONCILE_NMI						\
-	li	r10,IRQS_ALL_DISABLED;					\
-	stb	r10,PACAIRQSOFTMASK(r13);				\
-	lbz	r10,PACAIRQHAPPENED(r13);				\
+USE_TEXT_SECTION()
+	.balign IFETCH_ALIGN_BYTES
+DEFINE_FIXED_SYMBOL(system_reset_real)
+system_reset_real:
+	/* XXX: non-maskables my hit in KVM before MSR[HV] is clear, should
+	 * they be testing the HSTATE instead?
+	 */
+	INT_KVM_TEST .L_system_reset_REG_SCRATCH, .L_system_reset_REG_SRR1, system_reset_kvm
+
+	ld	.L_system_reset_REG_STACK,PACA_NMI_EMERG_SP(r13)
+	subi	.L_system_reset_REG_STACK,.L_system_reset_REG_STACK,INT_FRAME_SIZE
+	INT_SETUP_C	system_reset
+
+	/* XXX: also save away and restore HSRRs? */
+
+	/*
+	 * Save PACAIRQHAPPENED because some code will do a hard disable
+	 * (e.g., xmon). So we want to restore this back to where it was
+	 * when we return. DAR is unused in the stack, so save it there.
+	 */
+	lbz	r10,PACAIRQHAPPENED(r13)
 	std	r10,_DAR(r1)
 
-EXC_COMMON_BEGIN(system_reset_common)
 	/*
 	 * Increment paca->in_nmi then enable MSR_RI. SLB or MCE will be able
 	 * to recover, but nested NMI will notice in_nmi and not recover
@@ -165,22 +1110,17 @@ EXC_COMMON_BEGIN(system_reset_common)
 	lhz	r10,PACA_IN_NMI(r13)
 	addi	r10,r10,1
 	sth	r10,PACA_IN_NMI(r13)
+
 	li	r10,MSR_RI
 	mtmsrd 	r10,1
 
-	mr	r10,r1
-	ld	r1,PACA_NMI_EMERG_SP(r13)
-	subi	r1,r1,INT_FRAME_SIZE
-	EXCEPTION_COMMON_NORET_STACK(PACA_EXNMI, 0x100,
-			system_reset, system_reset_exception,
-			ADD_NVGPRS;ADD_RECONCILE_NMI)
+	INT_RESTORE_REGS system_reset
+	bl	save_nvgprs
+	bl	system_reset_exception
 
-	/* This (and MCE) can be simplified with mtmsrd L=1 */
 	/* Clear MSR_RI before setting SRR0 and SRR1. */
-	li	r0,MSR_RI
-	mfmsr	r9
-	andc	r9,r9,r0
-	mtmsrd	r9,1
+	li	r10,0
+	mtmsrd	r10,1
 
 	/*
 	 * MSR_RI is clear, now we can decrement paca->in_nmi.
@@ -197,11 +1137,6 @@ EXC_COMMON_BEGIN(system_reset_common)
 	ld	r10,SOFTE(r1)
 	stb	r10,PACAIRQSOFTMASK(r13)
 
-	/*
-	 * Keep below code in synch with MACHINE_CHECK_HANDLER_WINDUP.
-	 * Should share common bits...
-	 */
-
 	/* Move original SRR0 and SRR1 into the respective regs */
 	ld	r9,_MSR(r1)
 	mtspr	SPRN_SRR1,r9
@@ -224,40 +1159,136 @@ EXC_COMMON_BEGIN(system_reset_common)
 	ld	r1,GPR1(r1)
 	RFI_TO_USER_OR_KERNEL
 
+	INT_KVM		system_reset,0 /* !skip */
+
+
 #ifdef CONFIG_PPC_PSERIES
 /*
- * Vectors for the FWNMI option.  Share common code.
+ * Vector for the FWNMI option, defined the same as primary vector.
  */
+#define int_define_system_reset_fwnmi int_define_system_reset
+
+INT_DEFINE system_reset_fwnmi
 TRAMP_REAL_BEGIN(system_reset_fwnmi)
-	SET_SCRATCH0(r13)		/* save r13 */
-	/* See comment at system_reset exception */
-	EXCEPTION_PROLOG_NORI(PACA_EXNMI, system_reset_common, EXC_STD,
-			      NOTEST, 0x100)
+	.globl system_reset_fwnmi
+	INT_ENTRY	system_reset_fwnmi,0 /* real */
+
+USE_TEXT_SECTION()
+	.balign IFETCH_ALIGN_BYTES
+DEFINE_FIXED_SYMBOL(system_reset_fwnmi_real)
+system_reset_fwnmi_real:
+	b	system_reset_real
 #endif /* CONFIG_PPC_PSERIES */
 
 
-EXC_REAL_BEGIN(machine_check, 0x200, 0x100)
-	/* This is moved out of line as it can be patched by FW, but
-	 * some code path might still want to branch into the original
-	 * vector
+.macro int_define_machine_check name
+/*
+ * Machine Check (MCE) is a non-maskable interrupt always taken in real-mode.
+ * It can be synchronous or asynchronous, caused by hardware or software,
+ * and it may be taken in a power-saving state.
+ *
+ * Handling:
+ * Similarly to system reset, this uses its own stack and PACA save area,
+ * the difference is re-entrancy is allowed.
+ *
+ *   powernv:
+ *   - Run machine_check_early in real mode, which decodes the machine check
+ *     and tries to handle it if possible (e.g., by flushing SLB if it had an
+ *     error). 
+ *   - Then test for power save wakeup condition. This is done after the
+ *     early handling because the wakeup process involves restoring
+ *     registers (e.g., SLB) and turning on MMU which may be involved in
+ *     the error, so could cause more failures.
+ *   - In case of power save wakeup, queue up the machine check event, which
+ *     leaves it to be handled by an irq_work handler which will fire after
+ *     the powersave wakeup is done. (XXX: this may not quite do the right
+ *     thing for KVM H_CEDE wakeups that should go to guest and not be
+ *     queued as a host event)
+ *   - If it was not a powersave, then test if it came from a guest context,
+ *     and if so, then call into KVM to handle it. (XXX: This may not be
+ *     strictly the right place in the case of asynchronous machine checks.
+ *     Possibly there is a way to fence failure domains?)
+ *   - If it was from host, then if it was from kernel mode, queue an event
+ *     and return for irq_work to handle it when interrupts are next enabled.
+ *   - If it was from user mode, handle it right away.
+ *
+ *   pseries:
+ *   - Guest mode is much simpler, no low-level call is made, just handle
+ *     it immediately.
+ *
+ * KVM:
+ * This can hit when a guest is running. Powernv handles it according to
+ * above. pseries (XXX -- PR KVM? Need to fix this up)
+ */
+	IVEC=0x200
+	ISIZE=0x100
+	IREAL=1
+	IVIRT=0
+#ifdef CONFIG_KVM_BOOK3S_64_HANDLER
+	IKVM_REAL=1
+#else
+	IKVM_REAL=0
+#endif
+	IINTS_ON=0
+	IHSRR=0
+	IAREA=PACA_EXMC
+	IINTS=0
+	IASYNC=0	/* XXX: sreset and mce are actually async */
+	/* XXX: original code had FINISH_NAP here */
+	IMASK=0
+	ICFAR=1
+	IPPR=1
+	ITB=0
+	IDATA=1
+	/*
+	 * Machine check may be d-side or i-side, but the handler explicitly
+ 	 * checks regs->nip for that, so save the d-side regs to dar/dsisr.
 	 */
-	SET_SCRATCH0(r13)		/* save r13 */
-	EXCEPTION_PROLOG_0(PACA_EXMC)
-BEGIN_FTR_SECTION
-	b	machine_check_common_early
-FTR_SECTION_ELSE
-	b	machine_check_pSeries_0
-ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
+	IISIDE=0
+	IDAR=1
+	IDSISR=1
+.endm
+
+INT_DEFINE machine_check
+
+EXC_REAL_BEGIN(machine_check, 0x200, 0x100)
+	INT_ENTRY	machine_check,0 /* real */
 EXC_REAL_END(machine_check, 0x200, 0x100)
+
 EXC_VIRT_NONE(0x4200, 0x100)
-TRAMP_REAL_BEGIN(machine_check_common_early)
-	EXCEPTION_PROLOG_1(PACA_EXMC, NOTEST, 0x200)
+
+USE_TEXT_SECTION()
+enable_msr_me:
+	mflr	r0
+	bcl	20,31,$+4
+0:      mflr	r3
+	addi	r3,r3,(1f - 0b)
+	mtspr	SPRN_SRR0,r3
+	mfmsr	r3
+	ori	r3,r3,MSR_ME
+	mtspr	SPRN_SRR1,r3
+	RFI_TO_KERNEL
+1:      mtlr    r0
+	blr
+
+disable_msr_me:
+	mflr	r0
+	bcl	20,31,$+4
+0:      mflr	r3
+	addi	r3,r3,(1f - 0b)
+	mtspr	SPRN_SRR0,r3
+	mfmsr	r3
+	ori	r3,r3,MSR_ME
+	xori	r3,r3,MSR_ME
+	mtspr	SPRN_SRR1,r3
+	RFI_TO_KERNEL
+1:      mtlr    r0
+	blr
+
+	.balign IFETCH_ALIGN_BYTES
+DEFINE_FIXED_SYMBOL(machine_check_real)
+machine_check_real:
 	/*
-	 * Register contents:
-	 * R13		= PACA
-	 * R9		= CR
-	 * Original R9 to R13 is saved on PACA_EXMC
-	 *
 	 * Switch to mc_emergency stack and handle re-entrancy (we limit
 	 * the nested MCE upto level 4 to avoid stack overflow).
 	 * Save MCE registers srr1, srr0, dar and dsisr and then set ME=1
@@ -278,127 +1309,175 @@ TRAMP_REAL_BEGIN(machine_check_common_early)
 	 * the machine check is handled then the idle wakeup code is called
 	 * to restore state.
 	 */
-	mr	r11,r1			/* Save r1 */
-	lhz	r10,PACA_IN_MCE(r13)
-	cmpwi	r10,0			/* Are we in nested machine check */
-	bne	0f			/* Yes, we are. */
-	/* First machine check entry */
-	ld	r1,PACAMCEMERGSP(r13)	/* Use MC emergency stack */
-0:	subi	r1,r1,INT_FRAME_SIZE	/* alloc stack frame */
-	addi	r10,r10,1		/* increment paca->in_mce */
-	sth	r10,PACA_IN_MCE(r13)
+
+	ld	.L_machine_check_REG_STACK,PACA_NMI_EMERG_SP(r13)
+	/* Are we in nested machine check? */
+	lhz	.L_machine_check_REG_SCRATCH,PACA_IN_MCE(r13)
+	cmpwi	.L_machine_check_REG_SCRATCH,0
+	beq	1f
+	/* If yes, then use existing r1 stack */
+	mr	.L_machine_check_REG_STACK,r1
+1:
+	subi	.L_machine_check_REG_STACK,.L_machine_check_REG_STACK,INT_FRAME_SIZE
+	/* Now increment paca->in_mce */
+	addi	.L_machine_check_REG_SCRATCH,.L_machine_check_REG_SCRATCH,1
+	sth	.L_machine_check_REG_SCRATCH,PACA_IN_MCE(r13)
+
 	/* Limit nested MCE to level 4 to avoid stack overflow */
-	cmpwi	r10,MAX_MCE_DEPTH
-	bgt	2f			/* Check if we hit limit of 4 */
-	std	r11,GPR1(r1)		/* Save r1 on the stack. */
-	std	r11,0(r1)		/* make stack chain pointer */
-	mfspr	r11,SPRN_SRR0		/* Save SRR0 */
-	std	r11,_NIP(r1)
-	mfspr	r11,SPRN_SRR1		/* Save SRR1 */
-	std	r11,_MSR(r1)
-	mfspr	r11,SPRN_DAR		/* Save DAR */
-	std	r11,_DAR(r1)
-	mfspr	r11,SPRN_DSISR		/* Save DSISR */
-	std	r11,_DSISR(r1)
-	std	r9,_CCR(r1)		/* Save CR in stackframe */
-	/* Save r9 through r13 from EXMC save area to stack frame. */
-	EXCEPTION_PROLOG_COMMON_2(PACA_EXMC)
-	mfmsr	r11			/* get MSR value */
+	cmpwi	cr2,.L_machine_check_REG_SCRATCH,MAX_MCE_DEPTH
+	ble	cr2,1f
+	/* Stack overflow, go back to previous stack frame */
+	addi	.L_machine_check_REG_STACK,.L_machine_check_REG_STACK,INT_FRAME_SIZE
+1:
+	INT_SETUP_C	machine_check
+
+	INT_RESTORE_REGS machine_check
+	bl	save_nvgprs
+
+	ble	cr2,1f 
+	/*
+	 * Stack overflow case
+	 * Invoke machine_check_exception to print MCE event and panic.
+	 */
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	machine_check_exception
+	b	.
+1:
+	/*
+	 * Test recoverability. We are going down. But there are chances that
+	 * we might get hit by another MCE during panic path and we may run
+	 * into unstable state with no way out. Hence, do this before turning
+	 * ME bit on, so that when another MCE is hit during panic path,
+	 * system will checkstop and hypervisor will get restarted cleanly by
+	 * SP.
+	 */
+	ld	r12,_MSR(r1)
+	andi.	r11,r12,MSR_RI
+	bne	1f
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	machine_check_exception
+	b	.
+1:
+
 BEGIN_FTR_SECTION
-	ori	r11,r11,MSR_ME		/* turn on ME bit */
+	bl	enable_msr_me
 END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
-	ori	r11,r11,MSR_RI		/* turn on RI bit */
-	LOAD_HANDLER(r12, machine_check_handle_early)
-1:	mtspr	SPRN_SRR0,r12
-	mtspr	SPRN_SRR1,r11
-	RFI_TO_KERNEL
-	b	.	/* prevent speculative execution */
-2:
-	/* Stack overflow. Stay on emergency stack and panic.
-	 * Keep the ME bit off while panic-ing, so that if we hit
-	 * another machine check we checkstop.
-	 */
-	addi	r1,r1,INT_FRAME_SIZE	/* go back to previous stack frame */
-	ld	r11,PACAKMSR(r13)
-	LOAD_HANDLER(r12, unrecover_mce)
-	li	r10,MSR_ME
-	andc	r11,r11,r10		/* Turn off MSR_ME */
-	b	1b
-	b	.	/* prevent speculative execution */
-
-TRAMP_REAL_BEGIN(machine_check_pSeries)
-	.globl machine_check_fwnmi
-machine_check_fwnmi:
-	SET_SCRATCH0(r13)		/* save r13 */
-	EXCEPTION_PROLOG_0(PACA_EXMC)
+	li	r10,MSR_RI
+	mtmsrd	r10,1
+
 BEGIN_FTR_SECTION
-	b	machine_check_common_early
-END_FTR_SECTION_IFCLR(CPU_FTR_HVMODE)
-machine_check_pSeries_0:
-	EXCEPTION_PROLOG_1(PACA_EXMC, KVMTEST_PR, 0x200)
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	machine_check_early
+	std	r3,RESULT(r1)	/* Save result */
+END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
+
+	/* XXX: check result?? */
+
+	ld	r12,_MSR(r1)
+
+#ifdef	CONFIG_PPC_P7_NAP
 	/*
-	 * MSR_RI is not enabled, because PACA_EXMC is being used, so a
-	 * nested machine check corrupts it. machine_check_common enables
-	 * MSR_RI.
+	 * Check if thread was in power saving mode. If it was, queue the event
+	 * and go through the powersave wakeup.
 	 */
-	EXCEPTION_PROLOG_2_NORI(machine_check_common, EXC_STD)
+	BEGIN_FTR_SECTION
+	rlwinm.	r11,r12,47-31,30,31
+	bne	machine_check_idle_common
+	END_FTR_SECTION_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
+#endif
 
-TRAMP_KVM_SKIP(PACA_EXMC, 0x200)
+#ifdef CONFIG_KVM_BOOK3S_64_HANDLER
+BEGIN_FTR_SECTION
+	/*
+	 * Check if we are coming from guest. If yes, then set up the KVM
+	 * interrupt and branch to it.
+	 */
+	lbz	r11,HSTATE_IN_GUEST(r13)
+	cmpwi	r11,0
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bne	machine_check_kvm
+END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
+#endif
 
-EXC_COMMON_BEGIN(machine_check_common)
 	/*
-	 * Machine check is different because we use a different
-	 * save area: PACA_EXMC instead of PACA_EXGEN.
+	 * At this point we are not coming from a guest, deliver the machine
+	 * check with machine_check_exception. Except in the case of HV mode,
+	 * where we queue the event if it hit in the kernel (XXX: unclear
+	 * why this is done for host not guest).
 	 */
-	mfspr	r10,SPRN_DAR
-	std	r10,PACA_EXMC+EX_DAR(r13)
-	mfspr	r10,SPRN_DSISR
-	stw	r10,PACA_EXMC+EX_DSISR(r13)
-	EXCEPTION_PROLOG_COMMON(0x200, PACA_EXMC)
-	FINISH_NAP
-	RECONCILE_IRQ_STATE(r10, r11)
-	ld	r3,PACA_EXMC+EX_DAR(r13)
-	lwz	r4,PACA_EXMC+EX_DSISR(r13)
-	/* Enable MSR_RI when finished with PACA_EXMC */
-	li	r10,MSR_RI
-	mtmsrd 	r10,1
-	std	r3,_DAR(r1)
-	std	r4,_DSISR(r1)
-	bl	save_nvgprs
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	machine_check_exception
-	b	ret_from_except
 
-#define MACHINE_CHECK_HANDLER_WINDUP			\
-	/* Clear MSR_RI before setting SRR0 and SRR1. */\
-	li	r0,MSR_RI;				\
-	mfmsr	r9;		/* get MSR value */	\
-	andc	r9,r9,r0;				\
-	mtmsrd	r9,1;		/* Clear MSR_RI */	\
-	/* Move original SRR0 and SRR1 into the respective regs */	\
-	ld	r9,_MSR(r1);				\
-	mtspr	SPRN_SRR1,r9;				\
-	ld	r3,_NIP(r1);				\
-	mtspr	SPRN_SRR0,r3;				\
-	ld	r9,_CTR(r1);				\
-	mtctr	r9;					\
-	ld	r9,_XER(r1);				\
-	mtxer	r9;					\
-	ld	r9,_LINK(r1);				\
-	mtlr	r9;					\
-	REST_GPR(0, r1);				\
-	REST_8GPRS(2, r1);				\
-	REST_GPR(10, r1);				\
-	ld	r11,_CCR(r1);				\
-	mtcr	r11;					\
-	/* Decrement paca->in_mce. */			\
-	lhz	r12,PACA_IN_MCE(r13);			\
-	subi	r12,r12,1;				\
-	sth	r12,PACA_IN_MCE(r13);			\
-	REST_GPR(11, r1);				\
-	REST_2GPRS(12, r1);				\
-	/* restore original r1. */			\
+BEGIN_FTR_SECTION
+	andi.	r11,r12,MSR_PR
+	bne	1f
+	bl	machine_check_queue_event
+	b	2f
+END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
+	/* User mode or !HVMODE */
+1:	bl	machine_check_exception
+
+2:	/* Return from interrupt */
+	bl	disable_msr_me
+	/* MSR[RI] may remain on, for system reset */
+
+	lhz	r12,PACA_IN_MCE(r13)
+	subi	r12,r12,1
+	sth	r12,PACA_IN_MCE(r13)
+
+	/*
+	 * Restore soft mask settings.
+	 */
+	ld	r10,_DAR(r1)
+	stb	r10,PACAIRQHAPPENED(r13)
+	ld	r10,SOFTE(r1)
+	stb	r10,PACAIRQSOFTMASK(r13)
+
+	/* Move original SRR0 and SRR1 into the respective regs */
+	ld	r9,_MSR(r1)
+	mtspr	SPRN_SRR1,r9
+	ld	r3,_NIP(r1)
+	mtspr	SPRN_SRR0,r3
+	ld	r9,_CTR(r1)
+	mtctr	r9
+	ld	r9,_XER(r1)
+	mtxer	r9
+	ld	r9,_LINK(r1)
+	mtlr	r9
+	REST_GPR(0, r1)
+	REST_8GPRS(2, r1)
+	REST_GPR(10, r1)
+	ld	r11,_CCR(r1)
+	mtcr	r11
+	REST_GPR(11, r1)
+	REST_2GPRS(12, r1)
+	/* restore original r1. */
 	ld	r1,GPR1(r1)
+	RFI_TO_USER_OR_KERNEL
+
+	/* Both pseries and powernv (after early) come in here */
+machine_check_common:
+	INT_KVM_TEST .L_machine_check_REG_SCRATCH, .L_machine_check_REG_SRR1, machine_check_kvm
+
+	bl	machine_check_exception
+
+
+#ifdef CONFIG_PPC_PSERIES
+/*
+ * Vector for the FWNMI option, defined the same as primary vector.
+ */
+#define int_define_machine_check_fwnmi int_define_machine_check
+INT_DEFINE machine_check_fwnmi
+
+TRAMP_REAL_BEGIN(machine_check_fwnmi)
+	.globl machine_check_fwnmi
+	INT_ENTRY	machine_check_fwnmi,0 /* real */
+
+USE_TEXT_SECTION()
+	.balign IFETCH_ALIGN_BYTES
+DEFINE_FIXED_SYMBOL(machine_check_fwnmi_real)
+machine_check_fwnmi_real:
+	b	machine_check_real
+#endif
 
 #ifdef CONFIG_PPC_P7_NAP
 /*
@@ -421,312 +1500,529 @@ EXC_COMMON_BEGIN(machine_check_idle_common)
 	ld	r3,_MSR(r1)
 
 	lhz	r11,PACA_IN_MCE(r13)
-	subi	r11,r11,1
-	sth	r11,PACA_IN_MCE(r13)
-
-	/* Turn off the RI bit because SRR1 is used by idle wakeup code. */
-	/* Recoverability could be improved by reducing the use of SRR1. */
-	li	r11,0
-	mtmsrd	r11,1
-
-	b	pnv_powersave_wakeup_mce
-#endif
-	/*
-	 * Handle machine check early in real mode. We come here with
-	 * ME=1, MMU (IR=0 and DR=0) off and using MC emergency stack.
-	 */
-EXC_COMMON_BEGIN(machine_check_handle_early)
-	std	r0,GPR0(r1)	/* Save r0 */
-	EXCEPTION_PROLOG_COMMON_3(0x200)
-	bl	save_nvgprs
-	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	machine_check_early
-	std	r3,RESULT(r1)	/* Save result */
-	ld	r12,_MSR(r1)
-BEGIN_FTR_SECTION
-	b	4f
-END_FTR_SECTION_IFCLR(CPU_FTR_HVMODE)
-
-#ifdef	CONFIG_PPC_P7_NAP
-	/*
-	 * Check if thread was in power saving mode. We come here when any
-	 * of the following is true:
-	 * a. thread wasn't in power saving mode
-	 * b. thread was in power saving mode with no state loss,
-	 *    supervisor state loss or hypervisor state loss.
-	 *
-	 * Go back to nap/sleep/winkle mode again if (b) is true.
-	 */
-	BEGIN_FTR_SECTION
-	rlwinm.	r11,r12,47-31,30,31
-	bne	machine_check_idle_common
-	END_FTR_SECTION_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
-#endif
+	subi	r11,r11,1
+	sth	r11,PACA_IN_MCE(r13)
 
-	/*
-	 * Check if we are coming from hypervisor userspace. If yes then we
-	 * continue in host kernel in V mode to deliver the MC event.
-	 */
-	rldicl.	r11,r12,4,63		/* See if MC hit while in HV mode. */
-	beq	5f
-4:	andi.	r11,r12,MSR_PR		/* See if coming from user. */
-	bne	9f			/* continue in V mode if we are. */
+	/* Turn off the RI bit because SRR1 is used by idle wakeup code. */
+	/* Recoverability could be improved by reducing the use of SRR1. */
+	li	r11,0
+	mtmsrd	r11,1
 
-5:
-#ifdef CONFIG_KVM_BOOK3S_64_HANDLER
-BEGIN_FTR_SECTION
-	/*
-	 * We are coming from kernel context. Check if we are coming from
-	 * guest. if yes, then we can continue. We will fall through
-	 * do_kvm_200->kvmppc_interrupt to deliver the MC event to guest.
-	 */
-	lbz	r11,HSTATE_IN_GUEST(r13)
-	cmpwi	r11,0			/* Check if coming from guest */
-	bne	9f			/* continue if we are. */
-END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
+	b	pnv_powersave_wakeup_mce
 #endif
-	/*
-	 * At this point we are not sure about what context we come from.
-	 * Queue up the MCE event and return from the interrupt.
-	 * But before that, check if this is an un-recoverable exception.
-	 * If yes, then stay on emergency stack and panic.
-	 */
-	andi.	r11,r12,MSR_RI
-	bne	2f
-1:	mfspr	r11,SPRN_SRR0
-	LOAD_HANDLER(r10,unrecover_mce)
-	mtspr	SPRN_SRR0,r10
-	ld	r10,PACAKMSR(r13)
-	/*
-	 * We are going down. But there are chances that we might get hit by
-	 * another MCE during panic path and we may run into unstable state
-	 * with no way out. Hence, turn ME bit off while going down, so that
-	 * when another MCE is hit during panic path, system will checkstop
-	 * and hypervisor will get restarted cleanly by SP.
-	 */
-	li	r3,MSR_ME
-	andc	r10,r10,r3		/* Turn off MSR_ME */
-	mtspr	SPRN_SRR1,r10
-	RFI_TO_KERNEL
-	b	.
-2:
-	/*
-	 * Check if we have successfully handled/recovered from error, if not
-	 * then stay on emergency stack and panic.
-	 */
-	ld	r3,RESULT(r1)	/* Load result */
-	cmpdi	r3,0		/* see if we handled MCE successfully */
 
-	beq	1b		/* if !handled then panic */
-BEGIN_FTR_SECTION
-	/*
-	 * Return from MC interrupt.
-	 * Queue up the MCE event so that we can log it later, while
-	 * returning from kernel or opal call.
-	 */
-	bl	machine_check_queue_event
-	MACHINE_CHECK_HANDLER_WINDUP
-	RFI_TO_USER_OR_KERNEL
-FTR_SECTION_ELSE
-	/*
-	 * pSeries: Return from MC interrupt. Before that stay on emergency
-	 * stack and call machine_check_exception to log the MCE event.
-	 */
-	LOAD_HANDLER(r10,mce_return)
-	mtspr	SPRN_SRR0,r10
-	ld	r10,PACAKMSR(r13)
-	mtspr	SPRN_SRR1,r10
-	RFI_TO_KERNEL
-	b	.
-ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
-9:
-	/* Deliver the machine check to host kernel in V mode. */
-	MACHINE_CHECK_HANDLER_WINDUP
-	SET_SCRATCH0(r13)		/* save r13 */
-	EXCEPTION_PROLOG_0(PACA_EXMC)
-	b	machine_check_pSeries_0
+#ifdef CONFIG_KVM_BOOK3S_64_HANDLER
+EXC_COMMON_BEGIN(machine_check_kvm)
+	bl	disable_msr_me
+	li	r12,0
+	mtmsrd	r12,1
+
+	lhz	r12,PACA_IN_MCE(r13)
+	subi	r12,r12,1
+	sth	r12,PACA_IN_MCE(r13)
 
-EXC_COMMON_BEGIN(unrecover_mce)
-	/* Invoke machine_check_exception to print MCE event and panic. */
-	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	machine_check_exception
 	/*
-	 * We will not reach here. Even if we did, there is no way out. Call
-	 * unrecoverable_exception and die.
+	 * Restore soft mask settings.
 	 */
-1:	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	unrecoverable_exception
-	b	1b
+	ld	r10,_DAR(r1)
+	stb	r10,PACAIRQHAPPENED(r13)
+	ld	r10,SOFTE(r1)
+	stb	r10,PACAIRQSOFTMASK(r13)
 
-EXC_COMMON_BEGIN(mce_return)
-	/* Invoke machine_check_exception to print MCE event and return. */
-	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	machine_check_exception
-	MACHINE_CHECK_HANDLER_WINDUP
-	RFI_TO_KERNEL
-	b	.
+	/* Move original SRR0 and SRR1 into the respective regs */
+	ld	r9,_MSR(r1)
+	mtspr	SPRN_SRR1,r9
+	ld	r3,_NIP(r1)
+	mtspr	SPRN_SRR0,r3
+	ld	r9,_CTR(r1)
+	mtctr	r9
+	ld	r9,_XER(r1)
+	mtxer	r9
+	ld	r9,_LINK(r1)
+	mtlr	r9
+	REST_GPR(0, r1)
+	REST_8GPRS(2, r1)
+	REST_GPR(10, r1)
+	ld	r11,_CCR(r1)
+	mtcr	r11
+	REST_GPR(11, r1)
+	REST_GPR(12, r1)
 
-EXC_REAL(data_access, 0x300, 0x80)
-EXC_VIRT(data_access, 0x4300, 0x80, 0x300)
-TRAMP_KVM_SKIP(PACA_EXGEN, 0x300)
+	/* Set up KVM call. */
+	std	r12,HSTATE_SCRATCH0(r13)
 
-EXC_COMMON_BEGIN(data_access_common)
-	/*
-	 * Here r13 points to the paca, r9 contains the saved CR,
-	 * SRR0 and SRR1 are saved in r11 and r12,
-	 * r9 - r13 are saved in paca->exgen.
-	 */
-	mfspr	r10,SPRN_DAR
-	std	r10,PACA_EXGEN+EX_DAR(r13)
-	mfspr	r10,SPRN_DSISR
-	stw	r10,PACA_EXGEN+EX_DSISR(r13)
-	EXCEPTION_PROLOG_COMMON(0x300, PACA_EXGEN)
-	RECONCILE_IRQ_STATE(r10, r11)
-	ld	r12,_MSR(r1)
-	ld	r3,PACA_EXGEN+EX_DAR(r13)
-	lwz	r4,PACA_EXGEN+EX_DSISR(r13)
-	li	r5,0x300
-	std	r3,_DAR(r1)
-	std	r4,_DSISR(r1)
+	ld	r12,ORIG_GPR3(r1)
+	std	r12,HSTATE_CFAR(r13)
+	ld	r12,_PPR(r1)
+	std     r12,HSTATE_PPR(r13)
+
+#ifdef CONFIG_RELOCATABLE
+	mfctr	r12
+	std	r12,HSTATE_SCRATCH1(r13)
+#endif
+	mfcr	r12
+	sldi	r12,r12,32
+	ori	r12,r12,0x200
+
+	/* restore original r1. */
+	ld	r1,GPR1(r1)
+
+	b	kvmppc_interrupt
+#endif
+
+.macro int_define_data_access name
+/*
+ * Data Storage (DSI) is a synchronous interrupt in response to an MMU fault or
+ * DAWR match, or faults in other data operations like copy-paste, AMO, etc.
+ *
+ * Handling:
+ * On HPT this will go to a hash fault first to see if the HPT can be filled
+ * from an entry in the Linux page table, if none is found, do a Linux page
+ * fault. On RPT it means HW found no entry in the Linux-HW page table so go
+ * straight to page fault.
+ *
+ * Side errors like DAWR are handled along the way.
+ *
+ * Hash fault keeps interrupts off because it can hit in a kernel region
+ * where interrupts were off.
+ *
+ * CFAR is saved to report bad page faults.
+ *
+ * KVM:
+ * This can hit when a guest is running for PR-KVM. HV-KVM will take HDSIs.
+ * KVM will perform the access, so the KVM handler skips on return.
+ */
+	IVEC=0x300
+	ISIZE=0x80
+	IREAL=1
+	IVIRT=1
+#ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
+	IKVM_REAL=1
+	IKVM_VIRT=1
+#else
+	IKVM_REAL=0
+	IKVM_VIRT=0
+#endif
+	IINTS_ON=1
+	IHSRR=0
+	IAREA=PACA_EXGEN
+	IINTS=0
+	IASYNC=0
+	IMASK=0
+	ICFAR=1
+	IPPR=1
+	ITB=0
+	IDATA=1
+	IISIDE=0
+	IDAR=1
+	IDSISR=1
+.endm
+
+INT_DEFINE data_access
+
+EXC_REAL_BEGIN(data_access, 0x300, 0x80)
+	INT_ENTRY	data_access,0 /* real */
+EXC_REAL_END(data_access, 0x300, 0x80)
+
+EXC_VIRT_BEGIN(data_access, 0x4300, 0x80)
+	INT_ENTRY	data_access,1 /* virt */
+EXC_VIRT_END(data_access, 0x4300, 0x80)
+
+USE_TEXT_SECTION()
+	INT_COMMON	data_access
 BEGIN_MMU_FTR_SECTION
+	li	r6,0x300
 	b	do_hash_page		/* Try to handle as hpte fault */
 MMU_FTR_SECTION_ELSE
 	b	handle_page_fault
 ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_TYPE_RADIX)
 
+	INT_KVM		data_access,1 /* skip */
+
+
+.macro int_define_data_access_slb name
+/*
+ * Data Segment (DSLB) is a synchronous interrupt in response to an MMU fault
+ * missing SLB entry for HPT, or an address outside RPT translation address.
+ *
+ * Handling:
+ * On HPT this refills the SLB. The user-mode SLB handler can touch any data
+ * because it is allowed to take a recursive kernel-mode DSLB. The kernel
+ * mode handler must be careful. The stack can be accessed because it has a
+ * bolted SLB, but no arbitrary data that is not allocated carefully (e.g.,
+ * see paca alloation).
+ *
+ * A dedicated save area EXSLB is used (XXX: but it actually need not be
+ * these days, we could use EXGEN).
+ *
+ * CFAR is saved to report bad SLB faults.
+ *
+ * KVM:
+ * This can hit when a guest is running for PR-KVM. HV-KVM does not take
+ * DSLBs for its guests.
+ * KVM will perform the access, so the KVM handler skips on return.
+ */
+	IVEC=0x380
+	ISIZE=0x80
+	IREAL=1
+	IVIRT=1
+#ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
+	IKVM_REAL=1
+	IKVM_VIRT=1
+#else
+	IKVM_REAL=0
+	IKVM_VIRT=0
+#endif
+	IINTS_ON=0
+	IHSRR=0
+	IAREA=PACA_EXSLB
+	IINTS=0
+	IASYNC=0
+	IMASK=0
+	ICFAR=1
+	/*
+	 * XXX: would not have to save IPPR if we did not restore it
+	 */
+	IPPR=1
+	ITB=0
+	IDATA=1
+	IISIDE=0
+	IDAR=1
+	IDSISR=0
+.endm
+
+INT_DEFINE data_access_slb
 
 EXC_REAL_BEGIN(data_access_slb, 0x380, 0x80)
-EXCEPTION_PROLOG(PACA_EXSLB, data_access_slb_common, EXC_STD, KVMTEST_PR, 0x380);
+	INT_ENTRY	data_access_slb,0 /* real */
 EXC_REAL_END(data_access_slb, 0x380, 0x80)
 
 EXC_VIRT_BEGIN(data_access_slb, 0x4380, 0x80)
-EXCEPTION_RELON_PROLOG(PACA_EXSLB, data_access_slb_common, EXC_STD, NOTEST, 0x380);
+	INT_ENTRY	data_access_slb,1 /* virt */
 EXC_VIRT_END(data_access_slb, 0x4380, 0x80)
 
-TRAMP_KVM_SKIP(PACA_EXSLB, 0x380)
-
-EXC_COMMON_BEGIN(data_access_slb_common)
-	mfspr	r10,SPRN_DAR
-	std	r10,PACA_EXSLB+EX_DAR(r13)
-	EXCEPTION_PROLOG_COMMON(0x380, PACA_EXSLB)
-	ld	r4,PACA_EXSLB+EX_DAR(r13)
-	std	r4,_DAR(r1)
-	addi	r3,r1,STACK_FRAME_OVERHEAD
+USE_TEXT_SECTION()
+	/* XXX: radix case? */
+	INT_COMMON	data_access_slb
 	bl	do_slb_fault
 	cmpdi	r3,0
 	bne-	1f
+	ld	r9,SOFTE(r1)
+	stb	r9,PACAIRQSOFTMASK(r13)
 	b	fast_exception_return
 1:	/* Error case */
 	std	r3,RESULT(r1)
 	bl	save_nvgprs
-	RECONCILE_IRQ_STATE(r10, r11)
 	ld	r4,_DAR(r1)
 	ld	r5,RESULT(r1)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	do_bad_slb_fault
 	b	ret_from_except
 
+	INT_KVM		data_access_slb,1 /* skip */
 
-EXC_REAL(instruction_access, 0x400, 0x80)
-EXC_VIRT(instruction_access, 0x4400, 0x80, 0x400)
-TRAMP_KVM(PACA_EXGEN, 0x400)
 
-EXC_COMMON_BEGIN(instruction_access_common)
-	EXCEPTION_PROLOG_COMMON(0x400, PACA_EXGEN)
-	RECONCILE_IRQ_STATE(r10, r11)
-	ld	r12,_MSR(r1)
-	ld	r3,_NIP(r1)
-	andis.	r4,r12,DSISR_SRR1_MATCH_64S@h
-	li	r5,0x400
-	std	r3,_DAR(r1)
-	std	r4,_DSISR(r1)
+.macro int_define_instruction_access name
+/*
+ * Instruction Storage (ISI) is a synchronous interrupt in response to an MMU
+ * fault due to an instruction fetch.
+ *
+ * Handling:
+ * Similar to DSI, though it is i-side, and the KVM handler does not perform
+ * the instruction so it is not skipped.
+ */
+	IVEC=0x400
+	ISIZE=0x80
+	IREAL=1
+	IVIRT=1
+#ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
+	IKVM_REAL=1
+	IKVM_VIRT=1
+#else
+	IKVM_REAL=0
+	IKVM_VIRT=0
+#endif
+	IINTS_ON=1
+	IHSRR=0
+	IAREA=PACA_EXGEN
+	IINTS=0
+	IASYNC=0
+	IMASK=0
+	ICFAR=1
+	IPPR=1
+	ITB=0
+	IDATA=1
+	IISIDE=1
+	IDAR=1
+	IDSISR=1
+.endm
+
+INT_DEFINE instruction_access
+
+EXC_REAL_BEGIN(instruction_access, 0x400, 0x80)
+	INT_ENTRY	instruction_access,0 /* real */
+EXC_REAL_END(instruction_access, 0x400, 0x80)
+
+EXC_VIRT_BEGIN(instruction_access, 0x4400, 0x80)
+	INT_ENTRY	instruction_access,1 /* virt */
+EXC_VIRT_END(instruction_access, 0x4400, 0x80)
+
+USE_TEXT_SECTION()
+	INT_COMMON	instruction_access
 BEGIN_MMU_FTR_SECTION
+	li	r6,0x400
 	b	do_hash_page		/* Try to handle as hpte fault */
 MMU_FTR_SECTION_ELSE
 	b	handle_page_fault
 ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_TYPE_RADIX)
 
+	INT_KVM		instruction_access,0 /* !skip */
+
+
+.macro int_define_instruction_access_slb name
+/*
+ * Instruction Segment (ISLB) is a synchronous interrupt in response to an MMU
+ * fault due to instruction fetch.
+ *
+ * Handling:
+ * Similar to DSLB, though it is i-side, and the KVM handler does not perform
+ * the instruction so it is not skipped.
+ */
+	IVEC=0x480
+	ISIZE=0x80
+	IREAL=1
+	IVIRT=1
+#ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
+	IKVM_REAL=1
+	IKVM_VIRT=1
+#else
+	IKVM_REAL=0
+	IKVM_VIRT=0
+#endif
+	IINTS_ON=0
+	IHSRR=0
+	IAREA=PACA_EXSLB
+	IINTS=0
+	IASYNC=0
+	IMASK=0
+	ICFAR=1
+	/*
+	 * XXX: would not have to save IPPR if we did not restore it
+	 */
+	IPPR=1
+	ITB=0
+	IDATA=1
+	IISIDE=1
+	IDAR=1
+	IDSISR=0
+.endm
+
+INT_DEFINE instruction_access_slb
 
 EXC_REAL_BEGIN(instruction_access_slb, 0x480, 0x80)
-EXCEPTION_PROLOG(PACA_EXSLB, instruction_access_slb_common, EXC_STD, KVMTEST_PR, 0x480);
+	INT_ENTRY	instruction_access_slb,0 /* real */
 EXC_REAL_END(instruction_access_slb, 0x480, 0x80)
 
 EXC_VIRT_BEGIN(instruction_access_slb, 0x4480, 0x80)
-EXCEPTION_RELON_PROLOG(PACA_EXSLB, instruction_access_slb_common, EXC_STD, NOTEST, 0x480);
+	INT_ENTRY	instruction_access_slb,1 /* virt */
 EXC_VIRT_END(instruction_access_slb, 0x4480, 0x80)
 
-TRAMP_KVM(PACA_EXSLB, 0x480)
-
-EXC_COMMON_BEGIN(instruction_access_slb_common)
-	EXCEPTION_PROLOG_COMMON(0x480, PACA_EXSLB)
-	ld	r4,_NIP(r1)
-	addi	r3,r1,STACK_FRAME_OVERHEAD
+USE_TEXT_SECTION()
+	INT_COMMON	instruction_access_slb
 	bl	do_slb_fault
 	cmpdi	r3,0
 	bne-	1f
+	ld	r9,SOFTE(r1)
+	stb	r9,PACAIRQSOFTMASK(r13)
 	b	fast_exception_return
 1:	/* Error case */
 	std	r3,RESULT(r1)
 	bl	save_nvgprs
-	RECONCILE_IRQ_STATE(r10, r11)
-	ld	r4,_NIP(r1)
+	ld	r4,_DAR(r1)
 	ld	r5,RESULT(r1)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	do_bad_slb_fault
 	b	ret_from_except
 
+	INT_KVM		instruction_access_slb,0 /* !skip */
+
+
+.macro int_define_hardware_interrupt name
+/*
+ * External is an asynchronous interrupt in response to an "external exception"
+ * from the interrupt controller e.g., PCI or XIVE IPI.  It is maskable in
+ * hardware by clearing MSR[EE], and soft-maskable with IRQS_DISABLED mask
+ * (i.e., local_irq_disable()).
+ *
+ * When running in HV mode, Linux sets up the LPCR[LPES] bit such that
+ * interrupts are delivered with HSRR registers, which requires IHSRR_HVMODE=1.
+ *
+ * Handling:
+ * This calls into Linux IRQ handler. NV-GPRs and CFAR are not saved, to
+ * reduce overhead. Registers at the time of the interrupt are not so
+ * important (XXX: unless using IC IPIs?)
+ *
+ * KVM:
+ * This can hit when a guest is running, so KVM must be called.
+ */
+	IVEC=0x500
+	ISIZE=0x100
+	IREAL=1
+	IVIRT=1
+#ifdef CONFIG_KVM_BOOK3S_64_HANDLER
+	IKVM_REAL=1
+	IKVM_VIRT=1
+#else
+	IKVM_REAL=0
+	IKVM_VIRT=0
+#endif
+	IINTS_ON=0
+	IHSRR=1
+	IHSRR_HVMODE=1
+	IAREA=PACA_EXGEN
+	IINTS=0
+	IASYNC=1
+	IMASK=IRQS_DISABLED
+	ICFAR=0
+	IPPR=1
+	ITB=0
+	IDATA=0
+.endm
+
+INT_DEFINE hardware_interrupt
+
+EXC_REAL_BEGIN(hardware_interrupt, 0x500, 0x80)
+	INT_ENTRY	hardware_interrupt,0 /* real */
+EXC_REAL_END(hardware_interrupt, 0x500, 0x80)
+
+EXC_VIRT_BEGIN(hardware_interrupt, 0x4500, 0x80)
+	INT_ENTRY	hardware_interrupt,1 /* virt */
+EXC_VIRT_END(hardware_interrupt, 0x4500, 0x80)
+
+USE_TEXT_SECTION()
+	INT_COMMON	hardware_interrupt
+	bl	do_IRQ
+	b	ret_from_except_lite
+
+	INT_KVM		hardware_interrupt,0 /* !skip */
 
-EXC_REAL_BEGIN(hardware_interrupt, 0x500, 0x100)
-	.globl hardware_interrupt_hv;
-hardware_interrupt_hv:
+.macro hardware_interrupt_masked_addition name
+	xori	IREG_SRR1,IREG_SRR1,MSR_EE	/* Disable EE in SRR1 */
 	BEGIN_FTR_SECTION
-		MASKABLE_EXCEPTION_HV(0x500, hardware_interrupt_common, IRQS_DISABLED)
+	mtspr	SPRN_HSRR1,IREG_SRR1
 	FTR_SECTION_ELSE
-		MASKABLE_EXCEPTION(0x500, hardware_interrupt_common, IRQS_DISABLED)
+	mtspr	SPRN_SRR1,IREG_SRR1
 	ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
-EXC_REAL_END(hardware_interrupt, 0x500, 0x100)
+.endm
 
-EXC_VIRT_BEGIN(hardware_interrupt, 0x4500, 0x100)
-	.globl hardware_interrupt_relon_hv;
-hardware_interrupt_relon_hv:
-	BEGIN_FTR_SECTION
-		MASKABLE_RELON_EXCEPTION_HV(0x500, hardware_interrupt_common,
-					    IRQS_DISABLED)
-	FTR_SECTION_ELSE
-		__MASKABLE_RELON_EXCEPTION(0x500, hardware_interrupt_common,
-					   EXC_STD, SOFTEN_TEST_PR, IRQS_DISABLED)
-	ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
-EXC_VIRT_END(hardware_interrupt, 0x4500, 0x100)
-
-TRAMP_KVM(PACA_EXGEN, 0x500)
-TRAMP_KVM_HV(PACA_EXGEN, 0x500)
-EXC_COMMON_ASYNC(hardware_interrupt_common, 0x500, do_IRQ)
-
-
-EXC_REAL(alignment, 0x600, 0x100)
-EXC_VIRT(alignment, 0x4600, 0x100, 0x600)
-TRAMP_KVM(PACA_EXGEN, 0x600)
-EXC_COMMON_BEGIN(alignment_common)
-	mfspr	r10,SPRN_DAR
-	std	r10,PACA_EXGEN+EX_DAR(r13)
-	mfspr	r10,SPRN_DSISR
-	stw	r10,PACA_EXGEN+EX_DSISR(r13)
-	EXCEPTION_PROLOG_COMMON(0x600, PACA_EXGEN)
-	ld	r3,PACA_EXGEN+EX_DAR(r13)
-	lwz	r4,PACA_EXGEN+EX_DSISR(r13)
-	std	r3,_DAR(r1)
-	std	r4,_DSISR(r1)
+	INT_MASKED	hardware_interrupt, PACA_IRQ_EE, 1
+
+	INT_REPLAY	hardware_interrupt
+
+
+.macro int_define_alignment name
+/*
+ * Alignment is a synchronous interrupt in response to data alignment
+ * fault.
+ *
+ * Handling:
+ * NVGPRs and CFAR are saved for debug
+ * XXX: don't need to load DSISR (older archs may put something here).
+ *
+ * KVM:
+ * This can hit when a guest is running for PR-KVM. HV-KVM is not involved.
+ */
+	IVEC=0x600
+	ISIZE=0x100
+	IREAL=1
+	IVIRT=1
+#ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
+	IKVM_REAL=1
+	IKVM_VIRT=1
+#else
+	IKVM_REAL=0
+	IKVM_VIRT=0
+#endif
+	IINTS_ON=0
+	IHSRR=0
+	IAREA=PACA_EXGEN
+	IINTS=0
+	IASYNC=0
+	IMASK=0
+	ICFAR=1
+	IPPR=1
+	ITB=0
+	IDATA=1
+	IISIDE=0
+	IDAR=1
+	IDSISR=1
+.endm
+
+INT_DEFINE alignment
+
+EXC_REAL_BEGIN(alignment, 0x600, 0x100)
+	INT_ENTRY	alignment,0 /* real */
+EXC_REAL_END(alignment, 0x600, 0x100)
+
+EXC_VIRT_BEGIN(alignment, 0x4600, 0x100)
+	INT_ENTRY	alignment,1 /* virt */
+EXC_VIRT_END(alignment, 0x4600, 0x100)
+
+USE_TEXT_SECTION()
+	INT_COMMON	alignment
 	bl	save_nvgprs
-	RECONCILE_IRQ_STATE(r10, r11)
-	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	alignment_exception
 	b	ret_from_except
 
+	INT_KVM		alignment,0 /* !skip */
+
+
+.macro int_define_program_check name
+/*
+ * Program is a synchronous interrupt in response to various instruction
+ * faults: traps, privilege errors, TM errors, floating point exception.
+ *
+ * Handling:
+ * NVGPRs and CFAR are saved for debug
+ *
+ * KVM:
+ * This can hit when a guest is running for PR-KVM. HV-KVM is not involved.
+ */
+	IVEC=0x700
+	ISIZE=0x100
+	IREAL=1
+	IVIRT=1
+#ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
+	IKVM_REAL=1
+	IKVM_VIRT=1
+#else
+	IKVM_REAL=0
+	IKVM_VIRT=0
+#endif
+	IINTS_ON=0
+	IHSRR=0
+	IAREA=PACA_EXGEN
+	IINTS=0
+	IASYNC=0
+	IMASK=0
+	ICFAR=1
+	IPPR=1
+	ITB=0
+	IDATA=0
+.endm
+
+INT_DEFINE program_check
+
+EXC_REAL_BEGIN(program_check, 0x700, 0x100)
+	INT_ENTRY	program_check,0 /* real */
+EXC_REAL_END(program_check, 0x700, 0x100)
+
+EXC_VIRT_BEGIN(program_check, 0x4700, 0x100)
+	INT_ENTRY	program_check,1 /* virt */
+EXC_VIRT_END(program_check, 0x4700, 0x100)
 
-EXC_REAL(program_check, 0x700, 0x100)
-EXC_VIRT(program_check, 0x4700, 0x100, 0x700)
-TRAMP_KVM(PACA_EXGEN, 0x700)
-EXC_COMMON_BEGIN(program_check_common)
+USE_TEXT_SECTION()
+.macro program_check_stack_addition name
 	/*
 	 * It's possible to receive a TM Bad Thing type program check with
 	 * userspace register values (in particular r1), but with SRR1 reporting
@@ -735,37 +2031,82 @@ EXC_COMMON_BEGIN(program_check_common)
 	 * we switch to the emergency stack if we're taking a TM Bad Thing from
 	 * the kernel.
 	 */
-	li	r10,MSR_PR		/* Build a mask of MSR_PR ..	*/
-	oris	r10,r10,0x200000@h	/* .. and SRR1_PROGTM		*/
-	and	r10,r10,r12		/* Mask SRR1 with that.		*/
-	srdi	r10,r10,8		/* Shift it so we can compare	*/
-	cmpldi	r10,(0x200000 >> 8)	/* .. with an immediate.	*/
-	bne 1f				/* If != go to normal path.	*/
-
-	/* SRR1 had PR=0 and SRR1_PROGTM=1, so use the emergency stack	*/
-	andi.	r10,r12,MSR_PR;		/* Set CR0 correctly for label	*/
-					/* 3 in EXCEPTION_PROLOG_COMMON	*/
-	mr	r10,r1			/* Save r1			*/
-	ld	r1,PACAEMERGSP(r13)	/* Use emergency stack		*/
-	subi	r1,r1,INT_FRAME_SIZE	/* alloc stack frame		*/
-	b 3f				/* Jump into the macro !!	*/
-1:	EXCEPTION_PROLOG_COMMON(0x700, PACA_EXGEN)
+
+	andi.	IREG_SCRATCH,IREG_SRR1,MSR_PR
+	bne	2f			/* If userspace, go normal path */
+
+	andis.	IREG_SCRATCH,IREG_SRR1,(SRR1_PROGTM)@h
+	bne	1f			/* If TM, emergency		*/
+
+	/* Check if the stack is within our kernel stack region */
+	ld	IREG_SCRATCH,PACAKSAVE(r13)
+	xor     IREG_SCRATCH,IREG_SCRATCH,IREG_STACK
+	srdi    IREG_SCRATCH,IREG_SCRATCH,THREAD_SHIFT
+	cmpdi	IREG_SCRATCH,0
+	beq	2f
+
+1:	/* Use the emergency stack */
+	ld	IREG_STACK,PACAEMERGSP(r13) /* Use emergency stack	*/
+	subi	IREG_STACK,IREG_STACK,INT_FRAME_SIZE
+2:
+.endm
+
+	INT_COMMON	program_check 1
 	bl	save_nvgprs
-	RECONCILE_IRQ_STATE(r10, r11)
-	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	program_check_exception
 	b	ret_from_except
 
+	INT_KVM		program_check,0 /* !skip */
+
+
+.macro int_define_fp_unavailable name
+/*
+ * Floating-Point Unavailable is a synchronous interrupt in response to
+ * executing an fp instruction with MSR[FP]=0
+ *
+ * Handling:
+ * CFAR is saved for debug. NVGPRs are saved in the case of a bug.
+ *
+ * KVM:
+ * This can hit when a guest is running for PR-KVM. HV-KVM is not involved.
+ */
+	IVEC=0x800
+	ISIZE=0x100
+	IREAL=1
+	IVIRT=1
+#ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
+	IKVM_REAL=1
+	IKVM_VIRT=1
+#else
+	IKVM_REAL=0
+	IKVM_VIRT=0
+#endif
+	IINTS_ON=0
+	IHSRR=0
+	IAREA=PACA_EXGEN
+	IINTS=0
+	IASYNC=0
+	IMASK=0
+	ICFAR=1
+	IPPR=1
+	ITB=0
+	IDATA=0
+.endm
+INT_DEFINE fp_unavailable
+
+EXC_REAL_BEGIN(fp_unavailable, 0x800, 0x100)
+	INT_ENTRY	fp_unavailable,0 /* real */
+EXC_REAL_END(fp_unavailable, 0x800, 0x100)
+
+EXC_VIRT_BEGIN(fp_unavailable, 0x4800, 0x100)
+	INT_ENTRY	fp_unavailable,1 /* virt */
+EXC_VIRT_END(fp_unavailable, 0x4800, 0x100)
 
-EXC_REAL(fp_unavailable, 0x800, 0x100)
-EXC_VIRT(fp_unavailable, 0x4800, 0x100, 0x800)
-TRAMP_KVM(PACA_EXGEN, 0x800)
-EXC_COMMON_BEGIN(fp_unavailable_common)
-	EXCEPTION_PROLOG_COMMON(0x800, PACA_EXGEN)
-	bne	1f			/* if from user, just load it up */
+USE_TEXT_SECTION()
+	INT_COMMON	fp_unavailable
+	ld	r12,_MSR(r1)		/* load_up_fpu wants SRR1 in r12 */
+	bne	cr2,1f			/* if from user, just load it up */
 	bl	save_nvgprs
-	RECONCILE_IRQ_STATE(r10, r11)
-	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	kernel_fp_unavailable_exception
 	BUG_OPCODE
 1:
@@ -778,44 +2119,251 @@ BEGIN_FTR_SECTION
 	bne-	2f
 END_FTR_SECTION_IFSET(CPU_FTR_TM)
 #endif
+	ld	r9,SOFTE(r1)
+	stb	r9,PACAIRQSOFTMASK(r13)
 	bl	load_up_fpu
 	b	fast_exception_return
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 2:	/* User process was in a transaction */
 	bl	save_nvgprs
-	RECONCILE_IRQ_STATE(r10, r11)
-	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	fp_unavailable_tm
 	b	ret_from_except
 #endif
 
+	INT_KVM		fp_unavailable,0 /* !skip */
+
+
+.macro int_define_decrementer name
+/*
+ * Decrementer is an asynchronous interrupt in response to a decrementer
+ * exception (e.g., DEC has wrapped below zero).
+ *
+ * It is maskable in hardware by clearing MSR[EE], and soft-maskable with
+ * IRQS_DISABLED mask (i.e., local_irq_disable()).
+ *
+ * Handling:
+ * This calls into Linux timer handler. NV-GPRs and CFAR are not saved, to
+ * reduce overhead.
+ *
+ * With the watchdog configured, then in the case this fires and while soft
+ * masked, code in the masked handler switches to emergency stack (which may
+ * only be used with MSR[EE]=0, so safe from races), and calls the watchdog
+ * "soft-nmi" handler. NVGPRs are saved in this case.
+ *
+ * KVM:
+ * This can hit when a guest is running for PR-KVM. HV-KVM is not involved.
+ */
+	IVEC=0x900
+	ISIZE=0x100
+	IREAL=1
+	IVIRT=1
+#ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
+	IKVM_REAL=1
+	IKVM_VIRT=1
+#else
+	IKVM_REAL=0
+	IKVM_VIRT=0
+#endif
+	IINTS_ON=0
+	IHSRR=0
+	IAREA=PACA_EXGEN
+	IINTS=0
+	IASYNC=1
+	IMASK=IRQS_DISABLED
+	ICFAR=0
+	IPPR=1
+	ITB=1
+	IDATA=0
+.endm
+
+INT_DEFINE decrementer
+
+EXC_REAL_BEGIN(decrementer, 0x900, 0x80)
+	INT_ENTRY	decrementer,0 /* real */
+EXC_REAL_END(decrementer, 0x900, 0x80)
+
+EXC_VIRT_BEGIN(decrementer, 0x4900, 0x80)
+	INT_ENTRY	decrementer,1 /* virt */
+EXC_VIRT_END(decrementer, 0x4900, 0x80)
+
+USE_TEXT_SECTION()
+	INT_COMMON	decrementer
+	bl	timer_interrupt_new
+	b	ret_from_except_lite
+
+	INT_KVM		decrementer,0 /* !skip */
+
+.macro decrementer_masked_addition name
+	lis	IREG_SCRATCH,0x7fff
+	ori	IREG_SCRATCH,IREG_SCRATCH,0xffff
+	mtspr	SPRN_DEC,IREG_SCRATCH
+
+#ifdef CONFIG_PPC_WATCHDOG
+/*
+ * Branch to soft_nmi_interrupt using the emergency stack. The emergency
+ * stack is one that is usable by maskable interrupts so long as MSR_EE
+ * remains off. It is used for recovery when something has corrupted the
+ * normal kernel stack, for example. The "soft NMI" must not use the process
+ * stack because we want irq disabled sections to avoid touching the stack
+ * at all (other than PMU interrupts), so use the emergency stack for this,
+ * and run it entirely with interrupts hard disabled.
+ */
+	ld	IREG_STACK,PACAEMERGSP(r13)
+	subi	IREG_STACK,IREG_STACK,INT_FRAME_SIZE
+	INT_SETUP_C decrementer
+	INT_RESTORE_REGS decrementer
+	bl	save_nvgprs
+	bl	soft_nmi_interrupt
+	/* XXX: soft-disable in exception return will require restore regs carefully rather than ret_from_except */
+	b	ret_from_except
+#endif
+.endm
+
+	INT_MASKED	decrementer, PACA_IRQ_DEC, 1
+
+	INT_REPLAY	decrementer
+
+
+.macro int_define_hdecrementer name
+/*
+ * Hypervisor Decrementer is an asynchronous interrupt in response to a
+ * hypervisor decrementer exception (e.g., HDEC has wrapped below zero).
+ *
+ * It is maskable in hardware by clearing MSR[EE] or with an LPCR used
+ * to stop taking them in the host.
+ *
+ * Handling:
+ * This is only used by KVM when running guests, so just need to specify
+ * the KVM handlers.
+ *
+ * KVM:
+ * HV-KVM only.
+ */
+	IVEC=0x980
+	ISIZE=0x80
+	IREAL=1
+	IVIRT=1
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+	IKVM_REAL=1
+	IKVM_VIRT=1
+#else
+	IKVM_REAL=0
+	IKVM_VIRT=0
+#endif
+	IINTS_ON=0
+	IHSRR=1
+	IAREA=PACA_EXGEN
+	IINTS=0
+	IASYNC=0 /* It is async, but no need to bother with runlatch */
+	IMASK=0
+	ICFAR=0
+	IPPR=1
+	ITB=0
+	IDATA=0
+.endm
+
+INT_DEFINE hdecrementer
+
+EXC_REAL_BEGIN(hdecrementer, 0x980, 0x80)
+	INT_ENTRY	hdecrementer,0 /* real */
+EXC_REAL_END(hdecrementer, 0x980, 0x80)
+
+EXC_VIRT_BEGIN(hdecrementer, 0x4980, 0x80)
+	INT_ENTRY	hdecrementer,1 /* virt */
+EXC_VIRT_END(hdecrementer, 0x4980, 0x80)
 
-EXC_REAL_OOL_MASKABLE(decrementer, 0x900, 0x80, IRQS_DISABLED)
-EXC_VIRT_MASKABLE(decrementer, 0x4900, 0x80, 0x900, IRQS_DISABLED)
-TRAMP_KVM(PACA_EXGEN, 0x900)
-EXC_COMMON_ASYNC(decrementer_common, 0x900, timer_interrupt)
+USE_TEXT_SECTION()
+	INT_COMMON	hdecrementer
+/*
+ * Hypervisor decrementer interrupts shouldn't occur but are sometimes
+ * left pending on exit from a KVM guest.  We don't need to do anything
+ * to clear them, as they are edge-triggered.
+ */
+	b	ret_from_except_lite
 
+	INT_KVM		hdecrementer,0 /* !skip */
 
-EXC_REAL_HV(hdecrementer, 0x980, 0x80)
-EXC_VIRT_HV(hdecrementer, 0x4980, 0x80, 0x980)
-TRAMP_KVM_HV(PACA_EXGEN, 0x980)
-EXC_COMMON(hdecrementer_common, 0x980, hdec_interrupt)
 
+.macro int_define_doorbell name
+/*
+ * Directed Privileged Doorbell is an asynchronous interrupt in response to a
+ * msgsndp doorbell.
+ *
+ * It is maskable in hardware by clearing MSR[EE], and soft-maskable with
+ * IRQS_DISABLED mask (i.e., local_irq_disable()).
+ *
+ * Handling:
+ * Linux guests use this for IPIs between threads in a core if the
+ * hypervisor supports it.
+ *
+ * KVM:
+ * This can hit when a guest is running for PR-KVM. HV-KVM is not involved.
+ */
+	IVEC=0xa00
+	ISIZE=0x100
+	IREAL=1
+	IVIRT=1
+#ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
+	IKVM_REAL=1
+	IKVM_VIRT=1
+#else
+	IKVM_REAL=0
+	IKVM_VIRT=0
+#endif
+	IINTS_ON=0
+	IHSRR=0
+	IAREA=PACA_EXGEN
+	IINTS=0
+	IASYNC=1
+	IMASK=IRQS_DISABLED
+	ICFAR=0
+	IPPR=1
+	ITB=0
+	IDATA=0
+.endm
+
+INT_DEFINE doorbell
+
+EXC_REAL_BEGIN(doorbell, 0xa00, 0x100)
+	INT_ENTRY	doorbell,0 /* real */
+EXC_REAL_END(doorbell, 0xa00, 0x100)
+
+EXC_VIRT_BEGIN(doorbell, 0x4a00, 0x100)
+	INT_ENTRY	doorbell,1 /* virt */
+EXC_VIRT_END(doorbell, 0x4a00, 0x100)
 
-EXC_REAL_MASKABLE(doorbell_super, 0xa00, 0x100, IRQS_DISABLED)
-EXC_VIRT_MASKABLE(doorbell_super, 0x4a00, 0x100, 0xa00, IRQS_DISABLED)
-TRAMP_KVM(PACA_EXGEN, 0xa00)
+USE_TEXT_SECTION()
+	INT_COMMON	doorbell
 #ifdef CONFIG_PPC_DOORBELL
-EXC_COMMON_ASYNC(doorbell_super_common, 0xa00, doorbell_exception)
+	bl	doorbell_exception
 #else
-EXC_COMMON_ASYNC(doorbell_super_common, 0xa00, unknown_exception)
+	bl	unknown_exception
 #endif
+	b	ret_from_except_lite
+
+	INT_KVM		doorbell,0 /* !skip */
+
+	INT_MASKED	doorbell, PACA_IRQ_DBELL
+
+.macro doorbell_replay_addition name
+	LOAD_REG_IMMEDIATE(r3, PPC_DBELL_MSGTYPE << (63-36))
+	PPC_MSGCLRP(3)
+.endm
+
+	INT_REPLAY	doorbell, 1
+
 
+EXC_REAL_NONE(0xb00, 0x100)
+EXC_VIRT_NONE(0x4b00, 0x100)
 
-EXC_REAL(trap_0b, 0xb00, 0x100)
-EXC_VIRT(trap_0b, 0x4b00, 0x100, 0xb00)
-TRAMP_KVM(PACA_EXGEN, 0xb00)
-EXC_COMMON(trap_0b_common, 0xb00, unknown_exception)
+/*
+ * Save area offsets for EXRFI for flushes, and EXGEN for syscalls
+ */
+#define EX_R9		0
+#define EX_R10		8
+#define EX_R11		16
+#define EX_R12		24
+#define EX_PPR		32
 
 /*
  * system call / hypercall (0xc00, 0x4c00)
@@ -867,7 +2415,9 @@ EXC_COMMON(trap_0b_common, 0xb00, unknown_exception)
 	GET_PACA(r13);							\
 	std	r10,PACA_EXGEN+EX_R10(r13);				\
 	INTERRUPT_TO_KERNEL;						\
-	KVMTEST_PR(0xc00); /* uses r10, branch to do_kvm_0xc00_system_call */ \
+	lbz	r10,HSTATE_IN_GUEST(r13);				\
+	cmpwi	r10,0;							\
+	bne	syscall_kvm;						\
 	HMT_MEDIUM;							\
 	mfctr	r9;
 
@@ -961,7 +2511,7 @@ EXC_VIRT_END(system_call, 0x4c00, 0x100)
 	 * ctr = orig r13
 	 * orig r10 saved in PACA
 	 */
-TRAMP_KVM_BEGIN(do_kvm_0xc00)
+TRAMP_KVM_BEGIN(syscall_kvm)
 	 /*
 	  * Save the PPR (on systems that support it) before changing to
 	  * HMT_MEDIUM. That allows the KVM code to save that value into the
@@ -972,34 +2522,139 @@ TRAMP_KVM_BEGIN(do_kvm_0xc00)
 	OPT_SAVE_REG_TO_PACA(PACA_EXGEN+EX_PPR, r10, CPU_FTR_HAS_PPR)
 	mfctr	r10
 	SET_SCRATCH0(r10)
-	std	r9,PACA_EXGEN+EX_R9(r13)
-	mfcr	r9
-	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0xc00)
-#endif
-
-
-EXC_REAL(single_step, 0xd00, 0x100)
-EXC_VIRT(single_step, 0x4d00, 0x100, 0xd00)
-TRAMP_KVM(PACA_EXGEN, 0xd00)
-EXC_COMMON(single_step_common, 0xd00, single_step_exception)
-
-EXC_REAL_OOL_HV(h_data_storage, 0xe00, 0x20)
-EXC_VIRT_OOL_HV(h_data_storage, 0x4e00, 0x20, 0xe00)
-TRAMP_KVM_HV_SKIP(PACA_EXGEN, 0xe00)
-EXC_COMMON_BEGIN(h_data_storage_common)
-	mfspr   r10,SPRN_HDAR
-	std     r10,PACA_EXGEN+EX_DAR(r13)
-	mfspr   r10,SPRN_HDSISR
-	stw     r10,PACA_EXGEN+EX_DSISR(r13)
-	EXCEPTION_PROLOG_COMMON(0xe00, PACA_EXGEN)
-	bl      save_nvgprs
-	RECONCILE_IRQ_STATE(r10, r11)
-	addi    r3,r1,STACK_FRAME_OVERHEAD
+
+	/* hcalls do not save CFAR */
+	BEGIN_FTR_SECTION_NESTED(947)
+	li	r10,0
+	std	r10,HSTATE_CFAR(r13)
+	END_FTR_SECTION_NESTED(CPU_FTR_CFAR,CPU_FTR_CFAR,947)
+	BEGIN_FTR_SECTION_NESTED(948)
+	ld	r10,PACA_EXGEN+EX_PPR(r13)
+	std	r10,HSTATE_PPR(r13)
+	END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,948)
+	mfcr	r10
+	std	r12,HSTATE_SCRATCH0(r13)
+	sldi	r12,r10,32
+	ori	r12,r12,0xc00
+
+#ifdef CONFIG_RELOCATABLE
+	mfctr	r10
+	std	r10,HSTATE_SCRATCH1(r13)
+	__LOAD_FAR_HANDLER(r10, kvmppc_interrupt)
+	mtctr	r10
+	ld	r10,PACA_EXGEN+EX_R10(r13)
+	bctr
+#else
+	ld	r10,PACA_EXGEN+EX_R10(r13)
+	b	kvmppc_interrupt
+#endif
+
+#endif
+
+.macro int_define_single_step name
+/*
+ * Trace is a synchronous interrupt in response to instruction step or
+ * breakpoint faults.
+ *
+ * Handling:
+ * NVGPRs and CFAR are saved for debug
+ *
+ * KVM:
+ * This can hit when a guest is running for PR-KVM. HV-KVM is not involved.
+ */
+	IVEC=0xd00
+	ISIZE=0x100
+	IREAL=1
+	IVIRT=1
+#ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
+	IKVM_REAL=1
+	IKVM_VIRT=1
+#else
+	IKVM_REAL=0
+	IKVM_VIRT=0
+#endif
+	IINTS_ON=0
+	IHSRR=0
+	IAREA=PACA_EXGEN
+	IINTS=0
+	IASYNC=0
+	IMASK=0
+	ICFAR=1
+	IPPR=1
+	ITB=0
+	IDATA=0
+.endm
+
+INT_DEFINE single_step
+
+EXC_REAL_BEGIN(single_step, 0xd00, 0x100)
+	INT_ENTRY	single_step,0 /* real */
+EXC_REAL_END(single_step, 0xd00, 0x100)
+
+EXC_VIRT_BEGIN(single_step, 0x4d00, 0x100)
+	INT_ENTRY	single_step,1 /* virt */
+EXC_VIRT_END(single_step, 0x4d00, 0x100)
+
+USE_TEXT_SECTION()
+	INT_COMMON	single_step 0
+	bl	save_nvgprs
+	bl	single_step_exception
+	b	ret_from_except
+
+	INT_KVM		single_step,0 /* !skip */
+
+
+.macro int_define_h_data_storage name
+/*
+ * Hypervisor Data Storage (HDSI) is a synchronous interrupt in response to an
+ * MMU fault...
+ *
+ * Handling:
+ * Primarily handled by KVM...
+ *
+ * KVM:
+ * HV-KVM only.
+ */
+	IVEC=0xe00
+	ISIZE=0x20
+	IREAL=1
+	IVIRT=1
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+	IKVM_REAL=1
+	IKVM_VIRT=1
+#else
+	IKVM_REAL=0
+	IKVM_VIRT=0
+#endif
+	IINTS_ON=0
+	IHSRR=1
+	IAREA=PACA_EXGEN
+	IINTS=0
+	IASYNC=0
+	IMASK=0
+	ICFAR=1
+	IPPR=1
+	ITB=0
+	IDATA=1
+	IISIDE=0
+	IDAR=1
+	IDSISR=1
+.endm
+
+INT_DEFINE h_data_storage
+
+EXC_REAL_BEGIN(h_data_storage, 0xe00, 0x20)
+	INT_ENTRY	h_data_storage,0 /* real */
+EXC_REAL_END(h_data_storage, 0xe00, 0x20)
+
+EXC_VIRT_BEGIN(h_data_storage, 0x4e00, 0x20)
+	INT_ENTRY	h_data_storage,1 /* virt */
+EXC_VIRT_END(h_data_storage, 0x4e00, 0x20)
+
+USE_TEXT_SECTION()
+	INT_COMMON	h_data_storage 0
+	bl	save_nvgprs
 BEGIN_MMU_FTR_SECTION
-	ld	r4,PACA_EXGEN+EX_DAR(r13)
-	lwz	r5,PACA_EXGEN+EX_DSISR(r13)
-	std	r4,_DAR(r1)
-	std	r5,_DSISR(r1)
 	li	r5,SIGSEGV
 	bl      bad_page_fault
 MMU_FTR_SECTION_ELSE
@@ -1007,97 +2662,386 @@ MMU_FTR_SECTION_ELSE
 ALT_MMU_FTR_SECTION_END_IFSET(MMU_FTR_TYPE_RADIX)
 	b       ret_from_except
 
+	INT_KVM		h_data_storage,0 /* !skip */
+
+.macro int_define_h_instr_storage name
+/*
+ * Hypervisor Instruction Storage (HISI) is a synchronous interrupt in response
+ * to an MMU fault...
+ *
+ * Handling:
+ * Primarily handled by KVM...
+ *
+ * KVM:
+ * HV-KVM only.
+ */
+	IVEC=0xe20
+	ISIZE=0x20
+	IREAL=1
+	IVIRT=1
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+	IKVM_REAL=1
+	IKVM_VIRT=1
+#else
+	IKVM_REAL=0
+	IKVM_VIRT=0
+#endif
+	IINTS_ON=0
+	IHSRR=1
+	IAREA=PACA_EXGEN
+	IINTS=0
+	IASYNC=0
+	IMASK=0
+	ICFAR=1
+	IPPR=1
+	ITB=0
+	IDATA=0
+.endm
+INT_DEFINE h_instr_storage
+
+EXC_REAL_BEGIN(h_instr_storage, 0xe20, 0x20)
+	INT_ENTRY	h_instr_storage,0 /* real */
+EXC_REAL_END(h_instr_storage, 0xe20, 0x20)
+
+EXC_VIRT_BEGIN(h_instr_storage, 0x4e20, 0x20)
+	INT_ENTRY	h_instr_storage,1 /* virt */
+EXC_VIRT_END(h_instr_storage, 0x4e20, 0x20)
+
+USE_TEXT_SECTION()
+	INT_COMMON	h_instr_storage 0
+	bl	save_nvgprs
+	bl	unknown_exception
+	b	ret_from_except_lite
+
+	INT_KVM		h_instr_storage,0 /* !skip */
 
-EXC_REAL_OOL_HV(h_instr_storage, 0xe20, 0x20)
-EXC_VIRT_OOL_HV(h_instr_storage, 0x4e20, 0x20, 0xe20)
-TRAMP_KVM_HV(PACA_EXGEN, 0xe20)
-EXC_COMMON(h_instr_storage_common, 0xe20, unknown_exception)
+.macro int_define_emulation_assist name
+/*
+ * Hypervisor Emulation Assistance...
+ *
+ * Handling:
+ * NVGPRs and CFAR are saved for debug
+ *
+ * KVM:
+ * HV-KVM only.
+ */
+	IVEC=0xe40
+	ISIZE=0x20
+	IREAL=1
+	IVIRT=1
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+	IKVM_REAL=1
+	IKVM_VIRT=1
+#else
+	IKVM_REAL=0
+	IKVM_VIRT=0
+#endif
+	IINTS_ON=0
+	IHSRR=1
+	IAREA=PACA_EXGEN
+	IINTS=0
+	IASYNC=0
+	IMASK=0
+	ICFAR=1
+	IPPR=1
+	ITB=0
+	IDATA=0
+.endm
+INT_DEFINE emulation_assist
+
+EXC_REAL_BEGIN(emulation_assist, 0xe40, 0x20)
+	INT_ENTRY	emulation_assist,0 /* real */
+EXC_REAL_END(emulation_assist, 0xe40, 0x20)
+
+EXC_VIRT_BEGIN(emulation_assist, 0x4e40, 0x20)
+	INT_ENTRY	emulation_assist,1 /* virt */
+EXC_VIRT_END(emulation_assist, 0x4e40, 0x20)
 
+USE_TEXT_SECTION()
+	INT_COMMON	emulation_assist 0
+	bl	emulation_assist_interrupt
+	b	ret_from_except_lite
 
-EXC_REAL_OOL_HV(emulation_assist, 0xe40, 0x20)
-EXC_VIRT_OOL_HV(emulation_assist, 0x4e40, 0x20, 0xe40)
-TRAMP_KVM_HV(PACA_EXGEN, 0xe40)
-EXC_COMMON(emulation_assist_common, 0xe40, emulation_assist_interrupt)
+	INT_KVM		emulation_assist,0 /* !skip */
 
 
+.macro int_define_hmi_exception name
 /*
- * hmi_exception trampoline is a special case. It jumps to hmi_exception_early
- * first, and then eventaully from there to the trampoline to get into virtual
- * mode.
+ * Hypervisor Maintenance (HMI) is an asynchronous interrupt always taken in
+ * real mode. It is caused by a Hypervisor Maintenance exception (an enabled
+ * HMER bit is set).
+ *
+ * It is maskable in hardware by clearing MSR[EE], and soft-maskable with
+ * IRQS_DISABLED mask (i.e., local_irq_disable()).
+ *
+ * Handling:
+ * Special case, this is handled similarly to machine checks, with an
+ * initial real mode handler that is not masked to fix the problem. Then
+ * may branch to a more normal virtual mode handler which is maskable.
+ *
+ * The emergency stack is used for the non-soft-maskable case.
+ *
+ * KVM:
+ * This can hit when a guest is running, so KVM must be called. Unlike
+ * MCE, this calls KVM without calling the early realmode handler.
  */
-__EXC_REAL_OOL_HV_DIRECT(hmi_exception, 0xe60, 0x20, hmi_exception_early)
-__TRAMP_REAL_OOL_MASKABLE_HV(hmi_exception, 0xe60, IRQS_DISABLED)
+	IVEC=0xe60
+	ISIZE=0x20
+	IREAL=1
+	IVIRT=0
+#ifdef CONFIG_KVM_BOOK3S_64_HANDLER
+	IKVM_REAL=1
+#else
+	IKVM_REAL=0
+#endif
+	IINTS_ON=0
+	IHSRR=1
+	IAREA=PACA_EXGEN
+	IINTS=0
+	IASYNC=0	/* XXX: is are actually async */
+	IMASK=0
+	ICFAR=0
+	IPPR=1
+	ITB=0
+	IDATA=0
+.endm
+
+INT_DEFINE hmi_exception
+
+EXC_REAL_BEGIN(hmi_exception, 0xe60, 0x20)
+	INT_ENTRY	hmi_exception,0 /* real */
+EXC_REAL_END(hmi_exception, 0xe60, 0x20)
+
 EXC_VIRT_NONE(0x4e60, 0x20)
-TRAMP_KVM_HV(PACA_EXGEN, 0xe60)
-TRAMP_REAL_BEGIN(hmi_exception_early)
-	EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST_HV, 0xe60)
-	mr	r10,r1			/* Save r1 */
-	ld	r1,PACAEMERGSP(r13)	/* Use emergency stack for realmode */
-	subi	r1,r1,INT_FRAME_SIZE	/* alloc stack frame		*/
-	mfspr	r11,SPRN_HSRR0		/* Save HSRR0 */
-	mfspr	r12,SPRN_HSRR1		/* Save HSRR1 */
-	EXCEPTION_PROLOG_COMMON_1()
-	EXCEPTION_PROLOG_COMMON_2(PACA_EXGEN)
-	EXCEPTION_PROLOG_COMMON_3(0xe60)
-	addi	r3,r1,STACK_FRAME_OVERHEAD
-	BRANCH_LINK_TO_FAR(DOTSYM(hmi_exception_realmode)) /* Function call ABI */
+
+USE_TEXT_SECTION()
+	.balign IFETCH_ALIGN_BYTES
+DEFINE_FIXED_SYMBOL(hmi_exception_real)
+hmi_exception_real:
+	INT_KVM_TEST .L_hmi_exception_REG_SCRATCH, .L_hmi_exception_REG_SRR1, hmi_exception_kvm
+
+	ld	.L_hmi_exception_REG_STACK,PACAEMERGSP(r13)
+	subi	.L_hmi_exception_REG_STACK,.L_hmi_exception_REG_STACK,INT_FRAME_SIZE
+
+	INT_SETUP_C	hmi_exception
+	bl	DOTSYM(hmi_exception_realmode) /* Function call ABI */
+
 	cmpdi	cr0,r3,0
 
-	/* Windup the stack. */
+	/* Restore IRQ state */
+	ld	r9,SOFTE(r1)
+	stb	r9,PACAIRQSOFTMASK(r13)
 	/* Move original HSRR0 and HSRR1 into the respective regs */
+	/* XXX: how about PPR? */
 	ld	r9,_MSR(r1)
 	mtspr	SPRN_HSRR1,r9
-	ld	r3,_NIP(r1)
-	mtspr	SPRN_HSRR0,r3
+	ld	r9,_NIP(r1)
+	mtspr	SPRN_HSRR0,r9
 	ld	r9,_CTR(r1)
 	mtctr	r9
 	ld	r9,_XER(r1)
 	mtxer	r9
-	ld	r9,_LINK(r1)
-	mtlr	r9
 	REST_GPR(0, r1)
-	REST_8GPRS(2, r1)
-	REST_GPR(10, r1)
-	ld	r11,_CCR(r1)
-	REST_2GPRS(12, r1)
+	REST_GPR(2, r1)
+	REST_10GPRS(3, r1)
+
 	bne	1f
-	mtcr	r11
-	REST_GPR(11, r1)
-	ld	r1,GPR1(r1)
-	HRFI_TO_USER_OR_KERNEL
 
-1:	mtcr	r11
-	REST_GPR(11, r1)
-	ld	r1,GPR1(r1)
+	INT_RESTORE_REGS hmi_exception /* Restore NV regs */
 
+	/* Windup the stack. */
+	ld	r9,_CCR(r1)
+	mtcr	r9
+	ld	r9,_LINK(r1)
+	mtlr	r9
+	REST_GPR(13, r1)
+	ld	r1,GPR1(r1)
 	/*
-	 * Go to virtual mode and pull the HMI event information from
-	 * firmware.
+	 * Need not check MSR[RI] because that should never be clear when
+	 * MSR[EE] is set.
 	 */
-	.globl hmi_exception_after_realmode
-hmi_exception_after_realmode:
-	SET_SCRATCH0(r13)
-	EXCEPTION_PROLOG_0(PACA_EXGEN)
-	b	tramp_real_hmi_exception
+	HRFI_TO_USER_OR_KERNEL
+1:
+	/*
+	 * All int non-volatiles are still in place and matching the after
+	 * real handler so can branch straight there, just need to reload
+	 * restore r1, then load the regular stack into stack reg.
+	 */
+	ld	r1,GPR1(r1)
+	ld	.L_hmi_exception_REG_STACK,PACAKSAVE(r13)
+	b	hmi_exception_after_real_real
+
+	INT_KVM		hmi_exception,0 /* !skip */
+
+.macro int_define_hmi_exception_after_real name
+	IVEC=0xe60
+	ISIZE=0x20
+	IREAL=1
+	IVIRT=1
+	IKVM_REAL=0
+	IKVM_VIRT=0
+	IINTS_ON=0
+	IHSRR=1
+	IAREA=PACA_EXGEN
+	IINTS=0
+	IASYNC=1
+	IMASK=IRQS_DISABLED
+	ICFAR=1
+	IPPR=1
+	ITB=0
+	IDATA=0
+.endm
+
+INT_DEFINE hmi_exception_after_real
+
+	INT_COMMON	hmi_exception_after_real
+	bl	save_nvgprs
+	bl	handle_hmi_exception
+	b	ret_from_except
+
+	INT_MASKED	hmi_exception_after_real, PACA_IRQ_HMI
 
-EXC_COMMON_BEGIN(hmi_exception_common)
-EXCEPTION_COMMON(PACA_EXGEN, 0xe60, hmi_exception_common, handle_hmi_exception,
-        ret_from_except, FINISH_NAP;ADD_NVGPRS;ADD_RECONCILE;RUNLATCH_ON)
+	INT_REPLAY	hmi_exception_after_real
 
-EXC_REAL_OOL_MASKABLE_HV(h_doorbell, 0xe80, 0x20, IRQS_DISABLED)
-EXC_VIRT_OOL_MASKABLE_HV(h_doorbell, 0x4e80, 0x20, 0xe80, IRQS_DISABLED)
-TRAMP_KVM_HV(PACA_EXGEN, 0xe80)
+
+.macro int_define_h_doorbell name
+/*
+ * Directed Hypervisor Doorbell is an asynchronous interrupt in response to a
+ * msgsnd doorbell.
+ *
+ * It is maskable in hardware by clearing MSR[EE], and soft-maskable with
+ * IRQS_DISABLED mask (i.e., local_irq_disable()).
+ *
+ * Handling:
+ * Linux guests use this for IPIs between threads in a core if the
+ * hypervisor supports it.
+ *
+ * KVM:
+ * This can hit when a guest is running, so KVM must be called.
+ */
+	IVEC=0xe80
+	ISIZE=0x20
+	IREAL=1
+	IVIRT=1
+#ifdef CONFIG_KVM_BOOK3S_64_HANDLER
+	IKVM_REAL=1
+	IKVM_VIRT=1
+#else
+	IKVM_REAL=0
+	IKVM_VIRT=0
+#endif
+	IINTS_ON=0
+	IHSRR=1
+	IAREA=PACA_EXGEN
+	IINTS=0
+	IASYNC=1
+	IMASK=IRQS_DISABLED
+	ICFAR=0
+	IPPR=1
+	ITB=0
+	IDATA=0
+.endm
+INT_DEFINE h_doorbell
+
+EXC_REAL_BEGIN(h_doorbell, 0xe80, 0x20)
+	INT_ENTRY	h_doorbell,0 /* real */
+EXC_REAL_END(h_doorbell, 0xe80, 0x20)
+
+EXC_VIRT_BEGIN(h_doorbell, 0x4e80, 0x20)
+	INT_ENTRY	h_doorbell,1 /* virt */
+EXC_VIRT_END(h_doorbell, 0x4e80, 0x20)
+
+USE_TEXT_SECTION()
+	INT_COMMON	h_doorbell
 #ifdef CONFIG_PPC_DOORBELL
-EXC_COMMON_ASYNC(h_doorbell_common, 0xe80, doorbell_exception)
+	bl	doorbell_exception
+#else
+	bl	unknown_exception
+#endif
+	b	ret_from_except
+
+	INT_KVM		h_doorbell,0 /* !skip */
+
+	INT_MASKED	h_doorbell, PACA_IRQ_DBELL
+
+/*
+ * When doorbell is triggered from system reset wakeup, the message is
+ * not cleared, so it would fire again when EE is enabled.
+ *
+ * When coming from local_irq_enable, there may be the same problem if
+ * we were hard disabled.
+ *
+ * Execute msgclr to clear pending exceptions before handling it.
+ */
+.macro h_doorbell_replay_addition name
+	LOAD_REG_IMMEDIATE(r3, PPC_DBELL_MSGTYPE << (63-36))
+	PPC_MSGCLR(3)
+.endm
+
+	INT_REPLAY	h_doorbell, 1
+
+
+.macro int_define_h_virt_irq name
+/*
+ * Hypervisor Virtualization is an asynchronous interrupt in response to an
+ * "external exception" similar to External interrupts.
+ * It is maskable in hardware by clearing MSR[EE], and soft-maskable with
+ * IRQS_DISABLED mask (i.e., local_irq_disable()).
+ *
+ * Handling:
+ * This calls into Linux IRQ handler.
+ *
+ * KVM:
+ * This can hit when a guest is running, so KVM must be called.
+ */
+	IVEC=0xea0
+	ISIZE=0x20
+	IREAL=1
+	IVIRT=1
+#ifdef CONFIG_KVM_BOOK3S_64_HANDLER
+	IKVM_REAL=1
+	IKVM_VIRT=1
 #else
-EXC_COMMON_ASYNC(h_doorbell_common, 0xe80, unknown_exception)
+	IKVM_REAL=0
+	IKVM_VIRT=0
 #endif
+	IINTS_ON=0
+	IHSRR=1
+	IAREA=PACA_EXGEN
+	IINTS=0
+	IASYNC=1
+	IMASK=IRQS_DISABLED
+	ICFAR=0
+	IPPR=1
+	ITB=0
+	IDATA=0
+.endm
+
+INT_DEFINE h_virt_irq
+
+EXC_REAL_BEGIN(h_virt_irq, 0xea0, 0x20)
+	INT_ENTRY	h_virt_irq,0 /* real */
+EXC_REAL_END(h_virt_irq, 0xea0, 0x20)
+
+EXC_VIRT_BEGIN(h_virt_irq, 0x4ea0, 0x20)
+	INT_ENTRY	h_virt_irq,1 /* virt */
+EXC_VIRT_END(h_virt_irq, 0x4ea0, 0x20)
+
+USE_TEXT_SECTION()
+	INT_COMMON	h_virt_irq
+	bl	do_IRQ
+	b	ret_from_except_lite
+
+	INT_KVM		h_virt_irq,0 /* !skip */
+
+.macro h_virt_irq_masked_addition name
+	xori	IREG_SRR1,IREG_SRR1,MSR_EE	/* Disable EE in SRR1 */
+	mtspr	SPRN_HSRR1,IREG_SRR1
+.endm
 
+	INT_MASKED	h_virt_irq, PACA_IRQ_EE, 1
 
-EXC_REAL_OOL_MASKABLE_HV(h_virt_irq, 0xea0, 0x20, IRQS_DISABLED)
-EXC_VIRT_OOL_MASKABLE_HV(h_virt_irq, 0x4ea0, 0x20, 0xea0, IRQS_DISABLED)
-TRAMP_KVM_HV(PACA_EXGEN, 0xea0)
-EXC_COMMON_ASYNC(h_virt_irq_common, 0xea0, do_IRQ)
+	INT_REPLAY	h_virt_irq
 
 
 EXC_REAL_NONE(0xec0, 0x20)
@@ -1106,20 +3050,123 @@ EXC_REAL_NONE(0xee0, 0x20)
 EXC_VIRT_NONE(0x4ee0, 0x20)
 
 
-EXC_REAL_OOL_MASKABLE(performance_monitor, 0xf00, 0x20, IRQS_PMI_DISABLED)
-EXC_VIRT_OOL_MASKABLE(performance_monitor, 0x4f00, 0x20, 0xf00, IRQS_PMI_DISABLED)
-TRAMP_KVM(PACA_EXGEN, 0xf00)
-EXC_COMMON_ASYNC(performance_monitor_common, 0xf00, performance_monitor_exception)
+.macro int_define_performance_monitor name
+/*
+ * Performance Monitor is an asynchronous interrupt in response to a
+ * PMU exception.
+ *
+ * It is maskable in hardware by clearing MSR[EE], and soft-maskable with
+ * IRQS_PMI_DISABLED mask.
+ *
+ * Handling:
+ * This calls into perf handler. NV-GPRs and CFAR are not saved, to
+ * reduce overhead.
+ *
+ * It appears a soft-nmi interrupt to Linux, but may be soft-disabled in
+ * powerpc specific code.
+ *
+ * KVM:
+ * This can hit when a guest is running for PR-KVM. HV-KVM is not involved.
+ */
+	IVEC=0xf00
+	ISIZE=0x20
+	IREAL=1
+	IVIRT=1
+#ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
+	IKVM_REAL=1
+	IKVM_VIRT=1
+#else
+	IKVM_REAL=0
+	IKVM_VIRT=0
+#endif
+	IINTS_ON=0
+	IHSRR=0
+	IAREA=PACA_EXGEN
+	IINTS=0
+	IASYNC=1
+	IMASK=IRQS_PMI_DISABLED
+	ICFAR=0
+	IPPR=1
+	ITB=0 /* XXX: perf could use TB to avoid a mftb perhaps */
+	IDATA=0
+.endm
+
+INT_DEFINE performance_monitor
+
+EXC_REAL_BEGIN(performance_monitor, 0xf00, 0x20)
+	INT_ENTRY	performance_monitor,0 /* real */
+EXC_REAL_END(performance_monitor, 0xf00, 0x20)
+
+EXC_VIRT_BEGIN(performance_monitor, 0x4f00, 0x20)
+	INT_ENTRY	performance_monitor,1 /* virt */
+EXC_VIRT_END(performance_monitor, 0x4f00, 0x20)
+
+USE_TEXT_SECTION()
+	INT_COMMON	performance_monitor
+	bl	performance_monitor_exception
+	b	ret_from_except_lite
+
+	INT_KVM		performance_monitor,0 /* !skip */
+
+.macro performance_monitor_masked_addition name
+	xori	IREG_SRR1,IREG_SRR1,MSR_EE	/* Disable EE in SRR1 */
+	mtspr	SPRN_SRR1,IREG_SRR1
+.endm
 
+	INT_MASKED	performance_monitor, PACA_IRQ_PMI, 1
+
+	INT_REPLAY	performance_monitor
+
+
+.macro int_define_altivec_unavailable name
+/* XXX
+ * Floating-Point Unavailable is a synchronous interrupt in response to
+ * executing an fp instruction with MSR[FP]=0
+ *
+ * Handling:
+ * CFAR is saved for debug. NVGPRs are saved in the case of a bug.
+ *
+ * KVM:
+ * This can hit when a guest is running for PR-KVM. HV-KVM is not involved.
+ */
+	IVEC=0xf20
+	ISIZE=0x20
+	IREAL=1
+	IVIRT=1
+#ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
+	IKVM_REAL=1
+	IKVM_VIRT=1
+#else
+	IKVM_REAL=0
+	IKVM_VIRT=0
+#endif
+	IINTS_ON=0
+	IHSRR=0
+	IAREA=PACA_EXGEN
+	IINTS=0
+	IASYNC=0
+	IMASK=0
+	ICFAR=1
+	IPPR=1
+	ITB=0
+	IDATA=0
+.endm
+INT_DEFINE altivec_unavailable
+
+EXC_REAL_BEGIN(altivec_unavailable, 0xf20, 0x20)
+	INT_ENTRY	altivec_unavailable,0 /* real */
+EXC_REAL_END(altivec_unavailable, 0xf20, 0x20)
+
+EXC_VIRT_BEGIN(altivec_unavailable, 0x4f20, 0x20)
+	INT_ENTRY	altivec_unavailable,1 /* virt */
+EXC_VIRT_END(altivec_unavailable, 0x4f20, 0x20)
 
-EXC_REAL_OOL(altivec_unavailable, 0xf20, 0x20)
-EXC_VIRT_OOL(altivec_unavailable, 0x4f20, 0x20, 0xf20)
-TRAMP_KVM(PACA_EXGEN, 0xf20)
-EXC_COMMON_BEGIN(altivec_unavailable_common)
-	EXCEPTION_PROLOG_COMMON(0xf20, PACA_EXGEN)
+USE_TEXT_SECTION()
+	INT_COMMON	altivec_unavailable
 #ifdef CONFIG_ALTIVEC
 BEGIN_FTR_SECTION
-	beq	1f
+	beq	cr2,1f
+	ld	r12,_MSR(r1)		/* load_up_altivec wants SRR1 in r12 */
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
   BEGIN_FTR_SECTION_NESTED(69)
 	/* Test if 2 TM state bits are zero.  If non-zero (ie. userspace was in
@@ -1129,13 +3176,13 @@ BEGIN_FTR_SECTION
 	bne-	2f
   END_FTR_SECTION_NESTED(CPU_FTR_TM, CPU_FTR_TM, 69)
 #endif
+	ld	r9,SOFTE(r1)
+	stb	r9,PACAIRQSOFTMASK(r13)
 	bl	load_up_altivec
 	b	fast_exception_return
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 2:	/* User process was in a transaction */
 	bl	save_nvgprs
-	RECONCILE_IRQ_STATE(r10, r11)
-	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	altivec_unavailable_tm
 	b	ret_from_except
 #endif
@@ -1143,20 +3190,61 @@ BEGIN_FTR_SECTION
 END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 #endif
 	bl	save_nvgprs
-	RECONCILE_IRQ_STATE(r10, r11)
-	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	altivec_unavailable_exception
 	b	ret_from_except
 
+	INT_KVM		altivec_unavailable,0 /* !skip */
 
-EXC_REAL_OOL(vsx_unavailable, 0xf40, 0x20)
-EXC_VIRT_OOL(vsx_unavailable, 0x4f40, 0x20, 0xf40)
-TRAMP_KVM(PACA_EXGEN, 0xf40)
-EXC_COMMON_BEGIN(vsx_unavailable_common)
-	EXCEPTION_PROLOG_COMMON(0xf40, PACA_EXGEN)
+
+.macro int_define_vsx_unavailable name
+/* XXX
+ * Floating-Point Unavailable is a synchronous interrupt in response to
+ * executing an fp instruction with MSR[FP]=0
+ *
+ * Handling:
+ * CFAR is saved for debug. NVGPRs are saved in the case of a bug.
+ *
+ * KVM:
+ * This can hit when a guest is running for PR-KVM. HV-KVM is not involved.
+ */
+	IVEC=0xf40
+	ISIZE=0x20
+	IREAL=1
+	IVIRT=1
+#ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
+	IKVM_REAL=1
+	IKVM_VIRT=1
+#else
+	IKVM_REAL=0
+	IKVM_VIRT=0
+#endif
+	IINTS_ON=0
+	IHSRR=0
+	IAREA=PACA_EXGEN
+	IINTS=0
+	IASYNC=0
+	IMASK=0
+	ICFAR=1
+	IPPR=1
+	ITB=0
+	IDATA=0
+.endm
+INT_DEFINE vsx_unavailable
+
+EXC_REAL_BEGIN(vsx_unavailable, 0xf40, 0x20)
+	INT_ENTRY	vsx_unavailable,0 /* real */
+EXC_REAL_END(vsx_unavailable, 0xf40, 0x20)
+
+EXC_VIRT_BEGIN(vsx_unavailable, 0x4f40, 0x20)
+	INT_ENTRY	vsx_unavailable,1 /* virt */
+EXC_VIRT_END(vsx_unavailable, 0x4f40, 0x20)
+
+USE_TEXT_SECTION()
+	INT_COMMON	vsx_unavailable
 #ifdef CONFIG_VSX
 BEGIN_FTR_SECTION
-	beq	1f
+	beq	cr2,1f
+	ld	r12,_MSR(r1)		/* load_up_vsx wants SRR1 in r12 */
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
   BEGIN_FTR_SECTION_NESTED(69)
 	/* Test if 2 TM state bits are zero.  If non-zero (ie. userspace was in
@@ -1166,12 +3254,12 @@ BEGIN_FTR_SECTION
 	bne-	2f
   END_FTR_SECTION_NESTED(CPU_FTR_TM, CPU_FTR_TM, 69)
 #endif
+	ld	r9,SOFTE(r1)
+	stb	r9,PACAIRQSOFTMASK(r13)
 	b	load_up_vsx
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 2:	/* User process was in a transaction */
 	bl	save_nvgprs
-	RECONCILE_IRQ_STATE(r10, r11)
-	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	vsx_unavailable_tm
 	b	ret_from_except
 #endif
@@ -1179,22 +3267,113 @@ BEGIN_FTR_SECTION
 END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 #endif
 	bl	save_nvgprs
-	RECONCILE_IRQ_STATE(r10, r11)
-	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	vsx_unavailable_exception
 	b	ret_from_except
 
+	INT_KVM		vsx_unavailable,0 /* !skip */
+
+.macro int_define_facility_unavailable name
+/* XXX
+ * Floating-Point Unavailable is a synchronous interrupt in response to
+ * executing an fp instruction with MSR[FP]=0
+ *
+ * Handling:
+ * CFAR is saved for debug. NVGPRs are saved in the case of a bug.
+ *
+ * KVM:
+ * This can hit when a guest is running for PR-KVM. HV-KVM is not involved.
+ */
+	IVEC=0xf60
+	ISIZE=0x20
+	IREAL=1
+	IVIRT=1
+#ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
+	IKVM_REAL=1
+	IKVM_VIRT=1
+#else
+	IKVM_REAL=0
+	IKVM_VIRT=0
+#endif
+	IINTS_ON=0
+	IHSRR=0
+	IAREA=PACA_EXGEN
+	IINTS=0
+	IASYNC=0
+	IMASK=0
+	ICFAR=1
+	IPPR=1
+	ITB=0
+	IDATA=0
+.endm
+INT_DEFINE facility_unavailable
+
+EXC_REAL_BEGIN(facility_unavailable, 0xf60, 0x20)
+	INT_ENTRY	facility_unavailable,0 /* real */
+EXC_REAL_END(facility_unavailable, 0xf60, 0x20)
+
+EXC_VIRT_BEGIN(facility_unavailable, 0x4f60, 0x20)
+	INT_ENTRY	facility_unavailable,1 /* virt */
+EXC_VIRT_END(facility_unavailable, 0x4f60, 0x20)
+
+USE_TEXT_SECTION()
+	INT_COMMON	facility_unavailable
+	bl	save_nvgprs
+	bl	facility_unavailable_exception
+	b	ret_from_except
+
+	INT_KVM		facility_unavailable,0 /* !skip */
 
-EXC_REAL_OOL(facility_unavailable, 0xf60, 0x20)
-EXC_VIRT_OOL(facility_unavailable, 0x4f60, 0x20, 0xf60)
-TRAMP_KVM(PACA_EXGEN, 0xf60)
-EXC_COMMON(facility_unavailable_common, 0xf60, facility_unavailable_exception)
 
+.macro int_define_h_facility_unavailable name
+/* XXX
+ * Floating-Point Unavailable is a synchronous interrupt in response to
+ * executing an fp instruction with MSR[FP]=0
+ *
+ * Handling:
+ * CFAR is saved for debug. NVGPRs are saved in the case of a bug.
+ *
+ * KVM:
+ * This can hit when a guest is running for PR-KVM. HV-KVM is not involved.
+ */
+	IVEC=0xf80
+	ISIZE=0x20
+	IREAL=1
+	IVIRT=1
+#ifdef CONFIG_KVM_BOOK3S_64_HANDLER
+	IKVM_REAL=1
+	IKVM_VIRT=1
+#else
+	IKVM_REAL=0
+	IKVM_VIRT=0
+#endif
+	IINTS_ON=0
+	IHSRR=1
+	IAREA=PACA_EXGEN
+	IINTS=0
+	IASYNC=0
+	IMASK=0
+	ICFAR=1
+	IPPR=1
+	ITB=0
+	IDATA=0
+.endm
+INT_DEFINE h_facility_unavailable
+
+EXC_REAL_BEGIN(h_facility_unavailable, 0xf80, 0x20)
+	INT_ENTRY	h_facility_unavailable,0 /* real */
+EXC_REAL_END(h_facility_unavailable, 0xf80, 0x20)
+
+EXC_VIRT_BEGIN(h_facility_unavailable, 0x4f80, 0x20)
+	INT_ENTRY	h_facility_unavailable,1 /* virt */
+EXC_VIRT_END(h_facility_unavailable, 0x4f80, 0x20)
+
+USE_TEXT_SECTION()
+	INT_COMMON	h_facility_unavailable
+	bl	save_nvgprs
+	bl	facility_unavailable_exception
+	b	ret_from_except
 
-EXC_REAL_OOL_HV(h_facility_unavailable, 0xf80, 0x20)
-EXC_VIRT_OOL_HV(h_facility_unavailable, 0x4f80, 0x20, 0xf80)
-TRAMP_KVM_HV(PACA_EXGEN, 0xf80)
-EXC_COMMON(h_facility_unavailable_common, 0xf80, facility_unavailable_exception)
+	INT_KVM		h_facility_unavailable,0 /* !skip */
 
 
 EXC_REAL_NONE(0xfa0, 0x20)
@@ -1209,6 +3388,8 @@ EXC_VIRT_NONE(0x5000, 0x100)
 EXC_REAL_NONE(0x1100, 0x100)
 EXC_VIRT_NONE(0x5100, 0x100)
 
+#if 0
+
 #ifdef CONFIG_CBE_RAS
 EXC_REAL_HV(cbe_system_error, 0x1200, 0x100)
 EXC_VIRT_NONE(0x5200, 0x100)
@@ -1220,14 +3401,31 @@ EXC_VIRT_NONE(0x5200, 0x100)
 #endif
 
 
-EXC_REAL(instruction_breakpoint, 0x1300, 0x100)
-EXC_VIRT(instruction_breakpoint, 0x5300, 0x100, 0x1300)
-TRAMP_KVM_SKIP(PACA_EXGEN, 0x1300)
-EXC_COMMON(instruction_breakpoint_common, 0x1300, instruction_breakpoint_exception)
+/* !ints_on, !async, !mask, kvm_real, kvm_virt, !hsrr, cfar, ppr, !tb, !iside, !dar, !dsisr, stack */
+INT_DEFINE instruction_breakpoint,0x1300,0x100,PACA_EXGEN,0,0,0,1,1,0,1,1,0,0,0,0,1
+
+EXC_REAL_BEGIN(instruction_breakpoint, 0x1300, 0x100)
+	INT_ENTRY	instruction_breakpoint,0 /* real */
+EXC_REAL_END(instruction_breakpoint, 0x1300, 0x100)
+
+EXC_VIRT_BEGIN(instruction_breakpoint, 0x5300, 0x100)
+	INT_ENTRY	instruction_breakpoint,1 /* virt */
+EXC_VIRT_END(instruction_breakpoint, 0x5300, 0x100)
+
+USE_TEXT_SECTION()
+	INT_COMMON	instruction_breakpoint
+	bl	save_nvgprs
+	bl	instruction_breakpoint_exception
+	b	ret_from_except
+
+	INT_KVM		instruction_breakpoint,0 /* !skip */
 
 EXC_REAL_NONE(0x1400, 0x100)
 EXC_VIRT_NONE(0x5400, 0x100)
 
+EXC_REAL_NONE(0x1500, 0x100)
+EXC_VIRT_NONE(0x5500, 0x100)
+
 EXC_REAL_BEGIN(denorm_exception_hv, 0x1500, 0x100)
 	mtspr	SPRN_SPRG_HSCRATCH0,r13
 	EXCEPTION_PROLOG_0(PACA_EXGEN)
@@ -1352,80 +3550,7 @@ EXC_COMMON(cbe_thermal_common, 0x1800, cbe_thermal_exception)
 EXC_REAL_NONE(0x1800, 0x100)
 EXC_VIRT_NONE(0x5800, 0x100)
 #endif
-
-#ifdef CONFIG_PPC_WATCHDOG
-
-#define MASKED_DEC_HANDLER_LABEL 3f
-
-#define MASKED_DEC_HANDLER(_H)				\
-3: /* soft-nmi */					\
-	std	r12,PACA_EXGEN+EX_R12(r13);		\
-	GET_SCRATCH0(r10);				\
-	std	r10,PACA_EXGEN+EX_R13(r13);		\
-	EXCEPTION_PROLOG_2(soft_nmi_common, _H)
-
-/*
- * Branch to soft_nmi_interrupt using the emergency stack. The emergency
- * stack is one that is usable by maskable interrupts so long as MSR_EE
- * remains off. It is used for recovery when something has corrupted the
- * normal kernel stack, for example. The "soft NMI" must not use the process
- * stack because we want irq disabled sections to avoid touching the stack
- * at all (other than PMU interrupts), so use the emergency stack for this,
- * and run it entirely with interrupts hard disabled.
- */
-EXC_COMMON_BEGIN(soft_nmi_common)
-	mr	r10,r1
-	ld	r1,PACAEMERGSP(r13)
-	subi	r1,r1,INT_FRAME_SIZE
-	EXCEPTION_COMMON_NORET_STACK(PACA_EXGEN, 0x900,
-			system_reset, soft_nmi_interrupt,
-			ADD_NVGPRS;ADD_RECONCILE)
-	b	ret_from_except
-
-#else /* CONFIG_PPC_WATCHDOG */
-#define MASKED_DEC_HANDLER_LABEL 2f /* normal return */
-#define MASKED_DEC_HANDLER(_H)
-#endif /* CONFIG_PPC_WATCHDOG */
-
-/*
- * An interrupt came in while soft-disabled. We set paca->irq_happened, then:
- * - If it was a decrementer interrupt, we bump the dec to max and and return.
- * - If it was a doorbell we return immediately since doorbells are edge
- *   triggered and won't automatically refire.
- * - If it was a HMI we return immediately since we handled it in realmode
- *   and it won't refire.
- * - Else it is one of PACA_IRQ_MUST_HARD_MASK, so hard disable and return.
- * This is called with r10 containing the value to OR to the paca field.
- */
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
+#endif
 
 TRAMP_REAL_BEGIN(stf_barrier_fallback)
 	std	r9,PACA_EXRFI+EX_R9(r13)
@@ -1526,41 +3651,6 @@ TRAMP_REAL_BEGIN(hrfi_flush_fallback)
 	GET_SCRATCH0(r13);
 	hrfid
 
-/*
- * Real mode exceptions actually use this too, but alternate
- * instruction code patches (which end up in the common .text area)
- * cannot reach these if they are put there.
- */
-USE_FIXED_SECTION(virt_trampolines)
-	MASKED_INTERRUPT()
-	MASKED_INTERRUPT(H)
-
-#ifdef CONFIG_KVM_BOOK3S_64_HANDLER
-TRAMP_REAL_BEGIN(kvmppc_skip_interrupt)
-	/*
-	 * Here all GPRs are unchanged from when the interrupt happened
-	 * except for r13, which is saved in SPRG_SCRATCH0.
-	 */
-	mfspr	r13, SPRN_SRR0
-	addi	r13, r13, 4
-	mtspr	SPRN_SRR0, r13
-	GET_SCRATCH0(r13)
-	RFI_TO_KERNEL
-	b	.
-
-TRAMP_REAL_BEGIN(kvmppc_skip_Hinterrupt)
-	/*
-	 * Here all GPRs are unchanged from when the interrupt happened
-	 * except for r13, which is saved in SPRG_SCRATCH0.
-	 */
-	mfspr	r13, SPRN_HSRR0
-	addi	r13, r13, 4
-	mtspr	SPRN_HSRR0, r13
-	GET_SCRATCH0(r13)
-	HRFI_TO_KERNEL
-	b	.
-#endif
-
 /*
  * Ensure that any handlers that get invoked from the exception prologs
  * above are below the first 64KB (0x10000) of the kernel image because
@@ -1619,15 +3709,25 @@ CLOSE_FIXED_SECTION(virt_trampolines);
 
 USE_TEXT_SECTION()
 
+#ifdef CONFIG_PPC_SPLPAR
+tramp_accumulate_stolen_time:
+	b	accumulate_stolen_time
+#endif
+
 /*
  * Hash table stuff
  */
 	.balign	IFETCH_ALIGN_BYTES
 do_hash_page:
+/*
+ * XXX: hash page needs to turn interrupts on for error cases. Difficult.
+ * Idea is to use a common handler for page fault and a common one for hash,
+ * and make one turn on ints and the other not?
+ */
 #ifdef CONFIG_PPC_BOOK3S_64
 	lis	r0,(DSISR_BAD_FAULT_64S | DSISR_DABRMATCH | DSISR_KEYFAULT)@h
 	ori	r0,r0,DSISR_BAD_FAULT_64S@l
-	and.	r0,r4,r0		/* weird error? */
+	and.	r0,r5,r0		/* weird error? */
 	bne-	handle_page_fault	/* if not, try to insert a HPTE */
 	CURRENT_THREAD_INFO(r11, r1)
 	lwz	r0,TI_PREEMPT(r11)	/* If we're in an "NMI" */
@@ -1642,8 +3742,12 @@ do_hash_page:
 	 *
 	 * at return r3 = 0 for success, 1 for page fault, negative for error
 	 */
-        mr 	r4,r12
-	ld      r6,_DSISR(r1)
+	mr	r3,r4
+	ld	r4,_MSR(r1)
+	mr	r7,r5
+	mr	r5,r6
+	mr	r6,r7
+
 	bl	__hash_page		/* build HPTE if possible */
         cmpdi	r3,0			/* see if __hash_page succeeded */
 
@@ -1653,24 +3757,26 @@ do_hash_page:
 	/* Error */
 	blt-	13f
 
-	/* Reload DSISR into r4 for the DABR check below */
-	ld      r4,_DSISR(r1)
+	/* Reload r3-r5 params */
+	ld      r5,_DSISR(r1)
+	ld      r4,_DAR(r1)
+	addi    r3,r1,STACK_FRAME_OVERHEAD
 #endif /* CONFIG_PPC_BOOK3S_64 */
 
 /* Here we have a page fault that hash_page can't handle. */
 handle_page_fault:
-11:	andis.  r0,r4,DSISR_DABRMATCH@h
+	li	r9,MSR_RI
+	ori	r9,r9,MSR_EE
+	mtmsrd	r9,1
+	andis.  r0,r5,DSISR_DABRMATCH@h
 	bne-    handle_dabr_fault
-	ld	r4,_DAR(r1)
-	ld	r5,_DSISR(r1)
-	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	do_page_fault
 	cmpdi	r3,0
 	beq+	12f
 	bl	save_nvgprs
 	mr	r5,r3
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	lwz	r4,_DAR(r1)
+	ld	r4,_DAR(r1) /* XXX: fixme!! */
 	bl	bad_page_fault
 	b	ret_from_except
 
@@ -1704,92 +3810,10 @@ handle_dabr_fault:
  * the access, or panic if there isn't a handler.
  */
 77:	bl	save_nvgprs
-	mr	r4,r3
-	addi	r3,r1,STACK_FRAME_OVERHEAD
 	li	r5,SIGSEGV
 	bl	bad_page_fault
 	b	ret_from_except
 
-/*
- * Here we have detected that the kernel stack pointer is bad.
- * R9 contains the saved CR, r13 points to the paca,
- * r10 contains the (bad) kernel stack pointer,
- * r11 and r12 contain the saved SRR0 and SRR1.
- * We switch to using an emergency stack, save the registers there,
- * and call kernel_bad_stack(), which panics.
- */
-bad_stack:
-	ld	r1,PACAEMERGSP(r13)
-	subi	r1,r1,64+INT_FRAME_SIZE
-	std	r9,_CCR(r1)
-	std	r10,GPR1(r1)
-	std	r11,_NIP(r1)
-	std	r12,_MSR(r1)
-	mfspr	r11,SPRN_DAR
-	mfspr	r12,SPRN_DSISR
-	std	r11,_DAR(r1)
-	std	r12,_DSISR(r1)
-	mflr	r10
-	mfctr	r11
-	mfxer	r12
-	std	r10,_LINK(r1)
-	std	r11,_CTR(r1)
-	std	r12,_XER(r1)
-	SAVE_GPR(0,r1)
-	SAVE_GPR(2,r1)
-	ld	r10,EX_R3(r3)
-	std	r10,GPR3(r1)
-	SAVE_GPR(4,r1)
-	SAVE_4GPRS(5,r1)
-	ld	r9,EX_R9(r3)
-	ld	r10,EX_R10(r3)
-	SAVE_2GPRS(9,r1)
-	ld	r9,EX_R11(r3)
-	ld	r10,EX_R12(r3)
-	ld	r11,EX_R13(r3)
-	std	r9,GPR11(r1)
-	std	r10,GPR12(r1)
-	std	r11,GPR13(r1)
-BEGIN_FTR_SECTION
-	ld	r10,EX_CFAR(r3)
-	std	r10,ORIG_GPR3(r1)
-END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
-	SAVE_8GPRS(14,r1)
-	SAVE_10GPRS(22,r1)
-	lhz	r12,PACA_TRAP_SAVE(r13)
-	std	r12,_TRAP(r1)
-	addi	r11,r1,INT_FRAME_SIZE
-	std	r11,0(r1)
-	li	r12,0
-	std	r12,0(r11)
-	ld	r2,PACATOC(r13)
-	ld	r11,exception_marker@toc(r2)
-	std	r12,RESULT(r1)
-	std	r11,STACK_FRAME_OVERHEAD-16(r1)
-1:	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	kernel_bad_stack
-	b	1b
-_ASM_NOKPROBE_SYMBOL(bad_stack);
-
-/*
- * When doorbell is triggered from system reset wakeup, the message is
- * not cleared, so it would fire again when EE is enabled.
- *
- * When coming from local_irq_enable, there may be the same problem if
- * we were hard disabled.
- *
- * Execute msgclr to clear pending exceptions before handling it.
- */
-h_doorbell_common_msgclr:
-	LOAD_REG_IMMEDIATE(r3, PPC_DBELL_MSGTYPE << (63-36))
-	PPC_MSGCLR(3)
-	b 	h_doorbell_common
-
-doorbell_super_common_msgclr:
-	LOAD_REG_IMMEDIATE(r3, PPC_DBELL_MSGTYPE << (63-36))
-	PPC_MSGCLRP(3)
-	b 	doorbell_super_common
-
 /*
  * Called from arch_local_irq_enable when an interrupt needs
  * to be resent. r3 contains 0x500, 0x900, 0xa00 or 0xe80 to indicate
@@ -1814,23 +3838,23 @@ _GLOBAL(__replay_interrupt)
 	mfcr	r9
 	ori	r12,r12,MSR_EE
 	cmpwi	r3,0x900
-	beq	decrementer_common
+	beq	decrementer_replay
 	cmpwi	r3,0x500
 BEGIN_FTR_SECTION
-	beq	h_virt_irq_common
+	beq	h_virt_irq_replay
 FTR_SECTION_ELSE
-	beq	hardware_interrupt_common
+	beq	hardware_interrupt_replay
 ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_300)
 	cmpwi	r3,0xf00
-	beq	performance_monitor_common
+	beq	performance_monitor_replay
 BEGIN_FTR_SECTION
 	cmpwi	r3,0xa00
-	beq	h_doorbell_common_msgclr
+	beq	h_doorbell_replay
 	cmpwi	r3,0xe60
-	beq	hmi_exception_common
+	beq	hmi_exception_after_real_replay
 FTR_SECTION_ELSE
 	cmpwi	r3,0xa00
-	beq	doorbell_super_common_msgclr
+	beq	doorbell_replay
 ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
 replay_interrupt_return:
 	blr
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 916ddc4aac44..392b9f5597ab 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -138,6 +138,10 @@ notrace unsigned int __check_irq_replay(void)
 	 */
 	unsigned char happened = local_paca->irq_happened;
 
+#ifdef CONFIG_PPC_IRQ_SOFT_MASK_DEBUG
+	WARN_ON(mfmsr() & MSR_EE);
+#endif
+
 	/*
 	 * We are responding to the next interrupt, so interrupt-off
 	 * latencies should be reset here.
@@ -149,13 +153,13 @@ notrace unsigned int __check_irq_replay(void)
 	 * We are always hard disabled here, but PACA_IRQ_HARD_DIS may
 	 * not be set, which means interrupts have only just been hard
 	 * disabled as part of the local_irq_restore or interrupt return
-	 * code. In that case, skip the decrementr check becaus it's
+	 * code. In that case, skip the decrementer check because it's
 	 * expensive to read the TB.
 	 *
 	 * HARD_DIS then gets cleared here, but it's reconciled later.
 	 * Either local_irq_disable will replay the interrupt and that
 	 * will reconcile state like other hard interrupts. Or interrupt
-	 * retur will replay the interrupt and in that case it sets
+	 * return will replay the interrupt and in that case it sets
 	 * PACA_IRQ_HARD_DIS by hand (see comments in entry_64.S).
 	 */
 	if (happened & PACA_IRQ_HARD_DIS) {
@@ -269,7 +273,8 @@ notrace void arch_local_irq_restore(unsigned long mask)
 		 * #endif
 		 *
 		 * But currently it hits in a few paths, we should fix those and
-		 * enable the warning.
+		 * enable the warning. Actually can't do this because of
+		 * interrupts
 		 */
 		return;
 	}
@@ -282,6 +287,10 @@ notrace void arch_local_irq_restore(unsigned long mask)
 	 */
 	if (!(irq_happened & PACA_IRQ_HARD_DIS)) {
 #ifdef CONFIG_PPC_IRQ_SOFT_MASK_DEBUG
+		/*
+		 * XXX: this could false positive with racing EE/PMI turning
+		 * off MSR[EE] here. Read MSR first?
+		 */
 		WARN_ON(!(mfmsr() & MSR_EE));
 #endif
 		__hard_irq_disable();
@@ -644,7 +653,8 @@ void __do_irq(struct pt_regs *regs)
 	irq = ppc_md.get_irq();
 
 	/* We can hard enable interrupts now to allow perf interrupts */
-	may_hard_irq_enable();
+	if (may_hard_irq_enable())
+		do_hard_irq_enable();
 
 	/* And finally process it */
 	if (unlikely(!irq))
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 3646affae963..3be08637d8ed 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -100,7 +100,7 @@ static struct clocksource clocksource_timebase = {
 };
 
 #define DECREMENTER_DEFAULT_MAX 0x7FFFFFFF
-u64 decrementer_max = DECREMENTER_DEFAULT_MAX;
+u64 decrementer_max __read_mostly = DECREMENTER_DEFAULT_MAX;
 
 static int decrementer_set_next_event(unsigned long evt,
 				      struct clock_event_device *dev);
@@ -577,12 +577,13 @@ void arch_irq_work_raise(void)
  * timer_interrupt - gets called when the decrementer overflows,
  * with interrupts disabled.
  */
-void timer_interrupt(struct pt_regs *regs)
+void timer_interrupt_new(struct pt_regs *regs, u64 now)
 {
-	struct clock_event_device *evt = this_cpu_ptr(&decrementers);
-	u64 *next_tb = this_cpu_ptr(&decrementers_next_tb);
 	struct pt_regs *old_regs;
-	u64 now;
+	u64 *next_tbp = this_cpu_ptr(&decrementers_next_tb);
+	u64 next_tb = *next_tbp;
+
+	*next_tbp = ~(u64)0;
 
 	/* Some implementations of hotplug will get timer interrupts while
 	 * offline, just ignore these and we also need to set
@@ -591,27 +592,26 @@ void timer_interrupt(struct pt_regs *regs)
 	 * here infinitely :(
 	 */
 	if (unlikely(!cpu_online(smp_processor_id()))) {
-		*next_tb = ~(u64)0;
 		set_dec(decrementer_max);
 		return;
 	}
 
-	/* Ensure a positive value is written to the decrementer, or else
-	 * some CPUs will continue to take decrementer exceptions. When the
-	 * PPC_WATCHDOG (decrementer based) is configured, keep this at most
-	 * 31 bits, which is about 4 seconds on most systems, which gives
-	 * the watchdog a chance of catching timer interrupt hard lockups.
-	 */
-	if (IS_ENABLED(CONFIG_PPC_WATCHDOG))
-		set_dec(0x7fffffff);
-	else
-		set_dec(decrementer_max);
-
-	/* Conditionally hard-enable interrupts now that the DEC has been
-	 * bumped to its maximum value
-	 */
-	may_hard_irq_enable();
+	/* Conditionally hard-enable interrupts. */
+	if (may_hard_irq_enable()) {
+		/* Ensure a positive value is written to the decrementer, or
+		 * else some CPUs will continue to take decrementer exceptions.
+		 * When the PPC_WATCHDOG (decrementer based) is configured,
+		 * keep this at most 31 bits, which is about 4 seconds on most
+		 * systems, which gives the watchdog a chance of catching timer
+		 * interrupt hard lockups.
+		 */
+		if (IS_ENABLED(CONFIG_PPC_WATCHDOG))
+			set_dec(0x7fffffff);
+		else
+			set_dec(decrementer_max);
 
+		do_hard_irq_enable();
+	}
 
 #if defined(CONFIG_PPC32) && defined(CONFIG_PPC_PMAC)
 	if (atomic_read(&ppc_n_lost_interrupts) != 0)
@@ -627,16 +627,14 @@ void timer_interrupt(struct pt_regs *regs)
 		irq_work_run();
 	}
 
-	now = get_tb_or_rtc();
-	if (now >= *next_tb) {
-		*next_tb = ~(u64)0;
+	if (now >= next_tb) {
+		struct clock_event_device *evt = this_cpu_ptr(&decrementers);
 		if (evt->event_handler)
 			evt->event_handler(evt);
 		__this_cpu_inc(irq_stat.timer_irqs_event);
 	} else {
-		now = *next_tb - now;
-		if (now <= decrementer_max)
-			set_dec(now);
+		u64 dec = next_tb - now;
+		set_dec(dec);
 		/* We may have raced with new irq work */
 		if (test_irq_work_pending())
 			set_dec(1);
@@ -649,6 +647,11 @@ void timer_interrupt(struct pt_regs *regs)
 }
 EXPORT_SYMBOL(timer_interrupt);
 
+void timer_interrupt(struct pt_regs * regs)
+{
+	timer_interrupt_new(regs, get_tb_or_rtc());
+}
+
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
 void timer_broadcast_interrupt(void)
 {
@@ -660,15 +663,6 @@ void timer_broadcast_interrupt(void)
 }
 #endif
 
-/*
- * Hypervisor decrementer interrupts shouldn't occur but are sometimes
- * left pending on exit from a KVM guest.  We don't need to do anything
- * to clear them, as they are edge-triggered.
- */
-void hdec_interrupt(struct pt_regs *regs)
-{
-}
-
 #ifdef CONFIG_SUSPEND
 static void generic_suspend_disable_irqs(void)
 {
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 64936b60d521..0d5fc706c7a1 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -346,8 +346,9 @@ static bool exception_common(int signr, struct pt_regs *regs, int code,
 
 	show_signal_msg(signr, regs, code, addr);
 
-	if (arch_irqs_disabled() && !arch_irq_disabled_regs(regs))
-		local_irq_enable();
+	/* Some paths have already enabled */
+	if (arch_irqs_disabled())
+		maybe_irqs_enable_after_interrupt(regs);
 
 	current->thread.trap_nr = code;
 
@@ -1451,9 +1452,7 @@ void program_check_exception(struct pt_regs *regs)
 	if (!user_mode(regs))
 		goto sigill;
 
-	/* We restore the interrupt state now */
-	if (!arch_irq_disabled_regs(regs))
-		local_irq_enable();
+	maybe_irqs_enable_after_interrupt(regs);
 
 	/* (reason & REASON_ILLEGAL) would be the obvious thing here,
 	 * but there seems to be a hardware bug on the 405GP (RevD)
@@ -1506,9 +1505,7 @@ void alignment_exception(struct pt_regs *regs)
 	enum ctx_state prev_state = exception_enter();
 	int sig, code, fixed = 0;
 
-	/* We restore the interrupt state now */
-	if (!arch_irq_disabled_regs(regs))
-		local_irq_enable();
+	maybe_irqs_enable_after_interrupt(regs);
 
 	if (tm_abort_check(regs, TM_CAUSE_ALIGNMENT | TM_CAUSE_PERSISTENT))
 		goto bail;
@@ -1649,9 +1646,7 @@ void facility_unavailable_exception(struct pt_regs *regs)
 		die("Unexpected facility unavailable exception", regs, SIGABRT);
 	}
 
-	/* We restore the interrupt state now */
-	if (!arch_irq_disabled_regs(regs))
-		local_irq_enable();
+	maybe_irqs_enable_after_interrupt(regs);
 
 	if (status == FSCR_DSCR_LG) {
 		/*
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 887f11bcf330..80b29f036770 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -473,9 +473,13 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 		return bad_area_nosemaphore(regs, address);
 	}
 
-	/* We restore the interrupt state now */
-	if (!arch_irq_disabled_regs(regs))
-		local_irq_enable();
+	/*
+	 * 64/s does not need to maybe-enable because we are aleady enabled
+	 * here by the handler
+	 */
+#ifndef CONFIG_PPC_BOOK3S_64
+	maybe_irqs_enable_after_interrupt(regs);
+#endif
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 
diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index b0723002a396..faae76a6ce1c 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -1267,7 +1267,7 @@ static void power_pmu_disable(struct pmu *pmu)
 }
 
 /*
- * Re-enable all events if disable == 0.
+ * Re-enable all events if disable == 1.
  * If we were previously disabled and events were added, then
  * put the new config on the PMU.
  */
@@ -2259,6 +2259,17 @@ static void perf_event_interrupt(struct pt_regs *regs)
 	perf_sample_event_took(sched_clock() - start_clock);
 }
 
+bool power_pmu_running(void)
+{
+	struct cpu_hw_events *cpuhw;
+
+	if (!ppmu)
+		return false;
+
+	cpuhw = this_cpu_ptr(&cpu_hw_events);
+	return cpuhw->n_events;
+}
+
 static int power_pmu_prepare_cpu(unsigned int cpu)
 {
 	struct cpu_hw_events *cpuhw = &per_cpu(cpu_hw_events, cpu);

-- 
2.18.0

