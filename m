Date: Mon, 21 Aug 2000 21:04:05 +0200
From: Claus <cl.en@gmx.net>
To: Benjamin Herrenschmidt <bh40@calva.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: irda.o and 2.2.17pre16-ben1
Message-ID: <20000821210405.A1679@olis.north.de>
Reply-To: cl.en@gmx.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hi,

if I try to built the irda section as modules, it complains this way:
Aug 21 20:03:59 apple irattach: device=/dev/ttyS1
Aug 21 20:03:59 apple irattach: SIR device
Aug 21 20:03:59 apple kernel: irda_setup 1st byte = 3
Aug 21 20:03:59 apple insmod: /lib/modules/2.2.17pre16-ben1/net/irda.o:
insmod tty-ldisc-11 failed
Aug 21 20:03:59 apple irattach: irattach: tty: set_disc(11): Bad file
descriptor

and if not, building stops here:

make[1]: Leaving directory `/usr/src/linux-pmac-benh/arch/ppc/lib'
ld -T arch/ppc/vmlinux.lds -Ttext 0xc0000000 -Bstatic
arch/ppc/kernel/head.o init/main.o in
it/version.o \
	--start-group \
	arch/ppc/kernel/kernel.o arch/ppc/mm/mm.o arch/ppc/lib/lib.o
kernel/kernel.o mm/mm.
o fs/fs.o ipc/ipc.o \
	fs/filesystems.a \
	net/network.a \
	drivers/block/block.a drivers/char/char.a drivers/misc/misc.a
drivers/net/net.a dri
vers/cdrom/cdrom.a drivers/sound/sound.a drivers/pci/pci.a
drivers/macintosh/macintosh.a dr
ivers/video/video.a drivers/usb/usbdrv.o drivers/net/irda/irda_drivers.a \
	/usr/src/linux/lib/lib.a \
	--end-group \
	-o vmlinux
net/network.a(irda.o): In function `irda_release':
irda.o(.text+0x19f70): undefined reference to `sock_put'
irda.o(.text+0x19f70): relocation truncated to fit: R_PPC_REL24 sock_put
make: *** [vmlinux] Error 1

[/usr/src/linux]uname -r
2.2.17pre16-ben1



2.2.17pre13-ben2 works like a charm.

Yours, ce

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
