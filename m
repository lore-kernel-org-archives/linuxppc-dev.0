Message-ID: <40473464.8010203@imc-berlin.de>
Date: Thu, 04 Mar 2004 14:51:32 +0100
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: uncached user space mapping with mmap() ???
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi there,

I am trying to access a hardware timer implemented in an FPGA from
user space. I implemented a simple mmap() functionality (taken from
Runbini's Linux Device Driver)

int simple_remap_mmap(struct file *filp, struct vm_area_struct *vma)
{
      unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;

      if (offset >= __pa(high_memory) || (filp->f_flags & O_SYNC)) {
          vma->vm_flags |= VM_IO;
      }
      vma->vm_flags |= VM_RESERVED;

      if (remap_page_range(vma->vm_start, offset,
	vma->vm_end-vma->vm_start, vma->vm_page_prot))
	        return -EAGAIN;

      return 0;
}

I just learned that

 > getting an uncached user space mapping is architecture dependent.
 > On ARM, however, passing pgprot_noncached(vma->vm_page_prot) to
 > remap_page_range() will alter the page protections such that the
 > mapping will be uncached.

How could I do this on an MPC8xx?

Thanks a million!


--
Steven Scholz

imc Measurement & Control               imc Meﬂsysteme GmbH
Voltastr. 5                             Voltastr. 5
13355 Berlin                            13355 Berlin
Germany                                 Deutschland


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
