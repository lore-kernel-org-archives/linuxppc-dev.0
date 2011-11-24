Return-Path: <anton@samba.org>
Message-Id: <20111124060847.105131188@samba.org>
Date: Thu, 24 Nov 2011 17:07:17 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, johnstul@us.ibm.com,
 miltonm@bga.com
Subject: [PATCH 1/6] powerpc/time: Handle wrapping of decrementer
References: <20111124060716.362614789@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When re-enabling interrupts we have code to handle edge sensitive
decrementers by resetting the decrementer to 1 whenever it is negative.
If interrupts were disabled long enough that the decrementer wrapped to
positive we do nothing. This means interrupts can be delayed for a long
time until it finally goes negative again.

While we hope interrupts are never be disabled long enough for the
decrementer to go positive, we have a very good test team that can
drive any kernel into the ground. The softlockup data we get back
from these fails could be seconds in the future, completely missing
the cause of the lockup.

We already keep track of the timebase of the next event so use that
to work out if we should trigger a decrementer exception.

Signed-off-by: Anton Blanchard <anton@samba.org>
Cc: stable@kernel.org
---

- I'd like to get this into -stable if possible since the reports are
  coming in on 3.0 and 3.1. It needs some solid review though.

- This has the unfortunate side effect of forcing arch_local_irq_restore
  to create a stack frame, but I will try to optimise that in a subsequent
  patch.

Index: linux-build/arch/powerpc/include/asm/time.h
===================================================================
--- linux-build.orig/arch/powerpc/include/asm/time.h	2011-11-17 10:04:16.543137415 +1100
+++ linux-build/arch/powerpc/include/asm/time.h	2011-11-17 13:19:47.831758211 +1100
@@ -219,5 +219,7 @@ DECLARE_PER_CPU(struct cpu_usage, cpu_us
 extern void secondary_cpu_time_init(void);
 extern void iSeries_time_init_early(void);
 
+extern void decrementer_check_overflow(void);
+
 #endif /* __KERNEL__ */
 #endif /* __POWERPC_TIME_H */
Index: linux-build/arch/powerpc/kernel/irq.c
===================================================================
--- linux-build.orig/arch/powerpc/kernel/irq.c	2011-11-17 10:04:16.551137554 +1100
+++ linux-build/arch/powerpc/kernel/irq.c	2011-11-17 14:23:10.834514143 +1100
@@ -164,16 +164,13 @@ notrace void arch_local_irq_restore(unsi
 	 */
 	local_paca->hard_enabled = en;
 
-#ifndef CONFIG_BOOKE
-	/* On server, re-trigger the decrementer if it went negative since
-	 * some processors only trigger on edge transitions of the sign bit.
-	 *
-	 * BookE has a level sensitive decrementer (latches in TSR) so we
-	 * don't need that
+	/*
+	 * Trigger the decrementer if we have a pending event. Some processors
+	 * only trigger on edge transitions of the sign bit. We might also
+	 * have disabled interrupts long enough that the decrementer wrapped
+	 * to positive.
 	 */
-	if ((int)mfspr(SPRN_DEC) < 0)
-		mtspr(SPRN_DEC, 1);
-#endif /* CONFIG_BOOKE */
+	decrementer_check_overflow();
 
 	/*
 	 * Force the delivery of pending soft-disabled interrupts on PS3.
Index: linux-build/arch/powerpc/kernel/time.c
===================================================================
--- linux-build.orig/arch/powerpc/kernel/time.c	2011-11-17 10:04:16.559137691 +1100
+++ linux-build/arch/powerpc/kernel/time.c	2011-11-17 13:19:49.415785997 +1100
@@ -889,6 +889,15 @@ static void __init clocksource_init(void
 	       clock->name, clock->mult, clock->shift);
 }
 
+void decrementer_check_overflow(void)
+{
+	u64 now = get_tb_or_rtc();
+	struct decrementer_clock *decrementer = &__get_cpu_var(decrementers);
+
+	if (now >= decrementer->next_tb)
+		set_dec(1);
+}
+
 static int decrementer_set_next_event(unsigned long evt,
 				      struct clock_event_device *dev)
 {
