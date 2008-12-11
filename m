Return-Path: <dhowells@redhat.com>
Received: from mx2.redhat.com (mx2.redhat.com [66.187.237.31])
	by ozlabs.org (Postfix) with ESMTP id 9B62FDDEFB
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 23:53:58 +1100 (EST)
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id mBBCrvP1002463
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 07:53:57 -0500
From: David Howells <dhowells@redhat.com>
Subject: [PATCH] NOMMU: Rename PowerPC's struct vm_region
To: linuxppc-dev@ozlabs.org
Date: Thu, 11 Dec 2008 12:53:54 +0000
Message-ID: <20081211125354.20641.23213.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Rename PowerPC's struct vm_region so that I can introduce my own global version
for NOMMU.  It's feasible that the PowerPC version may wish to use my global
one instead.

The NOMMU vm_region struct defines areas of the physical memory map that are
under mmap.  This may include chunks of RAM or regions of memory mapped
devices, such as flash.  It is also used to retain copies of file content so
that shareable private memory mappings of files can be made.  As such, it may
be compatible with what is described in the banner comment for PowerPC's
vm_region struct.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 arch/powerpc/lib/dma-noncoherent.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)


diff --git a/arch/powerpc/lib/dma-noncoherent.c b/arch/powerpc/lib/dma-noncoherent.c
index 31734c0..a55c6ca 100644
--- a/arch/powerpc/lib/dma-noncoherent.c
+++ b/arch/powerpc/lib/dma-noncoherent.c
@@ -77,26 +77,26 @@ static DEFINE_SPINLOCK(consistent_lock);
  * the amount of RAM found at boot time.)  I would imagine that get_vm_area()
  * would have to initialise this each time prior to calling vm_region_alloc().
  */
-struct vm_region {
+struct ppc_vm_region {
 	struct list_head	vm_list;
 	unsigned long		vm_start;
 	unsigned long		vm_end;
 };
 
-static struct vm_region consistent_head = {
+static struct ppc_vm_region consistent_head = {
 	.vm_list	= LIST_HEAD_INIT(consistent_head.vm_list),
 	.vm_start	= CONSISTENT_BASE,
 	.vm_end		= CONSISTENT_END,
 };
 
-static struct vm_region *
-vm_region_alloc(struct vm_region *head, size_t size, gfp_t gfp)
+static struct ppc_vm_region *
+ppc_vm_region_alloc(struct ppc_vm_region *head, size_t size, gfp_t gfp)
 {
 	unsigned long addr = head->vm_start, end = head->vm_end - size;
 	unsigned long flags;
-	struct vm_region *c, *new;
+	struct ppc_vm_region *c, *new;
 
-	new = kmalloc(sizeof(struct vm_region), gfp);
+	new = kmalloc(sizeof(struct ppc_vm_region), gfp);
 	if (!new)
 		goto out;
 
@@ -130,9 +130,9 @@ vm_region_alloc(struct vm_region *head, size_t size, gfp_t gfp)
 	return NULL;
 }
 
-static struct vm_region *vm_region_find(struct vm_region *head, unsigned long addr)
+static struct ppc_vm_region *ppc_vm_region_find(struct ppc_vm_region *head, unsigned long addr)
 {
-	struct vm_region *c;
+	struct ppc_vm_region *c;
 
 	list_for_each_entry(c, &head->vm_list, vm_list) {
 		if (c->vm_start == addr)
@@ -151,7 +151,7 @@ void *
 __dma_alloc_coherent(size_t size, dma_addr_t *handle, gfp_t gfp)
 {
 	struct page *page;
-	struct vm_region *c;
+	struct ppc_vm_region *c;
 	unsigned long order;
 	u64 mask = 0x00ffffff, limit; /* ISA default */
 
@@ -191,7 +191,7 @@ __dma_alloc_coherent(size_t size, dma_addr_t *handle, gfp_t gfp)
 	/*
 	 * Allocate a virtual address in the consistent mapping region.
 	 */
-	c = vm_region_alloc(&consistent_head, size,
+	c = ppc_vm_region_alloc(&consistent_head, size,
 			    gfp & ~(__GFP_DMA | __GFP_HIGHMEM));
 	if (c) {
 		unsigned long vaddr = c->vm_start;
@@ -239,7 +239,7 @@ EXPORT_SYMBOL(__dma_alloc_coherent);
  */
 void __dma_free_coherent(size_t size, void *vaddr)
 {
-	struct vm_region *c;
+	struct ppc_vm_region *c;
 	unsigned long flags, addr;
 	pte_t *ptep;
 
@@ -247,7 +247,7 @@ void __dma_free_coherent(size_t size, void *vaddr)
 
 	spin_lock_irqsave(&consistent_lock, flags);
 
-	c = vm_region_find(&consistent_head, (unsigned long)vaddr);
+	c = ppc_vm_region_find(&consistent_head, (unsigned long)vaddr);
 	if (!c)
 		goto no_area;
 
