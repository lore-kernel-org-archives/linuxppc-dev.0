Return-Path: <yinbo.zhu@nxp.com>
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0114.outbound.protection.outlook.com [104.47.37.114])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40hwkp4cMDzF2Cn
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 13:37:06 +1000 (AEST)
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
 <ying.zhang22455@nxp.com>
Subject: [PATCH 3/9] soc: fsl: set rcpm bit for FTM
Date: Fri, 11 May 2018 11:35:24 +0800
Message-ID: <20180511033530.7931-3-yinbo.zhu@nxp.com>
In-Reply-To: <20180511033530.7931-1-yinbo.zhu@nxp.com>
References: <20180511033530.7931-1-yinbo.zhu@nxp.com>
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

From: Zhang Ying-22455 <ying.zhang22455@nxp.com>

Set RCPM for FTM when using FTM as wakeup source. Because the RCPM
module of each platform has different big-end and little-end mode,
there need to set RCPM depending on the platform.

Signed-off-by: Zhang Ying-22455 <ying.zhang22455@nxp.com>
Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
---
 .../devicetree/bindings/timer/fsl,ftm-timer.txt    |    7 ++
 drivers/soc/fsl/layerscape/ftm_alarm.c             |   92 ++++++++++++++++++-
 2 files changed, 94 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/fsl,ftm-timer.txt b/Documentation/devicetree/bindings/timer/fsl,ftm-timer.txt
index aa8c402..15ead58 100644
--- a/Documentation/devicetree/bindings/timer/fsl,ftm-timer.txt
+++ b/Documentation/devicetree/bindings/timer/fsl,ftm-timer.txt
@@ -3,6 +3,13 @@ Freescale FlexTimer Module (FTM) Timer
 Required properties:
 
 - compatible : should be "fsl,ftm-timer"
+ Possible compatibles for ARM:
+     "fsl,ls1012a-ftm"
+     "fsl,ls1021a-ftm"
+     "fsl,ls1043a-ftm"
+     "fsl,ls1046a-ftm"
+     "fsl,ls1088a-ftm"
+     "fsl,ls208xa-ftm"
 - reg : Specifies base physical address and size of the register sets for the
   clock event device and clock source device.
 - interrupts : Should be the clock event device interrupt.
diff --git a/drivers/soc/fsl/layerscape/ftm_alarm.c b/drivers/soc/fsl/layerscape/ftm_alarm.c
index 6f9882f..811dcfa 100644
--- a/drivers/soc/fsl/layerscape/ftm_alarm.c
+++ b/drivers/soc/fsl/layerscape/ftm_alarm.c
@@ -16,6 +16,9 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/libata.h>
 
 #define FTM_SC			0x00
 #define FTM_SC_CLK_SHIFT	3
@@ -40,6 +43,59 @@
 static u32 alarm_freq;
 static bool big_endian;
 
