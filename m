Message-ID: <3A7B0CFB.6BAB81F3@matrox.com>
Date: Fri, 02 Feb 2001 14:39:39 -0500
From: Sébastien Côté <scote1@matrox.com>
MIME-Version: 1.0
To: Jim Potter <jrp@wvi.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: mm in user space
References: <3A79EBF9.6534E50D@wvi.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jim Potter wrote:
>
> > I got exactly the same problem, did you manage to fix it?
> Yes, I did (blushing).
> While doing the early boot-tasks I had installed a custom DSI trap
> handler, to alert me to all the stupid mistakes that sometimes get made
> when bringing up Linux on a new hardware platform.  When I got to the
> "user space" task of create_elf_tables(), it's *supposed* to take the
> regular DSI trap to fixup the TLB, pagetables, etc...
>
> After restoring the default DSI trap handler in head.S, it worked fine.
>
> What kind of problem are you having with your system?

I lose the system in create_elf_tables, when NEW_AUX_ENT is first called
but I don't really know what happens then because the debugger screws
up.

Today, I noticed that the values of PAGE_OFFSET (from which KERNELBASE
is set) and KERNELLOAD had been changed to 0x0 on the system..  This
seemed very bad to me so I set them back to 0xc0000000 but then the
debugger doesn't want to load the kernel image in memory (it tries to
load it at 0xc0000000 which isn't possible).. Then I just changed
KERNELLOAD back to 0x0 and kept KERNELBASE to 0xc0000000.

Now the system locks up at the very beginning (prom_init) but since
KERNELLOAD and KERNELBASE are different, I wasn't hoping for much (not
really beacuse they differ, but because the linker used 0x0).

Do you think it would be possible to get everything to work with
KERNELBASE and KERNELLOAD = 0x0 ?

Sébastien Côté

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
