Date: Fri, 14 Jun 2002 12:06:40 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Eugene Surovegin <ebs@innocent.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Dan Malek <dan@embeddededge.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] pci_alloc_consistent in an interrupt context
Message-ID: <20020614020640.GI26146@zax>
References: <5.1.0.14.2.20020613180327.02e11f68@pop.prodigy.net> <20020613215635.GB13541@opus.bloom.county> <5.1.0.14.2.20020613122317.02e34480@mail.zultys.com> <20020613205824.GX13541@opus.bloom.county> <3D0912F4.4020300@embeddededge.com> <20020613215635.GB13541@opus.bloom.county> <5.1.0.14.2.20020613180327.02e11f68@pop.prodigy.net> <5.1.0.14.2.20020613184104.026b9910@pop.prodigy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5.1.0.14.2.20020613184104.026b9910@pop.prodigy.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Jun 13, 2002 at 06:57:45PM -0700, Eugene Surovegin wrote:
>
> At 06:33 PM 6/13/2002, David Gibson wrote:
> >On Thu, Jun 13, 2002 at 06:25:11PM -0700, Eugene Surovegin wrote:
> >>
> >> At 05:24 PM 6/13/2002, David Gibson wrote:
> >> >That's right.  But I think the patch below is a better fix for the
> >> >problem.  It makes consistent_alloc()/consistent_free() just do the
> >> >right thing for both cache coherent and cache non-coherent processors,
> >> >so we can get rid of the ifdef in pci_alloc_consistent() and
> >> >pci_free_consistent().
> >>
> >> So, kmalloc will allocate non-cacheable memory?
> >>
> >> I seriously doubt it (actually I've just tested it:).
> >
> >No, but on cache coherent processors we don't need non-cacheable
> >memory.  That's the whole point.  Likewise with __get_free_pages()
> >which is what pci_alloc_consistent() uses on cache-coherent processors
> >now.
>
> OK, I got it :)
>
> One problem though, kmalloc allocated memory will not be necessarily
> properly aligned
> as required by DMA-mappings.txt
>
> Some PCI drivers may break because of this.

Ah, yes, indeed.  How about this:

diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/kernel/pci-dma.c linux-grinch/arch/ppc/kernel/pci-dma.c
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/kernel/pci-dma.c	Fri Jun 14 07:57:36 2002
+++ linux-grinch/arch/ppc/kernel/pci-dma.c	Fri Jun 14 10:23:01 2002
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
 	consistent_free(vaddr);
-#else
-	free_pages((unsigned long)vaddr, get_order(size));
-#endif
 }
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/include/asm-ppc/io.h linux-grinch/include/asm-ppc/io.h
--- /home/dgibson/kernel/linuxppc_2_4_devel/include/asm-ppc/io.h	Sat May 11 02:02:08 2002
+++ linux-grinch/include/asm-ppc/io.h	Fri Jun 14 12:05:35 2002
@@ -458,8 +458,17 @@
 #define dma_cache_wback(_start,_size)		do { } while (0)
 #define dma_cache_wback_inv(_start,_size)	do { } while (0)

-#define consistent_alloc(gfp, size, handle)	NULL
-#define consistent_free(addr, size)		do { } while (0)
+static inline void *consistent_alloc(int gfp, size_t size, dma_addr_t *dma_handle)
+{
+	unsigned long vaddr;
+
+	vaddr = __get_free_pages(gfp, get_order(size));
+	if (vaddr)
+		*dma_handle = virt_to_bus(vaddr);
+	return (void *)vaddr;
+}
+
+#define consistent_free(addr, size)		kfree(addr)
 #define consistent_sync(addr, size, rw)		do { } while (0)
 #define consistent_sync_page(pg, off, sz, rw)	do { } while (0)



--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
