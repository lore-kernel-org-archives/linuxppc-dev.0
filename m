MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: VME driver patch for PowerPC
Date: Wed, 9 Jun 2004 08:59:19 -0500
Message-ID: <DB1DE297F535B340AEAE1E51B221C3D007E84015@FTWMLVEM02.e2k.ad.ge.com>
From: "Heater, Daniel (GE Infrastructure)" <Daniel.Heater@gefanuc.com>
To: "Oliver Korpilla" <okorpil@fh-landshut.de>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> +#ifdef CONFIG_PPC32
> +       vma->vm_page_prot.pgprot |= _PAGE_NO_CACHE | _PAGE_GUARDED;
> +       DPRINTF("PowerPC protection flags set.\n");
> +#endif

Cool. I was just about to suggest _PAGE_NO_CACHE | _PAGE_GUARDED.

>          /* Don't swap these pages out
>           */
> -       vma->vm_flags |= VM_RESERVED;
> +       vma->vm_flags |= VM_LOCKED | VM_IO | VM_SHM;

I'm trying to understand this change. VM_IO looks like it needs to
be there to prevent deadlocks on core dumps.
http://www.uwsg.iu.edu/hypermail/linux/kernel/0202.0/1309.html

and if I'm interpreting some older mailing list postings correctly,
VM_RESERVED is a replacement for VM_LOCKED | VM_SHM but VM_RESERVED
may yield some performance advantages. Thus, in later kernels you
only see VM_RESERVED and not VM_LOCKED | VM_SHM.

Maybe since this is an out of tree driver, it should have
> +       vma->vm_flags |= VM_LOCKED | VM_IO | VM_SHM | VM_RESERVED;

to handle older kernels and still get the advantages of VM_RESERVED
on newer kernels.

What do you think? Am I interpreting this correctly?

Daniel.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
