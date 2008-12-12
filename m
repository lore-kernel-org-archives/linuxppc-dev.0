Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 57068DE0D4
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Dec 2008 01:19:18 +1100 (EST)
Message-Id: <A15C72A2-1CEE-4D22-ACA8-F0DA1F04699E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Trent Piepho <tpiepho@freescale.com>
In-Reply-To: <Pine.LNX.4.64.0812120015050.28806@t2.domain.actdsltmp>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: How to support 3GB pci address?
Date: Fri, 12 Dec 2008 08:17:04 -0600
References: <200812112004118902765@gmail.com>
	<41706FC0-B740-42C0-BA2B-B9E4B5839477@kernel.crashing.org>
	<Pine.LNX.4.64.0812111957470.28806@t2.domain.actdsltmp>
	<C2765CC8-2113-4323-9983-FD6E9A357453@kernel.crashing.org>
	<Pine.LNX.4.64.0812120015050.28806@t2.domain.actdsltmp>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	"maillist.kernel" <maillist.kernel@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 12, 2008, at 3:04 AM, Trent Piepho wrote:

> On Thu, 11 Dec 2008, Kumar Gala wrote:
>> On Dec 11, 2008, at 10:07 PM, Trent Piepho wrote:
>>> On Thu, 11 Dec 2008, Kumar Gala wrote:
>>>> On Dec 11, 2008, at 6:04 AM, maillist.kernel wrote:
>>>>> In the system, the total PCI address needed is about 3GB, so I  
>>>>> want to
>>>>> know
>>>>> how to support it in linux. mpc8548 has 36-bit real address, and  
>>>>> can
>>>>> support 32GB PCIE address space, but in linux, there is only 1GB  
>>>>> kernel
>>>>> space, how to map the 3GB pci address to kernel? Is the  36-bit  
>>>>> real
>>>>> address only used to support large memory(>4GB) for muti-threads?
>>>>
>>>> The 36-bit support is current (in tree) in complete.  Work is in  
>>>> progress
>>>> to
>>>> add swiotlb support to PPC which will generically enable what you  
>>>> want to
>>>> accomplish.
>>>
>>> Don't the ATMU windows in the pcie controller serve as a IOMMU,  
>>> making
>>> swiotlb
>>> unnecessary and wasteful?
>>
>> Nope.  You have no way to tell when to switch a window as you have  
>> no idea
>> when a device might DMA data.
>
> Isn't that what dma_alloc_coherent() and dma_map_single() are for?

Nope.  How would manipulate the PCI ATMU?

> It sounded like the original poster was talking about having 3GB of  
> PCI
> BARs.  How does swiotlb even enter the picture for that?

It wasn't clear how much system memory they wanted.  If they can fit  
their entire memory map for PCI addresses in 4G of address space (this  
includes all of system DRAM) than they don't need anything special.

>> From what I've read about swiotlb, it is a hack that allows one to  
>> do DMA
> with 32-bit PCI devices on 64-bit systems that lack an IOMMU.  It  
> reserves
> a large block of RAM under 32-bits (technically it uses GFP_DMA) and  
> doles
> this out to drivers that allocate DMA memory.

correct.  It bounce buffers the DMAs to a 32-bit dma'ble region and  
copies to/from the >32-bit address.

- k
