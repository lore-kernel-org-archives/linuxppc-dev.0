Return-Path: <k.kozlowski@samsung.com>
Received: from mailout4.w1.samsung.com (mailout4.w1.samsung.com
 [210.118.77.14])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rLBJX1q5PzDqgj
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jun 2016 01:40:44 +1000 (AEST)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0O8500AJ2I7SB610@mailout4.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Thu, 02 Jun 2016 16:40:41 +0100 (BST)
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
To: Richard Henderson <rth@twiddle.net>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>,
 Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Haavard Skinnemoen <hskinnemoen@gmail.com>,
 Hans-Christian Egtvedt <egtvedt@samfundet.no>,
 Steven Miao <realmz6@gmail.com>, Mark Salter <msalter@redhat.com>,
 Aurelien Jacquiot <a-jacquiot@ti.com>, Mikael Starvik <starvik@axis.com>,
 Jesper Nilsson <jesper.nilsson@axis.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>,
 Fenghua Yu <fenghua.yu@intel.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 James Hogan <james.hogan@imgtec.com>, Michal Simek <monstr@monstr.eu>,
 Ralf Baechle <ralf@linux-mips.org>, David Howells <dhowells@redhat.com>,
 Ley Foon Tan <lftan@altera.com>, Jonas Bonn <jonas@southpole.se>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
 Geoff Levand <geoff@infradead.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 David Vrabel <david.vrabel@citrix.com>, Juergen Gross <jgross@suse.com>,
 Muli Ben-Yehuda <muli@il.ibm.com>, Bjorn Helgaas <bhelgaas@google.com>,
 David Airlie <airlied@linux.ie>, Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 xen-devel@lists.xenproject.org, adi-buildroot-devel@lists.sourceforge.net,
 linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com,
 uclinux-h8-devel@lists.sourceforge.jp, linux-hexagon@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
 linux-am33-list@redhat.com, nios2-dev@lists.rocketboards.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, discuss@x86-64.org, linux-pci@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, dri-devel@lists.freedesktop.org,
 linux-samsung-soc@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-rdma@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-media@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-fbdev@vger.kernel.org
Cc: hch@infradead.org, Krzysztof Kozlowski <k.kozlowski@samsung.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [RFC v3 05/45] ARM: dma-mapping: Use unsigned long for dma_attrs
Date: Thu, 02 Jun 2016 17:39:07 +0200
Message-id: <1464881987-13203-6-git-send-email-k.kozlowski@samsung.com>
In-reply-to: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
References: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Split out subsystem specific changes for easier reviews. This will be
squashed with main commit.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/common/dmabounce.c              |  4 +-
 arch/arm/include/asm/dma-mapping.h       | 13 +++--
 arch/arm/include/asm/xen/page-coherent.h | 16 +++----
 arch/arm/mm/dma-mapping.c                | 81 ++++++++++++++++----------------
 arch/arm/xen/mm.c                        |  4 +-
 5 files changed, 56 insertions(+), 62 deletions(-)

diff --git a/arch/arm/common/dmabounce.c b/arch/arm/common/dmabounce.c
index 1143c4d5c567..301281645d08 100644
--- a/arch/arm/common/dmabounce.c
+++ b/arch/arm/common/dmabounce.c
@@ -310,7 +310,7 @@ static inline void unmap_single(struct device *dev, struct safe_buffer *buf,
  */
 static dma_addr_t dmabounce_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t size, enum dma_data_direction dir,
-		struct dma_attrs *attrs)
+		unsigned long attrs)
 {
 	dma_addr_t dma_addr;
 	int ret;
@@ -344,7 +344,7 @@ static dma_addr_t dmabounce_map_page(struct device *dev, struct page *page,
  * should be)
  */
 static void dmabounce_unmap_page(struct device *dev, dma_addr_t dma_addr, size_t size,
-		enum dma_data_direction dir, struct dma_attrs *attrs)
+		enum dma_data_direction dir, unsigned long attrs)
 {
 	struct safe_buffer *buf;
 
diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index a83570f10124..d009f7911ffc 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -5,7 +5,6 @@
 
 #include <linux/mm_types.h>
 #include <linux/scatterlist.h>
-#include <linux/dma-attrs.h>
 #include <linux/dma-debug.h>
 
 #include <asm/memory.h>
@@ -174,7 +173,7 @@ static inline void dma_mark_clean(void *addr, size_t size) { }
  * to be the device-viewed address.
  */
 extern void *arm_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
-			   gfp_t gfp, struct dma_attrs *attrs);
+			   gfp_t gfp, unsigned long attrs);
 
 /**
  * arm_dma_free - free memory allocated by arm_dma_alloc
@@ -191,7 +190,7 @@ extern void *arm_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
  * during and after this call executing are illegal.
  */
 extern void arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
