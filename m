Return-Path: <k.kozlowski@samsung.com>
Received: from mailout3.w1.samsung.com (mailout3.w1.samsung.com
 [210.118.77.13])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rLBJL2W8XzDqgj
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jun 2016 01:40:34 +1000 (AEST)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0O85008L8I7JD710@mailout3.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Thu, 02 Jun 2016 16:40:32 +0100 (BST)
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
Subject: [RFC v3 02/45] dma-mapping: Use unsigned long for dma_attrs
Date: Thu, 02 Jun 2016 17:39:04 +0200
Message-id: <1464881987-13203-3-git-send-email-k.kozlowski@samsung.com>
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

The dma-mapping core and the implementations do not change the
DMA attributes passed by pointer.  Thus the pointer can point to const
data.  However the attributes do not have to be a bitfield. Instead
unsigned long will do fine:

1. This is just simpler.  Both in terms of reading the code and setting
   attributes.  Instead of initializing local attributes on the stack
   and passing pointer to it to dma_set_attr(), just set the bits.

2. It brings safeness and checking for const correctness because the
   attributes are passed by value.

Semantic patches for this change (at least most of them):
===
virtual patch
virtual context

@r@
identifier f, attrs;

@@
f(...,
- struct dma_attrs *attrs
+ unsigned long attrs
, ...)
{
...
}

@@
identifier r.f;
@@
f(...,
- NULL
+ 0
 )
===
// Options: --all-includes
virtual patch
virtual context

@r@
identifier f, attrs;
type t;

@@
t f(..., struct dma_attrs *attrs);

@@
identifier r.f;
@@
f(...,
- NULL
+ 0
 )
===

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 Documentation/DMA-API.txt        |  29 +++++------
 Documentation/DMA-attributes.txt |   2 +-
 include/linux/dma-attrs.h        |  71 -------------------------
 include/linux/dma-mapping.h      | 108 +++++++++++++++++++++++----------------
 lib/dma-noop.c                   |   9 ++--
 5 files changed, 83 insertions(+), 136 deletions(-)
 delete mode 100644 include/linux/dma-attrs.h

diff --git a/Documentation/DMA-API.txt b/Documentation/DMA-API.txt
index 45ef3f279c3b..24f9688bb98a 100644
--- a/Documentation/DMA-API.txt
+++ b/Documentation/DMA-API.txt
@@ -369,35 +369,32 @@ See also dma_map_single().
 dma_addr_t
 dma_map_single_attrs(struct device *dev, void *cpu_addr, size_t size,
 		     enum dma_data_direction dir,
-		     struct dma_attrs *attrs)
+		     unsigned long attrs)
 
 void
 dma_unmap_single_attrs(struct device *dev, dma_addr_t dma_addr,
 		       size_t size, enum dma_data_direction dir,
-		       struct dma_attrs *attrs)
+		       unsigned long attrs)
 
 int
 dma_map_sg_attrs(struct device *dev, struct scatterlist *sgl,
 		 int nents, enum dma_data_direction dir,
-		 struct dma_attrs *attrs)
+		 unsigned long attrs)
 
 void
 dma_unmap_sg_attrs(struct device *dev, struct scatterlist *sgl,
 		   int nents, enum dma_data_direction dir,
-		   struct dma_attrs *attrs)
+		   unsigned long attrs)
 
 The four functions above are just like the counterpart functions
 without the _attrs suffixes, except that they pass an optional
-struct dma_attrs*.
-
-struct dma_attrs encapsulates a set of "DMA attributes". For the
-definition of struct dma_attrs see linux/dma-attrs.h.
+dma_attrs.
 
 The interpretation of DMA attributes is architecture-specific, and
 each attribute should be documented in Documentation/DMA-attributes.txt.
 
-If struct dma_attrs* is NULL, the semantics of each of these
-functions is identical to those of the corresponding function
+If dma_attrs are 0, the semantics of each of these functions
+is identical to those of the corresponding function
 without the _attrs suffix. As a result dma_map_single_attrs()
 can generally replace dma_map_single(), etc.
 
@@ -405,15 +402,15 @@ As an example of the use of the *_attrs functions, here's how
 you could pass an attribute DMA_ATTR_FOO when mapping memory
 for DMA:
 
