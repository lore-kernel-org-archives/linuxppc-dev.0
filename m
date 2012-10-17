Return-Path: <varuns@nmglablinux27.zin33.ap.freescale.net>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 29BDE2C030E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Oct 2012 04:37:00 +1100 (EST)
Received: from mail24-ch1 (localhost [127.0.0.1])	by mail24-ch1-R.bigfish.com
 (Postfix) with ESMTP id 62B3EC01AA	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,
 17 Oct 2012 17:36:50 +0000 (UTC)
Received: from CH1EHSMHS035.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.243])	by mail24-ch1.bigfish.com (Postfix) with ESMTP id
 773B92C0086
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2012 17:36:48 +0000 (UTC)
Received: from nmglablinux27.zin33.ap.freescale.net ([10.213.130.145])	by
 tx30smr01.am.freescale.net (8.14.3/8.14.0) with ESMTP id q9HHaffN011482	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2012 10:36:42 -0700
From: Varun Sethi <Varun.Sethi@freescale.com>
To: <joerg.roedel@amd.com>, <iommu@lists.linux-foundation.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3 v3] iommu/fsl: Add iommu domain attributes required by fsl
 PAMU driver.
Date: Wed, 17 Oct 2012 23:02:49 +0530
Message-ID: <1350495170-4593-3-git-send-email-Varun.Sethi@freescale.com>
In-Reply-To: <1350495170-4593-1-git-send-email-Varun.Sethi@freescale.com>
References: <1350495170-4593-1-git-send-email-Varun.Sethi@freescale.com>
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

Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
---
change in v3:
-renamed the stash attribute targets

 include/linux/iommu.h |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index f3b99e1..c3b9d73 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -44,6 +44,33 @@ struct iommu_domain_geometry {
 	dma_addr_t aperture_start; /* First address that can be mapped    */
 	dma_addr_t aperture_end;   /* Last address that can be mapped     */
 	bool force_aperture;       /* DMA only allowed in mappable range? */
+
+	/* The subwindows field indicates number of DMA subwindows supported
+	 * by the geometry. Following is the interpretation of
+	 * values for this field:
+	 * 0 : This implies that the supported geometry size is 1 MB
+         * with each subwindow size being 4KB. Thus number of subwindows
+	 * being = 1MB/4KB = 256.
+	 * 1 : Only one DMA window i.e. no subwindows.
+	 * value other than 0 or 1 would indicate actual number of subwindows.
+	 */
+	u32 subwindows;
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
@@ -60,6 +87,14 @@ struct iommu_domain {
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
