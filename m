Message-ID: <3A59F666.E5376DE6@cisco.com>
Date: Mon, 08 Jan 2001 11:18:30 -0600
From: Mike Beede <mbeede@cisco.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Possible VM fix(s) for 2.4 PPC port
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


We've been working with 2.4.0-test10 on 750 and found a couple of
things that might be useful to others.  If this isn't the place to
send these, can someone let me know?

First, we had some kernel panics loading modules.  Turns out that the
module list is half-baked during part of sys_module_install.  If we
take a memory fault copying in the module contents, the fault handler
can't search the kernel exception list because the module list is
temporarily corrupted.  So instead of __copy_tofrom_user just failing,
the kernel takes a fault.  The patch to module.c fixs this.

The second problem is that if you vmalloc memory requiring a new entry
in the
kernel pgd, it isn't visible when in a user context (if that's the
current
right term....).  Turned out, that was why we were having our memory
fault
in the first place, but now we failed the syscall instead of panicking.

We added some code modeled on the i386 version that copies the pgd
entry from the kernel pgd and it seems to work.  I assume that the PPC
version doesn't fault in pages in the kernel, since vmalloc seems to
allocate pages when called.  If that assumption is wrong, then this
isn't a sufficient solution, but it shouldn't be any worse than what
was there in test10.

	Mike Beede

--
Mike Beede, mbeede@cisco.com
Cisco Systems
612-398-1009



--- kernel/module.c.orig	Mon Jan  8 10:56:30 2001
+++ kernel/module.c	Mon Jan  8 10:59:22 2001
@@ -201,6 +201,7 @@
 		error = -EFAULT;
 		goto err2;
 	}
+	mod->next = mod_tmp.next;

 	/* Sanity check the size of the module.  */
 	error = -EINVAL;
@@ -292,7 +293,6 @@
 	flush_icache_range((unsigned long)mod, (unsigned long)mod +
mod->size);

 	/* Update module references.  */
-	mod->next = mod_tmp.next;
 	mod->refs = NULL;
 	for (i = 0, dep = mod->deps; i < mod->ndeps; ++i, ++dep) {
 		struct module *o, *d = dep->dep;
--- arch/ppc/mm/fault.c.orig	Mon Jan  8 10:49:14 2001
+++ arch/ppc/mm/fault.c	Mon Jan  8 10:54:19 2001
@@ -95,6 +95,14 @@
 #endif /* !CONFIG_4xx */
 #endif /* CONFIG_XMON || CONFIG_KGDB */

+        /*
+         * Handle a fault in kernel space.
+         */
+
+        if ( address > TASK_SIZE ) {
+           goto vmalloc_fault;
+        }
+
 	if (in_interrupt() || mm == NULL) {
 		bad_page_fault(regs, address);
 		return;
@@ -168,8 +176,35 @@
 	pte_misses++;
 	return;

+  vmalloc_fault:
+        {
+           /*
+            * Synchronize this task's top level page table with the
+            * reference page table.  Modeled on the i386 code with
+            * the difference that there are no pmds in the PPC port.
+            */
+           int offset = pgd_index(address);
+           pgd_t *pgd, *pgd_k;
+           pmd_t *pmd, *pmd_k;
+
+           pgd = current->active_mm->pgd + offset; /* address of pgd
entry in current */
+           pgd_k = init_mm.pgd + offset; /* address of pgd entry in
reference table */
+
+           if ( !pgd_val(*pgd) ) { /* if there isn't a pgd entry
already */
+              if (!pgd_val(*pgd_k)) {/* if there isn't a pgd entry in
the reference table */
+                 goto bad_area_nosemaphore;
+              }
+              *pgd = *pgd_k;
+              return;
+           }
+           goto bad_area_nosemaphore;
+        }
+
+#endif
+
 bad_area:
 	up(&mm->mmap_sem);
+  bad_area_nosemaphore:
 	pte_errors++;

 	/* User mode accesses cause a SIGSEGV */

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
