Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3FB0E976.20500@catapult.com>
Date: Tue, 11 Nov 2003 08:51:50 -0500
From: "Kevin A. Sapp" <Kevin.Sapp@catapult.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: EST sbc8260 boot debug
References: <8039970AF146314597457D3B51A68B382E042D@cossmgmbx02.email.corp.tld>
In-Reply-To: <8039970AF146314597457D3B51A68B382E042D@cossmgmbx02.email.corp.tld>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I am uisng an Arabella Free Distro as the starting point
for my development.  The NFS mounting works fine and is
good for development, however, I am trying to get the
deployed version underway using a ram disk and running
into some problems.  This is a 8275 FADS board.


Any help would be great!
Thank you
Kevin

Additional info below.

I have downloaded the simple-ramdisk-PPCBoot supplied
by Denx and created a kernel with:

CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=8192
# CONFIG_BLK_DEV_INITRD is not set

I tftpboot the kernel to 100000, the simple-ramdisk to 300000
set boot args to root=/dev/ram rw   then    bootm 100000 300000
and still run into problems:

Here is the last part of the start up log

...
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: devfs_debug: 0x0
devfs: boot_options: 0x1
pty: 256 Unix98 ptys configured
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
MPC8260 FCC Ethernet driver
BD rings initialised, RBASE=1FF8160, TBASE=1FF8360
Created eth0
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 4096)
eth0: OPEN
IP-Config: Guessing netmask 255.255.255.0
IP-Config: Complete:
      device=eth0, addr=192.168.90.3, mask=255.255.255.0,
gw=255.255.255.255,
     host=192.168.90.3, domain=, nis-domain=(none),
     bootserver=255.255.255.255, rootserver=255.255.255.255, rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
init/main.c:init:573
VFS: Cannot open root device "" or 00:00
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on 00:00


The trace shows:
arch_kernel_thread
init
prepare_namespace
mount_root
mount_block_root


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
