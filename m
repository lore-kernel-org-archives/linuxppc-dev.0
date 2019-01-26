Return-Path: <SRS0=UfQ7=QC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24EDC282C0
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Jan 2019 02:42:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74DF6218B0
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Jan 2019 02:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBNl9KS/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74DF6218B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43mgCK6pwlzDqRx
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Jan 2019 13:42:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="dBNl9KS/"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43mg9g5TlNzDqJX
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Jan 2019 13:40:39 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id a14so5364905plm.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2019 18:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=LnZepex7+WZtAmCDkHPUIdBUn50XycCcdk0ns6Xum+k=;
 b=dBNl9KS/wBrWipN3lb/gyVuc6FRUcpe3dynjvL6iTe6NwCTh5f5Mg8B+V7E+W4paqt
 M/X3ZHpjv1ZYAe2FnTR4Nu1ITlhWG5h0KOUcSNizJwtH/VNQku0Dx8w92QBMaj5upRn5
 +eJp5gPS54bIe8Cygj3P35AloZrfNRw8i/uyQo0PAKwcVMBaHz0ibuao7RTzVPogvdAe
 1DO9ZEn8bIZEGj7FMnGLnfiFfOvGG+4lshdQw/z2taDszG4XLj/02CttJk2pAw9FLrv9
 AAzDh4zOdOfPPtdJIEunVdvjhOmib/hlCXuPS7+uHV1pGRx7bQ7MetziVF9TfWSB/1SM
 thcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=LnZepex7+WZtAmCDkHPUIdBUn50XycCcdk0ns6Xum+k=;
 b=Zbcs6QLhqdpaNpOyJr/sJs8NH0Uz26khRwqL/WZWbPy/JI5qkiSBBMV/czSiO4EJjp
 WvtApU4a8Jya2TF3pqgBedIjNQKCJ5vm54iNddYOs3ece6+GDFxd/6nboKTThFkMUkRJ
 e+oj4Jbxy/mcRe0GpGAswFsw1b9O+3BNhG1YvkOeUI5f5TGd1B+OB28cubqsftoY17kj
 NNSIDaHOSb533/UDooj6cWVymfYWX4+Ji85XvfHzJkXsX5rFg4Ca7rEsypnJUGUVy/pJ
 P1weGiV/N0AjKZPnPblZ/ekwkLpTm1nolnG5PTXGYFm7qiazqeX/gRr6ResNTWmJ7nm2
 /96g==
X-Gm-Message-State: AJcUukeLqpovR2A41z2lMCvxSZ6kOsTzAC4cfxJA6JB1LAF8iONsgFuo
 BPUAtECyHKuL5M3QG+KR/cL9eQsr
X-Google-Smtp-Source: ALg8bN6d7cvMcqbG0h3VVciuczLnylNNT/4wB1K5AUdyS2WM+8hrq1gdE3KPjXsuFZfpshHxpzjo7Q==
X-Received: by 2002:a17:902:830a:: with SMTP id
 bd10mr13574613plb.321.1548470437453; 
 Fri, 25 Jan 2019 18:40:37 -0800 (PST)
Received: from roar.local0.net (115-64-241-162.tpgi.com.au. [115.64.241.162])
 by smtp.gmail.com with ESMTPSA id
 e16sm32905025pfn.46.2019.01.25.18.40.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 25 Jan 2019 18:40:36 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH] powerpc/64s: interrupt handler remove bad stack branch
Date: Sat, 26 Jan 2019 12:40:28 +1000
Message-Id: <20190126024028.11664-1-npiggin@gmail.com>
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

The bad stack test in interrupt handlers is annoying because it is an
always taken branch, which is a fetch bubble and a waste of i-cache.
It also requires yet another stack frame setup routine.

Remove the test/branch and replace it with a trap. Teach the program
check handler to use the emergency stack for this case.

This does not reconstruct the stack message quite so nicely as
previously, but the SRR0 and SRR1 of the crashed interrupt can be seen
in r11 and r12, as is the original r1, adjusted by INT_FRAME_SIZE,
which are the most important parts. The original r9-12 and cr0 is
lost, which is the main downside.

