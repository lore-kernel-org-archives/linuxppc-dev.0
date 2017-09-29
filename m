Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y3MbG49TXzDrDg
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Sep 2017 16:48:42 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8T6iEoT076888
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Sep 2017 02:48:40 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2d9g4b3b4c-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Sep 2017 02:48:40 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Fri, 29 Sep 2017 16:48:38 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v8T6mYGA49872998
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Sep 2017 16:48:34 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v8T6mPhI005641
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Sep 2017 16:48:25 +1000
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org, paulus@samba.org, svaidy@linux.vnet.ibm.com,
 ego@linux.vnet.ibm.com, akshay.adiga@linux.vnet.ibm.com,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH] powernv: Add OCC driver to mmap sensor area
Date: Fri, 29 Sep 2017 12:17:31 +0530
Message-Id: <1506667651-32301-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This driver provides interface to mmap the OCC sensor area
to userspace to parse and read OCC inband sensors.

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
- The skiboot patch for this is posted here:
https://lists.ozlabs.org/pipermail/skiboot/2017-September/009209.html

 arch/powerpc/platforms/powernv/Makefile   |  2 +-
 arch/powerpc/platforms/powernv/opal-occ.c | 88 +++++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal.c     |  3 ++
 3 files changed, 92 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/platforms/powernv/opal-occ.c

diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index 37d60f7..7911295 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -2,7 +2,7 @@ obj-y			+= setup.o opal-wrappers.o opal.o opal-async.o idle.o
 obj-y			+= opal-rtc.o opal-nvram.o opal-lpc.o opal-flash.o
 obj-y			+= rng.o opal-elog.o opal-dump.o opal-sysparam.o opal-sensor.o
 obj-y			+= opal-msglog.o opal-hmi.o opal-power.o opal-irqchip.o
-obj-y			+= opal-kmsg.o opal-powercap.o opal-psr.o opal-sensor-groups.o
+obj-y			+= opal-kmsg.o opal-powercap.o opal-psr.o opal-sensor-groups.o opal-occ.o
 
 obj-$(CONFIG_SMP)	+= smp.o subcore.o subcore-asm.o
 obj-$(CONFIG_PCI)	+= pci.o pci-ioda.o npu-dma.o
diff --git a/arch/powerpc/platforms/powernv/opal-occ.c b/arch/powerpc/platforms/powernv/opal-occ.c
new file mode 100644
index 0000000..5ca3a41
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/opal-occ.c
@@ -0,0 +1,88 @@
+/*
+ * Copyright IBM Corporation 2017
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#define pr_fmt(fmt) "opal-occ: " fmt
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/miscdevice.h>
+#include <linux/highmem.h>
+#include <asm/opal.h>
+
+static struct miscdevice occ;
+static u64 sensor_base, sensor_size;
+
+static int opal_occ_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	if (vma->vm_flags & VM_WRITE)
+		return -EINVAL;
+
+	return vm_iomap_memory(vma, sensor_base, sensor_size);
+}
+
+static const struct file_operations opal_occ_fops = {
+	.mmap		= opal_occ_mmap,
+	.owner		= THIS_MODULE,
+};
+
+static int opal_occ_probe(struct platform_device *pdev)
+{
+	u64 reg[2];
+	int rc;
+
+	if (!pdev || !pdev->dev.of_node)
+		return -ENODEV;
+
+	if (of_property_read_u64_array(pdev->dev.of_node, "occ-sensors",
+				       &reg[0], 2)) {
+		pr_warn("occ-sensors property not found\n");
+		return -ENODEV;
+	}
+
+	sensor_base = reg[0];
+	sensor_size = reg[1];
+	occ.minor = MISC_DYNAMIC_MINOR;
+	occ.name = "occ";
+	occ.fops = &opal_occ_fops;
+	rc = misc_register(&occ);
+	if (rc)
+		pr_warn("Failed to register OCC device\n");
+
+	return rc;
+}
+
+static int opal_occ_remove(struct platform_device *pdev)
+{
+	misc_deregister(&occ);
+	return 0;
+}
+
+static const struct of_device_id opal_occ_match[] = {
+	{ .compatible = "ibm,opal-occ-inband-sensors" },
+	{ },
+};
+
+static struct platform_driver opal_occ_driver = {
+	.driver = {
+		.name		= "opal_occ",
+		.of_match_table = opal_occ_match,
+	 },
+	.probe	= opal_occ_probe,
+	.remove	= opal_occ_remove,
+};
+
+module_platform_driver(opal_occ_driver);
+
+MODULE_DESCRIPTION("PowerNV OPAL-OCC driver");
+MODULE_LICENSE("GPL");
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 65c79ec..a4f977f 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -889,6 +889,9 @@ static int __init opal_init(void)
 	/* Initialise OPAL sensor groups */
 	opal_sensor_groups_init();
 
+	/* Initialise OCC driver */
+	opal_pdev_init("ibm,opal-occ-inband-sensors");
+
 	return 0;
 }
 machine_subsys_initcall(powernv, opal_init);
-- 
1.8.3.1
