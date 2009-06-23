Return-Path: <gerhard_pircher@gmx.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E3349B710D
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Jun 2009 18:56:02 +1000 (EST)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 766A6DDDD4
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Jun 2009 18:56:00 +1000 (EST)
Content-Type: text/plain; charset="utf-8"
Date: Tue, 23 Jun 2009 10:55:54 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <s5h8wjkoi70.wl%tiwai@suse.de>
Message-ID: <20090623085554.9200@gmx.net>
MIME-Version: 1.0
References: <20090621181855.74980@gmx.net>	<1245623678.16880.27.camel@pasglop>
	<s5h8wjkoi70.wl%tiwai@suse.de>
Subject: Re: ALSA fixes for non-coherent ppc32 again
To: Takashi Iwai <tiwai@suse.de>, benh@kernel.crashing.org
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
> Datum: Mon, 22 Jun 2009 09:12:35 +0200
> Von: Takashi Iwai <tiwai@suse.de>
> An: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: Gerhard Pircher <gerhard_pircher@gmx.net>, linuxppc-dev@ozlabs.org
> Betreff: Re: ALSA fixes for non-coherent ppc32 again

> But, it'd be helpful if someone can test the patches above beforehand,
> of course :)
Okay, I checked out your test/dma-fix branch and reformatted your
dma_mmap_coherent for powerpc patch ( http://www.nabble.com/-PATCH-0-3--ALSA-fixes-for-non-coherent-ppc32-to17980027.html#a17980027 ) to
adapt it for dma_mapping_ops (please take a look at the patch below).
I also had to change "def_bool n" to "def_bool y" for SND_NONCOHERENT_DMA
to actually enable it.

Unfortunately the build process stops with these error messages here
(but compiles fine, if SND_COHERENT_DMA is not selected):

  CC [M]  sound/core/memalloc.o
  CC [M]  sound/core/sgbuf.o
sound/core/sgbuf.c: In function ‘snd_free_sgbuf_pages’:
sound/core/sgbuf.c:46: error: dereferencing pointer to incomplete type
sound/core/sgbuf.c:47: error: dereferencing pointer to incomplete type
sound/core/sgbuf.c:48: error: dereferencing pointer to incomplete type
sound/core/sgbuf.c:50: error: dereferencing pointer to incomplete type
sound/core/sgbuf.c:51: error: dereferencing pointer to incomplete type
sound/core/sgbuf.c:52: error: dereferencing pointer to incomplete type
sound/core/sgbuf.c:56: error: dereferencing pointer to incomplete type
sound/core/sgbuf.c:57: error: dereferencing pointer to incomplete type
sound/core/sgbuf.c: In function ‘snd_malloc_sgbuf_pages’:
sound/core/sgbuf.c:78: error: dereferencing pointer to incomplete type
sound/core/sgbuf.c:81: error: dereferencing pointer to incomplete type
sound/core/sgbuf.c:82: error: implicit declaration of function ‘snd_sgbuf_aligned_pages’
sound/core/sgbuf.c:83: error: dereferencing pointer to incomplete type
sound/core/sgbuf.c:84: error: dereferencing pointer to incomplete type
sound/core/sgbuf.c:84: error: dereferencing pointer to incomplete type
sound/core/sgbuf.c:87: error: dereferencing pointer to incomplete type
sound/core/sgbuf.c:88: error: dereferencing pointer to incomplete type
sound/core/sgbuf.c:91: error: dereferencing pointer to incomplete type
sound/core/sgbuf.c:103: error: dereferencing pointer to incomplete type
sound/core/sgbuf.c:107: error: dereferencing pointer to incomplete type
sound/core/sgbuf.c:112: error: dereferencing pointer to incomplete type
sound/core/sgbuf.c:113: error: dereferencing pointer to incomplete type
sound/core/sgbuf.c:115: error: dereferencing pointer to incomplete type
sound/core/sgbuf.c:116: error: increment of pointer to unknown structure
sound/core/sgbuf.c:116: error: arithmetic on pointer to an incomplete type
sound/core/sgbuf.c:121: error: dereferencing pointer to incomplete type
sound/core/sgbuf.c:127: error: dereferencing pointer to incomplete type
sound/core/sgbuf.c:128: error: dereferencing pointer to incomplete type
sound/core/sgbuf.c:128: error: dereferencing pointer to incomplete type
sound/core/sgbuf.c:132: error: dereferencing pointer to incomplete type

I also tried to compile it with the orginal dma_mmap_coherent for
powerpc patch, but that doesn't make a difference.

As the next step I applied the reformatted dma_mmap_coherent patch and
the following patches from your test/dma-fix branch to a 2.6.30-rc8
branch:
- ALSA: Remove old DMA-mmap code from arm/devdma.c
- ALSA: Fix SG-buffer DMA with non-coherent architectures
- ALSA: Fix mapping of DMA buffers

This one compiled fine, but ALSA didn't work. No kernel oops, just the
sound of silence. :)

