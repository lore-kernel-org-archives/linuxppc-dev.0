Date: Mon, 5 Jul 2004 10:31:09 +0200 (CEST)
From: Oliver Korpilla <korpo@01019freenet.de>
Reply-To: okorpil@fh-landshut.de
To: linuxppc-embedded@lists.linuxppc.org
Subject: MPC7455 DMA buffer strangeness
Message-ID: <Pine.LNX.4.58.0407051018590.388@corpster2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello!

I'm mapping a DMA buffer allocated with pci_alloc_consistent() into user
space with a mmap hook like this:

int vme_mmap(struct file *file_ptr, struct vm_area_struct *vma)
{
        DPRINTF("Attempting to map %#lx bytes of memory at "
                "physical address %#lx\n", vma->vm_end - vma->vm_start,
                vma->vm_pgoff << PAGE_SHIFT);

        vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);

        vma->vm_flags |= VM_RESERVED;

#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,3) || defined RH9BRAINDAMAGE
        return remap_page_range(vma, vma->vm_start, vma->vm_pgoff <<
PAGE_SHIFT,
                                vma->vm_end - vma->vm_start,
vma->vm_page_prot);
#else
        return remap_page_range(vma->vm_start, vma->vm_pgoff <<
PAGE_SHIFT,
                                vma->vm_end - vma->vm_start,
vma->vm_page_prot);
#endif
}

Actually this produces the desired effect on a MPC8240, where the buffer
is writeable and readable from user space and kernel space (with its
original virtual address on allocation).

On the MPC7455, though, write accesses seem to be applied or not applied
in a somewhat random fashion. Sometimes an offsetted write into the buffer
is there, and sometimes not. Writing at the begin of the buffer seems to
disapper always.

What's going on here?

Thanks in advance,
Oliver Korpilla

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
