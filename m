Return-Path: <claudiu.manoil@nxp.com>
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0070.outbound.protection.outlook.com [104.47.37.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJn496WZMzDt1c
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 01:40:41 +1100 (AEDT)
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: Scott Wood <oss@buserror.net>, <roy.pledge@nxp.com>, Madalin Bucur
 <madalin.bucur@nxp.com>
Subject: [PATCH 02/17] soc/qman: Replace of_get_property() with portable
 equivalent
Date: Wed, 16 Nov 2016 16:40:15 +0200
Message-ID: <1479307230-16650-3-git-send-email-claudiu.manoil@nxp.com>
In-Reply-To: <1479307230-16650-1-git-send-email-claudiu.manoil@nxp.com>
References: <1479307230-16650-1-git-send-email-claudiu.manoil@nxp.com>
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

From: Madalin Bucur <madalin.bucur@nxp.com>

Use arch portable of_property_read_u32() instead, which takes
care of endianness conversions.

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
 drivers/soc/fsl/qbman/dpaa_sys.h    |  1 +
 drivers/soc/fsl/qbman/qman_portal.c | 12 ++++++------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/fsl/qbman/dpaa_sys.h b/drivers/soc/fsl/qbman/dpaa_sys.h
index b63fd72..2eaf318 100644
--- a/drivers/soc/fsl/qbman/dpaa_sys.h
+++ b/drivers/soc/fsl/qbman/dpaa_sys.h
@@ -38,6 +38,7 @@
 #include <linux/kthread.h>
 #include <linux/vmalloc.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
 #include <linux/of_reserved_mem.h>
 #include <linux/prefetch.h>
 #include <linux/genalloc.h>
diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/qman_portal.c
index 1486143..0c3e8ad 100644
--- a/drivers/soc/fsl/qbman/qman_portal.c
+++ b/drivers/soc/fsl/qbman/qman_portal.c
@@ -238,9 +238,9 @@ static int qman_portal_probe(struct platform_device *pdev)
 	struct device_node *node = dev->of_node;
 	struct qm_portal_config *pcfg;
 	struct resource *addr_phys[2];
-	const u32 *channel;
 	void __iomem *va;
-	int irq, len, cpu;
+	int irq, cpu, err;
+	u32 val;
 
 	pcfg = devm_kmalloc(dev, sizeof(*pcfg), GFP_KERNEL);
 	if (!pcfg)
@@ -264,13 +264,13 @@ static int qman_portal_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
-	channel = of_get_property(node, "cell-index", &len);
-	if (!channel || (len != 4)) {
+	err = of_property_read_u32(node, "cell-index", &val);
+	if (err) {
 		dev_err(dev, "Can't get %s property 'cell-index'\n",
 			node->full_name);
-		return -ENXIO;
+		return err;
 	}
-	pcfg->channel = *channel;
+	pcfg->channel = val;
 	pcfg->cpu = -1;
 	irq = platform_get_irq(pdev, 0);
 	if (irq <= 0) {
-- 
1.7.11.7
