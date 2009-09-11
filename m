Return-Path: <phazarika@amcc.com>
Received: from sdcmail02.amcc.com (sdcmail02.amcc.com [198.137.200.90])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 39E6DB7088
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 12 Sep 2009 02:05:22 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: AW: PowerPC PCI DMA issues (prefetch/coherency?)
Date: Fri, 11 Sep 2009 09:05:08 -0700
Message-ID: <0CA0A16855646F4FA96D25A158E299D606F6114D@SDCEXCHANGE01.ad.amcc.com>
In-Reply-To: <4AA95941.20506@datacast.com>
References: <1251926572.10090.17.camel@Adam>
	<4A9F78AF.4010206@oxtel.com>	<1251971849.15089.28.camel@pasglop>
	<1251993890.2548.14.camel@Adam>	<0CA0A16855646F4FA96D25A158E299D606F60795@SDCEXCHANGE01.ad.amcc.com>	<1252432873.2548.41.camel@Adam>
	<0CA0A16855646F4FA96D25A158E299D606F60B70@SDCEXCHANGE01.ad.amcc.com>
	<4AA7AD65.7070403@lebon.org.ua> <4AA7B0EC.4000106@datacast.com>
	<4AA7B7EA.2090500@lebon.org.ua> <4AA95941.20506@datacast.com>
From: "Prodyut Hazarika" <phazarika@amcc.com>
To: <tburns@datacast.com>,
	<lebon@lebon.org.ua>
Cc: Andrea Zypchen <azypchen@intldata.ca>, linuxppc-dev@lists.ozlabs.org,
	azilkie@datacast.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> I tried, using our JTAG debugger (BDI3000), to pause operation after=20
> calling dma_alloc_coherent to examine the TLB entry for the memory=20
> returned by the call (which was just past=20
> CONFIG_CONSISTENT_START=3D0xff100000).  The TLB list loaded at the =
time=20
> that I paused operation did not show a mapping for this area.  I guess

> the kernel swaps TLB entries on the fly so it isn't limited to only 64

> entries?  I will try to sleep in the same context as the=20
> dma_alloc_coherent call to try to catch the TLB entry while loaded to=20
> see if it has the I bit set.

> If that fails, any ideas?

Sleeping won't cause the entry to appear at the TLB.
After the dma_alloc call, try to deference the pointer returned.
As a result of the dereference, a DataTLB Miss will happen which will
result in
the appropriate entry put in TLB.
Then do a JTAG break right after the dereference, and you should be able
to see the TLB entry.

Thanks
Prodyut



Mikhail Zolotaryov wrote:
> Hi Tom,
>
> possible solution could be to use tasklet to perform DMA-related job=20
> (as in most cases DMA transfer is interrupt driven - makes sense).
>
>
> Tom Burns wrote:
>> Hi,
>>
>> With the default config for the Sequoia board on 2.6.24, calling=20
>> pci_dma_sync_sg_for_cpu() results in executing
>> invalidate_dcache_range() in arch/ppc/kernel/misc.S from=20
>> __dma_sync().  This OOPses on PPC440 since it tries to call directly=20
>> the assembly instruction dcbi, which can only be executed in=20
>> supervisor mode.  We tried that before resorting to manual cache line

>> management with usermode-safe assembly calls.
>>
>> Regards,
>> Tom Burns
>> International Datacasting Corporation
>>
>> Mikhail Zolotaryov wrote:
>>> Hi,
>>>
>>> Why manage cache lines  manually, if appropriate code is a part of=20
>>> __dma_sync / dma_sync_single_for_device of DMA API ? (implies=20
>>> CONFIG_NOT_COHERENT_CACHE enabled, as default for Sequoia Board)
>>>
>>> Prodyut Hazarika wrote:
>>>> Hi Adam,
>>>>
>>>> =20
>>>>> Yes, I am using the 440EPx (same as the sequoia board). Our=20
>>>>> ideDriver is DMA'ing blocks of 192-byte data over the PCI bus
>>>>>    =20
>>>> (using
>>>> =20
>>>>> the Sil0680A PCI-IDE bridge). Most of the DMA's (depending on
timing)
>>>>> end up being partially corrupted when we try to parse the data in
the
>>>>> virtual page. We have confirmed the data is good before the
PCI-IDE
>>>>> bridge. We are creating two 8K pages and map them to physical DMA
>>>>>    =20
>>>> memory
>>>> =20
>>>>> using single-entry scatter/gather structs. When a DMA block is
>>>>> corrupted, we see a random portion of it (always a multiple of
16byte
>>>>> cache lines) is overwritten with old data from the last time the
>>>>>    =20
>>>> buffer
>>>> =20
>>>>> was used.    =20
>>>>
>>>> This looks like a cache coherency problem.
>>>> Can you ensure that the TLB entries corresponding to the DMA region

