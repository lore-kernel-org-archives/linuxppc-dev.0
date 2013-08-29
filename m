Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by ozlabs.org (Postfix) with ESMTP id 1AAB62C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Aug 2013 07:04:06 +1000 (EST)
Message-ID: <521FB743.4020305@c-s.fr>
Date: Thu, 29 Aug 2013 23:04:03 +0200
From: leroy christophe <christophe.leroy@c-s.fr>
MIME-Version: 1.0
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: Feedback wished on possible improvment of CPU15 errata handling
 on mpc8xx
References: <521F80D4.2030300@c-s.fr>
 <OF0B494249.C66591E0-ONC1257BD6.0060FA67-C1257BD6.0062A4F8@transmode.se>
In-Reply-To: <OF0B494249.C66591E0-ONC1257BD6.0060FA67-C1257BD6.0062A4F8@transmode.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Scott Wood <scottwood@freescale.com>,
 LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le 29/08/2013 19:57, Joakim Tjernlund a écrit :
> "Linuxppc-dev"
> <linuxppc-dev-bounces+joakim.tjernlund=transmode.se@lists.ozlabs.org>
> wrote on 2013/08/29 19:11:48:
>> The mpc8xx powerpc has an errata identified CPU15 which is that whenever
>> the last instruction of a page is a conditional branch to the last
>> instruction of the next page, the CPU might do crazy things.
>>
>> To work around this errata, one of the workarounds proposed by freescale
> is:
>> "In the ITLB miss exception code, when loading the TLB for an MMU page,
>> also invalidate any TLB referring to the next and previous page using
>> tlbie. This intentionally forces an ITLB miss exception on every
>> execution across sequential MMU page boundaries"
>>
>> It is that workaround which has been implemented in the kernel. The
>> drawback of this workaround is that TLB miss is encountered everytime we
>> cross page boundary. On a flat program execution, it means that we get a
>> TLB miss every 1000 instructions. A TLB miss handling is around 30/40
>> instructions, which means a degradation of about 4% of the performances.
>> It can be even worse if the program has a loop astride two pages.
>>
>> In the errata document from freescale, there is an example where they
>> only invalidate the TLB when the page has the actual issue, in extenso
>> when the page has the offending instruction at offset 0xffc, and they
>> suggest to use the available PTE bits to tag pages in advance.
>>
>> I checked in asm/pte-8xx.h : we still have one SW bit available
>> (0x0080). So I was thinking about using that bit to mark pages
>> CPU15_SAFE when loading them if they don't have the offending
> instruction.
>> Then, in the ITLBmiss handler, instead of always invalidating preceeding
>> and following pages, we would check SW bit in the PTE and invalidate
>> following page only if current page is not marked CPU15_SAFE, then check
>> the PTE of preceeding page and invalidate it only if it is not marked
>> CPU15_SAFE
>>
>> I believe this would improve the CPU15 errata handling and would reduce
>> the overhead introduced by the handling of this errata.
>>
>> Do you see anything wrong with my proposal ?
> Just that you are using up the last bit of the pte which will be needed at
> some point.
> Have you run into CPU15? We have been using 8xx for more than 10 years on
> kernel 2.4 and I
> don't think we ever run into this problem.
Ok, indeed I have activated the CPU15 errata in the kernel because I 
know my CPU has the bug.
Do you think it can be deactivated without much risk though ?
> If you go forward with this I suggest you use the WRITETHRU bit instead
> and make
> it so the user can choose which to use.
>
> If you want to optimize TLB misses you might want to add support for 8MB
> pages, I got
> the TLB and kernel memory done in my 2.4 kernel. You could start with that
> and
> add 8MB user space page.
In 2.6 Kernel we have CONFIG_PIN_TLB which pins the first 8Mbytes in 
ITLB and pins the first 24Mbytes in DTLB as far as I understand. Do we 
need more for the kernel ? I so, yes I would be interested in porting 
your code to 2.6

Wouldn't we waste memory by using 8Mbytes pages in user mode ?
I read somewhere that Transparent Huge Pages have been ported on powerpc 
in future kernel 3.11. Therefore I was thinking about maybe adding 
support for hugepages into 8xx.
8xx has 512kbytes hugepages, I was thinking that maybe it would be more 
appropriate than 8Mbytes pages.
Do you think it would be feasible and usefull to do this for embeddeds 
system having let say 32 to 128Mbytes RAM ?

Christophe
