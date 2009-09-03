Return-Path: <chris.pringle@oxtel.com>
Received: from oxtel.com (mail.oxtel.com [193.200.114.15])
	by bilbo.ozlabs.org (Postfix) with ESMTP id AA0FFB7088
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Sep 2009 22:45:57 +1000 (EST)
Message-ID: <4A9FBA07.4050804@oxtel.com>
Date: Thu, 03 Sep 2009 13:43:51 +0100
From: Chris Pringle <chris.pringle@oxtel.com>
MIME-Version: 1.0
To: Wrobel Heinz-R39252 <Heinz.Wrobel@freescale.com>
Subject: Re: AW: PowerPC PCI DMA issues (prefetch/coherency?)
References: <1251926572.10090.17.camel@Adam> <4A9F78AF.4010206@oxtel.com>
	<AAE514D00E55E6438B7F5186462A545202750F9B@zuk35exm20.fsl.freescale.net>
In-Reply-To: <AAE514D00E55E6438B7F5186462A545202750F9B@zuk35exm20.fsl.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Tom Burns <tburns@datacast.com>, Andrea Zypchen <azypchen@intldata.ca>,
	linuxppc-dev@lists.ozlabs.org, azilkie@datacast.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In our case, we were suffering coherency issues on an 8260 when using 
DMA with PCI. Setting the 'M' bit cured all of our DMA coherency issues.

There is a comment in "pgtable-ppc32.h" on 2.6.29.6 that says:
"We always set _PAGE_COHERENT when SMP is enabled *or* the processor 
might need it for DMA coherency". Freescale had also suggested setting 
the 'M' bit when we submitted a support request.

I've no idea how this bit affects other PowerPC chips. Looking briefly 
through some of the header files, it looks as if the 'M' bit should not 
be set for 44x, so the issue is probably not the same as the one I had.

Cheers,
Chris

Wrobel Heinz-R39252 wrote:
> Hi,
>
> This doesn't seem right. If we are talking about a single CPU core chip,
> i.e., just one data cache, then setting M is typically a) useless and
> could even b) cause a performance penalty depending on a chip's
> implementation.
> The M bit is required if *other* cores with caches need to see changes
> for coherency of their caches. You wouldn't set it for one core only
> because your own core knows about its own cache.
> The possible performance penalty could happen because you need some way
> to tell the others that they better intercept a transaction. And that
> could, depending on the chip, by a clock extra or so per transaction.
> Now, in theory, a DMA engine could have caches, read from cache content
> first, and could snoop the bus on global transactions like another core,
> but I have never heard of such a beast. 
>
> Hope this helps,
>
> Heinz
>
> -----Original Message-----
> From: linuxppc-dev-bounces+heinz.wrobel=freescale.com@lists.ozlabs.org
> [mailto:linuxppc-dev-bounces+heinz.wrobel=freescale.com@lists.ozlabs.org
> ] On Behalf Of Chris Pringle
> Sent: Donnerstag, 3. September 2009 10:05
> To: azilkie@datacast.com
> Cc: Tom Burns; Andrea Zypchen; linuxppc-dev@lists.ozlabs.org
> Subject: Re: AW: PowerPC PCI DMA issues (prefetch/coherency?)
>
> Hi Adam,
>
> If you have a look in include/asm-ppc/pgtable.h for the following
> section:
> #ifdef CONFIG_44x
> #define _PAGE_BASE    (_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_GUARDED)
> #else
> #define _PAGE_BASE    (_PAGE_PRESENT | _PAGE_ACCESSED)
> #endif
>
> Try adding _PAGE_COHERENT to the appropriate line above and see if that
> fixes your issue - this causes the 'M' bit to be set on the page which
> sure enforce cache coherency. If it doesn't, you'll need to check the
> 'M' bit isn't being masked out in head_44x.S (it was originally masked
> out on arch/powerpc, but was fixed in later kernels when the cache
> coherency issues with non-SMP systems were resolved).
>
> The patch I had fixed two problems on 2.6.26 for 'powerpc':
> 1) It stopped the 'M' bit being masked out (head_32.S)
> 2) It set the cache coherency ('M' bit) flag on each page table entry
> (pgtable-ppc32.h)
>
> Hope this helps!
>
> Cheers,
> Chris
>
> Adam Zilkie wrote:
>   
>> Hi Chris,
>>
>> I am having a problem similar to what you described in this
>>     
> discussion.
>   
>> We are using the ppc arch with 2.6.24 with CONFIG_SEQUOIA with 
>> compiles arch/ppc/kernel/head_44x.c (quite different from 
>> /arch/powerpc/kernel/head_32.S). I would like to apply your 
>> backporting patch to this architecture. Any help would be appreciated.
>>
>> Regards,
>> Adam
>>
>>   
>>     
>
>
>   
____________________________

Miranda Technologies Limited
Registered in England and Wales CN 02017053
Registered Office: James House, Mere Park, Dedmere Road, Marlow, Bucks, SL7 1FJ
