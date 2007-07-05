Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id C91AEDDF5A
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jul 2007 03:03:50 +1000 (EST)
Message-Id: <20070705170241.899406000@lixom.net>
References: <20070705170233.258351000@lixom.net>
Date: Thu, 05 Jul 2007 12:03:04 -0500
From: Olof Johansson <olof@lixom.net>
To: linuxppc-dev@ozlabs.org
Subject: [patch 31/35] Work around errata 4161
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Errata 4161: Concurring ptesyncs on both cores might lock up the
cores. Most ptesyncs are already under tlbie_lock, so use that in the only
other remaining location (the timer interrupt ones we've added ourselves).


Index: 2.6.21/arch/powerpc/kernel/time.c
===================================================================
--- 2.6.21.orig/arch/powerpc/kernel/time.c
+++ 2.6.21/arch/powerpc/kernel/time.c
@@ -618,8 +618,11 @@ void timer_interrupt(struct pt_regs * re
 	int cpu = smp_processor_id();
 	unsigned long ticks;
 	u64 tb_next_jiffy;
+	extern spinlock_t native_tlbie_lock;
 
+	spin_lock(&native_tlbie_lock);
 	asm("ptesync");
+	spin_unlock(&native_tlbie_lock);
 
 #ifdef CONFIG_PPC32
 	if (atomic_read(&ppc_n_lost_interrupts) != 0)
Index: 2.6.21/arch/powerpc/mm/hash_native_64.c
===================================================================
--- 2.6.21.orig/arch/powerpc/mm/hash_native_64.c
+++ 2.6.21/arch/powerpc/mm/hash_native_64.c
@@ -35,7 +35,7 @@
 
 #define HPTE_LOCK_BIT 3
 
-static DEFINE_SPINLOCK(native_tlbie_lock);
+DEFINE_SPINLOCK(native_tlbie_lock);
 
 static inline void __tlbie(unsigned long va, unsigned int psize)
 {

--
