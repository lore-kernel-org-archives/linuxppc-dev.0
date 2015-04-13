Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0830C1A01C9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2015 23:21:25 +1000 (AEST)
Received: from /spool/local
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Mon, 13 Apr 2015 14:21:21 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6DD672190046
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2015 14:21:04 +0100 (BST)
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
 [9.149.37.248])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3DDLI4K65732708
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2015 13:21:18 GMT
Received: from d06av07.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3DDLHbk018143
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2015 09:21:18 -0400
Message-ID: <552BC2CA.80309@linux.vnet.ibm.com>
Date: Mon, 13 Apr 2015 15:21:14 +0200
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [RESEND PATCH v3 1/2] mm: Introducing arch_remap hook
References: <cover.1428916945.git.ldufour@linux.vnet.ibm.com>
 <9d827fc618a718830b2c47aa87e8be546914c897.1428916945.git.ldufour@linux.vnet.ibm.com>
 <20150413115811.GA12354@node.dhcp.inet.fi>
 <552BB972.3010704@linux.vnet.ibm.com>
 <20150413131357.GC12354@node.dhcp.inet.fi>
In-Reply-To: <20150413131357.GC12354@node.dhcp.inet.fi>
Content-Type: text/plain; charset=windows-1252
Cc: Rik van Riel <riel@redhat.com>, Pavel Emelyanov <xemul@parallels.com>,
 Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org, criu@openvz.org,
 linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>,
 Mel Gorman <mgorman@suse.de>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, cov@codeaurora.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 13/04/2015 15:13, Kirill A. Shutemov wrote:
> On Mon, Apr 13, 2015 at 02:41:22PM +0200, Laurent Dufour wrote:
>> On 13/04/2015 13:58, Kirill A. Shutemov wrote:
>>> On Mon, Apr 13, 2015 at 11:56:27AM +0200, Laurent Dufour wrote:
>>>> Some architecture would like to be triggered when a memory area is moved
>>>> through the mremap system call.
>>>>
>>>> This patch is introducing a new arch_remap mm hook which is placed in the
>>>> path of mremap, and is called before the old area is unmapped (and the
>>>> arch_unmap hook is called).
>>>>
>>>> The architectures which need to call this hook should define
>>>> __HAVE_ARCH_REMAP in their asm/mmu_context.h and provide the arch_remap
>>>> service with the following prototype:
>>>> void arch_remap(struct mm_struct *mm,
>>>>                 unsigned long old_start, unsigned long old_end,
>>>>                 unsigned long new_start, unsigned long new_end);
>>>>
>>>> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
>>>> Reviewed-by: Ingo Molnar <mingo@kernel.org>
>>>> ---
>>>>  mm/mremap.c | 19 +++++++++++++------
>>>>  1 file changed, 13 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/mm/mremap.c b/mm/mremap.c
>>>> index 2dc44b1cb1df..009db5565893 100644
>>>> --- a/mm/mremap.c
>>>> +++ b/mm/mremap.c
>>>> @@ -25,6 +25,7 @@
>>>>  
>>>>  #include <asm/cacheflush.h>
>>>>  #include <asm/tlbflush.h>
>>>> +#include <asm/mmu_context.h>
>>>>  
>>>>  #include "internal.h"
>>>>  
>>>> @@ -286,13 +287,19 @@ static unsigned long move_vma(struct vm_area_struct *vma,
>>>>  		old_len = new_len;
>>>>  		old_addr = new_addr;
>>>>  		new_addr = -ENOMEM;
>>>> -	} else if (vma->vm_file && vma->vm_file->f_op->mremap) {
>>>> -		err = vma->vm_file->f_op->mremap(vma->vm_file, new_vma);
>>>> -		if (err < 0) {
>>>> -			move_page_tables(new_vma, new_addr, vma, old_addr,
>>>> -					 moved_len, true);
>>>> -			return err;
>>>> +	} else {
>>>> +		if (vma->vm_file && vma->vm_file->f_op->mremap) {
>>>> +			err = vma->vm_file->f_op->mremap(vma->vm_file, new_vma);
>>>> +			if (err < 0) {
>>>> +				move_page_tables(new_vma, new_addr, vma,
>>>> +						  old_addr, moved_len, true);
>>>> +				return err;
>>>> +			}
>>>>  		}
>>>> +#ifdef __HAVE_ARCH_REMAP
>>>
>>> It would be cleaner to provide dummy arch_remap() for !__HAVE_ARCH_REMAP
>>> in some generic header.
>>
>> The idea was to not impact all the architectures as arch_unmap(),
>> arch_dup_mmap() or arch_exit_mmap() implies.
>>
>> I look at the headers where such a dummy arch_remap could be put but I
>> can't figure out one which will not impact all the architecture.
>> What about defining a dummy service earlier in mm/remap.c in the case
>> __HAVE_ARCH_REMAP is not defined ?
>> Something like :
>> #ifndef __HAVE_ARCH_REMAP
>> static inline void void arch_remap(struct mm_struct *mm,
>>                                    unsigned long old_start,
>>                                    unsigned long old_end,
>>                                    unsigned long new_start,
>>                                    unsigned long new_end)
>> {
>> }
>> #endif
> 
> Or just #define arch_remap(...) do { } while (0)
> 

I guessed you wanted the arch_remap() prototype to be exposed somewhere
in the code.

To be honest, I can't find the benefit of defining a dummy arch_remap()
in mm/remap.c if __HAVE_ARCH_REMAP is not defined instead of calling it
in move_vma if __HAVE_ARCH_REMAP is defined.
Is it really what you want ?

Thanks,
Laurent.
