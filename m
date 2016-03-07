Return-Path: <codrin.ciubotariu@nxp.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0058.outbound.protection.outlook.com [207.46.100.58])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 985061A011D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 02:49:40 +1100 (AEDT)
From: Codrin Ciubotariu <codrin.ciubotariu@nxp.com>
To: <iommu@lists.linux-foundation.org>
CC: <scottwood@freescale.com>, <Varun.Sethi@freescale.com>,
 <linuxppc-dev@lists.ozlabs.org>, Codrin Ciubotariu
 <codrin.ciubotariu@nxp.com>, Shengzhou Liu <Shengzhou.Liu@freescale.com>
Subject: [PATCH 2/7] iommu/fsl: Work around erratum A-007907
Date: Mon, 7 Mar 2016 17:34:18 +0200
Message-ID: <1457364863-18004-3-git-send-email-codrin.ciubotariu@nxp.com>
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

Erratum A-007907 can cause a core hang under certain circumstances.
Part of the workaround involves not stashing to L1 Cache.  On affected
chips, stash to L2 when L1 is requested.

Signed-off-by: Scott Wood <scottwood@freescale.com>
Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@nxp.com>
---
 drivers/iommu/fsl_pamu.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
index c64cdef..a00c473 100644
--- a/drivers/iommu/fsl_pamu.c
+++ b/drivers/iommu/fsl_pamu.c
@@ -25,6 +25,7 @@
 #include <linux/genalloc.h>
 
 #include <asm/mpc85xx.h>
+#include <asm/reg.h>
 
 /* define indexes for each operation mapping scenario */
 #define OMI_QMAN        0x00
@@ -534,6 +535,16 @@ void get_ome_index(u32 *omi_index, struct device *dev)
 		*omi_index = OMI_QMAN_PRIV;
 }
 
+static bool has_erratum_a007907(void)
+{
+	u32 pvr = mfspr(SPRN_PVR);
+
+	if (PVR_VER(pvr) == PVR_VER_E6500 && PVR_REV(pvr) <= 0x20)
+		return true;
+
+	return false;
+}
+
 /**
  * get_stash_id - Returns stash destination id corresponding to a
  *                cache type and vcpu.
@@ -551,6 +562,9 @@ u32 get_stash_id(u32 stash_dest_hint, u32 vcpu)
 	int len, found = 0;
 	int i;
 
+	if (stash_dest_hint == PAMU_ATTR_CACHE_L1 && has_erratum_a007907())
+		stash_dest_hint = PAMU_ATTR_CACHE_L2;
+
 	/* Fastpath, exit early if L3/CPC cache is target for stashing */
 	if (stash_dest_hint == PAMU_ATTR_CACHE_L3) {
 		node = of_find_matching_node(NULL, l3_device_ids);
-- 
1.9.3
