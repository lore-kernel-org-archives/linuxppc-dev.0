Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0132.outbound.protection.outlook.com [157.56.111.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D0BC51A0DA4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2015 09:35:14 +1100 (AEDT)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: Replace cpumask_weight(cpu_possible_mask) with
 num_possible_cpus()
Date: Wed, 21 Jan 2015 16:21:14 -0600
Message-ID: <1421878874-30422-1-git-send-email-Emilian.Medve@Freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Emil Medve <Emilian.Medve@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
---
 arch/powerpc/platforms/cell/smp.c            | 2 +-
 arch/powerpc/platforms/pseries/hotplug-cpu.c | 2 +-
 arch/powerpc/sysdev/mpic.c                   | 2 +-
 arch/powerpc/sysdev/xics/xics-common.c       | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/cell/smp.c b/arch/powerpc/platforms/cell/smp.c
index c8017a7..b64e7ea 100644
--- a/arch/powerpc/platforms/cell/smp.c
+++ b/arch/powerpc/platforms/cell/smp.c
@@ -106,7 +106,7 @@ static int __init smp_iic_probe(void)
 {
 	iic_request_IPIs();
 
-	return cpumask_weight(cpu_possible_mask);
+	return num_possible_cpus();
 }
 
 static void smp_cell_setup_cpu(int cpu)
diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index f30cf4d..6247544 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -272,7 +272,7 @@ static int pseries_add_processor(struct device_node *np)
 		 */
 		printk(KERN_ERR "Cannot add cpu %s; this system configuration"
 		       " supports %d logical cpus.\n", np->full_name,
-		       cpumask_weight(cpu_possible_mask));
+		       num_possible_cpus());
 		goto out_unlock;
 	}
 
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index c4648ad..bbfbbf2 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1929,7 +1929,7 @@ int __init smp_mpic_probe(void)
 
 	DBG("smp_mpic_probe()...\n");
 
-	nr_cpus = cpumask_weight(cpu_possible_mask);
+	nr_cpus = num_possible_cpus();
 
 	DBG("nr_cpus: %d\n", nr_cpus);
 
diff --git a/arch/powerpc/sysdev/xics/xics-common.c b/arch/powerpc/sysdev/xics/xics-common.c
index 365249c..125743b 100644
--- a/arch/powerpc/sysdev/xics/xics-common.c
+++ b/arch/powerpc/sysdev/xics/xics-common.c
@@ -148,7 +148,7 @@ int __init xics_smp_probe(void)
 	/* Register all the IPIs */
 	xics_request_ipi();
 
-	return cpumask_weight(cpu_possible_mask);
+	return num_possible_cpus();
 }
 
 #endif /* CONFIG_SMP */
-- 
2.2.2
