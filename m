Message-ID: <20010713165029.14586.qmail@kunk.jriver.com>
Subject: Re: compiling 2.2.19 kernel with promise ide card support
To: linuxppc-dev@lists.linuxppc.org
Date: Fri, 13 Jul 2001 11:50:29 -0500 (CDT)
From: Robert E Brose II <bob@kunk.jriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


----- Forwarded message from Michel Lanners -----

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



-- end of forwarded message --

Hi Michel,

Thanks for the help... You were correct, hw_regs_t was undefined. After
looking at the includes I saw that for some reason in
drivers/block/ll_rw_blk.c there is the following conditional..

#ifdef CONFIG_POWERMAC
#include <asm/ide.h>
#endif

And in ide-pmac.c

#include <asm/ide.h>

ide.h in asm is also included by linux/ide.h. It appears that ll_rw_blk.c
and ide-pmac.c should be using linux/ide.h instead of asm/ide.h because
hw_regs_t is defined in linux/ide.h. When I made that change the
kernel compile completes and the kernel works fine.

Bob
--
Robert E. Brose II    N0QBJ
http://www.jriver.com/~bob/
bob@kunk.jriver.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
