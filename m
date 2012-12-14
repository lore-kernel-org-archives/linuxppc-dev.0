Return-Path: <B16395@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1DA7F2C00BF
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Dec 2012 00:57:23 +1100 (EST)
From: Varun Sethi <Varun.Sethi@freescale.com>
To: <joerg.roedel@amd.com>, <iommu@lists.linux-foundation.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <timur@freescale.com>, <scottwood@freescale.com>
Subject: [PATCH 3/4 v7] iommu/fsl: Add iommu domain attributes required by fsl
 PAMU driver.
Date: Fri, 14 Dec 2012 19:21:53 +0530
Message-ID: <1355493114-21776-3-git-send-email-Varun.Sethi@freescale.com>
In-Reply-To: <1355493114-21776-1-git-send-email-Varun.Sethi@freescale.com>
References: <1355493114-21776-1-git-send-email-Varun.Sethi@freescale.com>
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

Added the following domain attributes required by FSL PAMU driver:
1. Subwindows field added to the iommu domain geometry attribute.
2. Added new iommu stash attribute, which allows setting of the
   LIODN specific stash id parameter through IOMMU API.
3. Added an attribute for enabling/disabling DMA to a particular
   memory window.
4. Added max_subwindows field to the geometry attribute. This is
   used to determine the maximum number sub windows available
   for the geometry.

Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
---
changes in v7:
- Added max_subwindows field to the geometry attribute.
changes in v5:
- Updated description of the subwindows field.
changes in v4:
- Updated comment explaining subwindows(as mentioned by Scott).
change in v3:
-renamed the stash attribute targets
 include/linux/iommu.h |   49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index f3b99e1..01ca1de 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -44,6 +44,47 @@ struct iommu_domain_geometry {
 	dma_addr_t aperture_start; /* First address that can be mapped    */
 	dma_addr_t aperture_end;   /* Last address that can be mapped     */
 	bool force_aperture;       /* DMA only allowed in mappable range? */
+
+	/*
+	 * A geometry mapping can be created in one of the following ways
+	 * for an IOMMU:
+	 * 1. A single contiguous window
+	 * 2. Through arbritary paging throughout the aperture.
+	 * 3. Using multiple subwindows
+	 *
+	 * In absence of arbritary paging, subwindows allow for supporting
+	 * physically discontiguous mappings.
+	 *
+	 * This attribute indicates number of DMA subwindows supported by
+	 * the geometry. If there is a single window that maps the entire
+	 * geometry, attribute must be set to "1". A value of "0" implies
+	 * that this mechanism is not used at all(normal paging is used).
+	 * Value other than* "0" or "1" indicates the actual number of
+	 * subwindows.
+	 */
+	u32 subwindows;
+	/*
+	 * This is a read only field and indicates the maximum number of
+	 * subwindows that are permitted for the geometry. The user is
+	 * not allowed to write to this field.
+	 */
+	u32 max_subwindows;
+};
+
+/* cache stash targets */
+#define IOMMU_ATTR_CACHE_L1 1
+#define IOMMU_ATTR_CACHE_L2 2
+#define IOMMU_ATTR_CACHE_L3 3
+
+/* This attribute corresponds to IOMMUs capable of generating
+ * a stash transaction. A stash transaction is typically a
+ * hardware initiated prefetch of data from memory to cache.
+ * This attribute allows configuring stashig specific parameters
+ * in the IOMMU hardware.
+ */
+struct iommu_stash_attribute {
+	u32 	cpu;	/* cpu number */
+	u32 	cache;	/* cache to stash to: L1,L2,L3 */
 };
 
 struct iommu_domain {
@@ -60,6 +101,14 @@ struct iommu_domain {
 enum iommu_attr {
 	DOMAIN_ATTR_MAX,
 	DOMAIN_ATTR_GEOMETRY,
+	/* Set the IOMMU hardware stashing
+	 * parameters.
+	 */
+	DOMAIN_ATTR_STASH,
+	/* Explicity enable/disable DMA for a
+         * particular memory window.
+         */
+	DOMAIN_ATTR_ENABLE,
 };
 
 #ifdef CONFIG_IOMMU_API
-- 
1.7.4.1
