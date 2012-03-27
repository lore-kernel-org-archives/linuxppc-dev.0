Return-Path: <m.szyprowski@samsung.com>
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11]) by ozlabs.org (Postfix) with ESMTP id 21126B6F6E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2012 00:43:52 +1100 (EST)
Received: from euspt2 (mailout1.w1.samsung.com [210.118.77.11])
 by mailout1.w1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0M1J00BZ2Q3ILC@mailout1.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Tue, 27 Mar 2012 14:42:55 +0100 (BST)
Received: from linux.samsung.com ([106.116.38.10])
 by spt2.w1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
 2004)) with ESMTPA id <0M1J0022UQ491V@spt2.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Tue, 27 Mar 2012 14:43:23 +0100 (BST)
Date: Tue, 27 Mar 2012 15:42:39 +0200
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCHv2 05/14] SPARC: adapt for dma_map_ops changes
In-reply-to: <1332855768-32583-1-git-send-email-m.szyprowski@samsung.com>
To: linux-kernel@vger.kernel.org
Message-id: <1332855768-32583-6-git-send-email-m.szyprowski@samsung.com>
MIME-version: 1.0
Content-type: TEXT/PLAIN
References: <1332855768-32583-1-git-send-email-m.szyprowski@samsung.com>
Cc: linux-mips@linux-mips.org, Kevin Cernekee <cernekee@gmail.com>,
 linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, linux-mm@kvack.org,
 sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Marek Szyprowski <m.szyprowski@samsung.com>, linux-arch@vger.kernel.org,
 Stephen Rothwell <sfr@canb.auug.org.au>, Jonathan Corbet <corbet@lwn.net>,
 x86@kernel.org, Matt Turner <mattst88@gmail.com>,
 Dezhong Diao <dediao@cisco.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Arnd Bergmann <arnd@arndb.de>, microblaze-uclinux@itee.uq.edu.au,
 linaro-mm-sig@lists.linaro.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Richard Henderson <rth@twiddle.net>, discuss@x86-64.org,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 Richard Kuo <rkuo@codeaurora.org>,
 FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
 Kyungmin Park <kyungmin.park@samsung.com>, Paul Mundt <lethal@linux-sh.org>,
 linux-alpha@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Andrzej Pietrasiewicz <andrzej.p@samsung.com>

Adapt core SPARC architecture code for dma_map_ops changes: replace
alloc/free_coherent with generic alloc/free methods.

Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/dma-mapping.h |   18 ++++++++++++------
 arch/sparc/kernel/iommu.c            |   10 ++++++----
 arch/sparc/kernel/ioport.c           |   18 ++++++++++--------
 arch/sparc/kernel/pci_sun4v.c        |    9 +++++----
 4 files changed, 33 insertions(+), 22 deletions(-)

diff --git a/arch/sparc/include/asm/dma-mapping.h b/arch/sparc/include/asm/dma-mapping.h
index 8c0e4f7..48a7c65 100644
--- a/arch/sparc/include/asm/dma-mapping.h
+++ b/arch/sparc/include/asm/dma-mapping.h
@@ -26,24 +26,30 @@ static inline struct dma_map_ops *get_dma_ops(struct device *dev)
 
 #include <asm-generic/dma-mapping-common.h>
 
-static inline void *dma_alloc_coherent(struct device *dev, size_t size,
-				       dma_addr_t *dma_handle, gfp_t flag)
+#define dma_alloc_coherent(d,s,h,f)	dma_alloc_attrs(d,s,h,f,NULL)
+
+static inline void *dma_alloc_attrs(struct device *dev, size_t size,
+				    dma_addr_t *dma_handle, gfp_t flag,
+				    struct dma_attrs *attrs)
 {
 	struct dma_map_ops *ops = get_dma_ops(dev);
 	void *cpu_addr;
 
-	cpu_addr = ops->alloc_coherent(dev, size, dma_handle, flag);
+	cpu_addr = ops->alloc(dev, size, dma_handle, flag, attrs);
 	debug_dma_alloc_coherent(dev, size, *dma_handle, cpu_addr);
 	return cpu_addr;
 }
 
-static inline void dma_free_coherent(struct device *dev, size_t size,
-				     void *cpu_addr, dma_addr_t dma_handle)
+#define dma_free_coherent(d,s,c,h) dma_free_attrs(d,s,c,h,NULL)
+
+static inline void dma_free_attrs(struct device *dev, size_t size,
+				  void *cpu_addr, dma_addr_t dma_handle,
+				  struct dma_attrs *attrs)
 {
 	struct dma_map_ops *ops = get_dma_ops(dev);
 
 	debug_dma_free_coherent(dev, size, cpu_addr, dma_handle);
-	ops->free_coherent(dev, size, cpu_addr, dma_handle);
+	ops->free(dev, size, cpu_addr, dma_handle, attrs);
 }
 
 static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
