Return-Path: <k.kozlowski@samsung.com>
Received: from mailout4.w1.samsung.com (mailout4.w1.samsung.com
 [210.118.77.14])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rLBKN20TrzDqgj
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jun 2016 01:41:28 +1000 (AEST)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0O8500AJTI8ZB610@mailout4.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Thu, 02 Jun 2016 16:41:24 +0100 (BST)
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
Subject: [RFC v3 19/45] [media] dma-mapping: Use unsigned long for dma_attrs
Date: Thu, 02 Jun 2016 17:39:21 +0200
Message-id: <1464881987-13203-20-git-send-email-k.kozlowski@samsung.com>
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
 drivers/media/platform/sti/bdisp/bdisp-hw.c    | 26 +++++++---------------
 drivers/media/v4l2-core/videobuf2-dma-contig.c | 30 +++++++++++---------------
 drivers/media/v4l2-core/videobuf2-dma-sg.c     | 19 ++++------------
 include/media/videobuf2-dma-contig.h           |  7 ++----
 4 files changed, 26 insertions(+), 56 deletions(-)

diff --git a/drivers/media/platform/sti/bdisp/bdisp-hw.c b/drivers/media/platform/sti/bdisp/bdisp-hw.c
index 052c932ac942..1600958939a5 100644
--- a/drivers/media/platform/sti/bdisp/bdisp-hw.c
+++ b/drivers/media/platform/sti/bdisp/bdisp-hw.c
@@ -125,14 +125,11 @@ int bdisp_hw_get_and_clear_irq(struct bdisp_dev *bdisp)
  */
 void bdisp_hw_free_nodes(struct bdisp_ctx *ctx)
 {
-	if (ctx && ctx->node[0]) {
-		DEFINE_DMA_ATTRS(attrs);
-
-		dma_set_attr(DMA_ATTR_WRITE_COMBINE, &attrs);
+	if (ctx && ctx->node[0])
 		dma_free_attrs(ctx->bdisp_dev->dev,
 			       sizeof(struct bdisp_node) * MAX_NB_NODE,
-			       ctx->node[0], ctx->node_paddr[0], &attrs);
-	}
+			       ctx->node[0], ctx->node_paddr[0],
+			       DMA_ATTR_WRITE_COMBINE);
 }
 
 /**
@@ -150,12 +147,10 @@ int bdisp_hw_alloc_nodes(struct bdisp_ctx *ctx)
 	unsigned int i, node_size = sizeof(struct bdisp_node);
 	void *base;
 	dma_addr_t paddr;
-	DEFINE_DMA_ATTRS(attrs);
 
 	/* Allocate all the nodes within a single memory page */
-	dma_set_attr(DMA_ATTR_WRITE_COMBINE, &attrs);
 	base = dma_alloc_attrs(dev, node_size * MAX_NB_NODE, &paddr,
-			       GFP_KERNEL | GFP_DMA, &attrs);
+			       GFP_KERNEL | GFP_DMA, DMA_ATTR_WRITE_COMBINE);
 	if (!base) {
 		dev_err(dev, "%s no mem\n", __func__);
 		return -ENOMEM;
@@ -188,13 +183,9 @@ void bdisp_hw_free_filters(struct device *dev)
 {
 	int size = (BDISP_HF_NB * NB_H_FILTER) + (BDISP_VF_NB * NB_V_FILTER);
 
-	if (bdisp_h_filter[0].virt) {
-		DEFINE_DMA_ATTRS(attrs);
-
-		dma_set_attr(DMA_ATTR_WRITE_COMBINE, &attrs);
+	if (bdisp_h_filter[0].virt)
 		dma_free_attrs(dev, size, bdisp_h_filter[0].virt,
-			       bdisp_h_filter[0].paddr, &attrs);
-	}
+			       bdisp_h_filter[0].paddr,DMA_ATTR_WRITE_COMBINE);
 }
 
 /**
@@ -211,12 +202,11 @@ int bdisp_hw_alloc_filters(struct device *dev)
 	unsigned int i, size;
 	void *base;
 	dma_addr_t paddr;
-	DEFINE_DMA_ATTRS(attrs);
 
 	/* Allocate all the filters within a single memory page */
 	size = (BDISP_HF_NB * NB_H_FILTER) + (BDISP_VF_NB * NB_V_FILTER);
