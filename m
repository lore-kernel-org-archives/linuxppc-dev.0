Return-Path: <Jason.Jin@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 89734DDE2D
	for <linuxppc-dev@ozlabs.org>; Fri, 18 May 2007 16:52:23 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l4I6qHKs019971
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 23:52:18 -0700 (MST)
Received: from zch01exm27.fsl.freescale.net (zch01exm27.ap.freescale.net
	[10.192.129.223])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l4I6qGRx020911
	for <linuxppc-dev@ozlabs.org>; Fri, 18 May 2007 01:52:17 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 5/5] PCI fixes for the MPC8641 Rev 2.0 silicon and Rev1.02
	hardware
Date: Fri, 18 May 2007 14:52:14 +0800
Message-ID: <CC27DED0F8F39E48A7E75FD768688B7A2FD493@zch01exm27.fsl.freescale.net>
In-Reply-To: <1179338794.8132.209.camel@rhino>
From: "Jin Zhengxiong-R64188" <Jason.Jin@freescale.com>
To: "Wade Farnsworth" <wfarnsworth@mvista.com>,
	"Loeliger Jon-LOELIGER" <jdl@freescale.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: linuxppc-dev-bounces+jinzhengxiong=3Dgmail.com@ozlabs.org=20
> [mailto:linuxppc-dev-bounces+jinzhengxiong=3Dgmail.com@ozlabs.or
> g] On Behalf Of Wade Farnsworth
> Sent: Thursday, May 17, 2007 2:07 AM
> To: Loeliger Jon-LOELIGER
> Cc: linuxppc-dev
> Subject: Re: [PATCH 5/5] PCI fixes for the MPC8641 Rev 2.0=20
> silicon and Rev1.02 hardware
>=20
> On Wed, 2007-05-16 at 11:44 -0500, Jon Loeliger wrote:
> > On Tue, 2007-05-15 at 11:50, Wade Farnsworth wrote:
> > > +static void __devinit early_mpc86xx_pcie(struct pci_dev *dev) {
> > > +	   dev->class =3D PCI_CLASS_BRIDGE_PCI << 8 | 0x1; }
> >=20
> > What'd we decide on that 0x1 in there?
> >=20
> > Thanks,
> > jdl
> >=20
> >=20
>=20
> I originally thought that it the 0x1 was necessary, but it=20
> was pointed out to me that it should not be.
>=20
> If I remove the 0x1 I get some I/O resource allocation=20
> failures on the P2P bridge and its child devices.  I'm=20
> currently investigating what the cause of this is.

> --Wade
>=20

As you changed the class of the bridge, dev->transparent will be set
again in the later  code, if you remove the 0x01 here, the
dev->transparent will be set to 0 later. So if you changed the class
like this, you do not need to set  dev->transparent =3D 1 in your patch.

Jason=20




>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>=20
