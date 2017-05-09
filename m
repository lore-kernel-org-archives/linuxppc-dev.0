Return-Path: <rashmica.g@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wMVmS5F1rzDqJn
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 May 2017 17:07:04 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id b23so12693280pfc.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 May 2017 00:07:04 -0700 (PDT)
Subject: Re: [PATCH 2/2] v1 powerpc/powernv: Enable removal of memory for in
 memory tracing
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Rashmica Gupta <rashmica.g@gmail.com>, Anton Blanchard <anton@samba.org>,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, npiggin@gmail.com,
 bsingharora@gmail.com, oohall@gmail.com
References: <20170428054227.9176-1-rashmica.g@gmail.com>
 <20170428054227.9176-2-rashmica.g@gmail.com>
 <c3b65fe7-37b2-6a87-1d81-966196b4ce20@linux.vnet.ibm.com>
 <1498ebd3-1239-9e5b-847c-920546443638@gmail.com>
 <2f338864-db39-2c01-1df4-ef5619ff1118@linux.vnet.ibm.com>
From: Rashmica Gupta <rashmica.g@gmail.com>
Message-ID: <ecf639df-387d-0862-9713-fceb829f3fa4@gmail.com>
Date: Tue, 9 May 2017 17:06:56 +1000
MIME-Version: 1.0
In-Reply-To: <2f338864-db39-2c01-1df4-ef5619ff1118@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sorry for the late reply, I somehow missed this.


On 03/05/17 21:56, Anshuman Khandual wrote:
> On 05/03/2017 09:22 AM, Rashmica Gupta wrote:
>> On 28/04/17 19:52, Anshuman Khandual wrote:
>>> On 04/28/2017 11:12 AM, Rashmica Gupta wrote:
>>>> Some powerpc hardware features may want to gain access to a chunk of
>>> What kind of features ? Please add specifics.
>>>
>>>> undisturbed real memory.  This update provides a means to unplug said
>>>> memory
>>> Undisturbed ? Meaning part of memblock and currently inside the buddy
>>> allocator which we are trying to hot unplug out ?
>>>
>>>> from the kernel with a set of debugfs calls.  By writing an integer
>>>> containing
>>>>    the size of memory to be unplugged into
>>> Does the size has some constraints like aligned with memblock section
>>> size ? LMB size ? page block size ? etc. Please add the details.
>> Will do.
>>
>>>> /sys/kernel/debug/powerpc/memtrace/enable, the code will remove that
>>>> much
>>>> memory from the end of each available chip's memory space (ie each
>>>> memory node).
>>> <size> amount (I guess bytes in this case) of memory will be removed
>>> from the end of the NUMA node ? Whats the guarantee that they would be
>>> free at that time and not being pinned by some process ? If its not
>>> guaranteed to be freed, then interface description should state that
>>> clearly.
>> We start looking from the end of the NUMA node but of course there is no
>> guarantee
>> that we will always be able to find some memory there that we are able
>> to remove.
>
> Okay. Do we have interface for giving this memory back to the buddy
> allocator again when we are done with HW tracing ? If not we need to
> add one.

Not at the moment. Last time I spoke to Anton he said something along 
the lines
of it not being too important as if you are getting the hardware traces 
for debugging
purposes you are probably not worried about a bit of memory being out of 
action.

However I can't see why having an interface to online the memory would 
be a bad thing,
so I'll look into it.