-			 dma_addr_t handle, struct dma_attrs *attrs);
+			 dma_addr_t handle, unsigned long attrs);
 
 /**
  * arm_dma_mmap - map a coherent DMA allocation into user space
@@ -208,7 +207,7 @@ extern void arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
  */
 extern int arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 			void *cpu_addr, dma_addr_t dma_addr, size_t size,
-			struct dma_attrs *attrs);
+			unsigned long attrs);
 
 /*
  * This can be called during early boot to increase the size of the atomic
@@ -262,16 +261,16 @@ extern void dmabounce_unregister_dev(struct device *);
  * The scatter list versions of the above methods.
  */
 extern int arm_dma_map_sg(struct device *, struct scatterlist *, int,
-		enum dma_data_direction, struct dma_attrs *attrs);
+		enum dma_data_direction, unsigned long attrs);
 extern void arm_dma_unmap_sg(struct device *, struct scatterlist *, int,
-		enum dma_data_direction, struct dma_attrs *attrs);
+		enum dma_data_direction, unsigned long attrs);
 extern void arm_dma_sync_sg_for_cpu(struct device *, struct scatterlist *, int,
 		enum dma_data_direction);
 extern void arm_dma_sync_sg_for_device(struct device *, struct scatterlist *, int,
 		enum dma_data_direction);
 extern int arm_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
 		void *cpu_addr, dma_addr_t dma_addr, size_t size,
-		struct dma_attrs *attrs);
+		unsigned long attrs);
 
 #endif /* __KERNEL__ */
 #endif
diff --git a/arch/arm/include/asm/xen/page-coherent.h b/arch/arm/include/asm/xen/page-coherent.h
index 9408a994cc91..95ce6ac3a971 100644
--- a/arch/arm/include/asm/xen/page-coherent.h
+++ b/arch/arm/include/asm/xen/page-coherent.h
@@ -2,15 +2,14 @@
 #define _ASM_ARM_XEN_PAGE_COHERENT_H
 
 #include <asm/page.h>
-#include <linux/dma-attrs.h>
 #include <linux/dma-mapping.h>
 
 void __xen_dma_map_page(struct device *hwdev, struct page *page,
 	     dma_addr_t dev_addr, unsigned long offset, size_t size,
-	     enum dma_data_direction dir, struct dma_attrs *attrs);
+	     enum dma_data_direction dir, unsigned long attrs);
 void __xen_dma_unmap_page(struct device *hwdev, dma_addr_t handle,
 		size_t size, enum dma_data_direction dir,
-		struct dma_attrs *attrs);
+		unsigned long attrs);
 void __xen_dma_sync_single_for_cpu(struct device *hwdev,
 		dma_addr_t handle, size_t size, enum dma_data_direction dir);
 
