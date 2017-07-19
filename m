Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xCQpZ3hyczDrCn
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 04:41:10 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6JIeJ1e031128
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 14:41:08 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2btcgkrynw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 14:41:08 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Thu, 20 Jul 2017 04:41:06 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6JIetLw27984042
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 04:41:03 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6JIeUrc004785
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 04:40:31 +1000
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: stewart@linux.vnet.ibm.com, cyrilbur@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 ego@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH V7 3/3] powernv : Add support to clear sensor groups data
Date: Thu, 20 Jul 2017 00:09:56 +0530
In-Reply-To: <1500489596-23255-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1500489596-23255-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Message-Id: <1500489596-23255-4-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Adds support for clearing different sensor groups. OCC inband sensor
groups like CSM, Profiler, Job Scheduler can be cleared using this
driver. The min/max of all sensors belonging to these sensor groups
will be cleared.

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
Changes from V6:
- Removed a generic read/write interface for all commands. Commands to
  set powercap and power-shifting-ratio has been implemented as
  generic framework and this driver supports non-generic platform
  commands.

 arch/powerpc/include/asm/opal-api.h            |   3 +-
 arch/powerpc/include/asm/opal.h                |   1 +
 arch/powerpc/include/uapi/asm/opal-occ.h       |  23 ++++++
 arch/powerpc/platforms/powernv/Makefile        |   2 +-
 arch/powerpc/platforms/powernv/opal-occ.c      | 108 +++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-wrappers.S |   1 +
 arch/powerpc/platforms/powernv/opal.c          |   3 +
 7 files changed, 139 insertions(+), 2 deletions(-)
 create mode 100644 arch/powerpc/include/uapi/asm/opal-occ.h
 create mode 100644 arch/powerpc/platforms/powernv/opal-occ.c

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 0d37315..e849bd2 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -195,7 +195,8 @@
 #define OPAL_SET_POWERCAP			153
 #define OPAL_GET_PSR				154
 #define OPAL_SET_PSR				155
