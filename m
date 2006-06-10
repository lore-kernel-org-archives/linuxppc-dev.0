Return-Path: <anton@ozlabs.org>
Date: Sat, 10 Jun 2006 20:00:09 +1000
From: Anton Blanchard <anton@samba.org>
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] powerpc: Fix pseries IOMMU allocations
Message-ID: <20060610100009.GA12634@krispykreme>
References: <20060606141135.GB6974@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060606141135.GB6974@lst.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Make sure dma_alloc_coherent allocates memory from the local node.  This
> is important on Cell where we avoid going through the slow cpu
> interconnect.
> 
> Note:  I could only test this patch on Cell, it should be verified on
> some pseries machine by thos that have the hardware.

Looks like this patch is merged in Pauls tree and breaking pseries boot.
The patch below should fix it.

--

The arguments to alloc_pages_node were reversed, resulting in IOMMU
allocation failures. Fix it.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: build/arch/powerpc/kernel/iommu.c
===================================================================
--- build.orig/arch/powerpc/kernel/iommu.c	2006-06-10 19:49:51.000000000 +1000
+++ build/arch/powerpc/kernel/iommu.c	2006-06-10 19:52:12.000000000 +1000
@@ -561,7 +561,7 @@ void *iommu_alloc_coherent(struct iommu_
 		return NULL;
 
 	/* Alloc enough pages (and possibly more) */
-	page = alloc_pages_node(flag, order, node);
+	page = alloc_pages_node(node, flag, order);
 	if (!page)
 		return NULL;
 	ret = page_address(page);
