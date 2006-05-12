Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E4A75679E6
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 13 May 2006 09:31:39 +1000 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Feh6X-0004oe-JY
	for linuxppc-embedded@ozlabs.org; Sat, 13 May 2006 01:31:29 +0200
Received: from icarus.icarus.com ([64.105.89.2])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Sat, 13 May 2006 01:31:29 +0200
Received: from steve by icarus.icarus.com with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Sat, 13 May 2006 01:31:29 +0200
To: linuxppc-embedded@ozlabs.org
From: Stephen Williams <steve@icarus.com>
Subject: Bigphysarea vs. kernel 2.4.32 and PPC405GPr
Date: Fri, 12 May 2006 16:31:09 -0700
Message-ID: <e435rv$62q$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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


I'm trying to use the bigphysarea patch to help me allocate big
physical chunks of memory for use by some custom embedded devices.
I've applied the bigphysarea-2.4.20 patch and built, no trouble,
and I've got it to config for my PPC. I can see at boot time that
the bigphysarea is getting its pages.

I'm trying to use a mmap call to the driver to map a chunk of this
memory into the process. The mmap for the driver has this:

      pgprot_val(vma->vm_page_prot) |= _PAGE_NO_CACHE;
      vma->vm_flags |= VM_RESERVED;

      npages = (vma->vm_end - vma->vm_start) / PAGE_SIZE;
      heap_map_base = bigphysarea_alloc_pages(npages, 1, GFP_KERNEL);

      printk("XXXX Map base=%p, %ld pages\n", heap_map_base, npages);

      rc = remap_page_range(vma->vm_start,
			    (unsigned long)heap_map_base,
			    npages*PAGE_SIZE,
			    vma->vm_page_prot);

The mmap returns without an error, but any access to the mapped
region gets me an immediate "Oops: machine check, sig: 7". I don't
see it. Where is the stupid mistake that I'm invariably making?


-- 
Steve Williams                "The woods are lovely, dark and deep.
steve at icarus.com           But I have promises to keep,
http://www.icarus.com         and lines to code before I sleep,
http://www.picturel.com       And lines to code before I sleep."
