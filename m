Return-Path: <jeff@mock.com>
Received: from mail.mock.com (gw.mock.com [209.157.146.194])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.mock.com", Issuer "CAcert Class 3 Root" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B8927DDE26
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Feb 2008 17:54:35 +1100 (EST)
Message-ID: <47BD2025.7030001@mock.com>
Date: Wed, 20 Feb 2008 22:54:29 -0800
From: Jeff Mock <jeff@mock.com>
MIME-Version: 1.0
To: fariyaf@gmail.com
Subject: Re: Sample driver
References: <8024567.229231203576334424.JavaMail.nabble@isper.nabble.com>
In-Reply-To: <8024567.229231203576334424.JavaMail.nabble@isper.nabble.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



fariyaf@gmail.com wrote:
> Hi,
> 
> Thanks so much for the driver. I have a few doubts.. .may be u cud
> help me out with it.... Basically, I am working on the PPC 405EX
> processor with a peripheral attached to the EBC. I've requested for
> I/O memory & mapped it using ioremap. The following are my doubts:
> 
> 1) How do I ensure that the memory range that I requested is
> non-cacheable. I've to work with non-cacheable memory.  I've
> requested for memory using request_mem_region( ).

In my example the memory range is set to non-cacheable, this needs to be 
done if you are talking to real hardware registers:

   "vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);"

static int
pdev_mmap(struct file *file, struct vm_area_struct *vma)
{
     int fpga_num = iminor(file->f_dentry->d_inode) - PDEV_SPCTL;
     phys_addr_t     paddr;

     paddr = fpga_num ? PDEV_SP1_REG : PDEV_SP0_REG;
#ifdef PDEV_DEBUG
     printk("pdev-gxctl: fpga %d reg mmap() at %016llx\n", fpga_num, paddr);
#endif
     vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
     if (remap_pfn_range(vma,
             vma->vm_start,
             paddr >> PAGE_SHIFT,
             vma->vm_end-vma->vm_start,
             vma->vm_page_prot))
         return -EAGAIN;
     return 0;
}

> 2) Between any consecutive writes or any consecutive reads to the EBC
> peripheral, if I introduce a delay of 500msec, the read/write is
> completing.  Does this have to do anything with caching? What could
> be the  reason for this?


I have no idea where the 500ms delay comes from, this is quite a long 
delay.  Maybe there is some problem with the EBC programming for your 
example.  The EBC is quite flexible and can be programmed in any number 
of insane ways that might cause trouble.

jeff
