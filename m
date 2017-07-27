Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xHxsy3kdgzDrF2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 13:14:46 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: joserz@linux.vnet.ibm.com, Paul Mackerras <paulus@ozlabs.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, oohall@gmail.com
Subject: Re: KVM guests freeze under upstream kernel
In-Reply-To: <20170726131848.GA13783@pacoca>
References: <20170719194634.GA1222@pacoca>
 <1500507770.3350.41.camel@kernel.crashing.org>
 <20170720030222.GA21034@pacoca> <20170720052159.GB8602@fergus.ozlabs.ibm.com>
 <20170721011818.GC13187@pacoca> <20170726131848.GA13783@pacoca>
Date: Thu, 27 Jul 2017 13:14:45 +1000
Message-ID: <87d18mfu56.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

joserz@linux.vnet.ibm.com writes:
> On Thu, Jul 20, 2017 at 10:18:18PM -0300, joserz@linux.vnet.ibm.com wrote:
>> On Thu, Jul 20, 2017 at 03:21:59PM +1000, Paul Mackerras wrote:
>> > 
>> > Did you check the host kernel logs for any oops messages?
>> 
>> dmesg was clean but after sometime waiting (I forgot QEMU running in
>> another terminal) I got the oops below (after rebooting the host I 
>> couldn't reproduce it again).
>> 
>> Another test that I did was:
>> Compile with transparent huge pages disabled: KVM works fine
>> Compile with transparent huge pages enabled: doesn't work
>>   + disabling it in /sys/kernel/mm/transparent_hugepage: doesn't work
>> 
>> Just out of my own curiosity I made this small change:
>> 
>> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h
>> b/arch/powerpc/include
>> index c0737c8..f94a3b6 100644
>> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
>> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
>> @@ -80,7 +80,7 @@
>>  
>>   #define _PAGE_SOFT_DIRTY       _RPAGE_SW3 /* software: software dirty
>>   tracking 
>>    #define _PAGE_SPECIAL          _RPAGE_SW2 /* software: special page */
>>    -#define _PAGE_DEVMAP           _RPAGE_SW1 /* software: ZONE_DEVICE page */
>>    +#define _PAGE_DEVMAP           _RPAGE_RSV3
>>     #define __HAVE_ARCH_PTE_DEVMAP
>> 
>> and it works. I chose _RPAGE_RSV3 because it uses the same value that
>> x86 uses (0x0400000000000000UL) but I don't if it could have any side
>> effect
>> 
>
> Does this change make any sense to you people?

No :)

I think it's just hiding the bug somehow. Presumably we have some code
somewhere that is getting confused by _RPAGE_SW1 being set, or setting
that bit incorrectly.

cheers
