Return-Path: <yinbo.zhu@nxp.com>
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam01on0136.outbound.protection.outlook.com [104.47.32.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40hwkg0pm7zF2Cp
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 13:36:50 +1000 (AEST)
From: Yinbo Zhu <yinbo.zhu@nxp.com>
To: <yinbo.zhu@nxp.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, "Catalin Marinas )" <catalin.marinas@arm.com>, "Will
 Deacon )" <will.deacon@arm.com>, "Lorenzo Pieralisi )"
 <lorenzo.pieralisi@arm.com>, Li Yang <leoyang.li@nxp.com>
CC: <xiaobo.xie@nxp.com>, <ran.wang_1@nxp.com>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Shawn Guo
 <shawnguo@kernel.org>, Madalin Bucur <madalin.bucur@nxp.com>, Hou Zhiqiang
 <Zhiqiang.Hou@nxp.com>, Changming Huang <jerry.huang@nxp.com>, Minghuan Lian
 <Minghuan.Lian@nxp.com>, Zhao Qiang <qiang.zhao@nxp.com>, Fabio Estevam
 <fabio.estevam@nxp.com>, "jiaheng . fan" <jiaheng.fan@nxp.com>, Po Liu
 <po.liu@nxp.com>, Nipun Gupta <nipun.gupta@nxp.com>,
 =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>, Priyanka Jain
 <priyanka.jain@nxp.com>, Sumit Garg <sumit.garg@nxp.com>, costi
 <constantin.tudor@freescale.com>, Bogdan Purcareata
 <bogdan.purcareata@nxp.com>, Meng Yi <meng.yi@nxp.com>, Wang Dongsheng
 <dongsheng.wang@nxp.com>, "open list:CLOCKSOURCE, CLOCKEVENT DRIVERS"
 <linux-kernel@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE
 TREE BINDINGS" <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, "open list:FREESCALE SOC DRIVERS"
 <linuxppc-dev@lists.ozlabs.org>, Tang Yuantian <Yuantian.Tang@nxp.com>,
 <ying.zhang22455@nxp.com>, Yuantian Tang <andy.tang@nxp.com>
Subject: [PATCH 1/9] armv8: pm: add rcpm module support
Date: Fri, 11 May 2018 11:35:22 +0800
Message-ID: <20180511033530.7931-1-yinbo.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Yuantian Tang <andy.tang@nxp.com>

The Run Control and Power Management (RCPM) module communicates
with embedded cores, coherency modules, and other device platform
module to provide run control and power management functionality

Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
---
 drivers/soc/fsl/Makefile |    1 +
 drivers/soc/fsl/rcpm.c   |  153 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 154 insertions(+), 0 deletions(-)
 create mode 100644 drivers/soc/fsl/rcpm.c

diff --git a/drivers/soc/fsl/Makefile b/drivers/soc/fsl/Makefile
index 629dab8..68fcd71 100644
--- a/drivers/soc/fsl/Makefile
+++ b/drivers/soc/fsl/Makefile
@@ -5,6 +5,7 @@
 obj-$(CONFIG_FSL_DPAA)                 += qbman/
 obj-$(CONFIG_QUICC_ENGINE)		+= qe/
 obj-$(CONFIG_CPM)			+= qe/
+obj-$(CONFIG_SUSPEND)            	+= rcpm.o
 obj-$(CONFIG_FSL_GUTS)			+= guts.o
 obj-$(CONFIG_FSL_LS2_CONSOLE)		+= ls2-console/
 obj-$(CONFIG_LS_SOC_DRIVERS)		+= layerscape/