-	dma_set_attr(DMA_ATTR_WRITE_COMBINE, &attrs);
-	base = dma_alloc_attrs(dev, size, &paddr, GFP_KERNEL | GFP_DMA, &attrs);
+	base = dma_alloc_attrs(dev, size, &paddr, GFP_KERNEL | GFP_DMA,
+			       DMA_ATTR_WRITE_COMBINE);
 	if (!base)
 		return -ENOMEM;
 
diff --git a/drivers/media/v4l2-core/videobuf2-dma-contig.c b/drivers/media/v4l2-core/videobuf2-dma-contig.c
index 5361197f3e57..8009a582326b 100644
--- a/drivers/media/v4l2-core/videobuf2-dma-contig.c
+++ b/drivers/media/v4l2-core/videobuf2-dma-contig.c
@@ -23,7 +23,7 @@
 
 struct vb2_dc_conf {
 	struct device		*dev;
-	struct dma_attrs	attrs;
+	unsigned long		attrs;
 };
 
 struct vb2_dc_buf {
@@ -32,7 +32,7 @@ struct vb2_dc_buf {
 	unsigned long			size;
 	void				*cookie;
 	dma_addr_t			dma_addr;
-	struct dma_attrs		attrs;
+	unsigned long			attrs;
 	enum dma_data_direction		dma_dir;
 	struct sg_table			*dma_sgt;
 	struct frame_vector		*vec;
@@ -135,7 +135,7 @@ static void vb2_dc_put(void *buf_priv)
 		kfree(buf->sgt_base);
 	}
 	dma_free_attrs(buf->dev, buf->size, buf->cookie, buf->dma_addr,
-			&buf->attrs);
+		       buf->attrs);
 	put_device(buf->dev);
 	kfree(buf);
 }
@@ -153,14 +153,14 @@ static void *vb2_dc_alloc(void *alloc_ctx, unsigned long size,
 
 	buf->attrs = conf->attrs;
 	buf->cookie = dma_alloc_attrs(dev, size, &buf->dma_addr,
-					GFP_KERNEL | gfp_flags, &buf->attrs);
+					GFP_KERNEL | gfp_flags, buf->attrs);
 	if (!buf->cookie) {
 		dev_err(dev, "dma_alloc_coherent of size %ld failed\n", size);
 		kfree(buf);
 		return ERR_PTR(-ENOMEM);
 	}
 
-	if (!dma_get_attr(DMA_ATTR_NO_KERNEL_MAPPING, &buf->attrs))
+	if (!dma_get_attr(DMA_ATTR_NO_KERNEL_MAPPING, buf->attrs))
 		buf->vaddr = buf->cookie;
 
 	/* Prevent the device from being released while the buffer is used */
