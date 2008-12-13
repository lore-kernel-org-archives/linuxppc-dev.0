Return-Path: <tpiepho@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7D46BDDF69
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Dec 2008 09:11:54 +1100 (EST)
Date: Sat, 13 Dec 2008 14:11:38 -0800 (PST)
From: Trent Piepho <tpiepho@freescale.com>
To: "maillist.kernel" <maillist.kernel@gmail.com>
Subject: Re: Re: How to support 3GB pci address?
In-Reply-To: <200812131256230461123@gmail.com>
Message-ID: <Pine.LNX.4.64.0812131230290.28806@t2.domain.actdsltmp>
References: <200812112004118902765@gmail.com>,
	<41706FC0-B740-42C0-BA2B-B9E4B5839477@kernel.crashing.org>,
	<Pine.LNX.4.64.0812111957470.28806@t2.domain.actdsltmp>,
	<C2765CC8-2113-4323-9983-FD6E9A357453@kernel.crashing.org>,
	<Pine.LNX.4.64.0812120015050.28806@t2.domain.actdsltmp>,
	<A15C72A2-1CEE-4D22-ACA8-F0DA1F04699E@kernel.crashing.org>,
	<Pine.LNX.4.64.0812121141550.28806@t2.domain.actdsltmp>
	<200812131256230461123@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 13 Dec 2008, maillist.kernel wrote:
> Thanks for all the suggestions and Comments!
> In the system,  the total memory size is less than 4GB.   I want to know how to map the 3GB pci address to the kernel ,
> and how can my driver access all the pci device. Usually we have only 1GB kernel address, minus the 896MB
> for memory map, we can only use the 128M for ioremap. I can adjust the PAGE_OFFSET to a lower value, but it's not enough.

My contract with Freescale is expiring very soon, so you will probably not
be able to reach me at this email address next week.

In order to ioremap() 3GB from the kernel, I think what you'll need to do
is reduce the user task size and low mem size to less than 1 GB.  Set the
custom user task to something like 512MB, set PAGE_OFFSET to whatever the
user task size is, and set maximum low memory to 384 MB.  That should give
you 3.25 GB for kernel ioremap()s.  If your BARs are 3GB total you'll
need a little more than that for other things the kernel will map.  Of
course, the user task size and lowmem size are now rather small....

I've tested ioremap() of a 2GB PCI BAR and I know at least that much can
work.

Current kernels require that PAGE_OFFSET be 256 MB aligned, but I've posted
patches that reduce this requirement.  They've been ignored so far.

>> One can mmap() a PCI BAR from userspace, in which case the mapping comes
>> out of the "max userspace size" pool instead of the "all ioremap()s" pool.
>> The userspace pool is per processes.  So while having four kernel drivers
>> each call ioremap(..., 1GB) will never work, it is possible to have four
>> userspace processes each call mmap("/sys/bus/pci.../resource", 1GB) and
>> have it work.
>
> There are many pci devices in the system and every pci device has only several tens of MB, so how can I call the mmap("/sys/bus/pci.../resource", 1GB)
> and how can I use it by my drivers ?

There are resource files in sysfs for each PCI BAR.  For example, say we
have this device:

00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 MP
         Flags: bus master, 66Mhz, medium devsel, latency 32
 	Memory at e8000000 (32-bit, prefetchable) [size=128M]
 	Memory at e7000000 (32-bit, prefetchable) [size=4K]
 	I/O ports at 1020 [disabled] [size=4]

Then in sysfs we will have these files:
-rw------- root 128M /sys/bus/pci/devices/0000:00:00.0/resource0
-rw------- root 4.0K /sys/bus/pci/devices/0000:00:00.0/resource1
-rw------- root    4 /sys/bus/pci/devices/0000:00:00.0/resource2

A userspace process can use mmap() on them to map the PCI BAR into its
address space.  Because each process get it's own address space, you could
have multiple processes which have mapped a total of more than 4 GB.  But
this is for userspace processes, not the kernel.  The kernel only gets one
address space.

> On Fri, 12 Dec 2008, Kumar Gala wrote:
>> On Dec 12, 2008, at 3:04 AM, Trent Piepho wrote:
>>> On Thu, 11 Dec 2008, Kumar Gala wrote:
>>> > On Dec 11, 2008, at 10:07 PM, Trent Piepho wrote:
>>> > > On Thu, 11 Dec 2008, Kumar Gala wrote:
>>> > > > The 36-bit support is current (in tree) in complete.  Work is in
>>> > > > add swiotlb support to PPC which will generically enable what you
>>> > >
>>> > > Don't the ATMU windows in the pcie controller serve as a IOMMU, making
>>> > > swiotlb
>>> > > unnecessary and wasteful?
>>> >
>>> > Nope.  You have no way to tell when to switch a window as you have no
>>> > idea
>>> > when a device might DMA data.
>>>
>>> Isn't that what dma_alloc_coherent() and dma_map_single() are for?
>>
>> Nope.  How would manipulate the PCI ATMU?
>
> Umm, out_be32()?  Why would it be any different than other iommu
> implementations, like the pseries one for example?
>
> Just define set a of fsl dma ops that use an inbound ATMU window if they
> need to.  The only issue would be if you have a 32-bit device with multiple
> concurrent DMA buffers scattered over  > 32 bits of address space and run
> out of ATMU windows.  But other iommu implementations have that same
> limitation.  You just have to try harder to allocate GFP_DMA memory that
> doesn't need an ATMU window or create larger contiguous bounce buffer to
> replace scattered smaller buffers.
>
>>> It sounded like the original poster was talking about having 3GB of PCI
>>> BARs.  How does swiotlb even enter the picture for that?
>>
>> It wasn't clear how much system memory they wanted.  If they can fit their
>> entire memory map for PCI addresses in 4G of address space (this includes all
>> of system DRAM) than they don't need anything special.
>
> Why the need to fit the entire PCI memory map into the lower 4G?  What
> issue is there with mapping a PCI BAR above 4G if you have 36-bit support?
>
> Putting system memory below 4GB is only an issue if you're talking about
> DMA.  For mapping a PCI BAR, what does it doesn't matter?
>
> The problem I see with having large PCI BARs, is that the max userspace
> process size plus low memory plus all ioremap()s must be less than 4GB.  If
> one wants to call ioremap(..., 3GB), then only 1 GB is left for userspace
> plus low memory.  That's not very much.
>
> One can mmap() a PCI BAR from userspace, in which case the mapping comes
> out of the "max userspace size" pool instead of the "all ioremap()s" pool.
> The userspace pool is per processes.  So while having four kernel drivers
> each call ioremap(..., 1GB) will never work, it is possible to have four
> userspace processes each call mmap("/sys/bus/pci.../resource", 1GB) and
> have it work.
>
>>> >From what I've read about swiotlb, it is a hack that allows one to do DMA
>>> with 32-bit PCI devices on 64-bit systems that lack an IOMMU.  It reserves
>>> a large block of RAM under 32-bits (technically it uses GFP_DMA) and doles
>>> this out to drivers that allocate DMA memory.
>>
>> correct.  It bounce buffers the DMAs to a 32-bit dma'ble region and copies
>> to/from the  >32-bit address.
>
