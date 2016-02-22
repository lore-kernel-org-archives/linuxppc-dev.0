Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6F7211A05F8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 21:22:56 +1100 (AEDT)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 22 Feb 2016 20:22:55 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id E5A383578169
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 21:14:19 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1MAEBML43712562
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 21:14:19 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1MADlJU023347
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 21:13:47 +1100
Message-ID: <56CADF49.6040008@linux.vnet.ibm.com>
Date: Mon, 22 Feb 2016 15:43:29 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Rashmica Gupta <rashmicy@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/pagetable: Add option to dump kernel pagetable
References: <1456120933-23109-1-git-send-email-rashmicy@gmail.com>
In-Reply-To: <1456120933-23109-1-git-send-email-rashmicy@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/22/2016 11:32 AM, Rashmica Gupta wrote:
> Useful to be able to dump the kernel page tables to check permissions and
> memory types - derived from arm64's implementation.
> 
> Add a debugfs file to check the page tables. To use this the PPC_PTDUMP
> config option must be selected.
> 
> Tested on 64BE and 64LE with both 4K and 64K page sizes.
> ---

This statement above must be after the ---- line else it will be part of
the commit message or you wanted the test note as part of commit message
itself ?

The patch seems to contain some white space problems. Please clean them up.

>  arch/powerpc/Kconfig.debug |  12 ++
>  arch/powerpc/mm/Makefile   |   1 +
>  arch/powerpc/mm/dump.c     | 364 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 377 insertions(+)
>  create mode 100644 arch/powerpc/mm/dump.c
> 
> diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
> index 638f9ce740f5..e4883880abe3 100644
> --- a/arch/powerpc/Kconfig.debug
> +++ b/arch/powerpc/Kconfig.debug
> @@ -344,4 +344,16 @@ config FAIL_IOMMU
>  
>  	  If you are unsure, say N.
>  
> +config PPC_PTDUMP
> +        bool "Export kernel pagetable layout to userspace via debugfs"
> +        depends on DEBUG_KERNEL
> +        select DEBUG_FS
> +        help
> +          This options dumps the state of the kernel pagetables in a debugfs
> +          file. This is only useful for kernel developers who are working in
> +          architecture specific areas of the kernel - probably not a good idea to
> +          enable this feature in a production kernel.

Just clean the paragraph alignment here ......................................^^^^^^^^

> +
> +          If you are unsure, say N.
> +
>  endmenu
> diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
> index 1ffeda85c086..16f84bdd7597 100644
> --- a/arch/powerpc/mm/Makefile
> +++ b/arch/powerpc/mm/Makefile
> @@ -40,3 +40,4 @@ obj-$(CONFIG_NOT_COHERENT_CACHE) += dma-noncoherent.o
>  obj-$(CONFIG_HIGHMEM)		+= highmem.o
>  obj-$(CONFIG_PPC_COPRO_BASE)	+= copro_fault.o
>  obj-$(CONFIG_SPAPR_TCE_IOMMU)	+= mmu_context_iommu.o
> +obj-$(CONFIG_PPC_PTDUMP)	+= dump.o

File name like "[kernel_]pgtable_dump.c" will sound better ? Or
just use like the X86 one "dump_pagetables.c". "dump.c" sounds
very generic.

> diff --git a/arch/powerpc/mm/dump.c b/arch/powerpc/mm/dump.c
> new file mode 100644
> index 000000000000..937b10fc40cc
> --- /dev/null
> +++ b/arch/powerpc/mm/dump.c
> @@ -0,0 +1,364 @@
> +/*
> + * Copyright 2016, Rashmica Gupta, IBM Corp.
> + * 
> + * Debug helper to dump the current kernel pagetables of the system
> + * so that we can see what the various memory ranges are set to.
> + * 
> + * Derived from the arm64 implementation:
> + * Copyright (c) 2014, The Linux Foundation, Laura Abbott.
> + * (C) Copyright 2008 Intel Corporation, Arjan van de Ven.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; version 2
> + * of the License.
> + */
> +#include <linux/debugfs.h>
> +#include <linux/fs.h>
> +#include <linux/io.h>
> +#include <linux/mm.h>
> +#include <linux/sched.h>
> +#include <linux/seq_file.h>
> +#include <asm/fixmap.h>
> +#include <asm/pgtable.h>
> +#include <linux/const.h>
> +#include <asm/page.h>
> +
> +#define PUD_TYPE_MASK           (_AT(u64, 3) << 0)
> +#define PUD_TYPE_SECT           (_AT(u64, 1) << 0)
> +#define PMD_TYPE_MASK           (_AT(u64, 3) << 0)
> +#define PMD_TYPE_SECT           (_AT(u64, 1) << 0)
> +
> + 
> +#if CONFIG_PGTABLE_LEVELS == 2
> +#include <asm-generic/pgtable-nopmd.h>
> +#elif CONFIG_PGTABLE_LEVELS == 3
> +#include <asm-generic/pgtable-nopud.h>
> +#endif

