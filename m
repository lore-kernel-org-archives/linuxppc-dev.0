Return-Path: <rashmicy@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rGFSs5jWHzDqCT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 May 2016 15:49:17 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id f144so4800095pfa.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 May 2016 22:49:17 -0700 (PDT)
From: Rashmica Gupta <rashmicy@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	mpe@ellerman.id.au
Subject: [v3 PATCH 1/2] powerpc/mm: Dump linux pagetables
Date: Fri, 27 May 2016 15:48:59 +1000
Message-Id: <1464328140-31178-1-git-send-email-rashmicy@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Useful to be able to dump the kernels page tables to check permissions
and memory types - derived from arm64's implementation.

Add a debugfs file to check the page tables. To use this the PPC_PTDUMP
config option must be selected.

Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>
---
v2 -> v3: Changed to be compatible with P9. 

 arch/powerpc/Kconfig.debug             |  12 +
 arch/powerpc/mm/Makefile               |   1 +
 arch/powerpc/mm/dump_linuxpagetables.c | 440 +++++++++++++++++++++++++++++++++
 3 files changed, 453 insertions(+)
 create mode 100644 arch/powerpc/mm/dump_linuxpagetables.c

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index 2be221874de8..d19f496a7e12 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -350,4 +350,16 @@ config FAIL_IOMMU
 
 	  If you are unsure, say N.
 
+config PPC_PTDUMP
+        bool "Export kernel pagetable layout to userspace via debugfs"
+        depends on DEBUG_KERNEL
+        select DEBUG_FS
+        help
+	  This option exports the state of the kernel pagetables to a
+	  debugfs file. This is only useful for kernel developers who are
+	  working in architecture specific areas of the kernel - probably
+	  not a good idea to enable this feature in a production kernel.
+
+	  If you are unsure, say N.
+
 endmenu
diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index f2cea6d5e764..d3dfa02082b1 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -43,3 +43,4 @@ obj-$(CONFIG_NOT_COHERENT_CACHE) += dma-noncoherent.o
 obj-$(CONFIG_HIGHMEM)		+= highmem.o
 obj-$(CONFIG_PPC_COPRO_BASE)	+= copro_fault.o
 obj-$(CONFIG_SPAPR_TCE_IOMMU)	+= mmu_context_iommu.o
