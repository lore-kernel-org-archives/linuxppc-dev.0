Date: Fri, 14 Jun 2002 15:57:11 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: consistent_free()
Message-ID: <20020614055711.GA1124@zax>
References: <20020614042928.GK26146@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020614042928.GK26146@zax>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Jun 14, 2002 at 02:29:28PM +1000, David Gibson wrote:
>
> In attempting to make consistent_alloc/free() work sensibly on
> processors which are cache coherent I ran into a problem.
> consistent_free() doesn't take a size argument.  We don't need it in
> the case of not cache coherent processors - in that case
> consistent_alloc() sets up a vm_area() so there's enough information
> to get the size.  However for cache coherent processors we probably
> want consistent_alloc() to degenerate to __get_free_pages(), in which
> case consistent_free() must degenerate to free_pages(), which takes a
> size argument.
>
> I suggest we change consistent_free() to take the virtual addresss,
> size and the physical address (dma_addr_t), which will make our
> consistent_free() match the one on ARM.  I know we don't need the
> third argument in any existing situation.
>
> Patch coming...

As promised...

This boots up fine on my EP405PC board, and I'm sending this mail from
my TiBook running 2_4_devel with this patch and also the 40x large
page PMD patch.

diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/kernel/pci-dma.c linux-grinch/arch/ppc/kernel/pci-dma.c
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/kernel/pci-dma.c	Fri Jun 14 07:57:36 2002
+++ linux-grinch/arch/ppc/kernel/pci-dma.c	Fri Jun 14 14:30:36 2002
@@ -25,28 +25,16 @@

 	if (hwdev == NULL || hwdev->dma_mask != 0xffffffff)
 		gfp |= GFP_DMA;
-
-#ifdef CONFIG_NOT_COHERENT_CACHE
 	ret = consistent_alloc(gfp, size, dma_handle);
-#else
-	ret = (void *)__get_free_pages(gfp, get_order(size));
-#endif

-	if (ret != NULL) {
+	if (ret != NULL)
 		memset(ret, 0, size);
-#ifndef CONFIG_NOT_COHERENT_CACHE
-		*dma_handle = virt_to_bus(ret);
-#endif
-	}
+
 	return ret;
 }

 void pci_free_consistent(struct pci_dev *hwdev, size_t size,
 			 void *vaddr, dma_addr_t dma_handle)
 {
-#ifdef CONFIG_NOT_COHERENT_CACHE
-	consistent_free(vaddr);
-#else
-	free_pages((unsigned long)vaddr, get_order(size));
-#endif
+	consistent_free(vaddr, size, dma_handle);
 }
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/kernel/ppc4xx_dma.c linux-grinch/arch/ppc/kernel/ppc4xx_dma.c
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/kernel/ppc4xx_dma.c	Fri Jun  7 15:26:47 2002
+++ linux-grinch/arch/ppc/kernel/ppc4xx_dma.c	Fri Jun 14 14:36:12 2002
@@ -457,6 +457,7 @@
 free_dma_handle(sgl_handle_t handle)
 {
 	sgl_list_info_t *psgl = (sgl_list_info_t *) handle;
+	dma_addr_t dma_addr;

 	if (!handle) {
 #ifdef DEBUG_4xxDMA
@@ -475,7 +476,8 @@
 		return;
 	}

-	consistent_free((void *) psgl);
+	dma_addr = psql->dma_addr;
+	consistent_free((void *) psgl, DMA_PPC4xx_SIZE, dma_addr);
 }

 EXPORT_SYMBOL(hw_init_dma_channel);
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/mm/cachemap.c linux-grinch/arch/ppc/mm/cachemap.c
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/mm/cachemap.c	Thu Jun 13 13:40:03 2002
+++ linux-grinch/arch/ppc/mm/cachemap.c	Fri Jun 14 15:54:36 2002
@@ -121,7 +121,7 @@
 /*
  * free page(s) as defined by the above mapping.
  */
-void consistent_free(void *vaddr)
+void consistent_free(void *vaddr, size_t size, dma_addr_t handle)
 {
 	if (in_interrupt())
 		BUG();
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/drivers/net/ibm_ocp/ibm_ocp_enet.c linux-grinch/drivers/net/ibm_ocp/ibm_ocp_enet.c
--- /home/dgibson/kernel/linuxppc_2_4_devel/drivers/net/ibm_ocp/ibm_ocp_enet.c	Thu Jun 13 10:18:47 2002
+++ linux-grinch/drivers/net/ibm_ocp/ibm_ocp_enet.c	Fri Jun 14 14:39:09 2002
@@ -1185,8 +1185,9 @@
 	/*
 	 * Unmap the non cached memory space.
 	 */
-	consistent_free((void *) tx_virt_addr);
-	consistent_free((void *) rx_virt_addr);
+
+	consistent_free(tx_virt_addr, PAGE_SIZE * emac_max, tx_phys_addr);
+	consistent_free(rx_virt_addr, PAGE_SIZE * emac_max, rx_phys_addr);

 }

diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/include/asm-ppc/io.h linux-grinch/include/asm-ppc/io.h
--- /home/dgibson/kernel/linuxppc_2_4_devel/include/asm-ppc/io.h	Sat May 11 02:02:08 2002
+++ linux-grinch/include/asm-ppc/io.h	Fri Jun 14 14:54:20 2002
@@ -436,7 +436,7 @@
  * to ensure it is consistent.
  */
 extern void *consistent_alloc(int gfp, size_t size, dma_addr_t *handle);
-extern void consistent_free(void *vaddr);
+extern void consistent_free(void *vaddr, size_t size, dma_addr_t handle);
 extern void consistent_sync(void *vaddr, size_t size, int rw);
 extern void consistent_sync_page(struct page *page, unsigned long offset,
 				 size_t size, int rw);
@@ -458,8 +458,17 @@
 #define dma_cache_wback(_start,_size)		do { } while (0)
 #define dma_cache_wback_inv(_start,_size)	do { } while (0)

-#define consistent_alloc(gfp, size, handle)	NULL
-#define consistent_free(addr, size)		do { } while (0)
+static inline void *consistent_alloc(int gfp, size_t size, dma_addr_t *dma_handle)
+{
+	void *vaddr;
+
+	vaddr = (void *)__get_free_pages(gfp, get_order(size));
+	if (vaddr)
+		*dma_handle = virt_to_bus(vaddr);
+	return vaddr;
+}
+
+#define consistent_free(addr, size, dmaddr)	free_pages((unsigned long)addr, get_order(size))
 #define consistent_sync(addr, size, rw)		do { } while (0)
 #define consistent_sync_page(pg, off, sz, rw)	do { } while (0)




--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
