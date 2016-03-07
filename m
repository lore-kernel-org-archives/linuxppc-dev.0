Return-Path: <codrin.ciubotariu@nxp.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0078.outbound.protection.outlook.com [207.46.100.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 59F011A011D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 02:50:33 +1100 (AEDT)
From: Codrin Ciubotariu <codrin.ciubotariu@nxp.com>
To: <iommu@lists.linux-foundation.org>
CC: <scottwood@freescale.com>, <Varun.Sethi@freescale.com>,
 <linuxppc-dev@lists.ozlabs.org>, Codrin Ciubotariu
 <codrin.ciubotariu@nxp.com>
Subject: [PATCH 5/7] iommu/fsl: Enable default DMA window for PCIe devices
 once detached from domain
Date: Mon, 7 Mar 2016 17:34:21 +0200
Message-ID: <1457364863-18004-6-git-send-email-codrin.ciubotariu@nxp.com>
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

Once the PCIe device assigned to a guest VM (via VFIO) gets detached
from the iommu domain (when guest terminates), its PAMU table entry
is disabled. So, this would prevent the device from being used once
it's assigned back to the host.

This patch allows for creation of a default DMA window corresponding
to the device and subsequently enabling the PAMU table entry. Before
we enable the entry, we ensure that the device's bus master capability
is disabled (device quiesced).

Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@nxp.com>
---
 drivers/iommu/fsl_pamu.c        | 45 ++++++++++++++++++++++++++++++++---------
 drivers/iommu/fsl_pamu.h        |  1 +
 drivers/iommu/fsl_pamu_domain.c | 42 +++++++++++++++++++++++++++++++++++---
 3 files changed, 76 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
index ce25084..181759e 100644
--- a/drivers/iommu/fsl_pamu.c
+++ b/drivers/iommu/fsl_pamu.c
@@ -302,6 +302,40 @@ int pamu_update_paace_stash(int liodn, u32 subwin, u32 value)
 	return 0;
 }
 
+/* Default PPAACE settings for an LIODN */
+static void setup_default_ppaace(struct paace *ppaace)
+{
+	pamu_init_ppaace(ppaace);
+	/* window size is 2^(WSE+1) bytes */
+	set_bf(ppaace->addr_bitfields, PPAACE_AF_WSE, 35);
+	ppaace->wbah = 0;
+	set_bf(ppaace->addr_bitfields, PPAACE_AF_WBAL, 0);
+	set_bf(ppaace->impl_attr, PAACE_IA_ATM,
+		PAACE_ATM_NO_XLATE);
+	set_bf(ppaace->addr_bitfields, PAACE_AF_AP,
+		PAACE_AP_PERMS_ALL);
+}
+
+/* Reset the PAACE entry to the default state */
+void enable_default_dma_window(int liodn)
+{
+	struct paace *ppaace;
+
+	ppaace = pamu_get_ppaace(liodn);
+	if (!ppaace) {
+		pr_debug("Invalid liodn entry\n");
+		return;
+	}
+
+	memset(ppaace, 0, sizeof(struct paace));
+
+	setup_default_ppaace(ppaace);
+
+	/* Ensure that all other stores to the ppaace complete first */
+	mb();
+	pamu_enable_liodn(liodn);
+}
+
 /* Disable a subwindow corresponding to the LIODN */
 int pamu_disable_spaace(int liodn, u32 subwin)
 {
@@ -792,15 +826,8 @@ static void setup_liodns(void)
 				continue;
 			}
 			ppaace = pamu_get_ppaace(liodn);
-			pamu_init_ppaace(ppaace);
-			/* window size is 2^(WSE+1) bytes */
-			set_bf(ppaace->addr_bitfields, PPAACE_AF_WSE, 35);
-			ppaace->wbah = 0;
-			set_bf(ppaace->addr_bitfields, PPAACE_AF_WBAL, 0);
-			set_bf(ppaace->impl_attr, PAACE_IA_ATM,
-			       PAACE_ATM_NO_XLATE);
-			set_bf(ppaace->addr_bitfields, PAACE_AF_AP,
-			       PAACE_AP_PERMS_ALL);
+			setup_default_ppaace(ppaace);
+
 			if (of_device_is_compatible(node, "fsl,qman-portal"))
 				setup_qbman_paace(ppaace, QMAN_PORTAL_PAACE);
 			if (of_device_is_compatible(node, "fsl,qman"))
diff --git a/drivers/iommu/fsl_pamu.h b/drivers/iommu/fsl_pamu.h
index bebc2e3..3bd0434 100644
--- a/drivers/iommu/fsl_pamu.h
+++ b/drivers/iommu/fsl_pamu.h
@@ -412,5 +412,6 @@ void get_ome_index(u32 *omi_index, struct device *dev);
 int  pamu_update_paace_stash(int liodn, u32 subwin, u32 value);
 int pamu_disable_spaace(int liodn, u32 subwin);
 u32 pamu_get_max_subwin_cnt(void);
+void enable_default_dma_window(int liodn);
 
 #endif  /* __FSL_PAMU_H */
diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index 37f95d3..ba2f97b 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -327,17 +327,53 @@ static struct fsl_dma_domain *iommu_alloc_dma_domain(void)
 	return domain;
 }
 
+/* Disable device DMA capability and enable default DMA window */
+static void disable_device_dma(struct device_domain_info *info,
+			       int enable_dma_window)
+{
+#ifdef CONFIG_PCI
+	if (dev_is_pci(info->dev))
+		pci_clear_master(to_pci_dev(info->dev));
+#endif
+
+	if (enable_dma_window)
+		enable_default_dma_window(info->liodn);
+}
+
+static int check_for_shared_liodn(struct device_domain_info *info)
+{
+	struct device_domain_info *tmp;
+
+	/*
+	 * Sanity check, to ensure that this is not a
+	 * shared LIODN. In case of a PCIe controller
+	 * it's possible that all PCIe devices share
+	 * the same LIODN.
+	 */
+	list_for_each_entry(tmp, &info->domain->devices, link) {
+		if (info->liodn == tmp->liodn)
+			return 1;
+	}
+
+	return 0;
+}
+
 static void remove_device_ref(struct device_domain_info *info, u32 win_cnt)
 {
 	unsigned long flags;
+	int enable_dma_window = 0;
 
 	list_del(&info->link);
 	spin_lock_irqsave(&iommu_lock, flags);
-	if (win_cnt > 1)
-		pamu_free_subwins(info->liodn);
-	pamu_disable_liodn(info->liodn);
+	if (!check_for_shared_liodn(info)) {
+		if (win_cnt > 1)
+			pamu_free_subwins(info->liodn);
+		pamu_disable_liodn(info->liodn);
+		enable_dma_window = 1;
+	}
 	spin_unlock_irqrestore(&iommu_lock, flags);
 	spin_lock_irqsave(&device_domain_lock, flags);
+	disable_device_dma(info, enable_dma_window);
 	info->dev->archdata.iommu_domain = NULL;
 	kmem_cache_free(iommu_devinfo_cache, info);
 	spin_unlock_irqrestore(&device_domain_lock, flags);
-- 
1.9.3
