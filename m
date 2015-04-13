Return-Path: <xemul@odin.com>
Received: from mx2.parallels.com (mx2.parallels.com [199.115.105.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 338811A0094
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2015 23:42:27 +1000 (AEST)
Message-ID: <552BC619.9080603@parallels.com>
Date: Mon, 13 Apr 2015 16:35:21 +0300
From: Pavel Emelyanov <xemul@parallels.com>
MIME-Version: 1.0
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>, "Kirill A. Shutemov"
 <kirill@shutemov.name>
Subject: Re: [RESEND PATCH v3 1/2] mm: Introducing arch_remap hook
References: <cover.1428916945.git.ldufour@linux.vnet.ibm.com>
 <9d827fc618a718830b2c47aa87e8be546914c897.1428916945.git.ldufour@linux.vnet.ibm.com>
 <20150413115811.GA12354@node.dhcp.inet.fi>
 <552BB972.3010704@linux.vnet.ibm.com>
 <20150413131357.GC12354@node.dhcp.inet.fi>
 <552BC2CA.80309@linux.vnet.ibm.com>
In-Reply-To: <552BC2CA.80309@linux.vnet.ibm.com>
Content-Type: text/plain; charset="windows-1252"
Cc: Rik van Riel <riel@redhat.com>, Hugh Dickins <hughd@google.com>,
 linux-kernel@vger.kernel.org, criu@openvz.org, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>, Mel Gorman <mgorman@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, cov@codeaurora.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/13/2015 04:21 PM, Laurent Dufour wrote:
> On 13/04/2015 15:13, Kirill A. Shutemov wrote:
>> On Mon, Apr 13, 2015 at 02:41:22PM +0200, Laurent Dufour wrote:
>>> On 13/04/2015 13:58, Kirill A. Shutemov wrote:
>>>> On Mon, Apr 13, 2015 at 11:56:27AM +0200, Laurent Dufour wrote:
>>>>> Some architecture would like to be triggered when a memory area is moved
>>>>> through the mremap system call.
>>>>>
>>>>> This patch is introducing a new arch_remap mm hook which is placed in the
>>>>> path of mremap, and is called before the old area is unmapped (and the
>>>>> arch_unmap hook is called).
>>>>>
>>>>> The architectures which need to call this hook should define
>>>>> __HAVE_ARCH_REMAP in their asm/mmu_context.h and provide the arch_remap
>>>>> service with the following prototype:
>>>>> void arch_remap(struct mm_struct *mm,
>>>>>                 unsigned long old_start, unsigned long old_end,
>>>>>                 unsigned long new_start, unsigned long new_end);
>>>>>
>>>>> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
>>>>> Reviewed-by: Ingo Molnar <mingo@kernel.org>
>>>>> ---
>>>>>  mm/mremap.c | 19 +++++++++++++------
>>>>>  1 file changed, 13 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/mm/mremap.c b/mm/mremap.c
>>>>> index 2dc44b1cb1df..009db5565893 100644
>>>>> --- a/mm/mremap.c
>>>>> +++ b/mm/mremap.c
>>>>> @@ -25,6 +25,7 @@
>>>>>  
>>>>>  #include <asm/cacheflush.h>
>>>>>  #include <asm/tlbflush.h>
>>>>> +#include <asm/mmu_context.h>
>>>>>  
>>>>>  #include "internal.h"
>>>>>  
>>>>> @@ -286,13 +287,19 @@ static unsigned long move_vma(struct vm_area_struct *vma,
>>>>>  		old_len = new_len;
>>>>>  		old_addr = new_addr;
>>>>>  		new_addr = -ENOMEM;
>>>>> -	} else if (vma->vm_file && vma->vm_file->f_op->mremap) {
>>>>> -		err = vma->vm_file->f_op->mremap(vma->vm_file, new_vma);
>>>>> -		if (err < 0) {
>>>>> -			move_page_tables(new_vma, new_addr, vma, old_addr,
>>>>> -					 moved_len, true);
>>>>> -			return err;
>>>>> +	} else {
>>>>> +		if (vma->vm_file && vma->vm_file->f_op->mremap) {
>>>>> +			err = vma->vm_file->f_op->mremap(vma->vm_file, new_vma);
>>>>> +			if (err < 0) {
>>>>> +				move_page_tables(new_vma, new_addr, vma,
>>>>> +						  old_addr, moved_len, true);
>>>>> +				return err;
>>>>> +			}
>>>>>  		}
>>>>> +#ifdef __HAVE_ARCH_REMAP
>>>>
>>>> It would be cleaner to provide dummy arch_remap() for !__HAVE_ARCH_REMAP
>>>> in some generic header.
>>>
>>> The idea was to not impact all the architectures as arch_unmap(),
>>> arch_dup_mmap() or arch_exit_mmap() implies.
>>>
>>> I look at the headers where such a dummy arch_remap could be put but I
>>> can't figure out one which will not impact all the architecture.
>>> What about defining a dummy service earlier in mm/remap.c in the case
>>> __HAVE_ARCH_REMAP is not defined ?
>>> Something like :
>>> #ifndef __HAVE_ARCH_REMAP
>>> static inline void void arch_remap(struct mm_struct *mm,
>>>                                    unsigned long old_start,
>>>                                    unsigned long old_end,
>>>                                    unsigned long new_start,
>>>                                    unsigned long new_end)
>>> {
>>> }
>>> #endif
>>
>> Or just #define arch_remap(...) do { } while (0)
>>
> 
> I guessed you wanted the arch_remap() prototype to be exposed somewhere
> in the code.
> 
> To be honest, I can't find the benefit of defining a dummy arch_remap()
> in mm/remap.c if __HAVE_ARCH_REMAP is not defined instead of calling it
> in move_vma if __HAVE_ARCH_REMAP is defined.
> Is it really what you want ?

I think Kirill meant something like e.g. the arch_enter_lazy_mmu_mode()
is implemented and called in mm/mremap.c -- the "generic" part is in the
include/asm-generic/pgtable.h and those architectures willing to have
their own implementation are in arch/$arch/...

Kirill, if I'm right with it, can you suggest the header where to put
the "generic" mremap hook's (empty) body?

-- Pavel
