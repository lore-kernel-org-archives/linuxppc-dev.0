Date: Fri, 6 Feb 2004 04:06:57 +1100
From: Anton Blanchard <anton@samba.org>
To: Peter Bergner <bergner@vnet.ibm.com>
Cc: joakim.tjernlund@lumentis.se, linuxppc-dev@lists.linuxppc.org
Subject: Re: TASK_UNMAPPED_BASE
Message-ID: <20040205170657.GA19011@krispykreme>
References: <001301c3ebc6$1d9f0a80$0a01a8c0@LUMENTIS02> <1075998857.2843.14.camel@otta.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1075998857.2843.14.camel@otta.rchland.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> The problem with a TASK_UNMAPPED_BASE that was "too low" was referring to
> the bug where we always loaded ld.so at TASK_UNMAPPED_BASE even though
> that adress was in the middle of the bss.  Now that has been fixed, "too low"
> isn't a concern anymore.
>
> However, I'm not sure moving the TASK_UNMAPPED_BASE below the text section
> will work.  It's used for more than just loading shared libs.  Anonymous mmap
> areas and the heap are all located relative to it.

That reminded me of a patch wli did to rearrange how things are
allocated. I wonder if doing something radical like this will work on
ppc32.

Anton

diff -purN -X /home/mbligh/.diff.exclude 400-less_bouncy/arch/i386/Kconfig 410-topdown/arch/i386/Kconfig
--- 400-less_bouncy/arch/i386/Kconfig	2003-11-24 16:36:16.000000000 -0800
+++ 410-topdown/arch/i386/Kconfig	2003-11-25 14:24:37.000000000 -0800
@@ -1542,6 +1542,15 @@ config SCHEDSTATS
 	  application, you can say N to avoid the very slight overhead
 	  this adds.

+config MMAP_TOPDOWN
+	bool "Top-down vma allocation"
+	help
+	  Say Y here to have the kernel change its vma allocation policy
+	  to allocate vma's from the top of the address space down, and
+	  to shove the stack low so as to conserve virtualspace. This is
+	  risky because various apps, including a number of versions of
+	  ld.so, depend on the kernel's bottom-up behavior.
+
 config X86_EXTRA_IRQS
 	bool
 	depends on X86_LOCAL_APIC || X86_VOYAGER
diff -purN -X /home/mbligh/.diff.exclude 400-less_bouncy/arch/i386/mm/pgtable.c 410-topdown/arch/i386/mm/pgtable.c
--- 400-less_bouncy/arch/i386/mm/pgtable.c	2003-10-01 11:34:29.000000000 -0700
+++ 410-topdown/arch/i386/mm/pgtable.c	2003-11-25 14:24:37.000000000 -0800
@@ -237,3 +237,60 @@ void pgd_free(pgd_t *pgd)
 	/* in the non-PAE case, clear_page_tables() clears user pgd entries */
 	kmem_cache_free(pgd_cache, pgd);
 }
+
+#define GLIBC_BUFFER	(32*1024*1024)
+
+/*
+ * This is total crap; it needs to use the free area cache to mitigate
+ * catastrophic O(n) search with many vmas.
+ */
+unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr,
+					unsigned long len, unsigned long pgoff,
+					unsigned long flags)
+{
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma, *prev;
+
+	len = PAGE_ALIGN(len);
+	addr = PAGE_ALIGN(addr);
+
+	if (len > TASK_SIZE)
+		return -ENOMEM;
+
+	if (addr) {
+		struct vm_area_struct *vma;
+		vma = find_vma(mm, addr);
+		if (TASK_SIZE - len >= addr &&
+				(!vma || addr + len <= vma->vm_start))
+			goto out;
+	}
+
+	if (!mm->mmap) {
+		if (len > TASK_SIZE - GLIBC_BUFFER)
+			addr = TASK_SIZE - len;
+		else
+			addr = TASK_SIZE - GLIBC_BUFFER - len;
+		goto out;
+	}
+
+	addr = -ENOMEM;
+	for (prev = NULL, vma = mm->mmap; vma; prev = vma, vma = vma->vm_next) {
+		unsigned long lo, hi;
+		lo = prev ? prev->vm_end : 0;
+		hi = vma->vm_start;
+		if (hi - lo >= len && (addr == -ENOMEM || addr < hi - len))
+			addr = hi - len;
+	}
+	/*
+	 * We're at the last one; let's try the top, but only if nothing
+	 * else can be found (to respect GLIBC_BUFFER).
+	 */
+	if (prev && TASK_SIZE - prev->vm_end >= len) {
+		if (TASK_SIZE - GLIBC_BUFFER - prev->vm_end >= len)
+			addr = TASK_SIZE - GLIBC_BUFFER - len;
+		else if (addr == -ENOMEM)
+			addr = TASK_SIZE - len;
+	}
+out:
+	return addr;
+}
diff -purN -X /home/mbligh/.diff.exclude 400-less_bouncy/fs/binfmt_elf.c 410-topdown/fs/binfmt_elf.c
--- 400-less_bouncy/fs/binfmt_elf.c	2003-11-24 16:34:48.000000000 -0800
+++ 410-topdown/fs/binfmt_elf.c	2003-11-25 14:24:37.000000000 -0800
@@ -7,6 +7,7 @@
  * Tools".
  *
  * Copyright 1993, 1994: Eric Youngdale (ericy@cais.com).
