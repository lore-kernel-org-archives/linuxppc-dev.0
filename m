Date: Thu, 12 Sep 2002 07:29:45 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Todd Poynor <tpoynor@mvista.com>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: consistent_free re-revisited
Message-ID: <20020912142945.GC13840@opus.bloom.county>
References: <3D7FB97B.9060301@mvista.com> <20020912032640.GA32156@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020912032640.GA32156@zax>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Sep 12, 2002 at 01:26:40PM +1000, David Gibson wrote:
>
> On Wed, Sep 11, 2002 at 02:45:31PM -0700, Todd Poynor wrote:
> > The APIs for consistent_free have diverged between PPC and ARM.  It has,
> > at least in the past, been a goal to keep the APIs in sync.
>
> That's the least of our worries - the current consistent_alloc() is
> badly broken.  It breaks the DMA-mapping.txt rules, because it can't
> safely be called from interrupt context.  I think we need generic
> changes (gfp masks to various functions) to fix this sanely.

IIRC, to fix the interrupt context bit, we need something like the
following, which was Paul's idea, and he said he would talk to Dave M.
about it.  Did anything ever happen there?

But on the other hand, IIRC, the allocation can fail, and the driver has
to be able to deal with that.  But almost none of them do.

> It would be nice to have the same interface as ARM, though - on the
> other hand the consistent_*() interface as such may be obsoleted by
> unified device model interfaces: I believe per-bus consistent memory
> interfaces are supposed to be in there.

Well, if we can have the same interface as ARM, wouldn't that go a ways
towards having the code already done for the unified device model?  And
this is a 2.4 problem too.

[snip]
> Incidentally I think there are also cases where consistent_alloc()
> (both ours and ARM's, IIRC) could leak memory if failures occur at
> just the right point.

Do you remember what that point was?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

--- arch/ppc/mm/cachemap.c	2002/05/10 16:12:32	1.2
+++ arch/ppc/mm/cachemap.c	2002/07/12 19:01:00
@@ -68,9 +68,6 @@
 	struct vm_struct *area;
 	void     *ret;

-	if (in_interrupt())
-		BUG();
-
 	/* Only allocate page size areas.
 	*/
 	size = PAGE_ALIGN(size);
--- mm/vmalloc.c	2002/05/09 00:26:12	1.1.1.1
+++ mm/vmalloc.c	2002/07/12 19:01:00
@@ -12,6 +12,7 @@
 #include <linux/spinlock.h>
 #include <linux/highmem.h>
 #include <linux/smp_lock.h>
+#include <linux/interrupt.h>

 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
@@ -169,15 +170,16 @@

 struct vm_struct * get_vm_area(unsigned long size, unsigned long flags)
 {
-	unsigned long addr;
+	unsigned long addr, lflags;
 	struct vm_struct **p, *tmp, *area;

-	area = (struct vm_struct *) kmalloc(sizeof(*area), GFP_KERNEL);
+	area = (struct vm_struct *) kmalloc(sizeof(*area),
+			(in_interrupt() ? GFP_ATOMIC : GFP_KERNEL));
 	if (!area)
 		return NULL;
 	size += PAGE_SIZE;
 	addr = VMALLOC_START;
-	write_lock(&vmlist_lock);
+	write_lock_irqsave(&vmlist_lock, lflags);
 	for (p = &vmlist; (tmp = *p) ; p = &tmp->next) {
 		if ((size + addr) < addr)
 			goto out;
@@ -192,11 +194,11 @@
 	area->size = size;
 	area->next = *p;
 	*p = area;
-	write_unlock(&vmlist_lock);
+	write_unlock_irqrestore(&vmlist_lock, lflags);
 	return area;

 out:
-	write_unlock(&vmlist_lock);
+	write_unlock_irqrestore(&vmlist_lock, lflags);
 	kfree(area);
 	return NULL;
 }
--- include/asm-ppc/pgalloc.h.orig	Wed Aug  7 11:04:12 2002
+++ include/asm-ppc/pgalloc.h	Wed Aug  7 11:09:02 2002
@@ -114,7 +114,8 @@
 	extern void *early_get_page(void);

 	if (mem_init_done)
-		pte = (pte_t *) __get_free_page(GFP_KERNEL);
+		pte = (pte_t *) __get_free_page(
+				(in_interrupt() ? GFP_ATOMIC : GFP_KERNEL));
 	else
 		pte = (pte_t *) early_get_page();
 	if (pte != NULL)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
