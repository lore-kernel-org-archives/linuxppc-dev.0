Return-Path: <mcaraman@mcaraman-VirtualBox.ea.freescale.net>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9411E2C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Aug 2012 23:27:28 +1000 (EST)
Received: from mail43-ch1 (localhost [127.0.0.1])	by mail43-ch1-R.bigfish.com
 (Postfix) with ESMTP id 9ADBCA00AA	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Aug 2012 13:27:23 +0000 (UTC)
Received: from CH1EHSMHS015.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.246])	by mail43-ch1.bigfish.com (Postfix) with ESMTP id
 A0FDB2200B7
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Aug 2012 13:27:21 +0000 (UTC)
Received: from mcaraman-VirtualBox.ea.freescale.net ([10.213.130.145])	by
 tx30smr01.am.freescale.net (8.14.3/8.14.0) with ESMTP id q76DRInp012086	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Aug 2012 06:27:19 -0700
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 4/6] powerpc/booke64: remove mfspr srr1 duplicate in exception
 prolog
Date: Mon, 6 Aug 2012 16:27:06 +0300
Message-ID: <1344259628-31161-5-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1344259628-31161-1-git-send-email-mihai.caraman@freescale.com>
References: <1344259628-31161-1-git-send-email-mihai.caraman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mihai Caraman <mihai.caraman@freescale.com>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Refactor exception prolog to get rid of mfspr srr1 duplicate. This was
introduced by KVM integration, with DO_KVM macro logic expecting srr1 value
earlier in r11.
Reserve r11 to hold srr1's value also required at the end of the prolog and
free up r10 to serve as spare in addition macros.
For syscalls case this change does not add any performance penalty. For irq
soft-disabled case the change adds a store/load of conditional register value
to/from a paca slot. Paca slots fit in one 64-byte cache line so these
additional operations have little impact on performance.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
 arch/powerpc/kernel/exceptions-64e.S |   67 ++++++++++++++++------------------
 1 files changed, 32 insertions(+), 35 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 3b1ad1b..83c20e8 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -45,10 +45,9 @@
 	mfcr	r10;			/* save CR */			    \
 	mfspr	r11,SPRN_##type##_SRR1;/* what are we coming from */	    \
 	DO_KVM	intnum,SPRN_##type##_SRR1;    /* KVM hook */		    \
+	stw	r10,PACA_EX##type+EX_CR(r13); /* save old CR in the PACA */ \
 	addition;			/* additional code for that exc. */ \
 	std	r1,PACA_EX##type+EX_R1(r13); /* save old r1 in the PACA */  \
-	stw	r10,PACA_EX##type+EX_CR(r13); /* save old CR in the PACA */ \
-	mfspr	r11,SPRN_##type##_SRR1;/* what are we coming from */	    \
 	type##_SET_KSTACK;		/* get special stack if necessary */\
 	andi.	r10,r11,MSR_PR;		/* save stack pointer */	    \
 	beq	1f;			/* branch around if supervisor */   \
@@ -109,8 +108,8 @@
 #define PROLOG_ADDITION_NONE_MC(n)
 
 #define PROLOG_ADDITION_MASKABLE_GEN(n)					    \
-	lbz	r11,PACASOFTIRQEN(r13); /* are irqs soft-disabled ? */	    \
-	cmpwi	cr0,r11,0;		/* yes -> go out of line */	    \
+	lbz	r10,PACASOFTIRQEN(r13); /* are irqs soft-disabled ? */	    \
+	cmpwi	cr0,r10,0;		/* yes -> go out of line */	    \
 	beq	masked_interrupt_book3e_##n
 
 #define PROLOG_ADDITION_2REGS_GEN(n)					    \
@@ -624,44 +623,42 @@ kernel_dbg_exc:
  * accordingly and if the interrupt is level sensitive, we hard disable
  */
 
+.macro masked_interrupt_book3e paca_irq full_mask
+	lbz	r10,PACAIRQHAPPENED(r13)
+	ori	r10,r10,\paca_irq
+	stb	r10,PACAIRQHAPPENED(r13)
+
+	.if \full_mask == 1
+	rldicl	r10,r11,48,1		/* clear MSR_EE */
+	rotldi	r11,r10,16
+	mtspr	SPRN_SRR1,r11
+	.endif
+
+	lwz	r11,PACA_EXGEN+EX_CR(r13)
+	mtcr	r11
+	ld	r10,PACA_EXGEN+EX_R10(r13)
+	ld	r11,PACA_EXGEN+EX_R11(r13)
+	mfspr	r13,SPRN_SPRG_GEN_SCRATCH
+	rfi
+	b	.
+.endm
+
 masked_interrupt_book3e_0x500:
-	/* XXX When adding support for EPR, use PACA_IRQ_EE_EDGE */
-	li	r11,PACA_IRQ_EE
-	b	masked_interrupt_book3e_full_mask
+	// XXX When adding support for EPR, use PACA_IRQ_EE_EDGE
+	masked_interrupt_book3e PACA_IRQ_EE 1
 
 masked_interrupt_book3e_0x900:
-	ACK_DEC(r11);
-	li	r11,PACA_IRQ_DEC
-	b	masked_interrupt_book3e_no_mask
+	ACK_DEC(r10);
+	masked_interrupt_book3e PACA_IRQ_DEC 0
+
 masked_interrupt_book3e_0x980:
-	ACK_FIT(r11);
-	li	r11,PACA_IRQ_DEC
-	b	masked_interrupt_book3e_no_mask
+	ACK_FIT(r10);
+	masked_interrupt_book3e PACA_IRQ_DEC 0
+
 masked_interrupt_book3e_0x280:
 masked_interrupt_book3e_0x2c0:
-	li	r11,PACA_IRQ_DBELL
-	b	masked_interrupt_book3e_no_mask
+	masked_interrupt_book3e PACA_IRQ_DBELL 0
 
-masked_interrupt_book3e_no_mask:
-	mtcr	r10
-	lbz	r10,PACAIRQHAPPENED(r13)
-	or	r10,r10,r11
-	stb	r10,PACAIRQHAPPENED(r13)
-	b	1f
-masked_interrupt_book3e_full_mask:
-	mtcr	r10
-	lbz	r10,PACAIRQHAPPENED(r13)
-	or	r10,r10,r11
-	stb	r10,PACAIRQHAPPENED(r13)
-	mfspr	r10,SPRN_SRR1
-	rldicl	r11,r10,48,1		/* clear MSR_EE */
-	rotldi	r10,r11,16
-	mtspr	SPRN_SRR1,r10
-1:	ld	r10,PACA_EXGEN+EX_R10(r13);
-	ld	r11,PACA_EXGEN+EX_R11(r13);
-	mfspr	r13,SPRN_SPRG_GEN_SCRATCH;
-	rfi
-	b	.
 /*
  * Called from arch_local_irq_enable when an interrupt needs
  * to be resent. r3 contains either 0x500,0x900,0x260 or 0x280
-- 
1.7.4.1
