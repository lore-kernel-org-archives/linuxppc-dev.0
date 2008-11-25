Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 47303DDE0A
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Nov 2008 04:04:58 +1100 (EST)
In-Reply-To: <6E1FF753-110E-4DCF-966C-C73FC454368C@kernel.crashing.org>
References: <00e4dc93772a5517c4ac98d974d166ed@bga.com>
	<Pine.LNX.4.64.0811221242150.18022@t2.domain.actdsltmp>
	<6E1FF753-110E-4DCF-966C-C73FC454368C@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <9621091c6370601dbe24c741ce8be54a@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] powerpc: Better setup of boot page TLB entry
Date: Tue, 25 Nov 2008 11:03:35 -0600
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linux-ppc <linuxppc-dev@ozlabs.org>, Trent Piepho <tpiepho@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Nov 23, 2008, at 11:01 PM, Kumar Gala wrote:
> On Nov 22, 2008, at 10:01 PM, Trent Piepho wrote:
>> On Sat, 22 Nov 2008, Milton Miller wrote:
>>> On Thu Nov 20 at 06:14:30 EST in 2008, Trent Piepho wrote:
>>>> -       li      r7,0
>>>> -       lis     r6,PAGE_OFFSET at h
>>>> -       ori     r6,r6,PAGE_OFFSET at l
>>>> -       rlwimi  r6,r7,0,20,31
>>>> +       lis     r6,MAS2_VAL(PAGE_OFFSET, BOOKE_PAGESZ_64M, 
>>>> M_IF_SMP)@h
>>>> +       ori     r6,r6,MAS2_VAL(PAGE_OFFSET, BOOKE_PAGESZ_64M, 
>>>> M_IF_SMP)@l
>>>
>>> I'm fine with this part, even if the expression is a bit long.  You 
>>> might
>>> consider using LOAD_REG_IMMEDIATE from asm/ppc_asm.h to avoid 
>>> duplicating the
>>> expression.
>>
>> LOAD_REG_IMMEDIATE isn't used at all in that file, while lis/ori is 
>> used
>> many times.  In fact, there only one call of LOAD_REG_IMMEDIATE in 
>> all of
>> arch/powerpc/kernel/*.S.  So I think lis/ori is more easily 
>> recognized.
>> And to be honest, I find switching syntax from assembly language
>> instructions to C style macros that generate instructions to be
>> aesthetically ugly.

The macro is more useful for the 64 bit case where it uses its arguemnt 
4 times.  The usage was severely reduced with the 64 bit relocatable 
patch, where *IMMEDIATE was not relocated but LOAD_ADDR was.

>> It would be nice if the assembler provided a "liw" macro instruction 
>> that
>> would load an immediate.  When the assembler knows the immediate 
>> value, it
>> could even generate shorter sequences in some cases, like when the 
>> upper
>> 16 bits are all zero.

One thing that is nice about powerpc assembly is that all instructions 
and macros are fixed length.  That means we don't need to do multiple 
passes to figure out how many bytes we need for that source line.  In 
fact, I think all the standard macros are just alias formatting of one 
instruction.   At a minimum, you would only want the zero detection 
when it was a constant.


> I agree lis/ori is what should be used in this file and am not 
> interested in changing it at this point.

It was only a light consider comment and would not have prompted the 
email.


>
>>>> /* 7. Jump to KERNELBASE mapping */
>>>> -       lis     r6,KERNELBASE at h
>>>> -       ori     r6,r6,KERNELBASE at l
>>>> -       rlwimi  r6,r7,0,20,31
>>>> +       lis     r6,(KERNELBASE & ~0xfff)@h
>>>> +       ori     r6,r6,(KERNELBASE & ~0xfff)@l
>>>
>>> Why do you need to mask off the bottom bits of KERNEL_BASE?  Just 
>>> trying to
>>> keep the instruction effect identical?
>>
>> Yes, so it was clear I wasn't changing what the code did here.  And to
>> make it clear we only wanted the page number from KERNEL_BASE.  It's 
>> an
>> obvious expression and a compile time constant, merely saving a few
>> characters in the source doesn't seem worth much.  I realize it's
>> unnecessary since those bits get masked off in the wlwimi a few
>> instructions later.

You realize it after studying the code, but the next person reading may 
not.   My take is putting this longer expression makes the code harder 
to read and a changelog comment pointing out that the lower bits are 
overwritten would have eliminated the need for this ugly expression.

>> Really all I wanted to fix the was memory coherency on SMP bug.  But 
>> the
>> code for MAS2 was stupid, so I had to change that to fix the bug in a
>> non-ugly way.  But then r7 didn't need to be zeroed and the 
>> (unnecessary)
>> "rlwimi r6,r7,0,20,31" would no longer be doing what's it's supposed 
>> to,
>> so I fixed that too.
>>
>>> First of all, if its not aligned, then its likely other parts of the 
>>> kernel
>>> will break.  We could put a BUILD_BUG_ON somewhere (in c) if that 
>>> check is
>>> required.
>>
>> I seems like "Require KERNEL_BASE to be page aligned and modify code 
>> to
>> depend on said requirement" belongs in another patch.

Well, I could write one, but I don't have any hardware to test.

And the above code depends on the alignement, by the fact that it 
inserts the 4k offset into kernel base.

>>>> -       addi    r6,r6,24
>>>> +       addi    r6,r6,(2f - 1b)
>>>
>>> and while doing assembler math is better than the hand computed 24, 
>>> how about
>>> doing li r9,2f@l and just inserting that into r6?  Unless you expect 
>>> step 8
>>> to cross a page from the 1b label above.  But if you are that close 
>>> to a page
>>> boundary than assuming 1b is in the page at KERNEL_BASE would seem 
>>> to be
>>> suspect.
>>>
>>> For that matter, just do LOAD_ADDR(2f) or LOAD_REG_IMMEDIATE(2f), 
>>> which would
>>> give the same result, as KERNEL_BASE should be reflected the linked 
>>> address
>>> of the kernel (I assume that you are not doing dynamic runtime 
>>> relocation
>>> like ppc64 on the code up to here, otherwise the previous suggestion 
>>> still
>>> works).
>>
>> I'm not sure if this code can be relocated or not.  If it isn't now, 
>> using
>> non-position independent code won't make it any easier to make it
>> relocatable.  It looks like the "bl 1f ; 1: mflr" sequence is used 13
>> times in arch/powerpc/kernel/*.S, I wonder if all of them are 
>> unnecessary?
>
> We support relocation of this kernel so any changes need to be tried 
> out w/CONFIG_RELOCATABLE enabled.

The question was not does the kernel support CONFIG_RELOCATABLE, the 
question was 'will some agent relocate the kernel to be running at its 
loaded location before this code (which appears to be very early) is 
run', or does the RELOCATABLE code for this flavor work by adjusting 
the linear mapping offset (which is what I thought it did).

>
> I'm fine with the patch as is and any other changes should be follow 
> on patches.
>
> - k

I don't have any booke hardware, so I'm less likely to look at this 
code.  Any changes from me would only be compile changes.

milton
