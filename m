Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zggCt4cTFzF0ng
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 22:24:08 +1100 (AEDT)
Subject: Re: [RFC PATCH 0/5] powerpc/mm/slice: improve slice speed and stack
 use
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
References: <20180210081139.27236-1-npiggin@gmail.com>
 <e2043d70-97a7-b914-f279-4aad76b9bf91@c-s.fr>
 <20180213012442.45b6f49b@roar.ozlabs.ibm.com>
 <7364b502-83a7-8b40-3530-b160e3c80523@c-s.fr>
 <20180213184017.168c31f0@roar.ozlabs.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <e939dfed-f992-36e0-c92b-f05fb539b383@c-s.fr>
Date: Tue, 13 Feb 2018 12:24:02 +0100
MIME-Version: 1.0
In-Reply-To: <20180213184017.168c31f0@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 13/02/2018 à 09:40, Nicholas Piggin a écrit :
> On Mon, 12 Feb 2018 18:42:21 +0100
> Christophe LEROY <christophe.leroy@c-s.fr> wrote:
> 
>> Le 12/02/2018 à 16:24, Nicholas Piggin a écrit :
>>> On Mon, 12 Feb 2018 16:02:23 +0100
>>> Christophe LEROY <christophe.leroy@c-s.fr> wrote:
>>>    
>>>> Le 10/02/2018 à 09:11, Nicholas Piggin a écrit :
>>>>> This series intends to improve performance and reduce stack
>>>>> consumption in the slice allocation code. It does it by keeping slice
>>>>> masks in the mm_context rather than compute them for each allocation,
>>>>> and by reducing bitmaps and slice_masks from stacks, using pointers
>>>>> instead where possible.
>>>>>
>>>>> checkstack.pl gives, before:
>>>>> 0x00000de4 slice_get_unmapped_area [slice.o]:           656
>>>>> 0x00001b4c is_hugepage_only_range [slice.o]:            512
>>>>> 0x0000075c slice_find_area_topdown [slice.o]:           416
>>>>> 0x000004c8 slice_find_area_bottomup.isra.1 [slice.o]:   272
>>>>> 0x00001aa0 slice_set_range_psize [slice.o]:             240
>>>>> 0x00000a64 slice_find_area [slice.o]:                   176
>>>>> 0x00000174 slice_check_fit [slice.o]:                   112
>>>>>
>>>>> after:
>>>>> 0x00000d70 slice_get_unmapped_area [slice.o]:           320
>>>>> 0x000008f8 slice_find_area [slice.o]:                   144
>>>>> 0x00001860 slice_set_range_psize [slice.o]:             144
>>>>> 0x000018ec is_hugepage_only_range [slice.o]:            144
>>>>> 0x00000750 slice_find_area_bottomup.isra.4 [slice.o]:   128
>>>>>
>>>>> The benchmark in https://github.com/linuxppc/linux/issues/49 gives, before:
>>>>> $ time ./slicemask
>>>>> real	0m20.712s
>>>>> user	0m5.830s
>>>>> sys	0m15.105s
>>>>>
>>>>> after:
>>>>> $ time ./slicemask
>>>>> real	0m13.197s
>>>>> user	0m5.409s
>>>>> sys	0m7.779s
>>>>
>>>> Hi,
>>>>
>>>> I tested your serie on an 8xx, on top of patch
>>>> https://patchwork.ozlabs.org/patch/871675/
>>>>
>>>> I don't get a result as significant as yours, but there is some
>>>> improvment anyway:
>>>>
>>>> ITERATION 500000
>>>>
>>>> Before:
>>>>
>>>> root@vgoip:~# time ./slicemask
>>>> real    0m 33.26s
>>>> user    0m 1.94s
>>>> sys     0m 30.85s
>>>>
>>>> After:
>>>> root@vgoip:~# time ./slicemask
>>>> real    0m 29.69s
>>>> user    0m 2.11s
>>>> sys     0m 27.15s
>>>>
>>>> Most significant improvment is obtained with the first patch of your serie:
>>>> root@vgoip:~# time ./slicemask
>>>> real    0m 30.85s
>>>> user    0m 1.80s
>>>> sys     0m 28.57s
>>>
>>> Okay, thanks. Are you still spending significant time in the slice
>>> code?
>>
>> Do you mean am I still updating my patches ? No I hope we are at last
> 
> Actually I was wondering about CPU time spent for the microbenchmark :)

Lol.

I've got the following perf report (functions over 0.50%)

