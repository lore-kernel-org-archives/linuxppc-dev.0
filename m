Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Fri, 31 Jan 2003 13:04:38 +0100 (MET)
From: Andreas Plaickner <apxx@gmx.net>
To: linuxppc-embedded@lists.linuxppc.org
Cc: apxx@gmx.net
MIME-Version: 1.0
Subject: 3Com 574BT PCMCIA Card on PowerPC
Message-ID: <2651.1044014678@www39.gmx.net>
Content-Type: text/plain; charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I am new to the development of RTAI Linux on
PowerPC boards, therefore I would be very
grateful for some advice.

I want to use the PCMCIA card 3Com
3CCFE574BT in the pcmcia-slot on the board. On the
board is a Motorola MPC855T.

I have seen that there exists already a solution
for a wireless LAN card. I took these steps as
a basis to try to bring to work my card. On my
board it is not possible to start the card
services with the script
/etc/rc.d/rc.pcmcia start
as there is no bash to interpret the script, there
is only a BusyBox.

S I start the PCMCIA card services manually:
insmod pcmcia_core.o
insmod m8xx_pcmcia.o
insmod ds.o
insmod 3c574_cs.o

When I don't insert the card in the slot and I only
start the cardmgr everything seems to be fine,
the cardmgr responds with:

cardmgr[61]: watching 1 sockets
cardmgr[62]: starting, version is 3.2.0

When I insert the card, nothing happens so I have
to call the command
cardctl insert

When I do this one I get the following error message,
and the system reboots:

/ # Oops: Kernel Mode Software FPU Emulation, sig: 8
NIP: 00000304 XER: A000007F LR: C3040490 SP: C07F1810 REGS: c07f1760 TRAP:
1000
MSR: 00001000 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00
TASK = c07f0000[58] 'cardmgr' Last syscall: 54
last math 00000000 last altivec 00000000
GPR00: 00000800 C07F1810 C07F0000 0000001F 00100000 00000002 C07F17AB
00000000
GPR08: 0000000F 0000030E 00000058 C000B2D4 95743B34 018223F8 00FF3D00
007FFF5D
GPR16: 00000000 00000001 007FFF00 FFFFFFFF 00009032 007F1E80 C07F19B8
C07F1838
GPR24: C093D0FC C093D000 C093D08C C0941170 0000002B C093D1BC 00000300
C093D000
Call backtrace:
C3040490 C304098C C3030208 C3031880 C3040244 C303C894 C303D614
C004377C C00025BC 01802D18 01803444 01804A20 016D9DBC 00000000

When I, after inserting the modules, dont start the cardmgr,
but write cardctl insert I can check with the commands

cardctl status
cardctl config
cardctl ident

and get some information that the card is in the socket.
But I think this one doesn't help as I need to start the
cardmgr to use the card. When I start the cardmgr now
I get again the above errormessage.

What I also tried is to change the file config.opts,
setting the memory area to 0xe0000000-0xec000000
because when I start the board during the boot
process appears
PCMCIA slot B: phys mem e0000000...ec000000 (size 0c000000)

When I did this one I got the following error-msg:

/lib/modules/2.4.4-rthal5/pcmcia # cardmgr
cardmgr[61]: watching 1 sockets
cardmgr[62]: starting, version is 3.2.0
/lib/modules/2.4.4-rthal5/pcmcia # cardctl insert
/lib/modules/2.4.4-rthal5/pcmcia # __ioremap(): phys addr 0 is RAM lr
c000b25c
Oops: kernel access of bad area, sig: 11
NIP: CF032C34 XER: A000007E LR: CF032C10 SP: C09AF8F0 REGS: c09af840 TRAP:
0300
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 00000000, DSISR: 00000405
TASK = c09ae000[62] 'cardmgr' Last syscall: 54
last math 00000000 last altivec 00000000
....


My Kernel-Image is

## Booting image at 40040000 ...
   Image Name:   Linux-2.4.4
   Created:      2002-07-17  10:40:49 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    614209 Bytes = 599 kB = 0 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK

I didn't create a new kernel, but I used one that was already
pre-installed on the board. Could this one be the reason
for the above error?

I am stuck and don't know how to continue, therefore I
would be very grateful if someone could give me some advice.

Thanks very much in advance.

Andreas

--
+++ GMX - Mail, Messaging & more  http://www.gmx.net +++
NEU: Mit GMX ins Internet. Rund um die Uhr für 1 ct/ Min. surfen!


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
