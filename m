Return-Path: <jschopp@austin.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 65FCDB7D09
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 29 Jan 2010 10:21:03 +1100 (EST)
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e3.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o0SNAgmY022180
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2010 18:10:42 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o0SNL06r141564
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2010 18:21:00 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o0SNKwHv004445
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2010 21:20:59 -0200
Subject: [PATCHv3 2/2] powerpc: implement arch_scale_smt_power for Power7
From: Joel Schopp <jschopp@austin.ibm.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
In-Reply-To: <1264548495.12239.56.camel@jschopp-laptop>
References: <1264017638.5717.121.camel@jschopp-laptop>
	<1264017847.5717.132.camel@jschopp-laptop>
	<1264548495.12239.56.camel@jschopp-laptop>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 28 Jan 2010 17:20:55 -0600
Message-ID: <1264720855.9660.22.camel@jschopp-laptop>
Mime-Version: 1.0
Cc: ego@in.ibm.com, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Power7 processors running in SMT4 mode with 2, 3, or 4 idle threads 
there is performance benefit to idling the higher numbered threads in
the core.  

This patch implements arch_scale_smt_power to dynamically update smt
thread power in these idle cases in order to prefer threads 0,1 over
threads 2,3 within a core.


Signed-off-by: Joel Schopp <jschopp@austin.ibm.com>
---
Version 2 addresses style and optimization, same basic functionality
Version 3 adds a comment
On Power7 processors running in SMT4 mode with 2, 3, or 4 idle threads 
there is performance benefit to idling the higher numbered threads in
the core.  

This patch implements arch_scale_smt_power to dynamically update smt
thread power in these idle cases in order to prefer threads 0,1 over
threads 2,3 within a core.

Signed-off-by: Joel Schopp <jschopp@austin.ibm.com>
---
Version 2 addresses style and optimization, same basic functionality
Index: linux-2.6.git/arch/powerpc/kernel/smp.c
===================================================================
--- linux-2.6.git.orig/arch/powerpc/kernel/smp.c
+++ linux-2.6.git/arch/powerpc/kernel/smp.c
@@ -620,3 +620,59 @@ void __cpu_die(unsigned int cpu)
 		smp_ops->cpu_die(cpu);
 }
 #endif
+
+unsigned long arch_scale_smt_power(struct sched_domain *sd, int cpu)
+{
+	int sibling;
+	int idle_count = 0;
+	int thread;
+
+	/* Setup the default weight and smt_gain used by most cpus for SMT
+	 * Power.  Doing this right away covers the default case and can be
+	 * used by cpus that modify it dynamically.
+	 */
+	struct cpumask *sibling_map = sched_domain_span(sd);
+	unsigned long weight = cpumask_weight(sibling_map);
+	unsigned long smt_gain = sd->smt_gain;
+
+
+	if (cpu_has_feature(CPU_FTR_ASYNC_SMT4) && weight == 4) {
+		for_each_cpu(sibling, sibling_map) {
+			if (idle_cpu(sibling))
+				idle_count++;
+		}
+
+		/* the following section attempts to tweak cpu power based
+		 * on current idleness of the threads dynamically at runtime
+		 */
+		if (idle_count > 1) {
+			thread = cpu_thread_in_core(cpu);
+			if (thread < 2) {
+				/* add 75 % to thread power */
+				smt_gain += (smt_gain >> 1) + (smt_gain >> 2);
+			} else {
+				 /* subtract 75 % to thread power */
+				smt_gain = smt_gain >> 2;
+			}
+		}
+	}
+
+	/* default smt gain is 1178, weight is # of SMT threads */
+	switch (weight) {
+	case 1:
+		/*divide by 1, do nothing*/
+		break;
+	case 2:
+		smt_gain = smt_gain >> 1;
+		break;
+	case 4:
+		smt_gain = smt_gain >> 2;
+		break;
+	default:
+		smt_gain /= weight;
+		break;
+	}
+
+	return smt_gain;
+
+}
Index: linux-2.6.git/arch/powerpc/include/asm/cputable.h
===================================================================
--- linux-2.6.git.orig/arch/powerpc/include/asm/cputable.h
+++ linux-2.6.git/arch/powerpc/include/asm/cputable.h
@@ -195,6 +195,7 @@ extern const char *powerpc_base_platform
 #define CPU_FTR_SAO			LONG_ASM_CONST(0x0020000000000000)
 #define CPU_FTR_CP_USE_DCBTZ		LONG_ASM_CONST(0x0040000000000000)
 #define CPU_FTR_UNALIGNED_LD_STD	LONG_ASM_CONST(0x0080000000000000)
+#define CPU_FTR_ASYNC_SMT4		LONG_ASM_CONST(0x0100000000000000)
 
 #ifndef __ASSEMBLY__
 
@@ -409,7 +410,7 @@ extern const char *powerpc_base_platform
 	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
 	    CPU_FTR_COHERENT_ICACHE | CPU_FTR_LOCKLESS_TLBIE | \
 	    CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE | \
-	    CPU_FTR_DSCR | CPU_FTR_SAO)
+	    CPU_FTR_DSCR | CPU_FTR_SAO | CPU_FTR_ASYNC_SMT4)
 #define CPU_FTRS_CELL	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