-#include <linux/dma-attrs.h>
-/* DMA_ATTR_FOO should be defined in linux/dma-attrs.h and
+#include <linux/dma-mapping.h>
+/* DMA_ATTR_FOO should be defined in linux/dma-mapping.h and
  * documented in Documentation/DMA-attributes.txt */
 ...
 
-	DEFINE_DMA_ATTRS(attrs);
-	dma_set_attr(DMA_ATTR_FOO, &attrs);
+	unsigned long attr;
+	attr |= DMA_ATTR_FOO;
 	....
-	n = dma_map_sg_attrs(dev, sg, nents, DMA_TO_DEVICE, &attr);
+	n = dma_map_sg_attrs(dev, sg, nents, DMA_TO_DEVICE, attr);
 	....
 
 Architectures that care about DMA_ATTR_FOO would check for its
@@ -422,7 +419,7 @@ routines, e.g.:
 
 void whizco_dma_map_sg_attrs(struct device *dev, dma_addr_t dma_addr,
 			     size_t size, enum dma_data_direction dir,
-			     struct dma_attrs *attrs)
+			     unsigned long attrs)
 {
 	....
 	int foo =  dma_get_attr(DMA_ATTR_FOO, attrs);
diff --git a/Documentation/DMA-attributes.txt b/Documentation/DMA-attributes.txt
index e8cf9cf873b3..2d455a5cf671 100644
--- a/Documentation/DMA-attributes.txt
+++ b/Documentation/DMA-attributes.txt
@@ -2,7 +2,7 @@
 			==============
 
 This document describes the semantics of the DMA attributes that are
-defined in linux/dma-attrs.h.
+defined in linux/dma-mapping.h.
 
 DMA_ATTR_WRITE_BARRIER
 ----------------------
diff --git a/include/linux/dma-attrs.h b/include/linux/dma-attrs.h
deleted file mode 100644
index 5246239a4953..000000000000
--- a/include/linux/dma-attrs.h
+++ /dev/null
@@ -1,71 +0,0 @@
-#ifndef _DMA_ATTR_H
-#define _DMA_ATTR_H
-
-#include <linux/bitmap.h>
-#include <linux/bitops.h>
-#include <linux/bug.h>
-
-/**
- * an enum dma_attr represents an attribute associated with a DMA
- * mapping. The semantics of each attribute should be defined in
- * Documentation/DMA-attributes.txt.
- */
-enum dma_attr {
-	DMA_ATTR_WRITE_BARRIER,
-	DMA_ATTR_WEAK_ORDERING,
-	DMA_ATTR_WRITE_COMBINE,
-	DMA_ATTR_NON_CONSISTENT,
-	DMA_ATTR_NO_KERNEL_MAPPING,
-	DMA_ATTR_SKIP_CPU_SYNC,
-	DMA_ATTR_FORCE_CONTIGUOUS,
-	DMA_ATTR_ALLOC_SINGLE_PAGES,
-	DMA_ATTR_MAX,
-};
-
-#define __DMA_ATTRS_LONGS BITS_TO_LONGS(DMA_ATTR_MAX)
-
-/**
- * struct dma_attrs - an opaque container for DMA attributes
- * @flags - bitmask representing a collection of enum dma_attr
- */
-struct dma_attrs {
-	unsigned long flags[__DMA_ATTRS_LONGS];
-};
-
-#define DEFINE_DMA_ATTRS(x) 					\
-	struct dma_attrs x = {					\
-		.flags = { [0 ... __DMA_ATTRS_LONGS-1] = 0 },	\
-	}
-
-static inline void init_dma_attrs(struct dma_attrs *attrs)
-{
-	bitmap_zero(attrs->flags, __DMA_ATTRS_LONGS);
-}
-
-/**
- * dma_set_attr - set a specific attribute
- * @attr: attribute to set
- * @attrs: struct dma_attrs (may be NULL)
- */
-static inline void dma_set_attr(enum dma_attr attr, struct dma_attrs *attrs)
-{
-	if (attrs == NULL)
-		return;
-	BUG_ON(attr >= DMA_ATTR_MAX);
-	__set_bit(attr, attrs->flags);
-}
-
-/**
- * dma_get_attr - check for a specific attribute
- * @attr: attribute to set
- * @attrs: struct dma_attrs (may be NULL)
- */
-static inline int dma_get_attr(enum dma_attr attr, struct dma_attrs *attrs)
-{
-	if (attrs == NULL)
-		return 0;
-	BUG_ON(attr >= DMA_ATTR_MAX);
-	return test_bit(attr, attrs->flags);
-}
-
-#endif /* _DMA_ATTR_H */
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 71c1b215ef66..b752b9ccec78 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -5,13 +5,25 @@
 #include <linux/string.h>
 #include <linux/device.h>
 #include <linux/err.h>
-#include <linux/dma-attrs.h>
 #include <linux/dma-debug.h>
 #include <linux/dma-direction.h>
 #include <linux/scatterlist.h>
 #include <linux/kmemcheck.h>
 #include <linux/bug.h>
 
+/**
+ * List of possible attributes associated with a DMA mapping. The semantics
+ * of each attribute should be defined in Documentation/DMA-attributes.txt.
+ */
+#define DMA_ATTR_WRITE_BARRIER		(1UL << 1)
+#define DMA_ATTR_WEAK_ORDERING		(1UL << 2)
+#define DMA_ATTR_WRITE_COMBINE		(1UL << 3)
+#define DMA_ATTR_NON_CONSISTENT		(1UL << 4)
+#define DMA_ATTR_NO_KERNEL_MAPPING	(1UL << 5)
+#define DMA_ATTR_SKIP_CPU_SYNC		(1UL << 6)
+#define DMA_ATTR_FORCE_CONTIGUOUS	(1UL << 7)
+#define DMA_ATTR_ALLOC_SINGLE_PAGES	(1UL << 8)
+
 /*
  * A dma_addr_t can hold any valid DMA or bus address for the platform.
  * It can be given to a device to use as a DMA source or target.  A CPU cannot
@@ -21,34 +33,35 @@
 struct dma_map_ops {
 	void* (*alloc)(struct device *dev, size_t size,
 				dma_addr_t *dma_handle, gfp_t gfp,
-				struct dma_attrs *attrs);
+				unsigned long attrs);
 	void (*free)(struct device *dev, size_t size,
 			      void *vaddr, dma_addr_t dma_handle,
-			      struct dma_attrs *attrs);
+			      unsigned long attrs);
 	int (*mmap)(struct device *, struct vm_area_struct *,
-			  void *, dma_addr_t, size_t, struct dma_attrs *attrs);
+			  void *, dma_addr_t, size_t,
+			  unsigned long attrs);
 
 	int (*get_sgtable)(struct device *dev, struct sg_table *sgt, void *,
-			   dma_addr_t, size_t, struct dma_attrs *attrs);
+			   dma_addr_t, size_t, unsigned long attrs);
 
 	dma_addr_t (*map_page)(struct device *dev, struct page *page,
 			       unsigned long offset, size_t size,
 			       enum dma_data_direction dir,
-			       struct dma_attrs *attrs);
+			       unsigned long attrs);
 	void (*unmap_page)(struct device *dev, dma_addr_t dma_handle,
 			   size_t size, enum dma_data_direction dir,
-			   struct dma_attrs *attrs);
+			   unsigned long attrs);
 	/*
 	 * map_sg returns 0 on error and a value > 0 on success.
 	 * It should never return a value < 0.
 	 */
 	int (*map_sg)(struct device *dev, struct scatterlist *sg,
 		      int nents, enum dma_data_direction dir,
-		      struct dma_attrs *attrs);
+		      unsigned long attrs);
 	void (*unmap_sg)(struct device *dev,
 			 struct scatterlist *sg, int nents,
 			 enum dma_data_direction dir,
-			 struct dma_attrs *attrs);
+			 unsigned long attrs);
 	void (*sync_single_for_cpu)(struct device *dev,
 				    dma_addr_t dma_handle, size_t size,
 				    enum dma_data_direction dir);
