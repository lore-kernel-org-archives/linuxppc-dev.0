Return-Path: <iamjoonsoo.kim@lge.com>
Received: from lgeamrelo01.lge.com (lgeamrelo01.lge.com [156.147.1.125])
 by lists.ozlabs.org (Postfix) with ESMTP id 2BC831A0370
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jun 2014 15:36:42 +1000 (EST)
From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
To: Andrew Morton <akpm@linux-foundation.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Michal Nazarewicz <mina86@mina86.com>
Subject: [PATCH v3 -next 8/9] mm,
 CMA: change cma_declare_contiguous() to obey coding convention
Date: Mon, 16 Jun 2014 14:40:50 +0900
Message-Id: <1402897251-23639-9-git-send-email-iamjoonsoo.kim@lge.com>
In-Reply-To: <1402897251-23639-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1402897251-23639-1-git-send-email-iamjoonsoo.kim@lge.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, kvm@vger.kernel.org,
 linux-mm@kvack.org, Gleb Natapov <gleb@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
 Paul Mackerras <paulus@samba.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Zhang Yanfei <zhangyanfei@cn.fujitsu.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Conventionally, we put output param to the end of param list
and put the 'base' ahead of 'size', but cma_declare_contiguous()
doesn't look like that, so change it.

Additionally, move down cma_areas reference code to the position
where it is really needed.

v3: put 'base' ahead of 'size' (Minchan)

Acked-by: Michal Nazarewicz <mina86@mina86.com>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

diff --git a/arch/powerpc/kvm/book3s_hv_builtin.c b/arch/powerpc/kvm/book3s_hv_builtin.c
index 3960e0b..6cf498a 100644
--- a/arch/powerpc/kvm/book3s_hv_builtin.c
+++ b/arch/powerpc/kvm/book3s_hv_builtin.c
@@ -185,8 +185,8 @@ void __init kvm_cma_reserve(void)
 			align_size = HPT_ALIGN_PAGES << PAGE_SHIFT;
 
 		align_size = max(kvm_rma_pages << PAGE_SHIFT, align_size);
-		cma_declare_contiguous(selected_size, 0, 0, align_size,
-			KVM_CMA_CHUNK_ORDER - PAGE_SHIFT, &kvm_cma, false);
+		cma_declare_contiguous(0, selected_size, 0, align_size,
+			KVM_CMA_CHUNK_ORDER - PAGE_SHIFT, false, &kvm_cma);
 	}
 }
 
diff --git a/drivers/base/dma-contiguous.c b/drivers/base/dma-contiguous.c
index 0411c1c..6606abd 100644
--- a/drivers/base/dma-contiguous.c
+++ b/drivers/base/dma-contiguous.c
@@ -165,7 +165,7 @@ int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
 {
 	int ret;
 
-	ret = cma_declare_contiguous(size, base, limit, 0, 0, res_cma, fixed);
+	ret = cma_declare_contiguous(base, size, limit, 0, 0, fixed, res_cma);
 	if (ret)
 		return ret;
 
diff --git a/include/linux/cma.h b/include/linux/cma.h
index 69d3726..32cab7a 100644
--- a/include/linux/cma.h
+++ b/include/linux/cma.h
@@ -15,7 +15,7 @@ extern unsigned long cma_get_size(struct cma *cma);
 extern int __init cma_declare_contiguous(phys_addr_t size,
 			phys_addr_t base, phys_addr_t limit,
 			phys_addr_t alignment, unsigned int order_per_bit,
-			struct cma **res_cma, bool fixed);
+			bool fixed, struct cma **res_cma);
 extern struct page *cma_alloc(struct cma *cma, int count, unsigned int align);
 extern bool cma_release(struct cma *cma, struct page *pages, int count);
 #endif
diff --git a/mm/cma.c b/mm/cma.c
index b442a13..9961120 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -141,13 +141,13 @@ core_initcall(cma_init_reserved_areas);
 
 /**
  * cma_declare_contiguous() - reserve custom contiguous area
- * @size: Size of the reserved area (in bytes),
  * @base: Base address of the reserved area optional, use 0 for any
+ * @size: Size of the reserved area (in bytes),
  * @limit: End address of the reserved memory (optional, 0 for any).
  * @alignment: Alignment for the CMA area, should be power of 2 or zero
  * @order_per_bit: Order of pages represented by one bit on bitmap.
- * @res_cma: Pointer to store the created cma region.
  * @fixed: hint about where to place the reserved area
+ * @res_cma: Pointer to store the created cma region.
  *
  * This function reserves memory from early allocator. It should be
  * called by arch specific code once the early allocator (memblock or bootmem)
@@ -157,12 +157,12 @@ core_initcall(cma_init_reserved_areas);
  * If @fixed is true, reserve contiguous area at exactly @base.  If false,
  * reserve in range from @base to @limit.
  */
-int __init cma_declare_contiguous(phys_addr_t size,
-			phys_addr_t base, phys_addr_t limit,
+int __init cma_declare_contiguous(phys_addr_t base,
+			phys_addr_t size, phys_addr_t limit,
 			phys_addr_t alignment, unsigned int order_per_bit,
-			struct cma **res_cma, bool fixed)
+			bool fixed, struct cma **res_cma)
 {
-	struct cma *cma = &cma_areas[cma_area_count];
+	struct cma *cma;
 	int ret = 0;
 
 	pr_debug("%s(size %lx, base %08lx, limit %08lx alignment %08lx)\n",
@@ -218,6 +218,7 @@ int __init cma_declare_contiguous(phys_addr_t size,
 	 * Each reserved area must be initialised later, when more kernel
 	 * subsystems (like slab allocator) are available.
 	 */
+	cma = &cma_areas[cma_area_count];
 	cma->base_pfn = PFN_DOWN(base);
 	cma->count = size >> PAGE_SHIFT;
 	cma->order_per_bit = order_per_bit;
-- 
1.7.9.5
