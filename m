Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id A02F7DDD0B
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Nov 2008 21:20:58 +1100 (EST)
Date: Sun, 16 Nov 2008 15:43:45 -0600
From: Milton Miller <miltonm@bga.com>
To: paulus@samba.org,
Subject: [PATCH] ppc32: remove secondary_ti
Message-Id: <31226871825643c98694.1714636915.miltonm@bga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Instead of copying current_set[cpu] to secondary_ti, directly index into
current_set by the cpu number like head_64.S.  In addition to removing
the variable, a slow to respond cpu will not clobber another cpus
stack.

---
grep found no other reference in arch/powerpc.   compile tested but I have
no 32bit smp hardware.

Index: next.git/arch/powerpc/kernel/head_32.S
===================================================================
--- next.git.orig/arch/powerpc/kernel/head_32.S	2008-11-16 01:36:45.000000000 -0600
+++ next.git/arch/powerpc/kernel/head_32.S	2008-11-16 01:42:02.000000000 -0600
@@ -906,10 +906,11 @@ __secondary_start:
 	bl	init_idle_6xx
 #endif /* CONFIG_6xx */
 
-	/* get current_thread_info and current */
-	lis	r1,secondary_ti@ha
+	/* get current_thread_info (current_set[cpu]) and current =  */
+	slwi	r1,r24,2
+	addis	r1,r1,current_set@ha
 	tophys(r1,r1)
-	lwz	r1,secondary_ti@l(r1)
+	lwz	r1,current_set@l(r1)
 	tophys(r2,r1)
 	lwz	r2,TI_TASK(r2)
 
Index: next.git/arch/powerpc/kernel/smp.c
===================================================================
--- next.git.orig/arch/powerpc/kernel/smp.c	2008-11-16 01:36:05.000000000 -0600
+++ next.git/arch/powerpc/kernel/smp.c	2008-11-16 01:36:22.000000000 -0600
@@ -58,7 +58,6 @@
 #endif
 
 int smp_hw_index[NR_CPUS];
-struct thread_info *secondary_ti;
 
 cpumask_t cpu_possible_map = CPU_MASK_NONE;
 cpumask_t cpu_online_map = CPU_MASK_NONE;
@@ -320,7 +319,6 @@ int __cpuinit __cpu_up(unsigned int cpu)
 {
 	int c;
 
-	secondary_ti = current_set[cpu];
 	if (!cpu_enable(cpu))
 		return 0;
 
