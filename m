Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qZJrr5dGgzDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Mar 2016 05:17:00 +1100 (AEDT)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qZJrr0tRYz9s0M
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Mar 2016 05:17:00 +1100 (AEDT)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Wed, 30 Mar 2016 04:16:59 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 5B2F53578053
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Mar 2016 05:16:55 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2TIGkWc57671876
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Mar 2016 05:16:55 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2TIGLKn032564
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Mar 2016 05:16:22 +1100
Subject: Re: ppc64/book3s: copy interrupts till __end_handlers marker instead
 of __end_interrupts
To: Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
References: <3qZ6Cr6yXRz9s9N@ozlabs.org>
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>, Paul Mackerras <paulus@samba.org>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Message-ID: <56FAC663.3030803@linux.vnet.ibm.com>
Date: Tue, 29 Mar 2016 23:46:03 +0530
MIME-Version: 1.0
In-Reply-To: <3qZ6Cr6yXRz9s9N@ozlabs.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 03/29/2016 03:47 PM, Michael Ellerman wrote:
> Hi Hari,
>
> You win the "Best Change Log of the Year" award.
>
> Some comments below ...
>
> On Mon, 2016-28-03 at 11:23:22 UTC, Hari Bathini wrote:
>> Some of the interrupt vectors on 64-bit POWER server processors  are
>> only 32 bytes long (8 instructions), which is not enough for the full
>> first-level interrupt handler. For these we need to branch to an out-
>> of-line (OOL) handler. But when we are running a relocatable kernel,
>> interrupt vectors till __end_interrupts marker are copied down to real
>> address 0x100. So, branching to labels (read OOL handlers) outside this
>> section should be handled differently (see LOAD_HANDLER()), considering
>> relocatable kernel, which would need atleast 4 instructions.
>>
>> However, branching from interrupt vector means that we corrupt the CFAR
>> (come-from address register) on POWER7 and later processors as mentioned
>> in commit 1707dd16. So, EXCEPTION_PROLOG_0
>> (6 instructions) that contains the part up to the point where the CFAR is
>> saved in the PACA should be part of the short interrupt vectors before we
>> branch out to OOL handlers.
>>
>> But as mentioned already, there are interrupt vectors on 64-bit POWER server
>> processors that are only 32 bytes long (like vectors 0x4f00, 0x4f20, etc.),
>> which cannot accomodate the above two cases at the same time owing to space
>> constraint. Currently, in these interrupt vectors, we simply branch out to
>> OOL handlers, without using LOAD_HANDLER(), which leaves us vulnerable when
>> running a relocatable kernel (eg. kdump case). While this has been the case
>> for sometime now and kdump is used widely, we were fortunate not to see any
>> problems so far, for three reasons:
>>
>>      1. In almost all cases, production kernel (relocatable) is used for
>>         kdump as well, which would mean that crashed kernel's OOL handler
>>         would be at the same place where we endup branching to, from short
>>         interrupt vector of kdump kernel.
>>      2. Also, OOL handler was unlikely the reason for crash in almost all
>>         the kdump scenarios, which meant we had a sane OOL handler from
>>         crashed kernel that we branched to.
>>      3. On most 64-bit POWER server processors, page size is large enough
>>         that marking interrupt vector code as executable (see commit
>>         429d2e83) leads to marking OOL handler code from crashed kernel,
>>         that sits right below interrupt vector code from kdump kernel, as
>>         executable as well.
>>
>> Let us fix this undependable code path firstly, by moving down __end_handlers
>> marker down past OOL handlers. Secondly, copying interrupt vectors down till
>> __end_handlers marker instead of __end_interrupts, when running a relocatable
>> kernel, to make sure we endup in relocated (kdump) kernel's OOL handler instead
>> of crashed kernel's. Thirdly, by marking all the interrupt vector code that is
>> copied down to real address 0x100 as executable, considering the relocation on
>> exception feature that allows exceptions to be raised in virtual mode (IR=DR=1).
>>
>> This fix has been tested successfully in kdump scenario, on a lpar with 4K page
>> size by using different default/production kernel and kdump kernel.
> So I think you've missed one important case.

My bad! I missed out on considering this case..

> In do_final_fixups() we recopy the (now patched) kernel code down to zero. That
> code uses __end_interrupts as its limit, so I think if you look closely your OOL
> handlers down at zero will not have had feature fixups applied to them.
>
> I think perhaps the better fix is just to move __end_interrupts down (up) to the
> right location. AFAICS all users of __end_interrupts actually want that address.
>
> It would also mean we could remove __end_handlers as unused.

True. This sounds less complicated.

> So can you please check that I'm right about do_final_fixups(), and then try
> moving __end_interrupts and check that works?

Yeah. Testing the patch. Will post it soon.
Thanks for the review!

- Hari
