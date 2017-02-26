Return-Path: <oohall@gmail.com>
Received: from mail-qk0-x243.google.com (mail-qk0-x243.google.com
 [IPv6:2607:f8b0:400d:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vWhXM68bdzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2017 10:54:43 +1100 (AEDT)
Received: by mail-qk0-x243.google.com with SMTP id r90so13427984qki.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Feb 2017 15:54:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170222213910.5628-1-rashmica.g@gmail.com>
References: <20170222213910.5628-1-rashmica.g@gmail.com>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Mon, 27 Feb 2017 10:54:41 +1100
Message-ID: <CAOSf1CEOtK-sYoc+J=O5=gLsPX=spOKfHp73Es0Wjmj5NAKwVw@mail.gmail.com>
Subject: Re: [RFC] Remove memory from nodes for memtrace.
To: Rashmica Gupta <rashmica.g@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
 Balbir Singh <bsingharora@gmail.com>, dllehr@us.ibm.com,
 Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 23, 2017 at 8:39 AM, Rashmica Gupta <rashmica.g@gmail.com> wrote:
>  Some powerpc hardware features may want to gain access to a
>  chunk of undisturbed real memory.  This update provides a means to unplug
>  said memory from the kernel with a set of sysfs calls.  By writing an integer
>  containing  the size of memory to be unplugged into
>  /sys/kernel/debug/powerpc/memtrace/enable, the code will remove that much
>  memory from the end of each available chip's memory space. In addition, the
>  means to read out the contents of the unplugged memory is also provided by
>  reading out the /sys/kernel/debug/powerpc/memtrace/<chip-id>/dump file.
>
> Signed-off-by: Rashmica Gupta <rashmica.g@gmail.com>
> ---
> Written by Douglas Lehr <dllehr@us.ibm.com>.
> Have tested and seems to work as I would expect. Only change I have made from
> the original is to check that the value being written to the debugfs file is
> not 0 (or obscenely large), as otherwise you get a nice kernel oops where the
> kernel attempts to access data at 0xfffffffe0.
>
> Thoughts about doing this with hot unplug or other changes?
>
>  arch/powerpc/mm/hash_native_64.c          |  39 +++-
>  arch/powerpc/platforms/powernv/Makefile   |   1 +
>  arch/powerpc/platforms/powernv/memtrace.c | 285 ++++++++++++++++++++++++++++++
>  3 files changed, 321 insertions(+), 4 deletions(-)
>  create mode 100644 arch/powerpc/platforms/powernv/memtrace.c
>
> diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
> index cc33260..44cc6ce 100644
> --- a/arch/powerpc/mm/hash_native_64.c
> +++ b/arch/powerpc/mm/hash_native_64.c
> @@ -3,7 +3,7 @@
>   *
>   * SMP scalability work:
>   *    Copyright (C) 2001 Anton Blanchard <anton@au.ibm.com>, IBM
> - *
> + *
>   * This program is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU General Public License
>   * as published by the Free Software Foundation; either version
> @@ -181,7 +181,7 @@ static inline void native_lock_hpte(struct hash_pte *hptep)
>         while (1) {
>                 if (!test_and_set_bit_lock(HPTE_LOCK_BIT, word))
>                         break;
> -               while(test_bit(HPTE_LOCK_BIT, word))
> +               while (test_bit(HPTE_LOCK_BIT, word))
>                         cpu_relax();
>         }
>  }
> @@ -208,10 +208,10 @@ static long native_hpte_insert(unsigned long hpte_group, unsigned long vpn,
>         }
>
>         for (i = 0; i < HPTES_PER_GROUP; i++) {
> -               if (! (be64_to_cpu(hptep->v) & HPTE_V_VALID)) {
> +               if (!(be64_to_cpu(hptep->v) & HPTE_V_VALID)) {
>                         /* retry with lock held */
>                         native_lock_hpte(hptep);
> -                       if (! (be64_to_cpu(hptep->v) & HPTE_V_VALID))
> +                       if (!(be64_to_cpu(hptep->v) & HPTE_V_VALID))
>                                 break;
>                         native_unlock_hpte(hptep);
>                 }
> @@ -407,6 +407,36 @@ static void native_hpte_updateboltedpp(unsigned long newpp, unsigned long ea,
>         tlbie(vpn, psize, psize, ssize, 0);
>  }
>
> +/*
> + * Remove a bolted kernel entry. Memory hotplug uses this.
> + *
> + * No need to lock here because we should be the only user.
> + */
> +static int native_hpte_removebolted(unsigned long ea, int psize, int ssize)
> +{
> +       unsigned long vpn;
> +       unsigned long vsid;
> +       long slot;
> +       struct hash_pte *hptep;
> +
> +       vsid = get_kernel_vsid(ea, ssize);
> +       vpn = hpt_vpn(ea, vsid, ssize);
> +
> +       slot = native_hpte_find(vpn, psize, ssize);
> +       if (slot == -1)
> +               return -ENOENT;
> +
> +       hptep = htab_address + slot;
> +
> +       /* Invalidate the hpte */
> +       hptep->v = 0;
> +
> +       /* Invalidate the TLB */
> +       tlbie(vpn, psize, psize, ssize, 0);
> +       return 0;
> +}
> +
> +
>  static void native_hpte_invalidate(unsigned long slot, unsigned long vpn,
>                                    int bpsize, int apsize, int ssize, int local)
>  {
> @@ -722,6 +752,7 @@ void __init hpte_init_native(void)
>         mmu_hash_ops.hpte_invalidate    = native_hpte_invalidate;
>         mmu_hash_ops.hpte_updatepp      = native_hpte_updatepp;
>         mmu_hash_ops.hpte_updateboltedpp = native_hpte_updateboltedpp;
> +       mmu_hash_ops.hpte_removebolted = native_hpte_removebolted;
>         mmu_hash_ops.hpte_insert        = native_hpte_insert;
>         mmu_hash_ops.hpte_remove        = native_hpte_remove;
>         mmu_hash_ops.hpte_clear_all     = native_hpte_clear;
> diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
> index b5d98cb..2026661 100644
> --- a/arch/powerpc/platforms/powernv/Makefile
> +++ b/arch/powerpc/platforms/powernv/Makefile
> @@ -11,4 +11,5 @@ obj-$(CONFIG_EEH)     += eeh-powernv.o
>  obj-$(CONFIG_PPC_SCOM) += opal-xscom.o
>  obj-$(CONFIG_MEMORY_FAILURE)   += opal-memory-errors.o
>  obj-$(CONFIG_TRACEPOINTS)      += opal-tracepoints.o
> +obj-$(CONFIG_MEMORY_HOTREMOVE)         += memtrace.o
>  obj-$(CONFIG_OPAL_PRD) += opal-prd.o
> diff --git a/arch/powerpc/platforms/powernv/memtrace.c b/arch/powerpc/platforms/powernv/memtrace.c
> new file mode 100644
> index 0000000..fdba3ee
> --- /dev/null
> +++ b/arch/powerpc/platforms/powernv/memtrace.c
> @@ -0,0 +1,285 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * Copyright (C) IBM Corporation, 2014
> + *
> + * Author: Anton Blanchard <anton@au.ibm.com>
> + */
> +
> +#define pr_fmt(fmt) "powernv-memtrace: " fmt
> +
> +#include <linux/bitops.h>
> +#include <linux/string.h>
> +#include <linux/memblock.h>
> +#include <linux/init.h>
> +#include <linux/moduleparam.h>
> +#include <linux/fs.h>
> +#include <linux/debugfs.h>
> +#include <linux/slab.h>
> +#include <linux/memory.h>
> +#include <linux/memory_hotplug.h>
> +#include <asm/machdep.h>
> +
> +struct memtrace_entry {
> +       void *mem;
> +       u64 start;
> +       u64 size;
> +       u32 nid;
> +       struct dentry *dir;
> +       char name[16];
> +};
> +
> +static struct memtrace_entry *memtrace_array;
> +static unsigned int memtrace_array_nr;
> +
> +static ssize_t memtrace_read(struct file *filp, char __user *ubuf,
> +                            size_t count, loff_t *ppos)
> +{
> +       struct memtrace_entry *ent = filp->private_data;
> +
> +       return simple_read_from_buffer(ubuf, count, ppos, ent->mem, ent->size);
> +}
> +
> +static bool valid_memtrace_range(struct memtrace_entry *dev,
> +                                unsigned long start, unsigned long size)
> +{
> +       if ((dev->start <= start) &&
> +           ((start + size) <= (dev->start + dev->size)))
> +               return true;
> +
> +       return false;
> +}
> +
> +static int memtrace_mmap(struct file *filp, struct vm_area_struct *vma)
> +{
> +       unsigned long size = vma->vm_end - vma->vm_start;
> +       struct memtrace_entry *dev = filp->private_data;
> +
> +       if (!valid_memtrace_range(dev, vma->vm_pgoff << PAGE_SHIFT, size))
> +               return -EINVAL;
> +
> +       vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> +
> +       if (io_remap_pfn_range(vma, vma->vm_start,
> +                              vma->vm_pgoff + (dev->start >> PAGE_SHIFT),
> +                              size, vma->vm_page_prot))
> +               return -EAGAIN;
> +
> +       return 0;
> +}
> +
> +static const struct file_operations memtrace_fops = {
> +       .llseek = default_llseek,
> +       .read   = memtrace_read,
> +       .mmap   = memtrace_mmap,
> +       .open   = simple_open,
> +};
> +

> +static void flush_memory_region(u64 base, u64 size)
> +{
> +       unsigned long line_size = ppc64_caches.dline_size;
> +       u64 end = base + size;
> +       u64 addr;
> +
> +       base = round_down(base, line_size);
> +       end = round_up(end, line_size);
> +
> +       for (addr = base; addr < end; addr += line_size)
> +               asm volatile("dcbf 0,%0" : "=r" (addr) :: "memory");
> +}

I think this is the same as flush_inval_dcache_range()?

> +
> +static int check_memblock_online(struct memory_block *mem, void *arg)
> +{
> +       if (mem->state != MEM_ONLINE)
> +               return -1;
> +
> +       return 0;
> +}
> +
> +static int change_memblock_state(struct memory_block *mem, void *arg)
> +{
> +       unsigned long state = (unsigned long)arg;
> +
> +       mem->state = state;
> +       return 0;
> +}
> +
> +static bool memtrace_offline_pages(u32 nid, u64 start_pfn, u64 nr_pages)
> +{
> +       u64 end_pfn = start_pfn + nr_pages - 1;
> +
> +       if (walk_memory_range(start_pfn, end_pfn, NULL,
> +           check_memblock_online))
> +               return false;
> +
> +       walk_memory_range(start_pfn, end_pfn, (void *)MEM_GOING_OFFLINE,
> +                         change_memblock_state);
> +
> +       if (offline_pages(start_pfn, nr_pages)) {
> +               walk_memory_range(start_pfn, end_pfn, (void *)MEM_ONLINE,
> +                                 change_memblock_state);
> +               return false;
> +       }
> +
> +       walk_memory_range(start_pfn, end_pfn, (void *)MEM_OFFLINE,
> +                         change_memblock_state);
> +

> +       /* RCU grace period? */
> +       flush_memory_region((u64)__va(start_pfn << PAGE_SHIFT), nr_pages << PAGE_SHIFT);
> +
> +       remove_memory(nid, start_pfn << PAGE_SHIFT, nr_pages << PAGE_SHIFT);

This concerns me slightly. We're relying on flush_memory_region() to
ensure the whole region is out of the cache, but until it's been
unmapped the processor can still do speculative loads from this
region. Given the memory will be re-mapped as cache inhibited this is
opening a window for cache paradoxes. It might not be an issue, but if
you encounter random checkstops while testing we should look into
hardening this.

> +
> +       return true;
> +}
> +
> +static u64 memtrace_alloc_node(u32 nid, u64 size)
> +{
> +       u64 start_pfn, end_pfn, nr_pages;
> +       u64 base_pfn;
> +
> +       if (!NODE_DATA(nid) || !node_spanned_pages(nid))
> +               return 0;
> +
> +       start_pfn = node_start_pfn(nid);
> +       end_pfn = node_end_pfn(nid);
> +       nr_pages = size >> PAGE_SHIFT;
> +
> +       /* Trace memory needs to be aligned to the size */
> +       start_pfn = round_up(start_pfn, nr_pages);
> +
> +       for (base_pfn = start_pfn; base_pfn < end_pfn; base_pfn += nr_pages) {
> +               if (memtrace_offline_pages(nid, base_pfn, nr_pages) == true)
> +                       return base_pfn << PAGE_SHIFT;
> +       }
> +
> +       return 0;
> +}
> +
> +static int memtrace_init_regions_runtime(u64 size)
> +{
> +       u64 m;
> +       u32 nid;
> +
> +       memtrace_array = kzalloc(sizeof(struct memtrace_entry) *
> +                               num_online_nodes(), GFP_KERNEL);
> +       if (!memtrace_array) {
> +               pr_err("Failed to allocate memtrace_array\n");
> +               return -EINVAL;
> +       }
> +
> +       for_each_online_node(nid) {
> +               m = memtrace_alloc_node(nid, size);
> +               /*
> +                * A node might not have any local memory, so warn but
> +                * continue on.
> +                */
> +               if (!m) {
> +                       pr_err("Failed to allocate trace memory on node %d\n",
> +                                nid);
> +               } else {
> +                       pr_info("Allocated trace memory on node %d at "
> +                               "0x%016llx\n", nid, m);
> +
> +                       memtrace_array[memtrace_array_nr].start = m;
> +                       memtrace_array[memtrace_array_nr].size = size;
> +                       memtrace_array[memtrace_array_nr].nid = nid;
> +                       memtrace_array_nr++;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +static struct dentry *memtrace_debugfs_dir;
> +
> +static int memtrace_init_debugfs(void)
> +{
> +       int ret = 0;
> +       int i;
> +
> +       for (i = 0; i < memtrace_array_nr; i++) {
> +               struct dentry *dir;
> +               struct memtrace_entry *ent = &memtrace_array[i];
> +
> +               ent->mem = ioremap(ent->start, ent->size);
> +               /* Warn but continue on */
> +               if (!ent->mem) {
> +                       pr_err("Failed to map trace memory at 0x%llx\n",
> +                                ent->start);
> +                       ret = -1;
> +                       continue;
> +               }
> +
> +               snprintf(ent->name, 16, "%08x", ent->nid);
> +               dir = debugfs_create_dir(ent->name, memtrace_debugfs_dir);
> +               if (!dir)
> +                       return -1;
> +
> +               ent->dir = dir;
> +               debugfs_create_file("trace", S_IRUSR, dir, ent, &memtrace_fops);
> +               debugfs_create_x64("start", S_IRUSR, dir, &ent->start);
> +               debugfs_create_x64("size", S_IRUSR, dir, &ent->size);
> +               debugfs_create_u32("node", S_IRUSR, dir, &ent->nid);
> +       }
> +
> +       return ret;
> +}
> +
> +static u64 memtrace_size;
> +
> +static int memtrace_enable_set(void *data, u64 val)
> +{
> +       if (memtrace_size)
> +               return -EINVAL;
> +
> +       if (!val)
> +               return -EINVAL;
> +

> +       /* Make sure size is aligned to a memory block */
> +       if (val & (memory_block_size_bytes()-1))
> +               return -EINVAL;
Printing a warning here with the expected alignment would be helpful .

> +
> +       if (memtrace_init_regions_runtime(val))
> +               return -EINVAL;
> +
> +       if (memtrace_init_debugfs())
> +               return -EINVAL;
> +
> +       memtrace_size = val;
> +
> +       return 0;
> +}

I know this RFC is mostly about how the offlining path should be
handled, but can you sketch out the re-onlining path too?
