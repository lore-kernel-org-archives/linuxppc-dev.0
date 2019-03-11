Return-Path: <SRS0=/OnI=RO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B9CC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 08:37:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA2E32064A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 08:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="ojjJGui4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA2E32064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Hs185SkMzDqF3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 19:37:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="ojjJGui4"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Hrs758ygzDqCp
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Mar 2019 19:30:35 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44Hrrz4c0VzB09Zr;
 Mon, 11 Mar 2019 09:30:27 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=ojjJGui4; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id pNA_HruhAHjz; Mon, 11 Mar 2019 09:30:27 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44Hrrz3K2kzB09ZD;
 Mon, 11 Mar 2019 09:30:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1552293027; bh=tzLjMO94kEQ2Jb+M7Kmi/RZwE3wJFBGLZk4kgd60olM=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=ojjJGui4zBtwWShgDFk3s2W5QjnVLkdo5ZHv2ys0vAg1QfJbjuTlgTcMmYwjK5Hdt
 Qc9f+b7fDpPfXr9rVY9HhT8vDFK7HQ8vipnJ4r6GyleAypJcNIKSUWuxgYSbXgyAii
 l0tKXzwsC7PWqpO1m922ZDvWOtXYqc/M15/+X/Ts=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id BD7F48B813;
 Mon, 11 Mar 2019 09:30:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id NHAok17hrgjz; Mon, 11 Mar 2019 09:30:31 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 8E2748B7FE;
 Mon, 11 Mar 2019 09:30:31 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 80CC46FA08; Mon, 11 Mar 2019 08:30:31 +0000 (UTC)
Message-Id: <a4b2d23dec0624ac07669ff2933ac4ca85278423.1552292207.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1552292207.git.christophe.leroy@c-s.fr>
References: <cover.1552292207.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 04/10] powerpc/32: Prepare for Kernel Userspace Access
 Protection
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 ruscur@russell.cc
Date: Mon, 11 Mar 2019 08:30:31 +0000 (UTC)
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This patch adds ASM macros for saving, restoring and checking
the KUAP state, and modifies setup_32 to call them on exceptions
from kernel.

The macros are defined as empty by default for when CONFIG_PPC_KUAP
is not selected and/or for platforms which don't handle (yet) KUAP.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/kup.h         | 15 ++++++++++++++-
 arch/powerpc/kernel/entry_32.S         | 16 ++++++++++++----
 arch/powerpc/platforms/Kconfig.cputype |  2 +-
 3 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/kup.h b/arch/powerpc/include/asm/kup.h
index ccbd2a249575..632b367b93f4 100644
--- a/arch/powerpc/include/asm/kup.h
+++ b/arch/powerpc/include/asm/kup.h
@@ -6,7 +6,20 @@
 #include <asm/book3s/64/kup-radix.h>
 #endif
 
-#ifndef __ASSEMBLY__
+#ifdef __ASSEMBLY__
+#ifndef CONFIG_PPC_KUAP
+.macro kuap_save_and_lock	sp, thread, gpr1, gpr2, gpr3
+.endm
+
+.macro kuap_restore	sp, current, gpr1, gpr2, gpr3
+.endm
+
+.macro kuap_check	current, gpr
+.endm
+
+#endif
+
+#else /* !__ASSEMBLY__ */
 
 #include <asm/pgtable.h>
 
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index aaf7c5f44823..1182bf603d3c 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -36,6 +36,7 @@
 #include <asm/asm-405.h>
 #include <asm/feature-fixups.h>
 #include <asm/barrier.h>
+#include <asm/kup.h>
 
 /*
  * MSR_KERNEL is > 0x10000 on 4xx/Book-E since it include MSR_CE.
@@ -150,8 +151,8 @@ transfer_to_handler:
 	stw	r12,_CTR(r11)
 	stw	r2,_XER(r11)
 	mfspr	r12,SPRN_SPRG_THREAD
-	addi	r2,r12,-THREAD
 	beq	2f			/* if from user, fix up THREAD.regs */
+	addi	r2, r12, -THREAD
 	addi	r11,r1,STACK_FRAME_OVERHEAD
 	stw	r11,PT_REGS(r12)
 #if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
@@ -186,6 +187,8 @@ transfer_to_handler:
 2:	/* if from kernel, check interrupted DOZE/NAP mode and
          * check for stack overflow
          */
+	kuap_save_and_lock r11, r12, r9, r2, r0
+	addi	r2, r12, -THREAD
 	lwz	r9,KSP_LIMIT(r12)
 	cmplw	r1,r9			/* if r1 <= ksp_limit */
 	ble-	stack_ovf		/* then the kernel stack overflowed */
@@ -272,6 +275,7 @@ reenable_mmu:				/* re-enable mmu so we can */
 	lwz	r9,_MSR(r11)		/* if sleeping, clear MSR.EE */
 	rlwinm	r9,r9,0,~MSR_EE
 	lwz	r12,_LINK(r11)		/* and return to address in LR */
+	kuap_restore r11, r2, r3, r4, r5
 	b	fast_exception_return
 #endif
 
@@ -423,6 +427,7 @@ BEGIN_FTR_SECTION
 END_FTR_SECTION_IFSET(CPU_FTR_NEED_PAIRED_STWCX)
 	stwcx.	r0,0,r1			/* to clear the reservation */
 	ACCOUNT_CPU_USER_EXIT(r2, r5, r7)
+	kuap_check r2, r4
 	lwz	r4,_LINK(r1)
 	lwz	r5,_CCR(r1)
 	mtlr	r4
@@ -673,6 +678,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_SPE)
 	stw	r10,_CCR(r1)
 	stw	r1,KSP(r3)	/* Set old stack pointer */
 
+	kuap_check r2, r4
 #ifdef CONFIG_SMP
 	/* We need a sync somewhere here to make sure that if the
 	 * previous task gets rescheduled on another CPU, it sees all
@@ -861,12 +867,12 @@ resume_kernel:
 	/* check current_thread_info->preempt_count */
 	lwz	r0,TI_PREEMPT(r2)
 	cmpwi	0,r0,0		/* if non-zero, just restore regs and return */
-	bne	restore
+	bne	restore_kuap
 	andi.	r8,r8,_TIF_NEED_RESCHED
-	beq+	restore
+	beq+	restore_kuap
 	lwz	r3,_MSR(r1)
 	andi.	r0,r3,MSR_EE	/* interrupts off? */
-	beq	restore		/* don't schedule if so */
+	beq	restore_kuap	/* don't schedule if so */
 #ifdef CONFIG_TRACE_IRQFLAGS
 	/* Lockdep thinks irqs are enabled, we need to call
 	 * preempt_schedule_irq with IRQs off, so we inform lockdep
@@ -885,6 +891,8 @@ resume_kernel:
 	bl	trace_hardirqs_on
 #endif
 #endif /* CONFIG_PREEMPT */
+restore_kuap:
+	kuap_restore r1, r2, r9, r10, r0
 
 	/* interrupts are hard-disabled at this point */
 restore:
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 5e53b9fd62aa..2e45a6e2bc99 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -373,7 +373,7 @@ config PPC_KUAP
 
 config PPC_KUAP_DEBUG
 	bool "Extra debugging for Kernel Userspace Access Protection"
-	depends on PPC_HAVE_KUAP && PPC_RADIX_MMU
+	depends on PPC_HAVE_KUAP && (PPC_RADIX_MMU || PPC_32)
 	help
 	  Add extra debugging for Kernel Userspace Access Protection (KUAP)
 	  If you're unsure, say N.
-- 
2.13.3