Any idea what's wrong here or if I did something wrong?

Thanks!

Gerhard

---
 arch/powerpc/include/asm/dma-mapping.h |   14 ++++++++++++++
 arch/powerpc/kernel/dma.c              |   21 +++++++++++++++++++++
 2 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index 3d9e887..6fbeafe 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -89,6 +89,8 @@ struct dma_mapping_ops {
                 struct dma_attrs *attrs);
     int        (*addr_needs_map)(struct device *dev, dma_addr_t addr,
                 size_t size);
+    int        (*mmap_coherent)(struct device *dev, struct vm_area_struct *vma,
+                void *cpu_addr, dma_addr_t handle, size_t size);
 #ifdef CONFIG_PPC_NEED_DMA_SYNC_OPS
     void            (*sync_single_range_for_cpu)(struct device *hwdev,
                 dma_addr_t dma_handle, unsigned long offset,
@@ -301,6 +303,18 @@ static inline void dma_unmap_sg(struct device *dev, struct scatterlist *sg,
     dma_unmap_sg_attrs(dev, sg, nhwentries, direction, NULL);
 }
 
+static inline int dma_mmap_coherent(struct device *dev,
+                    struct vm_area_struct *vma,
+                    void *cpu_addr, dma_addr_t handle,
+                    size_t size)
+{
+    struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
+
+    BUG_ON(!dma_ops);
+
+    return dma_ops->mmap_coherent(dev, vma, cpu_addr, handle, size);
+}
+
 #ifdef CONFIG_PPC_NEED_DMA_SYNC_OPS
 static inline void dma_sync_single_for_cpu(struct device *dev,
         dma_addr_t dma_handle, size_t size,
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index 20a60d6..7ff3772 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -120,6 +120,26 @@ static inline void dma_direct_unmap_page(struct device *dev,
 {
 }
 
+/*
+ * A helper to mmap the pages allocated via dma_alloc_coherent()
+ */
+static inline int dma_direct_mmap_coherent(struct device *dev,
+                       struct vm_area_struct *vma,
+                       void *cpu_addr, dma_addr_t handle,
+                       size_t size)
+{
+    struct page *pg;
+
+#ifdef CONFIG_NOT_COHERENT_CACHE
+    /* I'm too lazy and can't stop using bus_to_virt() here... */
+    cpu_addr = bus_to_virt(handle);
+#endif
+    pg = virt_to_page(cpu_addr);
+    return remap_pfn_range(vma, vma->vm_start,
+                   page_to_pfn(pg) + vma->vm_pgoff,
+                   size, vma->vm_page_prot);
+}
+
 #ifdef CONFIG_NOT_COHERENT_CACHE
 static inline void dma_direct_sync_sg(struct device *dev,
         struct scatterlist *sgl, int nents,
@@ -148,6 +168,7 @@ struct dma_mapping_ops dma_direct_ops = {
     .dma_supported    = dma_direct_dma_supported,
     .map_page    = dma_direct_map_page,
     .unmap_page    = dma_direct_unmap_page,
+    .mmap_coherent    = dma_direct_mmap_coherent,
 #ifdef CONFIG_NOT_COHERENT_CACHE
     .sync_single_range_for_cpu     = dma_direct_sync_single_range,
     .sync_single_range_for_device     = dma_direct_sync_single_range,
-- 
1.5.6.5
-- 
GRATIS für alle GMX-Mitglieder: Die maxdome Movie-FLAT!
Jetzt freischalten unter http://portal.gmx.net/de/go/maxdome01