@@ -88,6 +101,19 @@ static inline int is_device_dma_capable(struct device *dev)
 	return dev->dma_mask != NULL && *dev->dma_mask != DMA_MASK_NONE;
 }
 
+/**
+ * dma_get_attr - check for a specific attribute
+ * @attr: attribute to look for
+ * @attrs: attributes to check within
+ *
+ * Unlike all other dma-mapping functions, this one gets pointer to
+ * attributes (for old-code compatiblity reasons).
+ */
+static inline bool dma_get_attr(unsigned long attr, unsigned long attrs)
+{
+	return !!(attr & attrs);
+}
+
 #ifdef CONFIG_HAVE_GENERIC_DMA_COHERENT
 /*
  * These three functions are only for dma allocator.
@@ -123,7 +149,7 @@ static inline struct dma_map_ops *get_dma_ops(struct device *dev)
 static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
 					      size_t size,
 					      enum dma_data_direction dir,
-					      struct dma_attrs *attrs)
+					      unsigned long attrs)
 {
 	struct dma_map_ops *ops = get_dma_ops(dev);
 	dma_addr_t addr;
@@ -142,7 +168,7 @@ static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
 static inline void dma_unmap_single_attrs(struct device *dev, dma_addr_t addr,
 					  size_t size,
 					  enum dma_data_direction dir,
-					  struct dma_attrs *attrs)
+					  unsigned long attrs)
 {
 	struct dma_map_ops *ops = get_dma_ops(dev);
 
@@ -158,7 +184,7 @@ static inline void dma_unmap_single_attrs(struct device *dev, dma_addr_t addr,
  */
 static inline int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 				   int nents, enum dma_data_direction dir,
