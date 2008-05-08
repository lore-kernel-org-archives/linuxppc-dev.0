Return-Path: <dcogley@uslinc.com>
Received: from que11.charter.net (que11.charter.net [209.225.8.21])
	by ozlabs.org (Postfix) with ESMTP id 8F927DDFAB
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 May 2008 03:40:53 +1000 (EST)
Received: from aarprv04.charter.net ([10.20.200.74]) by mta11.charter.net
	(InterMail vM.7.08.03.00 201-2186-126-20070710) with ESMTP
	id <20080508170143.IYH5653.mta11.charter.net@aarprv04.charter.net>
	for <linuxppc-embedded@ozlabs.org>; Thu, 8 May 2008 13:01:43 -0400
Received: from [192.168.1.32] (really [71.93.35.174])
	by aarprv04.charter.net with ESMTP
	id <20080508170142.NBER4495.aarprv04.charter.net@[192.168.1.32]>
	for <linuxppc-embedded@ozlabs.org>; Thu, 8 May 2008 13:01:42 -0400
Subject: Re: mmap problem in device driver and application program.
From: Dave Cogley <dcogley@uslinc.com>
To: linuxppc-embedded@ozlabs.org
In-Reply-To: <BAY138-W55519F961B3A01D0B8A167B2D00@phx.gbl>
References: <BAY138-W55519F961B3A01D0B8A167B2D00@phx.gbl>
Content-Type: text/plain; charset=UTF-8
Date: Thu, 08 May 2008 10:01:49 -0700
Message-Id: <1210266109.3755.8.camel@localhost.localdomain>
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

The address you are passing to mmap is where the pointer will be mapped
in virtual address space. You need to determine the DMA memory address
page number down in the actual mmap call.

int foo_mmap(struct file* filep, struct vm_area_struct* vma)
{
	unsigned long dma_addr = 0x03000000;
	unsigned long dma_size = 0x00200000;
	unsigned long pfn;

	// convert the DMA address to page number
	pfn = virt_to_phys(dma_addr) >> PAGE_SHIFT;

	// remap our page frame to the vma offset
	remap_pfn_range(vma, vma->vm_start, pfn, 
		dma_size, vma->vm_page_prot);
}

Change the address parameter from 0x03000000 to 0:

lut_mem_base = (unsigned int *) mmap(0, LUT_SIZE_IN_BYTE, 
	PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);


Dave

On Thu, 2008-05-08 at 15:33 +0000, MingLiu wrote:
> Dear all,
> I had some problem when I use mmap() file operation in the device
> driver file operation. My situation can be described as:
>  
> 1. I reserve 2MB DDR memory as a look-up-table (LUT) for my customized
> device. The physical start address in the memory is 0x03000000 and the
> size is 2MB. 
>  
> 2. In the device driver, I use mmap file operation to make this memory
> area directly accessible by application programs. In the mmap file
> operation, it looks like:
>  
>   if(remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff, vma->vm_end -
> vma->vm_start, vma->vm_page_prot)){
>      return -EAGAIN;
>    }
>  
> 3. In the application program, I read from a file and initialize the
> LUT area. I use the following sentence to mmap the physical address
> into a virtual one which could be accessed by the application:
>  
>   // the physical address is from 0x03000000 with a size of
> LUT_SIZE_IN_BYTE equal to 2MB
>   lut_mem_base = (unsigned int *) mmap(0, LUT_SIZE_IN_BYTE, PROT_READ
> | PROT_WRITE, MAP_SHARED, fd, 0x03000000);
>  
> Then, I initialize the LUT area with the virtual address specified by
> lut_mem_base. 
>  
>   for(i=0;;i++){
>     fread(&buf, sizeof(unsigned int), 1, fp);
>     *(lut_mem_base + i) = buf;
>     if(feop(fp)){
>        break;
>     }
>   }
>  
> 4. After the initialization of the LUT memory area, in the device
> driver, DMA transfer will be enabled using the physical address of
> 0x03000000 as the source address. The destination is a register in my
> customized device. The data is fed from the memory to my device
> register. 
>  
> HOWEVER, I found that the data fed to the device register is not the
> same as the one used to initialize the LUT memory. Maybe the DMA
> fetches wrong data from different addresses and feeds to my device.
> Since this is my first time to use mmap, I am not self-confident to my
> program, both in the device driver and in the application. Is there
> anything wrong with my mmap part? I will appreciate so much if some
> experts could give me some hints. Thanks in advance.
>  
> BR
> Ming
>  
>  
>  
>  
>  
>  
> 
> 
> ______________________________________________________________________
> Windows Live Writer，支持离线撰写博客内容，随时随地想写就写。 立即使
> 用！
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
