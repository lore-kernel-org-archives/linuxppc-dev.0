Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3AB61394.D9CD1DB3@fiberlogic.com>
Date: Mon, 19 Mar 2001 22:11:32 +0800
From: Carl Lin <carl@fiberlogic.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Problem about running kernel with root fs
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Please help :

I try to run Linux kernel 2.4.0-test13-pre2 (ramdisk size
=4096KB and initrd supported) with a root fs (hello.rfs
from BlueCat) on a board equivalent to TQM855L with the
following configuration :

  memstart    = 0x00000000
  memsize     = 0x01000000
  flashstart  = 0x02800000
  flashsize   = 0x00200000
  flashoffset = 0x00044000
  sramstart   = 0x00000000
  sramsize    = 0x00000000
  immr_base   = 0xff000000
  bootflags   = 0x00000001
  ........................
  bootcmd=bootm 2800100
  baudrate=9600
  ethaddr=00:03:54:00:00:94
  bootfile=/opt/tftpboot/vmlinux
  bootargs=root=/dev/ram

When I "mkimage" with a single kernel image by

mkimage -A ppc -O linux -T kernel -C gzip -a 0 -e 0 \
-n 'test' -d arch/ppc/coffboot/vmlinux.gz \
/opt/tftpboot/vmlinux

and download it to the board, it runs as following :

Linux version 2.4.0-test13-pre2
Boot arguments: root=/dev/ram
..................................
Kernel command line: root=/dev/ram
..................................
Memory: 14752k available (956k kernel code,........
..................................
RAMDISK driver initialized: 16 RAM disks of 4096K size
1024 blocksize
...................................................
VFS: Cannot open root device "ram" or 01:00
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on 01:00

When I "mkimage" with the kernel and the root fs by

mkimage -A ppc -O linux -T multi -C gzip -a 0 -e 0 \
-n 'test' -d arch/ppc/coffboot/vmlinux.gz:hello.rfs \
/opt/tftpboot/vmlinux

and download it to the board, the "imi" shows

## Checking Image at 00100000 ...
   Image Name:   test
   Image Type:   PowerPC Linux Multi-File Image (gzip...
   Data Size:    629184 Bytes = 614 kB = 0 MB
   Load Address: 00000000
   Entry Point:  00000000
   Contents:
   Image 0:   516095 Bytes = 503 kB = 0 MB
   Image 1:   113076 Bytes = 110 kB = 0 MB
   Verifying Checksum ... OK

And, it runs as

## Booting Linux kernel at 00100000 ...
   Image Name:   test
   Image Type:   PowerPC Linux Multi-File Image (gzip...
   Data Size:    629184 Bytes = 614 kB = 0 MB
   Load Address: 00000000
   Entry Point:  00000000
   Contents:
   Image 0:   516095 Bytes = 503 kB = 0 MB
   Image 1:   113076 Bytes = 110 kB = 0 MB
   Verifying Checksum ... OK
   Uncompressing Multi-File Image ... OK
   Loading Ramdisk to db0fc000 ...

and then HALT forever!

What's wrong ?

---------------------------------------------------
Carl Lin                        carl@fiberlogic.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
