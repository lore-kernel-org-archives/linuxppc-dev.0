Return-Path: <k.kozlowski@samsung.com>
Received: from mailout3.w1.samsung.com (mailout3.w1.samsung.com
 [210.118.77.13])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rLBKs2GdNzDqG1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jun 2016 01:41:53 +1000 (AEST)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0O8500AFFI9RVM10@mailout3.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Thu, 02 Jun 2016 16:41:52 +0100 (BST)
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
Subject: [RFC v3 28/45] ia64: dma-mapping: Use unsigned long for dma_attrs
Date: Thu, 02 Jun 2016 17:39:30 +0200
Message-id: <1464881987-13203-29-git-send-email-k.kozlowski@samsung.com>
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
 arch/ia64/hp/common/sba_iommu.c | 22 +++++++++++-----------
 arch/ia64/include/asm/machvec.h |  1 -
 arch/ia64/kernel/pci-swiotlb.c  |  4 ++--
 arch/ia64/sn/pci/pci_dma.c      | 12 ++++++------
 4 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/arch/ia64/hp/common/sba_iommu.c b/arch/ia64/hp/common/sba_iommu.c
index a6d6190c9d24..630ee8073899 100644
--- a/arch/ia64/hp/common/sba_iommu.c
+++ b/arch/ia64/hp/common/sba_iommu.c
@@ -919,7 +919,7 @@ sba_mark_invalid(struct ioc *ioc, dma_addr_t iova, size_t byte_cnt)
 static dma_addr_t sba_map_page(struct device *dev, struct page *page,
 			       unsigned long poff, size_t size,
 			       enum dma_data_direction dir,
-			       struct dma_attrs *attrs)
+			       unsigned long attrs)
 {
 	struct ioc *ioc;
 	void *addr = page_address(page) + poff;
@@ -1005,7 +1005,7 @@ static dma_addr_t sba_map_page(struct device *dev, struct page *page,
 
 static dma_addr_t sba_map_single_attrs(struct device *dev, void *addr,
 				       size_t size, enum dma_data_direction dir,
-				       struct dma_attrs *attrs)
+				       unsigned long attrs)
 {
 	return sba_map_page(dev, virt_to_page(addr),
 			    (unsigned long)addr & ~PAGE_MASK, size, dir, attrs);
@@ -1046,7 +1046,7 @@ sba_mark_clean(struct ioc *ioc, dma_addr_t iova, size_t size)
  * See Documentation/DMA-API-HOWTO.txt
  */
 static void sba_unmap_page(struct device *dev, dma_addr_t iova, size_t size,
-			   enum dma_data_direction dir, struct dma_attrs *attrs)
+			   enum dma_data_direction dir, unsigned long attrs)
 {
 	struct ioc *ioc;
 #if DELAYED_RESOURCE_CNT > 0
@@ -1115,7 +1115,7 @@ static void sba_unmap_page(struct device *dev, dma_addr_t iova, size_t size,
 }
 
 void sba_unmap_single_attrs(struct device *dev, dma_addr_t iova, size_t size,
-			    enum dma_data_direction dir, struct dma_attrs *attrs)
+			    enum dma_data_direction dir, unsigned long attrs)
 {
 	sba_unmap_page(dev, iova, size, dir, attrs);
 }
@@ -1130,7 +1130,7 @@ void sba_unmap_single_attrs(struct device *dev, dma_addr_t iova, size_t size,
  */
 static void *
 sba_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_handle,
-		   gfp_t flags, struct dma_attrs *attrs)
+		   gfp_t flags, unsigned long attrs)
 {
 	struct ioc *ioc;
 	void *addr;
@@ -1175,7 +1175,7 @@ sba_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	 * device to map single to get an iova mapping.
 	 */
 	*dma_handle = sba_map_single_attrs(&ioc->sac_only_dev->dev, addr,
-					   size, 0, NULL);
+					   size, 0, 0);
 
 	return addr;
 }
@@ -1191,9 +1191,9 @@ sba_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_handle,
  * See Documentation/DMA-API-HOWTO.txt
  */
 static void sba_free_coherent(struct device *dev, size_t size, void *vaddr,
-			      dma_addr_t dma_handle, struct dma_attrs *attrs)
+			      dma_addr_t dma_handle, unsigned long attrs)
 {
-	sba_unmap_single_attrs(dev, dma_handle, size, 0, NULL);
+	sba_unmap_single_attrs(dev, dma_handle, size, 0, 0);
 	free_pages((unsigned long) vaddr, get_order(size));
 }
 
