Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp5.wanadoo.fr (smtp5.wanadoo.fr [193.252.22.26])
	by ozlabs.org (Postfix) with ESMTP id 62D472BF07
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Jan 2005 09:20:38 +1100 (EST)
Date: Tue, 4 Jan 2005 23:28:54 +0100
To: Ulrich Teichert <krypton@ulrich-teichert.org>
Message-ID: <20050104222854.GA30919@pegasos>
References: <33721.82.10.231.190.1104781370.squirrel@82.10.231.190>
	<200501032211.j03MB7A1021340@arbas.nms.ulrich-teichert.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <200501032211.j03MB7A1021340@arbas.nms.ulrich-teichert.org>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-dev@ozlabs.org, mikemartin@linux.ca,
	debian-powerpc@lists.debian.org
Subject: Re: 43p-140 install issues
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jan 03, 2005 at 11:11:06PM +0100, Ulrich Teichert wrote:
> Hi,
> 
> >Delete the "console=tty0", so you end up with:
> >
> > Linux/PPC load: console=ttyS0,9600 root=/dev/ram
> >
> >and try again!
> [del]
> 
> Right, then the installer knows what to do. I think this should go into
> the Debian installation docs, there are a lot of boxes with graphic cards
> out which are not supported by Linux.

Err, it should default to vga tedxt mode if the graphic card fbdev is not
builtin, at least it does it here.

> But the low level SCSI-driver is missing in this image, or any low level
> SCSI drivers for that matter. There are only the high level modules there,
> like sd_mod.ko and sr_mod.ko:

Sure, these should be loaded through the network. Try the
powerpc/cdrom/vmlinuz-prep.initrd for images with scsi modules included.

> Nov 30 00:06:32 hw-detect: Using discover version 1.
> Nov 30 00:06:35 hw-detect: Detecting hardware...
> Nov 30 00:06:36 hw-detect: Missing module 'sym53c8xx'.
> Nov 30 00:06:36 hw-detect: Missing module 'usb-storage'.
> Nov 30 00:06:36 hw-detect: Missing module 'ide-mod'.
> Nov 30 00:06:36 hw-detect: Missing module 'ide-probe-mod'.
> Nov 30 00:06:36 hw-detect: Missing module 'ide-detect'.
> Nov 30 00:06:36 hw-detect: Missing module 'ide-generic'.
> Nov 30 00:06:37 hw-detect: Missing module 'ide-floppy'.
> --More-- (57% of 44385 bytes)                             Nov 30 00:06:37 hw-detect: Missing module 'ide-disk'.
> Nov 30 00:06:37 hw-detect: Missing module 'isofs'.
> Nov 30 00:06:37 hw-detect: Loading modules...
> Nov 30 00:06:37 hw-detect: Detected module 'pcnet32' for 'Advanced Micro Devices [AMD] 79c970 [PCnet32 LANCE]'
> Nov 30 00:06:37 hw-detect: Trying to load module 'pcnet32'
> Nov 30 00:06:37 kernel: pcnet32.c:v1.30i 06.28.2004 tsbogend@alpha.franken.de
> Nov 30 00:06:37 kernel: PCI: Enabling device 0000:00:0c.0 (0000 -> 0003)
> Nov 30 00:06:37 kernel: pcnet32: PCnet/PCI II 79C970A at 0x1020, 00 06 29 2e 98 9d assigned IRQ 22.
> Nov 30 00:06:37 kernel: divert: allocating divert_blk for eth0
> Nov 30 00:06:37 kernel: eth0: registered as PCnet/PCI II 79C970A
> Nov 30 00:06:37 kernel: pcnet32: 1 cards_found.
> Nov 30 00:06:38 hw-detect: Detected module 'floppy' for 'Linux Floppy'
> Nov 30 00:06:38 hw-detect: Trying to load module 'floppy'
> Nov 30 00:06:38 kernel: inserting floppy driver for 2.6.8-powerpc
> Nov 30 00:06:38 kernel: Using anticipatory io scheduler
> Nov 30 00:06:38 kernel: Floppy drive(s): fd0 is 2.88M
> Nov 30 00:06:38 kernel: FDC 0 is a National Semiconductor PC87306
> Nov 30 00:06:38 hw-detect: Detected module 'ide-cd' for 'Linux ATAPI CD-ROM'
> Nov 30 00:06:38 hw-detect: Trying to load module 'ide-cd'
> Nov 30 00:06:39 kernel: Linux Kernel Card Services
> Nov 30 00:06:39 kernel:   options:  [pci] [cardbus] [pm]
> Nov 30 00:06:39 hw-detect: Starting PCMCIA services: using yenta_socket instead of i82365
> Nov 30 00:06:39 hw-detect: cardmgr[1070]: no sockets found!
> Nov 30 00:06:39 cardmgr[1070]: no sockets found!
> Nov 30 00:06:39 hw-detect: done.
> Nov 30 00:06:39 hw-detect: Detected discover version 1, installing discover1.
> Nov 30 00:06:39 hw-detect: Detected hotplug support, installing hotplug.
> Nov 30 00:06:40 hw-detect: Missing modules 'sym53c8xx (Symbios Logic Inc. / NCR 53c825), usb-storage (USB storage), ide-mod (Linux IDE driver), ide-probe-mod (Linux IDE probe driver), ide-detect (Linux IDE detection), ide-generic (Linux IDE support), ide-floppy (Linux IDE floppy), ide-disk (Linux ATA DISK), isofs (Linux ISO 9660 filesystem)
> 
> /lib/modules/2.6.8-powerpc/kernel/drivers/scsi # ls
> scsi_mod.ko  sd_mod.ko    sr_mod.ko
> 
> So, either this is the wrong image (I've taken the same as Daniel mentioned
> in one of his mails: http://debian.yorku.ca/debian/dists/testing/main/installer-powerpc/current/images/powerpc/netboot/vmlinuz-prep.initrd),
> or it's missing some vital modules.

Notice, the canonical address for the daily builds is : 

  http://people.debian.org/~luther/d-i/images/daily

Friendly,

Sven Luther
