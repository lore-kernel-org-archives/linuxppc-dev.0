Return-Path: <jschopp@austin.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E0C32B7CE2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 21 Jan 2010 07:04:13 +1100 (EST)
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e4.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o0KJsKtj025255
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jan 2010 14:54:20 -0500
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o0KK4ArO136446
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jan 2010 15:04:10 -0500
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o0KK49T7005905
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jan 2010 13:04:10 -0700
Subject: [PATCH 2/2] powerpc: implement arch_scale_smt_power for Power7
From: Joel Schopp <jschopp@austin.ibm.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
In-Reply-To: <1264017638.5717.121.camel@jschopp-laptop>
References: <1264017638.5717.121.camel@jschopp-laptop>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 20 Jan 2010 14:04:07 -0600
Message-ID: <1264017847.5717.132.camel@jschopp-laptop>
Mime-Version: 1.0
Cc: Ingo Molnar <mingo@elte.hu>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, ego@in.ibm.com
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
Index: linux-2.6.git/arch/powerpc/kernel/smp.c
===================================================================
--- linux-2.6.git.orig/arch/powerpc/kernel/smp.c
+++ linux-2.6.git/arch/powerpc/kernel/smp.c
@@ -617,3 +617,44 @@ void __cpu_die(unsigned int cpu)
 		smp_ops->cpu_die(cpu);
 }
 #endif
+
+static inline int thread_in_smt4core(int x)
+{
+  return x % 4;
+}
+unsigned long arch_scale_smt_power(struct sched_domain *sd, int cpu)
+{
+  int cpu2;
+  int idle_count = 0;
+
+  struct cpumask *cpu_map = sched_domain_span(sd);
+
+	unsigned long weight = cpumask_weight(cpu_map);
+	unsigned long smt_gain = sd->smt_gain;
+
+	if (cpu_has_feature(CPU_FTRS_POWER7) && weight == 4) {
+		for_each_cpu(cpu2, cpu_map) {
+			if (idle_cpu(cpu2))
+				idle_count++;
+		}
+
+		/* the following section attempts to tweak cpu power based
+		 * on current idleness of the threads dynamically at runtime
+		 */
+		if (idle_count == 2 || idle_count == 3 || idle_count == 4) {
+			if (thread_in_smt4core(cpu) == 0 ||
+			    thread_in_smt4core(cpu) == 1) {
+				/* add 75 % to thread power */
+				smt_gain += (smt_gain >> 1) + (smt_gain >> 2);
+			} else {
+				 /* subtract 75 % to thread power */
+				smt_gain = smt_gain >> 2;
+			}
+		}
+	}
+	/* default smt gain is 1178, weight is # of SMT threads */
+	smt_gain /= weight;
+
+	return smt_gain;
+
+}
Index: linux-2.6.git/kernel/sched_features.h
===================================================================
--- linux-2.6.git.orig/kernel/sched_features.h
+++ linux-2.6.git/kernel/sched_features.h
@@ -107,7 +107,7 @@ SCHED_FEAT(CACHE_HOT_BUDDY, 1)
 /*
  * Use arch dependent cpu power functions
  */
-SCHED_FEAT(ARCH_POWER, 0)
+SCHED_FEAT(ARCH_POWER, 1)
 
 SCHED_FEAT(HRTICK, 0)
 SCHED_FEAT(DOUBLE_TICK, 0)
