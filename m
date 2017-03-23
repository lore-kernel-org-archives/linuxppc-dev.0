Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vpr1f4rLxzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Mar 2017 02:24:06 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2NFNoYU042349
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Mar 2017 11:24:01 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29c57ed2j4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Mar 2017 11:24:01 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <svaidy@linux.vnet.ibm.com>;
 Fri, 24 Mar 2017 01:23:58 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2NFNmF927721800
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Mar 2017 02:23:56 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2NFNLRf015155
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Mar 2017 02:23:22 +1100
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: [PATCH v2 1/2] powerpc/powernv/cpuidle: Pass correct drv->cpumask for
 registration
Date: Thu, 23 Mar 2017 20:52:46 +0530
In-Reply-To: <20170323152247.14733-1-svaidy@linux.vnet.ibm.com>
References: <20170323152247.14733-1-svaidy@linux.vnet.ibm.com>
Message-Id: <20170323152247.14733-2-svaidy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

drv->cpumask defaults to cpu_possible_mask in __cpuidle_driver_init().
On PowerNV platform cpu_present could be less than cpu_possible in cases
where firmware detects the cpu, but it is not available to the OS.  When
CONFIG_HOTPLUG_CPU=n, such cpus are not hotplugable at runtime and hence
we skip creating cpu_device.

This breaks cpuidle on powernv where register_cpu() is not called for
cpus in cpu_possible_mask that cannot be hot-added at runtime.

Trying cpuidle_register_device() on cpu without cpu_device will cause
crash like this:

cpu 0xf: Vector: 380 (Data SLB Access) at [c000000ff1503490]
    pc: c00000000022c8bc: string+0x34/0x60
    lr: c00000000022ed78: vsnprintf+0x284/0x42c
    sp: c000000ff1503710
   msr: 9000000000009033
   dar: 6000000060000000
  current = 0xc000000ff1480000
  paca    = 0xc00000000fe82d00   softe: 0        irq_happened: 0x01
    pid   = 1, comm = swapper/8
Linux version 4.11.0-rc2 (sv@sagarika) (gcc version 4.9.4
(Buildroot 2017.02-00004-gc28573e) ) #15 SMP Fri Mar 17 19:32:02 IST 2017
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

This patch fixes the bug by passing correct cpumask from
powernv-cpuidle driver.

Signed-off-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
---
 drivers/cpuidle/cpuidle-powernv.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index a06df51..82f7b33 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -175,6 +175,24 @@ static int powernv_cpuidle_driver_init(void)
 		drv->state_count += 1;
 	}
 
+	/*
+	 * On PowerNV platform cpu_present may be less that cpu_possible in
+	 * cases where firmware detects the cpu, but it is not available to the
+	 * OS.  If CONFIG_HOTPLUG_CPU=n then such CPUs are not hotplugable at
+	 * runtime and hence cpu_devices are not created for those cpus by
+	 * generic topology_init().
+	 *
+	 * drv->cpumask defaults to cpu_possible_mask in
+	 * __cpuidle_driver_init().  This breaks cpuidle on powernv where
+	 * cpu_devices are not created for cpus in cpu_possible_mask that
+	 * cannot be hot-added later at runtime.
+	 *
+	 * Trying cpuidle_register_device() on a cpu without cpu_devices is
+	 * incorrect. Hence pass correct cpu mask to generic cpuidle driver.
+	 */
+
+	drv->cpumask = (struct cpumask *)cpu_present_mask;
+
 	return 0;
 }
 
-- 
2.9.3
