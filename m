Return-Path: <k.kozlowski@samsung.com>
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rLBJv291zzDqgj
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jun 2016 01:41:03 +1000 (AEST)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0O8500DRFI8E1J40@mailout2.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Thu, 02 Jun 2016 16:41:02 +0100 (BST)
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
Subject: [RFC v3 12/45] drm/exynos: dma-mapping: Use unsigned long for
 dma_attrs
Date: Thu, 02 Jun 2016 17:39:14 +0200
Message-id: <1464881987-13203-13-git-send-email-k.kozlowski@samsung.com>
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
 drivers/gpu/drm/exynos/exynos_drm_fbdev.c |  2 +-
 drivers/gpu/drm/exynos/exynos_drm_g2d.c   | 12 +++++-------
 drivers/gpu/drm/exynos/exynos_drm_gem.c   | 20 ++++++++++----------
 drivers/gpu/drm/exynos/exynos_drm_gem.h   |  2 +-
 4 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
index 67dcd6831291..dd091175fc2d 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
@@ -52,7 +52,7 @@ static int exynos_drm_fb_mmap(struct fb_info *info,
 
 	ret = dma_mmap_attrs(to_dma_dev(helper->dev), vma, exynos_gem->cookie,
 			     exynos_gem->dma_addr, exynos_gem->size,
-			     &exynos_gem->dma_attrs);
+			     exynos_gem->dma_attrs);
 	if (ret < 0) {
 		DRM_ERROR("failed to mmap.\n");
 		return ret;
diff --git a/drivers/gpu/drm/exynos/exynos_drm_g2d.c b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
index 493552368295..15539aea8415 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_g2d.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
@@ -17,7 +17,6 @@
 #include <linux/slab.h>
 #include <linux/workqueue.h>
 #include <linux/dma-mapping.h>
-#include <linux/dma-attrs.h>
 #include <linux/of.h>
 
 #include <drm/drmP.h>
@@ -235,7 +234,7 @@ struct g2d_data {
 	struct mutex			cmdlist_mutex;
 	dma_addr_t			cmdlist_pool;
 	void				*cmdlist_pool_virt;
-	struct dma_attrs		cmdlist_dma_attrs;
+	unsigned long			cmdlist_dma_attrs;
 
 	/* runqueue*/
 	struct g2d_runqueue_node	*runqueue_node;
@@ -256,13 +255,12 @@ static int g2d_init_cmdlist(struct g2d_data *g2d)
 	int ret;
 	struct g2d_buf_info *buf_info;
 
-	init_dma_attrs(&g2d->cmdlist_dma_attrs);
-	dma_set_attr(DMA_ATTR_WRITE_COMBINE, &g2d->cmdlist_dma_attrs);
+	g2d->cmdlist_dma_attrs = DMA_ATTR_WRITE_COMBINE;
 
 	g2d->cmdlist_pool_virt = dma_alloc_attrs(to_dma_dev(subdrv->drm_dev),
 						G2D_CMDLIST_POOL_SIZE,
 						&g2d->cmdlist_pool, GFP_KERNEL,
-						&g2d->cmdlist_dma_attrs);
+						g2d->cmdlist_dma_attrs);
 	if (!g2d->cmdlist_pool_virt) {
 		dev_err(dev, "failed to allocate dma memory\n");
 		return -ENOMEM;
@@ -295,7 +293,7 @@ static int g2d_init_cmdlist(struct g2d_data *g2d)
 err:
 	dma_free_attrs(to_dma_dev(subdrv->drm_dev), G2D_CMDLIST_POOL_SIZE,
 			g2d->cmdlist_pool_virt,
-			g2d->cmdlist_pool, &g2d->cmdlist_dma_attrs);
+			g2d->cmdlist_pool, g2d->cmdlist_dma_attrs);
 	return ret;
 }
 
@@ -309,7 +307,7 @@ static void g2d_fini_cmdlist(struct g2d_data *g2d)
 		dma_free_attrs(to_dma_dev(subdrv->drm_dev),
 				G2D_CMDLIST_POOL_SIZE,
 				g2d->cmdlist_pool_virt,
-				g2d->cmdlist_pool, &g2d->cmdlist_dma_attrs);
+				g2d->cmdlist_pool, g2d->cmdlist_dma_attrs);
 	}
 }
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_gem.c b/drivers/gpu/drm/exynos/exynos_drm_gem.c
index cdf9f1af4347..f2ae72ba7d5a 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_gem.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_gem.c
@@ -24,7 +24,7 @@
 static int exynos_drm_alloc_buf(struct exynos_drm_gem *exynos_gem)
 {
 	struct drm_device *dev = exynos_gem->base.dev;
-	enum dma_attr attr;
+	unsigned long attr;
 	unsigned int nr_pages;
 	struct sg_table sgt;
 	int ret = -ENOMEM;
@@ -34,7 +34,7 @@ static int exynos_drm_alloc_buf(struct exynos_drm_gem *exynos_gem)
 		return 0;
 	}
 
