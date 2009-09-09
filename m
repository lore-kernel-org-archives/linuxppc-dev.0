Return-Path: <lebon@lebon.org.ua>
Received: from b-mail.com.ua (b-mail.com.ua [195.68.202.242])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 2BD13B6F34
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Sep 2009 00:40:31 +1000 (EST)
Message-ID: <4AA7BE5A.2070507@lebon.org.ua>
Date: Wed, 09 Sep 2009 17:40:26 +0300
From: Mikhail Zolotaryov <lebon@lebon.org.ua>
MIME-Version: 1.0
To: tburns@datacast.com
Subject: Re: AW: PowerPC PCI DMA issues (prefetch/coherency?)
References: <1251926572.10090.17.camel@Adam>
	<4A9F78AF.4010206@oxtel.com>	<1251971849.15089.28.camel@pasglop>
	<1251993890.2548.14.camel@Adam>	<0CA0A16855646F4FA96D25A158E299D606F60795@SDCEXCHANGE01.ad.amcc.com>	<1252432873.2548.41.camel@Adam>
	<0CA0A16855646F4FA96D25A158E299D606F60B70@SDCEXCHANGE01.ad.amcc.com>
	<4AA7AD65.7070403@lebon.org.ua> <4AA7B0EC.4000106@datacast.com>
	<4AA7B7EA.2090500@lebon.org.ua> <4AA7B766.2040501@datacast.com>
In-Reply-To: <4AA7B766.2040501@datacast.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Prodyut Hazarika <phazarika@amcc.com>,
	Andrea Zypchen <azypchen@intldata.ca>,
	linuxppc-dev@lists.ozlabs.org, azilkie@datacast.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Tom,

In my case __dma_sync() calls flush_dcache_range() (it's due to 
alignment) from a tasklet - no OOPS. It uses dcbf instruction instead of 
dcbi - that's the difference as dcbf is not privileged.