@@ -1442,7 +1442,7 @@ sba_coalesce_chunks(struct ioc *ioc, struct device *dev,
 
 static void sba_unmap_sg_attrs(struct device *dev, struct scatterlist *sglist,
 			       int nents, enum dma_data_direction dir,
-			       struct dma_attrs *attrs);
+			       unsigned long attrs);
 /**
  * sba_map_sg - map Scatter/Gather list
  * @dev: instance of PCI owned by the driver that's asking.
@@ -1455,7 +1455,7 @@ static void sba_unmap_sg_attrs(struct device *dev, struct scatterlist *sglist,
  */
 static int sba_map_sg_attrs(struct device *dev, struct scatterlist *sglist,
 			    int nents, enum dma_data_direction dir,
-			    struct dma_attrs *attrs)
+			    unsigned long attrs)
 {
 	struct ioc *ioc;
 	int coalesced, filled = 0;
@@ -1551,7 +1551,7 @@ static int sba_map_sg_attrs(struct device *dev, struct scatterlist *sglist,
  */
 static void sba_unmap_sg_attrs(struct device *dev, struct scatterlist *sglist,
 			       int nents, enum dma_data_direction dir,
-			       struct dma_attrs *attrs)
+			       unsigned long attrs)
 {
 #ifdef ASSERT_PDIR_SANITY
 	struct ioc *ioc;
diff --git a/arch/ia64/include/asm/machvec.h b/arch/ia64/include/asm/machvec.h
index 9c39bdfc2da8..ed7f09089f12 100644
--- a/arch/ia64/include/asm/machvec.h
+++ b/arch/ia64/include/asm/machvec.h
@@ -22,7 +22,6 @@ struct pci_bus;
 struct task_struct;
 struct pci_dev;
 struct msi_desc;
-struct dma_attrs;
 
 typedef void ia64_mv_setup_t (char **);
 typedef void ia64_mv_cpu_init_t (void);
diff --git a/arch/ia64/kernel/pci-swiotlb.c b/arch/ia64/kernel/pci-swiotlb.c
index 939260aeac98..2933208c0285 100644
--- a/arch/ia64/kernel/pci-swiotlb.c
+++ b/arch/ia64/kernel/pci-swiotlb.c
@@ -16,7 +16,7 @@ EXPORT_SYMBOL(swiotlb);
 
 static void *ia64_swiotlb_alloc_coherent(struct device *dev, size_t size,
 					 dma_addr_t *dma_handle, gfp_t gfp,
-					 struct dma_attrs *attrs)
+					 unsigned long attrs)
 {
 	if (dev->coherent_dma_mask != DMA_BIT_MASK(64))
 		gfp |= GFP_DMA;
@@ -25,7 +25,7 @@ static void *ia64_swiotlb_alloc_coherent(struct device *dev, size_t size,
 
 static void ia64_swiotlb_free_coherent(struct device *dev, size_t size,
 				       void *vaddr, dma_addr_t dma_addr,
-				       struct dma_attrs *attrs)
+				       unsigned long attrs)
 {
 	swiotlb_free_coherent(dev, size, vaddr, dma_addr);
 }
diff --git a/arch/ia64/sn/pci/pci_dma.c b/arch/ia64/sn/pci/pci_dma.c
index 8f59907007cb..6b78fc953c4b 100644
--- a/arch/ia64/sn/pci/pci_dma.c
+++ b/arch/ia64/sn/pci/pci_dma.c
@@ -77,7 +77,7 @@ EXPORT_SYMBOL(sn_dma_set_mask);
  */
 static void *sn_dma_alloc_coherent(struct device *dev, size_t size,
 				   dma_addr_t * dma_handle, gfp_t flags,
-				   struct dma_attrs *attrs)
+				   unsigned long attrs)
 {
 	void *cpuaddr;
 	unsigned long phys_addr;
@@ -138,7 +138,7 @@ static void *sn_dma_alloc_coherent(struct device *dev, size_t size,
  * any associated IOMMU mappings.
  */
 static void sn_dma_free_coherent(struct device *dev, size_t size, void *cpu_addr,
-				 dma_addr_t dma_handle, struct dma_attrs *attrs)
+				 dma_addr_t dma_handle, unsigned long attrs)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct sn_pcibus_provider *provider = SN_PCIDEV_BUSPROVIDER(pdev);
@@ -176,7 +176,7 @@ static void sn_dma_free_coherent(struct device *dev, size_t size, void *cpu_addr
 static dma_addr_t sn_dma_map_page(struct device *dev, struct page *page,
 				  unsigned long offset, size_t size,
 				  enum dma_data_direction dir,
-				  struct dma_attrs *attrs)
+				  unsigned long attrs)
 {
 	void *cpu_addr = page_address(page) + offset;
 	dma_addr_t dma_addr;
@@ -218,7 +218,7 @@ static dma_addr_t sn_dma_map_page(struct device *dev, struct page *page,
  */
 static void sn_dma_unmap_page(struct device *dev, dma_addr_t dma_addr,
 			      size_t size, enum dma_data_direction dir,
-			      struct dma_attrs *attrs)
+			      unsigned long attrs)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct sn_pcibus_provider *provider = SN_PCIDEV_BUSPROVIDER(pdev);
@@ -240,7 +240,7 @@ static void sn_dma_unmap_page(struct device *dev, dma_addr_t dma_addr,
  */
 static void sn_dma_unmap_sg(struct device *dev, struct scatterlist *sgl,
 			    int nhwentries, enum dma_data_direction dir,
-			    struct dma_attrs *attrs)
+			    unsigned long attrs)
 {
 	int i;
 	struct pci_dev *pdev = to_pci_dev(dev);
@@ -273,7 +273,7 @@ static void sn_dma_unmap_sg(struct device *dev, struct scatterlist *sgl,
  */
 static int sn_dma_map_sg(struct device *dev, struct scatterlist *sgl,
 			 int nhwentries, enum dma_data_direction dir,
-			 struct dma_attrs *attrs)
+			 unsigned long attrs)
 {
 	unsigned long phys_addr;
 	struct scatterlist *saved_sg = sgl, *sg;
-- 
1.9.1