@@ -18,22 +17,20 @@ void __xen_dma_sync_single_for_device(struct device *hwdev,
 		dma_addr_t handle, size_t size, enum dma_data_direction dir);
 
 static inline void *xen_alloc_coherent_pages(struct device *hwdev, size_t size,
-		dma_addr_t *dma_handle, gfp_t flags,
-		struct dma_attrs *attrs)
+		dma_addr_t *dma_handle, gfp_t flags, unsigned long attrs)
 {
 	return __generic_dma_ops(hwdev)->alloc(hwdev, size, dma_handle, flags, attrs);
 }
 
 static inline void xen_free_coherent_pages(struct device *hwdev, size_t size,
-		void *cpu_addr, dma_addr_t dma_handle,
-		struct dma_attrs *attrs)
+		void *cpu_addr, dma_addr_t dma_handle, unsigned long attrs)
 {
 	__generic_dma_ops(hwdev)->free(hwdev, size, cpu_addr, dma_handle, attrs);
 }
 
 static inline void xen_dma_map_page(struct device *hwdev, struct page *page,
 	     dma_addr_t dev_addr, unsigned long offset, size_t size,
-	     enum dma_data_direction dir, struct dma_attrs *attrs)
+	     enum dma_data_direction dir, unsigned long attrs)
 {
 	unsigned long page_pfn = page_to_xen_pfn(page);
 	unsigned long dev_pfn = XEN_PFN_DOWN(dev_addr);
@@ -58,8 +55,7 @@ static inline void xen_dma_map_page(struct device *hwdev, struct page *page,
 }
 
 static inline void xen_dma_unmap_page(struct device *hwdev, dma_addr_t handle,
-		size_t size, enum dma_data_direction dir,
-		struct dma_attrs *attrs)
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
 	unsigned long pfn = PFN_DOWN(handle);
 	/*
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index ff7ed5697d3e..ebb3fde99043 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -124,7 +124,7 @@ static void __dma_page_dev_to_cpu(struct page *, unsigned long,
  */
 static dma_addr_t arm_dma_map_page(struct device *dev, struct page *page,
 	     unsigned long offset, size_t size, enum dma_data_direction dir,
-	     struct dma_attrs *attrs)
+	     unsigned long attrs)
 {
 	if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
 		__dma_page_cpu_to_dev(page, offset, size, dir);
@@ -133,7 +133,7 @@ static dma_addr_t arm_dma_map_page(struct device *dev, struct page *page,
 
 static dma_addr_t arm_coherent_dma_map_page(struct device *dev, struct page *page,
 	     unsigned long offset, size_t size, enum dma_data_direction dir,
-	     struct dma_attrs *attrs)
+	     unsigned long attrs)
 {
 	return pfn_to_dma(dev, page_to_pfn(page)) + offset;
 }
@@ -153,8 +153,7 @@ static dma_addr_t arm_coherent_dma_map_page(struct device *dev, struct page *pag
  * whatever the device wrote there.
  */
 static void arm_dma_unmap_page(struct device *dev, dma_addr_t handle,
-		size_t size, enum dma_data_direction dir,
-		struct dma_attrs *attrs)
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
 	if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
 		__dma_page_dev_to_cpu(pfn_to_page(dma_to_pfn(dev, handle)),
@@ -194,12 +193,12 @@ struct dma_map_ops arm_dma_ops = {
 EXPORT_SYMBOL(arm_dma_ops);
 
 static void *arm_coherent_dma_alloc(struct device *dev, size_t size,
-	dma_addr_t *handle, gfp_t gfp, struct dma_attrs *attrs);
+	dma_addr_t *handle, gfp_t gfp, unsigned long attrs);
 static void arm_coherent_dma_free(struct device *dev, size_t size, void *cpu_addr,
-				  dma_addr_t handle, struct dma_attrs *attrs);
+				  dma_addr_t handle, unsigned long attrs);
 static int arm_coherent_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 		 void *cpu_addr, dma_addr_t dma_addr, size_t size,
-		 struct dma_attrs *attrs);
+		 unsigned long attrs);
 
 struct dma_map_ops arm_coherent_dma_ops = {
 	.alloc			= arm_coherent_dma_alloc,
@@ -621,7 +620,7 @@ static void __free_from_contiguous(struct device *dev, struct page *page,
 	dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT);
 }
 
-static inline pgprot_t __get_dma_pgprot(struct dma_attrs *attrs, pgprot_t prot)
+static inline pgprot_t __get_dma_pgprot(unsigned long attrs, pgprot_t prot)
 {
 	prot = dma_get_attr(DMA_ATTR_WRITE_COMBINE, attrs) ?
 			    pgprot_writecombine(prot) :
@@ -732,7 +731,7 @@ static struct arm_dma_allocator remap_allocator = {
 
 static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 			 gfp_t gfp, pgprot_t prot, bool is_coherent,
-			 struct dma_attrs *attrs, const void *caller)
+			 unsigned long attrs, const void *caller)
 {
 	u64 mask = get_coherent_dma_mask(dev);
 	struct page *page = NULL;
@@ -814,7 +813,7 @@ static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
  * virtual and bus address for that space.
  */
 void *arm_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
-		    gfp_t gfp, struct dma_attrs *attrs)
+		    gfp_t gfp, unsigned long attrs)
 {
 	pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL);
 
