Return-Path: <roy.pledge@nxp.com>
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-bl2nam02on0044.outbound.protection.outlook.com [104.47.38.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7Yy72BkBzDq8t
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 06:49:02 +1000 (AEST)
From: Roy Pledge <roy.pledge@nxp.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <oss@buserror.net>, <robin.murphy@arm.com>
CC: <madalin.bucur@nxp.com>, Roy Pledge <roy.pledge@nxp.com>
Subject: [PATCH v2 01/11] soc/fsl/qbman: Use shared-dma-pool for BMan private
 memory allocations
Date: Wed, 19 Apr 2017 16:48:40 -0400
Message-ID: <1492634930-10765-2-git-send-email-roy.pledge@nxp.com>
In-Reply-To: <1492634930-10765-1-git-send-email-roy.pledge@nxp.com>
References: <1492634930-10765-1-git-send-email-roy.pledge@nxp.com>
Reply-To: <roy.pledge@nxp.com>
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

Use the shared-memory-pool mechanism for free buffer proxy record
area allocation.

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 drivers/soc/fsl/qbman/bman_ccsr.c | 35 ++++++++++++++++++++++++++++++++++-
 drivers/soc/fsl/qbman/bman_priv.h |  3 +++
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qbman/bman_ccsr.c b/drivers/soc/fsl/qbman/bman_ccsr.c
index a8e8389..4d2392d 100644
--- a/drivers/soc/fsl/qbman/bman_ccsr.c
+++ b/drivers/soc/fsl/qbman/bman_ccsr.c
@@ -170,10 +170,11 @@ static int fsl_bman_probe(struct platform_device *pdev)
 {
 	int ret, err_irq;
 	struct device *dev = &pdev->dev;
-	struct device_node *node = dev->of_node;
+	struct device_node *mem_node, *node = dev->of_node;
 	struct resource *res;
 	u16 id, bm_pool_cnt;
 	u8 major, minor;
+	u64 size;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
@@ -201,6 +202,38 @@ static int fsl_bman_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	/*
+	 * If FBPR memory wasn't defined using the qbman compatiable string
+	 * try using the of_reserved_mem_device method
+	 */
+	if (!fbpr_a) {
+		ret = of_reserved_mem_device_init(dev);
+		if (ret) {
+			dev_err(dev, "of_reserved_mem_device_init() failed 0x%x\n",
+				ret);
+			return -ENODEV;
+		}
+		mem_node = of_parse_phandle(dev->of_node, "memory-region", 0);
+		if (mem_node) {
+			ret = of_property_read_u64(mem_node, "size", &size);
+			if (ret) {
+				dev_err(dev, "FBPR: of_address_to_resource fails 0x%x\n",
+					ret);
+				return -ENODEV;
+			}
+			fbpr_sz = size;
+		} else {
+			dev_err(dev, "No memory-region found for FBPR\n");
+			return -ENODEV;
+		}
+		if (!dma_zalloc_coherent(dev, fbpr_sz, &fbpr_a, 0)) {
+			dev_err(dev, "Alloc FBPR memory failed\n");
+			return -ENODEV;
+		}
+	}
+
+	dev_info(dev, "Allocated FBPR 0x%llx 0x%zx\n", fbpr_a, fbpr_sz);
+
 	bm_set_memory(fbpr_a, fbpr_sz);
 
 	err_irq = platform_get_irq(pdev, 0);
diff --git a/drivers/soc/fsl/qbman/bman_priv.h b/drivers/soc/fsl/qbman/bman_priv.h
index f6896a2..765a4bf 100644
--- a/drivers/soc/fsl/qbman/bman_priv.h
+++ b/drivers/soc/fsl/qbman/bman_priv.h
@@ -33,6 +33,9 @@
 #include "dpaa_sys.h"
 
 #include <soc/fsl/bman.h>
+#include <linux/dma-contiguous.h>
+#include <linux/of_address.h>
+#include <linux/dma-mapping.h>
 
 /* Portal processing (interrupt) sources */
 #define BM_PIRQ_RCRI	0x00000002	/* RCR Ring (below threshold) */
-- 
2.7.4