-				   struct dma_attrs *attrs)
+				   unsigned long attrs)
 {
 	struct dma_map_ops *ops = get_dma_ops(dev);
 	int i, ents;
@@ -176,7 +202,7 @@ static inline int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 
 static inline void dma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
 				      int nents, enum dma_data_direction dir,
-				      struct dma_attrs *attrs)
+				      unsigned long attrs)
 {
 	struct dma_map_ops *ops = get_dma_ops(dev);
 
@@ -195,7 +221,7 @@ static inline dma_addr_t dma_map_page(struct device *dev, struct page *page,
 
 	kmemcheck_mark_initialized(page_address(page) + offset, size);
 	BUG_ON(!valid_dma_direction(dir));
-	addr = ops->map_page(dev, page, offset, size, dir, NULL);
+	addr = ops->map_page(dev, page, offset, size, dir, 0);
 	debug_dma_map_page(dev, page, offset, size, dir, addr, false);
 
 	return addr;
@@ -208,7 +234,7 @@ static inline void dma_unmap_page(struct device *dev, dma_addr_t addr,
 
 	BUG_ON(!valid_dma_direction(dir));
 	if (ops->unmap_page)
-		ops->unmap_page(dev, addr, size, dir, NULL);
+		ops->unmap_page(dev, addr, size, dir, 0);
 	debug_dma_unmap_page(dev, addr, size, dir, false);
 }
 
@@ -289,10 +315,10 @@ dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 
 }
 
-#define dma_map_single(d, a, s, r) dma_map_single_attrs(d, a, s, r, NULL)
-#define dma_unmap_single(d, a, s, r) dma_unmap_single_attrs(d, a, s, r, NULL)
-#define dma_map_sg(d, s, n, r) dma_map_sg_attrs(d, s, n, r, NULL)
-#define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, NULL)
+#define dma_map_single(d, a, s, r) dma_map_single_attrs(d, a, s, r, 0)
+#define dma_unmap_single(d, a, s, r) dma_unmap_single_attrs(d, a, s, r, 0)
+#define dma_map_sg(d, s, n, r) dma_map_sg_attrs(d, s, n, r, 0)
+#define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, 0)
 
 extern int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
 			   void *cpu_addr, dma_addr_t dma_addr, size_t size);
