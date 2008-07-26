Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 48DB0DDFAA
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jul 2008 14:51:47 +1000 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
In-Reply-To: <200807131420.29235.marvin24@gmx.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <67d6782d119397d07c9d8cfad01cff36@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [RFC] reorganize cputypes for PPC64 
Date: Fri, 25 Jul 2008 23:50:50 -0500
To: Marvin <marvin24@gmx.de>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sun Jul 13 22:20:28 EST 2008, Marvin wrote:
> On Saturday 12 July 2008 20:00:05 Arnd Bergmann wrote:
>> On Saturday 12 July 2008, Marvin wrote:
>>> attached patch introduces a "processor type" menu similar to ppc32. 
>>> It _should_ not change anything upto now.
>>>
>>> The aim is to allow future fine graded cpu optimizations via 
>>> mcpu/mtune compiler flags and also to clean up the arch 
>>> Makefile/Kconfig.cputypes (I know this is a minefield).
>>
>> I tried something similar last year, but failed miserably, because 
>> the complexity cannot really be contained. I still think it's a good 
>> idea, but I'm not sure whether your patch will help at all.
>
> Before I try to change something, I like to get some feedback about 
> the direction to take. Therefore your comments are more than welcome.
>
>>> diff --git a/arch/powerpc/platforms/Kconfig.cputype
>>> b/arch/powerpc/platforms/Kconfig.cputype
>>> index f7efaa9..eebde6c 100644
>>> --- a/arch/powerpc/platforms/Kconfig.cputype
>>> +++ b/arch/powerpc/platforms/Kconfig.cputype
>>> @@ -54,35 +54,65 @@ config E200
>>>
>>>  endchoice
>>>
>>> -config POWER4_ONLY
>>> -       bool "Optimize for POWER4"
>>> +choice
>>> +       prompt "Processor Type"
>>>         depends on PPC64
>>> +       default TUNE_POWER4
>>> +       help
>>> +         There are serveral families of 64 bit PowerPC chips  
>>> supported.
>>> +         These include the Power3 to Power6 series, 970, and Cell 
>>> BE based
>>> +         CPUs made be IBM.
>>> +
>>> +         If unsure, select Power4.
>>> +
>>> +config TUNE_POWER3
>>> +       bool "Power3"
...
>>> +
>>> +config TUNE_CELL
>>> +       bool "Cell Broadband Engine"
>>> +       help
>>> +         Cause the compiler to optimize for the PPE of the Cell 
>>> Broadband
>>> +         Engine. This will make the code run considerably faster on 
>>> Cell
>>> +         but somewhat slower on other machines. If the resulting 
>>> kernel is
>>> +         built to run only on Cell BE machines, select also 
>>> OPT_EXCLUSIVE.
>>> +
>>> +endchoice
>>
>> What about the other CPUs? There is also RS64, Power5+, PA6T and 
>> Power7.
>
> I grepped the source (especially the defconfigs) and it seems, that 
> there is only one distinction between the different PPC64 archs named 
> POWER3. POWER4 is always set on PPC64 archs, POWER3 is not set on G5, 
> maple and pasemi.
>
> Grepping further reveals, that POWER3 is mentioned in mm/pgtable_32.c 
> only, where is used to define HAVE_BATS (it exists also in 
> asm/cputable.h, which is a candidate for cleanup -> replace !POWER4 && 
> !POWER3 by !PPC64).
>
> My daring conclusion is therefore:
>         1. POWER3 could be replaced by HAVE_BATS
>         2. POWER4 could be replaced by PPC64

No, this is the wrong approach.  Don't figure out what to call things 
by looking at where you see them used.  See below for why.

> The only processor dependant config left is the tuning option. gcc has 
> no special option for power7 or pa6t yet, but the reorg should be 
> flexible, so new tuning options can be added easily. RS64 could be 
> added to the  tuneing options.

Let me give you a hint why you find the current usage.

POWER4 is is the first PowerPC-2.x architecture processor.

POWER3 and the RS64 series implement various versions of the PowerPC 
1.x architecture.  RS64 decided it didn't need bats.

While for the most part there have only been additions, the biggest 
change as far as the operating system is the removal of the BAT and the 
replacement of the STAB with the SLB.

That said, there are subtile compatibility problems.   There are bits 
that are defined in current instructions that should have been ignored 
but are not.  For example, mtocrf causes a fault on POWER3 but makes 
POWER4 and later run mach faster.  Also, the encoding of branch 
prediction was changed.

POWER4_ONLY says go ahead and compile a kernel that will not run on a 
POWER3.   However, currently, it still runs on RS64, as we don't 
conditionally compile SLB or STAB code.


