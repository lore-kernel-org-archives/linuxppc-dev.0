Message-Id: <200110122149.XAA03908@piglet.grunz.lu>
Date: Fri, 12 Oct 2001 23:49:14 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: kernel linking segfaults??
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

Now that Ben fixed the serial console problem, I've tried again to
compile recent 2.4 kernels (2.4.12-benh0 that is) on my venerable 7600.

However, compilation fails on the final link stage:

ld -T arch/ppc/vmlinux.lds -Ttext 0xc0000000 -Bstatic arch/ppc/kernel/head.o init/main.o init/version.o \
        --start-group \
        arch/ppc/kernel/kernel.o arch/ppc/mm/mm.o arch/ppc/lib/lib.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o arch/ppc/xmon/x.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/char/drm/drm.o drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o drivers/sound/sounddrivers.o drivers/pci/driver.o drivers/pcmcia/pcmcia.o drivers/net/pcmcia/pcmcia_net.o drivers/net/wireless/wireless_net.o drivers/macintosh/macintosh.o drivers/video/video.o drivers/usb/usbdrv.o drivers/input/inputdrv.o drivers/i2c/i2c.o \
        net/network.o \
        /usr/src/2.4/linux-2.4.benh/lib/lib.a \
        --end-group \
        -o vmlinux
make: *** [vmlinux] Segmentation fault
make: *** Deleting file `vmlinux'

Since the 7600 has some weirdo old LinuxPPC install with a rather old
toolchain, I thought I'd try on the TiBook (Debian testing), but same
result (both with the 7600's kernel config and the Book's).

Anybody got any clue here?


Thanks, and cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
