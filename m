Return-Path: <sjenning@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e35.co.us.ibm.com", Issuer "Equifax" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 16089B6EEA
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Mar 2012 08:19:12 +1100 (EST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sjenning@linux.vnet.ibm.com>;
 Wed, 7 Mar 2012 14:19:10 -0700
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id A782419D804A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2012 14:19:01 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q27LJ18E139914
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Mar 2012 14:19:01 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q27LJ0XI025978
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Mar 2012 14:19:01 -0700
Message-ID: <4F57D0C0.7040108@linux.vnet.ibm.com>
Date: Wed, 07 Mar 2012 15:18:56 -0600
From: Seth Jennings <sjenning@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: tlb flushing on Power
References: <4F2160B3.60708@linux.vnet.ibm.com>
 <4F216620.2010509@linux.vnet.ibm.com> <1327613953.24487.9.camel@pasglop>
 <4F32B354.7030306@linux.vnet.ibm.com> <1328735054.2903.29.camel@pasglop>
 <4F356C7E.3070608@linux.vnet.ibm.com> <4F3D38D3.4020903@linux.vnet.ibm.com>
 <1329424301.2892.23.camel@pasglop> <4F54FE51.8070709@linux.vnet.ibm.com>
 <6006.1331098094@neuling.org>
In-Reply-To: <6006.1331098094@neuling.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Robert Jennings <rcj@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Nitin Gupta <ngupta@vflare.org>, Dave Hansen <dave@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/06/2012 11:28 PM, Michael Neuling wrote:
> Seth,
> 
>> Thanks for the help!  I was wondering if you could take a look at something
>> for me.
>>
>> I've been working on this staging driver (zsmalloc memory allocator)
>> that does virtual mapping of two pages.
>>
>> I have a github repo with the driver and the unsubmitted changes.  I'm
>> trying to make to get the pte/tlb stuff working in a portable way:
>>
>> git://github.com/spartacus06/linux.git (portable branch)
>>
>> The experimental commits are the top 5 and the branch is based on
>> Greg's staging-next + frontswap-v11 patches.
>>
>> Could you take a look at the zs_map_object() and zs_unmap_object()
>> in drivers/staging/zsmalloc/zsmalloc-main.c and see if they should
>> work for PPC64?
> 
> I suggest you post the code directly to the list in reviewable chucks.
> People are much more likely to review it if they don't have to download
> some random git tree, checkout some branch, find the changes, etc etc.

It's hard to summarize out of context, but I'll try.

So zsmalloc is designed to store compressed memory pages.  In order
to do that efficiently in memory restricted environments where
memory allocations from the buddy allocator greater than order 0 are
very likely to fail, we have to be able to store compressed memory pages
across non-contiguous page boundaries.

zsmalloc uses virtual memory mapping to do this.  There is a per-cpu
struct vm_struct *vm.  This vm is initialized like this:
===
pte_t *vm_ptes[2];
vm = alloc_vm_area(2 * PAGE_SIZE, vm_ptes);
===

When the allocation needs to be accessed, we map the memory like this
(with preemption disabled):

set_pte_at(&init_mm, 0, vm_ptes[0], mk_pte(page1, PAGE_KERNEL));
set_pte_at(&init_mm, 0, vm_ptes[1], mk_pte(page2, PAGE_KERNEL));

Preemption remains disabled while the user manipulates the allocation.

When the user is done, we unmap by doing:
====
ptep_get_and_clear(&init_mm, vm->addr, vm_ptes[0]);
ptep_get_and_clear(&init_mm, vm->addr + PAGE_SIZE, vm_ptes[1]);

local_flush_tlb_kernel_page(vm->addr);
local_flush_tlb_kernel_page(vm->addr + PAGE_SIZE);
====

In my patch, I've defined local_flush_tlb_kernel_page as:

#define local_flush_tlb_kernel_page(kaddr) local_flush_tlb_page(NULL, kaddr)

in arch/powerpc/include/asm/tlbflush.h

For PPC64 (the platform I'm testing on) local_flush_tlb_page() is a no-op
because of the hashing tlb in that architecture; however, it isn't a no-op
on other archs and the whole point of this change is portability.

My understanding is that the tlb flush on PPC64 happens as a result of
the pte_update() eventually called from ptep_get_and_clear().

The problem is that this doesn't always seem to work.  I get corruption
in the mapped memory from time to time.  

I've isolated the issue to this mapping code.

Does anyone see anything glaringly wrong with this approach?

Should ptep_get_and_clear() also flush the tlb entry (asynchronously I think)?

For comparison, this code is stable on x86 where local_flush_tlb_kernel_page()
is defined to __flush_tlb_one().

> If it's work in progress, mark it as an RFC patch and note what issues
> you think still exist.  
> 
> Mikey