-	init_dma_attrs(&exynos_gem->dma_attrs);
+	exynos_gem->dma_attrs = 0;
 
 	/*
 	 * if EXYNOS_BO_CONTIG, fully physically contiguous memory
@@ -42,7 +42,7 @@ static int exynos_drm_alloc_buf(struct exynos_drm_gem *exynos_gem)
 	 * as possible.
 	 */
 	if (!(exynos_gem->flags & EXYNOS_BO_NONCONTIG))
-		dma_set_attr(DMA_ATTR_FORCE_CONTIGUOUS, &exynos_gem->dma_attrs);
+		exynos_gem->dma_attrs |= DMA_ATTR_FORCE_CONTIGUOUS;
 
 	/*
 	 * if EXYNOS_BO_WC or EXYNOS_BO_NONCACHABLE, writecombine mapping
@@ -54,8 +54,8 @@ static int exynos_drm_alloc_buf(struct exynos_drm_gem *exynos_gem)
 	else
 		attr = DMA_ATTR_NON_CONSISTENT;
 
-	dma_set_attr(attr, &exynos_gem->dma_attrs);
-	dma_set_attr(DMA_ATTR_NO_KERNEL_MAPPING, &exynos_gem->dma_attrs);
+	exynos_gem->dma_attrs |= attr;
+	exynos_gem->dma_attrs |= DMA_ATTR_NO_KERNEL_MAPPING;
 
 	nr_pages = exynos_gem->size >> PAGE_SHIFT;
 
@@ -67,7 +67,7 @@ static int exynos_drm_alloc_buf(struct exynos_drm_gem *exynos_gem)
 
 	exynos_gem->cookie = dma_alloc_attrs(to_dma_dev(dev), exynos_gem->size,
 					     &exynos_gem->dma_addr, GFP_KERNEL,
-					     &exynos_gem->dma_attrs);
+					     exynos_gem->dma_attrs);
 	if (!exynos_gem->cookie) {
 		DRM_ERROR("failed to allocate buffer.\n");
 		goto err_free;
@@ -75,7 +75,7 @@ static int exynos_drm_alloc_buf(struct exynos_drm_gem *exynos_gem)
 
 	ret = dma_get_sgtable_attrs(to_dma_dev(dev), &sgt, exynos_gem->cookie,
 				    exynos_gem->dma_addr, exynos_gem->size,
-				    &exynos_gem->dma_attrs);
+				    exynos_gem->dma_attrs);
 	if (ret < 0) {
 		DRM_ERROR("failed to get sgtable.\n");
 		goto err_dma_free;
@@ -99,7 +99,7 @@ err_sgt_free:
 	sg_free_table(&sgt);
 err_dma_free:
 	dma_free_attrs(to_dma_dev(dev), exynos_gem->size, exynos_gem->cookie,
-		       exynos_gem->dma_addr, &exynos_gem->dma_attrs);
+		       exynos_gem->dma_addr, exynos_gem->dma_attrs);
 err_free:
 	drm_free_large(exynos_gem->pages);
 
@@ -120,7 +120,7 @@ static void exynos_drm_free_buf(struct exynos_drm_gem *exynos_gem)
 
 	dma_free_attrs(to_dma_dev(dev), exynos_gem->size, exynos_gem->cookie,
 			(dma_addr_t)exynos_gem->dma_addr,
-			&exynos_gem->dma_attrs);
+			exynos_gem->dma_attrs);
 
 	drm_free_large(exynos_gem->pages);
 }
@@ -346,7 +346,7 @@ static int exynos_drm_gem_mmap_buffer(struct exynos_drm_gem *exynos_gem,
 
 	ret = dma_mmap_attrs(to_dma_dev(drm_dev), vma, exynos_gem->cookie,
 			     exynos_gem->dma_addr, exynos_gem->size,
-			     &exynos_gem->dma_attrs);
+			     exynos_gem->dma_attrs);
 	if (ret < 0) {
 		DRM_ERROR("failed to mmap.\n");
 		return ret;
diff --git a/drivers/gpu/drm/exynos/exynos_drm_gem.h b/drivers/gpu/drm/exynos/exynos_drm_gem.h
index 78100742281d..df7c543d6558 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_gem.h
+++ b/drivers/gpu/drm/exynos/exynos_drm_gem.h
@@ -50,7 +50,7 @@ struct exynos_drm_gem {
 	void			*cookie;
 	void __iomem		*kvaddr;
 	dma_addr_t		dma_addr;
-	struct dma_attrs	dma_attrs;
+	unsigned long		dma_attrs;
 	struct page		**pages;
 	struct sg_table		*sgt;
 };
-- 
1.9.1