Tom Burns wrote:
> Hi Mikhail,
>
> Sorry, this DMA code is in a tasklet.  Are you suggesting the 
> processor is in supervisor mode at that time?  Calling 
> pci_dma_sync_sg_for_cpu() from the tasklet context is what generates 
> the OOPS.  The entire oops is as follows, if it's relevant:
>
> Oops: kernel access of bad area, sig: 11 [#1]
> NIP: c0003ab0 LR: c0010c30 CTR: 02400001
> REGS: df117bd0 TRAP: 0300   Tainted: P         (2.6.24.2)
> MSR: 00029000 <EE,ME>  CR: 44224042  XER: 20000000
> DEAR: 3fd39000, ESR: 00800000
> TASK = de5db7d0[157] 'cat' THREAD: df116000
> GPR00: e11e5854 df117c80 de5db7d0 3fd39000 02400001 0000001f 00000002
> 0079a169
> GPR08: 00000001 c0310000 00000000 c0010c84 24224042 101c0dac c0310000
> 10177000
> GPR16: deb14200 df116000 e12062d0 e11f6104 de0f16c0 e11f0000 c0310000
> e11f59cc
> GPR24: e11f62d0 e11f0000 e11f0000 00000000 00000002 defee014 3fd39008
> 87d39009
> NIP [c0003ab0] invalidate_dcache_range+0x1c/0x30
> LR [c0010c30] __dma_sync+0x58/0xac
> Call Trace:
> [df117c80] [0000000a] 0xa (unreliable)
> [df117c90] [e11e5854] DoTasklet+0x67c/0xc90 [ideDriverDuo_cyph]
> [df117ce0] [c001ee24] tasklet_action+0x60/0xcc
> [df117cf0] [c001ef04] __do_softirq+0x74/0xe0
> [df117d10] [c00067a8] do_softirq+0x54/0x58
> [df117d20] [c001edb4] irq_exit+0x48/0x58
> [df117d30] [c00069d0] do_IRQ+0x6c/0xc0
> [df117d40] [c00020e0] ret_from_except+0x0/0x18
> [df117e00] [c00501e0] unmap_vmas+0x2c4/0x560
> [df117e90] [c0053ebc] exit_mmap+0x64/0xec
> [df117ec0] [c00171ac] mmput+0x50/0xd4
> [df117ed0] [c001aef8] exit_mm+0x80/0xe0
> [df117ef0] [c001c818] do_exit+0x134/0x6f8
> [df117f30] [c001ce14] do_group_exit+0x38/0x74
> [df117f40] [c0001a80] ret_from_syscall+0x0/0x3c
> Instruction dump:
> 7c0018ac 38630020 4200fff8 7c0004ac 4e800020 38a0001f 7c632878 7c832050
> 7c842a14 5484d97f 4d820020 7c8903a6 <7c001bac> 38630020 4200fff8
> 7c0004ac
> Kernel panic - not syncing: Aiee, killing interrupt handler!
> Rebooting in 180 seconds..
>
>
> Cheers,
> Tom
>
> Mikhail Zolotaryov wrote:
>> Hi Tom,
>>
>> possible solution could be to use tasklet to perform DMA-related job 
>> (as in most cases DMA transfer is interrupt driven - makes sense).
>>
>>
>> Tom Burns wrote:
>>> Hi,
>>>
>>> With the default config for the Sequoia board on 2.6.24, calling 
>>> pci_dma_sync_sg_for_cpu() results in executing
>>> invalidate_dcache_range() in arch/ppc/kernel/misc.S from 
>>> __dma_sync().  This OOPses on PPC440 since it tries to call directly 
>>> the assembly instruction dcbi, which can only be executed in 
>>> supervisor mode.  We tried that before resorting to manual cache 
>>> line management with usermode-safe assembly calls.
>>>
>>> Regards,
>>> Tom Burns
>>> International Datacasting Corporation
>>>
>>> Mikhail Zolotaryov wrote:
>>>> Hi,
>>>>
>>>> Why manage cache lines  manually, if appropriate code is a part of 
>>>> __dma_sync / dma_sync_single_for_device of DMA API ? (implies 
>>>> CONFIG_NOT_COHERENT_CACHE enabled, as default for Sequoia Board)
>>>>
>>>> Prodyut Hazarika wrote:
>>>>> Hi Adam,
>>>>>
>>>>>  
>>>>>> Yes, I am using the 440EPx (same as the sequoia board). Our 
>>>>>> ideDriver is DMA'ing blocks of 192-byte data over the PCI bus
>>>>>>     
>>>>> (using
>>>>>  
>>>>>> the Sil0680A PCI-IDE bridge). Most of the DMA's (depending on 
>>>>>> timing)
>>>>>> end up being partially corrupted when we try to parse the data in 
>>>>>> the
>>>>>> virtual page. We have confirmed the data is good before the PCI-IDE
>>>>>> bridge. We are creating two 8K pages and map them to physical DMA
>>>>>>     
>>>>> memory
>>>>>  
>>>>>> using single-entry scatter/gather structs. When a DMA block is
>>>>>> corrupted, we see a random portion of it (always a multiple of 
>>>>>> 16byte
>>>>>> cache lines) is overwritten with old data from the last time the
>>>>>>     
>>>>> buffer
>>>>>  
>>>>>> was used.     
>>>>>
>>>>> This looks like a cache coherency problem.
>>>>> Can you ensure that the TLB entries corresponding to the DMA 
>>>>> region has
>>>>> the CacheInhibit bit set.
>>>>> You will need a BDI connected to your system.
>>>>>
>>>>> Also, you will need to invalidate and flush the lines appropriately,
>>>>> since in 440 cores,
>>>>> L1Cache coherency is managed entirely by software.
>>>>> Please look at drivers/net/ibm_newemac/mal.c and core.c for 
>>>>> example on
>>>>> how to do it.
>>>>>
>>>>> Thanks
>>>>> Prodyut
>>>>>
>>>>> On Thu, 2009-09-03 at 13:27 -0700, Prodyut Hazarika wrote:
>>>>>  
>>>>>> Hi Adam,
>>>>>>
>>>>>>  
>>>>>>> Are you sure there is L2 cache on the 440?
>>>>>>>       
>>>>>> It depends on the SoC you are using. SoC like 460EX (Canyonlands
>>>>>>     
>>>>> board)
>>>>>  
>>>>>> have L2Cache.
>>>>>> It seems you are using a Sequoia board, which has a 440EPx SoC. 
>>>>>> 440EPx
>>>>>> has a 440 cpu core, but no L2Cache.
>>>>>> Could you please tell me which SoC you are using?
>>>>>> You can also refer to the appropriate dts file to see if there is 
>>>>>> L2C.
>>>>>> For example, in canyonlands.dts (460EX based board), we have the L2C
>>>>>> entry.
>>>>>>         L2C0: l2c {
>>>>>>               ...
>>>>>>         }
>>>>>>
>>>>>>  
>>>>>>> I am seeing this problem with our custom IDE driver which is 
>>>>>>> based on
>>>>>>>       
>>>>>
>>>>>  
>>>>>>> pretty old code. Our driver uses pci_alloc_consistent() to allocate
>>>>>>>       
>>>>> the
>>>>>  
>>>>>>> physical DMA memory and alloc_pages() to allocate a virtual 
>>>>>>> page. It then uses pci_map_sg() to map to a scatter/gather 
>>>>>>> buffer. Perhaps I should convert these to the DMA API calls as 
>>>>>>> you suggest.
>>>>>>>       
>>>>>> Could you give more details on the consistency problem? It is a good
>>>>>> idea to change to the new DMA APIs, but pci_alloc_consistent() 
>>>>>> should
>>>>>> work too
>>>>>>
>>>>>> Thanks
>>>>>> Prodyut  On Thu, 2009-09-03 at 19:57 +1000, Benjamin 
>>>>>> Herrenschmidt wrote:
>>>>>>  
>>>>>>> On Thu, 2009-09-03 at 09:05 +0100, Chris Pringle wrote:
>>>>>>>   
>>>>>>>> Hi Adam,
>>>>>>>>
>>>>>>>> If you have a look in include/asm-ppc/pgtable.h for the following
>>>>>>>>         
>>>>>> section:
>>>>>>  
>>>>>>>> #ifdef CONFIG_44x
>>>>>>>> #define _PAGE_BASE    (_PAGE_PRESENT | _PAGE_ACCESSED |
>>>>>>>>         
>>>>>> _PAGE_GUARDED)
>>>>>>  
>>>>>>>> #else
>>>>>>>> #define _PAGE_BASE    (_PAGE_PRESENT | _PAGE_ACCESSED)
>>>>>>>> #endif
>>>>>>>>
>>>>>>>> Try adding _PAGE_COHERENT to the appropriate line above and see if
>>>>>>>>         
>>>>>> that 
>>>>>>>> fixes your issue - this causes the 'M' bit to be set on the page
>>>>>>>>         
>>>>>> which 
>>>>>>>> sure enforce cache coherency. If it doesn't, you'll need to check
>>>>>>>>         
>>>>>> the 
>>>>>>>> 'M' bit isn't being masked out in head_44x.S (it was originally
>>>>>>>>         
>>>>>> masked 
>>>>>>>> out on arch/powerpc, but was fixed in later kernels when the cache
>>>>>>>>         
>>>>>
>>>>>  
>>>>>>>> coherency issues with non-SMP systems were resolved).
>>>>>>>>         
>>>>>>> I have some doubts about the usefulness of doing that for 4xx.
>>>>>>>       
>>>>> AFAIK,
>>>>>  
>>>>>>> the 440 core just ignores M.
>>>>>>>
>>>>>>> The problem lies probably elsewhere. Maybe the L2 cache coherency
>>>>>>>       
>>>>>> isn't
>>>>>>  
>>>>>>> enabled or not working ?
>>>>>>>
>>>>>>> The L1 cache on 440 is simply not coherent, so drivers have to make
>>>>>>>       
>>>>>> sure
>>>>>>  
>>>>>>> they use the appropriate DMA APIs which will do cache flushing when
>>>>>>> needed.
>>>>>>>
>>>>>>> Adam, what driver is causing you that sort of problems ?
>>>>>>>
>>>>>>> Cheers,
>>>>>>> Ben.
>>>>>>>
>>>>>>>
>>>>>>>       
>>>>
>>>>
>>>
>>>
>>
>>
>
>
