Message-ID: <40E3D44A.4070009@fh-landshut.de>
Date: Thu, 01 Jul 2004 11:07:22 +0200
From: Oliver Korpilla <okorpil@fh-landshut.de>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Two PowerPC platforms: Addressing strangeness
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello!

I'm currently porting a VME driver to two PowerPC platforms, and I am getting
strange results on mmap() on one of them.

The driver (written orginally for the x86) now works fine for the MPC8240 (on a
MVME2100), but does not work completely on a Motorola 7455 (on a MVME5500).

Steps are (from user space):
- Creating a DMA buffer via an ioctl()
- Mapping that buffer to user space via mmap()
- Accessing that mapped buffer via pointers
- Triggering a DMA transfer

All these steps work, excepting accessing the buffer from user space. If I'm
writing into the buffer, the values won't appear in the transfer, as if the
buffer was empty. Worse, on the first attempt on executing my test suite some
values will appear, and on repeated attempt they won't.

The DMA buffers are created with pci_alloc_consistent().

The code for the mmap() hook is like this:

/*============================================================================
  * Hook to the mmap file operation
  */
int vme_mmap(struct file *file_ptr, struct vm_area_struct *vma)
{
	DPRINTF("Attempting to map %#lx bytes of memory at "
		"physical address %#lx\n", vma->vm_end - vma->vm_start,
		vma->vm_pgoff << PAGE_SHIFT);

	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);

	/* Don't swap these pages out
	 */
	vma->vm_flags |= VM_RESERVED;

#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,3) || defined RH9BRAINDAMAGE
	return remap_page_range(vma, vma->vm_start, vma->vm_pgoff << PAGE_SHIFT,
				vma->vm_end - vma->vm_start, vma->vm_page_prot);
#else
	return remap_page_range(vma->vm_start, vma->vm_pgoff << PAGE_SHIFT,
				vma->vm_end - vma->vm_start, vma->vm_page_prot);
#endif
}


The pgprot_noncached() call is there to avoid caching issues on the remapped
pages, the VM_RESERVED flags is set to avoid having the kernel flush the pages
to disk.

Most of the driver's features work, even reading in data via DMA, only writing
data with DMA doesn't seem to work, or: It does work, but the buffer used
doesn't seem to have the data I wrote in it.

I find this especially strange, because it works on the MPC8240.

I'm using a TimeSys 2.4.21 kernel with a uClibc snapshot from April.

Thanks in advance,
Oliver Korpilla


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
