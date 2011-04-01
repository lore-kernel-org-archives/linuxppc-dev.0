Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7B6A0B6F86
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  1 Apr 2011 15:48:32 +1100 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id p314mRa3006736
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Mar 2011 23:48:28 -0500
Subject: [PATCH] powerpc/pseries: Fix build without CONFIG_HOTPLUG_CPU
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 01 Apr 2011 15:48:25 +1100
Message-ID: <1301633305.2549.2.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Matt Evans <matt@ozlabs.au.ibm.com>

Signed-off-by: Matt Evans <matt@ozlabs.au.ibm.com>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/pseries/smp.c |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
index 0317cce..5fe1ad6 100644
--- a/arch/powerpc/platforms/pseries/smp.c
+++ b/arch/powerpc/platforms/pseries/smp.c
@@ -112,10 +112,10 @@ static inline int __devinit smp_startup_cpu(unsigned int lcpu)
 
 	/* Fixup atomic count: it exited inside IRQ handler. */
 	task_thread_info(paca[lcpu].__current)->preempt_count	= 0;
-
+#ifdef CONFIG_HOTPLUG_CPU
 	if (get_cpu_current_state(lcpu) == CPU_STATE_INACTIVE)
 		goto out;
-
+#endif
 	/* 
 	 * If the RTAS start-cpu token does not exist then presume the
 	 * cpu is already spinning.
@@ -130,7 +130,9 @@ static inline int __devinit smp_startup_cpu(unsigned int lcpu)
 		return 0;
 	}
 
+#ifdef CONFIG_HOTPLUG_CPU
 out:
+#endif
 	return 1;
 }
 
@@ -144,16 +146,15 @@ static void __devinit smp_xics_setup_cpu(int cpu)
 		vpa_init(cpu);
 
 	cpumask_clear_cpu(cpu, of_spin_mask);
+#ifdef CONFIG_HOTPLUG_CPU
 	set_cpu_current_state(cpu, CPU_STATE_ONLINE);
 	set_default_offline_state(cpu);
-
+#endif
 }
 #endif /* CONFIG_XICS */
 
 static void __devinit smp_pSeries_kick_cpu(int nr)
 {
-	long rc;
-	unsigned long hcpuid;
 	BUG_ON(nr < 0 || nr >= NR_CPUS);
 
 	if (!smp_startup_cpu(nr))
@@ -165,16 +166,20 @@ static void __devinit smp_pSeries_kick_cpu(int nr)
 	 * the processor will continue on to secondary_start
 	 */
 	paca[nr].cpu_start = 1;
-
+#ifdef CONFIG_HOTPLUG_CPU
 	set_preferred_offline_state(nr, CPU_STATE_ONLINE);
 
 	if (get_cpu_current_state(nr) == CPU_STATE_INACTIVE) {
+		long rc;
+		unsigned long hcpuid;
+
 		hcpuid = get_hard_smp_processor_id(nr);
 		rc = plpar_hcall_norets(H_PROD, hcpuid);
 		if (rc != H_SUCCESS)
 			printk(KERN_ERR "Error: Prod to wake up processor %d "
 						"Ret= %ld\n", nr, rc);
 	}
+#endif
 }
 
 static int smp_pSeries_cpu_bootable(unsigned int nr)
