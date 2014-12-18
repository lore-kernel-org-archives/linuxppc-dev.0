Return-Path: <rusty@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6C4C81A0A07
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Dec 2014 15:23:27 +1100 (AEDT)
From: Rusty Russell <rusty@rustcorp.com.au>
To: David Laight <David.Laight@ACULAB.COM>,
 'Madhavan Srinivasan' <maddy@linux.vnet.ibm.com>,
 "mpe\@ellerman.id.au" <mpe@ellerman.id.au>
Subject: RE: [RFC PATCH 0/2] powerpc: CR based local atomic operation
 implementation
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1C9FFB90@AcuExch.aculab.com>
References: <1417090721-25298-1-git-send-email-maddy@linux.vnet.ibm.com>
 <063D6719AE5E284EB5DD2968C1650D6D1C9FDC8B@AcuExch.aculab.com>
 <547831DC.6000703@linux.vnet.ibm.com>
 <063D6719AE5E284EB5DD2968C1650D6D1C9FE4A9@AcuExch.aculab.com>
 <547C8ADD.1050905@linux.vnet.ibm.com>
 <063D6719AE5E284EB5DD2968C1650D6D1C9FFB90@AcuExch.aculab.com>
Date: Thu, 18 Dec 2014 14:48:17 +1030
Message-ID: <87k31ptwty.fsf@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "paulus@samba.org" <paulus@samba.org>, "anton@samba.org" <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

David Laight <David.Laight@ACULAB.COM> writes:
> From: Madhavan Srinivasan [mailto:maddy@linux.vnet.ibm.com]
> ...
>> >>> I also wonder if it is possible to inspect the interrupted
>> >>> code to determine the start/end of the RAS block.
>> >>> (Easiest if you assume that there is a single 'write' instruction
>> >>> as the last entry in the block.)
>> >>>
>> >> So each local_* function also have code in the __ex_table section. IIUC,
>> >> __ex_table contains two address. So if the return address found in the
>> >> first column of the _ex_table, use the corresponding address in the
>> >> second column to continue from.
>> >
>> > That really doesn't scale.
>> > I don't know how many 1000 address pairs you table will have (and the
>> > ones in each loadable module), but the search isn't going to be cheap.
>> >
>> > If these sequences are restartable then they can only have one write
>> > to memory.
>> >
>> 
>> May be, but i see these issues incase of insts decode path,
>> 
>> 1) Decoding instruction may also cause a fault (in case of module) and
>> handling a fault at this stage toward the exit path of interrupt exit
>> makes me nervous
>
> It shouldn't be possible to unload a module that is interrupted by
> a hardware interrupt.
> An 'invalid' loadable module can cause an oops/panic anyway.

Yes, the module won't fault (vmalloc memory can be lazily mapped, but
we've already copied the module into there, so it won't happen).

>> 2) resulting code with lot of condition and branch (for opcode decode)
>> will be lot messy and may be an issue incase of maintenance,
>
> You don't need to decode the instructions.
> Just look for the two specific instructions used as markers.
> This is only really possible with fixed-size instructions.
>
> It might also be that the 'interrupt entry' path is easier to
> modify than the 'interrupt exit' one (fewer code paths) and
> you just need to modify the 'pc' in the stack frame.
> You are only interested in interrupts from kernel space.

It's an overoptimization for case that statistically never happens.
You won't even be able to measure the difference.

The question of bloat remains, but that's also easily measured.  In
practice, I'd guess less than 1k.

Cheers,
Rusty.
