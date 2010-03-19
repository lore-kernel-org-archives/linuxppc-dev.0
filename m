Return-Path: <albert_herranz@yahoo.es>
Received: from smtp133.mail.ukl.yahoo.com (smtp133.mail.ukl.yahoo.com
	[77.238.184.64]) by ozlabs.org (Postfix) with SMTP id D4B96B7CE4
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 20 Mar 2010 05:32:52 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH v5 01/10] swiotbl: add back swiotlb_alloc_boot()
Date: Fri, 19 Mar 2010 19:32:17 +0100
Message-Id: <1269023546-25534-2-git-send-email-albert_herranz@yahoo.es>
In-Reply-To: <1269023546-25534-1-git-send-email-albert_herranz@yahoo.es>
References: <1269023546-25534-1-git-send-email-albert_herranz@yahoo.es>
Cc: Albert Herranz <albert_herranz@yahoo.es>, konrad.wilk@oracle.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch makes swiotlb_alloc_boot() available again.

This weak function can be overloaded to modify slightly how the SWIOTLB
and the overflow areas are allocated during boot.

This will be used later to support the Nintendo Wii video game console,
which requires placing the SWIOTLB area above 0x10000000 (MEM2).

Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
---
 include/linux/swiotlb.h |    1 +
 lib/swiotlb.c           |   10 ++++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 8550d6b..c769939 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -54,6 +54,7 @@ extern void swiotlb_bounce(phys_addr_t phys, char *dma_addr, size_t size,
 			   enum dma_data_direction dir);
 extern void swiotlb_full(struct device *dev, size_t size, int dir, int do_panic);
 
+extern void __init *swiotlb_alloc_boot(size_t bytes, unsigned long nslabs);
 #endif
 
 /* swiotlb.c: dma_ops functions. */
diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index c6bfa5d..ab1622a 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -136,6 +136,11 @@ void swiotlb_print_info(void)
 	       (unsigned long long)pend);
 }
 
+void * __weak __init swiotlb_alloc_boot(size_t size, unsigned long nslabs)
+{
+	return alloc_bootmem_low_pages(size);
+}
+
 /*
  * Statically reserve bounce buffer space and initialize bounce buffer data
  * structures for the software IO TLB used to implement the DMA API.
@@ -155,7 +160,7 @@ swiotlb_init_with_default_size(size_t default_size, int verbose)
 	/*
 	 * Get IO TLB memory from the low pages
 	 */
-	swiotlb_bk_start = alloc_bootmem_low_pages(bytes);
+	swiotlb_bk_start = swiotlb_alloc_boot(bytes, swiotlb_bk_nslabs);
 	if (!swiotlb_bk_start)
 		panic("Cannot allocate SWIOTLB buffer");
 	swiotlb_bk_end = swiotlb_bk_start + bytes;
@@ -175,7 +180,8 @@ swiotlb_init_with_default_size(size_t default_size, int verbose)
 	/*
 	 * Get the overflow emergency buffer
 	 */
-	swiotlb_bk_overflow_buffer = alloc_bootmem_low(swiotlb_bk_overflow);
+	swiotlb_bk_overflow_buffer = swiotlb_alloc_boot(swiotlb_bk_overflow,
+							swiotlb_bk_nslabs);
 	if (!swiotlb_bk_overflow_buffer)
 		panic("Cannot allocate SWIOTLB overflow buffer!\n");
 	if (verbose)
-- 
1.6.3.3
