Return-Path: <Wei.Zhang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E0598DDEC7
	for <linuxppc-dev@ozlabs.org>; Fri, 18 May 2007 20:20:29 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l4IAKNrP000497
	for <linuxppc-dev@ozlabs.org>; Fri, 18 May 2007 03:20:24 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l4IAKMdi027056
	for <linuxppc-dev@ozlabs.org>; Fri, 18 May 2007 05:20:23 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 5/5] PCI fixes for the MPC8641 Rev 2.0 silicon and
	Rev1.02hardware
Date: Fri, 18 May 2007 18:20:21 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C23466B@zch01exm26.fsl.freescale.net>
In-Reply-To: <1179421139.8132.256.camel@rhino>
References: <1179245829.8132.100.camel@rhino> <1179247809.8132.138.camel@rhino>
	<46B96294322F7D458F9648B60E15112C23441B@zch01exm26.fsl.freescale.net>
	<1179417813.8132.250.camel@rhino>
	<744CD970-5421-47D6-A30A-C7C79BE21BE8@kernel.crashing.org>
	<1179421139.8132.256.camel@rhino>
From: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
To: "Wade Farnsworth" <wfarnsworth@mvista.com>,
	"Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

For support rev 1.0 boards, you can only remove the
pci@00:pci@00:interrupt-map sector. The pci driver can use
pci@8000:interrupt-map for irq mapping.

Such as below:

diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
index 260b264..04626b1 100644
--- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
+++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
@@ -297,6 +297,12 @@
 				interrupts =3D <49 2>;
 				interrupt-parent =3D <&mpic>;
 			};
+			uli1575: uli1575@100 {
+				reg =3D <0 0 0 0 0>;
+				pci_bridge@200 {
+					reg =3D <0 0 0 0 0>;
+				};
+			};
=20
 		};

Cheers,
Wei
> > On May 17, 2007, at 11:03 AM, Wade Farnsworth wrote:
> >=20
> > > On Thu, 2007-05-17 at 10:50 +0800, Zhang Wei-r63237 wrote:
> > >> Hi,
> > >>
> > >> If you add below sector to pci@8000, please remove the=20
> interrupt-map
> > >> sector from pci@8000.
> > >
> > > Correct me if I'm wrong, but I think if the interrupt-map=20
> for pci@8000
> > > is removed then the pci devices on the revision 1.0 board=20
> will not get
> > > the correct interrupts.  I don't currently have a rev 1.0 to test
> > > though.  Can someone with a rev 1.0 HPCN board confirm this?
> >=20
> > If I'm understanding things this might best be handled by two =20
> > different dts.  Is this because of board changes or chip/silicon =20
> > changes?
> >=20
> > - k
> >=20
>=20
> Yes.  On rev 1.0 boards, all of the devices on the south bridge are on
> bus 0, while on rev 1.02, the devices on the southbridge are on bus 2.
>=20
> I'd like to use the same dts for both rev's if possible.  But if there
> is a reason why they shouldn't, I suppose I could create a=20
> separate dts.
>=20
> --Wade
>=20
>=20
