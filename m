Message-ID: <40C7099D.10206@fh-landshut.de>
Date: Wed, 09 Jun 2004 14:59:09 +0200
From: Oliver Korpilla <okorpil@fh-landshut.de>
MIME-Version: 1.0
To: "Heater, Daniel (GE Infrastructure)" <Daniel.Heater@gefanuc.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: VME driver patch for PowerPC
References: <DB1DE297F535B340AEAE1E51B221C3D0016B3DCB@FTWMLVEM02.e2k.ad.ge.com> <40C48A1C.30602@fh-landshut.de>
In-Reply-To: <40C48A1C.30602@fh-landshut.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello!

Adding the patch below activated correct behaviour for vme_peek/poke, with
correct data width (tested VME_D8, VME_D16 and VME_D32), and without cache bursts.

It simply sets the cache-inhibited and guarded bits before remapping the pages
(these flags are PowerPC-specific, and the pci_mmap_page_range() function is
sadly no exported kernel symbol).

Would you again be so kind to run some "still works"-test on an Intel board?

Looks like a hack, but I guess it simply gets the job done... No need for a
larger rewrite here.

May take some time till I can again lay hands on a MVME5500 (PPC 7455 - 1Ghz) to
verify on another PPC board, though.

With kind regards,
Oliver Korpilla

Index: module/vme_main.c
===================================================================
--- module/vme_main.c   (revision 5)
+++ module/vme_main.c   (revision 6)
@@ -191,14 +191,18 @@
   */
  int vme_mmap(struct file *file_ptr, struct vm_area_struct *vma)
  {
-
         DPRINTF("Attempting to map %#lx bytes of memory at "
                 "physical address %#lx\n", vma->vm_end - vma->vm_start,
                 vma->vm_pgoff << PAGE_SHIFT);

+#ifdef CONFIG_PPC32
+       vma->vm_page_prot.pgprot |= _PAGE_NO_CACHE | _PAGE_GUARDED;
+       DPRINTF("PowerPC protection flags set.\n");
+#endif
+
         /* Don't swap these pages out
          */
-       vma->vm_flags |= VM_RESERVED;
+       vma->vm_flags |= VM_LOCKED | VM_IO | VM_SHM;

  #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,3) || defined RH9BRAINDAMAGE
         return remap_page_range(vma, vma->vm_start, vma->vm_pgoff << PAGE_SHIFT,

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