@@ -823,7 +822,7 @@ void *arm_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 }
 
 static void *arm_coherent_dma_alloc(struct device *dev, size_t size,
-	dma_addr_t *handle, gfp_t gfp, struct dma_attrs *attrs)
+	dma_addr_t *handle, gfp_t gfp, unsigned long attrs)
 {
 	return __dma_alloc(dev, size, handle, gfp, PAGE_KERNEL, true,
 			   attrs, __builtin_return_address(0));
@@ -831,7 +830,7 @@ static void *arm_coherent_dma_alloc(struct device *dev, size_t size,
 
 static int __arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 		 void *cpu_addr, dma_addr_t dma_addr, size_t size,
-		 struct dma_attrs *attrs)
+		 unsigned long attrs)
 {
 	int ret = -ENXIO;
 #ifdef CONFIG_MMU
@@ -859,14 +858,14 @@ static int __arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
  */
 static int arm_coherent_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 		 void *cpu_addr, dma_addr_t dma_addr, size_t size,
-		 struct dma_attrs *attrs)
+		 unsigned long attrs)
 {
 	return __arm_dma_mmap(dev, vma, cpu_addr, dma_addr, size, attrs);
 }
 
 int arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 		 void *cpu_addr, dma_addr_t dma_addr, size_t size,
-		 struct dma_attrs *attrs)
+		 unsigned long attrs)
 {
 #ifdef CONFIG_MMU
 	vma->vm_page_prot = __get_dma_pgprot(attrs, vma->vm_page_prot);
@@ -878,7 +877,7 @@ int arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
  * Free a buffer as defined by the above mapping.
  */
 static void __arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
-			   dma_addr_t handle, struct dma_attrs *attrs,
+			   dma_addr_t handle, unsigned long attrs,
 			   bool is_coherent)
 {
 	struct page *page = pfn_to_page(dma_to_pfn(dev, handle));
@@ -900,20 +899,20 @@ static void __arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
 }
 
 void arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
-		  dma_addr_t handle, struct dma_attrs *attrs)
+		  dma_addr_t handle, unsigned long attrs)
 {
 	__arm_dma_free(dev, size, cpu_addr, handle, attrs, false);
 }
 
 static void arm_coherent_dma_free(struct device *dev, size_t size, void *cpu_addr,
-				  dma_addr_t handle, struct dma_attrs *attrs)
+				  dma_addr_t handle, unsigned long attrs)
 {
 	__arm_dma_free(dev, size, cpu_addr, handle, attrs, true);
 }
 
 int arm_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
 		 void *cpu_addr, dma_addr_t handle, size_t size,
-		 struct dma_attrs *attrs)
+		 unsigned long attrs)
 {
 	struct page *page = pfn_to_page(dma_to_pfn(dev, handle));
 	int ret;
@@ -1046,7 +1045,7 @@ static void __dma_page_dev_to_cpu(struct page *page, unsigned long off,
  * here.
  */
 int arm_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
-		enum dma_data_direction dir, struct dma_attrs *attrs)
+		enum dma_data_direction dir, unsigned long attrs)
 {
 	struct dma_map_ops *ops = get_dma_ops(dev);
 	struct scatterlist *s;
@@ -1080,7 +1079,7 @@ int arm_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
  * rules concerning calls here are the same as for dma_unmap_single().
  */
 void arm_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
-		enum dma_data_direction dir, struct dma_attrs *attrs)
+		enum dma_data_direction dir, unsigned long attrs)
 {
 	struct dma_map_ops *ops = get_dma_ops(dev);
 	struct scatterlist *s;
@@ -1253,7 +1252,7 @@ static inline void __free_iova(struct dma_iommu_mapping *mapping,
 static const int iommu_order_array[] = { 9, 8, 4, 0 };
 
 static struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
-					  gfp_t gfp, struct dma_attrs *attrs)
+					  gfp_t gfp, unsigned long attrs)
 {
 	struct page **pages;
 	int count = size >> PAGE_SHIFT;
@@ -1342,7 +1341,7 @@ error:
 }
 
 static int __iommu_free_buffer(struct device *dev, struct page **pages,
-			       size_t size, struct dma_attrs *attrs)
+			       size_t size, unsigned long attrs)
 {
 	int count = size >> PAGE_SHIFT;
 	int i;
@@ -1439,7 +1438,7 @@ static struct page **__atomic_get_pages(void *addr)
 	return (struct page **)page;
 }
 
