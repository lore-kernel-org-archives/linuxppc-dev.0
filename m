Return-Path: <B16395@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe004.messaging.microsoft.com [216.32.180.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BBB252C0149
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2013 05:53:13 +1100 (EST)
From: Varun Sethi <Varun.Sethi@freescale.com>
To: <joro@8bytes.org>, <iommu@lists.linux-foundation.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <galak@kernel.crashing.org>, <benh@kernel.crashing.org>,
 <scottwood@freescale.com>, <stuart.yoder@freescale.com>
Subject: [PATCH 4/5 v9] iommu/fsl: Add additional iommu attributes required by
 the PAMU driver.
Date: Thu, 14 Mar 2013 00:15:09 +0530
Message-ID: <1363200310-11513-5-git-send-email-Varun.Sethi@freescale.com>
In-Reply-To: <1363200310-11513-1-git-send-email-Varun.Sethi@freescale.com>
References: <1363200310-11513-1-git-send-email-Varun.Sethi@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Varun Sethi <Varun.Sethi@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Added the following domain attributes for the FSL PAMU driver:
1. Added new iommu stash attribute, which allows setting of the
   LIODN specific stash id parameter through IOMMU API.
2. Added an attribute for enabling/disabling DMA to a particular
   memory window.
3. Added domain attribute to check for PAMUV1 specific constraints.

Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
---
 include/linux/iommu.h |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 02ac111..1db9fd3 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -40,6 +40,25 @@ struct notifier_block;
 typedef int (*iommu_fault_handler_t)(struct iommu_domain *,
 			struct device *, unsigned long, int, void *);
 
+/* cache stash targets */
+enum stash_target {
+	IOMMU_ATTR_CACHE_L1 = 1,
+	IOMMU_ATTR_CACHE_L2,
+	IOMMU_ATTR_CACHE_L3,
+};
+
+/* This attribute corresponds to IOMMUs capable of generating
+ * a stash transaction. A stash transaction is typically a
+ * hardware initiated prefetch of data from memory to cache.
+ * This attribute allows configuring stashig specific parameters
+ * in the IOMMU hardware.
+ */
+
+struct iommu_stash_attribute {
+	u32 	cpu;	/* cpu number */
+	u32 	cache;	/* cache to stash to: L1,L2,L3 */
+};
+
 struct iommu_domain_geometry {
 	dma_addr_t aperture_start; /* First address that can be mapped    */
 	dma_addr_t aperture_end;   /* Last address that can be mapped     */
@@ -57,10 +76,26 @@ struct iommu_domain {
 #define IOMMU_CAP_CACHE_COHERENCY	0x1
 #define IOMMU_CAP_INTR_REMAP		0x2	/* isolates device intrs */
 
+/*
+ * Following constraints are specifc to PAMUV1:
+ *  -aperture must be power of 2, and naturally aligned
+ *  -number of windows must be power of 2, and address space size
+ *   of each window is determined by aperture size / # of windows
+ *  -the actual size of the mapped region of a window must be power
+ *   of 2 starting with 4KB and physical address must be naturally
+ *   aligned.
+ * DOMAIN_ATTR_FSL_PAMUV1 corresponds to the above mentioned contraints.
+ * The caller can invoke iommu_domain_get_attr to check if the underlying
+ * iommu implementation supports these constraints.
+ */
+
 enum iommu_attr {
 	DOMAIN_ATTR_GEOMETRY,
 	DOMAIN_ATTR_PAGING,
 	DOMAIN_ATTR_WINDOWS,
+	DOMAIN_ATTR_PAMU_STASH,
+	DOMAIN_ATTR_PAMU_ENABLE,
+	DOMAIN_ATTR_FSL_PAMUV1,
 	DOMAIN_ATTR_MAX,
 };
 
-- 
1.7.4.1
