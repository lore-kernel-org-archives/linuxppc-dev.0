Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xhWxT381lzDqkY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 00:59:09 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7TEx47o112507
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 10:59:06 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2cn6sc6bpb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 10:59:05 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Tue, 29 Aug 2017 15:58:32 +0100
Subject: Re: [PATCH v2 19/20] x86/mm: Add speculative pagefault handling
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 paulmck@linux.vnet.ibm.com, peterz@infradead.org,
 akpm@linux-foundation.org, kirill@shutemov.name, ak@linux.intel.com,
 mhocko@kernel.org, dave@stgolabs.net, jack@suse.cz,
 Matthew Wilcox <willy@infradead.org>, benh@kernel.crashing.org,
 mpe@ellerman.id.au, paulus@samba.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 hpa@zytor.com, Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, haren@linux.vnet.ibm.com,
 npiggin@gmail.com, bsingharora@gmail.com,
 Tim Chen <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org
References: <1503007519-26777-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1503007519-26777-20-git-send-email-ldufour@linux.vnet.ibm.com>
 <dbaaf637-9f22-eba0-63a5-7bd83f810e4f@linux.vnet.ibm.com>
 <37b9b036-e951-0a74-3e5c-31049cda7dd2@linux.vnet.ibm.com>
Date: Tue, 29 Aug 2017 16:58:23 +0200
MIME-Version: 1.0
In-Reply-To: <37b9b036-e951-0a74-3e5c-31049cda7dd2@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <6233b5fc-92d8-1977-82f9-e266ac1f6dec@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 29/08/2017 16:50, Laurent Dufour wrote:
> On 21/08/2017 09:29, Anshuman Khandual wrote:
>> On 08/18/2017 03:35 AM, Laurent Dufour wrote:
>>> From: Peter Zijlstra <peterz@infradead.org>
>>>
>>> Try a speculative fault before acquiring mmap_sem, if it returns with
>>> VM_FAULT_RETRY continue with the mmap_sem acquisition and do the
>>> traditional fault.
>>>
>>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>>
>>> [Clearing of FAULT_FLAG_ALLOW_RETRY is now done in
>>>  handle_speculative_fault()]
>>> [Retry with usual fault path in the case VM_ERROR is returned by
>>>  handle_speculative_fault(). This allows signal to be delivered]
>>> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
>>> ---
>>>  arch/x86/include/asm/pgtable_types.h |  7 +++++++
>>>  arch/x86/mm/fault.c                  | 19 +++++++++++++++++++
>>>  2 files changed, 26 insertions(+)
>>>
>>> diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
>>> index bf9638e1ee42..4fd2693a037e 100644
>>> --- a/arch/x86/include/asm/pgtable_types.h
>>> +++ b/arch/x86/include/asm/pgtable_types.h
>>> @@ -234,6 +234,13 @@ enum page_cache_mode {
>>>  #define PGD_IDENT_ATTR	 0x001		/* PRESENT (no other attributes) */
>>>  #endif
>>>  
>>> +/*
>>> + * Advertise that we call the Speculative Page Fault handler.
>>> + */
>>> +#ifdef CONFIG_X86_64
>>> +#define __HAVE_ARCH_CALL_SPF
>>> +#endif
>>> +
>>>  #ifdef CONFIG_X86_32
>>>  # include <asm/pgtable_32_types.h>
>>>  #else
>>> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
>>> index 2a1fa10c6a98..4c070b9a4362 100644
>>> --- a/arch/x86/mm/fault.c
>>> +++ b/arch/x86/mm/fault.c
>>> @@ -1365,6 +1365,24 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
>>>  	if (error_code & PF_INSTR)
>>>  		flags |= FAULT_FLAG_INSTRUCTION;
>>>  
>>> +#ifdef __HAVE_ARCH_CALL_SPF
>>> +	if (error_code & PF_USER) {
>>> +		fault = handle_speculative_fault(mm, address, flags);
>>> +
>>> +		/*
>>> +		 * We also check against VM_FAULT_ERROR because we have to
>>> +		 * raise a signal by calling later mm_fault_error() which
>>> +		 * requires the vma pointer to be set. So in that case,
>>> +		 * we fall through the normal path.
>>
>> Cant mm_fault_error() be called inside handle_speculative_fault() ?
>> Falling through the normal page fault path again just to raise a
>> signal seems overkill. Looking into mm_fault_error(), it seems they
>> are different for x86 and powerpc.
>>
>> X86:
>>
>> mm_fault_error(struct pt_regs *regs, unsigned long error_code,
>>                unsigned long address, struct vm_area_struct *vma,
>>                unsigned int fault)
>>
>> powerpc:
>>
>> mm_fault_error(struct pt_regs *regs, unsigned long addr, int fault)
>>
>> Even in case of X86, I guess we would have reference to the faulting
>> VMA (after the SRCU search) which can be used to call this function
>> directly.
> 
> Yes I think this is doable in the case of x86.

Indeed this is not doable as the vma pointer is not returned by
handle_speculative_fault() and this is not possible to return it because
once srcu_read_unlock() is called, the pointer is no more safe.
