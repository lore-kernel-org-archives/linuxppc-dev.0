Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <20040609130013.57180.qmail@web15204.mail.bjs.yahoo.com>
Date: Wed, 9 Jun 2004 21:00:13 +0800 (CST)
From: Song Sam <samlinuxppc@yahoo.com.cn>
Subject: BDI2000 problem on programming BIG file to FLASH?
To: support@abatron.ch
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <16582.38634.736636.748883@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I met a strange problem on FLASH programming with
BDI2000 on a 8xx board.After programming a 11.7MB
ramdisk to 4*8bit Intel FLASH[4*28F128J3A=64MB],the
main menu of application in ramdisk couldn't
appear.But if I did this job with U-BOOT,everything
went well.Also the ramdisk programmed by BDI2000 was
checked "right" as following with crc32 by
U-BOOT.Meanwhile,I have been using BDI2000 good for
programming U-BOOT and Linux kernel.So weird... I hope
this is not a bug of BDI2000 fireware... Could anyone
encounter such strangeness before?

Image at FE000000:
   Image Name:   ramdisk for 5-25 test
   Image Type:   PowerPC Linux RAMDisk Image (gzip
compressed)
   Data Size:    12235275 Bytes = 11.7 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK

[root@sam bdi]# ./bdisetup -v -p/dev/ttyS1 -b57 -s
BDI Type : BDI2000 Rev.C (SN: 94402134)
Loader   : V1.05
Firmware : V1.12 bdiGDB for MPC8xx/MPC5xx
Logic    : V1.02 MPC8xx/MPC5xx
MAC      : 00-0c-01-94-40-21
IP Addr  : 172.16.115.8
Subnet   : 255.255.255.0
Gateway  : 255.255.255.255
Host IP  : 172.16.115.6
Config   : dmtless+.cfg

----------------------------------------------------
; bdiGDB configuration file for custom 8xx board

[INIT]
; init core register
WSPR    149             0x2002000F      ;DER  : set
debug enable register
;;WSPR  149             0x2006000F      ;DER  : enable
SYSIE for BDI flash progr.
WSPR    638             0xFA200000      ;IMMR :
internal memory at 0xFFF00000

; init SIU register
WM32    0xFA200000      0x00000C00      ;SIUMCR
WM32    0xFA200004      0xFFFFFF89      ;SYPCR

[TARGET]
CPUCLOCK    40000000    ;; the CPU clock rate after
processing the init list
BDIMODE     AGENT       ;; the BDI working mode
(LOADONLY | AGENT)
BREAKMODE   HARD        ;; SOFT or HARD, HARD uses PPC
hardware breakpoints

[HOST]
IP          172.16.115.6
FILE        u-boot
FORMAT      ELF
LOAD        MANUAL      ;load code MANUAL or AUTO
after reset

[FLASH]
WORKSPACE   0xFA202000
CHIPTYPE    STRATAX8      ;; Flash type (AM29F |
AM29BX8 | AM29BX16 | I28BX8 | I28BX16)
CHIPSIZE    0x1000000     ;; The size of one flash
chip in bytes
BUSWIDTH    32            ;; The width of the flash
memory bus in bits (8 | 16 | 32)
FILE        u-boot.bin    ;; The file to program
FORMAT      BIN 0x00000000
ERASE       0xfff00000 BLOCK
ERASE       0xfff80000 BLOCK

[REGS]
DMM1    0xFA200000
FILE    reg823e.def

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
