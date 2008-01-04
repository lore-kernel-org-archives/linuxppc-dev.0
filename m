Return-Path: <Wei.Zhang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3E650DDE0A
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jan 2008 19:05:16 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m0481voH007172
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Jan 2008 01:05:00 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m0472frL015484
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Jan 2008 01:02:42 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 2/3] (Resend part #1) Add the RapidIO support to
	powerpcarchitecture with memory mapping support.
Date: Fri, 4 Jan 2008 15:02:42 +0800
Message-ID: <ABF87B0B6A38C0458E319AC973ED68AEACF8A0@zch01exm26.fsl.freescale.net>
In-Reply-To: <20071223093911.3fd4d1e5.sfr@canb.auug.org.au>
References: <11982311233889-git-send-email-wei.zhang@freescale.com>
	<20071223093911.3fd4d1e5.sfr@canb.auug.org.au>
From: "Zhang Wei" <Wei.Zhang@freescale.com>
To: "Stephen Rothwell" <sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, =20

Thanks!

Maybe I should make a clean and split them into small patches.

Cheers!
Wei.

> Hi,
>=20
> This is a very large patch.  It may be easier to review if it could be
> split on some logical way, that is at all possible (I don't=20
> know either
> way).  This is just a quick note about some more trivial things.
>=20
> On Fri, 21 Dec 2007 17:58:43 +0800 Zhang Wei=20
> <wei.zhang@FREESCALE.COM> wrote:
> >
> > +struct rio_priv {
> > +	volatile void __iomem *regs_win;
> > +	volatile struct rio_atmu_regs __iomem *atmu_regs;
> > +	volatile struct rio_atmu_regs __iomem *maint_atmu_regs;
> > +	volatile struct rio_atmu_regs __iomem *dbell_atmu_regs;
> > +	volatile void __iomem *dbell_win;
> > +	volatile void __iomem *maint_win;
> > +	volatile struct rio_msg_regs __iomem *msg_regs;
>=20
> Paulus has said that any pointer marked __iomem does not need to be
> volatile ...
>=20
> > +static int of_cells_get(struct device_node *np, const char *str)
> > +{
> > +	struct device_node *tmp =3D NULL;
> > +	const int *var =3D NULL;
>=20
> These initializations are unnecessary.
>=20
> > +	var =3D of_get_property(np, str, NULL);
> > +	tmp =3D of_get_parent(np);
> > +
> > +	while (!var && tmp) {
> > +		var =3D (int *)of_get_property(tmp, str, NULL);
>=20
> While I applaud the number of casts remove by this patch,=20
> this one is an
> unnecessary addition.
>=20
> > +		of_node_put(tmp);
> > +		tmp =3D of_get_parent(np);
>=20
> You should do the above two line in the opposite order. Also do you
> really want to keep getting the parent of the same node over and over
> (i.e. you never change np)?
>=20
> > +	}
>=20
> You probably want a final of_node_put(tmp).
>=20
>=20
> > +	INFO("Phy type: ");
> > +	switch (phy_type) {
> > +	case RIO_PHY_SERIAL:
> > +		printk("serial\n");
> > +		break;
> > +	case RIO_PHY_PARALLEL:
> > +		printk("parallel");
>=20
> Missing \n
>=20
> > +	port =3D kzalloc(sizeof(struct rio_mport), GFP_KERNEL);
> > +	if (!port) {
> > +		ERR("Can't alloc memory for 'port'\n");
> > +		rc =3D -ENOMEM;
> > +		goto err;
> > +	}
> >  	port->id =3D 0;
> >  	port->index =3D 0;
>=20
> These two could go as you just allocated zeroed memory.
>=20
> --=20
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au
> http://www.canb.auug.org.au/~sfr/
>=20
