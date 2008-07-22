Return-Path: <rcjenn@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2A15ADDEF9
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 10:24:36 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6M0OXGq031817
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 20:24:33 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6M0OWhE148354
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 18:24:32 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6M0OWno029284
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 18:24:32 -0600
Date: Mon, 21 Jul 2008 19:24:21 -0500
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
	linuxppc-dev@ozlabs.org, Brian King <brking@linux.vnet.ibm.com>,
	Nathan Fontenot <nfont@austin.ibm.com>,
	David Darrington <ddarring@linux.vnet.ibm.com>
Subject: [PATCH] powerpc: Correct CMO entitlement accounting for map_sg
Message-ID: <20080722002420.GA26633@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The ibmvscsi driver maps pages via map_sg and frees the sg list by calling
unmap_single.  This exposes a problem where the code had been using the
length field in the scatterlist to account for the allocation when the
mapping was created but the dma_length would be used when the mapping
was destroyed.  The iommu code does coalesce the pages so the dma_length
can be smaller and would result in an entitlement accounting leak.
This patch frees up the entitlement after calling the iommu map_sg code
when pages have been coalesced so that freeing entitlement based on
dma_length is correct.

Signed-off-by: Robert Jennings <rcj@linux.vnet.ibm.com>

---
This applies on top of the existing CMO patchset.

---
 arch/powerpc/kernel/vio.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

Index: b/arch/powerpc/kernel/vio.c
===================================================================
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -571,6 +571,11 @@ static int vio_dma_iommu_map_sg(struct d
 		atomic_inc(&viodev->cmo.allocs_failed);
 	}
 
+	for (sgl = sglist, count = 0; count < ret; count++, sgl++)
+		alloc_size -= roundup(sgl->dma_length, PAGE_SIZE);
+	if (alloc_size)
+		vio_cmo_dealloc(viodev, alloc_size);
+
 	return ret;
 }
 
@@ -584,7 +589,7 @@ static void vio_dma_iommu_unmap_sg(struc
 	int count = 0;
 
 	for (sgl = sglist; count < nelems; count++, sgl++)
-		alloc_size += roundup(sgl->length, PAGE_SIZE);
+		alloc_size += roundup(sgl->dma_length, PAGE_SIZE);
 
 	dma_iommu_ops.unmap_sg(dev, sglist, nelems, direction);
 