diff --git a/arch/sparc/kernel/iommu.c b/arch/sparc/kernel/iommu.c
index 4643d68..070ed14 100644
--- a/arch/sparc/kernel/iommu.c
+++ b/arch/sparc/kernel/iommu.c
@@ -280,7 +280,8 @@ static inline void iommu_free_ctx(struct iommu *iommu, int ctx)
 }
 
 static void *dma_4u_alloc_coherent(struct device *dev, size_t size,
-				   dma_addr_t *dma_addrp, gfp_t gfp)
+				   dma_addr_t *dma_addrp, gfp_t gfp,
+				   struct dma_attrs *attrs)
 {
 	unsigned long flags, order, first_page;
 	struct iommu *iommu;
@@ -330,7 +331,8 @@ static void *dma_4u_alloc_coherent(struct device *dev, size_t size,
 }
 
 static void dma_4u_free_coherent(struct device *dev, size_t size,
-				 void *cpu, dma_addr_t dvma)
+				 void *cpu, dma_addr_t dvma,
+				 struct dma_attrs *attrs)
 {
 	struct iommu *iommu;
 	unsigned long flags, order, npages;
@@ -825,8 +827,8 @@ static void dma_4u_sync_sg_for_cpu(struct device *dev,
 }
 
 static struct dma_map_ops sun4u_dma_ops = {
-	.alloc_coherent		= dma_4u_alloc_coherent,
-	.free_coherent		= dma_4u_free_coherent,
+	.alloc			= dma_4u_alloc_coherent,
+	.free			= dma_4u_free_coherent,
 	.map_page		= dma_4u_map_page,
 	.unmap_page		= dma_4u_unmap_page,
 	.map_sg			= dma_4u_map_sg,
diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index d0479e2..21bd739 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -261,7 +261,8 @@ EXPORT_SYMBOL(sbus_set_sbus64);
  * CPU may access them without any explicit flushing.
  */
 static void *sbus_alloc_coherent(struct device *dev, size_t len,
-				 dma_addr_t *dma_addrp, gfp_t gfp)
+				 dma_addr_t *dma_addrp, gfp_t gfp,
+				 struct dma_attrs *attrs)
 {
 	struct platform_device *op = to_platform_device(dev);
 	unsigned long len_total = PAGE_ALIGN(len);
@@ -315,7 +316,7 @@ err_nopages:
 }
 
 static void sbus_free_coherent(struct device *dev, size_t n, void *p,
-			       dma_addr_t ba)
+			       dma_addr_t ba, struct dma_attrs *attrs)
 {
 	struct resource *res;
 	struct page *pgv;
@@ -407,8 +408,8 @@ static void sbus_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 }
 
 struct dma_map_ops sbus_dma_ops = {
-	.alloc_coherent		= sbus_alloc_coherent,
-	.free_coherent		= sbus_free_coherent,
+	.alloc			= sbus_alloc_coherent,
+	.free			= sbus_free_coherent,
 	.map_page		= sbus_map_page,
 	.unmap_page		= sbus_unmap_page,
 	.map_sg			= sbus_map_sg,
@@ -436,7 +437,8 @@ arch_initcall(sparc_register_ioport);
  * hwdev should be valid struct pci_dev pointer for PCI devices.
  */
 static void *pci32_alloc_coherent(struct device *dev, size_t len,
-				  dma_addr_t *pba, gfp_t gfp)
+				  dma_addr_t *pba, gfp_t gfp,
+				  struct dma_attrs *attrs)
 {
 	unsigned long len_total = PAGE_ALIGN(len);
 	void *va;
@@ -489,7 +491,7 @@ err_nopages:
  * past this call are illegal.
  */
 static void pci32_free_coherent(struct device *dev, size_t n, void *p,
-				dma_addr_t ba)
+				dma_addr_t ba, struct dma_attrs *attrs)
 {
 	struct resource *res;
 
@@ -645,8 +647,8 @@ static void pci32_sync_sg_for_device(struct device *device, struct scatterlist *
 }
 
 struct dma_map_ops pci32_dma_ops = {
-	.alloc_coherent		= pci32_alloc_coherent,
-	.free_coherent		= pci32_free_coherent,
+	.alloc			= pci32_alloc_coherent,
+	.free			= pci32_free_coherent,
 	.map_page		= pci32_map_page,
 	.unmap_page		= pci32_unmap_page,
 	.map_sg			= pci32_map_sg,
diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
index af5755d..7661e84 100644
--- a/arch/sparc/kernel/pci_sun4v.c
+++ b/arch/sparc/kernel/pci_sun4v.c
@@ -128,7 +128,8 @@ static inline long iommu_batch_end(void)
 }
 
 static void *dma_4v_alloc_coherent(struct device *dev, size_t size,
-				   dma_addr_t *dma_addrp, gfp_t gfp)
+				   dma_addr_t *dma_addrp, gfp_t gfp,
+				   struct dma_attrs *attrs)
 {
 	unsigned long flags, order, first_page, npages, n;
 	struct iommu *iommu;
@@ -198,7 +199,7 @@ range_alloc_fail:
 }
 
 static void dma_4v_free_coherent(struct device *dev, size_t size, void *cpu,
-				 dma_addr_t dvma)
+				 dma_addr_t dvma, struct dma_attrs *attrs)
 {
 	struct pci_pbm_info *pbm;
 	struct iommu *iommu;
@@ -527,8 +528,8 @@ static void dma_4v_unmap_sg(struct device *dev, struct scatterlist *sglist,
 }
 
 static struct dma_map_ops sun4v_dma_ops = {
-	.alloc_coherent			= dma_4v_alloc_coherent,
-	.free_coherent			= dma_4v_free_coherent,
+	.alloc				= dma_4v_alloc_coherent,
+	.free				= dma_4v_free_coherent,
 	.map_page			= dma_4v_map_page,
 	.unmap_page			= dma_4v_unmap_page,
 	.map_sg				= dma_4v_map_sg,
-- 
1.7.1.569.g6f426
