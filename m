Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id C964DDDF5C
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jul 2007 03:03:50 +1000 (EST)
Message-Id: <20070705170239.982028000@lixom.net>
References: <20070705170233.258351000@lixom.net>
Date: Thu, 05 Jul 2007 12:02:57 -0500
From: Olof Johansson <olof@lixom.net>
To: linuxppc-dev@ozlabs.org
Subject: [patch 24/35] Work around errata 4628
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Errata 4628 causes lockups during table walks that are recovered from
when a ptesync is received. So, issue a ptesync every timer interrupt,
and for CPUs that have not yet spun up, at regular intervals. This seems
sufficient to avoid hitting it.

Index: 2.6.21/arch/powerpc/kernel/head_64.S
===================================================================
--- 2.6.21.orig/arch/powerpc/kernel/head_64.S
+++ 2.6.21/arch/powerpc/kernel/head_64.S
@@ -123,10 +123,22 @@ _GLOBAL(__secondary_hold)
 	std	r24,__secondary_hold_acknowledge@l(0)
 	sync
 
+#ifdef CONFIG_SMP
 	/* All secondary cpus wait here until told to start. */
 100:	ld	r4,__secondary_hold_spinloop@l(0)
 	cmpdi	0,r4,1
 	bne	100b
+#else
+	lis	r3, 0x40
+	mtctr	r3
+100:	bdnz	.
+	ptesync
+	ptesync
+	lis	r3, 0x40
+	mtctr	r3
+	b	100b
+	
+#endif
 
 #if defined(CONFIG_SMP) || defined(CONFIG_KEXEC)
 	LOAD_REG_IMMEDIATE(r4, .generic_secondary_smp_init)
@@ -1582,16 +1594,32 @@ _GLOBAL(generic_secondary_smp_init)
 2:	mtspr	SPRN_SPRG3,r13		/* Save vaddr of paca in SPRG3	 */
 	/* From now on, r24 is expected to be logical cpuid */
 	mr	r24,r5
+
+	lis	r23, 0x40
+	mtctr	r23
+
 3:	HMT_LOW
 	lbz	r23,PACAPROCSTART(r13)	/* Test if this processor should */
-					/* start.			 */
-	sync
 
 #ifndef CONFIG_SMP
 	b	3b			/* Never go on non-SMP		 */
 #else
 	cmpwi	0,r23,0
-	beq	3b			/* Loop until told to go	 */
+	bne	5f			/* Loop until told to go	 */
+					/* start.			 */
+	isync
+
+4:	bdnz	3b
+	ptesync
+	isync
+	sync
+	ptesync
+	lis	r23, 0x40
+	mtctr	r23
+	b	3b
+
+5:
+
 
 	/* See if we need to call a cpu state restore handler */
 	LOAD_REG_IMMEDIATE(r23, cur_cpu_spec)
Index: 2.6.21/arch/powerpc/kernel/time.c
===================================================================
--- 2.6.21.orig/arch/powerpc/kernel/time.c
+++ 2.6.21/arch/powerpc/kernel/time.c
@@ -619,6 +619,8 @@ void timer_interrupt(struct pt_regs * re
 	unsigned long ticks;
 	u64 tb_next_jiffy;
 
+	asm("ptesync");
+
 #ifdef CONFIG_PPC32
 	if (atomic_read(&ppc_n_lost_interrupts) != 0)
 		do_IRQ(regs);

--
