Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <000f01c42562$d3713150$a81e1aac@liuming>
From: "liuming" <lm_mailbox@sohu.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Cc: "liuming" <lm_mailbox@163.com>
Subject: Need help booting linux on my 8265 board
Date: Mon, 19 Apr 2004 00:33:02 +0800
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
  I have problem booting linux on my 8265 board. Both u-boot and ppcboot
run well, but when I boot the linux kernel, the board be dead. At this
time the registers look like to be some default values(use powertap
pro). I try u-boot1.1, ppcboot1.1.5; linux kernel 2.4.4 2.4.18 2.4.20.

(1)about compile kernel
vim Makefile,        arch=ppc CROSS_COMPILE=ppc_82xx-
vim arch/ppc/platforms/ads826x.h,      IMAP_ADDR=0x04700000 BCSR=0x04500000

then make mrproper/ make ads826x_config/ make oldconfig/ make dep/ make
pImage (bd info struct is quite same between uboot and linux)

Is there anything I had ignored?

(2)let's see!(I add some "printf" to display values,
"console=ttyS0,9600" is added)
=> bootm ffa00000 ffc00000
## Booting image at ffa00000 ...
   Image Name:   Linux-2.4.20-pre7ncsd1
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    634729 Bytes = 619 kB = 0 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Current stack ends at 0x03F7FC48 => set upper limit to 0x00800000
## cmdline at 0x007FFF00 ... 0x007FFF23
memstart    = 0x00000000
memsize     = 0x04000000
flashstart  = 0xFF800000
flashsize   = 0x00800000
flashoffset = 0x00000000
sramstart   = 0x00000000
sramsize    = 0x00000000
immr_base   = 0x04700000
bootflags   = 0x00000001
vco         = 266.666 MHz
sccfreq     = 66.666 MHz
brgfreq     = 16.666 MHz
intfreq     = 166.666 MHz
cpmfreq     = 133.333 MHz
busfreq     = 33.333 MHz
ethaddr     = 00:10:EC:00:30:8C
IP addr     = 8.6.0.1
baudrate    =   9600 bps
## Loading RAMDisk Image at ffc00000 ...
   Image Name:   Simple Ramdisk-Image
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    567988 Bytes = 554 kB = 0 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
## initrd at 0xFFC00040 ... 0xFFC8AAF3 (len=567988=0x8AAB4)
   Loading Ramdisk to 03ef4000, end 03f7eab4 ... OK
## Transferring control to Linux (at address 00000000) ...

then the board is dead and the LED(FCC link) coruscate . (I have
modified clock calculations for this board so SCC can output message.
it's the reason?) any ideas? thanks a lot!

--
liu
lm_mailbox@sohu.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
