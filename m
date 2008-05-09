Return-Path: <dcogley@uslinc.com>
Received: from mta21.charter.net (mta21.charter.net [216.33.127.81])
	by ozlabs.org (Postfix) with ESMTP id 40729DDF45
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 10 May 2008 06:55:54 +1000 (EST)
Received: from aarprv04.charter.net ([10.20.200.74]) by mta21.charter.net
	(InterMail vM.7.08.03.00 201-2186-126-20070710) with ESMTP
	id <20080509205542.DOWT23078.mta21.charter.net@aarprv04.charter.net>
	for <linuxppc-embedded@ozlabs.org>; Fri, 9 May 2008 16:55:42 -0400
Received: from [192.168.1.32] (really [71.93.35.174])
	by aarprv04.charter.net with ESMTP
	id <20080509205542.IMPC4495.aarprv04.charter.net@[192.168.1.32]>
	for <linuxppc-embedded@ozlabs.org>; Fri, 9 May 2008 16:55:42 -0400
Subject: RE: mmap problem in device driver and application program.
From: Dave Cogley <dcogley@uslinc.com>
To: linuxppc-embedded@ozlabs.org
In-Reply-To: <BAY138-W36C7249F532D111A1DC508B2D00@phx.gbl>
References: <BAY138-W55519F961B3A01D0B8A167B2D00@phx.gbl>
	<1210266109.3755.8.camel@localhost.localdomain>
	<BAY138-W36C7249F532D111A1DC508B2D00@phx.gbl>
Content-Type: text/plain; charset=UTF-8
Date: Fri, 09 May 2008 13:55:52 -0700
Message-Id: <1210366552.3755.21.camel@localhost.localdomain>
Mime-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> Shall I use virt_to_phys? dma_addr is already exactly physical address
> which is used to initiate DMA transfers. 

Is the physical memory outside of the reach of the kernel? If it is
under control of the kernel memory management you will need to ioremap
it. This will return a kernel virtual address which will need to be
converted to a physical address and further convert to a page number.
remap_pfn_range only works on page numbers not physical addresses.

So I guess it would look something like this:

int foo_mmap(struct file* filep, struct vm_area_struct* vma)
{
	unsigned long dma_addr = ioremap(0x03000000);
	unsigned long dma_size = 0x00200000;
	unsigned long pfn;

	// convert the DMA address to page number
	pfn = virt_to_phys(dma_addr) >> PAGE_SHIFT;

	...
}

If you are using memory that is not under the kernel's memory management
you will need to use something other than remap_pfn_range.

Dave

On Thu, 2008-05-08 at 18:42 +0000, MingLiu wrote:
> Dear Dave,
>  
> Thanks for your answer first. However I am very confused. It seems
> that I understand the memory-mapping-related functions completely
> wrong. Here comes more questions. 
> 
> 
> > The address you are passing to mmap is where the pointer will be
> mapped
> > in virtual address space. You need to determine the DMA memory
> address
> > page number down in the actual mmap call.
> > 
> > int foo_mmap(struct file* filep, struct vm_area_struct* vma)
> > {
> > unsigned long dma_addr = 0x03000000;
> > unsigned long dma_size = 0x00200000;
> > unsigned long pfn;
> > 
> > // convert the DMA address to page number
> > pfn = virt_to_phys(dma_addr) >> PAGE_SHIFT;
> 
> Shall I use virt_to_phys? dma_addr is already exactly physical address
> which is used to initiate DMA transfers. 
>  
> > // remap our page frame to the vma offset
> > remap_pfn_range(vma, vma->vm_start, pfn, 
> > dma_size, vma->vm_page_prot);
> > }
> > 
> > Change the address parameter from 0x03000000 to 0:
> > 
> > lut_mem_base = (unsigned int *) mmap(0, LUT_SIZE_IN_BYTE, 
> > PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> 
> Previously I used "remap_page_range(vma, vma->vm_start, physical_addr,
> vm_size, vma->vm_page_prot)" in the device driver, where physical_addr
> is 0x03000000. In the application program, I used "lut_mem_base =
> (unsigned int *) mmap(0, LUT_SIZE_IN_BYTE, PROT_READ | PROT_WRITE,
> MAP_SHARED, fd, 0);". I think it is correct but it doesn't work. I
> heard that in the new kernels, remap_page_range is not supported any
> more. However when I compile the driver, nothing was shown to complain
> that. I am using 2.6.10 kernel. Any hint for this?
>  
> Thank you for your help to make me understand. 
>  
> BR
> Ming
> 
> 
> ______________________________________________________________________
> 使用新一代 Windows Live Messenger 轻松交流和共享！ 立即体验！