diff --git a/drivers/soc/fsl/rcpm.c b/drivers/soc/fsl/rcpm.c
new file mode 100644
index 0000000..ff0477b
--- /dev/null
+++ b/drivers/soc/fsl/rcpm.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2016 NXP
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+#define pr_fmt(fmt) "RCPM: %s: " fmt, __func__
+
+#include <linux/kernel.h>
+#include <linux/io.h>
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
+#include <linux/suspend.h>
+
+/* RCPM register offset */
+#define RCPM_IPPDEXPCR0			0x140
+
+#define RCPM_WAKEUP_CELL_SIZE	2
+
+struct rcpm_config {
+	int ipp_num;
+	int ippdexpcr_offset;
+	u32 ippdexpcr[2];
+	void *rcpm_reg_base;
+};
+
+static struct rcpm_config *rcpm;
+
+static inline void rcpm_reg_write(u32 offset, u32 value)
+{
+	iowrite32be(value, rcpm->rcpm_reg_base + offset);
+}
+
+static inline u32 rcpm_reg_read(u32 offset)
+{
+	return ioread32be(rcpm->rcpm_reg_base + offset);
+}
+
+static void rcpm_wakeup_fixup(struct device *dev, void *data)
+{
+	struct device_node *node = dev ? dev->of_node : NULL;
+	u32 value[RCPM_WAKEUP_CELL_SIZE];
+	int ret, i;
+
+	if (!dev || !node || !device_may_wakeup(dev))
+		return;
+
+	/*
+	 * Get the values in the "rcpm-wakeup" property.
+	 * Three values are:
+	 * The first is a pointer to the RCPM node.
+	 * The second is the value of the ippdexpcr0 register.
+	 * The third is the value of the ippdexpcr1 register.
+	 */
+	ret = of_property_read_u32_array(node, "fsl,rcpm-wakeup",
+					 value, RCPM_WAKEUP_CELL_SIZE);
+	if (ret)
+		return;
+
+	pr_debug("wakeup source: the device %s\n", node->full_name);
+
+	for (i = 0; i < rcpm->ipp_num; i++)
+		rcpm->ippdexpcr[i] |= value[i + 1];
+}
+
+static int rcpm_suspend_prepare(void)
+{
+	int i;
+
+	WARN_ON(!rcpm);
+
+	for (i = 0; i < rcpm->ipp_num; i++)
+		rcpm->ippdexpcr[i] = 0;
+
+	dpm_for_each_dev(NULL, rcpm_wakeup_fixup);
+
+	for (i = 0; i < rcpm->ipp_num; i++) {
+		rcpm_reg_write(rcpm->ippdexpcr_offset + 4 * i,
+			       rcpm->ippdexpcr[i]);
+		pr_debug("ippdexpcr%d = 0x%x\n", i, rcpm->ippdexpcr[i]);
+	}
+
+	return 0;
+}
+
+static int rcpm_suspend_notifier_call(struct notifier_block *bl,
+				      unsigned long state,
+				      void *unused)
+{
+	switch (state) {
+	case PM_SUSPEND_PREPARE:
+		rcpm_suspend_prepare();
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct rcpm_config rcpm_default_config = {
+	.ipp_num = 1,
+	.ippdexpcr_offset = RCPM_IPPDEXPCR0,
+};
+
+static const struct of_device_id rcpm_matches[] = {
+	{
+		.compatible = "fsl,qoriq-rcpm-2.1",
+		.data = &rcpm_default_config,
+	},
+	{}
+};
+
+static struct notifier_block rcpm_suspend_notifier = {
+	.notifier_call = rcpm_suspend_notifier_call,
+};
+
+static int __init layerscape_rcpm_init(void)
+{
+	const struct of_device_id *match;
+	struct device_node *np;
+
+	np = of_find_matching_node_and_match(NULL, rcpm_matches, &match);
+	if (!np) {
+		pr_err("Can't find the RCPM node.\n");
+		return -EINVAL;
+	}
+
+	if (match->data)
+		rcpm = (struct rcpm_config *)match->data;
+	else
+		return -EINVAL;
+
+	rcpm->rcpm_reg_base = of_iomap(np, 0);
+	of_node_put(np);
+	if (!rcpm->rcpm_reg_base)
+		return -ENOMEM;
+
+	register_pm_notifier(&rcpm_suspend_notifier);
+
+	pr_info("The RCPM driver initialized.\n");
+
+	return 0;
+}
+
+subsys_initcall(layerscape_rcpm_init);
-- 
1.7.1
