Date: Tue, 16 Jul 2002 12:13:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: consistent_alloc() revisited
Message-ID: <20020716021313.GQ22786@zax>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J/dobhs11T7y2rNN"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

A little while back Tom Rini suggested that we implement the various
tricks ARM uses in its version of consistent_alloc() in our version.
I've made a start on that, but there are some complications.

There are basically two things that ARM does and we don't:
	1. Frees unused pages in the allocation, if the requested size
isn't a power of two pages
	2. Marks the pages Reserved

In addition, the following seem to me like desirable (to a greater or
lesser extent) properties for consistent_alloc():
	a. one of the return values can be used as a single "handle"
so that consistent_free() only needs one parameter.
	b. works on both cache coherent and non cache coherent
machines
	c. be able to use highmem pages

(1) is certainly desirable and the attached patch implements it (for
2.5).  I think the patch may also correct some potential bugs in the
current implementation - I'm not 100% convinced the current
implementation can't leak memory if map_page() fails at the wrong
time.  I'll commit this if no-one has objections.

(2) is a little more complicated.  The reason asserted in the comments
in the ARM code is so that remap_page_range() works.  However, the
only code I can see that would call remap_page_range() on memory which
came from consistent_alloc() (actually from pci_alloc_consistent()) is
in some (apparently x86 specific) sound drivers.  [actually these are
broken on PPC (2.5) anyway since they use virt_to_bus() on the virtual
address returned by pci_alloc_consistent() but that's easily fixed].
These drivers set and clear PageReserved themselves, so they're
clearly not expecting pci_alloc_consistent() to return Reserved pages.

Arguably setting PageReserved is the Right Thing, since
consistent_alloc() memory obviously shouldn't be swapped or paged.
However, it's only relevant if the memory is mapped into userspace,
and then a driver can set VM_IO on the vma to prevent this.

Furthermore, at the moment it is diffuclt for a general driver to
correctly map consistent_alloc() memory into userspace, since it must
set the flags on the new mappings correctly to disable caching on
machines which aren't DMA consistent.  At the moment that means the
driver must be (a) arch-specific and (b) have an ifdef on
CONFIG_NOT_COHERENT_CACHE or various different options for some of the
other archs.

Therefore, I think a _PAGE_DMA_CONSISTENT page flag would be a useful
thing.  Patches probably forthcoming.

We currently have (a) by use of vfree() on the virtual address, we
don't have (b) or (c).  Some earlier patches of mine added (b), but at
the expense of (a).  paulus pointer out however, that we can add (b)
while keeping (a) by having consistent_alloc() remap the memory even
on cache coherent machines - it will just omit the cache flush and the
_PAGE_NO_CACHE flag.  A _PAGE_DMA_CONSISTENT would make this even
easier.  As a bonus, having this remapping gives us (c) almost for
free.

Comments?  Objections?

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch0

diff -urN /home/dgibson/kernel/linuxppc-2.5/arch/ppc/mm/cachemap.c linux-bluefish/arch/ppc/mm/cachemap.c
--- /home/dgibson/kernel/linuxppc-2.5/arch/ppc/mm/cachemap.c	Fri Jun 28 10:40:59 2002
+++ linux-bluefish/arch/ppc/mm/cachemap.c	Mon Jul 15 16:20:39 2002
@@ -61,57 +61,69 @@
  */
 void *consistent_alloc(int gfp, size_t size, dma_addr_t *dma_handle)
 {
-	int order, err, i;
-	unsigned long page, va, pa, flags;
-	struct vm_struct *area;
-	void	 *ret;
+	int order, err;
+	struct page *page, *free, *end;
+	unsigned long pa, flags, offset;
+	struct vm_struct *area = NULL;
+	unsigned long va = 0;

-	if (in_interrupt())
-		BUG();
+	BUG_ON(in_interrupt());

-	/* Only allocate page size areas.
-	*/
+	/* Only allocate page size areas */
 	size = PAGE_ALIGN(size);
 	order = get_order(size);

-	page = __get_free_pages(gfp, order);
-	if (!page) {
-		BUG();
+	free = page = alloc_pages(gfp, order);
+	if (! page)
 		return NULL;
-	}
+
+	pa = page_to_phys(page);
+	*dma_handle = page_to_bus(page);
+	end = page + (1 << order);

 	/*
 	 * we need to ensure that there are no cachelines in use,
 	 * or worse dirty in this area.
 	 */
-	invalidate_dcache_range(page, page + size);
+	invalidate_dcache_range((unsigned long)page_address(page),
+				(unsigned long)page_address(page) + size);

-	/* Allocate some common virtual space to map the new pages.
-	*/
+	/*
+	 * alloc_pages() expects the block to be handled as a unit, so
+	 * it only sets the page count on the first page.  We set the
+	 * counts on each page so they can be freed individually
+	 */
+	for (; page < end; page++)
+		set_page_count(page, 1);
+
+
+	/* Allocate some common virtual space to map the new pages*/
 	area = get_vm_area(size, VM_ALLOC);
-	if (area == 0) {
-		free_pages(page, order);
-		return NULL;
-	}
-	va = VMALLOC_VMADDR(area->addr);
-	ret = (void *)va;
+	if (! area)
+		goto out;

-	/* This gives us the real physical address of the first page.
-	*/
-	*dma_handle = pa = virt_to_bus((void *)page);
+	va = VMALLOC_VMADDR(area->addr);

 	flags = _PAGE_KERNEL | _PAGE_NO_CACHE;
-
-	err = 0;
-	for (i = 0; i < size && err == 0; i += PAGE_SIZE)
-		err = map_page(va+i, pa+i, flags);

-	if (err) {
-		vfree((void *)va);
-		return NULL;
+	for (offset = 0; offset < size; offset += PAGE_SIZE) {
+		err = map_page(va+offset, pa+offset, flags);
+		if (err) {
+			vfree((void *)va);
+			va = 0;
+			goto out;
+		}
+
+		free++;
+	}
+
+ out:
+	/* Free pages which weren't mapped */
+	for (; free < end; free++) {
+		__free_page(free);
 	}

-	return ret;
+	return (void *)va;
 }

 /*
@@ -119,8 +131,7 @@
  */
 void consistent_free(void *vaddr)
 {
-	if (in_interrupt())
-		BUG();
+	BUG_ON(in_interrupt());
 	vfree(vaddr);
 }

@@ -157,6 +168,6 @@
 {
 	unsigned long start;

-	start = page_address(page) + offset;
+	start = (unsigned long)page_address(page) + offset;
 	consistent_sync((void *)start, size, direction);
 }

--J/dobhs11T7y2rNN--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
