Return-Path: <mgaouar@solacom.com>
Received: from solacom.com (unknown [209.217.64.195])
	by ozlabs.org (Postfix) with ESMTP id CF027DDE9C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Sep 2007 02:23:13 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: U-Boot problems with MPC8272ADS
Date: Wed, 19 Sep 2007 12:23:11 -0400
Message-ID: <9A1468054ED2FD40907CC3B2C1871D400106CC89@hermes.versatel.com>
From: "Manil Gaouar" <mgaouar@solacom.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I have been trying many things to solve this problem, I found using a
JTAG that U-Boot is running from flash so my JP9 jumper should stay in
BCSR.

I still can not have display on my com port, do you know what I have to
check more in the U-Boot code to make sure the come port is enabled? Is
there a test I can do?

Since I don't have a display, I want to put in my env var in U-Boot the
ip=3D..., BootCmd=3D..., so it will look like something like this:
bootcmd=3Dset ipaddr 192.168.1.123;tftp 0x10200000 uImage;bootm=20
bootargs=3Droot=3D/dev/nfs nfsroot=3D192.168.1.125:/nfs
ip=3D192.168.1.123::192.168.1.125:::eth0:off console=3DttyS0

Is those commands have to be written in /include/configs/stamp.h?

Thx for any help...

-----Original Message-----
From: linuxppc-embedded-bounces+mgaouar=3Dsolacom.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+mgaouar=3Dsolacom.com@ozlabs.org] On
Behalf Of linuxppc-embedded-request@ozlabs.org
Sent: Thursday, September 13, 2007 3:55 PM
To: linuxppc-embedded@ozlabs.org
Subject: Linuxppc-embedded Digest, Vol 37, Issue 27

Send Linuxppc-embedded mailing list submissions to
	linuxppc-embedded@ozlabs.org

To subscribe or unsubscribe via the World Wide Web, visit
	https://ozlabs.org/mailman/listinfo/linuxppc-embedded
or, via email, send a message with subject or body 'help' to
	linuxppc-embedded-request@ozlabs.org

You can reach the person managing the list at
	linuxppc-embedded-owner@ozlabs.org

When replying, please edit your Subject line so it is more specific
than "Re: Contents of Linuxppc-embedded digest..."


Today's Topics:

   1. U-Boot problems with MPC8272ADS (Manil Gaouar)


----------------------------------------------------------------------

Message: 1
Date: Thu, 13 Sep 2007 15:55:05 -0400
From: "Manil Gaouar" <mgaouar@solacom.com>
Subject: U-Boot problems with MPC8272ADS
To: <linuxppc-embedded@ozlabs.org>
Message-ID:
	<9A1468054ED2FD40907CC3B2C1871D400106CC84@hermes.versatel.com>
Content-Type: text/plain; charset=3D"us-ascii"

Hi all,

=20

I have a MPC8272ADS evaluation board from Motorolla. I am trying to run
U-Boot and Linux kernel 2.6 on it. I am using the 4.1 ELDK, U-Boot from
the git repos, and Linux kernel 2.6 from git repos.

=20

I am burning U-Boot into the flash using a BDI2000.

=20

My problem is:=20

=20

1-       When burning the U-Boot and setting the jumper JP9 in BSCR
everything works fine, I reboot the board and the memory at 0xfff00000
is locked which probably means that U-Boot is running, but I have no
display on my serial link (running cu S0@115200).

2-       When I put the jumper JP6 in memory position the card keeps
resetting and I have a message error if I connect the BDI to the board
saying:

=20

- TARGET: processing user reset request

- BDI asserts HRESET

- Reset JTAG controller passed

- Bypass check: 0x00000001 =3D> 0x00000001

- JTAG exists check passed

- COP status is 0x7D

- Check running state failed

- TARGET: Target PVR is 0x80822014

*** TARGET: resetting target failed

# PPC: unexpected response from target

- TARGET: target will be restarted in 10 sec

8272>

=20

And it keeps resetting and same message again and again.

=20

Here is my BDI CFG file:

=20

; bdiGDB configuration file for MPC8272ADS board

; ----------------------------------------------

[INIT]

; init core register

WREG    MSR             0x00001002      ;MSR  : ME,RI

WM32         0x0F010004      0xFFFFFFC3     ;SYPCR: disable watchdog

WM32         0x0F0101A8      0x04700000       ;IMMR : internal space @
0x04700000

WM32         0x04710024       0x100C0000      ;BCR  : Single PQ2, ..

WM32         0x04710c94       0x00000001       ;RMR  : checkstop reset
enable

; init memory controller

=20

WM32         0x04710104       0xFF800876      ;OR0: Flash 8MB, CS early
negate, 11 w.s., Timing relax

