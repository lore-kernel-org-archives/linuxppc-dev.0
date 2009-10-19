Return-Path: <vbarshak@ru.mvista.com>
Received: from localhost.localdomain (unknown [93.100.123.135])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 98F0BB7B72
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Oct 2009 05:29:11 +1100 (EST)
Date: Mon, 19 Oct 2009 22:28:58 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [RFC] PowerPC64: Use preempt_schedule_irq instead of
	preempt_schedule when returning from exceptions
Message-ID: <20091019182858.GA10495@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: olof@lixom.net, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use preempt_schedule_irq to prevent infinite irq-entry and
eventual stack overflow problems with fast-paced IRQ sources.
This kind of problems has been observed on the PASemi Electra IDE
controller. We have to make sure we are soft-disabled before calling
preempt_schedule_irq and hard disable interrupts after that
to avoid unrecoverable exceptions.

This patch also moves the "clrrdi r9,r1,THREAD_SHIFT" out of
the #ifdef CONFIG_PPC_BOOK3E scope, since r9 is clobbered
and has to be restored in both cases.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 arch/powerpc/kernel/entry_64.S |   25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff -pruN linux-2.6.orig/arch/powerpc/kernel/entry_64.S linux-2.6.new/arch/powerpc/kernel/entry_64.S
--- linux-2.6.orig/arch/powerpc/kernel/entry_64.S	2009-10-17 03:46:26.000000000 +0400
+++ linux-2.6.new/arch/powerpc/kernel/entry_64.S	2009-10-19 17:35:16.000000000 +0400
@@ -660,33 +660,20 @@ do_work:
 	bne	restore
 	/* here we are preempting the current task */
 1:
-#ifdef CONFIG_TRACE_IRQFLAGS
-	bl	.trace_hardirqs_on
-	/* Note: we just clobbered r10 which used to contain the previous
-	 * MSR before the hard-disabling done by the caller of do_work.
-	 * We don't have that value anymore, but it doesn't matter as
-	 * we will hard-enable unconditionally, we can just reload the
-	 * current MSR into r10
-	 */
-	mfmsr	r10
-#endif /* CONFIG_TRACE_IRQFLAGS */
-	li	r0,1
+	/* ensure we are soft-disabled */
+	li	r0,0
 	stb	r0,PACASOFTIRQEN(r13)
-	stb	r0,PACAHARDIRQEN(r13)
+	bl	.preempt_schedule_irq
+	/* hard-disable interrupts */
 #ifdef CONFIG_PPC_BOOK3E
-	wrteei	1
-	bl	.preempt_schedule
 	wrteei	0
 #else
-	ori	r10,r10,MSR_EE
-	mtmsrd	r10,1		/* reenable interrupts */
-	bl	.preempt_schedule
 	mfmsr	r10
-	clrrdi	r9,r1,THREAD_SHIFT
-	rldicl	r10,r10,48,1	/* disable interrupts again */
+	rldicl	r10,r10,48,1
 	rotldi	r10,r10,16
 	mtmsrd	r10,1
 #endif /* CONFIG_PPC_BOOK3E */
+	clrrdi	r9,r1,THREAD_SHIFT
 	ld	r4,TI_FLAGS(r9)
 	andi.	r0,r4,_TIF_NEED_RESCHED
 	bne	1b