@@ -321,7 +347,7 @@ void dma_common_free_remap(void *cpu_addr, size_t size, unsigned long vm_flags);
  */
 static inline int
 dma_mmap_attrs(struct device *dev, struct vm_area_struct *vma, void *cpu_addr,
-	       dma_addr_t dma_addr, size_t size, struct dma_attrs *attrs)
+	       dma_addr_t dma_addr, size_t size, unsigned long attrs)
 {
 	struct dma_map_ops *ops = get_dma_ops(dev);
 	BUG_ON(!ops);
@@ -330,7 +356,7 @@ dma_mmap_attrs(struct device *dev, struct vm_area_struct *vma, void *cpu_addr,
 	return dma_common_mmap(dev, vma, cpu_addr, dma_addr, size);
 }
 
-#define dma_mmap_coherent(d, v, c, h, s) dma_mmap_attrs(d, v, c, h, s, NULL)
+#define dma_mmap_coherent(d, v, c, h, s) dma_mmap_attrs(d, v, c, h, s, 0)
 
 int
 dma_common_get_sgtable(struct device *dev, struct sg_table *sgt,
@@ -338,7 +364,8 @@ dma_common_get_sgtable(struct device *dev, struct sg_table *sgt,
 
 static inline int
 dma_get_sgtable_attrs(struct device *dev, struct sg_table *sgt, void *cpu_addr,
-		      dma_addr_t dma_addr, size_t size, struct dma_attrs *attrs)
+		      dma_addr_t dma_addr, size_t size,
+		      unsigned long attrs)
 {
 	struct dma_map_ops *ops = get_dma_ops(dev);
 	BUG_ON(!ops);
@@ -348,7 +375,7 @@ dma_get_sgtable_attrs(struct device *dev, struct sg_table *sgt, void *cpu_addr,
 	return dma_common_get_sgtable(dev, sgt, cpu_addr, dma_addr, size);
 }
 
-#define dma_get_sgtable(d, t, v, h, s) dma_get_sgtable_attrs(d, t, v, h, s, NULL)
+#define dma_get_sgtable(d, t, v, h, s) dma_get_sgtable_attrs(d, t, v, h, s, 0)
 
 #ifndef arch_dma_alloc_attrs
 #define arch_dma_alloc_attrs(dev, flag)	(true)
@@ -356,7 +383,7 @@ dma_get_sgtable_attrs(struct device *dev, struct sg_table *sgt, void *cpu_addr,
 
 static inline void *dma_alloc_attrs(struct device *dev, size_t size,
 				       dma_addr_t *dma_handle, gfp_t flag,
-				       struct dma_attrs *attrs)
+				       unsigned long attrs)
 {
 	struct dma_map_ops *ops = get_dma_ops(dev);
 	void *cpu_addr;
@@ -378,7 +405,7 @@ static inline void *dma_alloc_attrs(struct device *dev, size_t size,
 
 static inline void dma_free_attrs(struct device *dev, size_t size,
 				     void *cpu_addr, dma_addr_t dma_handle,
-				     struct dma_attrs *attrs)
+				     unsigned long attrs)
 {
 	struct dma_map_ops *ops = get_dma_ops(dev);
 
@@ -398,31 +425,27 @@ static inline void dma_free_attrs(struct device *dev, size_t size,
 static inline void *dma_alloc_coherent(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t flag)
 {
-	return dma_alloc_attrs(dev, size, dma_handle, flag, NULL);
+	return dma_alloc_attrs(dev, size, dma_handle, flag, 0);
 }
 
 static inline void dma_free_coherent(struct device *dev, size_t size,
 		void *cpu_addr, dma_addr_t dma_handle)
 {
-	return dma_free_attrs(dev, size, cpu_addr, dma_handle, NULL);
+	return dma_free_attrs(dev, size, cpu_addr, dma_handle, 0);
 }
 
 static inline void *dma_alloc_noncoherent(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp)
 {
-	DEFINE_DMA_ATTRS(attrs);
-
-	dma_set_attr(DMA_ATTR_NON_CONSISTENT, &attrs);
-	return dma_alloc_attrs(dev, size, dma_handle, gfp, &attrs);
+	return dma_alloc_attrs(dev, size, dma_handle, gfp,
+			       DMA_ATTR_NON_CONSISTENT);
 }
 
 static inline void dma_free_noncoherent(struct device *dev, size_t size,
 		void *cpu_addr, dma_addr_t dma_handle)
 {
-	DEFINE_DMA_ATTRS(attrs);
-
-	dma_set_attr(DMA_ATTR_NON_CONSISTENT, &attrs);
-	dma_free_attrs(dev, size, cpu_addr, dma_handle, &attrs);
+	dma_free_attrs(dev, size, cpu_addr, dma_handle,
+		       DMA_ATTR_NON_CONSISTENT);
 }
 
 static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
@@ -646,9 +669,8 @@ static inline void dmam_release_declared_memory(struct device *dev)
 static inline void *dma_alloc_wc(struct device *dev, size_t size,
 				 dma_addr_t *dma_addr, gfp_t gfp)
 {
-	DEFINE_DMA_ATTRS(attrs);
-	dma_set_attr(DMA_ATTR_WRITE_COMBINE, &attrs);
-	return dma_alloc_attrs(dev, size, dma_addr, gfp, &attrs);
+	return dma_alloc_attrs(dev, size, dma_addr, gfp,
+			       DMA_ATTR_WRITE_COMBINE);
 }
 #ifndef dma_alloc_writecombine
 #define dma_alloc_writecombine dma_alloc_wc
@@ -657,9 +679,8 @@ static inline void *dma_alloc_wc(struct device *dev, size_t size,
 static inline void dma_free_wc(struct device *dev, size_t size,
 			       void *cpu_addr, dma_addr_t dma_addr)
 {
-	DEFINE_DMA_ATTRS(attrs);
-	dma_set_attr(DMA_ATTR_WRITE_COMBINE, &attrs);
-	return dma_free_attrs(dev, size, cpu_addr, dma_addr, &attrs);
+	return dma_free_attrs(dev, size, cpu_addr, dma_addr,
+			      DMA_ATTR_WRITE_COMBINE);
 }
 #ifndef dma_free_writecombine
 #define dma_free_writecombine dma_free_wc
@@ -670,9 +691,8 @@ static inline int dma_mmap_wc(struct device *dev,
 			      void *cpu_addr, dma_addr_t dma_addr,
 			      size_t size)
 {
-	DEFINE_DMA_ATTRS(attrs);
-	dma_set_attr(DMA_ATTR_WRITE_COMBINE, &attrs);
-	return dma_mmap_attrs(dev, vma, cpu_addr, dma_addr, size, &attrs);
+	return dma_mmap_attrs(dev, vma, cpu_addr, dma_addr, size,
+			      DMA_ATTR_WRITE_COMBINE);
 }
 #ifndef dma_mmap_writecombine
 #define dma_mmap_writecombine dma_mmap_wc
diff --git a/lib/dma-noop.c b/lib/dma-noop.c
index 72145646857e..3d766e78fbe2 100644
--- a/lib/dma-noop.c
+++ b/lib/dma-noop.c
@@ -10,7 +10,7 @@
 
 static void *dma_noop_alloc(struct device *dev, size_t size,
 			    dma_addr_t *dma_handle, gfp_t gfp,
-			    struct dma_attrs *attrs)
+			    unsigned long attrs)
 {
 	void *ret;
 
@@ -22,7 +22,7 @@ static void *dma_noop_alloc(struct device *dev, size_t size,
 
 static void dma_noop_free(struct device *dev, size_t size,
 			  void *cpu_addr, dma_addr_t dma_addr,
-			  struct dma_attrs *attrs)
+			  unsigned long attrs)
 {
 	free_pages((unsigned long)cpu_addr, get_order(size));
 }
@@ -30,13 +30,14 @@ static void dma_noop_free(struct device *dev, size_t size,
 static dma_addr_t dma_noop_map_page(struct device *dev, struct page *page,
 				      unsigned long offset, size_t size,
 				      enum dma_data_direction dir,
-				      struct dma_attrs *attrs)
+				      unsigned long attrs)
 {
 	return page_to_phys(page) + offset;
 }
 
 static int dma_noop_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
-			     enum dma_data_direction dir, struct dma_attrs *attrs)
+			     enum dma_data_direction dir,
+			     unsigned long attrs)
 {
 	int i;
 	struct scatterlist *sg;
-- 
1.9.1
