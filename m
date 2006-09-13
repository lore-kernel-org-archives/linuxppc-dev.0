Return-Path: <claus.gindhart@kontron.com>
Received: from mail.kontron-modular.com (mail.e2brain.de [62.159.155.200])
	by ozlabs.org (Postfix) with ESMTP id D2EEA67B53
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Sep 2006 16:58:30 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: How to move from /ppc/ to /powerpc/
Date: Wed, 13 Sep 2006 08:58:24 +0200
Message-ID: <DADA32856852FC458E0F96B664A6F55E011E24CC@kom-mailsrv1.kontron-modular.com>
From: "Claus Gindhart" <claus.gindhart@kontron.com>
To: "Fredrik Roubert" <roubert@df.lth.se>,
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

Hi Fredrik,

i am running a Kontron board (which has the same SoC as the MPC834x_SYS =
onboard) with the Freescale version of the 2.6.17-Kernel, and its =
working well.
Together with my update from 2.6.13 i migrated from arch/ppc to =
arch/powerpc.

The most important modification is (besides changing the ARCH env from =
ppc to powerpc), that your U-Boot has to provide the flattened device =
tree.
Please read Documentation/powerpc/booting-without-of.txt
within the kernel source tree.

So, its mainly an issue for the Bootloader, because many of the board =
dependent definitions is now migrated to the flattened device tree.
The U-Boot, which comes with the Freescale LTIB, supports flattened =
device tree, so the first step is updating U-Boot. Then, the kernel will =
work, if you compile it with ARCH=3Dpowerpc setting.

--=20
Mit freundlichen Gruessen / Best regards

Claus Gindhart
SW R&D
Kontron Modular Computers
phone :++49 (0)8341-803-374
mailto:claus.gindhart@kontron-modular.com
http://www.kontron.com

-----BEGIN GEEK CODE BLOCK-----
  Version: 3.1
  GU d- s++:>++:+ a+ C++$ !U !P L++>$ E-- W+(-) N- o?
  K? w !O !M V !PS PE- Y+ PGP+ t 5? X R* tv- b+ DI+++
  D-- G e++> h--- !r x+++
------END GEEK CODE BLOCK------
=20



-----Original Message-----
From: linuxppc-embedded-bounces+claus.gindhart=3Dkontron.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+claus.gindhart=3Dkontron.com@ozlabs.org=
]
On Behalf Of Fredrik Roubert
Sent: Dienstag, 12. September 2006 17:33
To: linuxppc-embedded@ozlabs.org
Subject: How to move from /ppc/ to /powerpc/


Hi!

I have a custom board on which I currently run Linux 2.6.18-rc6
configured for MPC834x_SYS in the /ppc/ tree, which just a few minor
changes. Now I'm interested to move to using the /powerpc/ source tree
instead, but I can't figure out exactly what steps are necessary to do
this.

Does anyone run a MPC834x_SYS built with ARCH=3Dpowerpc?

I boot the board with U-Boot (version 1.1.4, customized), and I assume
that I need to add some stuff for this new device tree thing, but I
can't figure out exactly what the kernel will expect.

Does anyone have some pointers on how to do this?

Cheers // Fredrik Roubert

--=20
Visserij 192  |  +32 473 344527 / +46 708 776974
BE-9000 Gent  |  http://www.df.lth.se/~roubert/
