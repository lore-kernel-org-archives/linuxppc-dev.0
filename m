Return-Path: <markn@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (E23SMTP02.au.ibm.com [202.81.18.163])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E0826DDDE4
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 14:59:29 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp02.au.ibm.com (8.13.1/8.13.1) with ESMTP id l8Q4xThq010986
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 14:59:29 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8Q4xR6s1519744
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 14:59:27 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8Q4xR8v020484
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 14:59:27 +1000
Message-ID: <46F9E67C.4070209@au1.ibm.com>
Date: Wed, 26 Sep 2007 14:56:28 +1000
From: Mark Nelson <markn@au1.ibm.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] add Altivec/VMX state to coredumps
References: <46F88896.50706@au1.ibm.com>
	<E4CA12E1-888D-4A8B-B687-02F9D2850E1F@kernel.crashing.org>
	<46F9B454.8010004@au1.ibm.com>
	<1B211071-5D55-4DBC-A109-7A66EC17A810@kernel.crashing.org>
In-Reply-To: <1B211071-5D55-4DBC-A109-7A66EC17A810@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Carlos Eduardo Seo <eduseo@br.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> 
> On Sep 25, 2007, at 8:22 PM, Mark Nelson wrote:
> 
>> Kumar Gala wrote:
>>>
>>> On Sep 24, 2007, at 11:03 PM, Mark Nelson wrote:
>>>
>>>> Update dump_task_altivec() (that has so far never been put to use)
>>>> so that it dumps the Altivec/VMX registers (VR[0] - VR[31], VSCR
>>>> and VRSAVE) in the same format as the ptrace get_vrregs() and add
>>>> the appropriate glue typedefs and #defines to
>>>> include/asm-powerpc/elf.h for it to work.
>>>
>>> Is there some way to tell if the core dump has altivec registers state
>>> in it?
>>>
>>> I'm wondering how we distinguish a core dump w/altivec state vs one with
>>> SPE state.
>>>
>>> - k
>>>
>>>
>>
>> If the core dump has the Altivec registers saved in there it will have a
>> note called LINUX as shown below:
>>
>> $ readelf -n core
>>
>> Notes at offset 0x000002b4 with length 0x000005c8:
>>   Owner         Data size       Description
>>   CORE          0x0000010c      NT_PRSTATUS (prstatus structure)
>>   CORE          0x00000080      NT_PRPSINFO (prpsinfo structure)
>>   CORE          0x000000b0      NT_AUXV (auxiliary vector)
>>   CORE          0x00000108      NT_FPREGSET (floating point registers)
>>   LINUX         0x00000220      NT_PRXFPREG (user_xfpregs structure)
>>
>> This mirrors what occurs with the SSE registers on i386 core dumps in
>> order to keep things as similar as possible.
>>
>> I can't find any place where dump_spe() is called at the moment, but I
>> suppose if it were to be hooked up in the future it could cause
>> confusion.
>> The Altivec register state in the core file is much larger than what
>> would be dumped by the current dump_spe(), but I'm not sure if that
>> matters...
>>
>> There's a patch for GDB that currently reads the contents of these vector
>> registers from the core file, but it's being held until this patch has
>> been commented on and/or approved of, so if it comes to it the note name
>> could be changed to ALTIVEC (or something similar).
> 
> I think we should NOT overload NT_PRXFPREG and add proper note types
> NT_ALTIVEC & NT_SPE for those register sets.
> 
> Who on the GDB side would we need to coordinate such a change with?
> 
> - k
> 

You're probably right :)

What cores have SPE at the moment? Also, perhaps more importantly, are there any plans to have Altivec and SPE in the same core?

I've been working with Carlos Eduardo Seo (Cc'ed on this mail) on the GDB side of this.


Thanks!

Mark.
