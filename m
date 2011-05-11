Return-Path: <nacc@us.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1ADD41008F4
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 May 2011 08:25:26 +1000 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e33.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p4BMIDtm031792
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2011 16:18:13 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p4BMPFiY132170
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2011 16:25:15 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p4BGPFB1016888
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2011 10:25:15 -0600
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Milton Miller <miltonm@bga.com>
Subject: [PATCH 8/8] powerpc: tidy up dma_map_ops after adding new hook
Date: Wed, 11 May 2011 15:25:04 -0700
Message-Id: <1305152704-4864-9-git-send-email-nacc@us.ibm.com>
In-Reply-To: <1305152704-4864-1-git-send-email-nacc@us.ibm.com>
References: <1305152704-4864-1-git-send-email-nacc@us.ibm.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org,
	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	Paul Mackerras <paulus@samba.org>,
	Sean MacLennan <smaclennan@pikatech.com>,
	Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Milton Miller <miltonm@bga.com>

The new get_required_mask hook name is longer than many of but not all
of the prior ops.  Tidy the struct initializers to align the equal signs
using the local whitespace.

Signed-off-by: Milton Miller <miltonm@bga.com>
Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
---
 arch/powerpc/kernel/dma-iommu.c |   14 +++++++-------
 arch/powerpc/kernel/dma.c       |   16 ++++++++--------
 arch/powerpc/kernel/ibmebus.c   |   14 +++++++-------
 arch/powerpc/kernel/vio.c       |   14 +++++++-------
 4 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
index c1ad9db..6f04b9c 100644
--- a/arch/powerpc/kernel/dma-iommu.c
+++ b/arch/powerpc/kernel/dma-iommu.c
@@ -104,13 +104,13 @@ static u64 dma_iommu_get_required_mask(struct device *dev)
 }
 
 struct dma_map_ops dma_iommu_ops = {
-	.alloc_coherent	= dma_iommu_alloc_coherent,
-	.free_coherent	= dma_iommu_free_coherent,
-	.map_sg		= dma_iommu_map_sg,
-	.unmap_sg	= dma_iommu_unmap_sg,
-	.dma_supported	= dma_iommu_dma_supported,
-	.map_page	= dma_iommu_map_page,
-	.unmap_page	= dma_iommu_unmap_page,
+	.alloc_coherent		= dma_iommu_alloc_coherent,
+	.free_coherent		= dma_iommu_free_coherent,
+	.map_sg			= dma_iommu_map_sg,
+	.unmap_sg		= dma_iommu_unmap_sg,
+	.dma_supported		= dma_iommu_dma_supported,
+	.map_page		= dma_iommu_map_page,
+	.unmap_page		= dma_iommu_unmap_page,
 	.get_required_mask	= dma_iommu_get_required_mask,
 };
 EXPORT_SYMBOL(dma_iommu_ops);
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index df142d1..f94df52 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -149,14 +149,14 @@ static inline void dma_direct_sync_single(struct device *dev,
 #endif
 
 struct dma_map_ops dma_direct_ops = {
-	.alloc_coherent	= dma_direct_alloc_coherent,
-	.free_coherent	= dma_direct_free_coherent,
-	.map_sg		= dma_direct_map_sg,
-	.unmap_sg	= dma_direct_unmap_sg,
-	.dma_supported	= dma_direct_dma_supported,
-	.map_page	= dma_direct_map_page,
-	.unmap_page	= dma_direct_unmap_page,
-	.get_required_mask	= dma_direct_get_required_mask,
+	.alloc_coherent			= dma_direct_alloc_coherent,
+	.free_coherent			= dma_direct_free_coherent,
+	.map_sg				= dma_direct_map_sg,
+	.unmap_sg			= dma_direct_unmap_sg,
+	.dma_supported			= dma_direct_dma_supported,
+	.map_page			= dma_direct_map_page,
+	.unmap_page			= dma_direct_unmap_page,
+	.get_required_mask		= dma_direct_get_required_mask,
 #ifdef CONFIG_NOT_COHERENT_CACHE
 	.sync_single_for_cpu 		= dma_direct_sync_single,
 	.sync_single_for_device 	= dma_direct_sync_single,
diff --git a/arch/powerpc/kernel/ibmebus.c b/arch/powerpc/kernel/ibmebus.c
index 90ef2a4..73110fb 100644
--- a/arch/powerpc/kernel/ibmebus.c
+++ b/arch/powerpc/kernel/ibmebus.c
@@ -134,14 +134,14 @@ static u64 ibmebus_dma_get_required_mask(struct device *dev)
 }
 
 static struct dma_map_ops ibmebus_dma_ops = {
-	.alloc_coherent = ibmebus_alloc_coherent,
-	.free_coherent  = ibmebus_free_coherent,
-	.map_sg         = ibmebus_map_sg,
-	.unmap_sg       = ibmebus_unmap_sg,
-	.dma_supported  = ibmebus_dma_supported,
+	.alloc_coherent     = ibmebus_alloc_coherent,
+	.free_coherent      = ibmebus_free_coherent,
+	.map_sg             = ibmebus_map_sg,
+	.unmap_sg           = ibmebus_unmap_sg,
+	.dma_supported      = ibmebus_dma_supported,
 	.get_required_mask  = ibmebus_dma_get_required_mask,
-	.map_page       = ibmebus_map_page,
-	.unmap_page     = ibmebus_unmap_page,
+	.map_page           = ibmebus_map_page,
+	.unmap_page         = ibmebus_unmap_page,
 };
 
 static int ibmebus_match_path(struct device *dev, void *data)
diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
index c049325..34d291d 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -611,13 +611,13 @@ static u64 vio_dma_get_required_mask(struct device *dev)
 }
 
 struct dma_map_ops vio_dma_mapping_ops = {
-	.alloc_coherent = vio_dma_iommu_alloc_coherent,
-	.free_coherent  = vio_dma_iommu_free_coherent,
-	.map_sg         = vio_dma_iommu_map_sg,
-	.unmap_sg       = vio_dma_iommu_unmap_sg,
-	.map_page       = vio_dma_iommu_map_page,
-	.unmap_page     = vio_dma_iommu_unmap_page,
-	.dma_supported  = vio_dma_iommu_dma_supported,
+	.alloc_coherent    = vio_dma_iommu_alloc_coherent,
+	.free_coherent     = vio_dma_iommu_free_coherent,
+	.map_sg            = vio_dma_iommu_map_sg,
+	.unmap_sg          = vio_dma_iommu_unmap_sg,
+	.map_page          = vio_dma_iommu_map_page,
+	.unmap_page        = vio_dma_iommu_unmap_page,
+	.dma_supported     = vio_dma_iommu_dma_supported,
 	.get_required_mask = vio_dma_get_required_mask,
 };
 
-- 
1.7.4.1
