Return-Path: <tburns@datacast.com>
Received: from datacast.com (mail.datacast.com [209.87.232.171])
	by bilbo.ozlabs.org (Postfix) with ESMTP id B4C49B7067
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 12 Sep 2009 00:01:36 +1000 (EST)
Received: from [192.168.2.31] by datacast.com (MDaemon PRO v9.6.1)
	with ESMTP id md50001441186.msg
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2009 09:56:38 -0400
Message-ID: <4AAA55CA.1050206@datacast.com>
Date: Fri, 11 Sep 2009 09:51:06 -0400
From: Tom Burns <tburns@datacast.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: AW: PowerPC PCI DMA issues (prefetch/coherency?)
References: <1251926572.10090.17.camel@Adam> <4A9F78AF.4010206@oxtel.com>	
	<1251971849.15089.28.camel@pasglop>
	<1251993890.2548.14.camel@Adam>	
	<0CA0A16855646F4FA96D25A158E299D606F60795@SDCEXCHANGE01.ad.amcc.com>	
	<1252432873.2548.41.camel@Adam>	
	<0CA0A16855646F4FA96D25A158E299D606F60B70@SDCEXCHANGE01.ad.amcc.com>	
	<4AA7AD65.7070403@lebon.org.ua> <4AA7B0EC.4000106@datacast.com>
	<1252634148.8566.11.camel@pasglop>
In-Reply-To: <1252634148.8566.11.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Prodyut Hazarika <phazarika@amcc.com>,
	Andrea Zypchen <azypchen@intldata.ca>,
	linuxppc-dev@lists.ozlabs.org, azilkie@datacast.com, lebon@lebon.org.ua
Reply-To: tburns@datacast.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

Benjamin Herrenschmidt wrote:
> On Wed, 2009-09-09 at 09:43 -0400, Tom Burns wrote:
>   
>> Hi,
>>
>> With the default config for the Sequoia board on 2.6.24, calling 
>> pci_dma_sync_sg_for_cpu() results in executing
>> invalidate_dcache_range() in arch/ppc/kernel/misc.S from __dma_sync().  
>> This OOPses on PPC440 since it tries to call directly the assembly 
>> instruction dcbi, which can only be executed in supervisor mode.  We 
>> tried that before resorting to manual cache line management with 
>> usermode-safe assembly calls.
>>     
>
> Wait a minute.... usermode ? You are doing all of that from userspace ?
> I don't understand the story here. You can't call all those kernel APIs
> form userspace in the first place, indeed... But then an IDE driver has
> nothing to do in userspace neither.
>   
Sorry, I was referring to whether or not the CPU is in supervisor mode. 
Our code is all in the kernel, not userspace :).  I can see now from the 
value of MSR at the time of the OOPS that the processor was in 
supervisor mode, I missed that earlier.  Looks like you're right about 
the bad address, I will investigate.

Thanks,
Tom