-#define OPAL_LAST				155
+#define OPAL_CLEAR_SENSOR_GROUPS		156
+#define OPAL_LAST				156
 
 /* Device tree flags */
 
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 58b30a4..ccf42ae 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -271,6 +271,7 @@ int64_t opal_xive_set_vp_info(uint64_t vp,
 int opal_set_powercap(u32 handle, int token, u32 pcap);
 int opal_get_power_shifting_ratio(u32 handle, int token, u32 *psr);
 int opal_set_power_shifting_ratio(u32 handle, int token, u32 psr);
+int opal_clear_sensor_groups(u32 group_hndl, int token);
 
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
diff --git a/arch/powerpc/include/uapi/asm/opal-occ.h b/arch/powerpc/include/uapi/asm/opal-occ.h
new file mode 100644
index 0000000..97c45e2
--- /dev/null
+++ b/arch/powerpc/include/uapi/asm/opal-occ.h
@@ -0,0 +1,23 @@
+/*
+ * OPAL OCC command interface
+ * Supported on POWERNV platform
+ *
+ * (C) Copyright IBM 2017
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _UAPI_ASM_POWERPC_OPAL_OCC_H_
+#define _UAPI_ASM_POWERPC_OPAL_OCC_H_
+
+#define OPAL_OCC_IOCTL_CLEAR_SENSOR_GROUPS	_IOR('o', 1, u32)
+
+#endif /* _UAPI_ASM_POWERPC_OPAL_OCC_H */
diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index 9ed7d33..f193b33 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -2,7 +2,7 @@ obj-y			+= setup.o opal-wrappers.o opal.o opal-async.o idle.o
 obj-y			+= opal-rtc.o opal-nvram.o opal-lpc.o opal-flash.o
 obj-y			+= rng.o opal-elog.o opal-dump.o opal-sysparam.o opal-sensor.o
 obj-y			+= opal-msglog.o opal-hmi.o opal-power.o opal-irqchip.o
-obj-y			+= opal-kmsg.o opal-powercap.o opal-psr.o
+obj-y			+= opal-kmsg.o opal-powercap.o opal-psr.o opal-occ.o
 
 obj-$(CONFIG_SMP)	+= smp.o subcore.o subcore-asm.o
 obj-$(CONFIG_PCI)	+= pci.o pci-ioda.o npu-dma.o
diff --git a/arch/powerpc/platforms/powernv/opal-occ.c b/arch/powerpc/platforms/powernv/opal-occ.c
new file mode 100644
index 0000000..76b8526
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/opal-occ.c
@@ -0,0 +1,108 @@
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
+#include <linux/fs.h>
+#include <asm/opal.h>
+#include <asm/opal-occ.h>
+
+DEFINE_MUTEX(opal_occ_mutex);
+
+static int send_occ_command(u32 handle)
+{
+	struct opal_msg async_msg;
+	int token, rc;
+
+	token = opal_async_get_token_interruptible();
+	if (token < 0) {
+		pr_devel("Failed to get the token %d\n", token);
+		return token;
+	}
+
+	mutex_lock(&opal_occ_mutex);
+	rc = opal_clear_sensor_groups(handle, token);
+	if (rc == OPAL_ASYNC_COMPLETION) {
+		rc = opal_async_wait_response(token, &async_msg);
+		if (rc) {
+			pr_devel("Failed to wait for async response %d\n", rc);
+			goto out;
+		}
+		rc = opal_get_async_rc(async_msg);
+	}
+out:
+	mutex_unlock(&opal_occ_mutex);
+	opal_async_release_token(token);
+	return opal_error_code(rc);
+}
+
+static long opal_occ_ioctl(struct file *file, unsigned int cmd,
+			   unsigned long param)
+{
+	int rc = -EINVAL;
+
+	switch (cmd) {
+	case OPAL_OCC_IOCTL_CLEAR_SENSOR_GROUPS:
+		rc = send_occ_command(param);
+		break;
+	default:
+		break;
+	}
+
+	return rc;
+}
+
+static const struct file_operations opal_occ_fops = {
+	.unlocked_ioctl = opal_occ_ioctl,
+	.owner		= THIS_MODULE,
+};
+
+static struct miscdevice occ_dev = {
+	.minor	= MISC_DYNAMIC_MINOR,
+	.name	= "occ",
+	.fops	= &opal_occ_fops,
+};
+
+static int opal_occ_probe(struct platform_device *pdev)
+{
+	return misc_register(&occ_dev);
+}
+
+static int opal_occ_remove(struct platform_device *pdev)
+{
+	misc_deregister(&occ_dev);
+	return 0;
+}
+
+static const struct of_device_id opal_occ_match[] = {
+	{ .compatible = "ibm,opal-occ-sensor-group" },
+	{ },
+};
+
+static struct platform_driver opal_occ_driver = {
+	.driver = {
+		.name           = "opal-occ",
+		.of_match_table = opal_occ_match,
+	},
+	.probe	= opal_occ_probe,
+	.remove	= opal_occ_remove,
+};
+
+module_platform_driver(opal_occ_driver);
+
+MODULE_DESCRIPTION("PowerNV OPAL-OCC driver");
+MODULE_LICENSE("GPL");
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 9867726..aae48ed 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -314,3 +314,4 @@ OPAL_CALL(opal_get_powercap,			OPAL_GET_POWERCAP);
 OPAL_CALL(opal_set_powercap,			OPAL_SET_POWERCAP);
 OPAL_CALL(opal_get_power_shifting_ratio,	OPAL_GET_PSR);
 OPAL_CALL(opal_set_power_shifting_ratio,	OPAL_SET_PSR);
+OPAL_CALL(opal_clear_sensor_groups,		OPAL_CLEAR_SENSOR_GROUPS);
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index f34033f..9fc4a47 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -842,6 +842,9 @@ static int __init opal_init(void)
 	/* Initialise OPAL Power-Shifting-Ratio interface */
 	opal_psr_init();
 
+	/* Initialize platform device: OCC interface */
+	opal_pdev_init("ibm,opal-occ-sensor-group");
+
 	return 0;
 }
 machine_subsys_initcall(powernv, opal_init);
-- 
1.8.3.1
