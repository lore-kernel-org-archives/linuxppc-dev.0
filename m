Return-Path: <tpiepho@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1C130DE0C1
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Dec 2008 07:34:21 +1100 (EST)
Date: Fri, 12 Dec 2008 12:34:11 -0800 (PST)
From: Trent Piepho <tpiepho@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: How to support 3GB pci address?
In-Reply-To: <A15C72A2-1CEE-4D22-ACA8-F0DA1F04699E@kernel.crashing.org>
Message-ID: <Pine.LNX.4.64.0812121141550.28806@t2.domain.actdsltmp>
References: <200812112004118902765@gmail.com>
	<41706FC0-B740-42C0-BA2B-B9E4B5839477@kernel.crashing.org>
	<Pine.LNX.4.64.0812111957470.28806@t2.domain.actdsltmp>
	<C2765CC8-2113-4323-9983-FD6E9A357453@kernel.crashing.org>
	<Pine.LNX.4.64.0812120015050.28806@t2.domain.actdsltmp>
	<A15C72A2-1CEE-4D22-ACA8-F0DA1F04699E@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

On Fri, 12 Dec 2008, Kumar Gala wrote:
> On Dec 12, 2008, at 3:04 AM, Trent Piepho wrote:
>> On Thu, 11 Dec 2008, Kumar Gala wrote:
>> > On Dec 11, 2008, at 10:07 PM, Trent Piepho wrote:
>> > > On Thu, 11 Dec 2008, Kumar Gala wrote:
>> > > > The 36-bit support is current (in tree) in complete.  Work is in 
>> > > > add swiotlb support to PPC which will generically enable what you 
>> > > 
>> > > Don't the ATMU windows in the pcie controller serve as a IOMMU, making
>> > > swiotlb
>> > > unnecessary and wasteful?
>> > 
>> > Nope.  You have no way to tell when to switch a window as you have no 
>> > idea
>> > when a device might DMA data.
>> 
>> Isn't that what dma_alloc_coherent() and dma_map_single() are for?
>
> Nope.  How would manipulate the PCI ATMU?

Umm, out_be32()?  Why would it be any different than other iommu
implementations, like the pseries one for example?

Just define set a of fsl dma ops that use an inbound ATMU window if they
need to.  The only issue would be if you have a 32-bit device with multiple
concurrent DMA buffers scattered over > 32 bits of address space and run
out of ATMU windows.  But other iommu implementations have that same
limitation.  You just have to try harder to allocate GFP_DMA memory that
doesn't need an ATMU window or create larger contiguous bounce buffer to
replace scattered smaller buffers.

>> It sounded like the original poster was talking about having 3GB of PCI
>> BARs.  How does swiotlb even enter the picture for that?
>
> It wasn't clear how much system memory they wanted.  If they can fit their 
> entire memory map for PCI addresses in 4G of address space (this includes all 
> of system DRAM) than they don't need anything special.

Why the need to fit the entire PCI memory map into the lower 4G?  What
issue is there with mapping a PCI BAR above 4G if you have 36-bit support?

Putting system memory below 4GB is only an issue if you're talking about
DMA.  For mapping a PCI BAR, what does it doesn't matter?

The problem I see with having large PCI BARs, is that the max userspace
process size plus low memory plus all ioremap()s must be less than 4GB.  If
one wants to call ioremap(..., 3GB), then only 1 GB is left for userspace
plus low memory.  That's not very much.

One can mmap() a PCI BAR from userspace, in which case the mapping comes
out of the "max userspace size" pool instead of the "all ioremap()s" pool. 
The userspace pool is per processes.  So while having four kernel drivers
each call ioremap(..., 1GB) will never work, it is possible to have four
userspace processes each call mmap("/sys/bus/pci.../resource", 1GB) and
have it work.

>> >From what I've read about swiotlb, it is a hack that allows one to do DMA
>> with 32-bit PCI devices on 64-bit systems that lack an IOMMU.  It reserves
>> a large block of RAM under 32-bits (technically it uses GFP_DMA) and doles
>> this out to drivers that allocate DMA memory.
>
> correct.  It bounce buffers the DMAs to a 32-bit dma'ble region and copies 
> to/from the >32-bit address.
