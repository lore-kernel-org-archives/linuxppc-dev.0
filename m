Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: MPC5200LITE - kernel BUG at page_alloc.c
Date: Thu, 27 Nov 2003 08:52:48 +0100
Message-ID: <004B1D7A5257174C9044A1B7BD0E60ED447042@ratatosk.combitechsystems.com>
From: "Tord Andersson" <Tord.Andersson@combitechsystems.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I have some troubles when trying to run Linux-2.4.23-pre5 on a an
MPC5200LITE board (16MB) with U-BOOT 1.0.1). Right after the bogoMIPS
calculation I get "kernel BUG at page_alloc.c:105", and the system
reboots (see excerpt at end of mail).
I think the part which goes wrong is when the system tries to check if
the free pages in memory are OK (__freepages_ok(...)), where the
(page->mapping) seems to be marked and thus causing a bug.
Is there some kind of problems related to that all pages resides in the
zone(0), which seems to be used for DMA?
I have tried both the ELDK as described in other mails in this list and
the Metrowerks PCS evaluation version, and I end up with the same
problem irregardless if I try to use tftp for the kernel, nfs for the
root file system or all things in flash (rootfs in jffs2).

Any clues?

Kind regards,

Tord

.....
=> run net_nfs
TFTP from server 146.75.80.108; our IP address is 146.75.80.234
Filename '/MPC5200/uImage'.
Load address: 0x200000
Loading:
#################################################################

#################################################################
         #
done
Bytes transferred = 669156 (a35e4 hex)
## Booting image at 00200000 ...
   Image Name:   Linux-2.4.23-pre5
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    669092 Bytes = 653.4 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Memory BAT mapping: BAT2=64Mb, BAT3=0Mb, residual: 0Mb
Linux version 2.4.23-pre5 (toande@jupiter) (gcc version 2.95.4 20010319
(prerele
ase/franzo/20011204)) #1 Mon Nov 10 17:25:53 CET 2003
Motorola Icecube port
    (C) 2003 MontaVista Software, Inc. (source@mvista.com)
    (C) 2003 DENX Software Engineering (wd@denx.de)
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/nfs rw
nfsroot=146.75.80.108:/opt/eldk/ppc_82xx i
p=146.75.80.234:146.75.80.108::255.255.255.0:orion:eth0:off panic=1
Calibrating delay loop... 266.24 BogoMIPS
kernel BUG at page_alloc.c:105!
Oops: Exception in kernel mode, sig: 4
NIP: C002F8F8 XER: 00000000 LR: C002F8F8 SP: C0146380 REGS: c01462d0
TRAP: 0700
   Not tainted
MSR: 00089032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0144480[0] 'swapper' Last syscall: 0
last math 00000000 last altivec 00000000
GPR00: C002F8F8 C0146380 C0144480 00000020 00001032 00000001 00000000
C0190000
GPR08: 0000029A C0146DC0 C014DB88 C01462A0 44002044 FFFFFFFE 03FF4000
007FFF7E
GPR16: 00000000 00000001 007FFF00 03FF3E60 003FF000 FFFFFFFF 00000001
03F9EC00
GPR24: 00000000 00000001 00004000 00000008 00004000 00000000 000002FB
C024B43C
Call backtrace:
C002F8F8 C0030654 C017ED34 C017EF58 C017CC04 C0179500 000035F0
Kernel panic: Attempted to kill the idle task!
In idle task - not syncing
 <0>Rebooting in 1 seconds..

U-Boot 1.0.1 (Nov 10 2003 - 10:38:02)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
