Return-Path: <k.kozlowski@samsung.com>
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rLBLf6bg8zDqgj
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jun 2016 01:42:34 +1000 (AEST)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0O8500GIEIAVC540@mailout2.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Thu, 02 Jun 2016 16:42:32 +0100 (BST)
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
Subject: [RFC v3 41/45] tile: dma-mapping: Use unsigned long for dma_attrs
Date: Thu, 02 Jun 2016 17:39:43 +0200
Message-id: <1464881987-13203-42-git-send-email-k.kozlowski@samsung.com>
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
 arch/tile/kernel/pci-dma.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/tile/kernel/pci-dma.c b/arch/tile/kernel/pci-dma.c
index b6bc0547a4f6..09bb774b39cd 100644
--- a/arch/tile/kernel/pci-dma.c
+++ b/arch/tile/kernel/pci-dma.c
@@ -34,7 +34,7 @@
 
 static void *tile_dma_alloc_coherent(struct device *dev, size_t size,
 				     dma_addr_t *dma_handle, gfp_t gfp,
-				     struct dma_attrs *attrs)
+				     unsigned long attrs)
 {
 	u64 dma_mask = (dev && dev->coherent_dma_mask) ?
 		dev->coherent_dma_mask : DMA_BIT_MASK(32);
@@ -78,7 +78,7 @@ static void *tile_dma_alloc_coherent(struct device *dev, size_t size,
  */
 static void tile_dma_free_coherent(struct device *dev, size_t size,
 				   void *vaddr, dma_addr_t dma_handle,
-				   struct dma_attrs *attrs)
+				   unsigned long attrs)
 {
 	homecache_free_pages((unsigned long)vaddr, get_order(size));
 }
@@ -202,7 +202,7 @@ static void __dma_complete_pa_range(dma_addr_t dma_addr, size_t size,
 
 static int tile_dma_map_sg(struct device *dev, struct scatterlist *sglist,
 			   int nents, enum dma_data_direction direction,
-			   struct dma_attrs *attrs)
+			   unsigned long attrs)
 {
 	struct scatterlist *sg;
 	int i;
@@ -224,7 +224,7 @@ static int tile_dma_map_sg(struct device *dev, struct scatterlist *sglist,
 
 static void tile_dma_unmap_sg(struct device *dev, struct scatterlist *sglist,
 			      int nents, enum dma_data_direction direction,
-			      struct dma_attrs *attrs)
+			      unsigned long attrs)
 {
 	struct scatterlist *sg;
 	int i;
@@ -240,7 +240,7 @@ static void tile_dma_unmap_sg(struct device *dev, struct scatterlist *sglist,
 static dma_addr_t tile_dma_map_page(struct device *dev, struct page *page,
 				    unsigned long offset, size_t size,
 				    enum dma_data_direction direction,
-				    struct dma_attrs *attrs)
+				    unsigned long attrs)
 {
 	BUG_ON(!valid_dma_direction(direction));
 
@@ -252,7 +252,7 @@ static dma_addr_t tile_dma_map_page(struct device *dev, struct page *page,
 
 static void tile_dma_unmap_page(struct device *dev, dma_addr_t dma_address,
 				size_t size, enum dma_data_direction direction,
-				struct dma_attrs *attrs)
+				unsigned long attrs)
 {
 	BUG_ON(!valid_dma_direction(direction));
 
@@ -343,7 +343,7 @@ EXPORT_SYMBOL(tile_dma_map_ops);
 
 static void *tile_pci_dma_alloc_coherent(struct device *dev, size_t size,
 					 dma_addr_t *dma_handle, gfp_t gfp,
-					 struct dma_attrs *attrs)
+					 unsigned long attrs)
 {
 	int node = dev_to_node(dev);
 	int order = get_order(size);
@@ -368,14 +368,14 @@ static void *tile_pci_dma_alloc_coherent(struct device *dev, size_t size,
  */
 static void tile_pci_dma_free_coherent(struct device *dev, size_t size,
 				       void *vaddr, dma_addr_t dma_handle,
-				       struct dma_attrs *attrs)
+				       unsigned long attrs)
 {
 	homecache_free_pages((unsigned long)vaddr, get_order(size));
 }
 
 static int tile_pci_dma_map_sg(struct device *dev, struct scatterlist *sglist,
 			       int nents, enum dma_data_direction direction,
-			       struct dma_attrs *attrs)
+			       unsigned long attrs)
 {
 	struct scatterlist *sg;
 	int i;
@@ -400,7 +400,7 @@ static int tile_pci_dma_map_sg(struct device *dev, struct scatterlist *sglist,
 static void tile_pci_dma_unmap_sg(struct device *dev,
 				  struct scatterlist *sglist, int nents,
 				  enum dma_data_direction direction,
-				  struct dma_attrs *attrs)
+				  unsigned long attrs)
 {
 	struct scatterlist *sg;
 	int i;
@@ -416,7 +416,7 @@ static void tile_pci_dma_unmap_sg(struct device *dev,
 static dma_addr_t tile_pci_dma_map_page(struct device *dev, struct page *page,
 					unsigned long offset, size_t size,
 					enum dma_data_direction direction,
-					struct dma_attrs *attrs)
+					unsigned long attrs)
 {
 	BUG_ON(!valid_dma_direction(direction));
 
@@ -429,7 +429,7 @@ static dma_addr_t tile_pci_dma_map_page(struct device *dev, struct page *page,
 static void tile_pci_dma_unmap_page(struct device *dev, dma_addr_t dma_address,
 				    size_t size,
 				    enum dma_data_direction direction,
-				    struct dma_attrs *attrs)
+				    unsigned long attrs)
 {
 	BUG_ON(!valid_dma_direction(direction));
 
@@ -531,7 +531,7 @@ EXPORT_SYMBOL(gx_pci_dma_map_ops);
 #ifdef CONFIG_SWIOTLB
 static void *tile_swiotlb_alloc_coherent(struct device *dev, size_t size,
 					 dma_addr_t *dma_handle, gfp_t gfp,
-					 struct dma_attrs *attrs)
+					 unsigned long attrs)
 {
 	gfp |= GFP_DMA;
 	return swiotlb_alloc_coherent(dev, size, dma_handle, gfp);
@@ -539,7 +539,7 @@ static void *tile_swiotlb_alloc_coherent(struct device *dev, size_t size,
 
 static void tile_swiotlb_free_coherent(struct device *dev, size_t size,
 				       void *vaddr, dma_addr_t dma_addr,
-				       struct dma_attrs *attrs)
+				       unsigned long attrs)
 {
 	swiotlb_free_coherent(dev, size, vaddr, dma_addr);
 }
-- 
1.9.1
