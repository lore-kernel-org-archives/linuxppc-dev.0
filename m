Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Subject: IDE on Lite5200
To: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OF12C112DE.67675BE6-ON00256E4C.0060B975-00256E4C.0062715E@marel.is>
From: "=?iso-8859-1?Q?J=F3n_Benediktsson?=" <jonb@marel.is>
Date: Wed, 3 Mar 2004 17:55:15 +0000
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

I am working with a Lite5200 board.  I have u-boot running in a LOWBOOT
configuration and I can run the Denx linux kernel for MPC5200,
 using an nfs root filesystem.

Now I want to add IDE support to the kernel.  I already have IDE support in
u-boot and my disk is detected in the startup.
I have added what I can think of to the kernel config but I am stuck with a
linking error when running 'make uImage'.
Following is the last output of the make, indicating the error.

Can anyone point me in the right direction ?
What are the right CONFIG_ to add to be able to mount an ext3 filesystem on
a Lite5200 board ?

Regards,
Jon Benediktsson
www.marel.com

-----------------------------------------------------------------------------------------
.
.
.
make[1]: Leaving directory
`/home/jonb/projects/mpc5200/linuxppc_2_4_devel/arch/ppc/5xxx_io'
ppc_82xx-ld -T arch/ppc/vmlinux.lds -Ttext 0xc0000000 -Bstatic
arch/ppc/kernel/head.o arch/ppc/kernel/idle_6xx.o init/main.o
init/version.o init/do_mounts.o \
        --start-group \
        arch/ppc/kernel/kernel.o arch/ppc/platforms/platform.o
arch/ppc/mm/mm.o arch/ppc/lib/lib.o kernel/kernel.o mm/mm.o fs/fs.o
ipc/ipc.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o
drivers/net/net.o drivers/ide/idedriver.o drivers/pci/driver.o
drivers/mtd/mtdlink.o drivers/macintosh/macintosh.o drivers/media/media.o
arch/ppc/5xxx_io/5xxx_io.o \
        net/network.o \
        /home/jonb/projects/mpc5200/linuxppc_2_4_devel/lib/lib.a \
        --end-group \
        -o vmlinux
arch/ppc/platforms/platform.o(.text.init+0x13a): In function
`platform_init':
/home/jonb/projects/mpc5200/linuxppc_2_4_devel/arch/ppc/platforms/icecube.c:176:
 undefined reference to `mpc5xxx_ide_get_base'
arch/ppc/platforms/platform.o
(.text.init+0x142):/home/jonb/projects/mpc5200/linuxppc_2_4_devel/arch/ppc/platforms/icecube.c:176:
 undefined reference to `mpc5xxx_ide_get_base'
arch/ppc/platforms/platform.o
(.text.init+0x156):/home/jonb/projects/mpc5200/linuxppc_2_4_devel/arch/ppc/platforms/icecube.c:175:
 undefined reference to `mpc5xxx_ide_init_hwif_ports'
arch/ppc/platforms/platform.o
(.text.init+0x15e):/home/jonb/projects/mpc5200/linuxppc_2_4_devel/arch/ppc/platforms/icecube.c:175:
 undefined reference to `mpc5xxx_ide_init_hwif_ports'
drivers/ide/idedriver.o(.text.init+0xacc): In function `ide_fix_driveid':
/home/jonb/projects/mpc5200/linuxppc_2_4_devel/drivers/ide/ide-iops.c:503:
undefined reference to `mpc5xxx_ide_probe'
drivers/ide/idedriver.o
(.text.init+0xacc):/home/jonb/projects/mpc5200/linuxppc_2_4_devel/drivers/ide/ide-iops.c:503:
 relocation truncated to fit: R_PPC_REL24 mpc5xxx_ide_probe
make: *** [vmlinux] Error 1


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
