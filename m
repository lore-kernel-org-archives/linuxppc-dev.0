Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D2A3BDDF14
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 22:31:15 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l9FCV7C5008942
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 05:31:07 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l9FCV5i9025322
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 07:31:06 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH v3 3/9] add Freescale SerDes PHY support
Date: Mon, 15 Oct 2007 20:30:46 +0800
Message-ID: <989B956029373F45A0B8AF0297081890019B590F@zch01exm26.fsl.freescale.net>
In-Reply-To: <200710121633.49263.arnd@arndb.de>
References: <1192195728-24189-1-git-send-email-leoli@freescale.com><1192195728-24189-3-git-send-email-leoli@freescale.com><1192195728-24189-4-git-send-email-leoli@freescale.com>
	<200710121633.49263.arnd@arndb.de>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Arnd Bergmann" <arnd@arndb.de>, <linuxppc-dev@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org=20
> [mailto:linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org]=20
> On Behalf Of Arnd Bergmann
> Sent: Friday, October 12, 2007 10:34 PM
> To: linuxppc-dev@ozlabs.org
> Cc: linuxppc-dev@ozlabs.org; paulus@samba.org
> Subject: Re: [PATCH v3 3/9] add Freescale SerDes PHY support
>=20
> On Friday 12 October 2007, Li Yang wrote:
> > The SerDes(serializer/deserializer) PHY block is a new SoC=20
> block used=20
> > in Freescale chips to support multiple serial interfaces,=20
> such as PCI=20
> > Express, SGMII, SATA.
>=20
> Some of my comments here are similar to those for the ata=20
> driver, so I won't be as verbose here
>=20
> > +static int __init setup_serdes(struct device_node *np) {
> > +	void __iomem *regs;
> > +	const void *prot;
> > +	const unsigned int *freq;
> > +	struct resource res;
> > +	u32 rfcks;
> > +
> > +	of_address_to_resource(np, 0, &res);
> > +	regs =3D ioremap(res.start, res.end - res.start + 1);
>=20
> of_iomap?

I'd like to but of_iomap() couldn't provide the physical address of the
device used as identification.

- Leo