WM32         0x04710100       0xFF801801      ;BR0: Flash @0xFF800000,
32bit, no parity

WM32         0x0471010C      0xFFFF8010      ;OR1: BCSR 32KB, all types
access, 1 w.s.

WM32         0x04710108       0x04501801       ;BR1: BCSR @0x04500000,
32bit, no parity

WM32         0x04710124       0xFFFF8866      ;OR4: EEPROM 32KB, all
types access, 6 w.s.

WM32         0x04710120       0xC2000801      ;BR4: EEPROM @0xC2000000,
8bit, no parity

; init SDRAM Init (PPC bus)

WM16         0x04710184       0x2800          ;MPTPR: Divide Bus clock
by 41

WM8          0x0471019C      0x13             ;PSRT : Divide MPTPR
output by 20

WM32         0x04710114       0xfe002ec0        ;OR2  : 32MB, 2 banks,
row start at A9, 11 rows

WM32         0x04710110       0x00000041       ;BR2  : SDRAM
@0x00000000, 64bit, no parity

WM32         0x04710190       0x824b36a3       ;PSDMR: Precharge all
banks

WM32         0x04710190       0xaa4b36a3

WM8          0x00000000       0x00             ;Access SDRAM

WM32         0x04710190       0x8a4b36a3       ;PSDMR: CBR Refresh

WM8          0x00000000       0xFF             ;Access SDRAM

WM8          0x00000000       0xFF             ;Access SDRAM

WM8          0x00000000       0xFF             ;Access SDRAM

WM8          0x00000000       0xFF             ;Access SDRAM

WM8          0x00000000       0xFF             ;Access SDRAM

WM8          0x00000000       0xFF             ;Access SDRAM

WM8          0x00000000       0xFF             ;Access SDRAM

WM8          0x00000000       0xFF             ;Access SDRAM

WM32         0x04710190       0x9a4b36a3       ;PSDMR: Mode Set

WM8          0x00000190       0x00             ;Access SDRAM

WM32         0x04710190       0xc24b36a3       ;PSDMR: enable refresh,
normal operation

[TARGET]

CPUTYPE     8272        ;the CPU type

JTAGCLOCK   0           ;use 16 MHz JTAG clock

POWERUP     7000        ;start delay after power-up detected in ms

BOOTADDR    0xfff00100  ;boot address used for start-up break

WORKSPACE   0x04700000            ;workspace in target RAM for fast
download

;MEMDELAY    2000        ;additional memory access delay

=20

[HOST]

IP          172.16.0.120

FILE        u-boot.bin

FORMAT      BIN

;FILE        E:\temp\test16k.bin

;FORMAT      BIN 0x04708000

LOAD        MANUAL      ;load code MANUAL or AUTO after reset

DEBUGPORT   2001

PROMPT      8272> ;new prompt for Telnet

;DUMP        /home/solacom/bdi/dump.bin

[FLASH]

CHIPTYPE    I28BX8            ; Flash type

CHIPSIZE    0x200000          ; Single chip size (2 Mbyte)

BUSWIDTH    32                  ; total width for the whole SIMM

WORKSPACE   0x04700000            ;workspace in target RAM for fast
download

FILE        /home/solacom/bdi/1MB_junk.bin

FORMAT      BIN 0xFF800000

ERASE       0xFF800000  ;erase sector  4 of flash SIMM

ERASE       0xFF840000  ;erase sector  5 of flash SIMM

ERASE       0xFF880000  ;erase sector  6 of flash SIMM

ERASE       0xFF8C0000  ;erase sector  7 of flash SIMM

[REGS]

DMM1        0x04700000

FILE        reg8272.def

=20

Here are the commands I used to upload the U-Boot:

=20

8272>unlock

8272>erase

8272>erase 0xfff00000

8272>prog 0xfff00000 u-boot.bin

The prgrammation goes fine.

When I do a 8272>md 0xfff00000 I have the same data as the beginning of
the u-boot.bin, which means that my upload is correct.

=20

Can you help me on this please? My TEXT_BASE is 0xFFF00000 which means
u-boot run from flash, but putting JP9 means running from RAM right?

=20

I am confused about this, I've read a tutorial www.jungo.com/openrg/doc/
4.7/installation_guide/pdf/ppc.pdf and followed their steps to start
U-Boot, but I can not see the U_Boot prompt, may be U-Boot is not
running, I have no clue...Can we know when U-Boot is not running without
display?

=20

Thx for any help...

-------------- next part --------------
An HTML attachment was scrubbed...
URL:
http://ozlabs.org/pipermail/linuxppc-embedded/attachments/20070913/ad8d6
285/attachment.htm=20

------------------------------

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded

End of Linuxppc-embedded Digest, Vol 37, Issue 27
*************************************************
