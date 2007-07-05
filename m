Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 30C0BDDF4A
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jul 2007 03:03:50 +1000 (EST)
Message-Id: <20070705170241.086477000@lixom.net>
References: <20070705170233.258351000@lixom.net>
Date: Thu, 05 Jul 2007 12:03:01 -0500
From: Olof Johansson <olof@lixom.net>
To: linuxppc-dev@ozlabs.org
Subject: [patch 28/35] Work around errata 4712
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Workaround for errata 4712; on an SMP system the PIC can get stuck
trying to read the next available interrupt from INTACK in case there's
only a spurious available. The workaround is to program timers to cause
interrupts every now and then, which recovers from the lockup.


Index: mainline/arch/powerpc/sysdev/mpic.c
===================================================================
--- mainline.orig/arch/powerpc/sysdev/mpic.c
+++ mainline/arch/powerpc/sysdev/mpic.c
@@ -1602,3 +1602,37 @@ static int mpic_init_sys(void)
 }
 
 device_initcall(mpic_init_sys);
+
+
+static irqreturn_t intr_4712(int irq, void *data)
+{
+	return IRQ_HANDLED;
+}
+
+static int do_4712_workaround(void)
+{
+	struct mpic *mpic = mpic_primary;
+	int irq, ret;
+
+	/* HACK: setup timers 4 and 5: 2Hz for now, hold off for 1 sec */
+	/* Steal vectors 250 and 251, nothing uses them */
+
+	irq = irq_create_mapping(NULL, 250);
+	ret = request_irq(irq, &intr_4712, IRQF_DISABLED, "4712 workaround cpu0", NULL);
+	irq = irq_create_mapping(NULL, 251);
+	ret = request_irq(irq, &intr_4712, IRQF_DISABLED, "4712 workaround cpu1", NULL);
+
+	mpic_write(mpic->tmregs, 0 * MPIC_INFO(TIMER_STRIDE) + MPIC_INFO(TIMER_DESTINATION), 1);
+	mpic_write(mpic->tmregs, 0 * MPIC_INFO(TIMER_STRIDE) + MPIC_INFO(TIMER_VECTOR_PRI), (10 << MPIC_VECPRI_PRIORITY_SHIFT) | 250);
+	mpic_write(mpic->tmregs, 0 * MPIC_INFO(TIMER_STRIDE) + MPIC_INFO(TIMER_BASE_CNT), 8333333/4);
+	mpic_write(mpic->tmregs, 0 * MPIC_INFO(TIMER_STRIDE) + MPIC_INFO(TIMER_CURRENT_CNT), 8333333);
+
+	mpic_write(mpic->tmregs, 3 * MPIC_INFO(TIMER_STRIDE) + MPIC_INFO(TIMER_DESTINATION), 2);
+	mpic_write(mpic->tmregs, 3 * MPIC_INFO(TIMER_STRIDE) + MPIC_INFO(TIMER_VECTOR_PRI), (10 << MPIC_VECPRI_PRIORITY_SHIFT) | 251);
+	mpic_write(mpic->tmregs, 3 * MPIC_INFO(TIMER_STRIDE) + MPIC_INFO(TIMER_BASE_CNT), 8333333/4);
+	mpic_write(mpic->tmregs, 3 * MPIC_INFO(TIMER_STRIDE) + MPIC_INFO(TIMER_CURRENT_CNT), 8333333);
+
+	return 0;
+}
+late_initcall(do_4712_workaround);
+

--