-static struct page **__iommu_get_pages(void *cpu_addr, struct dma_attrs *attrs)
+static struct page **__iommu_get_pages(void *cpu_addr, unsigned long attrs)
 {
 	struct vm_struct *area;
 
@@ -1484,7 +1483,7 @@ static void __iommu_free_atomic(struct device *dev, void *cpu_addr,
 }
 
 static void *arm_iommu_alloc_attrs(struct device *dev, size_t size,
-	    dma_addr_t *handle, gfp_t gfp, struct dma_attrs *attrs)
+	    dma_addr_t *handle, gfp_t gfp, unsigned long attrs)
 {
 	pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL);
 	struct page **pages;
@@ -1532,7 +1531,7 @@ err_buffer:
 
 static int arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
 		    void *cpu_addr, dma_addr_t dma_addr, size_t size,
-		    struct dma_attrs *attrs)
+		    unsigned long attrs)
 {
 	unsigned long uaddr = vma->vm_start;
 	unsigned long usize = vma->vm_end - vma->vm_start;
@@ -1568,7 +1567,7 @@ static int arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
  * Must not be called with IRQs disabled.
  */
 void arm_iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
-			  dma_addr_t handle, struct dma_attrs *attrs)
+			  dma_addr_t handle, unsigned long attrs)
 {
 	struct page **pages;
 	size = PAGE_ALIGN(size);
@@ -1595,7 +1594,7 @@ void arm_iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
 
 static int arm_iommu_get_sgtable(struct device *dev, struct sg_table *sgt,
 				 void *cpu_addr, dma_addr_t dma_addr,
-				 size_t size, struct dma_attrs *attrs)
+				 size_t size, unsigned long attrs)
 {
 	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	struct page **pages = __iommu_get_pages(cpu_addr, attrs);
@@ -1633,7 +1632,7 @@ static int __dma_direction_to_prot(enum dma_data_direction dir)
  */
 static int __map_sg_chunk(struct device *dev, struct scatterlist *sg,
 			  size_t size, dma_addr_t *handle,
-			  enum dma_data_direction dir, struct dma_attrs *attrs,
+			  enum dma_data_direction dir, unsigned long attrs,
 			  bool is_coherent)
 {
 	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
@@ -1676,7 +1675,7 @@ fail:
 }
 
 static int __iommu_map_sg(struct device *dev, struct scatterlist *sg, int nents,
-		     enum dma_data_direction dir, struct dma_attrs *attrs,
+		     enum dma_data_direction dir, unsigned long attrs,
 		     bool is_coherent)
 {
 	struct scatterlist *s = sg, *dma = sg, *start = sg;
@@ -1734,7 +1733,7 @@ bad_mapping:
  * obtained via sg_dma_{address,length}.
  */
 int arm_coherent_iommu_map_sg(struct device *dev, struct scatterlist *sg,
-		int nents, enum dma_data_direction dir, struct dma_attrs *attrs)
+		int nents, enum dma_data_direction dir, unsigned long attrs)
 {
 	return __iommu_map_sg(dev, sg, nents, dir, attrs, true);
 }
@@ -1752,14 +1751,14 @@ int arm_coherent_iommu_map_sg(struct device *dev, struct scatterlist *sg,
  * sg_dma_{address,length}.
  */
 int arm_iommu_map_sg(struct device *dev, struct scatterlist *sg,
-		int nents, enum dma_data_direction dir, struct dma_attrs *attrs)
+		int nents, enum dma_data_direction dir, unsigned long attrs)
 {
 	return __iommu_map_sg(dev, sg, nents, dir, attrs, false);
 }
 
 static void __iommu_unmap_sg(struct device *dev, struct scatterlist *sg,
-		int nents, enum dma_data_direction dir, struct dma_attrs *attrs,
-		bool is_coherent)
+		int nents, enum dma_data_direction dir,
+		unsigned long attrs, bool is_coherent)
 {
 	struct scatterlist *s;
 	int i;
@@ -1786,7 +1785,8 @@ static void __iommu_unmap_sg(struct device *dev, struct scatterlist *sg,
  * rules concerning calls here are the same as for dma_unmap_single().
  */
 void arm_coherent_iommu_unmap_sg(struct device *dev, struct scatterlist *sg,
-		int nents, enum dma_data_direction dir, struct dma_attrs *attrs)
+		int nents, enum dma_data_direction dir,
+		unsigned long attrs)
 {
 	__iommu_unmap_sg(dev, sg, nents, dir, attrs, true);
 }
@@ -1802,7 +1802,8 @@ void arm_coherent_iommu_unmap_sg(struct device *dev, struct scatterlist *sg,
  * rules concerning calls here are the same as for dma_unmap_single().
  */
 void arm_iommu_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
-			enum dma_data_direction dir, struct dma_attrs *attrs)
+			enum dma_data_direction dir,
+			unsigned long attrs)
 {
 	__iommu_unmap_sg(dev, sg, nents, dir, attrs, false);
 }
