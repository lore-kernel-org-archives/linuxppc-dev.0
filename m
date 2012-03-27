Return-Path: <m.szyprowski@samsung.com>
Received: from mailout4.w1.samsung.com (mailout4.w1.samsung.com
 [210.118.77.14]) by ozlabs.org (Postfix) with ESMTP id F0456B6EEA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2012 00:43:31 +1100 (EST)
MIME-version: 1.0
Content-type: TEXT/PLAIN
Received: from euspt2 ([210.118.77.14]) by mailout4.w1.samsung.com
 (Sun Java(tm) System Messaging Server 6.3-8.04 (built Jul 29 2009; 32bit))
 with ESMTP id <0M1J00NXXQ4F2K60@mailout4.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Tue, 27 Mar 2012 14:43:27 +0100 (BST)
Received: from linux.samsung.com ([106.116.38.10])
 by spt2.w1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
 2004)) with ESMTPA id <0M1J0022VQ491V@spt2.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Tue, 27 Mar 2012 14:43:23 +0100 (BST)
Date: Tue, 27 Mar 2012 15:42:40 +0200
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCHv2 06/14] Alpha: adapt for dma_map_ops changes
In-reply-to: <1332855768-32583-1-git-send-email-m.szyprowski@samsung.com>
To: linux-kernel@vger.kernel.org
Message-id: <1332855768-32583-7-git-send-email-m.szyprowski@samsung.com>
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

Adapt core Alpha architecture code for dma_map_ops changes: replace
alloc/free_coherent with generic alloc/free methods.

Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/alpha/include/asm/dma-mapping.h |   18 ++++++++++++------
 arch/alpha/kernel/pci-noop.c         |   10 ++++++----
 arch/alpha/kernel/pci_iommu.c        |   10 ++++++----
 3 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/arch/alpha/include/asm/dma-mapping.h b/arch/alpha/include/asm/dma-mapping.h
index 4567aca..dfa32f0 100644
--- a/arch/alpha/include/asm/dma-mapping.h
+++ b/arch/alpha/include/asm/dma-mapping.h
@@ -12,16 +12,22 @@ static inline struct dma_map_ops *get_dma_ops(struct device *dev)
 
 #include <asm-generic/dma-mapping-common.h>
 
-static inline void *dma_alloc_coherent(struct device *dev, size_t size,
-				       dma_addr_t *dma_handle, gfp_t gfp)
+#define dma_alloc_coherent(d,s,h,f)	dma_alloc_attrs(d,s,h,f,NULL)
+
+static inline void *dma_alloc_attrs(struct device *dev, size_t size,
+				    dma_addr_t *dma_handle, gfp_t gfp,
+				    struct dma_attrs *attrs)
 {
-	return get_dma_ops(dev)->alloc_coherent(dev, size, dma_handle, gfp);
+	return get_dma_ops(dev)->alloc(dev, size, dma_handle, gfp, attrs);
 }
 
-static inline void dma_free_coherent(struct device *dev, size_t size,
-				     void *vaddr, dma_addr_t dma_handle)
+#define dma_free_coherent(d,s,c,h) dma_free_attrs(d,s,c,h,NULL)
+
+static inline void dma_free_attrs(struct device *dev, size_t size,
+				  void *vaddr, dma_addr_t dma_handle,
+				  struct dma_attrs *attrs)
 {
-	get_dma_ops(dev)->free_coherent(dev, size, vaddr, dma_handle);
+	get_dma_ops(dev)->free(dev, size, vaddr, dma_handle, attrs);
 }
 
 static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
diff --git a/arch/alpha/kernel/pci-noop.c b/arch/alpha/kernel/pci-noop.c
index 04eea48..df24b76 100644
--- a/arch/alpha/kernel/pci-noop.c
+++ b/arch/alpha/kernel/pci-noop.c
@@ -108,7 +108,8 @@ sys_pciconfig_write(unsigned long bus, unsigned long dfn,
 }
 
 static void *alpha_noop_alloc_coherent(struct device *dev, size_t size,
-				       dma_addr_t *dma_handle, gfp_t gfp)
+				       dma_addr_t *dma_handle, gfp_t gfp,
+				       struct dma_attrs *attrs)
 {
 	void *ret;
 
@@ -123,7 +124,8 @@ static void *alpha_noop_alloc_coherent(struct device *dev, size_t size,
 }
 
 static void alpha_noop_free_coherent(struct device *dev, size_t size,
-				     void *cpu_addr, dma_addr_t dma_addr)
+				     void *cpu_addr, dma_addr_t dma_addr,
+				     struct dma_attrs *attrs)
 {
 	free_pages((unsigned long)cpu_addr, get_order(size));
 }
@@ -174,8 +176,8 @@ static int alpha_noop_set_mask(struct device *dev, u64 mask)
 }
 
 struct dma_map_ops alpha_noop_ops = {
-	.alloc_coherent		= alpha_noop_alloc_coherent,
-	.free_coherent		= alpha_noop_free_coherent,
+	.alloc			= alpha_noop_alloc_coherent,
+	.free			= alpha_noop_free_coherent,
 	.map_page		= alpha_noop_map_page,
 	.map_sg			= alpha_noop_map_sg,
 	.mapping_error		= alpha_noop_mapping_error,
diff --git a/arch/alpha/kernel/pci_iommu.c b/arch/alpha/kernel/pci_iommu.c
index 4361080..cd63479 100644
--- a/arch/alpha/kernel/pci_iommu.c
+++ b/arch/alpha/kernel/pci_iommu.c
@@ -434,7 +434,8 @@ static void alpha_pci_unmap_page(struct device *dev, dma_addr_t dma_addr,
    else DMA_ADDRP is undefined.  */
 
 static void *alpha_pci_alloc_coherent(struct device *dev, size_t size,
-				      dma_addr_t *dma_addrp, gfp_t gfp)
+				      dma_addr_t *dma_addrp, gfp_t gfp,
+				      struct dma_attrs *attrs)
 {
 	struct pci_dev *pdev = alpha_gendev_to_pci(dev);
 	void *cpu_addr;
@@ -478,7 +479,8 @@ try_again:
    DMA_ADDR past this call are illegal.  */
 
 static void alpha_pci_free_coherent(struct device *dev, size_t size,
-				    void *cpu_addr, dma_addr_t dma_addr)
+				    void *cpu_addr, dma_addr_t dma_addr,
+				    struct dma_attrs *attrs)
 {
 	struct pci_dev *pdev = alpha_gendev_to_pci(dev);
 	pci_unmap_single(pdev, dma_addr, size, PCI_DMA_BIDIRECTIONAL);
@@ -952,8 +954,8 @@ static int alpha_pci_set_mask(struct device *dev, u64 mask)
 }
 
 struct dma_map_ops alpha_pci_ops = {
-	.alloc_coherent		= alpha_pci_alloc_coherent,
-	.free_coherent		= alpha_pci_free_coherent,
+	.alloc			= alpha_pci_alloc_coherent,
+	.free			= alpha_pci_free_coherent,
 	.map_page		= alpha_pci_map_page,
 	.unmap_page		= alpha_pci_unmap_page,
 	.map_sg			= alpha_pci_map_sg,
-- 
1.7.1.569.g6f426
