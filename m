Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id AF7A367B6E
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Sep 2006 12:54:14 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k812sC3v025044 for <linuxppc-embedded@ozlabs.org>;
	Thu, 31 Aug 2006 19:54:12 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k812s9PG001297
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 31 Aug 2006 21:54:11 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: Rattler 8347 and USB 2.0
Date: Fri, 1 Sep 2006 10:54:40 +0800
Message-ID: <4879B0C6C249214CBE7AB04453F84E4D0FCAEA@zch01exm20.fsl.freescale.net>
In-Reply-To: <Pine.LNX.4.64.0608291535260.23035@gemini.home.net>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Jamie Guinan" <guinan@bluebutton.com>, <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From:=20
> linuxppc-embedded-bounces+leoli=3Dfreescale.com@ozlabs.org=20
> [mailto:linuxppc-embedded-bounces+leoli=3Dfreescale.com@ozlabs.o
> rg] On Behalf Of Jamie Guinan
> Sent: Friday, September 01, 2006 12:14 AM
> To: linuxppc-embedded@ozlabs.org
> Subject: Rattler 8347 and USB 2.0
>=20
>=20
> Greetings,
>=20
> I have an mpc8347 board here (A&M Rattler 8347).  It shipped with a
> 2.6.16 patched enough to boot the board, but support for=20
> freescale USB 2.0 (ehci) is not present.
>=20
> Working my way backwards in the mainline kernel tree=20
> (2.6.18-rc5), I found drivers/usb/host/ehci-fsl.c, for=20
> FreeScale/PPC EHCI support.
>=20
> In that module, usb_hcd_fsl_probe() requires an initialized=20
> "struct fsl_usb2_platform_data", which only appears in=20
> arch/powerpc/sysdev/fsl_soc.c, yet the 2.6.16 patch provided=20
> puts the board in arch/ppc.
>=20
> My question is, what would be the best way to go about=20
> getting ehci-fsl.c working with this board?
>=20
> 1) Nudge the Rattler port from arch/ppc to arch/powerpc.  One=20
> problem with this is that the rattler uses RedBoot, and reading this,
>=20
> http://ozlabs.org/pipermail/linuxppc-embedded/2006-August/024116.html
>=20
> it looks like arch/powerpc wants to boot from=20
> OpenFirmware-like "flattened device tree" (does RedBoot=20
> support this?).

Use a shim which directly builds FDT in kernel to use powerpc arch.
>=20
> 2) Support ehci-fsl.c from arch/ppc.  If arch/ppc is=20
> deprecated, that's a bad long-term solution.  And since=20
> fsl_soc.c lives under arch/powerpc, that doesn't look good either.

Actually you don't need fsl_soc.c in ppc arch.  There are predefined
platform_device and platform_data in arch/ppc/syslib/mpc83xx_devices.c.
You can add your usb platform_data there easily.
