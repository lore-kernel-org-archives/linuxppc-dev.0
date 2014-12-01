Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2D0F61A0A0F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Dec 2014 02:36:07 +1100 (AEDT)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 1 Dec 2014 21:06:05 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 87114E0058
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Dec 2014 21:06:27 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB1Fc8HQ393648
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Dec 2014 21:08:09 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB1FZvRZ022226
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Dec 2014 21:05:58 +0530
Message-ID: <547C8ADD.1050905@linux.vnet.ibm.com>
Date: Mon, 01 Dec 2014 21:05:57 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
To: David Laight <David.Laight@ACULAB.COM>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>
Subject: Re: [RFC PATCH 0/2] powerpc: CR based local atomic operation
 implementation
References: <1417090721-25298-1-git-send-email-maddy@linux.vnet.ibm.com>
 <063D6719AE5E284EB5DD2968C1650D6D1C9FDC8B@AcuExch.aculab.com>
 <547831DC.6000703@linux.vnet.ibm.com>
 <063D6719AE5E284EB5DD2968C1650D6D1C9FE4A9@AcuExch.aculab.com>
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1C9FE4A9@AcuExch.aculab.com>
Content-Type: text/plain; charset=utf-8
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "rusty@rustcorp.com.au" <rusty@rustcorp.com.au>,
 "paulus@samba.org" <paulus@samba.org>, "anton@samba.org" <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday 28 November 2014 03:39 PM, David Laight wrote:
> From: Madhavan Srinivasan
>> On Thursday 27 November 2014 07:35 PM, David Laight wrote:
>>> From: Madhavan Srinivasan
>>>> This patchset create the infrastructure to handle the CR based
>>>> local_* atomic operations. Local atomic operations are fast
>>>> and highly reentrant per CPU counters.  Used for percpu
>>>> variable updates. Local atomic operations only guarantee
>>>> variable modification atomicity wrt the CPU which owns the
>>>> data and these needs to be executed in a preemption safe way.
>>>
>>> These are usually called 'restartable atomic sequences (RAS)'.
>>>
>>>> Here is the design of the first patch. Since local_* operations
>>>> are only need to be atomic to interrupts (IIUC), patch uses
>>>> one of the Condition Register (CR) fields as a flag variable. When
>>>> entering the local_*, specific bit in the CR5 field is set
>>>> and on exit, bit is cleared. CR bit checking is done in the
>>>> interrupt return path. If CR5[EQ] bit set and if we return
>>>> to kernel, we reset to start of local_* operation.
>>>
>>> I don't claim to be able to read ppc assembler.
>>> But I can't see the code that clears CR5[EQ] for the duration
>>> of the ISR.
>> I use crclr instruction at the end of the code block to clear the bit.
>>
>>> Without it a nested interrupt will go through unwanted paths.
> 
> That crclr looks to be in the ISR exit path, you need one in the
> isr entry path.

In case of entry path, i clear the field using mtcr instruction

> 
>>>
>>> There are also a lot of 'magic' constants in that assembly code.
>>>
>> All these constants are define in asm/ppc-opcode.h
> 
> I was thinking of the lines like:
> +	ori	r3,r3,16384

 ok sure. Will comment

> This one probably deserves a comment - or something
> +"3:"	PPC405_ERR77(0,%2)
> 
>>> I also wonder if it is possible to inspect the interrupted
>>> code to determine the start/end of the RAS block.
>>> (Easiest if you assume that there is a single 'write' instruction
>>> as the last entry in the block.)
>>>
>> So each local_* function also have code in the __ex_table section. IIUC,
>> __ex_table contains two address. So if the return address found in the
>> first column of the _ex_table, use the corresponding address in the
>> second column to continue from.
> 
> That really doesn't scale.
> I don't know how many 1000 address pairs you table will have (and the
> ones in each loadable module), but the search isn't going to be cheap.
> 
> If these sequences are restartable then they can only have one write
> to memory.
> 

May be, but i see these issues incase of insts decode path,

1) Decoding instruction may also cause a fault (in case of module) and
handling a fault at this stage toward the exit path of interrupt exit
makes me nervous

2) resulting code with lot of condition and branch (for opcode decode)
will be lot messy and may be an issue incase of maintenance,

but let me think it over again on this.

Regards
Maddy

> Given your:
>> This patch re-write the current local_* functions to CR5 based one.
>> Base flow for each function is 
>>
>> {
>> 	set cr5(eq)
>> 	load
>> 	..
>> 	store
>> 	clear cr5(eq)
>> }
> 
> On ISR entry:
> If an ISR detects cr5(eq) set then look at the returned to instruction.
> If it is 'clear cr5(eq)' do nothing.
> Otherwise read backwards through the code (for a max of (say) 16 instructions)
> searching for the 'set cr5(eq)' and change the return address to be that
> of the instruction following the 'set cr5(eq)'.
> In all cases clear cr5(eq) for the ISR itself (leave the saved value unchanged).
> 
> The you don't need a table of fault locations.
> 
> 	David
> 
