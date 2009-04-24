Return-Path: <CFRIESEN@nortel.com>
Received: from zcars04e.nortel.com (zcars04e.nortel.com [47.129.242.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "", Issuer "NORTEL" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 3CF43DE180
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Apr 2009 04:10:16 +1000 (EST)
Message-ID: <49F1FF98.1000100@nortel.com>
Date: Fri, 24 Apr 2009 12:06:16 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: help with inline assembly code?
References: <49F1F56C.8000708@nortel.com> <49F1F841.8080507@freescale.com>
In-Reply-To: <49F1F841.8080507@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
> Chris Friesen wrote:
>> I've got a function that is used to overwrite opcodes in order to create 
>> self-modifying code.  It worked just fine with previous compilers, but 
>> with gcc 4.3 it seems like it sometimes (but not always) causes problems 
>> when inlined.  If I force it to never be inlined, it works fine.
>>
>> First, here's the code:
>>
>> void alter_opcode(unsigned long *addr, unsigned long opcode)
>> {
>>     asm volatile(
>>                 "stw    %1,0(%0)    \n\t"
>>                 "dcbf   0,%0        \n\t"
>>                 "sync            \n\t"
>>                 "icbi   0,%0,        \n\t"
>>                 "isync            \n\t"
>>                     :: "r" (addr), "r" (opcode): "memory");
>> }
>>
>> The symptom of the problem is a segfault on the "stw" instruction.  I've 
>> verified that the address it's trying to write to is the expected 
>> address, 
> 
> Verified by looking at the address in "addr", or by looking at the 
> reported faulting address?

Verified by running it in userspace under gdb, then looking at the 
registers listed in the disassembly and comparing it to the process maps.


>> and that the opcode being written is the expected opcode.
>>
>> I assume I've mixed up the registers or constraints or 
>> something...anyone want to take a crack at it?
> 
> Is the compiler assigning r0 to addr?  That will be treated as a literal 
> zero instead.  Try changing "r" (addr) to "b" (addr), or use stwx.

Bingo!  Is there a constraint to tell the compiler to not use r0 for addr?

Chris