+enum pmu_endian_type {
+	BIG_ENDIAN,
+	LITTLE_ENDIAN,
+};
+
+struct rcpm_cfg {
+	enum pmu_endian_type big_endian; /* Big/Little endian of PMU module */
+
+	/* FlexTimer1 is not powerdown during device LPM20 */
+	u32 flextimer_set_bit;
+};
+
+static struct rcpm_cfg ls1012a_rcpm_cfg = {
+	.big_endian = BIG_ENDIAN,
+	.flextimer_set_bit = 0x20000,
+};
+
+static struct rcpm_cfg ls1021a_rcpm_cfg = {
+	.big_endian = BIG_ENDIAN,
+	.flextimer_set_bit = 0x20000,
+};
+
+static struct rcpm_cfg ls1043a_rcpm_cfg = {
+	.big_endian = BIG_ENDIAN,
+	.flextimer_set_bit = 0x20000,
+};
+
+static struct rcpm_cfg ls1046a_rcpm_cfg = {
+	.big_endian = BIG_ENDIAN,
+	.flextimer_set_bit = 0x20000,
+};
+
+static struct rcpm_cfg ls1088a_rcpm_cfg = {
+	.big_endian = LITTLE_ENDIAN,
+	.flextimer_set_bit = 0x4000,
+};
+
+static struct rcpm_cfg ls208xa_rcpm_cfg = {
+	.big_endian = LITTLE_ENDIAN,
+	.flextimer_set_bit = 0x4000,
+};
+
+static const struct of_device_id ippdexpcr_of_match[] = {
+	{ .compatible = "fsl,ls1012a-ftm", .data = &ls1012a_rcpm_cfg},
+	{ .compatible = "fsl,ls1021a-ftm", .data = &ls1021a_rcpm_cfg},
+	{ .compatible = "fsl,ls1043a-ftm", .data = &ls1043a_rcpm_cfg},
+	{ .compatible = "fsl,ls1046a-ftm", .data = &ls1046a_rcpm_cfg},
+	{ .compatible = "fsl,ls1088a-ftm", .data = &ls1088a_rcpm_cfg},
+	{ .compatible = "fsl,ls208xa-ftm", .data = &ls208xa_rcpm_cfg},
+	{},
+};
+MODULE_DEVICE_TABLE(of, ippdexpcr_of_match);
+
 static inline u32 ftm_readl(void __iomem *addr)
 {
 	if (big_endian)
@@ -214,7 +270,10 @@ static int ftm_alarm_probe(struct platform_device *pdev)
 	struct resource *r;
 	int irq;
 	int ret;
-	u32 ippdexpcr;
+	struct rcpm_cfg *rcpm_cfg;
+	u32 ippdexpcr, flextimer;
+	const struct of_device_id *of_id;
+	enum pmu_endian_type endian;
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!r)
@@ -224,14 +283,32 @@ static int ftm_alarm_probe(struct platform_device *pdev)
 	if (IS_ERR(ftm1_base))
 		return PTR_ERR(ftm1_base);
 
+	of_id = of_match_node(ippdexpcr_of_match, np);
+	if (!of_id)
+		return -ENODEV;
+
+	rcpm_cfg = devm_kzalloc(&pdev->dev, sizeof(*rcpm_cfg), GFP_KERNEL);
+	if (!rcpm_cfg)
+		return -ENOMEM;
+
+	rcpm_cfg = (struct rcpm_cfg *)of_id->data;
+	endian = rcpm_cfg->big_endian;
+	flextimer = rcpm_cfg->flextimer_set_bit;
+
 	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "FlexTimer1");
 	if (r) {
 		rcpm_ftm_addr = devm_ioremap_resource(&pdev->dev, r);
 		if (IS_ERR(rcpm_ftm_addr))
 			return PTR_ERR(rcpm_ftm_addr);
-		ippdexpcr = ioread32be(rcpm_ftm_addr);
-		ippdexpcr |= 0x20000;
-		iowrite32be(ippdexpcr, rcpm_ftm_addr);
+		if (endian == BIG_ENDIAN)
+			ippdexpcr = ioread32be(rcpm_ftm_addr);
+		else
+			ippdexpcr = ioread32(rcpm_ftm_addr);
+		ippdexpcr |= flextimer;
+		if (endian == BIG_ENDIAN)
+			iowrite32be(ippdexpcr, rcpm_ftm_addr);
+		else
+			iowrite32(ippdexpcr, rcpm_ftm_addr);
 	}
 
 	irq = irq_of_parse_and_map(np, 0);
@@ -265,7 +342,12 @@ static int ftm_alarm_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id ftm_alarm_match[] = {
-	{ .compatible = "fsl,ftm-alarm", },
+	{ .compatible = "fsl,ls1012a-ftm", },
+	{ .compatible = "fsl,ls1021a-ftm", },
+	{ .compatible = "fsl,ls1043a-ftm", },
+	{ .compatible = "fsl,ls1046a-ftm", },
+	{ .compatible = "fsl,ls1088a-ftm", },
+	{ .compatible = "fsl,ls208xa-ftm", },
 	{ .compatible = "fsl,ftm-timer", },
 	{ },
 };
-- 
1.7.1