+ * Top-down vma allocation support, William Irwin, IBM, 2003
  */

 #include <linux/module.h>
@@ -329,8 +330,13 @@ static unsigned long load_elf_interp(str
 	if (retval < 0)
 		goto out_close;

+#ifndef CONFIG_MMAP_TOPDOWN
 	eppnt = elf_phdata;
 	for (i=0; i<interp_elf_ex->e_phnum; i++, eppnt++) {
+#else
+	eppnt = &elf_phdata[interp_elf_ex->e_phnum - 1];
+	for (i = interp_elf_ex->e_phnum - 1; i >= 0; --i, --eppnt) {
+#endif
 	  if (eppnt->p_type == PT_LOAD) {
 	    int elf_type = MAP_PRIVATE | MAP_DENYWRITE;
 	    int elf_prot = 0;
@@ -344,7 +350,8 @@ static unsigned long load_elf_interp(str
 	    if (interp_elf_ex->e_type == ET_EXEC || load_addr_set)
 	    	elf_type |= MAP_FIXED;

-	    map_addr = elf_map(interpreter, load_addr + vaddr, eppnt, elf_prot, elf_type);
+	    map_addr = load_addr_set ? load_addr + vaddr : 0;
+	    map_addr = elf_map(interpreter, map_addr, eppnt, elf_prot, elf_type);
 	    if (BAD_ADDR(map_addr))
 	    	goto out_close;

diff -purN -X /home/mbligh/.diff.exclude 400-less_bouncy/include/asm-i386/a.out.h 410-topdown/include/asm-i386/a.out.h
--- 400-less_bouncy/include/asm-i386/a.out.h	2002-12-09 18:45:54.000000000 -0800
+++ 410-topdown/include/asm-i386/a.out.h	2003-11-25 14:24:37.000000000 -0800
@@ -19,7 +19,16 @@ struct exec

 #ifdef __KERNEL__

+/*
+ * Typical ELF load address is 0x8048000, which is 128MB + 288KB.
+ * Shoving the stack very close to it lets smaller programs fit in
+ * a single pagetable page's worth of virtualspace.
+ */
+#ifdef CONFIG_MMAP_TOPDOWN
+#define STACK_TOP	((128 << 20) + (256 << 10))
+#else
 #define STACK_TOP	TASK_SIZE
+#endif

 #endif

diff -purN -X /home/mbligh/.diff.exclude 400-less_bouncy/include/asm-i386/pgtable.h 410-topdown/include/asm-i386/pgtable.h
--- 400-less_bouncy/include/asm-i386/pgtable.h	2003-10-14 15:50:32.000000000 -0700
+++ 410-topdown/include/asm-i386/pgtable.h	2003-11-25 14:24:37.000000000 -0800
@@ -25,6 +25,10 @@
 #include <linux/list.h>
 #include <linux/spinlock.h>

+#ifdef CONFIG_MMAP_TOPDOWN
+#define HAVE_ARCH_UNMAPPED_AREA
+#endif
+
 /*
  * ZERO_PAGE is a global shared page that is always zero: used
  * for zero-mapped memory areas etc..


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