@@ -194,7 +194,7 @@ static int vb2_dc_mmap(void *buf_priv, struct vm_area_struct *vma)
 	vma->vm_pgoff = 0;
 
 	ret = dma_mmap_attrs(buf->dev, vma, buf->cookie,
-		buf->dma_addr, buf->size, &buf->attrs);
+		buf->dma_addr, buf->size, buf->attrs);
 
 	if (ret) {
 		pr_err("Remapping memory failed, error: %d\n", ret);
@@ -377,7 +377,7 @@ static struct sg_table *vb2_dc_get_base_sgt(struct vb2_dc_buf *buf)
 	}
 
 	ret = dma_get_sgtable_attrs(buf->dev, sgt, buf->cookie, buf->dma_addr,
-		buf->size, &buf->attrs);
+		buf->size, buf->attrs);
 	if (ret < 0) {
 		dev_err(buf->dev, "failed to get scatterlist from DMA API\n");
 		kfree(sgt);
@@ -426,15 +426,12 @@ static void vb2_dc_put_userptr(void *buf_priv)
 	struct page **pages;
 
 	if (sgt) {
-		DEFINE_DMA_ATTRS(attrs);
-
-		dma_set_attr(DMA_ATTR_SKIP_CPU_SYNC, &attrs);
 		/*
 		 * No need to sync to CPU, it's already synced to the CPU
 		 * since the finish() memop will have been called before this.
 		 */
 		dma_unmap_sg_attrs(buf->dev, sgt->sgl, sgt->orig_nents,
-				   buf->dma_dir, &attrs);
+				   buf->dma_dir, DMA_ATTR_SKIP_CPU_SYNC);
 		pages = frame_vector_pages(buf->vec);
 		/* sgt should exist only if vector contains pages... */
 		BUG_ON(IS_ERR(pages));
@@ -490,9 +487,6 @@ static void *vb2_dc_get_userptr(void *alloc_ctx, unsigned long vaddr,
 	struct sg_table *sgt;
 	unsigned long contig_size;
 	unsigned long dma_align = dma_get_cache_alignment();
-	DEFINE_DMA_ATTRS(attrs);
-
-	dma_set_attr(DMA_ATTR_SKIP_CPU_SYNC, &attrs);
 
 	/* Only cache aligned DMA transfers are reliable */
 	if (!IS_ALIGNED(vaddr | size, dma_align)) {
@@ -554,7 +548,7 @@ static void *vb2_dc_get_userptr(void *alloc_ctx, unsigned long vaddr,
 	 * prepare() memop is called.
 	 */
 	sgt->nents = dma_map_sg_attrs(buf->dev, sgt->sgl, sgt->orig_nents,
-				      buf->dma_dir, &attrs);
+				      buf->dma_dir, DMA_ATTR_SKIP_CPU_SYNC);
 	if (sgt->nents <= 0) {
 		pr_err("failed to map scatterlist\n");
 		ret = -EIO;
@@ -578,7 +572,7 @@ out:
 
 fail_map_sg:
 	dma_unmap_sg_attrs(buf->dev, sgt->sgl, sgt->orig_nents,
-			   buf->dma_dir, &attrs);
+			   buf->dma_dir, DMA_ATTR_SKIP_CPU_SYNC);
 
 fail_sgt_init:
 	sg_free_table(sgt);
@@ -730,7 +724,7 @@ const struct vb2_mem_ops vb2_dma_contig_memops = {
 EXPORT_SYMBOL_GPL(vb2_dma_contig_memops);
 
 void *vb2_dma_contig_init_ctx_attrs(struct device *dev,
-				    struct dma_attrs *attrs)
+				    unsigned long attrs)
 {
 	struct vb2_dc_conf *conf;
 
@@ -740,7 +734,7 @@ void *vb2_dma_contig_init_ctx_attrs(struct device *dev,
 
 	conf->dev = dev;
 	if (attrs)
-		conf->attrs = *attrs;
+		conf->attrs = attrs;
 
 	return conf;
 }
diff --git a/drivers/media/v4l2-core/videobuf2-dma-sg.c b/drivers/media/v4l2-core/videobuf2-dma-sg.c
index 9985c89f0513..94f24e610fe7 100644
--- a/drivers/media/v4l2-core/videobuf2-dma-sg.c
+++ b/drivers/media/v4l2-core/videobuf2-dma-sg.c
@@ -107,9 +107,6 @@ static void *vb2_dma_sg_alloc(void *alloc_ctx, unsigned long size,
 	struct sg_table *sgt;
 	int ret;
 	int num_pages;
-	DEFINE_DMA_ATTRS(attrs);
-
-	dma_set_attr(DMA_ATTR_SKIP_CPU_SYNC, &attrs);
 
 	if (WARN_ON(alloc_ctx == NULL))
 		return NULL;
@@ -148,7 +145,7 @@ static void *vb2_dma_sg_alloc(void *alloc_ctx, unsigned long size,
 	 * prepare() memop is called.
 	 */
 	sgt->nents = dma_map_sg_attrs(buf->dev, sgt->sgl, sgt->orig_nents,
-				      buf->dma_dir, &attrs);
+				      buf->dma_dir, DMA_ATTR_SKIP_CPU_SYNC);
 	if (!sgt->nents)
 		goto fail_map;
 
@@ -183,13 +180,10 @@ static void vb2_dma_sg_put(void *buf_priv)
 	int i = buf->num_pages;
 
 	if (atomic_dec_and_test(&buf->refcount)) {
-		DEFINE_DMA_ATTRS(attrs);
-
-		dma_set_attr(DMA_ATTR_SKIP_CPU_SYNC, &attrs);
 		dprintk(1, "%s: Freeing buffer of %d pages\n", __func__,
 			buf->num_pages);
 		dma_unmap_sg_attrs(buf->dev, sgt->sgl, sgt->orig_nents,
-				   buf->dma_dir, &attrs);
+				   buf->dma_dir, DMA_ATTR_SKIP_CPU_SYNC);
 		if (buf->vaddr)
 			vm_unmap_ram(buf->vaddr, buf->num_pages);
 		sg_free_table(buf->dma_sgt);
@@ -233,10 +227,8 @@ static void *vb2_dma_sg_get_userptr(void *alloc_ctx, unsigned long vaddr,
 	struct vb2_dma_sg_conf *conf = alloc_ctx;
 	struct vb2_dma_sg_buf *buf;
 	struct sg_table *sgt;
-	DEFINE_DMA_ATTRS(attrs);
 	struct frame_vector *vec;
 
-	dma_set_attr(DMA_ATTR_SKIP_CPU_SYNC, &attrs);
 	buf = kzalloc(sizeof *buf, GFP_KERNEL);
 	if (!buf)
 		return NULL;
@@ -267,7 +259,7 @@ static void *vb2_dma_sg_get_userptr(void *alloc_ctx, unsigned long vaddr,
 	 * prepare() memop is called.
 	 */
 	sgt->nents = dma_map_sg_attrs(buf->dev, sgt->sgl, sgt->orig_nents,
-				      buf->dma_dir, &attrs);
+				      buf->dma_dir, DMA_ATTR_SKIP_CPU_SYNC);
 	if (!sgt->nents)
 		goto userptr_fail_map;
 
@@ -291,14 +283,11 @@ static void vb2_dma_sg_put_userptr(void *buf_priv)
 	struct vb2_dma_sg_buf *buf = buf_priv;
 	struct sg_table *sgt = &buf->sg_table;
 	int i = buf->num_pages;
-	DEFINE_DMA_ATTRS(attrs);
-
-	dma_set_attr(DMA_ATTR_SKIP_CPU_SYNC, &attrs);
 
 	dprintk(1, "%s: Releasing userspace buffer of %d pages\n",
 	       __func__, buf->num_pages);
 	dma_unmap_sg_attrs(buf->dev, sgt->sgl, sgt->orig_nents, buf->dma_dir,
-			   &attrs);
+			   DMA_ATTR_SKIP_CPU_SYNC);
 	if (buf->vaddr)
 		vm_unmap_ram(buf->vaddr, buf->num_pages);
 	sg_free_table(buf->dma_sgt);
diff --git a/include/media/videobuf2-dma-contig.h b/include/media/videobuf2-dma-contig.h
index 2087c9a68be3..048df1320451 100644
--- a/include/media/videobuf2-dma-contig.h
+++ b/include/media/videobuf2-dma-contig.h
@@ -16,8 +16,6 @@
 #include <media/videobuf2-v4l2.h>
 #include <linux/dma-mapping.h>
 
-struct dma_attrs;
-
 static inline dma_addr_t
 vb2_dma_contig_plane_dma_addr(struct vb2_buffer *vb, unsigned int plane_no)
 {
@@ -26,12 +24,11 @@ vb2_dma_contig_plane_dma_addr(struct vb2_buffer *vb, unsigned int plane_no)
 	return *addr;
 }
 
-void *vb2_dma_contig_init_ctx_attrs(struct device *dev,
-				    struct dma_attrs *attrs);
+void *vb2_dma_contig_init_ctx_attrs(struct device *dev, unsigned long attrs);
 
 static inline void *vb2_dma_contig_init_ctx(struct device *dev)
 {
-	return vb2_dma_contig_init_ctx_attrs(dev, NULL);
+	return vb2_dma_contig_init_ctx_attrs(dev, 0);
 }
 
 void vb2_dma_contig_cleanup_ctx(void *alloc_ctx);
-- 
1.9.1
