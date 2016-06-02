Return-Path: <k.kozlowski@samsung.com>
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rLBLb6qmHzDqgj
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jun 2016 01:42:31 +1000 (AEST)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0O8500NZIIAS0I00@mailout1.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Thu, 02 Jun 2016 16:42:28 +0100 (BST)
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
Subject: [RFC v3 40/45] sparc: dma-mapping: Use unsigned long for dma_attrs
Date: Thu, 02 Jun 2016 17:39:42 +0200
Message-id: <1464881987-13203-41-git-send-email-k.kozlowski@samsung.com>
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
 arch/sparc/kernel/iommu.c     | 12 ++++++------
 arch/sparc/kernel/ioport.c    | 24 ++++++++++++------------
 arch/sparc/kernel/pci_sun4v.c | 12 ++++++------
 3 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/sparc/kernel/iommu.c b/arch/sparc/kernel/iommu.c
index 37686828c3d9..5c615abff030 100644
--- a/arch/sparc/kernel/iommu.c
+++ b/arch/sparc/kernel/iommu.c
@@ -196,7 +196,7 @@ static inline void iommu_free_ctx(struct iommu *iommu, int ctx)
 
 static void *dma_4u_alloc_coherent(struct device *dev, size_t size,
 				   dma_addr_t *dma_addrp, gfp_t gfp,
-				   struct dma_attrs *attrs)
+				   unsigned long attrs)
 {
 	unsigned long order, first_page;
 	struct iommu *iommu;
@@ -245,7 +245,7 @@ static void *dma_4u_alloc_coherent(struct device *dev, size_t size,
 
 static void dma_4u_free_coherent(struct device *dev, size_t size,
 				 void *cpu, dma_addr_t dvma,
-				 struct dma_attrs *attrs)
+				 unsigned long attrs)
 {
 	struct iommu *iommu;
 	unsigned long order, npages;
@@ -263,7 +263,7 @@ static void dma_4u_free_coherent(struct device *dev, size_t size,
 static dma_addr_t dma_4u_map_page(struct device *dev, struct page *page,
 				  unsigned long offset, size_t sz,
 				  enum dma_data_direction direction,
-				  struct dma_attrs *attrs)
+				  unsigned long attrs)
 {
 	struct iommu *iommu;
 	struct strbuf *strbuf;
@@ -385,7 +385,7 @@ do_flush_sync:
 
 static void dma_4u_unmap_page(struct device *dev, dma_addr_t bus_addr,
 			      size_t sz, enum dma_data_direction direction,
-			      struct dma_attrs *attrs)
+			      unsigned long attrs)
 {
 	struct iommu *iommu;
 	struct strbuf *strbuf;
@@ -431,7 +431,7 @@ static void dma_4u_unmap_page(struct device *dev, dma_addr_t bus_addr,
 
 static int dma_4u_map_sg(struct device *dev, struct scatterlist *sglist,
 			 int nelems, enum dma_data_direction direction,
-			 struct dma_attrs *attrs)
+			 unsigned long attrs)
 {
 	struct scatterlist *s, *outs, *segstart;
 	unsigned long flags, handle, prot, ctx;
@@ -607,7 +607,7 @@ static unsigned long fetch_sg_ctx(struct iommu *iommu, struct scatterlist *sg)
 
 static void dma_4u_unmap_sg(struct device *dev, struct scatterlist *sglist,
 			    int nelems, enum dma_data_direction direction,
-			    struct dma_attrs *attrs)
+			    unsigned long attrs)
 {
 	unsigned long flags, ctx;
 	struct scatterlist *sg;
diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index ffd5ff4678cf..2344103414d1 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -260,7 +260,7 @@ EXPORT_SYMBOL(sbus_set_sbus64);
  */
 static void *sbus_alloc_coherent(struct device *dev, size_t len,
 				 dma_addr_t *dma_addrp, gfp_t gfp,
-				 struct dma_attrs *attrs)
+				 unsigned long attrs)
 {
 	struct platform_device *op = to_platform_device(dev);
 	unsigned long len_total = PAGE_ALIGN(len);
@@ -315,7 +315,7 @@ err_nopages:
 }
 
 static void sbus_free_coherent(struct device *dev, size_t n, void *p,
-			       dma_addr_t ba, struct dma_attrs *attrs)
+			       dma_addr_t ba, unsigned long attrs)
 {
 	struct resource *res;
 	struct page *pgv;
@@ -355,7 +355,7 @@ static void sbus_free_coherent(struct device *dev, size_t n, void *p,
 static dma_addr_t sbus_map_page(struct device *dev, struct page *page,
 				unsigned long offset, size_t len,
 				enum dma_data_direction dir,
-				struct dma_attrs *attrs)
+				unsigned long attrs)
 {
 	void *va = page_address(page) + offset;
 
@@ -371,20 +371,20 @@ static dma_addr_t sbus_map_page(struct device *dev, struct page *page,
 }
 
 static void sbus_unmap_page(struct device *dev, dma_addr_t ba, size_t n,
-			    enum dma_data_direction dir, struct dma_attrs *attrs)
+			    enum dma_data_direction dir, unsigned long attrs)
 {
 	mmu_release_scsi_one(dev, ba, n);
 }
 
 static int sbus_map_sg(struct device *dev, struct scatterlist *sg, int n,
-		       enum dma_data_direction dir, struct dma_attrs *attrs)
+		       enum dma_data_direction dir, unsigned long attrs)
 {
 	mmu_get_scsi_sgl(dev, sg, n);
 	return n;
 }
 
 static void sbus_unmap_sg(struct device *dev, struct scatterlist *sg, int n,
-			  enum dma_data_direction dir, struct dma_attrs *attrs)
+			  enum dma_data_direction dir, unsigned long attrs)
 {
 	mmu_release_scsi_sgl(dev, sg, n);
 }
@@ -429,7 +429,7 @@ arch_initcall(sparc_register_ioport);
  */
 static void *pci32_alloc_coherent(struct device *dev, size_t len,
 				  dma_addr_t *pba, gfp_t gfp,
-				  struct dma_attrs *attrs)
+				  unsigned long attrs)
 {
 	unsigned long len_total = PAGE_ALIGN(len);
 	void *va;
@@ -482,7 +482,7 @@ err_nopages:
  * past this call are illegal.
  */
 static void pci32_free_coherent(struct device *dev, size_t n, void *p,
-				dma_addr_t ba, struct dma_attrs *attrs)
+				dma_addr_t ba, unsigned long attrs)
 {
 	struct resource *res;
 
@@ -518,14 +518,14 @@ static void pci32_free_coherent(struct device *dev, size_t n, void *p,
 static dma_addr_t pci32_map_page(struct device *dev, struct page *page,
 				 unsigned long offset, size_t size,
 				 enum dma_data_direction dir,
-				 struct dma_attrs *attrs)
+				 unsigned long attrs)
 {
 	/* IIep is write-through, not flushing. */
 	return page_to_phys(page) + offset;
 }
 
 static void pci32_unmap_page(struct device *dev, dma_addr_t ba, size_t size,
-			     enum dma_data_direction dir, struct dma_attrs *attrs)
+			     enum dma_data_direction dir, unsigned long attrs)
 {
 	if (dir != PCI_DMA_TODEVICE)
 		dma_make_coherent(ba, PAGE_ALIGN(size));
@@ -548,7 +548,7 @@ static void pci32_unmap_page(struct device *dev, dma_addr_t ba, size_t size,
  */
 static int pci32_map_sg(struct device *device, struct scatterlist *sgl,
 			int nents, enum dma_data_direction dir,
-			struct dma_attrs *attrs)
+			unsigned long attrs)
 {
 	struct scatterlist *sg;
 	int n;
@@ -567,7 +567,7 @@ static int pci32_map_sg(struct device *device, struct scatterlist *sgl,
  */
 static void pci32_unmap_sg(struct device *dev, struct scatterlist *sgl,
 			   int nents, enum dma_data_direction dir,
-			   struct dma_attrs *attrs)
+			   unsigned long attrs)
 {
 	struct scatterlist *sg;
 	int n;
diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
index 836e8cef47e2..61c6f935accc 100644
--- a/arch/sparc/kernel/pci_sun4v.c
+++ b/arch/sparc/kernel/pci_sun4v.c
@@ -130,7 +130,7 @@ static inline long iommu_batch_end(void)
 
 static void *dma_4v_alloc_coherent(struct device *dev, size_t size,
 				   dma_addr_t *dma_addrp, gfp_t gfp,
-				   struct dma_attrs *attrs)
+				   unsigned long attrs)
 {
 	unsigned long flags, order, first_page, npages, n;
 	struct iommu *iommu;
@@ -213,7 +213,7 @@ static void dma_4v_iommu_demap(void *demap_arg, unsigned long entry,
 }
 
 static void dma_4v_free_coherent(struct device *dev, size_t size, void *cpu,
-				 dma_addr_t dvma, struct dma_attrs *attrs)
+				 dma_addr_t dvma, unsigned long attrs)
 {
 	struct pci_pbm_info *pbm;
 	struct iommu *iommu;
@@ -235,7 +235,7 @@ static void dma_4v_free_coherent(struct device *dev, size_t size, void *cpu,
 static dma_addr_t dma_4v_map_page(struct device *dev, struct page *page,
 				  unsigned long offset, size_t sz,
 				  enum dma_data_direction direction,
-				  struct dma_attrs *attrs)
+				  unsigned long attrs)
 {
 	struct iommu *iommu;
 	unsigned long flags, npages, oaddr;
@@ -294,7 +294,7 @@ iommu_map_fail:
 
 static void dma_4v_unmap_page(struct device *dev, dma_addr_t bus_addr,
 			      size_t sz, enum dma_data_direction direction,
-			      struct dma_attrs *attrs)
+			      unsigned long attrs)
 {
 	struct pci_pbm_info *pbm;
 	struct iommu *iommu;
@@ -322,7 +322,7 @@ static void dma_4v_unmap_page(struct device *dev, dma_addr_t bus_addr,
 
 static int dma_4v_map_sg(struct device *dev, struct scatterlist *sglist,
 			 int nelems, enum dma_data_direction direction,
-			 struct dma_attrs *attrs)
+			 unsigned long attrs)
 {
 	struct scatterlist *s, *outs, *segstart;
 	unsigned long flags, handle, prot;
@@ -466,7 +466,7 @@ iommu_map_failed:
 
 static void dma_4v_unmap_sg(struct device *dev, struct scatterlist *sglist,
 			    int nelems, enum dma_data_direction direction,
-			    struct dma_attrs *attrs)
+			    unsigned long attrs)
 {
 	struct pci_pbm_info *pbm;
 	struct scatterlist *sg;
-- 
1.9.1
