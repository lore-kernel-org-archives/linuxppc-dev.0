Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qbtDr44lfzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Apr 2016 18:24:44 +1100 (AEDT)
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qbtDr2zKZz9sC3
 for <linuxppc-dev@ozlabs.org>; Fri,  1 Apr 2016 18:24:44 +1100 (AEDT)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Fri, 1 Apr 2016 16:54:25 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 7B7503578052
 for <linuxppc-dev@ozlabs.org>; Fri,  1 Apr 2016 17:54:21 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u316sCqE63635498
 for <linuxppc-dev@ozlabs.org>; Fri, 1 Apr 2016 17:54:21 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u316rXY1025271
 for <linuxppc-dev@ozlabs.org>; Fri, 1 Apr 2016 17:53:34 +1100
Subject: Re: [PATCH v3] ppc64/book3s: fix branching to out of line handlers in
 relocation kernel
To: Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
References: <20160330181853.392.95184.stgit@hbathini.in.ibm.com>
 <1459491275.10334.6.camel@ellerman.id.au>
Cc: Michael Neuling <mikey@neuling.org>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Message-ID: <56FE1AD2.5020304@linux.vnet.ibm.com>
Date: Fri, 1 Apr 2016 12:23:06 +0530
MIME-Version: 1.0
In-Reply-To: <1459491275.10334.6.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 04/01/2016 11:44 AM, Michael Ellerman wrote:
> On Wed, 2016-03-30 at 23:49 +0530, Hari Bathini wrote:
>> Some of the interrupt vectors on 64-bit POWER server processors  are
>> only 32 bytes long (8 instructions), which is not enough for the full
> ...
>> Let us fix this undependable code path by moving these OOL handlers below
>> __end_interrupts marker to make sure we also copy these handlers to real
>> address 0x100 when running a relocatable kernel. Because the interrupt
>> vectors branching to these OOL handlers are not long enough to use
>> LOAD_HANDLER() for branching as discussed above.
>>
> ...
>> changes from v2:
>> 2. Move the OOL handlers before __end_interrupts marker instead of moving the __end_interrupts marker
>> 3. Leave __end_handlers marker as is.
> Hi Hari,
>
> Thanks for trying this. In the end I've decided it's not a good option.
>
> If you build an allmodconfig, and turn on CONFIG_RELOCATABLE, and then look at
> the disassembly, you see this:
>
>    c000000000006ffc:       48 00 29 04     b       c000000000009900 <.ret_from_except>
>    
>    c000000000007000 <__end_handlers>:
>
> At 0x7000 we have the FWNMI area, which is fixed and can't move. As you see
> above we end up with only 4 bytes of space between the end of the handlers and
> the FWNMI area.
>
> So any tiny change that adds two more instructions prior to 0x7000 will then
> fail to build.

Hi Michael,

I agree. But the OOL handlers that are moved up in v3 were below
0x7000 earlier as well and moving them below __end_interrupts marker
shouldn't make any difference in terms of space consumption at least in
comparison between v2 & v3. So, I guess picking either v2 or v3
doesn't change this for better.

Also, there is code between __end_interrupts and __end_handlers
that is not location dependent as long as it is within 64K (0x10000)
that can be moved above 0x8000, if need be.

For these reasons, I feel v3 is better going forward as it keeps
__start_interrupts to __end_interrupts code compact and
leaves alone the code that doesn't need to be copied to real 0.

Am I missing something here?

Thanks
Hari

> None of that's your fault, it's just the nature of the code in there, it's very
> space constrained.
>
> For now I'll take your v2, but I'll edit the comment and drop the removal of
> __end_handlers.
>
> cheers
>
