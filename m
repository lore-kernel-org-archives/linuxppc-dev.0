Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xk7416VP0zDqY3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Sep 2017 15:25:21 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id m15so1094598pgc.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 22:25:21 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Srivatsa S . Bhat" <srivatsa.bhat@linux.vnet.ibm.com>,
 Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: [RFC PATCH] powerpc: tick broadcast handler should call
 tick_receive_broadcast
Date: Fri,  1 Sep 2017 15:25:07 +1000
Message-Id: <20170901052507.31808-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Recently looking through the broadcast timers code, and I wonder if
we should be calling tick_receive_broadcast() here? Our __timer_interrupt()
works on the decrementer clockevent device, but we should be working on
the broadcast device I think? We must get away with it somehow, but I
see most other archs doing this and it seems to work, so I wonder if we
should take broadcasts this way?

---
 arch/powerpc/include/asm/time.h | 1 -
 arch/powerpc/kernel/smp.c       | 4 ++--
 arch/powerpc/kernel/time.c      | 9 ---------
 3 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/time.h b/arch/powerpc/include/asm/time.h
index b240666b7bc1..13b5d768c761 100644
--- a/arch/powerpc/include/asm/time.h
+++ b/arch/powerpc/include/asm/time.h
@@ -28,7 +28,6 @@ extern struct clock_event_device decrementer_clockevent;
 
 struct rtc_time;
 extern void to_tm(int tim, struct rtc_time * tm);
-extern void tick_broadcast_ipi_handler(void);
 
 extern void generic_calibrate_decr(void);
 
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 8d3320562c70..101e4476e1d6 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -155,7 +155,7 @@ static irqreturn_t reschedule_action(int irq, void *data)
 
 static irqreturn_t tick_broadcast_ipi_action(int irq, void *data)
 {
-	tick_broadcast_ipi_handler();
+	tick_receive_broadcast();
 	return IRQ_HANDLED;
 }
 
@@ -276,7 +276,7 @@ irqreturn_t smp_ipi_demux_relaxed(void)
 		if (all & IPI_MESSAGE(PPC_MSG_RESCHEDULE))
 			scheduler_ipi();
 		if (all & IPI_MESSAGE(PPC_MSG_TICK_BROADCAST))
-			tick_broadcast_ipi_handler();
+			tick_receive_broadcast();
 #ifdef CONFIG_NMI_IPI
 		if (all & IPI_MESSAGE(PPC_MSG_NMI_IPI))
 			nmi_ipi_action(0, NULL);
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index fe6f3a285455..6f291a99ce04 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -968,15 +968,6 @@ static int decrementer_shutdown(struct clock_event_device *dev)
 	return 0;
 }
 
-/* Interrupt handler for the timer broadcast IPI */
-void tick_broadcast_ipi_handler(void)
-{
-	u64 *next_tb = this_cpu_ptr(&decrementers_next_tb);
-
-	*next_tb = get_tb_or_rtc();
-	__timer_interrupt();
-}
-
 static void register_decrementer_clockevent(int cpu)
 {
 	struct clock_event_device *dec = &per_cpu(decrementers, cpu);
-- 
2.13.3