kernel BUG at linux/arch/powerpc/kernel/exceptions-64s.S:847!
Oops: Exception in kernel mode, sig: 5 [#1]
BE SMP NR_CPUS=2048 NUMA PowerNV
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted
NIP:  c000000000009108 LR: c000000000cadbcc CTR: c0000000000090f0
REGS: c0000000fffcbd70 TRAP: 0700   Not tainted
MSR:  9000000000021032 <SF,HV,ME,IR,DR,RI>  CR: 28222448  XER: 20040000
CFAR: c000000000009100 IRQMASK: 0
GPR00: 000000000000003d fffffffffffffd00 c0000000018cfb00 c0000000f02b3166
GPR04: fffffffffffffffd 0000000000000007 fffffffffffffffb 0000000000000030
GPR08: 0000000000000037 0000000028222448 0000000000000000 c000000000ca8de0
GPR12: 9000000002009032 c000000001ae0000 c000000000010a00 0000000000000000
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
GPR20: c0000000f00322c0 c000000000f85200 0000000000000004 ffffffffffffffff
GPR24: fffffffffffffffe 0000000000000000 0000000000000000 000000000000000a
GPR28: 0000000000000000 0000000000000000 c0000000f02b391c c0000000f02b3167
NIP [c000000000009108] decrementer_common+0x18/0x160
LR [c000000000cadbcc] .vsnprintf+0x3ec/0x4f0
Call Trace:
Instruction dump:
996d098a 994d098b 38610070 480246ed 48005518 60000000 38200000 718a4000
7c2a0b78 3821fd00 41c20008 e82d0970 <0981fd00> f92101a0 f9610170 f9810178

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/exception-64s.h | 17 +----
 arch/powerpc/kernel/exceptions-64s.S     | 85 ++++--------------------
 2 files changed, 16 insertions(+), 86 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 3b4767ed3ec5..6168021bf530 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -60,13 +60,6 @@
  */
 #define MAX_MCE_DEPTH	4
 
-/*
- * EX_R3 is only used by the bad_stack handler. bad_stack reloads and
- * saves DAR from SPRN_DAR, and EX_DAR is not used. So EX_R3 can overlap
- * with EX_DAR.
- */
-#define EX_R3		EX_DAR
-
 #define STF_ENTRY_BARRIER_SLOT						\
 	STF_ENTRY_BARRIER_FIXUP_SECTION;				\
 	nop;								\
@@ -488,14 +481,8 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	subi	r1,r1,INT_FRAME_SIZE;	/* alloc frame on kernel stack	*/ \
 	beq-	1f;							   \
 	ld	r1,PACAKSAVE(r13);	/* kernel stack to use		*/ \
-1:	cmpdi	cr1,r1,-INT_FRAME_SIZE;	/* check if r1 is in userspace	*/ \
-	blt+	cr1,3f;			/* abort if it is		*/ \
-	li	r1,(n);			/* will be reloaded later	*/ \
-	sth	r1,PACA_TRAP_SAVE(r13);					   \
-	std	r3,area+EX_R3(r13);					   \
-	addi	r3,r13,area;		/* r3 -> where regs are saved*/	   \
-	RESTORE_CTR(r1, area);						   \
-	b	bad_stack;						   \
+1:	tdgei	r1,-INT_FRAME_SIZE;	/* trap if r1 is in userspace	*/ \
+	EMIT_BUG_ENTRY 1b,__FILE__,__LINE__,0;				   \
 3:	EXCEPTION_PROLOG_COMMON_1();					   \
 	beq	4f;			/* if from kernel mode		*/ \
 	ACCOUNT_CPU_USER_ENTRY(r13, r9, r10);				   \
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 9e253ce27e08..b1ffc92cc4f9 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -735,21 +735,25 @@ EXC_COMMON_BEGIN(program_check_common)
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
+
+	andi.	r10,r12,MSR_PR
+	bne	2f			/* If userspace, go normal path */
+
+	andis.	r10,r12,(SRR1_PROGTM)@h
+	bne	1f			/* If TM, emergency		*/
+
+	cmpdi	r1,-INT_FRAME_SIZE	/* check if r1 is in userspace	*/
+	blt	2f			/* normal path if not		*/
+
+	/* Use the emergency stack					*/
+1:	andi.	r10,r12,MSR_PR		/* Set CR0 correctly for label	*/
 					/* 3 in EXCEPTION_PROLOG_COMMON	*/
 	mr	r10,r1			/* Save r1			*/
 	ld	r1,PACAEMERGSP(r13)	/* Use emergency stack		*/
 	subi	r1,r1,INT_FRAME_SIZE	/* alloc stack frame		*/
 	b 3f				/* Jump into the macro !!	*/
-1:	EXCEPTION_PROLOG_COMMON(0x700, PACA_EXGEN)
+2:
+	EXCEPTION_PROLOG_COMMON(0x700, PACA_EXGEN)
 	bl	save_nvgprs
 	RECONCILE_IRQ_STATE(r10, r11)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
@@ -1710,67 +1714,6 @@ handle_dabr_fault:
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
 /*
  * When doorbell is triggered from system reset wakeup, the message is
  * not cleared, so it would fire again when EE is enabled.
-- 
2.18.0

