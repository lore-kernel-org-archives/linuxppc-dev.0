Date: Fri, 29 Aug 2003 17:01:15 +0200
From: Wouter Cloetens <wouter@mind.be>
To: Trevor Woerner <ppc339@vtnet.ca>, linuxppc-dev@lists.linuxppc.org
Subject: [PATCH 2.4.22] Re: PPC405 support in later 2.4.x kernels
Message-ID: <20030829150115.GD1204@roadkill.intern.mind.be>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZPt4rx8FFjLCG7dd"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, 31 Jul 2003 23:32:41 -0400, Trevor Woerner wrote:
> I grabbed 2.4.22-pre8 and found the ppc4xx code back, but the strangest
> thing is now happening: I've lost my user-space.

I had the same problem with 2.4.22. I diffed 2.4.21-pre7 with 2.4.22
and found some 405-specific code to be missing in the fault handler.
The attached patch fixes the problem.

--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Description: 405fault.diff
Content-Disposition: attachment; filename="405fault.diff"

--- linux-2.4.22_linuxppc_2_4/arch/ppc/mm/fault.c	2003-08-29 11:13:00.000000000 +0200
+++ linux-2.4.22_linuxppc_2_4_insightv2p/arch/ppc/mm/fault.c	2003-08-29 16:35:26.000000000 +0200
@@ -26,6 +26,7 @@
 #include <linux/mman.h>
 #include <linux/mm.h>
 #include <linux/interrupt.h>
+#include <linux/highmem.h>

 #include <asm/page.h>
 #include <asm/pgtable.h>
@@ -51,6 +52,7 @@ unsigned int probingmem;
 extern void die_if_kernel(char *, struct pt_regs *, long);
 void bad_page_fault(struct pt_regs *, unsigned long, int sig);
 void do_page_fault(struct pt_regs *, unsigned long, unsigned long);
+extern int get_pteptr(struct mm_struct *mm, unsigned long addr, pte_t **ptep);

 /*
  * Check whether the instruction at regs->nip is a store using
@@ -202,6 +204,28 @@ good_area:
 	if (is_write) {
 		if (!(vma->vm_flags & VM_WRITE))
 			goto bad_area;
+#if defined(CONFIG_4xx)
+        /* an exec  - 4xx/BookE allows for per-page execute permission */
+	} else if (regs->trap == 0x400) {
+		pte_t *ptep;
+
+
+		/* Since 4xx supports per-page execute permission,
+		 * we lazily flush dcache to icache. */
+		if (get_pteptr(mm, address, &ptep) && pte_present(*ptep)) {
+			struct page *page = pte_page(*ptep);
+
+			if (! test_bit(PG_arch_1, &page->flags)) {
+				__flush_dcache_icache(kmap(page));
+				kunmap(page);
+				set_bit(PG_arch_1, &page->flags);
+			}
+			pte_update(ptep, 0, _PAGE_HWEXEC);
+			_tlbie(address);
+			up_read(&mm->mmap_sem);
+			return;
+		}
+#endif
 	/* a read */
 	} else {
 		/* protection fault */

--ZPt4rx8FFjLCG7dd--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
