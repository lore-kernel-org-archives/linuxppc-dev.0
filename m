Date: Fri, 14 Jun 2002 10:24:19 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Dan Malek <dan@embeddededge.com>,
	Eugene Surovegin <ebs@innocent.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] pci_alloc_consistent in an interrupt context
Message-ID: <20020614002419.GM4228@zax>
References: <5.1.0.14.2.20020613122317.02e34480@mail.zultys.com> <20020613205824.GX13541@opus.bloom.county> <3D0912F4.4020300@embeddededge.com> <20020613215635.GB13541@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020613215635.GB13541@opus.bloom.county>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Jun 13, 2002 at 02:56:35PM -0700, Tom Rini wrote:
>
> On Thu, Jun 13, 2002 at 05:47:32PM -0400, Dan Malek wrote:
> > Tom Rini wrote:
> >
> > >..... But I don't see (immediatly) why the change to
> > >pci_alloc_consistent was needed as well.
> >
> > It was a mistake on my part......when CONFIG_NOT_COHERENT_CACHE is used,
> > the consisten_alloc() returns the dma_handle, and we have to ensure we
> > don't do the virt_to_bus later to get it (because it will be wrong once
> > iopa() is discarded :-)
>
> Ah..  So this part is a correct and necessary fix, separate from the
> rest of the patch?

That's right.  But I think the patch below is a better fix for the
problem.  It makes consistent_alloc()/consistent_free() just do the
right thing for both cache coherent and cache non-coherent processors,
so we can get rid of the ifdef in pci_alloc_consistent() and
pci_free_consistent().

diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/kernel/pci-dma.c linux-grinch/arch/ppc/kernel/pci-dma.c
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/kernel/pci-dma.c	Sat Jan 19 19:07:14 2002
+++ linux-grinch/arch/ppc/kernel/pci-dma.c	Fri Jun 14 10:23:01 2002
@@ -25,25 +25,16 @@

 	if (hwdev == NULL || hwdev->dma_mask != 0xffffffff)
 		gfp |= GFP_DMA;
-#ifdef CONFIG_NOT_COHERENT_CACHE
 	ret = consistent_alloc(gfp, size, dma_handle);
-#else
-	ret = (void *)__get_free_pages(gfp, get_order(size));
-#endif

-	if (ret != NULL) {
+	if (ret != NULL)
 		memset(ret, 0, size);
-		*dma_handle = virt_to_bus(ret);
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
+++ linux-grinch/include/asm-ppc/io.h	Fri Jun 14 10:21:11 2002
@@ -458,8 +458,17 @@
 #define dma_cache_wback(_start,_size)		do { } while (0)
 #define dma_cache_wback_inv(_start,_size)	do { } while (0)

-#define consistent_alloc(gfp, size, handle)	NULL
-#define consistent_free(addr, size)		do { } while (0)
+static inline void *consistent_alloc(int gfp, size_t size, dma_addr_t *dma_handle)
+{
+	void *vaddr;
+
+	vaddr = kmalloc(size, gfp);
+	if (vaddr)
+		*dma_handle = virt_to_bus((unsigned long) vaddr);
+	return vaddr;
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
