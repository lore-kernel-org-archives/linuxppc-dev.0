Return-Path: <ayman@elkhashab.com>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.125]) by ozlabs.org (Postfix) with ESMTP id B7DDA1007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  8 Jul 2010 05:55:03 +1000 (EST)
Received: from hrndva-omtalb.mail.rr.com ([10.128.143.53])
	by hrndva-qmta02.mail.rr.com with ESMTP
	id <20100707195001942.BTOZ10056@hrndva-qmta02.mail.rr.com>
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Jul 2010 19:50:01 +0000
Received: from crust.elkhashab.com (localhost [127.0.0.1])
	by crust.elkhashab.com (8.14.3/8.14.3/Debian-5) with ESMTP id
	o67Jmlk6000995
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Jul 2010 14:48:47 -0500
Received: (from ayman@localhost)
	by crust.elkhashab.com (8.14.3/8.14.3/Submit) id o67JmkKd000994
	for linuxppc-dev@lists.ozlabs.org; Wed, 7 Jul 2010 14:48:46 -0500
Date: Wed, 7 Jul 2010 14:48:46 -0500
From: ayman@austin.rr.com
To: linuxppc-dev@lists.ozlabs.org
Subject: Problems mapping OCM memory from 460EX to user space
Message-ID: <20100707194846.GA724@crust.elkhashab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I've got an issue with the new rev B 460EX processors that I am trying to isolate.
(Rev A worked fine).  In order to do that, I am trying to modify my driver to 
map the OCM (on chip memory) from the 460EX to user space so that the rest of the
application and codebase don't really know the difference.

My driver implements the mmap and this works fine when I point it to areas of 
memory that have been setup with kmalloc.  My sequence is basically kmalloc, 
adjust for page boundaries, and then remap_pfn_range.  For regular DRAM this 
works fine.

Now I want to modfiy it to use OCM.  I've modified the code to use ioremap so 
that the driver has access to the memory. This seems to work.  But the kernel 
gives a register dump when I call 

#define PLB_OCM_BASE_ADDR        0x400040000ull
...

static int mapper_mmap(struct file *fip, struct vm_area_struct *vma)
{
  int rc;
  
  /* 
   * make sure to allocate the proper number of pages when using
   * mmap.  We check it for correctness here.
   */
  
  unsigned long len = vma->vm_end - vma->vm_start;

  /* if user tries to map bigger space than we have, error */
 if (PAGE_COUNT * PAGE_SIZE < len) 
    return -EIO;

 rc = io_remap_pfn_range(vma, PLB_OCM_BASE_ADDR>>PAGE_SHIFT, vma->vm_start, len, vma->vm_page_prot);

#if 0
  /* map the physical area into one buffer */
  rc = remap_pfn_range(vma, vma->vm_start, 
		       virt_to_phys( (void*)km.pal)>>PAGE_SHIFT,
		       len,
		       vma->vm_page_prot);
#endif

  MDEBUG("Mapped %ld bytes at virt address 0x%lx to mapper file descriptor...\n", len, vma->vm_start);

  /* return an error to the caller if remap fails */
  return (rc < 0 ? rc : 0);

}

The "#if 0" code is the working code for using DRAM.  MDEBUG is just a printk.

I am fairly certain the physical address is correct, I've verified that the
TLB entries in u-boot look ok.  Any tips on how to make this work?

Thanks
