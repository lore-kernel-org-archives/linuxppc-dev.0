Return-Path: <claus.gindhart@kontron.com>
Received: from mail.kontron-modular.com (mail.e2brain.de [62.159.155.200])
	by ozlabs.org (Postfix) with ESMTP id 849C467A3B
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Dec 2006 23:33:21 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Rattler 8347 and USB 2.0
Date: Fri, 1 Dec 2006 13:33:18 +0100
Message-ID: <DADA32856852FC458E0F96B664A6F55E011E2733@kom-mailsrv1.kontron-modular.com>
From: "Claus Gindhart" <claus.gindhart@kontron.com>
To: "Jamie Guinan" <guinan@bluebutton.com>,
	"Li Yang-r58472" <LeoLi@freescale.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

you could use a Kontron E2Brain EB8347 Eval-Board instead of the rattler =
board.
It comes with a BSP with a Kernel 2.6.13 including USB 2.0 support. I =
have already tested this port against keyboards, mice, touch controllers =
and memory sticks.

Soon, a Freescale Kernel 2.6.17 with flattened device tree support and =
the appropriate Bootloader for this board will be available (i have =
running it in my office since some months on this platform). This will =
additionally provide the USB transaction handler for USB 1.1 / USB 2.0 =
autonegotiation/switching.

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
On Behalf Of Jamie Guinan
Sent: Freitag, 1. Dezember 2006 07:54
To: Li Yang-r58472
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: Rattler 8347 and USB 2.0


On Fri, 1 Sep 2006, Li Yang-r58472 wrote:

> > -----Original Message-----
> > From:=20
> > linuxppc-embedded-bounces+leoli=3Dfreescale.com@ozlabs.org=20
> > [mailto:linuxppc-embedded-bounces+leoli=3Dfreescale.com@ozlabs.o
> > rg] On Behalf Of Jamie Guinan
> > Sent: Friday, September 01, 2006 12:14 AM
> > To: linuxppc-embedded@ozlabs.org
> > Subject: Rattler 8347 and USB 2.0
> >=20
> >=20
> > Greetings,
> >=20
> > I have an mpc8347 board here (A&M Rattler 8347).  It shipped with a
> > 2.6.16 patched enough to boot the board, but support for=20
> > freescale USB 2.0 (ehci) is not present.
> >=20
> > Working my way backwards in the mainline kernel tree=20
> > (2.6.18-rc5), I found drivers/usb/host/ehci-fsl.c, for=20
> > FreeScale/PPC EHCI support.
> >=20
> > In that module, usb_hcd_fsl_probe() requires an initialized=20
> > "struct fsl_usb2_platform_data", which only appears in=20
> > arch/powerpc/sysdev/fsl_soc.c, yet the 2.6.16 patch provided=20
> > puts the board in arch/ppc.
> >=20
> > My question is, what would be the best way to go about=20
> > getting ehci-fsl.c working with this board?
> >=20
> > 1) Nudge the Rattler port from arch/ppc to arch/powerpc.  One=20
> > problem with this is that the rattler uses RedBoot, and reading =
this,
> >=20
> > =
http://ozlabs.org/pipermail/linuxppc-embedded/2006-August/024116.html
> >=20
> > it looks like arch/powerpc wants to boot from=20
> > OpenFirmware-like "flattened device tree" (does RedBoot=20
> > support this?).
>=20
> Use a shim which directly builds FDT in kernel to use powerpc arch.
> >=20
> > 2) Support ehci-fsl.c from arch/ppc.  If arch/ppc is=20
> > deprecated, that's a bad long-term solution.  And since=20
> > fsl_soc.c lives under arch/powerpc, that doesn't look good either.
>=20
> Actually you don't need fsl_soc.c in ppc arch.  There are predefined
> platform_device and platform_data in =
arch/ppc/syslib/mpc83xx_devices.c.
> You can add your usb platform_data there easily.

So I got back on this (months later), and I added that entry like you=20
suggested (below is against 2.6.17, for reference only, do not apply),

<patch>
--- mpc83xx_devices.c.ori	2006-11-30 01:09:19.000000000 -0500
+++ mpc83xx_devices.c	2006-11-30 01:49:46.000000000 -0500
@@ -64,6 +64,12 @@
 	{ },
 };
=20
+static struct fsl_usb2_platform_data mpc83xx_usb_platform_data =3D {
+	.operating_mode =3D FSL_USB2_MPH_HOST,
+	.phy_mode =3D FSL_USB2_PHY_ULPI,
+	.port_enables =3D FSL_USB2_PORT0_ENABLED |=20
FSL_USB2_PORT1_ENABLED,
+};
+
 struct platform_device ppc_sys_platform_devices[] =3D {
 	[MPC83xx_TSEC1] =3D {
 		.name =3D "fsl-gianfar",
@@ -205,6 +211,7 @@
 	[MPC83xx_USB2_MPH] =3D {
 		.name =3D "fsl-usb2-mph",
 		.id	=3D 1,
+		.dev.platform_data =3D &mpc83xx_usb_platform_data,
 		.num_resources	 =3D 2,
 		.resource =3D (struct resource[]) {
 			{
</patch>

and I was quite pleased to see this on my console on the next
boot,

  fsl-usb2-mph fsl-usb2-mph.1: Freescale On-Chip EHCI Host Controller
  fsl-usb2-mph fsl-usb2-mph.1: new USB bus registered, assigned bus =
number 1
  fsl-usb2-mph fsl-usb2-mph.1: irq 39, io base 0xff022000
  fsl-usb2-mph fsl-usb2-mph.1: USB 2.0 started, EHCI 1.00, driver 10 Dec =
2004
  usb usb1: Product: Freescale On-Chip EHCI Host Controller
  usb usb1: Manufacturer: Linux 2.6.17-1_AM_JSG_NOV29 ehci_hcd
  usb usb1: SerialNumber: fsl-usb2-mph.1
  usb usb1: configuration #1 chosen from 1 choice
  hub 1-0:1.0: USB hub found
  hub 1-0:1.0: 2 ports detected
  Initializing USB Mass Storage driver...

Thanks for that tip.

Next (hopefully minor) hurdle is that I'm not seeing any activity when=20
I plug in a device, and the ehci irq39 line in /proc/interrupts stays=20
at 0.

Some of the PHY signals go through an FPGA on this board, I'm talking=20
to my vendor about that.

-Jamie
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