>>>> has
>>>> the CacheInhibit bit set.
>>>> You will need a BDI connected to your system.
>>>>
>>>> Also, you will need to invalidate and flush the lines
appropriately,
>>>> since in 440 cores,
>>>> L1Cache coherency is managed entirely by software.
>>>> Please look at drivers/net/ibm_newemac/mal.c and core.c for example
on
>>>> how to do it.
>>>>
>>>> Thanks
>>>> Prodyut
>>>>
>>>> On Thu, 2009-09-03 at 13:27 -0700, Prodyut Hazarika wrote:
>>>> =20
>>>>> Hi Adam,
>>>>>
>>>>> =20
>>>>>> Are you sure there is L2 cache on the 440?
>>>>>>      =20
>>>>> It depends on the SoC you are using. SoC like 460EX (Canyonlands
>>>>>    =20
>>>> board)
>>>> =20
>>>>> have L2Cache.
>>>>> It seems you are using a Sequoia board, which has a 440EPx SoC.=20
>>>>> 440EPx
>>>>> has a 440 cpu core, but no L2Cache.
>>>>> Could you please tell me which SoC you are using?
>>>>> You can also refer to the appropriate dts file to see if there is=20
>>>>> L2C.
>>>>> For example, in canyonlands.dts (460EX based board), we have the
L2C
>>>>> entry.
>>>>>         L2C0: l2c {
>>>>>               ...
>>>>>         }
>>>>>
>>>>> =20
>>>>>> I am seeing this problem with our custom IDE driver which is=20
>>>>>> based on
>>>>>>      =20
>>>>
>>>> =20
>>>>>> pretty old code. Our driver uses pci_alloc_consistent() to
allocate
>>>>>>      =20
>>>> the
>>>> =20
>>>>>> physical DMA memory and alloc_pages() to allocate a virtual page.

>>>>>> It then uses pci_map_sg() to map to a scatter/gather buffer.=20
>>>>>> Perhaps I should convert these to the DMA API calls as you
suggest.
>>>>>>      =20
>>>>> Could you give more details on the consistency problem? It is a
good
>>>>> idea to change to the new DMA APIs, but pci_alloc_consistent()
should
>>>>> work too
>>>>>
>>>>> Thanks
>>>>> Prodyut  On Thu, 2009-09-03 at 19:57 +1000, Benjamin Herrenschmidt

>>>>> wrote:
>>>>> =20
>>>>>> On Thu, 2009-09-03 at 09:05 +0100, Chris Pringle wrote:
>>>>>>   =20
>>>>>>> Hi Adam,
>>>>>>>
>>>>>>> If you have a look in include/asm-ppc/pgtable.h for the
following
>>>>>>>        =20
>>>>> section:
>>>>> =20
>>>>>>> #ifdef CONFIG_44x
>>>>>>> #define _PAGE_BASE    (_PAGE_PRESENT | _PAGE_ACCESSED |
>>>>>>>        =20
>>>>> _PAGE_GUARDED)
>>>>> =20
>>>>>>> #else
>>>>>>> #define _PAGE_BASE    (_PAGE_PRESENT | _PAGE_ACCESSED)
>>>>>>> #endif
>>>>>>>
>>>>>>> Try adding _PAGE_COHERENT to the appropriate line above and see
if
>>>>>>>        =20
>>>>> that =20
>>>>>>> fixes your issue - this causes the 'M' bit to be set on the page
>>>>>>>        =20
>>>>> which =20
>>>>>>> sure enforce cache coherency. If it doesn't, you'll need to
check
>>>>>>>        =20
>>>>> the =20
>>>>>>> 'M' bit isn't being masked out in head_44x.S (it was originally
>>>>>>>        =20
>>>>> masked =20
>>>>>>> out on arch/powerpc, but was fixed in later kernels when the
cache
>>>>>>>        =20
>>>>
>>>> =20
>>>>>>> coherency issues with non-SMP systems were resolved).
>>>>>>>        =20
>>>>>> I have some doubts about the usefulness of doing that for 4xx.
>>>>>>      =20
>>>> AFAIK,
>>>> =20
>>>>>> the 440 core just ignores M.
>>>>>>
>>>>>> The problem lies probably elsewhere. Maybe the L2 cache coherency
>>>>>>      =20
>>>>> isn't
>>>>> =20
>>>>>> enabled or not working ?
>>>>>>
>>>>>> The L1 cache on 440 is simply not coherent, so drivers have to
make
>>>>>>      =20
>>>>> sure
>>>>> =20
>>>>>> they use the appropriate DMA APIs which will do cache flushing
when
>>>>>> needed.
>>>>>>
>>>>>> Adam, what driver is causing you that sort of problems ?
>>>>>>
>>>>>> Cheers,
>>>>>> Ben.
>>>>>>
>>>>>>
>>>>>>      =20
>>>
>>>
>>
>>
>
>
--------------------------------------------------------

CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, =
is for the sole use of the intended recipient(s) and contains =
information that is confidential and proprietary to AppliedMicro =
Corporation or its subsidiaries. It is to be used solely for the purpose =
of furthering the parties' business relationship. All unauthorized =
review, use, disclosure or distribution is prohibited. If you are not =
the intended recipient, please contact the sender by reply e-mail and =
destroy all copies of the original message.
