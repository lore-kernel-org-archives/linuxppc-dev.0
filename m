Message-ID: <3B8FB97E.2020305@hadess.net>
Date: Fri, 31 Aug 2001 17:21:18 +0100
From: Bastien Nocera <hadess@hadess.net>
MIME-Version: 1.0
To: Mark D Dunn <mddunn@us.ibm.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Can't link 2.4.2 kernel on PPC
References: <OFEBF78347.D3748889-ON85256AB9.00579AF1@raleigh.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Mark D Dunn wrote:
> Can someone please help me?
>
> There appears to be undefined variable (in pmac_pci), called
> PCI_DEVICE_ID_APPLE_KL_USB.
> When I try to compile the 2.4.2 kernel on PPC machine with USB support on,

1) 2.4.2 is outdated, it 2.4.10-preX these days
2) You're probably using Linus' tree which is, as of the pre2, synced
with the main PPC tree.

Check the archives for which kernel to compile for which machine. Also
make sure you have all the required versions of the different software
by reading Documentation/Changes in the kernel sources.

> there is an error saying that this is
> undefined. After "fixing" the problems (using menu makeconfig), I am left
> with the linkage problems:
>
> make[1]: Entering directory `/usr/src/linux-2.4.2/arch/ppc/xmon'
> make all_targets
> make[2]: Entering directory `/usr/src/linux-2.4.2/arch/ppc/xmon'
> make[2]: Nothing to be done for `all_targets'.
> make[2]: Leaving directory `/usr/src/linux-2.4.2/arch/ppc/xmon'
> make[1]: Leaving directory `/usr/src/linux-2.4.2/arch/ppc/xmon'
> ld -T arch/ppc/vmlinux.lds -Ttext 0xc0000000 -Bstatic
> arch/ppc/kernel/head.o ini
> t/main.o init/version.o \
>         --start-group \
>         arch/ppc/kernel/kernel.o arch/ppc/mm/mm.o arch/ppc/lib/lib.o
> kernel/kern
> el.o mm/mm.o fs/fs.o ipc/ipc.o arch/ppc/xmon/x.o \
>         drivers/block/block.o drivers/char/char.o drivers/misc/misc.o
> drivers/ne
> t/net.o drivers/media/media.o  drivers/ide/idedriver.o
> drivers/scsi/scsidrv.o dr
> ivers/cdrom/driver.o drivers/pci/driver.o drivers/macintosh/macintosh.o
> drivers/
> video/video.o drivers/usb/usbdrv.o \
>         net/network.o \
>         /usr/src/linux/lib/lib.a \
>         --end-group \
>         -o vmlinux
> drivers/scsi/scsidrv.o: In function `ncr_script_copy_and_bind':
> drivers/scsi/scsidrv.o(.text.init+0x890): undefined reference to
> `phys_to_bus'
> drivers/scsi/scsidrv.o(.text.init+0x890): relocation truncated to fit:
>           R_PPC_REL24 phys_to_bus
> drivers/scsi/scsidrv.o: In function `ncr_attach':
> drivers/scsi/scsidrv.o(.text.init+0x1888): undefined reference to
> `phys_to_bus'
> drivers/scsi/scsidrv.o(.text.init+0x1888): relocation truncated to fit:
>           R_PPC_REL24 phys_to_bus
> drivers/video/video.o: In function `chips_of_init':
> drivers/video/video.o(.text.init+0x4b7c): undefined reference to
> `pci_device_loc
> '
> drivers/video/video.o(.text.init+0x4b7c): relocation truncated to fit:
>           R_PPC_REL24 pci_device_loc
> drivers/video/video.o(.text.init+0x4bc0): undefined reference to
> `pci_io_base'
> drivers/video/video.o(.text.init+0x4bc0): relocation truncated to fit:
>      R_PPC_REL24 pci_io_base
> drivers/video/video.o(.text.init+0x4bcc): undefined reference to
> `pci_io_base'
> drivers/video/video.o(.text.init+0x4bcc): relocation truncated to fit:
>      R_PPC_REL24 pci_io_base
> make: *** [vmlinux] Error 1
>
>
> Thanks in advance for your help.
>
> Mark D. Dunn
> IBM Jibe Project
> (919) 254-7052
>
>
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
