Return-Path: <codrin.ciubotariu@nxp.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0062.outbound.protection.outlook.com [207.46.100.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 718F11A011D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 02:50:20 +1100 (AEDT)
From: Codrin Ciubotariu <codrin.ciubotariu@nxp.com>
To: <iommu@lists.linux-foundation.org>
CC: <scottwood@freescale.com>, <Varun.Sethi@freescale.com>,
 <linuxppc-dev@lists.ozlabs.org>, Codrin Ciubotariu
 <codrin.ciubotariu@nxp.com>
Subject: [PATCH 7/7] iommu/fsl: Added cache controller compatible strings for
 SOCs
Date: Mon, 7 Mar 2016 17:34:23 +0200
Message-ID: <1457364863-18004-8-git-send-email-codrin.ciubotariu@nxp.com>
In-Reply-To: <1457364863-18004-1-git-send-email-codrin.ciubotariu@nxp.com>
References: <1457364863-18004-1-git-send-email-codrin.ciubotariu@nxp.com>
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

From: Varun Sethi <Varun.Sethi@freescale.com>

Added cache controller compatible strings for T2080, B4420, T1040
and T1024. PAMU driver searches for a matching string while setting
up L3 cache stashing.

Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@nxp.com>
---
 drivers/iommu/fsl_pamu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
index 290231a..47f54fe 100644
--- a/drivers/iommu/fsl_pamu.c
+++ b/drivers/iommu/fsl_pamu.c
@@ -63,12 +63,20 @@ static const struct of_device_id guts_device_ids[] = {
 /*
  * Table for matching compatible strings, for device tree
  * L3 cache controller node.
+ * "fsl,t1024-l3-cache-controller" corresponds to T1024,
+ * "fsl,t1040-l3-cache-controller" corresponds to T1040,
+ * "fsl,b4420-l3-cache-controller" corresponds to B4420,
+ * "fsl,t2080-l3-cache-controller" corresponds to T2080,
  * "fsl,t4240-l3-cache-controller" corresponds to T4,
  * "fsl,b4860-l3-cache-controller" corresponds to B4 &
  * "fsl,p4080-l3-cache-controller" corresponds to other,
  * SOCs.
  */
 static const struct of_device_id l3_device_ids[] = {
+	{ .compatible = "fsl,t1024-l3-cache-controller", },
+	{ .compatible = "fsl,t1040-l3-cache-controller", },
+	{ .compatible = "fsl,b4420-l3-cache-controller", },
+	{ .compatible = "fsl,t2080-l3-cache-controller", },
 	{ .compatible = "fsl,t4240-l3-cache-controller", },
 	{ .compatible = "fsl,b4860-l3-cache-controller", },
 	{ .compatible = "fsl,p4080-l3-cache-controller", },
@@ -647,6 +655,8 @@ u32 get_stash_id(u32 stash_dest_hint, u32 vcpu)
 			of_node_put(node);
 			return be32_to_cpup(prop);
 		}
+		pr_err("%s: Failed to get L3 cache controller information\n",
+		       __func__);
 		return ~(u32)0;
 	}
 
-- 
1.9.3