> Cheers,
> Ben.
>
>   
>> Regards,
>> Tom Burns
>> International Datacasting Corporation
>>
>> Mikhail Zolotaryov wrote:
>>     
>>> Hi,
>>>
>>> Why manage cache lines  manually, if appropriate code is a part of 
>>> __dma_sync / dma_sync_single_for_device of DMA API ? (implies 
>>> CONFIG_NOT_COHERENT_CACHE enabled, as default for Sequoia Board)
>>>
>>> Prodyut Hazarika wrote:
>>>       
>>>> Hi Adam,
>>>>
>>>>  
>>>>         
>>>>> Yes, I am using the 440EPx (same as the sequoia board). Our 
>>>>> ideDriver is DMA'ing blocks of 192-byte data over the PCI bus
>>>>>     
>>>>>           
>>>> (using
>>>>  
>>>>         
>>>>> the Sil0680A PCI-IDE bridge). Most of the DMA's (depending on timing)
>>>>> end up being partially corrupted when we try to parse the data in the
>>>>> virtual page. We have confirmed the data is good before the PCI-IDE
>>>>> bridge. We are creating two 8K pages and map them to physical DMA
>>>>>     
>>>>>           
>>>> memory
>>>>  
>>>>         
>>>>> using single-entry scatter/gather structs. When a DMA block is
>>>>> corrupted, we see a random portion of it (always a multiple of 16byte
>>>>> cache lines) is overwritten with old data from the last time the
>>>>>     
>>>>>           
>>>> buffer
>>>>  
>>>>         
>>>>> was used.     
>>>>>           
>>>> This looks like a cache coherency problem.
>>>> Can you ensure that the TLB entries corresponding to the DMA region has
>>>> the CacheInhibit bit set.
>>>> You will need a BDI connected to your system.
>>>>
>>>> Also, you will need to invalidate and flush the lines appropriately,
>>>> since in 440 cores,
>>>> L1Cache coherency is managed entirely by software.
>>>> Please look at drivers/net/ibm_newemac/mal.c and core.c for example on
>>>> how to do it.
>>>>
>>>> Thanks
>>>> Prodyut
>>>>
>>>> On Thu, 2009-09-03 at 13:27 -0700, Prodyut Hazarika wrote:
>>>>  
>>>>         
>>>>> Hi Adam,
>>>>>
>>>>>    
>>>>>           
>>>>>> Are you sure there is L2 cache on the 440?
>>>>>>       
>>>>>>             
>>>>> It depends on the SoC you are using. SoC like 460EX (Canyonlands
>>>>>     
>>>>>           
>>>> board)
>>>>  
>>>>         
>>>>> have L2Cache.
>>>>> It seems you are using a Sequoia board, which has a 440EPx SoC. 440EPx
>>>>> has a 440 cpu core, but no L2Cache.
>>>>> Could you please tell me which SoC you are using?
>>>>> You can also refer to the appropriate dts file to see if there is L2C.
>>>>> For example, in canyonlands.dts (460EX based board), we have the L2C
>>>>> entry.
>>>>>         L2C0: l2c {
>>>>>               ...
>>>>>         }
>>>>>
>>>>>    
>>>>>           
>>>>>> I am seeing this problem with our custom IDE driver which is based on
>>>>>>       
>>>>>>             
>>>>  
>>>>         
>>>>>> pretty old code. Our driver uses pci_alloc_consistent() to allocate
>>>>>>       
>>>>>>             
>>>> the
>>>>  
>>>>         
>>>>>> physical DMA memory and alloc_pages() to allocate a virtual page. 
>>>>>> It then uses pci_map_sg() to map to a scatter/gather buffer. 
>>>>>> Perhaps I should convert these to the DMA API calls as you suggest.
>>>>>>       
>>>>>>             
>>>>> Could you give more details on the consistency problem? It is a good
>>>>> idea to change to the new DMA APIs, but pci_alloc_consistent() should
>>>>> work too
>>>>>
>>>>> Thanks
>>>>> Prodyut   
>>>>>
>>>>> On Thu, 2009-09-03 at 19:57 +1000, Benjamin Herrenschmidt wrote:
>>>>>    
>>>>>           
>>>>>> On Thu, 2009-09-03 at 09:05 +0100, Chris Pringle wrote:
>>>>>>      
>>>>>>             
>>>>>>> Hi Adam,
>>>>>>>
>>>>>>> If you have a look in include/asm-ppc/pgtable.h for the following
>>>>>>>         
>>>>>>>               
>>>>> section:
>>>>>    
>>>>>           
>>>>>>> #ifdef CONFIG_44x
>>>>>>> #define _PAGE_BASE    (_PAGE_PRESENT | _PAGE_ACCESSED |
>>>>>>>         
>>>>>>>               
>>>>> _PAGE_GUARDED)
>>>>>    
>>>>>           
>>>>>>> #else
>>>>>>> #define _PAGE_BASE    (_PAGE_PRESENT | _PAGE_ACCESSED)
>>>>>>> #endif
>>>>>>>
>>>>>>> Try adding _PAGE_COHERENT to the appropriate line above and see if
>>>>>>>         
>>>>>>>               
>>>>> that    
>>>>>           
>>>>>>> fixes your issue - this causes the 'M' bit to be set on the page
>>>>>>>         
>>>>>>>               
>>>>> which    
>>>>>           
>>>>>>> sure enforce cache coherency. If it doesn't, you'll need to check
>>>>>>>         
>>>>>>>               
>>>>> the    
>>>>>           
>>>>>>> 'M' bit isn't being masked out in head_44x.S (it was originally
>>>>>>>         
>>>>>>>               
>>>>> masked    
>>>>>           
>>>>>>> out on arch/powerpc, but was fixed in later kernels when the cache
>>>>>>>         
>>>>>>>               
>>>>  
>>>>         
>>>>>>> coherency issues with non-SMP systems were resolved).
>>>>>>>         
>>>>>>>               
>>>>>> I have some doubts about the usefulness of doing that for 4xx.
>>>>>>       
>>>>>>             
>>>> AFAIK,
>>>>  
>>>>         
>>>>>> the 440 core just ignores M.
>>>>>>
>>>>>> The problem lies probably elsewhere. Maybe the L2 cache coherency
>>>>>>       
>>>>>>             
>>>>> isn't
>>>>>    
>>>>>           
>>>>>> enabled or not working ?
>>>>>>
>>>>>> The L1 cache on 440 is simply not coherent, so drivers have to make
>>>>>>       
>>>>>>             
>>>>> sure
>>>>>    
>>>>>           
>>>>>> they use the appropriate DMA APIs which will do cache flushing when
>>>>>> needed.
>>>>>>
>>>>>> Adam, what driver is causing you that sort of problems ?
>>>>>>
>>>>>> Cheers,
>>>>>> Ben.
>>>>>>
>>>>>>
>>>>>>       
>>>>>>             
>>>       
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>>     
>
>
>
>   