# Overhead  Command    Shared Object      Symbol
# ........  .........  .................  ..................................
#
      7.13%  slicemask  [kernel.kallsyms]  [k] do_brk_flags
      6.19%  slicemask  [kernel.kallsyms]  [k] DoSyscall
      5.81%  slicemask  [kernel.kallsyms]  [k] perf_event_mmap
      5.55%  slicemask  [kernel.kallsyms]  [k] do_munmap
      4.55%  slicemask  [kernel.kallsyms]  [k] sys_brk
      4.43%  slicemask  [kernel.kallsyms]  [k] find_vma
      3.42%  slicemask  [kernel.kallsyms]  [k] vma_compute_subtree_gap
      3.08%  slicemask  libc-2.23.so       [.] __brk
      2.95%  slicemask  [kernel.kallsyms]  [k] slice_get_unmapped_area
      2.81%  slicemask  [kernel.kallsyms]  [k] __vm_enough_memory
      2.78%  slicemask  [kernel.kallsyms]  [k] kmem_cache_free
      2.51%  slicemask  [kernel.kallsyms]  [k] perf_iterate_ctx.constprop.84
      2.40%  slicemask  [kernel.kallsyms]  [k] unmap_page_range
      2.27%  slicemask  [kernel.kallsyms]  [k] perf_iterate_sb
      2.21%  slicemask  [kernel.kallsyms]  [k] vmacache_find
      2.04%  slicemask  [kernel.kallsyms]  [k] vma_gap_update
      1.91%  slicemask  [kernel.kallsyms]  [k] unmap_region
      1.81%  slicemask  [kernel.kallsyms]  [k] memset_nocache_branch
      1.59%  slicemask  [kernel.kallsyms]  [k] kmem_cache_alloc
      1.57%  slicemask  [kernel.kallsyms]  [k] get_unmapped_area.part.7
      1.55%  slicemask  [kernel.kallsyms]  [k] up_write
      1.44%  slicemask  [kernel.kallsyms]  [k] vma_merge
      1.28%  slicemask  slicemask          [.] main
      1.27%  slicemask  [kernel.kallsyms]  [k] lru_add_drain
      1.22%  slicemask  [kernel.kallsyms]  [k] vma_link
      1.19%  slicemask  [kernel.kallsyms]  [k] tlb_gather_mmu
      1.17%  slicemask  [kernel.kallsyms]  [k] tlb_flush_mmu_free
      1.15%  slicemask  libc-2.23.so       [.] got_label
      1.11%  slicemask  [kernel.kallsyms]  [k] unlink_anon_vmas
      1.06%  slicemask  [kernel.kallsyms]  [k] lru_add_drain_cpu
      1.02%  slicemask  [kernel.kallsyms]  [k] free_pgtables
      1.01%  slicemask  [kernel.kallsyms]  [k] remove_vma
      0.98%  slicemask  [kernel.kallsyms]  [k] strlcpy
      0.98%  slicemask  [kernel.kallsyms]  [k] perf_event_mmap_output
      0.95%  slicemask  [kernel.kallsyms]  [k] may_expand_vm
      0.90%  slicemask  [kernel.kallsyms]  [k] unmap_vmas
      0.86%  slicemask  [kernel.kallsyms]  [k] down_write_killable
      0.83%  slicemask  [kernel.kallsyms]  [k] __vma_link_list
      0.83%  slicemask  [kernel.kallsyms]  [k] arch_vma_name
      0.81%  slicemask  [kernel.kallsyms]  [k] __vma_rb_erase
      0.80%  slicemask  [kernel.kallsyms]  [k] __rcu_read_unlock
      0.71%  slicemask  [kernel.kallsyms]  [k] tlb_flush_mmu
      0.70%  slicemask  [kernel.kallsyms]  [k] tlb_finish_mmu
      0.68%  slicemask  [kernel.kallsyms]  [k] __rb_insert_augmented
      0.63%  slicemask  [kernel.kallsyms]  [k] cap_capable
      0.61%  slicemask  [kernel.kallsyms]  [k] free_pgd_range
      0.59%  slicemask  [kernel.kallsyms]  [k] arch_tlb_finish_mmu
      0.59%  slicemask  [kernel.kallsyms]  [k] __vma_link_rb
      0.56%  slicemask  [kernel.kallsyms]  [k] __rcu_read_lock
      0.55%  slicemask  [kernel.kallsyms]  [k] 
arch_get_unmapped_area_topdown
      0.53%  slicemask  [kernel.kallsyms]  [k] unlink_file_vma
      0.51%  slicemask  [kernel.kallsyms]  [k] vmacache_update
      0.50%  slicemask  [kernel.kallsyms]  [k] kfree

Unfortunatly I didn't run a perf report before applying the patch serie. 
If you are interested for the comparison, I won't be able to do it 
before next week.

> 
>> run with v4 now that Aneesh has tagged all of them as reviewed-by himself.
>> Once the serie has been accepted, my next step will be to backport at
>> least the 3 first ones in kernel 4.14
>>
>>>    
>>>>
>>>> Had to modify your serie a bit, if you are interested I can post it.
>>>>   
>>>
>>> Sure, that would be good.
>>
>> Ok, lets share it. The patch are not 100% clean.
> 
> Those look pretty good, thanks for doing that work.

You are welcome. I wanted to try your serie on the 8xx. It is untested 
on the book3s64, not sure it even compiles.

Christophe

> 
> Thanks,
> Nick
> 
