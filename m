Return-Path: <albert_herranz@yahoo.es>
Received: from smtp134.mail.ukl.yahoo.com (smtp134.mail.ukl.yahoo.com
	[77.238.184.65]) by ozlabs.org (Postfix) with SMTP id DAC5AB7067
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  7 Mar 2010 23:12:00 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v3 03/11] swiotbl: add back swiotlb_alloc_boot()
Date: Sun,  7 Mar 2010 13:11:44 +0100
Message-Id: <1267963912-984-4-git-send-email-albert_herranz@yahoo.es>
In-Reply-To: <1267963912-984-1-git-send-email-albert_herranz@yahoo.es>
References: <1267963912-984-1-git-send-email-albert_herranz@yahoo.es>
Cc: Albert Herranz <albert_herranz@yahoo.es>, x86@kernel.org,
	linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
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
CC: linuxppc-dev@lists.ozlabs.org
CC: linux-kernel@vger.kernel.org
CC: x86@kernel.org
CC: linux-ia64@vger.kernel.org
---
 include/linux/swiotlb.h |    2 ++
 lib/swiotlb.c           |   10 ++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index febedcf..3954228 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -24,6 +24,8 @@ extern int swiotlb_force;
 
 extern void swiotlb_init(int verbose);
 
+extern void *swiotlb_alloc_boot(size_t bytes, unsigned long nslabs);
+
 extern void
 *swiotlb_alloc_coherent(struct device *hwdev, size_t size,
 			dma_addr_t *dma_handle, gfp_t flags);
diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index 437eedb..94db5df 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -117,6 +117,11 @@ setup_io_tlb_npages(char *str)
 __setup("swiotlb=", setup_io_tlb_npages);
 /* make io_tlb_overflow tunable too? */
 
+void * __weak __init swiotlb_alloc_boot(size_t size, unsigned long nslabs)
+{
+	return alloc_bootmem_low_pages(size);
+}
+
 /* Note that this doesn't work with highmem page */
 static dma_addr_t swiotlb_virt_to_bus(struct device *hwdev,
 				      volatile void *address)
@@ -158,7 +163,7 @@ swiotlb_init_with_default_size(size_t default_size, int verbose)
 	/*
 	 * Get IO TLB memory from the low pages
 	 */
-	io_tlb_start = alloc_bootmem_low_pages(bytes);
+	io_tlb_start = swiotlb_alloc_boot(bytes, io_tlb_nslabs);
 	if (!io_tlb_start)
 		panic("Cannot allocate SWIOTLB buffer");
 	io_tlb_end = io_tlb_start + bytes;
@@ -177,7 +182,8 @@ swiotlb_init_with_default_size(size_t default_size, int verbose)
 	/*
 	 * Get the overflow emergency buffer
 	 */
-	io_tlb_overflow_buffer = alloc_bootmem_low(io_tlb_overflow);
+	io_tlb_overflow_buffer = swiotlb_alloc_boot(io_tlb_overflow,
+						    io_tlb_nslabs);
 	if (!io_tlb_overflow_buffer)
 		panic("Cannot allocate SWIOTLB overflow buffer!\n");
 	if (verbose)
-- 
1.6.3.3
