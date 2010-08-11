Return-Path: <shawnxjin@gmail.com>
Received: from mail-ew0-f42.google.com (mail-ew0-f42.google.com
	[209.85.215.42]) by ozlabs.org (Postfix) with ESMTP id 9C743B6F14
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Aug 2010 16:55:55 +1000 (EST)
Received: by ewy2 with SMTP id 2so12854151ewy.15
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Aug 2010 23:55:53 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 10 Aug 2010 23:55:53 -0700
Message-ID: <AANLkTi=ZSBNUYgwv3CKA1PEZm7Vkk6SsubcFR8410qz+@mail.gmail.com>
Subject: kernel 2.6.33 fail to mount rootfs on ramdisk
From: Shawn Jin <shawnxjin@gmail.com>
To: ppcdev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

The kernel 2.6.33 failed to mount the rootfs on the ramdisk. I enabled
the ramdisk block device support and ext2 filesystem as shown below.

CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_EXT2_FS=y

Are these adequate configurations for kernel to support rootfs on
ramdisk? What have I missed? The ramdisk image is from DENX's SELF.
The boot message is shown below.

=> bootm 1000000 2000000
## Booting image at 01000000 ...
   Image Name:   Linux-2.6.33.5
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1070272 Bytes =  1 MB
   Load Address: 00400000
   Entry Point:  00400554
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Loading RAMDisk Image at 02000000 ...
   Image Name:   Simple Embedded Linux Framework
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    1459535 Bytes =  1.4 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Loading Ramdisk to 07bb7000, end 07d1b54f ... OK
Memory <- <0x0 0x8000000> (128MB)
ENET0: local-mac-address <- 00:09:9b:01:58:64
CPU clock-frequency <- 0x7270e00 (120MHz)
CPU timebase-frequency <- 0x7270e0 (8MHz)
CPU bus-frequency <- 0x3938700 (60MHz)

zImage starting: loaded at 0x00400000 (sp: 0x07d1cbd0)
Allocating 0x23f554 bytes for kernel ...
gunzipping (0x00000000 <- 0x0040c000:0x0067d01c)...done 0x22e6ec bytes
Using loader supplied ramdisk at 0x7bb7000-0x7d1b54f
initrd head: 0x1f8b0808

Linux/PowerPC load: root=/dev/ram
Finalizing device tree... flat tree at 0x68a300
.......
NET: Registered protocol family 17
List of all partitions:
No filesystem could mount root, tried:  ext2
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(1,0)
Call Trace:
[c781fed0] [c0006ce0] show_stack+0x40/0x168 (unreliable)
[c781ff10] [c001cc5c] panic+0x8c/0x178
[c781ff60] [c0201dc0] mount_block_root+0x1d4/0x244
[c781ffb0] [c0201fa4] prepare_namespace+0x64/0x210
[c781ffd0] [c0201220] kernel_init+0x104/0x130
[c781fff0] [c000dcc8] kernel_thread+0x4c/0x68
Rebooting in 180 seconds..

Thanks,
-Shawn.