Really ? Do we have any platform with only 2 level of page table ?
 
> + 
> +#define pmd_sect(pmd)  ((pmd_val(pmd) & PMD_TYPE_MASK) == PMD_TYPE_SECT)
> +#ifdef CONFIG_PPC_64K_PAGES
> +#define pud_sect(pud)           (0)
> +#else
> +#define pud_sect(pud)           ((pud_val(pud) & PUD_TYPE_MASK) == \
> +                                               PUD_TYPE_SECT)
> +#endif

Can you please explain the use of pmd_sect() and pud_sect() defines ?

> +	     
> +
> +struct addr_marker {
> +	unsigned long start_address;
> +	const char *name;
> +};

All the architectures are using the same structure addr_marker.
Cannot we just move it to a generic header file ? There are
other such common structures like these in the file which are
used across architectures and can be moved to some where common ?

> +
> +enum address_markers_idx {
> +	VMALLOC_START_NR = 0,
> +	VMALLOC_END_NR,
> +	ISA_IO_START_NR,
> +	ISA_IO_END_NR,
> +	PHB_IO_START_NR,
> +	PHB_IO_END_NR,
> +	IOREMAP_START_NR,
> +	IOREMP_END_NR,
> +};

Where these are used ? ^^^^^^^^^ I dont see any where.

Also as it dumps only the kernel virtual mapping, should not we
mention about it some where.

> +
> +static struct addr_marker address_markers[] = {
> +	{ VMALLOC_START,	"vmalloc() Area" },
> +	{ VMALLOC_END,		"vmalloc() End" },
> +	{ ISA_IO_BASE,		"isa I/O start" },
> +	{ ISA_IO_END,		"isa I/O end" },
> +	{ PHB_IO_BASE,		"phb I/O start" },
> +	{ PHB_IO_END,		"phb I/O end" },
> +	{ IOREMAP_BASE,		"I/O remap start" },
> +	{ IOREMAP_END,		"I/O remap end" },
> +	{ -1,			NULL },
> +};


I understand that VMEMMAP range is not covered under the kernel virtual
mapping page table. But we can hook it up looking into the linked list
we track for the VA-PA mappings in there. Just a suggestion.

> +
> +/*
> + * The page dumper groups page table entries of the same type into a single
> + * description. It uses pg_state to track the range information while
> + * iterating over the pte entries. When the continuity is broken it then
> + * dumps out a description of the range.
> + */

This needs to be more detailed. Some where at the starting point of the
file we need to write detailed description about what all information it
is dumping and how.

> +struct pg_state {
> +	struct seq_file *seq;
> +	const struct addr_marker *marker;
> +	unsigned long start_address;
> +	unsigned level;
> +	u64 current_prot;
> +};
> +
> +struct prot_bits {
> +	u64		mask;
> +	u64		val;
> +	const char	*set;
> +	const char	*clear;
> +};

This structure encapsulates various PTE flags bit information.
Then why it is named as "prot_bits" ?

> +
> +static const struct prot_bits pte_bits[] = {
> +	{
> +		.mask	= _PAGE_USER,
> +		.val	= _PAGE_USER,
> +		.set	= "user",
> +		.clear	= "    ",
> +	}, {
> +		.mask	= _PAGE_RW,
> +		.val	= _PAGE_RW,
> +		.set	= "rw",
> +		.clear	= "ro",
> +	}, {
> +		.mask	= _PAGE_EXEC,
> +		.val	= _PAGE_EXEC,
> +		.set	= " X ",
> +		.clear	= "   ",
> +	}, {
> +		.mask	= _PAGE_PTE,
> +		.val	= _PAGE_PTE,
> +		.set	= "pte",
> +		.clear	= "   ",
> +	}, {
> +		.mask	= _PAGE_PRESENT,
> +		.val	= _PAGE_PRESENT,
> +		.set	= "present",
> +		.clear	= "       ",
> +	}, {
> +		.mask	= _PAGE_HASHPTE,
> +		.val	= _PAGE_HASHPTE,
> +		.set	= "htpe",
> +		.clear	= "    ",
> +	}, {
> +		.mask	= _PAGE_GUARDED,
> +		.val	= _PAGE_GUARDED,
> +		.set	= "guarded",
> +		.clear	= "       ",
> +	}, {
> +		.mask	= _PAGE_DIRTY,
> +		.val	= _PAGE_DIRTY,
> +		.set	= "dirty",
> +		.clear	= "     ",
> +	}, {
> +		.mask	= _PAGE_ACCESSED,
> +		.val	= _PAGE_ACCESSED,
> +		.set	= "accessed",
> +		.clear	= "        ",
> +	}, {
> +		.mask	= _PAGE_WRITETHRU,
> +		.val	= _PAGE_WRITETHRU,
> +		.set	= "write through",
> +		.clear	= "             ",
> +	}, {
> +		.mask	= _PAGE_NO_CACHE,
> +		.val	= _PAGE_NO_CACHE,
> +		.set	= "no cache",
> +		.clear	= "        ",
> +	}, {
> +		.mask	= _PAGE_BUSY,
> +		.val	= _PAGE_BUSY,
> +		.set	= "busy",
> +	}, {
> +		.mask	= _PAGE_F_GIX,
> +		.val	= _PAGE_F_GIX,
> +		.set	= "gix",
> +	}, {
> +		.mask	= _PAGE_F_SECOND,
> +		.val	= _PAGE_F_SECOND,
> +		.set	= "second",
> +	}, {
> +		.mask	= _PAGE_SPECIAL,
> +		.val	= _PAGE_SPECIAL,
> +		.set	= "special",
> +	}
> +};
> +
> +struct pg_level {
> +	const struct prot_bits *bits;
> +	size_t num;
> +	u64 mask;
> +};
> +

