Return-Path: <k.kozlowski@samsung.com>
Received: from mailout3.w1.samsung.com (mailout3.w1.samsung.com
 [210.118.77.13])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rLBLM2g5XzDqgj
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jun 2016 01:42:19 +1000 (AEST)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0O85005Y1IAF2K10@mailout3.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Thu, 02 Jun 2016 16:42:16 +0100 (BST)
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
Subject: [RFC v3 36/45] parisc: dma-mapping: Use unsigned long for dma_attrs
Date: Thu, 02 Jun 2016 17:39:38 +0200
Message-id: <1464881987-13203-37-git-send-email-k.kozlowski@samsung.com>
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
 arch/parisc/kernel/pci-dma.c | 16 ++++++++--------
 drivers/parisc/ccio-dma.c    | 16 ++++++++--------
 drivers/parisc/sba_iommu.c   | 16 ++++++++--------
 3 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/parisc/kernel/pci-dma.c b/arch/parisc/kernel/pci-dma.c
index a27e4928bf73..845fdd52e4c5 100644
--- a/arch/parisc/kernel/pci-dma.c
+++ b/arch/parisc/kernel/pci-dma.c
@@ -414,7 +414,7 @@ pcxl_dma_init(void)
 __initcall(pcxl_dma_init);
 
 static void *pa11_dma_alloc(struct device *dev, size_t size,
-		dma_addr_t *dma_handle, gfp_t flag, struct dma_attrs *attrs)
+		dma_addr_t *dma_handle, gfp_t flag, unsigned long attrs)
 {
 	unsigned long vaddr;
 	unsigned long paddr;
@@ -441,7 +441,7 @@ static void *pa11_dma_alloc(struct device *dev, size_t size,
 }
 
 static void pa11_dma_free(struct device *dev, size_t size, void *vaddr,
-		dma_addr_t dma_handle, struct dma_attrs *attrs)
+		dma_addr_t dma_handle, unsigned long attrs)
 {
 	int order;
 
@@ -454,7 +454,7 @@ static void pa11_dma_free(struct device *dev, size_t size, void *vaddr,
 
 static dma_addr_t pa11_dma_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t size,
-		enum dma_data_direction direction, struct dma_attrs *attrs)
+		enum dma_data_direction direction, unsigned long attrs)
 {
 	void *addr = page_address(page) + offset;
 	BUG_ON(direction == DMA_NONE);
@@ -465,7 +465,7 @@ static dma_addr_t pa11_dma_map_page(struct device *dev, struct page *page,
 
 static void pa11_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
 		size_t size, enum dma_data_direction direction,
-		struct dma_attrs *attrs)
+		unsigned long attrs)
 {
 	BUG_ON(direction == DMA_NONE);
 
@@ -484,7 +484,7 @@ static void pa11_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
 
 static int pa11_dma_map_sg(struct device *dev, struct scatterlist *sglist,
 		int nents, enum dma_data_direction direction,
-		struct dma_attrs *attrs)
+		unsigned long attrs)
 {
 	int i;
 	struct scatterlist *sg;
@@ -503,7 +503,7 @@ static int pa11_dma_map_sg(struct device *dev, struct scatterlist *sglist,
 
 static void pa11_dma_unmap_sg(struct device *dev, struct scatterlist *sglist,
 		int nents, enum dma_data_direction direction,
-		struct dma_attrs *attrs)
+		unsigned long attrs)
 {
 	int i;
 	struct scatterlist *sg;
@@ -577,7 +577,7 @@ struct dma_map_ops pcxl_dma_ops = {
 };
 
 static void *pcx_dma_alloc(struct device *dev, size_t size,
-		dma_addr_t *dma_handle, gfp_t flag, struct dma_attrs *attrs)
+		dma_addr_t *dma_handle, gfp_t flag, unsigned long attrs)
 {
 	void *addr;
 
@@ -592,7 +592,7 @@ static void *pcx_dma_alloc(struct device *dev, size_t size,
 }
 
 static void pcx_dma_free(struct device *dev, size_t size, void *vaddr,
-		dma_addr_t iova, struct dma_attrs *attrs)
+		dma_addr_t iova, unsigned long attrs)
 {
 	free_pages((unsigned long)vaddr, get_order(size));
 	return;
diff --git a/drivers/parisc/ccio-dma.c b/drivers/parisc/ccio-dma.c
index e24b05996a1b..3ed6238f8f6e 100644
--- a/drivers/parisc/ccio-dma.c
+++ b/drivers/parisc/ccio-dma.c
@@ -790,7 +790,7 @@ ccio_map_single(struct device *dev, void *addr, size_t size,
 static dma_addr_t
 ccio_map_page(struct device *dev, struct page *page, unsigned long offset,
 		size_t size, enum dma_data_direction direction,
-		struct dma_attrs *attrs)
+		unsigned long attrs)
 {
 	return ccio_map_single(dev, page_address(page) + offset, size,
 			direction);
@@ -806,7 +806,7 @@ ccio_map_page(struct device *dev, struct page *page, unsigned long offset,
  */
 static void 
 ccio_unmap_page(struct device *dev, dma_addr_t iova, size_t size,
-		enum dma_data_direction direction, struct dma_attrs *attrs)
+		enum dma_data_direction direction, unsigned long attrs)
 {
 	struct ioc *ioc;
 	unsigned long flags; 
@@ -844,7 +844,7 @@ ccio_unmap_page(struct device *dev, dma_addr_t iova, size_t size,
  */
 static void * 
 ccio_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle, gfp_t flag,
-		struct dma_attrs *attrs)
+		unsigned long attrs)
 {
       void *ret;
 #if 0
@@ -878,9 +878,9 @@ ccio_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle, gfp_t flag,
  */
 static void 
 ccio_free(struct device *dev, size_t size, void *cpu_addr,
-		dma_addr_t dma_handle, struct dma_attrs *attrs)
+		dma_addr_t dma_handle, unsigned long attrs)
 {
-	ccio_unmap_page(dev, dma_handle, size, 0, NULL);
+	ccio_unmap_page(dev, dma_handle, size, 0, 0);
 	free_pages((unsigned long)cpu_addr, get_order(size));
 }
 
@@ -907,7 +907,7 @@ ccio_free(struct device *dev, size_t size, void *cpu_addr,
  */
 static int
 ccio_map_sg(struct device *dev, struct scatterlist *sglist, int nents, 
-	    enum dma_data_direction direction, struct dma_attrs *attrs)
+	    enum dma_data_direction direction, unsigned long attrs)
 {
 	struct ioc *ioc;
 	int coalesced, filled = 0;
@@ -984,7 +984,7 @@ ccio_map_sg(struct device *dev, struct scatterlist *sglist, int nents,
  */
 static void 
 ccio_unmap_sg(struct device *dev, struct scatterlist *sglist, int nents, 
-	      enum dma_data_direction direction, struct dma_attrs *attrs)
+	      enum dma_data_direction direction, unsigned long attrs)
 {
 	struct ioc *ioc;
 
@@ -1004,7 +1004,7 @@ ccio_unmap_sg(struct device *dev, struct scatterlist *sglist, int nents,
 		ioc->usg_pages += sg_dma_len(sglist) >> PAGE_SHIFT;
 #endif
 		ccio_unmap_page(dev, sg_dma_address(sglist),
-				  sg_dma_len(sglist), direction, NULL);
+				  sg_dma_len(sglist), direction, 0);
 		++sglist;
 	}
 
diff --git a/drivers/parisc/sba_iommu.c b/drivers/parisc/sba_iommu.c
index 42ec4600b7e4..151b86b6d2e2 100644
--- a/drivers/parisc/sba_iommu.c
+++ b/drivers/parisc/sba_iommu.c
@@ -783,7 +783,7 @@ sba_map_single(struct device *dev, void *addr, size_t size,
 static dma_addr_t
 sba_map_page(struct device *dev, struct page *page, unsigned long offset,
 		size_t size, enum dma_data_direction direction,
-		struct dma_attrs *attrs)
+		unsigned long attrs)
 {
 	return sba_map_single(dev, page_address(page) + offset, size,
 			direction);
@@ -801,7 +801,7 @@ sba_map_page(struct device *dev, struct page *page, unsigned long offset,
  */
 static void
 sba_unmap_page(struct device *dev, dma_addr_t iova, size_t size,
-		enum dma_data_direction direction, struct dma_attrs *attrs)
+		enum dma_data_direction direction, unsigned long attrs)
 {
 	struct ioc *ioc;
 #if DELAYED_RESOURCE_CNT > 0
@@ -876,7 +876,7 @@ sba_unmap_page(struct device *dev, dma_addr_t iova, size_t size,
  * See Documentation/DMA-API-HOWTO.txt
  */
 static void *sba_alloc(struct device *hwdev, size_t size, dma_addr_t *dma_handle,
-		gfp_t gfp, struct dma_attrs *attrs)
+		gfp_t gfp, unsigned long attrs)
 {
 	void *ret;
 
@@ -908,9 +908,9 @@ static void *sba_alloc(struct device *hwdev, size_t size, dma_addr_t *dma_handle
  */
 static void
 sba_free(struct device *hwdev, size_t size, void *vaddr,
-		    dma_addr_t dma_handle, struct dma_attrs *attrs)
+		    dma_addr_t dma_handle, unsigned long attrs)
 {
-	sba_unmap_page(hwdev, dma_handle, size, 0, NULL);
+	sba_unmap_page(hwdev, dma_handle, size, 0, 0);
 	free_pages((unsigned long) vaddr, get_order(size));
 }
 
@@ -943,7 +943,7 @@ int dump_run_sg = 0;
  */
 static int
 sba_map_sg(struct device *dev, struct scatterlist *sglist, int nents,
-	   enum dma_data_direction direction, struct dma_attrs *attrs)
+	   enum dma_data_direction direction, unsigned long attrs)
 {
 	struct ioc *ioc;
 	int coalesced, filled = 0;
@@ -1026,7 +1026,7 @@ sba_map_sg(struct device *dev, struct scatterlist *sglist, int nents,
  */
 static void 
 sba_unmap_sg(struct device *dev, struct scatterlist *sglist, int nents,
-	     enum dma_data_direction direction, struct dma_attrs *attrs)
+	     enum dma_data_direction direction, unsigned long attrs)
 {
 	struct ioc *ioc;
 #ifdef ASSERT_PDIR_SANITY
@@ -1051,7 +1051,7 @@ sba_unmap_sg(struct device *dev, struct scatterlist *sglist, int nents,
 	while (sg_dma_len(sglist) && nents--) {
 
 		sba_unmap_page(dev, sg_dma_address(sglist), sg_dma_len(sglist),
-				direction, NULL);
+				direction, 0);
 #ifdef SBA_COLLECT_STATS
 		ioc->usg_pages += ((sg_dma_address(sglist) & ~IOVP_MASK) + sg_dma_len(sglist) + IOVP_SIZE - 1) >> PAGE_SHIFT;
 		ioc->usingle_calls--;	/* kluge since call is unmap_sg() */
-- 
1.9.1