+obj-$(CONFIG_PPC_PTDUMP)	+= dump_linuxpagetables.o
diff --git a/arch/powerpc/mm/dump_linuxpagetables.c b/arch/powerpc/mm/dump_linuxpagetables.c
new file mode 100644
index 000000000000..d242bc79ae64
--- /dev/null
+++ b/arch/powerpc/mm/dump_linuxpagetables.c
@@ -0,0 +1,440 @@
+/*
+ * Copyright 2016, Rashmica Gupta, IBM Corp.
+ *
+ * This traverses the kernel pagetables and dumps the
+ * information about the used sections of memory to
+ * /sys/kernel/debug/kernel_pagetables.
+ *
+ * Derived from the arm64 implementation:
+ * Copyright (c) 2014, The Linux Foundation, Laura Abbott.
+ * (C) Copyright 2008 Intel Corporation, Arjan van de Ven.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version 2
+ * of the License.
+ */
+#include <linux/debugfs.h>
+#include <linux/fs.h>
+#include <linux/io.h>
+#include <linux/mm.h>
+#include <linux/sched.h>
+#include <linux/seq_file.h>
+#include <asm/fixmap.h>
+#include <asm/pgtable.h>
+#include <linux/const.h>
+#include <asm/page.h>
+#include <asm/pgalloc.h>
+
+/*
+ * To visualise what is happening,
+ *
+ *  - PTRS_PER_P** = how many entries there are in the corresponding P**
+ *  - P**_SHIFT = how many bits of the address we use to index into the
+ * corresponding P**
+ *  - P**_SIZE is how much memory we can access through the table - not the
+ * size of the table itself.
+ * P**={PGD, PUD, PMD, PTE}
+ *
+ *
+ * Each entry of the PGD points to a PUD. Each entry of a PUD points to a
+ * PMD. Each entry of a PMD points to a PTE. And every PTE entry points to
+ * a page.
+ *
+ * In the case where there are only 3 levels, the PUD is folded into the
+ * PGD: every PUD has only one entry which points to the PMD.
+ *
+ * The page dumper groups page table entries of the same type into a single
+ * description. It uses pg_state to track the range information while
+ * iterating over the PTE entries. When the continuity is broken it then
+ * dumps out a description of the range - ie PTEs that are virtually contiguous
+ * with the same PTE flags are chunked together. This is to make it clear how
+ * different areas of the kernel virtual memory are used.
+ *
+ */
+struct pg_state {
+	struct seq_file *seq;
+	const struct addr_marker *marker;
+	unsigned long start_address;
+	unsigned int level;
+	u64 current_flags;
+};
+
+struct addr_marker {
+	unsigned long start_address;
+	const char *name;
+};
+
+static struct addr_marker address_markers[] = {
+	{ 0,	"Start of kernel VM" },
+	{ 0,	"vmalloc() Area" },
+	{ 0,	"vmalloc() End" },
+	{ 0,	"isa I/O start" },
+	{ 0,	"isa I/O end" },
+	{ 0,	"phb I/O start" },
+	{ 0,	"phb I/O end" },
+	{ 0,	"I/O remap start" },
+	{ 0,	"I/O remap end" },
+	{ 0,	"vmemmap start" },
+	{ -1,	NULL },
+};
+
+struct flag_info {
+	u64		mask;
+	u64		val;
+	const char	*set;
+	const char	*clear;
+	bool		is_val;
+	int		shift;
+};
+
+static const struct flag_info flag_array[] = {
+	{
+#ifdef CONFIG_PPC_STD_MMU_64
+		.mask	= _PAGE_PRIVILEGED,
+		.val	= 0,
+#else
+		.mask	= _PAGE_USER,
+		.val	= _PAGE_USER,
+#endif
+		.set	= "user",
+		.clear	= "    ",
+	}, {
+		.mask	= _PAGE_RW,
+		.val	= _PAGE_RW,
+		.set	= "rw",
+		.clear	= "ro",
+	}, {
+		.mask	= _PAGE_EXEC,
+		.val	= _PAGE_EXEC,
+		.set	= " X ",
+		.clear	= "   ",
+	}, {
+		.mask	= _PAGE_PTE,
+		.val	= _PAGE_PTE,
+		.set	= "pte",
+		.clear	= "   ",
+	}, {
+		.mask	= _PAGE_PRESENT,
+		.val	= _PAGE_PRESENT,
+		.set	= "present",
+		.clear	= "       ",
+	}, {
+#ifdef CONFIG_PPC_STD_MMU_64
+		.mask	= H_PAGE_HASHPTE,
+		.val	= H_PAGE_HASHPTE,
+#else
+		.mask	= _PAGE_HASHPTE,
+		.val	= _PAGE_HASHPTE,
+#endif
+		.set	= "hpte",
+		.clear	= "    ",
+	}, {
+#ifndef CONFIG_PPC_STD_MMU_64
+		.mask	= _PAGE_GUARDED,
+		.val	= _PAGE_GUARDED,
+		.set	= "guarded",
+		.clear	= "       ",
+	}, {
+#endif
+		.mask	= _PAGE_DIRTY,
+		.val	= _PAGE_DIRTY,
+		.set	= "dirty",
+		.clear	= "     ",
+	}, {
+		.mask	= _PAGE_ACCESSED,
+		.val	= _PAGE_ACCESSED,
+		.set	= "accessed",
+		.clear	= "        ",
+	}, {
+#ifndef CONFIG_PPC_STD_MMU_64
+		.mask	= _PAGE_WRITETHRU,
+		.val	= _PAGE_WRITETHRU,
+		.set	= "write through",
+		.clear	= "             ",
+	}, {
+#endif
+		.mask	= _PAGE_NO_CACHE,
+		.val	= _PAGE_NO_CACHE,
+		.set	= "no cache",
+		.clear	= "        ",
+	}, {
+		.mask	= H_PAGE_BUSY,
+		.val	= H_PAGE_BUSY,
+		.set	= "busy",
+	}, {
+#ifdef CONFIG_PPC_64K_PAGES
+		.mask	= H_PAGE_COMBO,
+		.val	= H_PAGE_COMBO,
+		.set	= "combo",
+	}, {
+		.mask	= H_PAGE_4K_PFN,
+		.val	= H_PAGE_4K_PFN,
+		.set	= "4K_pfn",
+	}, {
+#endif
+		.mask	= H_PAGE_F_GIX,
+		.val	= H_PAGE_F_GIX,
+		.set	= "f_gix",
+		.is_val	= true,
+		.shift	= H_PAGE_F_GIX_SHIFT,
+	}, {
+		.mask	= H_PAGE_F_SECOND,
+		.val	= H_PAGE_F_SECOND,
+		.set	= "f_second",
+	}, {
+		.mask	= _PAGE_SPECIAL,
+		.val	= _PAGE_SPECIAL,
+		.set	= "special",
+	}
+};
+
+struct pgtable_level {
+	const struct flag_info *flag;
+	size_t num;
+	u64 mask;
+};
+
+static struct pgtable_level pg_level[] = {
+	{
+	}, { /* pgd */
+		.flag	= flag_array,
+		.num	= ARRAY_SIZE(flag_array),
+	}, { /* pud */
+		.flag	= flag_array,
+		.num	= ARRAY_SIZE(flag_array),
+	}, { /* pmd */
+		.flag	= flag_array,
+		.num	= ARRAY_SIZE(flag_array),
+	}, { /* pte */
+		.flag	= flag_array,
+		.num	= ARRAY_SIZE(flag_array),
+	},
+};
+
+static void dump_flag_info(struct pg_state *st, const struct flag_info
+		*flag, u64 pte, int num)
+{
+	unsigned int i;
+
+	for (i = 0; i < num; i++, flag++) {
+		const char *s = NULL;
+		u64 val;
+
+		/* flag not defined so don't check it */
+		if (flag->mask == 0)
+			continue;
+		/* Some 'flags' are actually values */
+		if (flag->is_val) {
+			val = pte & flag->val;
+			if (flag->shift)
+				val = val >> flag->shift;
+			seq_printf(st->seq, "  %s:%llx", flag->set, val);
+		} else {
+			if ((pte & flag->mask) == flag->val)
+				s = flag->set;
+			else
+				s = flag->clear;
+			if (s)
+				seq_printf(st->seq, "  %s", s);
+		}
+		st->current_flags &= ~flag->mask;
+	}
+	if (st->current_flags != 0)
+		seq_printf(st->seq, "  unknown flags:%llx", st->current_flags);
+}
+
+static void dump_addr(struct pg_state *st, unsigned long addr)
+{
+	static const char units[] = "KMGTPE";
+	const char *unit = units;
+	unsigned long delta;
+
+	seq_printf(st->seq, "0x%016lx-0x%016lx   ", st->start_address, addr-1);
+	delta = (addr - st->start_address) >> 10;
+	/* Work out what appropriate unit to use */
+	while (!(delta & 1023) && unit[1]) {
+		delta >>= 10;
+		unit++;
+	}
+	seq_printf(st->seq, "%9lu%c", delta, *unit);
+
+}
+
+static void note_page(struct pg_state *st, unsigned long addr,
+	       unsigned int level, u64 val)
+{
+	u64 flag = val & pg_level[level].mask;
+	/* At first no level is set */
+	if (!st->level) {
+		st->level = level;
+		st->current_flags = flag;
+		st->start_address = addr;
+		seq_printf(st->seq, "---[ %s ]---\n", st->marker->name);
+	/*
+	 * Dump the section of virtual memory when:
+	 *   - the PTE flags from one entry to the next differs.
+	 *   - we change levels in the tree.
+	 *   - the address is in a different section of memory and is thus
+	 *   used for a different purpose, regardless of the flags.
+	 */
+	} else if (flag != st->current_flags || level != st->level ||
+		   addr >= st->marker[1].start_address) {
+
+		/* Check the PTE flags */
+		if (st->current_flags) {
+			dump_addr(st, addr);
+
+			/* Dump all the flags */
+			if (pg_level[st->level].flag)
+				dump_flag_info(st, pg_level[st->level].flag,
+					  st->current_flags,
+					  pg_level[st->level].num);
+
+			seq_puts(st->seq, "\n");
+		}
+
+		/*
+		 * Address indicates we have passed the end of the
+		 * current section of virtual memory
+		 */
+		while (addr >= st->marker[1].start_address) {
+			st->marker++;
+			seq_printf(st->seq, "---[ %s ]---\n", st->marker->name);
+		}
+		st->start_address = addr;
+		st->current_flags = flag;
+		st->level = level;
+	}
+}
+
+static void walk_pte(struct pg_state *st, pmd_t *pmd, unsigned long start)
+{
+	pte_t *pte = pte_offset_kernel(pmd, 0);
+	unsigned long addr;
+	unsigned int i;
+
+	for (i = 0; i < PTRS_PER_PTE; i++, pte++) {
+		addr = start + i * PAGE_SIZE;
+		note_page(st, addr, 4, pte_val(*pte));
+
+	}
+}
+
+static void walk_pmd(struct pg_state *st, pud_t *pud, unsigned long start)
+{
+	pmd_t *pmd = pmd_offset(pud, 0);
+	unsigned long addr;
+	unsigned int i;
+
+	for (i = 0; i < PTRS_PER_PMD; i++, pmd++) {
+		addr = start + i * PMD_SIZE;
+		if (!pmd_none(*pmd))
+			/* pmd exists */
+			walk_pte(st, pmd, addr);
+		else
+			note_page(st, addr, 3, pmd_val(*pmd));
+	}
+}
+
+static void walk_pud(struct pg_state *st, pgd_t *pgd, unsigned long start)
+{
+	pud_t *pud = pud_offset(pgd, 0);
+	unsigned long addr;
+	unsigned int i;
+
+	for (i = 0; i < PTRS_PER_PUD; i++, pud++) {
+		addr = start + i * PUD_SIZE;
+		if (!pud_none(*pud))
+			/* pud exists */
+			walk_pmd(st, pud, addr);
+		else
+			note_page(st, addr, 2, pud_val(*pud));
+	}
+}
+
+static void walk_pagetables(struct pg_state *st)
+{
+	pgd_t *pgd = pgd_offset_k(0UL);
+	unsigned int i;
+	unsigned long addr;
+
+	/*
+	 * Traverse the linux pagetable structure and dump pages that are in
+	 * the hash pagetable.
+	 */
+	for (i = 0; i < PTRS_PER_PGD; i++, pgd++) {
+		addr = KERN_VIRT_START + i * PGDIR_SIZE;
+		if (!pgd_none(*pgd))
+			/* pgd exists */
+			walk_pud(st, pgd, addr);
+		else
+			note_page(st, addr, 1, pgd_val(*pgd));
+	}
+}
+
+static void populate_markers(void)
+{
+	address_markers[0].start_address = PAGE_OFFSET;
+	address_markers[1].start_address = VMALLOC_START;
+	address_markers[2].start_address = VMALLOC_END;
+	address_markers[3].start_address = ISA_IO_BASE;
+	address_markers[4].start_address = ISA_IO_END;
+	address_markers[5].start_address = PHB_IO_BASE;
+	address_markers[6].start_address = PHB_IO_END;
+	address_markers[7].start_address = IOREMAP_BASE;
+	address_markers[8].start_address = IOREMAP_END;
+#ifdef CONFIG_PPC_STD_MMU_64
+	address_markers[9].start_address =  H_VMEMMAP_BASE;
+#else
+	address_markers[9].start_address =  VMEMMAP_BASE;
+#endif
+}
+
+static int ptdump_show(struct seq_file *m, void *v)
+{
+	struct pg_state st = {
+		.seq = m,
+		.start_address = KERN_VIRT_START,
+		.marker = address_markers,
+	};
+	/* Traverse kernel page tables */
+	walk_pagetables(&st);
+	note_page(&st, 0, 0, 0);
+	return 0;
+}
+
+
+static int ptdump_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, ptdump_show, NULL);
+}
+
+static const struct file_operations ptdump_fops = {
+	.open		= ptdump_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static void build_pgtable_complete_mask(void)
+{
+	unsigned int i, j;
+
+	for (i = 0; i < ARRAY_SIZE(pg_level); i++)
+		if (pg_level[i].flag)
+			for (j = 0; j < pg_level[i].num; j++)
+				pg_level[i].mask |= pg_level[i].flag[j].mask;
+}
+
+static int ptdump_init(void)
+{
+	struct dentry *debugfs_file;
+
+	populate_markers();
+	build_pgtable_complete_mask();
+	debugfs_file = debugfs_create_file("kernel_pagetables", 0400, NULL,
+			NULL, &ptdump_fops);
+	return debugfs_file ? 0 : -ENOMEM;
+}
+device_initcall(ptdump_init);
-- 
2.5.0
