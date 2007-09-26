Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3B10EDDDE4
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 15:39:50 +1000 (EST)
In-Reply-To: <46F9E67C.4070209@au1.ibm.com>
References: <46F88896.50706@au1.ibm.com>
	<E4CA12E1-888D-4A8B-B687-02F9D2850E1F@kernel.crashing.org>
	<46F9B454.8010004@au1.ibm.com>
	<1B211071-5D55-4DBC-A109-7A66EC17A810@kernel.crashing.org>
	<46F9E67C.4070209@au1.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8FC0C4ED-3268-467C-A3EF-0336082062E1@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] add Altivec/VMX state to coredumps
Date: Wed, 26 Sep 2007 00:37:29 -0500
To: Mark Nelson <markn@au1.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Carlos Eduardo Seo <eduseo@br.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 25, 2007, at 11:56 PM, Mark Nelson wrote:

> Kumar Gala wrote:
>>
>> On Sep 25, 2007, at 8:22 PM, Mark Nelson wrote:
>>
>>> Kumar Gala wrote:
>>>>
>>>> On Sep 24, 2007, at 11:03 PM, Mark Nelson wrote:
>>>>
>>>>> Update dump_task_altivec() (that has so far never been put to use)
>>>>> so that it dumps the Altivec/VMX registers (VR[0] - VR[31], VSCR
>>>>> and VRSAVE) in the same format as the ptrace get_vrregs() and add
>>>>> the appropriate glue typedefs and #defines to
>>>>> include/asm-powerpc/elf.h for it to work.
>>>>
>>>> Is there some way to tell if the core dump has altivec registers  
>>>> state
>>>> in it?
>>>>
>>>> I'm wondering how we distinguish a core dump w/altivec state vs  
>>>> one with
>>>> SPE state.
>>>>
>>>> - k
>>>>
>>>>
>>>
>>> If the core dump has the Altivec registers saved in there it will  
>>> have a
>>> note called LINUX as shown below:
>>>
>>> $ readelf -n core
>>>
>>> Notes at offset 0x000002b4 with length 0x000005c8:
>>>   Owner         Data size       Description
>>>   CORE          0x0000010c      NT_PRSTATUS (prstatus structure)
>>>   CORE          0x00000080      NT_PRPSINFO (prpsinfo structure)
>>>   CORE          0x000000b0      NT_AUXV (auxiliary vector)
>>>   CORE          0x00000108      NT_FPREGSET (floating point  
>>> registers)
>>>   LINUX         0x00000220      NT_PRXFPREG (user_xfpregs structure)
>>>
>>> This mirrors what occurs with the SSE registers on i386 core  
>>> dumps in
>>> order to keep things as similar as possible.
>>>
>>> I can't find any place where dump_spe() is called at the moment,  
>>> but I
>>> suppose if it were to be hooked up in the future it could cause
>>> confusion.
>>> The Altivec register state in the core file is much larger than what
>>> would be dumped by the current dump_spe(), but I'm not sure if that
>>> matters...
>>>
>>> There's a patch for GDB that currently reads the contents of  
>>> these vector
>>> registers from the core file, but it's being held until this  
>>> patch has
>>> been commented on and/or approved of, so if it comes to it the  
>>> note name
>>> could be changed to ALTIVEC (or something similar).
>>
>> I think we should NOT overload NT_PRXFPREG and add proper note types
>> NT_ALTIVEC & NT_SPE for those register sets.
>>
>> Who on the GDB side would we need to coordinate such a change with?
>>
>> - k
>>
>
> You're probably right :)
>
> What cores have SPE at the moment? Also, perhaps more importantly,  
> are there any plans to have Altivec and SPE in the same core?

The e500 cores's from Freescale.

No, they are pretty much mutually exclusive.

> I've been working with Carlos Eduardo Seo (Cc'ed on this mail) on  
> the GDB side of this.

 From comments it looks like the expectation is that the combination  
of note type and name which is expected to be unique.

I'm wondering if we should handle this via  
elf_coredump_extra_notes_size() & elf_coredump_extra_notes_write().   
Does GDB care about the order it sees the various sections in?

- k
