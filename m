Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 41CF4B7B9B
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Oct 2009 10:55:35 +1100 (EST)
Subject: Re: [PATCH] [RFC] PowerPC64: Use preempt_schedule_irq instead of
	preempt_schedule when returning from exceptions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Valentine Barshak <vbarshak@ru.mvista.com>
In-Reply-To: <20091019182858.GA10495@ru.mvista.com>
References: <20091019182858.GA10495@ru.mvista.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 27 Oct 2009 10:55:24 +1100
Message-ID: <1256601324.2076.49.camel@pasglop>
Mime-Version: 1.0
Cc: olof@lixom.net, linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-10-19 at 22:28 +0400, Valentine Barshak wrote:
> Use preempt_schedule_irq to prevent infinite irq-entry and
> eventual stack overflow problems with fast-paced IRQ sources.
> This kind of problems has been observed on the PASemi Electra IDE
> controller. We have to make sure we are soft-disabled before calling
> preempt_schedule_irq and hard disable interrupts after that
> to avoid unrecoverable exceptions.
> 
> This patch also moves the "clrrdi r9,r1,THREAD_SHIFT" out of
> the #ifdef CONFIG_PPC_BOOK3E scope, since r9 is clobbered
> and has to be restored in both cases.

So I _think_ that the irqs on/off accounting for lockdep isn't quite
right. What do you think of this slightly modified version ? I've only
done a quick boot test on a G5 with lockdep enabled and a played a bit,
nothing shows up so far but it's definitely not conclusive.

The main difference is that I call trace_hardirqs_off to "advertise"
the fact that we are soft-disabling (it could be a dup, but at this
stage this is no big deal, but it's not always, like in syscall return
the kernel thinks we have interrupts enabled and could thus get out
of sync without that).

I also mark the PACA hard disable to reflect the MSR:EE state before
calling into preempt_schedule_irq().

---

[PATCH v2] powerpc: Use preempt_schedule_irq instead of preempt_schedule when returning from exceptions

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
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/entry_64.S |   38 +++++++++++++++++++++-----------------
 1 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index f9fd54b..b64ae3d 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -659,34 +659,38 @@ do_work:
 	crandc	eq,cr1*4+eq,eq
 	bne	restore
 	/* here we are preempting the current task */
-1:
+	/* ensure we are soft-disabled
+	 * */
+	li	r0,0
+	stb	r0,PACASOFTIRQEN(r13)
+	/* Trace the IRQ state change */
 #ifdef CONFIG_TRACE_IRQFLAGS
-	bl	.trace_hardirqs_on
-	/* Note: we just clobbered r10 which used to contain the previous
-	 * MSR before the hard-disabling done by the caller of do_work.
-	 * We don't have that value anymore, but it doesn't matter as
-	 * we will hard-enable unconditionally, we can just reload the
-	 * current MSR into r10
-	 */
+	bl	.trace_hardirqs_off
+#endif
+1:	/* And make sure we are hard-enabled */
+#ifdef CONFIG_PPC_BOOK3E
+	wrteei	1
+#else
 	mfmsr	r10
-#endif /* CONFIG_TRACE_IRQFLAGS */
+	ori	r10,r10,MSR_EE
+	mtmsrd	r10,1
+#endif
 	li	r0,1
-	stb	r0,PACASOFTIRQEN(r13)
 	stb	r0,PACAHARDIRQEN(r13)
+	/* Call the scheduler with soft IRQs off */
+	bl	.preempt_schedule_irq
+	/* hard-disable interrupts again */
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
+	li	r0,0
+	stb	r0,PACAHARDIRQEN(r13)
+	clrrdi	r9,r1,THREAD_SHIFT
 	ld	r4,TI_FLAGS(r9)
 	andi.	r0,r4,_TIF_NEED_RESCHED
 	bne	1b
-- 
1.6.1.2.14.gf26b5
