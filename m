Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 31AB267A3D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 May 2006 03:08:41 +1000 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FgPVY-0007vb-3o
	for linuxppc-embedded@ozlabs.org; Wed, 17 May 2006 19:08:24 +0200
Received: from icarus.icarus.com ([64.105.89.2])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Wed, 17 May 2006 19:08:24 +0200
Received: from steve by icarus.icarus.com with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Wed, 17 May 2006 19:08:24 +0200
To: linuxppc-embedded@ozlabs.org
From: Stephen Williams <steve@icarus.com>
Subject: Re: Bigphysarea vs. kernel 2.4.32 and PPC405GPr
Date: Wed, 17 May 2006 10:07:57 -0700
Message-ID: <e4fl9d$rka$1@sea.gmane.org>
References: <e435rv$62q$1@sea.gmane.org> <200605150835.48745.jgeissel@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
In-Reply-To: <200605150835.48745.jgeissel@gmx.net>
Sender: news <news@sea.gmane.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


That works nicely, thanks. I was under the mistaken impression that
the bigphysarea routines returned a physical address.

So now I can report that the bigphysarea patch works great on PPC
kernels 2.4.32+

Arno Geissel wrote:
> Try
> 
>       rc = remap_page_range(vma->vm_start,
>  			    virt_to_phys(heap_map_base),
>  			    npages*PAGE_SIZE,
>  			    vma->vm_page_prot);
> 
> Arno
> 
>> I'm trying to use the bigphysarea patch to help me allocate big
>> physical chunks of memory for use by some custom embedded devices.
>> I've applied the bigphysarea-2.4.20 patch and built, no trouble,
>> and I've got it to config for my PPC. I can see at boot time that
>> the bigphysarea is getting its pages.
>>
>> I'm trying to use a mmap call to the driver to map a chunk of this
>> memory into the process. The mmap for the driver has this:
>>
>>       pgprot_val(vma->vm_page_prot) |= _PAGE_NO_CACHE;
>>       vma->vm_flags |= VM_RESERVED;
>>
>>       npages = (vma->vm_end - vma->vm_start) / PAGE_SIZE;
>>       heap_map_base = bigphysarea_alloc_pages(npages, 1, GFP_KERNEL);
>>
>>       printk("XXXX Map base=%p, %ld pages\n", heap_map_base, npages);
>>
>>       rc = remap_page_range(vma->vm_start,
>> 			    (unsigned long)heap_map_base,
>> 			    npages*PAGE_SIZE,
>> 			    vma->vm_page_prot);
>>
>> The mmap returns without an error, but any access to the mapped
>> region gets me an immediate "Oops: machine check, sig: 7". I don't
>> see it. Where is the stupid mistake that I'm invariably making?


-- 
Steve Williams                "The woods are lovely, dark and deep.
steve at icarus.com           But I have promises to keep,
http://www.icarus.com         and lines to code before I sleep,
http://www.picturel.com       And lines to code before I sleep."
