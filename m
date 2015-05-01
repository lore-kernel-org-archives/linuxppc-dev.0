Return-Path: <akinobu.mita@gmail.com>
Received: from mail-pa0-x22f.google.com (mail-pa0-x22f.google.com
 [IPv6:2607:f8b0:400e:c03::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ED42E1A0D1F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2015 23:57:24 +1000 (AEST)
Received: by pacwv17 with SMTP id wv17so91701735pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 May 2015 06:57:22 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org
Subject: [PATCH v2 08/10] powerpc: use for_each_sg()
Date: Fri,  1 May 2015 22:56:41 +0900
Message-Id: <1430488603-11055-8-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1430488603-11055-1-git-send-email-akinobu.mita@gmail.com>
References: <1430488603-11055-1-git-send-email-akinobu.mita@gmail.com>
Cc: linux-arch@vger.kernel.org, Akinobu Mita <akinobu.mita@gmail.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This replaces the plain loop over the sglist array with for_each_sg()
macro which consists of sg_next() function calls.  Since powerpc does
select ARCH_HAS_SG_CHAIN, it is necessary to use for_each_sg() in
order to loop over each sg element.  This also help find problems with
drivers that do not properly initialize their sg tables when
CONFIG_DEBUG_SG is enabled.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-arch@vger.kernel.org
---
* New patch from v2

 arch/powerpc/kernel/vio.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
index 5bfdab9..b7a6844 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -557,11 +557,11 @@ static int vio_dma_iommu_map_sg(struct device *dev, struct scatterlist *sglist,
 	struct vio_dev *viodev = to_vio_dev(dev);
 	struct iommu_table *tbl;
 	struct scatterlist *sgl;
-	int ret, count = 0;
+	int ret, count;
 	size_t alloc_size = 0;
 
 	tbl = get_iommu_table_base(dev);
-	for (sgl = sglist; count < nelems; count++, sgl++)
+	for_each_sg(sglist, sgl, nelems, count)
 		alloc_size += roundup(sgl->length, IOMMU_PAGE_SIZE(tbl));
 
 	if (vio_cmo_alloc(viodev, alloc_size)) {
@@ -577,7 +577,7 @@ static int vio_dma_iommu_map_sg(struct device *dev, struct scatterlist *sglist,
 		return ret;
 	}
 
-	for (sgl = sglist, count = 0; count < ret; count++, sgl++)
+	for_each_sg(sglist, sgl, ret, count)
 		alloc_size -= roundup(sgl->dma_length, IOMMU_PAGE_SIZE(tbl));
 	if (alloc_size)
 		vio_cmo_dealloc(viodev, alloc_size);
@@ -594,10 +594,10 @@ static void vio_dma_iommu_unmap_sg(struct device *dev,
 	struct iommu_table *tbl;
 	struct scatterlist *sgl;
 	size_t alloc_size = 0;
-	int count = 0;
+	int count;
 
 	tbl = get_iommu_table_base(dev);
-	for (sgl = sglist; count < nelems; count++, sgl++)
+	for_each_sg(sglist, sgl, nelems, count)
 		alloc_size += roundup(sgl->dma_length, IOMMU_PAGE_SIZE(tbl));
 
 	dma_iommu_ops.unmap_sg(dev, sglist, nelems, direction, attrs);
-- 
1.9.1
