Message-Id: <200107081934.VAA00933@piglet.grunz.lu>
Date: Sun, 8 Jul 2001 21:33:57 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: compiling 2.2.19 kernel with promise ide card support
To: bob@kunk.jriver.com
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20010708182837.7945.qmail@kunk.jriver.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Bob,

On   8 Jul, this message from Robert E Brose II echoed through cyberspace:
> I'm trying to get a 2.2.19 kernel running to check some differences
> I'm having with a 2.4 kernel. I've started with a stock 2.2.19
> kernel from kernel.org and added patches I need on the 7600.

Sorry, but I'm running only 2.4 kernels on my 7600 for some time now...

> The problem I'm having is in getting the kernel to compile after adding
> the ide patches (to support the promise line of cards) from
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/hedrick/ide-2.2.20/ide.2.2.19.05042001.patch
>
> make[3]: Entering directory `/usr4/linux/drivers/block'
> cc -D__KERNEL__ -I/usr4/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char -msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple -mstring   -DEXPORT_SYMTAB -c ll_rw_blk.c
> In file included from ll_rw_blk.c:28:
> /usr4/linux/include/asm/ide.h:53: parse error before `*'
> /usr4/linux/include/asm/ide.h:56: warning: function declaration isn't a prototype
> /usr4/linux/include/asm/ide.h:63: parse error before `*'
> /usr4/linux/include/asm/ide.h:63: warning: function declaration isn't a prototype
>
>
> The problem is at this declaration...
>
>         void        (*ide_init_hwif)(hw_regs_t *hw,
>                                      ide_ioreg_t data_port,
>                                      ide_ioreg_t ctrl_port,
>                                      int *irq);

Have a look at all the types used here (*_t); one of them might not be
defined (or uncorrectly). Andre sometimes forgets to update the
definitions in the PPC-arch header files.

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
