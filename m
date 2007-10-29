Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18213.19469.827909.663373@cargo.ozlabs.ibm.com>
Date: Mon, 29 Oct 2007 13:57:17 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [POWERPC] Fix off-by-one error in setting decrementer on Book E
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The decrementer in Book E and 4xx processors interrupts on the
transition from 1 to 0, rather than on the 0 to -1 transition as on
64-bit server and 32-bit "classic" (6xx/7xx/7xxx) processors.

This fixes the problem by making set_dec subtract 1 from the count for
server and classic processors.  Since set_dec already had a bunch of
ifdefs to handle different processor types, there is no net increase
in ugliness. :)

This also removes a redundant call to set the decrementer to
0x7fffffff - it was already set to that earlier in timer_interrupt.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 9eb3284..5e253d6 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -586,7 +586,7 @@ void timer_interrupt(struct pt_regs * regs)
 		/* not time for this event yet */
 		now = per_cpu(decrementer_next_tb, cpu) - now;
 		if (now <= DECREMENTER_MAX)
-			set_dec((unsigned int)now - 1);
+			set_dec((int)now);
 		return;
 	}
 	old_regs = set_irq_regs(regs);
@@ -601,10 +601,8 @@ void timer_interrupt(struct pt_regs * regs)
 
 	if (evt->event_handler)
 		evt->event_handler(evt);
-	else
-		evt->set_next_event(DECREMENTER_MAX, evt);
 
 #ifdef CONFIG_PPC_ISERIES
 	if (firmware_has_feature(FW_FEATURE_ISERIES) && hvlpevent_is_pending())
@@ -826,9 +824,6 @@ static int decrementer_set_next_event(unsigned long evt,
 				      struct clock_event_device *dev)
 {
 	__get_cpu_var(decrementer_next_tb) = get_tb_or_rtc() + evt;
-	/* The decrementer interrupts on the 0 -> -1 transition */
-	if (evt)
-		--evt;
 	set_dec(evt);
 	return 0;
 }
diff --git a/include/asm-powerpc/time.h b/include/asm-powerpc/time.h
index f058955..eed64bd 100644
--- a/include/asm-powerpc/time.h
+++ b/include/asm-powerpc/time.h
@@ -183,6 +183,7 @@ static inline void set_dec(int val)
 #elif defined(CONFIG_8xx_CPU6)
 	set_dec_cpu6(val);
 #else
+	--val;	/* classic decrementer interrupts when dec goes negative */
 #ifdef CONFIG_PPC_ISERIES
 	int cur_dec;
 
