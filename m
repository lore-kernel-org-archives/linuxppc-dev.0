Date: Wed, 20 Feb 2002 07:54:22 -0800
From: David Ashley <dash@xdr.com>
Message-Id: <200202201554.g1KFsM010035@xdr.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Linux 2.4.17 bug, mmap of /dev/mem
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


It appears that drivers/char/mem.c in the mmap_mem function already
has the VM_RESERVED:
	/* Don't try to swap out physical pages.. */
	vma->vm_flags |= VM_RESERVED;

I tried adding the | VM_IO also there, and the behaviour changed (not in
a good way though). I could run my script a few times and I don't get the
kernel errors I had been getting (panic, kernel access of bad area, and
such like). But after running it several times first the shell froze
up, then linux itself.

In this case my script launched the mt program 64 times. The mt program
mmaps, then reads once, writes once, then exits.

-Dave


>Yes, there are a lot of differences.
>
>Did you try other protections flags like VM_IO (I think this is selected
>automatically in mem.c) and VM_RESERVED?
>
>Fred

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
