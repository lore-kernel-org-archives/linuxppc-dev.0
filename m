Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vlsYZ726CzDqY6
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Mar 2017 06:22:58 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2IJJJ7P124449
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Mar 2017 15:22:56 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29912xxvcm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Mar 2017 15:22:55 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <svaidy@linux.vnet.ibm.com>;
 Sun, 19 Mar 2017 05:22:53 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2IJMgBP39649324
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Mar 2017 06:22:50 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2IJMH28018917
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Mar 2017 06:22:17 +1100
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org
Subject: [PATCH] cpuidle: Validate cpu_dev in cpuidle_add_sysfs
Date: Sun, 19 Mar 2017 00:51:59 +0530
Message-Id: <20170318192159.20819-1-svaidy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If a given cpu is not in cpu_present and cpu hotplug
is disabled, arch can skip setting up the cpu_dev.

Arch cpuidle driver should pass correct cpu mask
for registration, but failing to do so by the driver
causes error to propagate and crash like this:

[   30.076045] Unable to handle kernel paging request for data at address 0x00000048
[   30.076100] Faulting instruction address: 0xc0000000007b2f30
cpu 0x4d: Vector: 300 (Data Access) at [c000003feb18b670]
    pc: c0000000007b2f30: kobject_get+0x20/0x70
    lr: c0000000007b3c94: kobject_add_internal+0x54/0x3f0
    sp: c000003feb18b8f0
   msr: 9000000000009033
   dar: 48
 dsisr: 40000000
  current = 0xc000003fd2ed8300
  paca    = 0xc00000000fbab500   softe: 0        irq_happened: 0x01
    pid   = 1, comm = swapper/0
Linux version 4.11.0-rc2-svaidy+ (sv@sagarika) (gcc version 6.2.0
20161005 (Ubuntu 6.2.0-5ubuntu12) ) #10 SMP Sun Mar 19 00:08:09 IST 2017
enter ? for help
[c000003feb18b960] c0000000007b3c94 kobject_add_internal+0x54/0x3f0
[c000003feb18b9f0] c0000000007b43a4 kobject_init_and_add+0x64/0xa0
[c000003feb18ba70] c000000000e284f4 cpuidle_add_sysfs+0xb4/0x130
[c000003feb18baf0] c000000000e26038 cpuidle_register_device+0x118/0x1c0
[c000003feb18bb30] c000000000e26c48 cpuidle_register+0x78/0x120
[c000003feb18bbc0] c00000000168fd9c powernv_processor_idle_init+0x110/0x1c4
[c000003feb18bc40] c00000000000cff8 do_one_initcall+0x68/0x1d0
[c000003feb18bd00] c0000000016242f4 kernel_init_freeable+0x280/0x360
[c000003feb18bdc0] c00000000000d864 kernel_init+0x24/0x160
[c000003feb18be30] c00000000000b4e8 ret_from_kernel_thread+0x5c/0x74

Validating cpu_dev fixes the crash and reports correct error message like:

[   30.163506] Failed to register cpuidle device for cpu136
[   30.173329] Registration of powernv driver failed.

Signed-off-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
---
 drivers/cpuidle/sysfs.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
index c5adc8c..19dcf32 100644
--- a/drivers/cpuidle/sysfs.c
+++ b/drivers/cpuidle/sysfs.c
@@ -615,6 +615,18 @@ int cpuidle_add_sysfs(struct cpuidle_device *dev)
 	struct device *cpu_dev = get_cpu_device((unsigned long)dev->cpu);
 	int error;
 
+	/*
+	 * Return if cpu_device is not setup for this cpu.
+	 * This could happen if arch did not setup cpu_device
+	 * since this cpu is not in cpu_present mask and
+	 * driver did not send correct cpu mask at registration.
+	 * Without this check we would end up passing bogus
+	 * value for &cpu_dev->kobj in kobject_init_and_add()
+	 */
+
+	if (!cpu_dev)
+		return -ENODEV;
+
 	kdev = kzalloc(sizeof(*kdev), GFP_KERNEL);
 	if (!kdev)
 		return -ENOMEM;
-- 
2.9.3