@@ -1855,7 +1856,7 @@ void arm_iommu_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
  */
 static dma_addr_t arm_coherent_iommu_map_page(struct device *dev, struct page *page,
 	     unsigned long offset, size_t size, enum dma_data_direction dir,
-	     struct dma_attrs *attrs)
+	     unsigned long attrs)
 {
 	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
 	dma_addr_t dma_addr;
@@ -1889,7 +1890,7 @@ fail:
  */
 static dma_addr_t arm_iommu_map_page(struct device *dev, struct page *page,
 	     unsigned long offset, size_t size, enum dma_data_direction dir,
-	     struct dma_attrs *attrs)
+	     unsigned long attrs)
 {
 	if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
 		__dma_page_cpu_to_dev(page, offset, size, dir);
@@ -1907,8 +1908,7 @@ static dma_addr_t arm_iommu_map_page(struct device *dev, struct page *page,
  * Coherent IOMMU aware version of arm_dma_unmap_page()
  */
 static void arm_coherent_iommu_unmap_page(struct device *dev, dma_addr_t handle,
-		size_t size, enum dma_data_direction dir,
-		struct dma_attrs *attrs)
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
 	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
 	dma_addr_t iova = handle & PAGE_MASK;
@@ -1932,8 +1932,7 @@ static void arm_coherent_iommu_unmap_page(struct device *dev, dma_addr_t handle,
  * IOMMU aware version of arm_dma_unmap_page()
  */
 static void arm_iommu_unmap_page(struct device *dev, dma_addr_t handle,
-		size_t size, enum dma_data_direction dir,
-		struct dma_attrs *attrs)
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
 	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
 	dma_addr_t iova = handle & PAGE_MASK;
diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
index c5f9a9e3d1f3..fc67ed236a10 100644
--- a/arch/arm/xen/mm.c
+++ b/arch/arm/xen/mm.c
@@ -98,7 +98,7 @@ static void __xen_dma_page_cpu_to_dev(struct device *hwdev, dma_addr_t handle,
 
 void __xen_dma_map_page(struct device *hwdev, struct page *page,
 	     dma_addr_t dev_addr, unsigned long offset, size_t size,
-	     enum dma_data_direction dir, struct dma_attrs *attrs)
+	     enum dma_data_direction dir, unsigned long attrs)
 {
 	if (is_device_dma_coherent(hwdev))
 		return;
@@ -110,7 +110,7 @@ void __xen_dma_map_page(struct device *hwdev, struct page *page,
 
 void __xen_dma_unmap_page(struct device *hwdev, dma_addr_t handle,
 		size_t size, enum dma_data_direction dir,
-		struct dma_attrs *attrs)
+		unsigned long attrs)
 
 {
 	if (is_device_dma_coherent(hwdev))
-- 
1.9.1
