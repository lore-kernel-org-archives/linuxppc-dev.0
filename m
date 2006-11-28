Return-Path: <christophe.alayrac@cresitt.com>
Received: from smtp6-g19.free.fr (smtp6-g19.free.fr [212.27.42.36])
	by ozlabs.org (Postfix) with ESMTP id 4623F679A6
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Nov 2006 19:09:31 +1100 (EST)
From: "alayrac" <christophe.alayrac@cresitt.com>
To: "'Peter Mendham'" <petermendham@computing.dundee.ac.uk>,
	<linuxppc-embedded@ozlabs.org>
Subject: RE : Using Linux on ML405: Some basic questions
Date: Tue, 28 Nov 2006 09:09:20 +0100
Message-ID: <000001c712c4$8252e870$c900a8c0@CRESITTLAB>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <456AF9A5.70301@computing.dundee.ac.uk>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Peter,

I'will try to help you on systemace only.

XACCACE can load an ace file from a FAT16 partition into the FPGA fabric
using boundary scan chain (JTAG).

First of all it loads the FPGA fabric, the bitsream file. If you have a
look in Applications in the ML405 project there should be a bootloop
code marked as activated and as used to initialized BRAM.=20
This code is loaded at address 0xFFFFFFFC (where there is a BRAM) wich
is the reset address of the powerpc. Thus after bitstream dowload, the
powerpc is in an infinite loop so that it won't try to access any
peripheral, especially memory.

Then systemeace will downlaod the elf file, in your case the kernel
image (it could be standalone apllication as well as uboot).

To do so the systemace take controle of powerpc through jtag chain (just
as you are dowing with the JTAG cable when you are debugging you code on
powerpc inside the FPGA). In fact the FPGA fabric include a JTAG daisy
chain, so that the PowerPC is seen on JTAG chain after FPGA
initialization (if you start an xps design from scratch you will see in
the wizard that you can select the debug chain of your powerpc from JTAG
or stub...)

So just to finish, as soon as system ace can see the PowerPC through
JTAG, it can see and use all powerpc peripherals and espaecially the
memory in your case. So it read the destination address of the elf image
to laod (from the elf file itself) and just copy the data at the
specific address. Then it put the PC at this address and sart the
powerpc.

Regards.

Chris

CRESITT INDUSTRIE
12 Rue de Blois, BP6744
45067 ORLEANS Cedex 2
Tel : 02.38.49.45.59
Fax :02.38.49.45.55
Email : christophe.alayrac@cresitt.com=20
Web : http://www.cresitt.com


<----> -----Message d'origine-----
<----> De=A0: linuxppc-embedded-
<----> bounces+christophe.alayrac=3Dcresitt.com@ozlabs.org
[mailto:linuxppc-
<----> embedded-bounces+christophe.alayrac=3Dcresitt.com@ozlabs.org] De =
la
<----> part de Peter Mendham
<----> Envoy=E9=A0: lundi 27 novembre 2006 15:44
<----> =C0=A0: linuxppc-embedded@ozlabs.org
<----> Objet=A0: Using Linux on ML405: Some basic questions
<---->=20
<----> Dear all,
<---->=20
<----> I am experimenting with Linux on an ML405 dev board in
preparation
<----> for
<----> designing a board of our own.  I am not massively knowledgeable
about
<----> Linux internals and am learning as I go along.  At the moment I'm
<----> working with a 2.4.26 kernel and the demonstration hardware
<----> configuration.  I have built the kernel and created a new root
file
<----> systems using buildroot/busybox.  Most of the time I have a
working
<----> system :)
<---->=20
<----> I have a few questions, I was wondering if someone could help me
out:
<---->=20
<----> 1) I don't really understand how the kernel image gets loaded
from
<----> the
<----> .ace file.  I've seen articles which say that the SystemAce
<----> controller
<----> puts the kernel image directly into RAM, but on inspection of the
<----> datasheet I can't see any capability other that JTAG programming
and
<----> acting as a slave to a processor.  Can anyone explain the way
this
<----> works?
<---->=20
<----> 2) I'm trying to simplify the kernel as much as possible, is
there a
<----> way
<----> to do without devfs?  If I don't have devfs do I need an initrd?
If
<----> so,
<----> what do I need to put on the initrd, can it just be a minimal
/dev
<----> directory?
<---->=20
<----> 3) I will eventually be wanting tri-mode ethernet support,
ideally
<----> under
<----> a 2.6 kernel.  I've been trying to follow the discussions on this
<----> mailing list with respect to the support for the tri-mode MAC and
<----> scatter gather/DMA support.  Can anyone summarise what sort of
stage
<----> this is at? Is auto-negotiation supported? Once I get past the
<----> hurdles I
<----> have at the moment my next step is to attempt incorporating the
tri-
<----> mode
<----> IP and getting it working under Linux.  If there's anything I can
do
<----> to
<----> help the effort at that point I'd be glad to put in some time.
<---->=20
<----> Many thanks in advance,
<----> -- Peter
<---->=20
<----> _______________________________________________
<----> Linuxppc-embedded mailing list
<----> Linuxppc-embedded@ozlabs.org
<----> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
