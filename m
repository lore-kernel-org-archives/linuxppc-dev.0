Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <20031106010608.27803.qmail@web11602.mail.yahoo.com>
Date: Wed, 5 Nov 2003 17:06:08 -0800 (PST)
From: Shamile Khan <shamile@yahoo.com>
Subject: RAMDISK image in flash not getting mounted - Memec Powerpc405 board
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I am trying to get Linux to boot with U-boot using a flash
based initrd image. I am using a Memec Virtex II Pro board
which has a Powerpc 405 processor embedded in an FPGA. I
have u-boot running. My flash is 8 Megs and is organized as
follows:

0xFE000000 - U-boot
0xFE100000 - Linux u-boot kernel (vmlinux.PPCBoot) created
using latest sources from ppckernel.org
0xFE200000 - Simple Ramdisk-Image (simple-ramdisk.PPCBoot )
from DENX.de

The boot arguments I pass using u-boot are
bootargs=console=ttyS0,115200 mem=32M root=/dev/ram rw

Some relevant kernel configuration parameters are (using
xilinx_ml300 as base)

# Block devices
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y

# File systems
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
CONFIG_DEVPTS_FS=y

However when I use "bootm fe100000 fe200000" to boot linux,
I get all the way to the end of the boot process at which
point I get this message:

RAMDISK: Compressed image found at block 0
Freeing initrd memory: 554k freed
Kernel panic: VFS: Unable to mount root fs on 01:00

Seems like it located the RAMDISK image but is not able to
mount it. Any ideas on what is causing this to occur.

I did a backtrace using gdb over abatron  and heres what I
get (breakpoints don't seem to work for me though although
I can get a stach trace)
#0  0xc000678c in __delay ()
#1  0xc0014734 in panic (fmt=0x1cfde0 <Address 0x1cfde0 out
of bounds>) at
/home/shamile/ecsi-linux/kernel/src-linuxppc_2_4_devel/include/asm/delay.h:42
#2  0xc00fcac8 in mount_block_root (name=0xc00d5ea4
"/dev/root", flags=32768) at init/do_mounts.c:376
#3  0xc00fd4d4 in mount_root () at init/do_mounts.c:789
#4  0xc0002888 in prepare_namespace () at
init/do_mounts.c:917
#5  0xc0002458 in init (unused=0xc2c1) at init/main.c:556
#6  0xc0006f60 in arch_kernel_thread ()

Thanks,
Shamile

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