It describes each level of the page table and what all kind of
PTE flags can be there at each of these levels and their combined
mask. The structure and it's elements must be named accordingly.
Its confusing right now.

> +static struct pg_level pg_level[] = {
> +	{
> +	}, { /* pgd */
> +		.bits	= pte_bits,
> +		.num	= ARRAY_SIZE(pte_bits),
> +	}, { /* pud */
> +		.bits	= pte_bits,
> +		.num	= ARRAY_SIZE(pte_bits),
> +	}, { /* pmd */
> +		.bits	= pte_bits,
> +		.num	= ARRAY_SIZE(pte_bits),
> +	}, { /* pte */
> +		.bits	= pte_bits,
> +		.num	= ARRAY_SIZE(pte_bits),
> +	},
> +};
> +
> +static void dump_prot(struct pg_state *st, const struct prot_bits *bits,
> +			size_t num)
> +{
> +	unsigned i;
> +
> +	for (i = 0; i < num; i++, bits++) {
> +		const char *s;
> +
> +		if ((st->current_prot & bits->mask) == bits->val)
> +			s = bits->set;
> +		else
> +			s = bits->clear;
> +
> +		if (s)
> +			seq_printf(st->seq, " %s", s);
> +	}
> +}
> +
> +static void note_page(struct pg_state *st, unsigned long addr, unsigned level,
> +				u64 val)
> +{
> +	static const char units[] = "KMGTPE";
> +	u64 prot = val & pg_level[level].mask;
> +
> +	/* At first no level is set */
> +	if (!st->level) {
> +		st->level = level;
> +		st->current_prot = prot;
> +		st->start_address = addr;
> +		seq_printf(st->seq, "---[ %s ]---\n", st->marker->name);
> +	/* We are only interested in dumping when something (protection,
> +	 *  level of PTE or the section of vmalloc) has changed */

Again, these are PTE flags not protection bits. Please change these
comments accordingly. Also this function does a lot of things, can
we split it up ?

> +	} else if (prot != st->current_prot || level != st->level ||
> +		   addr >= st->marker[1].start_address) {
> +		const char *unit = units;
> +		unsigned long delta;
> +
> +		/* Check protection on PTE */
> +		if (st->current_prot) {
> +			seq_printf(st->seq, "0x%016lx-0x%016lx   ",
> +				   st->start_address, addr-1);
> +
> +			delta = (addr - st->start_address) >> 10;
> +			/* Work out what appropriate unit to use */
> +			while (!(delta & 1023) && unit[1]) {
> +				delta >>= 10;
> +				unit++;
> +			}
> +			seq_printf(st->seq, "%9lu%c", delta, *unit);
> +			/* Dump all the protection flags */
> +			if (pg_level[st->level].bits)
> +				dump_prot(st, pg_level[st->level].bits,
> +					  pg_level[st->level].num);
> +			seq_puts(st->seq, "\n");
> +		}
> +		/* Address indicates we have passed the end of the
> +		 * current section of vmalloc */
> +		while (addr >= st->marker[1].start_address) {
> +			st->marker++;
> +			seq_printf(st->seq, "---[ %s ]---\n", st->marker->name);
> +		}

Right now with this patch, it does not print anything after [ vmalloc() End ].
But I would expect it to go over all other sections one by one. The above
while loop just goes over the list and prints the remaining address range
names. Why ?

0xd00007fffff00000-0xd00007fffff0ffff          64K      rw     pte present htpe         dirty accessed                       
0xd00007fffff10000-0xd00007fffff3ffff         192K      rw     pte present              dirty accessed                       
0xd00007fffff40000-0xd00007fffff4ffff          64K      rw     pte present htpe         dirty accessed                       
0xd00007fffff50000-0xd00007fffff7ffff         192K      rw     pte present              dirty accessed                       
0xd00007fffff80000-0xd00007fffff8ffff          64K      rw     pte present htpe         dirty accessed                       
0xd00007fffff90000-0xd00007fffffbffff         192K      rw     pte present              dirty accessed                       
0xd00007fffffc0000-0xd00007fffffcffff          64K      rw     pte present htpe         dirty accessed                       
0xd00007fffffd0000-0xd00007ffffffffff         192K      rw     pte present              dirty accessed                       
---[ vmalloc() End ]---
---[ isa I/O start ]---
---[ isa I/O end ]---
---[ phb I/O start ]---
---[ phb I/O end ]---
---[ I/O remap start ]---
---[ I/O remap end ]---


> +
> +		st->start_address = addr;
> +		st->current_prot = prot;
> +		st->level = level;
> +	}
> +
> +}
> +
> +static void walk_pte(struct pg_state *st, pmd_t *pmd, unsigned long start)
> +{
> +	pte_t *pte = pte_offset_kernel(pmd, 0);
> +	unsigned long addr;
> +	unsigned i;
> +
> +	for (i = 0; i < PTRS_PER_PTE; i++, pte++) {
> +		addr = start + i * PAGE_SIZE;
> +		note_page(st, addr, 4, pte_val(*pte));
> +	}
> +}
> +
> +static void walk_pmd(struct pg_state *st, pud_t *pud, unsigned long start)
> +{
> +	pmd_t *pmd = pmd_offset(pud, 0);
> +	unsigned long addr;
> +	unsigned i;
> +
> +	for (i = 0; i < PTRS_PER_PMD; i++, pmd++) {
> +		addr = start + i * PMD_SIZE;
> +		if (!pmd_none(*pmd) && !pmd_sect(*pmd))
> +			/* pmd exists */
> +			walk_pte(st, pmd, addr);
> +		else
> +			note_page(st, addr, 3, pmd_val(*pmd));
> +	}
> +}
> +
> +static void walk_pud(struct pg_state *st, pgd_t *pgd, unsigned long start)
> +{
> +	pud_t *pud = pud_offset(pgd, 0);
> +	unsigned long addr = 0UL;
> +	unsigned i;
> +
> +	for (i = 0; i < PTRS_PER_PUD; i++, pud++) {
> +		addr = start + i * PUD_SIZE;
> +		if (!pud_none(*pud) && !pud_sect(*pud))
> +			/* pud exists */
> +			walk_pmd(st, pud, addr);
> +		else
> +			note_page(st, addr, 2, pud_val(*pud));
> +	}
> +}
> +
> +static void walk_pgd(struct pg_state *st, unsigned long start)
> +{
> +	pgd_t *pgd = pgd_offset_k( 0UL);
> +	unsigned i;
> +	unsigned long addr;
> +
> +	for (i = 0; i < PTRS_PER_PGD; i++, pgd++) {
> +		addr = start + i * PGDIR_SIZE;
> +		if(!pgd_none(*pgd))
> +			/* pgd exists */
> +			walk_pud(st, pgd, addr);
> +		else
> +			note_page(st, addr, 1, pgd_val(*pgd));
> +
> +	}
> +}
> +
> +static int ptdump_show(struct seq_file *m, void *v)
> +{
> +	struct pg_state st = {
> +		.seq = m,
> +		.start_address = KERN_VIRT_START,
> +		.marker = address_markers,
> +	};
> +	/* Traverse kernel page tables */
> +	walk_pgd(&st, KERN_VIRT_START);
> +	note_page(&st, 0, 0, 0);
> +	return 0;
> +}
> +
> +static int ptdump_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, ptdump_show, NULL);
> +}
> +
> +static const struct file_operations ptdump_fops = {
> +	.open		= ptdump_open,
> +	.read		= seq_read,
> +	.llseek		= seq_lseek,
> +	.release	= single_release,
> +};
> +
> +static int ptdump_init(void)
> +{
> +	struct dentry *pe;

'pe' as a pointer ? Have a better name like 'pgtable' or simple
pointer like name 'ptr' will be better.


> +	unsigned i, j;
> +
> +	for (i = 0; i < ARRAY_SIZE(pg_level); i++)
> +		if (pg_level[i].bits)
> +			for (j = 0; j < pg_level[i].num; j++)
> +				pg_level[i].mask |= pg_level[i].bits[j].mask;

This is iterating over two data structures at a time. Cant we put
this into a separate function like build_pagetable_complete_mask() ?
