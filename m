Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4D83D679FB
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 21 May 2005 05:33:23 +1000 (EST)
Date: Fri, 20 May 2005 11:12:44 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Dan Malek <dan@embeddededge.com>, Matt Porter <mporter@kernel.crashing.org>
Message-ID: <20050520141244.GD24923@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] allow coherent DMA API to work before main page allocator
	is set up
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Dan, Matt,

The following patch changes dma_alloc_coherent() to, in case the 
main page allocator is not yet up and running, use the bootmem
allocator instead.

It also adds a new parameter to m8xx_cpm_hostalloc() to send back
the physical address to its caller.

With such modification in place it will be possible for early drivers 
to rely on the coherent DMA allocator. Special casing such as 
drivers/serial/cpm_uart/cpm_uart_cpm1.c's cpm_uart_allocbuf() can be 
removed:

        if (is_con) {
                mem_addr = (u8 *) m8xx_cpm_hostalloc(memsz);
                dma_addr = 0;
        } else
                mem_addr = dma_alloc_coherent(NULL, memsz, &dma_addr,
                                              GFP_KERNEL);

What is your opinion on this approach? 

If virt_to_phys() usage is discouraged any different method to walk 
the pagetables and retrieve the physical address can be used.

TIA

diff -Nur linux-2.6.11.orig/arch/ppc/8xx_io/commproc.c linux-2.6.11/arch/ppc/8xx_io/commproc.c
--- linux-2.6.11.orig/arch/ppc/8xx_io/commproc.c	2005-05-20 13:53:17.000000000 -0300
+++ linux-2.6.11/arch/ppc/8xx_io/commproc.c	2005-05-20 16:02:13.000000000 -0300
@@ -39,7 +39,8 @@
 #include <asm/tlbflush.h>
 #include <asm/rheap.h>
 
-extern int get_pteptr(struct mm_struct *mm, unsigned long addr, pte_t **ptep);
+
+phys_addr_t	physaddr;
 
 static void m8xx_cpm_dpinit(void);
 static	uint	host_buffer;	/* One page of host buffer */
@@ -111,11 +112,10 @@
 extern void flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
 
 void
