Return-Path: <Jason.Jin@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5201BDDF7E
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 12:25:11 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m4K2Oadw006298
	for <linuxppc-dev@ozlabs.org>; Mon, 19 May 2008 19:25:06 -0700 (MST)
Received: from zch01exm27.fsl.freescale.net (zch01exm27.ap.freescale.net
	[10.192.129.223])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m4K2OYRC015921
	for <linuxppc-dev@ozlabs.org>; Mon, 19 May 2008 21:24:35 -0500 (CDT)
MIME-Version: 1.0
Subject: RE: [PATCH 2/4 V5] MSI support on 83xx/85xx/86xx board
Content-Type: text/plain;
	charset="US-ASCII"
Date: Tue, 20 May 2008 10:24:33 +0800
Message-ID: <CC27DED0F8F39E48A7E75FD768688B7A8C1ED0@zch01exm27.fsl.freescale.net>
In-Reply-To: <20080519133337.31d6281b.sfr@canb.auug.org.au>
References: <1210931447-16234-1-git-send-email-Jason.jin@freescale.com><1210931447-16234-2-git-send-email-Jason.jin@freescale.com>
	<20080519133337.31d6281b.sfr@canb.auug.org.au>
From: "Jin Zhengxiong" <Jason.Jin@freescale.com>
To: "Stephen Rothwell" <sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Stephen,

Thanks for the comments,  I'd like to clean up some of the
codes by patch after some updates(such as irq_alloc_host you
mentioned).

Jason=20
> -----Original Message-----
> From: Stephen Rothwell [mailto:sfr@canb.auug.org.au]=20
> Sent: Monday, May 19, 2008 11:34 AM
> To: Jin Zhengxiong
> Cc: galak@kernel.crashing.org; linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH 2/4 V5] MSI support on 83xx/85xx/86xx board
>=20
> Hi Jason,
>=20
> Just a couple of comments.  All of which you may ignore. :-)
>=20
> On Fri, 16 May 2008 17:50:45 +0800 Jason Jin=20
> <Jason.jin@freescale.com> wrote:
> >
> > +static int fsl_msi_free_dt_hwirqs(struct fsl_msi *msi) {
>=20
> > +	if ((len % 0x8) !=3D 0) {
>=20
> why not (len % (2 * sizeof(u32))) ?
>=20
> > +	/* Format is: (<u32 start> <u32 count>)+ */
> > +	len /=3D sizeof(u32);
> > +	len /=3D 2;
>=20
> len /=3D 2 * sizeof(u32);
>=20
> > +	for (i =3D 0; i < len; i++, p +=3D 2)
>=20
> for (len /=3D 2 * sizeof(u32); len; len--, p +=3D 2)
>=20
> These are just style so you can ignore me if you like :-)
>=20
> > +static int __devinit fsl_of_msi_probe(struct of_device *dev,
> > +				const struct of_device_id *match) {
> > +	struct fsl_msi *msi;
> > +	struct resource res;
> > +	int err, i, count;
> > +	int rc;
> > +	int virt_msir;
> > +	const u32 *p;
> > +	struct fsl_msi_feature *tmp_data;
> > +
> > +	printk(KERN_DEBUG "Setting up Freescale MSI support\n");
> > +
> > +	msi =3D kzalloc(sizeof(struct fsl_msi), GFP_KERNEL);
> > +	if (!msi) {
> > +		dev_err(&dev->dev, "No memory for MSI structure\n");
> > +		err =3D -ENOMEM;
> > +		goto error_out;
> > +	}
> > +
> > +	msi->of_node =3D dev->node;
>=20
> You need to of_node_get dev->node [i.e. msi->of_node =3D=20
> of_node_get(dev->node)] and if you delay this as far as=20
> possible, you won't need of_node_put(msi->of_node) in the erro path.
>=20
> > +	msi->irqhost =3D irq_alloc_host(of_node_get(dev->node),
>=20
> irq_alloc_host should do the of_node_get if it needs to.=20
> Which it doesn't (at the moment), so just leave it as you=20
> have it and it will be cleaned up when irq_alloc_host is fixed.
>=20
> --
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au
> http://www.canb.auug.org.au/~sfr/
>=20
