Return-Path: <jimix@watson.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6F9AB67BF6
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Aug 2006 22:12:48 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k7MCCfE9024718
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Aug 2006 08:12:41 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7MCCfHe262426
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Aug 2006 08:12:41 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7MCCfQm000848
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Aug 2006 08:12:41 -0400
In-Reply-To: <aa3478a76dd7fb5bff781350a7538fb0@bga.com>
References: <aa3478a76dd7fb5bff781350a7538fb0@bga.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <BEC5255D-9CE1-4DE8-B678-EE57C4115C70@watson.ibm.com>
From: Jimi Xenidis <jimix@watson.ibm.com>
Subject: Re: Take 2: [RFC] Debugging with a HW probe.
Date: Tue, 22 Aug 2006 08:12:31 -0400
To: Milton Miller <miltonm@bga.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 22, 2006, at 2:04 AM, Milton Miller wrote:

>
> On Aug 14, 2006, at 5:16 AM, Jimi Xenidis jimix at watson.ibm.com   
> wrote:
>>
>> Signed-off-by: Jimi Xenidis <jimix at watson.ibm.com>
>
> [sorry for the list archive patch munging]
>
>> ---
>> diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
>> index e29ef77..bc4cdf9 100644
>> --- a/arch/powerpc/Kconfig.debug
>> +++ b/arch/powerpc/Kconfig.debug
>> @@ -61,6 +61,17 @@ config KGDB_CONSOLE
>>           over the gdb stub.
>>           If unsure, say N.
>>
>> +config ENABLE_HW_PROBE
>> +       bool "Allow instructions that contact a hardware probe  
>> (dangerous)"
>> +       depends on PPC64
>
> Not having this depend on DEBUGGER but in the middle of things that  
> do will
> get you scorn from the auto-indenting police.
ACK

>
> Since we can only call this from xmon, should it depend on XMON  
> (and be
> placed after that)?

If the HW probe is available, XMON will use it.
However, enabling the HW probe also means that I can (as a developer)  
insert ATTN() anywhere in my code and have the probe stop there. I  
even have kernels where BUG() contains ATTN(), but thats another patch.

>
>> +       help
>> +         If you enable this AND you add "hwprobe" to the cmdline,  
>> the
>> +         processor will enable instructions that contact the  
>> hardware
>> +         probe.  These instructions ca be used in all processor  
>> modes
>
> can
ACK

>
>> +         _including_ user mode and are only useful for kernel
>
> not sure this _highlighting_ is used elsewhere in Kconfig help ...

I was looking for an example and found "_will not boot_" in this very  
file.

>
> Should we mention that a hardware probe is required to continue  
> exectuion?
> In other words, its not just contact, but signal and wait for a hw  
> probe?
Hows this?
          If you enable this AND you add "hwprobe" to the cmdline, the
          processor will enable instructions that signal and wait for
          the hardware probe, _stopping_ the processor.  These
          instructions can be used in all processor modes _including_
          user mode and are only useful for kernel development and
          debugging.  DO NOT enable this unless you plan to use it.  If
          you DO NOT have a hardware probe, answer N.

[snip]
>> --- a/arch/powerpc/kernel/prom_init.c
>> +++ b/arch/powerpc/kernel/prom_init.c
>> @@ -587,6 +587,14 @@ #ifdef CONFIG_PPC64
>>                         RELOC(iommu_force_on) = 1;
>>         }
>>  #endif
>> +#ifdef CONFIG_HW_PROBE_ENABLE
>> +       opt = strstr(RELOC(prom_cmd_line), RELOC("hwprobe"));
>> +       if (opt) {
>> +               prom_printf("WARNING! HW Probe will be activated! 
>> \n");
>> +               prom_setprop(_prom->chosen, "/chosen",
>> +                            "linux,hw-probe-enable", NULL, 0);
>> +       }
>> +#endif
>>  }
>
> Please, PLEASE do NOT do this.

Ok, I won't. I somehow missed "early_param()" that should do just fine.

>
> Which .h is hw_probe_enabled in?  (none?)

Correct, this RFC is to get valuable feedback (thank you), the  
setting the global is the current goal, I'm waiting for some other  
patches from other people to get in before we start going after HID  
bits that this global, may or may not be part of.

>
>>
>>  #ifdef CONFIG_PPC_PSERIES
>> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
>> index 179b10c..51a1e4e 100644
>> --- a/arch/powerpc/xmon/xmon.c
>> +++ b/arch/powerpc/xmon/xmon.c
>> @@ -189,7 +189,12 @@ #endif
>>    dd   dump double values\n\
>>    dr   dump stream of raw bytes\n\
>>    e    print exception information\n\
>> -  f    flush cache\n\
>> +  f    flush cache\n"
>> +#ifdef CONFIG_ENABLE_HW_PROBE
>> +  "\
>> +  H     Contact hardware probe, if available\n"
>> +#endif
>> +  "\
>
> While this style does keep the lines aligned in the source, it adds  
> veritcal
> almost-whitespace.

Are you expressing "dislike"?

>   And I notice a different choice was made at the bottom.
I borrowed from the CONFIG_SMP above and avoided putting '"' in col 0  
but am happy to compress.

[snip]
>> @@ -641,6 +648,13 @@ extern void ppc64_runlatch_off(void);
>>  extern unsigned long scom970_read(unsigned int address);
>>  extern void scom970_write(unsigned int address, unsigned long  
>> value);
>>
>> +/*
>> + * Support Processor Attention Instruction instroduced in POWER
>> + * architecture processors as of RS64, tho may not be supported by
>> + * POWER 3.
>> + */
>> +#define ATTN() asm volatile("attn; nop")
>> +
>
>
> Fairly certian POWER3 does NOT implement this, but I don't have  
> book IV handy.
The book4 mentions "BPUBKT" and when asked no one could give a  
definite answerm, I figured I'd try an see at some point.  Having  
said that, you give me a s/Fairly/Absolutely/ and its GONE!

> Does one of the processors require the nop ?

The nop is there so that once in the probe, depending on your probe  
interface, you can easily skip it by adding 4 to the PC knowing you  
would get a nop.  This is not entirely necessary but some processor/ 
probes have a PC and a "next PC".  I have had little experience with  
this probe and wanted to make sure I had something to set both to if  
it was needed.

Thanks for your feedback.
-JX
