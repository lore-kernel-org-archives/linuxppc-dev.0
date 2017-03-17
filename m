Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vlCwM244NzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Mar 2017 05:06:59 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2HHwXst018744
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Mar 2017 14:06:51 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0b-001b2d01.pphosted.com with ESMTP id 298me10yce-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Mar 2017 14:06:50 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <svaidy@linux.vnet.ibm.com>;
 Sat, 18 Mar 2017 04:06:48 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2HI6bac43385006
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Mar 2017 05:06:45 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2HI6CSi021130
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Mar 2017 05:06:13 +1100
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/powernv/cpuidle: Pass correct drv->cpumask for
 registration
Date: Fri, 17 Mar 2017 23:35:50 +0530
Message-Id: <20170317180550.9931-1-svaidy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

drv->cpumask defaults to cpu_possible_mask in __cpuidle_driver_init().
This breaks cpuidle on powernv where sysfs files are not created for
cpus in cpu_possible_mask that cannot be hot-added.

Trying cpuidle_register_device() on cpu without sysfs node will
cause crash like:

cpu 0xf: Vector: 380 (Data SLB Access) at [c000000ff1503490]
    pc: c00000000022c8bc: string+0x34/0x60
    lr: c00000000022ed78: vsnprintf+0x284/0x42c
    sp: c000000ff1503710
   msr: 9000000000009033
   dar: 6000000060000000
  current = 0xc000000ff1480000
  paca    = 0xc00000000fe82d00   softe: 0        irq_happened: 0x01
    pid   = 1, comm = swapper/8
Linux version 4.11.0-rc2 (sv@sagarika) (gcc version 4.9.4 (Buildroot 2017.02-00004-gc28573e) ) #15 SMP Fri Mar 17 19:32:02 IST 2017
enter ? for help
[link register   ] c00000000022ed78 vsnprintf+0x284/0x42c
[c000000ff1503710] c00000000022ebb8 vsnprintf+0xc4/0x42c (unreliable)
[c000000ff1503800] c00000000022ef40 vscnprintf+0x20/0x44
[c000000ff1503830] c0000000000ab61c vprintk_emit+0x94/0x2cc
[c000000ff15038a0] c0000000000acc9c vprintk_func+0x60/0x74
[c000000ff15038c0] c000000000619694 printk+0x38/0x4c
[c000000ff15038e0] c000000000224950 kobject_get+0x40/0x60
[c000000ff1503950] c00000000022507c kobject_add_internal+0x60/0x2c4
[c000000ff15039e0] c000000000225350 kobject_init_and_add+0x70/0x78
[c000000ff1503a60] c00000000053c288 cpuidle_add_sysfs+0x9c/0xe0
[c000000ff1503ae0] c00000000053aeac cpuidle_register_device+0xd4/0x12c
[c000000ff1503b30] c00000000053b108 cpuidle_register+0x98/0xcc
[c000000ff1503bc0] c00000000085eaf0 powernv_processor_idle_init+0x140/0x1e0
[c000000ff1503c60] c00000000000cd60 do_one_initcall+0xc0/0x15c
[c000000ff1503d20] c000000000833e84 kernel_init_freeable+0x1a0/0x25c
[c000000ff1503dc0] c00000000000d478 kernel_init+0x24/0x12c
[c000000ff1503e30] c00000000000b564 ret_from_kernel_thread+0x5c/0x78

This patch fixes the issue by passing correct cpumask from
powernv-cpuidle driver.

Signed-off-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
---
 drivers/cpuidle/cpuidle-powernv.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 3705930..e7a8c2a 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -175,6 +175,28 @@ static int powernv_cpuidle_driver_init(void)
 		drv->state_count += 1;
 	}
 
+	/*
+	 * On PowerNV platform cpu_present may be less that cpu_possible
+	 * in cases where firmware detects the cpu, but it is not available
+	 * for OS.  Such CPUs are not hotplugable at runtime on PowerNV
+	 * platform and hence sysfs files are not created for those.
+	 * Generic topology_init() would skip creating sysfs directories
+	 * for cpus that are not present and not hotplugable later at
+	 * runtime.
+	 *
+	 * drv->cpumask defaults to cpu_possible_mask in __cpuidle_driver_init().
+	 * This breaks cpuidle on powernv where sysfs files are not created for
+	 * cpus in cpu_possible_mask that cannot be hot-added.
+	 *
+	 * Hence at runtime sysfs nodes are present for cpus only in
+	 * cpu_present_mask. Trying cpuidle_register_device() on cpu without
+	 * sysfs node is incorrect.
+	 *
+	 * Hence pass correct cpu mask to generic cpuidle driver.
+	 */
+
+	drv->cpumask = (struct cpumask *)cpu_present_mask;
+
 	return 0;
 }
 
-- 
2.9.3
