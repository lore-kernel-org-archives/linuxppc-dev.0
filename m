From: Benjamin Herrenschmidt <bh40@calva.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux/PPC Development
 <linuxppc-dev@lists.linuxppc.org>
Cc: <paulus@linuxcare.com.au>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
Date: Fri, 22 Sep 2000 00:40:42 +0200
Message-Id: <19340816161226.30414@192.168.1.10>
In-Reply-To: <Pine.LNX.4.10.10009211544591.375-100000@cassiopeia.home>
References: <Pine.LNX.4.10.10009211544591.375-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>And how to access PCI I/O space from user space? There the MMU doesn't help,
>since the user application (usually XFree86) just look at the BARs from
>/proc/bus/pci/...

There are two ways:

 - 2.4 and my 2.2.x kernels have a new syscall that returns for a given
PCI card, the io base for that card (the offset that must be added to the
BAR in physical space). AFAIK, Kostas is working on adding support for
this in XFree.

 - DaveM and I discussed about a better solution based on some mmap'ing
mecanisms & ioctls on /proc/bus/pci entries. It would obviously require
some arch-specific changes for IO (which are mmap'ed for us but not for x86).
I had no time to look more in depth at this, but this is probably the way
to go. We need also an ioctl that would give XFree access to
pci_enable_device()/pci_disable_device() and possiblty to the device PM
features.

>This is very similar to what many people already suggested on linux-kernel
>years ago: inb() and friends should take an additional argument pci_dev *.

Which could be NULL for legacy.. yup. Well, IOs are slow, so a bit of
overhead is ok ;)

>For kernel space. This doesn't work for user space, unless you mmap
>/dev/pci_{io,mem}_space, which don't exist at the moment.

DaveM have made a patch some month ago. I'll ask him if he made any
progress. In the mantime, we have the syscall.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
