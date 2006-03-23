Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BDB4167A0E
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Mar 2006 02:43:32 +1100 (EST)
In-Reply-To: <B1E46DE837A394458BB1A58F74A66A780596CB@ala-mail02.corp.ad.wrs.com>
References: <B1E46DE837A394458BB1A58F74A66A780596CB@ala-mail02.corp.ad.wrs.com>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <204E7000-3E88-4497-86C0-5AF786D72F75@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Memory mapping PCI memory region to user space
Date: Thu, 23 Mar 2006 09:44:26 -0600
To: "Wyse, Chris" <chris.wyse@windriver.com>
Cc: +linux-embedded <linux-embedded@mail.wrs.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Mar 23, 2006, at 8:21 AM, Wyse, Chris wrote:

> Hi,
>
> I'm trying to map a PCI memory region 1 into user space from my  
> driver (PPC440GX, Linux 2.6.10).  Here's the mmap routine of the  
> driver that I'm using:

Why don't use the mmap file exposed by sysfs so you dont have to  
write your own code?

See Documentation/filesystems/sysfs-pci.txt.  But effectively down  
under /sys/bus/pci/devices/[domain:bus:dev:func]/ you will get  
resource[0..N-1] that corresponds to each BAR on the device.  This is  
a mmap file to access that region.

- kumar

>
>
> staticfun
> int phob_mmap(struct file *filp, struct vm_area_struct *vma)
> {
>     struct phob_file *fptr = filp->private_data;
>     struct phob_struct *dev = fptr->dev;
>     struct phob_region *rptr = &dev->region[1];
>     phys_addr_t physAddr;
>
>     physAddr = rptr->address + PPC44x_PCIMEM_PAGE;
>     if (io_remap_page_range(vma, vma->vm_start,
>                             physAddr,
>                             rptr->len,
>                             vma->vm_page_prot))
>         return -EAGAIN;
> }
> Am I using the correct routine to do this?
>
> When I use this routine, the pfn_pte (pgtable.h):
>
> #define pfn_pte(pfn, prot)      __pte(((pfn) << PAGE_SHIFT) |  
> pgprot_val(prot))
>
> macro shifted out the high order bits of the pfn, which I didn't  
> think was correct, so I changed it to:
>
> #define pfn_pte(pfn, prot)      __pte((((unsigned long long) (pfn))  
> << PAGE_SHIFT) | pgprot_val(prot))
>
> For reference, the call stack up to the pfn_pte macro is:
>
> remap_pte_range()
> remap_pmd_range()
> remap_pfn_range()
> io_remap_page_range()
>
> After changing the macro, the value seems to be saved properly, and  
> the TLB gets updated properly when I get a TLB miss.  However, when  
> if I try to write to the PCI from user space, I get an error from  
> do_wp_page() stating that it is a bogus pfn.  If I try to read from  
> user space, the processor goes out to lunch and I need to reboot.
>
> Am I missing something obvious?  Anyone have any ideas on how to do  
> this and/or ways to debug it?
>
> Thanks.
>
> Chris Wyse
> Member of Technical Staff
> Embedded Technologies
> 860-749-1556 office
> 860-978-0849 cell
> 413-778-9101 fax
> http://www.windriver.com
>
>
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