>>>> In addition, the means to read out the contents of the unplugged
>>>> memory is also
>>>> provided by reading out the
>>>> /sys/kernel/debug/powerpc/memtrace/<chip-id>/trace
>>>> file.
>>> All of the debugfs file interfaces added here should be documented some
>>> where in detail.
>>>
>>>> Signed-off-by: Anton Blanchard <anton@samba.org>
>>>> Signed-off-by: Rashmica Gupta <rashmica.g@gmail.com>
>>>>
>>>> ---
>>>> This requires the 'Wire up hpte_removebolted for powernv' patch.
>>>>
>>>> RFC -> v1: Added in two missing locks. Replaced the open-coded
>>>> flush_memory_region() with the existing
>>>> flush_inval_dcache_range(start, end).
>>>>
>>>> memtrace_offline_pages() is open-coded because offline_pages is
>>>> designed to be
>>>> called through the sysfs interface - not directly.
>>>>
>>>> We could move the offlining of pages to userspace, which removes some
>>>> of this
>>>> open-coding. This would then require passing info to the kernel such
>>>> that it
>>>> can then remove the memory that has been offlined. This could be done
>>>> using
>>>> notifiers, but this isn't simple due to locking (remove_memory needs
>>>> mem_hotplug_begin() which the sysfs interface already has). This
>>>> could also be
>>>> done through the debugfs interface (similar to what is done here).
>>>> Either way,
>>>> this would require the process that needs the memory to have
>>>> open-coded code
>>>> which it shouldn't really be involved with.
>>>>
>>>> As the current remove_memory() function requires the memory to
>>>> already be
>>>> offlined, it makes sense to keep the offlining and removal of memory
>>>> functionality grouped together so that a process can simply make one
>>>> request to
>>>> unplug some memory. Ideally there would be a kernel function we could
>>>> call that
>>>> would offline the memory and then remove it.
>>>>
>>>>
>>>>    arch/powerpc/platforms/powernv/memtrace.c | 276
>>>> ++++++++++++++++++++++++++++++
>>>>    1 file changed, 276 insertions(+)
>>>>    create mode 100644 arch/powerpc/platforms/powernv/memtrace.c
>>>>
>>>> diff --git a/arch/powerpc/platforms/powernv/memtrace.c
>>>> b/arch/powerpc/platforms/powernv/memtrace.c
>>>> new file mode 100644
>>>> index 0000000..86184b1
>>>> --- /dev/null
>>>> +++ b/arch/powerpc/platforms/powernv/memtrace.c
>>>> @@ -0,0 +1,276 @@
>>>> +/*
>>>> + * This program is free software; you can redistribute it and/or modify
>>>> + * it under the terms of the GNU General Public License as published by
>>>> + * the Free Software Foundation; either version 2 of the License, or
>>>> + * (at your option) any later version.
>>>> + *
>>>> + * This program is distributed in the hope that it will be useful,
>>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>>> + * GNU General Public License for more details.
>>>> + *
>>>> + * Copyright (C) IBM Corporation, 2014
>>>> + *
>>>> + * Author: Anton Blanchard <anton@au.ibm.com>
>>>> + */
>>>> +
>>>> +#define pr_fmt(fmt) "powernv-memtrace: " fmt
>>>> +
>>>> +#include <linux/bitops.h>
>>>> +#include <linux/string.h>
>>>> +#include <linux/memblock.h>
>>>> +#include <linux/init.h>
>>>> +#include <linux/moduleparam.h>
>>>> +#include <linux/fs.h>
>>>> +#include <linux/debugfs.h>
>>>> +#include <linux/slab.h>
>>>> +#include <linux/memory.h>
>>>> +#include <linux/memory_hotplug.h>
>>>> +#include <asm/machdep.h>
>>>> +#include <asm/debugfs.h>
>>>> +#include <asm/cacheflush.h>
>>>> +
>>>> +struct memtrace_entry {
>>>> +    void *mem;
>>>> +    u64 start;
>>>> +    u64 size;
>>>> +    u32 nid;
>>>> +    struct dentry *dir;
>>>> +    char name[16];
>>>> +};
>>> Little bit of description about the structure here will help.
>> Something like 'this enables us to keep track of the memory removed from
>> each node'?
> Right, something like that.
>
>>>> +
>>>> +static struct memtrace_entry *memtrace_array;
>>>> +static unsigned int memtrace_array_nr;
>>>> +
>>>> +static ssize_t memtrace_read(struct file *filp, char __user *ubuf,
>>>> +                 size_t count, loff_t *ppos)
>>>> +{
>>>> +    struct memtrace_entry *ent = filp->private_data;
>>>> +
>>>> +    return simple_read_from_buffer(ubuf, count, ppos, ent->mem,
>>>> ent->size);
>>>> +}
>>>> +
>>>> +static bool valid_memtrace_range(struct memtrace_entry *dev,
>>>> +                 unsigned long start, unsigned long size)
>>>> +{
>>>> +    if ((dev->start <= start) &&
>>> Switch the position of start and dev->start above. Will make
>>> it easy while reading.
>>>
>>>> +        ((start + size) <= (dev->start + dev->size)))
>>>> +        return true;
>>>> +
>>>> +    return false;
>>>> +}
>>>> +
>>>> +static int memtrace_mmap(struct file *filp, struct vm_area_struct *vma)
>>>> +{
>>>> +    unsigned long size = vma->vm_end - vma->vm_start;
>>>> +    struct memtrace_entry *dev = filp->private_data;
>>>> +
>>>> +    if (!valid_memtrace_range(dev, vma->vm_pgoff << PAGE_SHIFT, size))
>>>> +        return -EINVAL;
>>>> +
>>>> +    vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
>>> Why we do this ? Its coming from real RAM not IO memory. Then the page
>>> protection still needs changes ?
>> Once the memory is removed from the kernel mappings we want to mark it as
>> uncachable.
> Got it but why ? Uncachable marking are for pages which will be mapped
> to IO ranges which should not be cached just to prevent the possibility
> of stale data.
>>>> +
>>>> +    if (io_remap_pfn_range(vma, vma->vm_start,
>>>> +                   vma->vm_pgoff + (dev->start >> PAGE_SHIFT),
>>>> +                   size, vma->vm_page_prot))
>>> You can just call remap_pfn_rang() instead though they are all the same.
>>> There is nothing I/O here should be explicit.
>> Good point.
>>
>>>> +        return -EAGAIN;
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static const struct file_operations memtrace_fops = {
>>>> +    .llseek = default_llseek,
>>>> +    .read    = memtrace_read,
>>>> +    .mmap    = memtrace_mmap,
>>>> +    .open    = simple_open,
>>>> +};
>>>> +
>>>> +static int check_memblock_online(struct memory_block *mem, void *arg)
>>>> +{
>>>> +    if (mem->state != MEM_ONLINE)
>>>> +        return -1;
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int change_memblock_state(struct memory_block *mem, void *arg)
>>>> +{
>>>> +    unsigned long state = (unsigned long)arg;
>>>> +
>>>> +    mem->state = state;
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static bool memtrace_offline_pages(u32 nid, u64 start_pfn, u64
>>>> nr_pages)
>>>> +{
>>>> +    u64 end_pfn = start_pfn + nr_pages - 1;
>>>> +
>>>> +    if (walk_memory_range(start_pfn, end_pfn, NULL,
>>>> +        check_memblock_online))
>>>> +        return false;
>>>> +
>>>> +    walk_memory_range(start_pfn, end_pfn, (void *)MEM_GOING_OFFLINE,
>>>> +              change_memblock_state);
>>>> +
>>> walk_memory_range() might be expensive, cant we just change the state
>>> to MEM_GOING_OFFLINE while checking the state for MEM_ONLINE during
>>> the first loop and bail out if any of the memblock is not in MEM_ONLINE
>>> in the first place.
>> Good idea.
>>
>>>> +    mem_hotplug_begin();
>>>> +    if (offline_pages(start_pfn, nr_pages)) {
>>>> +        walk_memory_range(start_pfn, end_pfn, (void *)MEM_ONLINE,
>>>> +                  change_memblock_state);
>>>> +        mem_hotplug_done();
>>> Right, this can remain as is. If we fail to offline pages, mark the
>>> memory blocks as MEM_ONLINE again.
>>>
>>>> +        return false;
>>>> +    }
>>>> +
>>>> +    walk_memory_range(start_pfn, end_pfn, (void *)MEM_OFFLINE,
>>>> +              change_memblock_state);
>>>> +    mem_hotplug_done();
>>> Right.
>>>
>>>> +
>>>> +    /* Clear the dcache to remove any references to the memory */
>>>> +    flush_inval_dcache_range((u64)__va(start_pfn << PAGE_SHIFT),
>>>> +                   (u64)__va(end_pfn << PAGE_SHIFT));
>>> I am wondering why this is required now when we dont do anything for
>>> cache flushing calls from core VM. If its really required now then
>>> it also should be required during memory hot unplug operations in
>>> general as well.
>> I could not see if this was being done when removing memory so figured
>> that it was better to put it in than not do it.
> Looking at the definitions I had pointed out before which gets
> called from core VM, powerpc does not need to do anything specific
> for cache invalidation or flushing. But I am not really sure on
> this. So let it be.
>
>>> /*
>>>    * No cache flushing is required when address mappings are changed,
>>>    * because the caches on PowerPCs are physically addressed.
>>>    */
>>> #define flush_cache_all()            do { } while (0)
>>> #define flush_cache_mm(mm)            do { } while (0)
>>> #define flush_cache_dup_mm(mm)            do { } while (0)
>>> #define flush_cache_range(vma, start, end)    do { } while (0)
>>> #define flush_cache_page(vma, vmaddr, pfn)    do { } while (0)
>>> #define flush_icache_page(vma, page)        do { } while (0)
>>> #define flush_cache_vmap(start, end)        do { } while (0)
>>> #define flush_cache_vunmap(start, end)        do { } while (0)
>>>
>>>
>>>> +
>>>> +    /* Now remove memory from the mappings */
>>>> +    lock_device_hotplug();
>>>> +    remove_memory(nid, start_pfn << PAGE_SHIFT, nr_pages <<
>>>> PAGE_SHIFT);
>>>> +    unlock_device_hotplug();
>>> Right. Now we have successfully taken down the memory.
>>>
>>>> +
>>>> +    return true;
>>>> +}
>>>> +
>>>> +static u64 memtrace_alloc_node(u32 nid, u64 size)
>>>> +{
>>>> +    u64 start_pfn, end_pfn, nr_pages;
>>>> +    u64 base_pfn;
>>>> +
>>>> +    if (!NODE_DATA(nid) || !node_spanned_pages(nid))
>>>> +        return 0;
>>> Why NODE_DATA check is required here ? Each node should have one
>>> allocated and initialized by now, else we have bigger problems.
>>> Is there any specific reason to check for spanned pages instead
>>> of present/managed pages.
>> Anton wrote this check, so will need to confirm with him. I assume
>> we check node_spanned_pages() rather than node_present_pages()
>> because in arch/powerpc/mm/numa.c we set node_spanned_pages() and
>> not node_present_pages()?
> I guess any thing is okay but NODE_DATA() seems redundant though.

Agreed.

>
> struct pglist_data {
>          ..........................
> 	unsigned long node_present_pages; /* total number of physical pages */
> 	unsigned long node_spanned_pages; /* total size of physical page
> 					     range, including holes */
>
> }
>
>>>> +
>>>> +    start_pfn = node_start_pfn(nid);
>>>> +    end_pfn = node_end_pfn(nid);
>>>> +    nr_pages = size >> PAGE_SHIFT;
>>>> +
>>>> +    /* Trace memory needs to be aligned to the size */
>>>> +    end_pfn = round_down(end_pfn - nr_pages, nr_pages);
>>>> +
>>>> +    for (base_pfn = end_pfn; base_pfn > start_pfn; base_pfn -=
>>>> nr_pages) {
>>>> +        if (memtrace_offline_pages(nid, base_pfn, nr_pages) == true)
>>>> +            return base_pfn << PAGE_SHIFT;
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int memtrace_init_regions_runtime(u64 size)
>>>> +{
>>>> +    u64 m;
>>>> +    u32 nid;
>>>> +
>>>> +    memtrace_array = kzalloc(sizeof(struct memtrace_entry) *
>>>> +                num_online_nodes(), GFP_KERNEL);
>>>> +    if (!memtrace_array) {
>>>> +        pr_err("Failed to allocate memtrace_array\n");
>>>> +        return -EINVAL;
>>>> +    }
>>>> +
>>>> +    for_each_online_node(nid) {
>>>> +        m = memtrace_alloc_node(nid, size);
>>>> +        /*
>>>> +         * A node might not have any local memory, so warn but
>>>> +         * continue on.
>>>> +         */
>>>> +        if (!m) {
>>>> +            pr_err("Failed to allocate trace memory on node %d\n",
>>>> +                 nid);
>>>> +        } else {
>>>> +            pr_info("Allocated trace memory on node %d at 0x%016llx\n",
>>>> +                 nid, m);
>>>> +
>>>> +            memtrace_array[memtrace_array_nr].start = m;
>>>> +            memtrace_array[memtrace_array_nr].size = size;
>>>> +            memtrace_array[memtrace_array_nr].nid = nid;
>>>> +            memtrace_array_nr++;
>>>> +        }
>>>> +    }
>>>> +    return 0;
>>>> +}
>>> All the pr_info() and pr_err() prints should have a "memtrace :"
>>> before the
>>> actual string to make it clear that its coming from this feature.
>>>
>> Good point!
>>>> +
>>>> +static struct dentry *memtrace_debugfs_dir;
>>>> +
>>>> +static int memtrace_init_debugfs(void)
>>>> +{
>>>> +    int ret = 0;
>>>> +    int i;
>>>> +
>>>> +    for (i = 0; i < memtrace_array_nr; i++) {
>>>> +        struct dentry *dir;
>>>> +        struct memtrace_entry *ent = &memtrace_array[i];
>>>> +
>>>> +        ent->mem = ioremap(ent->start, ent->size);
>>>> +        /* Warn but continue on */
>>>> +        if (!ent->mem) {
>>>> +            pr_err("Failed to map trace memory at 0x%llx\n",
>>>> +                 ent->start);
>>>> +            ret = -1;
>>>> +            continue;
>>>> +        }
>>>> +
>>>> +        snprintf(ent->name, 16, "%08x", ent->nid);
>>>> +        dir = debugfs_create_dir(ent->name, memtrace_debugfs_dir);
>>>> +        if (!dir)
>>>> +            return -1;
>>>> +
>>>> +        ent->dir = dir;
>>>> +        debugfs_create_file("trace", 0400, dir, ent, &memtrace_fops);
>>>> +        debugfs_create_x64("start", 0400, dir, &ent->start);
>>>> +        debugfs_create_x64("size", 0400, dir, &ent->size);
>>>> +        debugfs_create_u32("node", 0400, dir, &ent->nid);
>>>> +    }
>>> Oh okay, its creating all the four files. Please create corresponding
>>> to each of the files some where. Documentation/ABI/testing lists the
>>> actual system ABI on /sys/ not the sys/kernel/debug/ ones I guess.
>> I'm not exactly sure what you are saying here... Seeing that there is
>> documentation about debugfs files in Documentation/ABI/testing, I'll
>> follow suit
>> and put it there.
> I meant the same.
>
>>>> +
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +static u64 memtrace_size;
>>>> +
>>>> +static int memtrace_enable_set(void *data, u64 val)
>>>> +{
>>>> +    if (memtrace_size)
>>>> +        return -EINVAL;
>>>> +
>>>> +    if (!val)
>>>> +        return -EINVAL;
>>>> +
>>>> +    /* Make sure size is aligned to a memory block */
>>>> +    if (val & (memory_block_size_bytes()-1))
>>> As I have mentioned earlier, this should be mentioned in the interface
>>> description some where.
>>>
>>>> +        return -EINVAL;
>>>> +
>>>> +    if (memtrace_init_regions_runtime(val))
>>>> +        return -EINVAL;
>>>> +
>>>> +    if (memtrace_init_debugfs())
>>>> +        return -EINVAL;
>>>> +
>>>> +    memtrace_size = val;
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int memtrace_enable_get(void *data, u64 *val)
>>>> +{
>>>> +    *val = memtrace_size;
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +DEFINE_SIMPLE_ATTRIBUTE(memtrace_init_fops, memtrace_enable_get,
>>>> memtrace_enable_set, "0x%016llx\n");
>>>> +
>>>> +static int memtrace_init(void)
>>>> +{
>>>> +    memtrace_debugfs_dir = debugfs_create_dir("memtrace",
>>>> powerpc_debugfs_root);
>>>> +    if (!memtrace_debugfs_dir)
>>>> +        return -1;
>>>> +
>>>> +    debugfs_create_file("enable", 0600, memtrace_debugfs_dir,
>>>> +                NULL, &memtrace_init_fops);
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +machine_device_initcall(powernv, memtrace_init);
>>>> +
>>>>
>>> BTW how we start the tracing process for the trace to be collected in the
>>> interface before we can read them ? This interface does not seem to have
>>> a handler. When it directs the HW to start collecting the traces ?
>>>
>>> debugfs_create_x64("start", 0400, dir, &ent->start);
>>>
>>>
>> I think you're asking 'what is actually going to call this code and do
>> the tracing'?
> No, when you call this interface, where is the routine to start the
> actual tracing invoking appropriate platform functions or HW
> instructions ? I dont see such a function associated with 'start'
> interface mentioned above.

Essentially,
DEFINE_SIMPLE_ATTRIBUTE(memtrace_init_fops, memtrace_enable_get,
memtrace_enable_set, "0x%016llx\n");

means that when a number is written to the memtrace/enable file, the 
number is
read as a u64 and passed to memtrace_enable_set()

>
>> There is some userspace code in the works to do this. The person who was
>> writing it
>> is doing something else now, and I think it's a bit gross so I'm trying
>> to tidy it
>> up a little.
> Okay, please do provide some pointers when the code is ready which will
> help in better understanding of this interface.
>
Will do!
