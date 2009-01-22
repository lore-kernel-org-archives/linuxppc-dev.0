Return-Path: <rcjenn@austin.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9D1E3DDEF5
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jan 2009 06:40:47 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n0MJd4r3020867
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2009 12:39:04 -0700
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n0MJe3mf113666
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2009 12:40:03 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n0MJe1BF003192
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2009 12:40:02 -0700
Date: Thu, 22 Jan 2009 13:40:00 -0600
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Correct VIO bus accounting problem in CMO env.
Message-ID: <20090122194000.GA14767@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian King <brking@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In the VIO bus code the wrappers for dma alloc_coherent and free_coherent
calls are rounding to IOMMU_PAGE_SIZE.  Taking a look at the underlying
calls, the actual mapping is promoted to PAGE_SIZE.  Changing the
rounding in these two functions fixes under-reporting the entitlement
used by the system.  Without this change, the system could run out of
entitlement before it believes it has and incur mapping failures at the
firmware level.

Also in the VIO bus code, the wrapper for dma map_sg is not exiting in
an error path where it should.  Rather than fall through to code for the
success case, this patch adds the return that is needed in the error path.

Signed-off-by: Robert Jennings <rcj@linux.vnet.ibm.com>

---
 arch/powerpc/kernel/vio.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

Index: b/arch/powerpc/kernel/vio.c
===================================================================
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -492,14 +492,14 @@ static void *vio_dma_iommu_alloc_coheren
 	struct vio_dev *viodev = to_vio_dev(dev);
 	void *ret;
 
-	if (vio_cmo_alloc(viodev, roundup(size, IOMMU_PAGE_SIZE))) {
+	if (vio_cmo_alloc(viodev, roundup(size, PAGE_SIZE))) {
 		atomic_inc(&viodev->cmo.allocs_failed);
 		return NULL;
 	}
 
 	ret = dma_iommu_ops.alloc_coherent(dev, size, dma_handle, flag);
 	if (unlikely(ret == NULL)) {
-		vio_cmo_dealloc(viodev, roundup(size, IOMMU_PAGE_SIZE));
+		vio_cmo_dealloc(viodev, roundup(size, PAGE_SIZE));
 		atomic_inc(&viodev->cmo.allocs_failed);
 	}
 
@@ -513,7 +513,7 @@ static void vio_dma_iommu_free_coherent(
 
 	dma_iommu_ops.free_coherent(dev, size, vaddr, dma_handle);
 
-	vio_cmo_dealloc(viodev, roundup(size, IOMMU_PAGE_SIZE));
+	vio_cmo_dealloc(viodev, roundup(size, PAGE_SIZE));
 }
 
 static dma_addr_t vio_dma_iommu_map_page(struct device *dev, struct page *page,
@@ -572,6 +572,7 @@ static int vio_dma_iommu_map_sg(struct d
 	if (unlikely(!ret)) {
 		vio_cmo_dealloc(viodev, alloc_size);
 		atomic_inc(&viodev->cmo.allocs_failed);
+		return ret;
 	}
 
 	for (sgl = sglist, count = 0; count < ret; count++, sgl++)
