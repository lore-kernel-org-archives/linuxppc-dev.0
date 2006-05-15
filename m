Return-Path: <jgeissel@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 4218967B41
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 15 May 2006 16:35:51 +1000 (EST)
From: Arno Geissel <jgeissel@gmx.net>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Bigphysarea vs. kernel 2.4.32 and PPC405GPr
Date: Mon, 15 May 2006 08:35:48 +0200
References: <e435rv$62q$1@sea.gmane.org>
In-Reply-To: <e435rv$62q$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200605150835.48745.jgeissel@gmx.net>
Reply-To: jgeissel@gmx.net
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Try

      rc = remap_page_range(vma->vm_start,
 			    virt_to_phys(heap_map_base),
 			    npages*PAGE_SIZE,
 			    vma->vm_page_prot);

Arno

> I'm trying to use the bigphysarea patch to help me allocate big
> physical chunks of memory for use by some custom embedded devices.
> I've applied the bigphysarea-2.4.20 patch and built, no trouble,
> and I've got it to config for my PPC. I can see at boot time that
> the bigphysarea is getting its pages.
>
> I'm trying to use a mmap call to the driver to map a chunk of this
> memory into the process. The mmap for the driver has this:
>
>       pgprot_val(vma->vm_page_prot) |= _PAGE_NO_CACHE;
>       vma->vm_flags |= VM_RESERVED;
>
>       npages = (vma->vm_end - vma->vm_start) / PAGE_SIZE;
>       heap_map_base = bigphysarea_alloc_pages(npages, 1, GFP_KERNEL);
>
>       printk("XXXX Map base=%p, %ld pages\n", heap_map_base, npages);
>
>       rc = remap_page_range(vma->vm_start,
> 			    (unsigned long)heap_map_base,
> 			    npages*PAGE_SIZE,
> 			    vma->vm_page_prot);
>
> The mmap returns without an error, but any access to the mapped
> region gets me an immediate "Oops: machine check, sig: 7". I don't
> see it. Where is the stupid mistake that I'm invariably making?
