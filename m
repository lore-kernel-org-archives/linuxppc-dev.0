Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qZ6Cs0q7pzDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Mar 2016 21:17:45 +1100 (AEDT)
In-Reply-To: <20160328112305.18048.43759.stgit@hbathini.in.ibm.com>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>, Paul Mackerras <paulus@samba.org>
Subject: Re: ppc64/book3s: copy interrupts till __end_handlers marker instead
 of __end_interrupts
Message-Id: <3qZ6Cr6yXRz9s9N@ozlabs.org>
Date: Tue, 29 Mar 2016 21:17:44 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Hari,

You win the "Best Change Log of the Year" award.

Some comments below ...

On Mon, 2016-28-03 at 11:23:22 UTC, Hari Bathini wrote:
> Some of the interrupt vectors on 64-bit POWER server processors  are
> only 32 bytes long (8 instructions), which is not enough for the full
> first-level interrupt handler. For these we need to branch to an out-
> of-line (OOL) handler. But when we are running a relocatable kernel,
> interrupt vectors till __end_interrupts marker are copied down to real
> address 0x100. So, branching to labels (read OOL handlers) outside this
> section should be handled differently (see LOAD_HANDLER()), considering
> relocatable kernel, which would need atleast 4 instructions.
> 
> However, branching from interrupt vector means that we corrupt the CFAR
> (come-from address register) on POWER7 and later processors as mentioned
> in commit 1707dd16. So, EXCEPTION_PROLOG_0
> (6 instructions) that contains the part up to the point where the CFAR is
> saved in the PACA should be part of the short interrupt vectors before we
> branch out to OOL handlers.
> 
> But as mentioned already, there are interrupt vectors on 64-bit POWER server
> processors that are only 32 bytes long (like vectors 0x4f00, 0x4f20, etc.),
> which cannot accomodate the above two cases at the same time owing to space
> constraint. Currently, in these interrupt vectors, we simply branch out to
> OOL handlers, without using LOAD_HANDLER(), which leaves us vulnerable when
> running a relocatable kernel (eg. kdump case). While this has been the case
> for sometime now and kdump is used widely, we were fortunate not to see any
> problems so far, for three reasons:
> 
>     1. In almost all cases, production kernel (relocatable) is used for
>        kdump as well, which would mean that crashed kernel's OOL handler
>        would be at the same place where we endup branching to, from short
>        interrupt vector of kdump kernel.
>     2. Also, OOL handler was unlikely the reason for crash in almost all
>        the kdump scenarios, which meant we had a sane OOL handler from
>        crashed kernel that we branched to.
>     3. On most 64-bit POWER server processors, page size is large enough
>        that marking interrupt vector code as executable (see commit
>        429d2e83) leads to marking OOL handler code from crashed kernel,
>        that sits right below interrupt vector code from kdump kernel, as
>        executable as well.
> 
> Let us fix this undependable code path firstly, by moving down __end_handlers
> marker down past OOL handlers. Secondly, copying interrupt vectors down till
> __end_handlers marker instead of __end_interrupts, when running a relocatable
> kernel, to make sure we endup in relocated (kdump) kernel's OOL handler instead
> of crashed kernel's. Thirdly, by marking all the interrupt vector code that is
> copied down to real address 0x100 as executable, considering the relocation on
> exception feature that allows exceptions to be raised in virtual mode (IR=DR=1).
> 
> This fix has been tested successfully in kdump scenario, on a lpar with 4K page
> size by using different default/production kernel and kdump kernel.

So I think you've missed one important case.

In do_final_fixups() we recopy the (now patched) kernel code down to zero. That
code uses __end_interrupts as its limit, so I think if you look closely your OOL
handlers down at zero will not have had feature fixups applied to them.

I think perhaps the better fix is just to move __end_interrupts down (up) to the
right location. AFAICS all users of __end_interrupts actually want that address.

It would also mean we could remove __end_handlers as unused.

So can you please check that I'm right about do_final_fixups(), and then try
moving __end_interrupts and check that works?

cheers
