Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <C08678384BE7D311B4D70004ACA371050B763357@amer22.avnet.com>
From: "Kerl, John" <John.Kerl@Avnet.com>
To: "'Ed Brady'" <mailinglist@ebrady.net>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Compiling 2.4.18 for Motorola MBX board
Date: Wed, 27 Mar 2002 14:02:15 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I made the same newby bone-headed mistake last fall. :)

The default PPC .config appears to be something that's
appropriate to, say, running Linux on a Macintosh.
Which of course has many more devices than a little
ol' embedded system.

You should go into make menuconfig, & de-select PMAC
and other Mac-type ethernet devices.

In fact, I made sure to go through every (!) menu,
sub-menu, sub-sub-menu, etc. in make menuconfig to
de-select everything that wasn't appropriate for my
system.


-----Original Message-----
From: Ed Brady [mailto:mailinglist@ebrady.net]
Sent: Wednesday, March 27, 2002 1:48 PM
To: linuxppc-embedded@lists.linuxppc.org
Subject: Compiling 2.4.18 for Motorola MBX board



Hello,

I am trying to cross compile the latest 2.4.18 kernel to run on an MBX board
(MPC 860).  However, I consistently run into problems whenever the final
link is performed.    See error text below....

This code is comprised of the following:

linux 2.4.18 kernel from kernel.org with the ppc-patch-2.4.18 applied.

I have not tried cross compiling the kernel without the ppc patch applied.

The compiler is the gcc packaged build to cross-compile on an i386 linux
host with a target of powerpc-unknown-eabi.

Note:  This is the first time that I have attempted to cross-compile a
kernel for an embedded target, so if this is caused by a bone-headed
mistake, please be kind :)

Any thoughts or pointers would be appreciated...

powerpc-eabi-ld -T arch/ppc/vmlinux.lds -Ttext 0xc0000000 -Bstatic
arch/ppc/kernel/head_8xx.o init/main.o init/version.o \
        --start-group \
        arch/ppc/kernel/kernel.o arch/ppc/mm/mm.o arch/ppc/lib/lib.o
kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o arch/ppc/xmon/x.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o
drivers/net/net.o drivers/media/media.o drivers/video/video.o
drivers/i2c/i2c.o arch/ppc/8xx_io/8xx_io.o \
        net/network.o \
        /usr/src/ppc/linux/lib/lib.a \
        --end-group \
        -o vmlinux
arch/ppc/kernel/kernel.o: In function `lookup_partitions':
arch/ppc/kernel/kernel.o(.text.init+0xa22): undefined reference to
`pmac_newworld'
arch/ppc/kernel/kernel.o(.text.init+0xa26): undefined reference to
`pmac_newworld'
arch/ppc/kernel/kernel.o: In function `pmac_nvram_init':
arch/ppc/kernel/kernel.o(.text.init+0xb38): undefined reference to
`find_devices'
arch/ppc/kernel/kernel.o(.text.init+0xb38): relocation truncated to fit:
R_PPC_REL24 find_devices
arch/ppc/kernel/kernel.o(.text.init+0xb6c): undefined reference to
`device_is_compatible'
arch/ppc/kernel/kernel.o(.text.init+0xb6c): relocation truncated to fit:
R_PPC_REL24 device_is_compatible
arch/ppc/kernel/kernel.o(.text.init+0xc9a): undefined reference to
`sys_ctrler'
arch/ppc/kernel/kernel.o(.text.init+0xc9e): undefined reference to
`sys_ctrler'
arch/ppc/xmon/x.o: In function `xmon':
arch/ppc/xmon/x.o(.text+0x600): undefined reference to `xmon_enter'
arch/ppc/xmon/x.o(.text+0x600): relocation truncated to fit: R_PPC_REL24
xmon_enter
arch/ppc/xmon/x.o(.text+0x664): undefined reference to `xmon_leave'
arch/ppc/xmon/x.o(.text+0x664): relocation truncated to fit: R_PPC_REL24
xmon_leave
arch/ppc/xmon/x.o: In function `dump_hash_table_seg':
arch/ppc/xmon/x.o(.text+0x16b2): undefined reference to `Hash_size'
arch/ppc/xmon/x.o(.text+0x16ba): undefined reference to `Hash_size'
arch/ppc/xmon/x.o(.text+0x16ce): undefined reference to `Hash'
arch/ppc/xmon/x.o(.text+0x16d6): undefined reference to `Hash'
make: *** [vmlinux] Error 1

Ed Brady
ed@ebrady.net


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