The reason I said replacing POWER3 to HVAE_BATS is that that is the 
wrong interface for the user.   The user will know his cpu but will not 
know technical things like POWER3 has bats and later ones do not.

That said, I think its perfectly reasonable to have POWER3 select 
HAVE_BATS and make the code depend on that FEATURE type config.

>>> +
>>> +config OPT_EXCLUSIVE
>>> +       bool "Optimize to run exclusive on selected CPU"
>>>         default n
>>> -       ---help---
>>> -         Cause the compiler to optimize for POWER4/POWER5/PPC970 
>>> processors.
>>> -         The resulting binary will not work on POWER3 or RS64 
>>> processors
>>> -         when compiled with binutils 2.15 or later.
>>> +       help
>>> +         Cause the compiler to optimize to run exclusive on the 
>>> selected
>>> +         CPU. The resulting binary will probably not work on other 
>>> CPUs.
>>> +
>>> +         If the compiler/binutils combination does not support the 
>>> exclusive
>>> +         optimization, it will try to tune only or fail.
>>> +
>>> +         If you are unsure, select no.
>>
>> Almost all CPUs are backwards compatible, so the option should not be 
>> labelled 'exclusive'. In general, if you build for PowerX, it will 
>> also run on Power(X+1). 970 is backwards compatible to Power4, Cell 
>> and PA6T are backwards compatible to 970, Power6 is backwards 
>> compatible to both of these.
>>
>> Also, there are good reasons to have the -mcpu option different from 
>> -mtune. E.g. you may want to use Power4 compatible instructions but 
>> tune for Power6 in a typical distro kernel.
>
> ok. That would mean to have two config menus:
>         - optimize to run exclusive on cpu_x or higher
>         - tune for cpu_y, and use instruction set for cpu_x, where x<=y
>
> That seems to be rather complex and I think this is also unrealistic, 
> because there are often only two cases:
>         - a distro doesn't want to maintain one kernel per cpu. So 
> they always choose common instructions and tune for some higher cpu 
> (likely power4).
>         - a high end user (or specilized distro), who wants to compile 
>  his own kernel for maximum performance compiles exlusive only (e.g. 
> for cell be).
>
> This is why I choosed "select cpu" menu and a bool for exclusive (use 
> mcpu) or not (use mtune). Another option would be to add a string 
> prompt, so the user can enter his own tuning options "-mcpu=cpu_x 
> -mtune=cpu_y", but I think this is undesired.
>
>>>  config POWER3
>>> -       bool
>>>         depends on PPC64
>>> -       default y if !POWER4_ONLY
>>> +       def_bool y if !POWER4_ONLY
>>>
>>>  config POWER4
>>>         depends on PPC64
>>>         def_bool y
>>>
>>> -config TUNE_CELL
>>> -       bool "Optimize for Cell Broadband Engine"
>>> +config POWER4_ONLY
>>>         depends on PPC64
>>> -       help
>>> -         Cause the compiler to optimize for the PPE of the Cell 
>>> Broadband
>>> -         Engine. This will make the code run considerably faster on 
>>> Cell
>>> -         but somewhat slower on other machines. This option only 
>>> changes
>>> -         the scheduling of instructions, not the selection of 
>>> instructions
>>> -         itself, so the resulting kernel will keep running on all 
>>> other
>>> -         machines. When building a kernel that is supposed to run 
>>> only
>>> -         on Cell, you should also select the POWER4_ONLY option.
>>> +       def_bool y if TUNE_POWER4 && OPT_EXCLUSIVE
>>>
>>>  config 6xx
>>>         bool
>>
>> Tuning for Cell gives a significant performance bonus on cell based 
>> machines with a new compiler, and again, you would typically want to  
>> use the Power4 instruction set, but not restrict to Power3 or use all 
>> of the Cell instructions.
>
> That's again the "distro/high end user" question discussed above. I 
> think this was raised several times in the past on this list without a 
> common conclusion. A small survey shows, that distros are shipping 
> kernels for ppc32 (sometimes prep and chrp) and ppc64 (common, 
> iseries, pseries, and ps3) for installation only and provide a single 
> image for updates. Maybe this would change if there is a choice....

[My appoligies for the late reply, it seems to have gotten left in my 
drafts folder.   Probably because apple mail did a harrible job wrappig 
lines in all the wrong places.  I have made all the discussion flow 
into paragraphs with what I hope is the proper indenting/attribution.

Perhaps the patch has a singnificant amount of lines with trailing 
whitespace?]


milton
