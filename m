Message-ID: <20010708182837.7945.qmail@kunk.jriver.com>
Subject: compiling 2.2.19 kernel with promise ide card support
To: linuxppc-dev@lists.linuxppc.org
Date: Sun, 8 Jul 2001 13:28:37 -0500 (CDT)
From: Robert E Brose II <bob@kunk.jriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm trying to get a 2.2.19 kernel running to check some differences
I'm having with a 2.4 kernel. I've started with a stock 2.2.19
kernel from kernel.org and added patches I need on the 7600.

The problem I'm having is in getting the kernel to compile after adding
the ide patches (to support the promise line of cards) from

ftp://ftp.kernel.org/pub/linux/kernel/people/hedrick/ide-2.2.20/ide.2.2.19.05042001.patch

I have installed Michel Lanners 2.2 pci patches and the ide patch goes
in fine but when I try to compile the kernel I get....

make[3]: Entering directory `/usr4/linux/drivers/block'
cc -D__KERNEL__ -I/usr4/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char -msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple -mstring   -DEXPORT_SYMTAB -c ll_rw_blk.c
In file included from ll_rw_blk.c:28:
/usr4/linux/include/asm/ide.h:53: parse error before `*'
/usr4/linux/include/asm/ide.h:56: warning: function declaration isn't a prototype
/usr4/linux/include/asm/ide.h:63: parse error before `*'
/usr4/linux/include/asm/ide.h:63: warning: function declaration isn't a prototype


The problem is at this declaration...

        void        (*ide_init_hwif)(hw_regs_t *hw,
                                     ide_ioreg_t data_port,
                                     ide_ioreg_t ctrl_port,
                                     int *irq);

Can anyone drop me a clue as to the problem here??

Bob
--
Robert E. Brose II    N0QBJ
http://www.jriver.com/~bob/
bob@kunk.jriver.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
