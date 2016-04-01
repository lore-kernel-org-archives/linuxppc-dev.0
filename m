Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qcBbj3K5mzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Apr 2016 06:42:09 +1100 (AEDT)
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qcBbj27D1z9sdg
 for <linuxppc-dev@ozlabs.org>; Sat,  2 Apr 2016 06:42:09 +1100 (AEDT)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Sat, 2 Apr 2016 05:42:08 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 310733578052
 for <linuxppc-dev@ozlabs.org>; Sat,  2 Apr 2016 06:41:56 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u31JfmKT3146010
 for <linuxppc-dev@ozlabs.org>; Sat, 2 Apr 2016 06:41:56 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u31JfNT4021049
 for <linuxppc-dev@ozlabs.org>; Sat, 2 Apr 2016 06:41:23 +1100
Subject: Re: [PATCH v3] ppc64/book3s: fix branching to out of line handlers in
 relocation kernel
To: Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
References: <20160330181853.392.95184.stgit@hbathini.in.ibm.com>
 <1459491275.10334.6.camel@ellerman.id.au>
 <56FE1AD2.5020304@linux.vnet.ibm.com>
 <1459507074.10340.3.camel@ellerman.id.au>
Cc: Michael Neuling <mikey@neuling.org>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Message-ID: <56FECED0.6070707@linux.vnet.ibm.com>
Date: Sat, 2 Apr 2016 01:11:04 +0530
MIME-Version: 1.0
In-Reply-To: <1459507074.10340.3.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 04/01/2016 04:07 PM, Michael Ellerman wrote:
> On Fri, 2016-04-01 at 12:23 +0530, Hari Bathini wrote:
>> On 04/01/2016 11:44 AM, Michael Ellerman wrote:
>>> On Wed, 2016-03-30 at 23:49 +0530, Hari Bathini wrote:
>>>> Some of the interrupt vectors on 64-bit POWER server processors  are
>>>> only 32 bytes long (8 instructions), which is not enough for the full
>>> ...
>>>> Let us fix this undependable code path by moving these OOL handlers below
>>>> __end_interrupts marker to make sure we also copy these handlers to real
>>>> address 0x100 when running a relocatable kernel. Because the interrupt
>>>> vectors branching to these OOL handlers are not long enough to use
>>>> LOAD_HANDLER() for branching as discussed above.
>>>>
>>> ...
>>>> changes from v2:
>>>> 2. Move the OOL handlers before __end_interrupts marker instead of moving the __end_interrupts marker
>>>> 3. Leave __end_handlers marker as is.
>>> Hi Hari,
>>>
>>> Thanks for trying this. In the end I've decided it's not a good option.
>>>
>>> If you build an allmodconfig, and turn on CONFIG_RELOCATABLE, and then look at
>>> the disassembly, you see this:
>>>
>>>     c000000000006ffc:       48 00 29 04     b       c000000000009900 <.ret_from_except>
>>>     
>>>     c000000000007000 <__end_handlers>:
>>>
>>> At 0x7000 we have the FWNMI area, which is fixed and can't move. As you see
>>> above we end up with only 4 bytes of space between the end of the handlers and
>>> the FWNMI area.
>>>
>>> So any tiny change that adds two more instructions prior to 0x7000 will then
>>> fail to build.
>> Hi Michael,
>>
>> I agree. But the OOL handlers that are moved up in v3 were below
>> 0x7000 earlier as well and moving them below __end_interrupts marker
>> shouldn't make any difference in terms of space consumption at least in
>> comparison between v2 & v3. So, I guess picking either v2 or v3
>> doesn't change this for better.
> It does make a difference, due to alignment. Prior to your patch we have ~24
> bytes free.

Hi Michael,

Hmmm.. I thought ~24 bytes was not such a difference but with the scenario
you mentioned it does sound critical. Actually, this patch came into being
for want of another 8~12 bytes. So, I should have known better about
space constraint.

>
>> Also, there is code between __end_interrupts and __end_handlers
>> that is not location dependent as long as it is within 64K (0x10000)
>> that can be moved above 0x8000, if need be.
> That's true, but that sort of change is unlikely to backport well. And we need
> to backport this fix to everything.

That does sound like a maintainer's nightmare.

> But if you can get that to work I'll consider it. I tried quickly but couldn't
> get it working, due to problems with the feature else sections being too far
> away from.

Same case. May need sometime to get that right.
Also, exploring holes between __start_interrupts & __end_interrupts.
Will try and get back on this soon.
If none of this works, we have v2 anyway.

Thanks
Hari
