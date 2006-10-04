Return-Path: <christophe.alayrac@cresitt.com>
Received: from postfix1-g20.free.fr (postfix1-g20.free.fr [212.27.60.42])
	by ozlabs.org (Postfix) with ESMTP id 62EA567C7D
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  4 Oct 2006 17:25:06 +1000 (EST)
Received: from smtp5-g19.free.fr (smtp5-g19.free.fr [212.27.42.35])
	by postfix1-g20.free.fr (Postfix) with ESMTP id 707281835FD
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  4 Oct 2006 09:24:51 +0200 (CEST)
From: "alayrac" <christophe.alayrac@cresitt.com>
To: "'Aleck Lin'" <aleck@gdatech.com>,
	<linuxppc-embedded@ozlabs.org>
Subject: RE : platform flash for Xilinx ML403
Date: Wed, 4 Oct 2006 09:24:46 +0200
Message-ID: <000101c6e786$2be723c0$c900a8c0@CRESITTLAB>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <003001c6e75c$3ad7da70$800101df@monstertop>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Aleck,

As far as I understand Platform Flash can Only handel bistream for FPGA.
If your code is small enough to fit in internal BRAM then you can embed
you application in the bistream making your project as "Mark to
initialize BRAM's". Then when you will build the project XPS will update
BRAM memory content with your application.

I don't think that after bitsream load the PPC405 can access the
PlatformFlash in order to start Uboot from that place, and I'm afraid
that U-boot is to big to fit in FPGA internal BRAM.

If you have a quick look to ML403 schematics (page 8/24) you will see
that XCF32P as no Read signal. The parallel bus is just use to load
bitstream in parallel mode. Furthermore there is no interface for that
plateform Flash in the XPS project (you can't find it in the System
Assembly).

You should try to open a WebCase from Xilinx website and look in the faq
to confirm that point.


Cheers

Chris

CRESITT INDUSTRIE
Email : christophe.alayrac@cresitt.com=20
Web : http://www.cresitt.com


<----> -----Message d'origine-----
<----> De=A0: linuxppc-embedded-
<----> bounces+christophe.alayrac=3Dcresitt.com@ozlabs.org
[mailto:linuxppc-
<----> embedded-bounces+christophe.alayrac=3Dcresitt.com@ozlabs.org] De =
la
<----> part de Aleck Lin
<----> Envoy=E9=A0: mercredi 4 octobre 2006 04:24
<----> =C0=A0: linuxppc-embedded@ozlabs.org
<----> Objet=A0: platform flash for Xilinx ML403
<---->=20
<----> Hello,
<---->=20
<----> Can anyone help with my questions on platform flash for Xilinx
ML403?
<---->=20
<----> >From what I understand, I can use platform flash to store my
FPGA
<----> bitstream
<----> file and my software application elf file, so it's like using an
ACE
<----> file
<----> through the CompactFlash, except I just need to set the
configuration
<----> address through DIP switch and then push the PROG button on the
board
<----> (provided it's set to Platform Flash mode) and then the software
<----> application
<----> would start running. Is this correct?
<---->=20
<----> If it's correct, then how would I be able to program the Platform
<----> Flash? Do
<----> I program separate bit file and elf file, or do I program an ace
file
<----> or ??
<----> I have the ML40x Getting Started Tutorial in which there's a
section
<----> on how
<----> to program my own flash image. But I couldn't really understand
some
<----> things
<----> in it, such as a PROM file, or adding file to Revision no. and
etc.
<----> Can
<----> someone help or point out a more detailed document?
<---->=20
<----> My eventual goal is to be able to use the platform flash to start
u-
<----> boot and
<----> then boot linux image, which will be stored in linear flash. I
think
<----> I have
<----> all the parts ready (u-boot image, uImage, and hardware
bitstream),
<----> but just
<----> lack of the understanding to put in this particular
configuration.
<---->=20
<----> Any help would be appreciated!
<---->=20
<----> Thanks,
<---->=20
<----> Aleck
<----> _______________________________________________
<----> Linuxppc-embedded mailing list
<----> Linuxppc-embedded@ozlabs.org
<----> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