-m8xx_cpm_reset(uint bootpage)
+m8xx_cpm_reset(void)
 {
 	volatile immap_t	 *imp;
 	volatile cpm8xx_t	*commproc;
-	pte_t *pte;
 
 	imp = (immap_t *)IMAP_ADDR;
 	commproc = (cpm8xx_t *)&imp->im_cpm;
@@ -143,17 +143,6 @@
 	/* Reclaim the DP memory for our use. */
 	m8xx_cpm_dpinit();
 
-	/* get the PTE for the bootpage */
-	if (!get_pteptr(&init_mm, bootpage, &pte))
-	       panic("get_pteptr failed\n");
-																							
-	/* and make it uncachable */
-	pte_val(*pte) |= _PAGE_NO_CACHE;
-	_tlbie(bootpage);
-
-	host_buffer = bootpage;
-	host_end = host_buffer + PAGE_SIZE;
-
 	/* Tell everyone where the comm processor resides.
 	*/
 	cpmp = (cpm8xx_t *)commproc;
@@ -165,7 +154,6 @@
 static void
 alloc_host_memory(void)
 {
-	dma_addr_t	physaddr;
 
 	/* Set the host page for allocation.
 	*/
@@ -325,7 +313,7 @@
  * UART "fifos" and the like.
  */
 uint
-m8xx_cpm_hostalloc(uint size)
+m8xx_cpm_hostalloc(uint size, phys_addr_t *handle)
 {
 	uint	retloc;
 
@@ -336,7 +324,9 @@
 		return(0);
 
 	retloc = host_buffer;
+	*handle = physaddr;
 	host_buffer += size;
+	physaddr += size;
 
 	return(retloc);
 }
diff -Nur linux-2.6.11.orig/arch/ppc/kernel/dma-mapping.c linux-2.6.11/arch/ppc/kernel/dma-mapping.c
--- linux-2.6.11.orig/arch/ppc/kernel/dma-mapping.c	2005-05-20 13:53:17.000000000 -0300
+++ linux-2.6.11/arch/ppc/kernel/dma-mapping.c	2005-05-20 14:03:56.000000000 -0300
@@ -55,6 +55,8 @@
 
 int map_page(unsigned long va, phys_addr_t pa, int flags);
 
+extern int mem_init_done;
+
 #include <asm/tlbflush.h>
 
 /*
@@ -121,7 +123,10 @@
 	unsigned long flags;
 	struct vm_region *c, *new;
 
-	new = kmalloc(sizeof(struct vm_region), gfp);
+	if (mem_init_done)
+		new = kmalloc(sizeof(struct vm_region), gfp);
+	else
+		new = alloc_bootmem(sizeof(struct vm_region));
 	if (!new)
 		goto out;
 
@@ -175,10 +180,11 @@
 void *
 __dma_alloc_coherent(size_t size, dma_addr_t *handle, int gfp)
 {
-	struct page *page;
+	struct page *page = NULL;
 	struct vm_region *c;
 	unsigned long order;
 	u64 mask = 0x00ffffff, limit; /* ISA default */
+	void *bootmem_address = NULL;
 
 	if (!consistent_pte) {
 		printk(KERN_ERR "%s: not initialised\n", __func__);
@@ -199,14 +205,21 @@
 	if (mask != 0xffffffff)
 		gfp |= GFP_DMA;
 
-	page = alloc_pages(gfp, order);
-	if (!page)
-		goto no_page;
+	if (mem_init_done) {
+		page = alloc_pages(gfp, order);
+		if (!page)
+			goto no_page;
+	} else {
+		bootmem_address = alloc_bootmem_pages(PAGE_SIZE << order);
+		if (!bootmem_address)
+			goto no_page;
+	}
 
 	/*
 	 * Invalidate any data that might be lurking in the
 	 * kernel direct-mapped region for device DMA.
 	 */
+	if (mem_init_done)
 	{
 		unsigned long kaddr = (unsigned long)page_address(page);
 		memset(page_address(page), 0, size);
@@ -226,27 +239,37 @@
 		/*
 		 * Set the "dma handle"
 		 */
-		*handle = page_to_bus(page);
+		if (mem_init_done)
+			*handle = page_to_bus(page);
+		else
+			*handle = virt_to_phys(bootmem_address);
 
 		do {
-			BUG_ON(!pte_none(*pte));
+			if (mem_init_done) {
+				BUG_ON(!pte_none(*pte));
 
-			set_page_count(page, 1);
-			SetPageReserved(page);
-			set_pte_at(&init_mm, vaddr,
-				   pte, mk_pte(page, pgprot_noncached(PAGE_KERNEL)));
-			page++;
-			pte++;
-			vaddr += PAGE_SIZE;
+				set_page_count(page, 1);
+				SetPageReserved(page);
+				set_pte_at(&init_mm, vaddr,
+					   pte, mk_pte(page, pgprot_noncached(PAGE_KERNEL)));
+				page++;
+				pte++;
+				vaddr += PAGE_SIZE;
+			} else { 
+				set_pte(pte,__pte((pte_t)virt_to_phys(bootmem_address) | pgprot_val(pgprot_noncached(PAGE_KERNEL))));
+				bootmem_address += PAGE_SIZE;
+			}
 		} while (size -= PAGE_SIZE);
 
 		/*
 		 * Free the otherwise unused pages.
 		 */
-		while (page < end) {
-			set_page_count(page, 1);
-			__free_page(page);
-			page++;
+		if (mem_init_done) {
+			while (page < end) {
+				set_page_count(page, 1);
+				__free_page(page);
+				page++;
+			}
 		}
 
 		return (void *)c->vm_start;
diff -Nur linux-2.6.11.orig/arch/ppc/syslib/m8xx_setup.c linux-2.6.11/arch/ppc/syslib/m8xx_setup.c
--- linux-2.6.11.orig/arch/ppc/syslib/m8xx_setup.c	2005-05-20 13:53:17.000000000 -0300
+++ linux-2.6.11/arch/ppc/syslib/m8xx_setup.c	2005-05-20 15:59:24.000000000 -0300
@@ -57,7 +57,7 @@
 extern void m8xx_ide_init(void);
 
 extern unsigned long find_available_memory(void);
-extern void m8xx_cpm_reset(uint cpm_page);
+extern void m8xx_cpm_reset();
 extern void m8xx_wdt_handler_install(bd_t *bp);
 extern void rpxfb_alloc_pages(void);
 extern void cpm_interrupt_init(void);
@@ -70,13 +70,9 @@
 void __init
 m8xx_setup_arch(void)
 {
-	int	cpm_page;
-
-	cpm_page = (int) alloc_bootmem_pages(PAGE_SIZE);
-
 	/* Reset the Communication Processor Module.
 	*/
-	m8xx_cpm_reset(cpm_page);
+	m8xx_cpm_reset();
 
 #ifdef CONFIG_FB_RPX
 	rpxfb_alloc_pages();
diff -Nur linux-2.6.11.orig/include/asm-ppc/commproc.h linux-2.6.11/include/asm-ppc/commproc.h
--- linux-2.6.11.orig/include/asm-ppc/commproc.h	2005-05-20 13:53:40.000000000 -0300
+++ linux-2.6.11/include/asm-ppc/commproc.h	2005-05-20 16:02:37.000000000 -0300
@@ -79,7 +79,7 @@
 extern void *cpm_dpram_addr(uint offset);
 extern void cpm_setbrg(uint brg, uint rate);
 
-extern uint m8xx_cpm_hostalloc(uint size);
+extern uint m8xx_cpm_hostalloc(uint size, phys_addr_t *handle);
 extern int  m8xx_cpm_hostfree(uint start);
 extern void m8xx_cpm_hostdump(void);
 
