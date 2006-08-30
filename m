Return-Path: <arvid.staub@mediornet.com>
Received: from mail.mediornet.com (83-64-147-140.hietzing.xdsl-line.inode.at
	[83.64.147.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.mediornet.com", Issuer "mediornet.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4BD1467B54
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Aug 2006 18:46:26 +1000 (EST)
Subject: re: PPC405 system slow boot
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Wed, 30 Aug 2006 10:20:08 +0200
Message-ID: <8B59AE8CCFB44040B58FCBC1342ED3C414C4ED@mnx.mediornet.lan>
From: "Arvid Staub" <Arvid.Staub@mediornet.com>
To: "Clint Thomas" <cthomas@Soneticom.com>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

hi!

i've recently had a similar situation with a XC2VP50-based custom board.
There was no SystemACE involved, we load the FPGA via a CPLD/serial =
flash.

the problem resided in the interrupt controller, which was not able to =
enable interrupts due to an error in the MHS file.
you should check that your interrupt controller section includes the =
following parameters:
PARAMETER C_HAS_IPR =3D 1
PARAMETER C_HAS_SIE =3D 1
PARAMETER C_HAS_CIE =3D 1
PARAMETER C_HAS_IVR =3D 1

the intc driver uses SIE and CIE to atomically enable and disable =
interrupts.
when the uartlite interrupt was not enabled, the uartlite driver =
encountered timeouts which caused single characters to appear at the =
serial console, similar to what you described.

hope that helps,
arvid staub


________________________________________
Von: linuxppc-embedded-bounces+arvid.staub=3Dmediornet.com@ozlabs.org =
[mailto:linuxppc-embedded-bounces+arvid.staub=3Dmediornet.com@ozlabs.org]=
 Im Auftrag von Clint Thomas
Gesendet: Montag, 28. August 2006 21:57
An: linuxppc-embedded@ozlabs.org
Betreff: PPC405 system slow boot

Hey guys,

I've run through the loops to try and figure what could be wrong with =
this system. The board in question is modeled after the Xilinx ML300 =
board. It uses a Xilinx System ACE chip to load a FPGA / Kernel image =
from compact flash. Originally, I was trying to use the CompactFlash as =
the root file system, but because of issues in either the design or =
software, this would only work if SysAce was in polled I/O mode. To =
circumvent this, I built my root filesystem into an initrd image and =
built a single ELF file with the Kernel and RFS, then strapped that to =
the FPGA bit file to make a single FPGA/Kernel/RFS SysAce file.

Upon decompression, the Linux kernel boots quickly and loads all of the =
device drivers. However when it gets to the prompt, it starts slowing =
down. Output and input to and from the board becomes very very slow (it =
displays 2 characters roughly every 20 seconds). Originally I believed =
this to be the CPU still polling SystemAce, so I disabled the Linux =
System ACE drivers to remove that as a possibility, however after doing =
this, the problem still persists, even with the RFS in ram! Has anybody =
encountered a similar situation to this before, with possible insight =
towards a solution? Thank you for your time.
=A0
Clinton Thomas
cthomas@soneticom.com
=A0
