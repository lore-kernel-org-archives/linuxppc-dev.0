Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <DEA23DB61B62D4118B5900508B323B84012CC7D1@OPENMAIL>
From: Jeremy Bowen <Jeremy.Bowen@opennw.com>
To: "'Linux PPC'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Problems with MMU: address translation for 0xXXXXXXXX failed
Date: Tue, 13 May 2003 16:19:26 +1200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm trying to get a BDI2000 (firmware v1.09) working in order to debug a
kernel module.
I'm using an Embedded Planet RPXlite MPC850 board running kernel v2.4.20
from kernel.org with CONFIG_BDI_SWITCH=y and CONFIG_COMPILE_OPTIONS="-g
-ggdb"
in my .config

I have compiled gdb v5.3 with --host=i686-pc-linux-gnu
--target=powerpc-linux.

The relevant bit of my BDI config file is here:
=====================================================================
WSPR    796             0x00000000      ;;M_TWB: invalibdate TWB
WM32    0x000000f0      0x00000000      ;;invalidate page table base
(PTBASE)

[TARGET]
CPUTYPE     MPC800
CPUCLOCK    50000000		;the CPU clock rate after processing the
init list
WORKSPACE   0x00000000		;workspace in target RAM for fast download
BDIMODE     AGENT       	;the BDI working mode (LOADONLY | AGENT)
BREAKMODE   SOFT	      	;SOFT or HARD, HARD uses PPC hardware
breakpoints
MMU XLAT                      ; Enable address translation
======================================================================

I have scanned the archives of this mailing list and have seen a number of
messages relating to getting the BDI working with the MMU but I don't seem
to be able to get this working on my system.

My kernel is stored in flash and booted by u-boot v0.3.0

I start the system by telneting into the BDI and issuing:
BDI>bi 0xc0000000 0xc00fffff
BDI>go

U-boot starts, loads the kernel and it is decompressed. At this point the
system stops. I then do the following:

BDI>ci
BDI>mm 0xf0 0xc014f000

(gdb) target remote 192.168.240.242:2001
Remote debugging using 192.168.240.242:2001
0xc00020f0 in start_here()
(gdb) c
Continuing.

Everything is OK until after I get a login prompt. After I log in, I don't
seem to be able to debug successfully. I'm wanting to break on a call from a
user-space program to a kernel function. On executing the program that
triggers the kernel breakpoint I get the following error in the telnet
session to the BDI

*** MMU: address translation for 0xC400E69C failed
...
*** MMU: address translation for 0xC0A05EF0 failed
etc..

and in dgb:

(gdb)
Cannot remove breakpoints because program is no longer writeable.
It might be running in another process.
Further execution is probably impossible.

Breakpoint 3, m8xx_cpm_dpalloc (size=16) at commproc.c:216
(gdb) bt
Cannot access memory at address 0xc0a05ef0

Am I missing something obvious ? Is this the right way to go about debugging
a loadable module ? Any help would be gratefully appreciated.

Cheers

Jeremy


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
