Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 174A0DDE20
	for <linuxppc-dev@ozlabs.org>; Mon, 19 May 2008 13:33:54 +1000 (EST)
Date: Mon, 19 May 2008 13:33:37 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jason Jin <Jason.jin@freescale.com>
Subject: Re: [PATCH 2/4 V5] MSI support on 83xx/85xx/86xx board
Message-Id: <20080519133337.31d6281b.sfr@canb.auug.org.au>
In-Reply-To: <1210931447-16234-2-git-send-email-Jason.jin@freescale.com>
References: <1210931447-16234-1-git-send-email-Jason.jin@freescale.com>
	<1210931447-16234-2-git-send-email-Jason.jin@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__19_May_2008_13_33_37_+1000_y3g7+ui0bB=yTl57"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Mon__19_May_2008_13_33_37_+1000_y3g7+ui0bB=yTl57
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jason,

Just a couple of comments.  All of which you may ignore. :-)

On Fri, 16 May 2008 17:50:45 +0800 Jason Jin <Jason.jin@freescale.com> wrot=
e:
>
> +static int fsl_msi_free_dt_hwirqs(struct fsl_msi *msi)
> +{

> +	if ((len % 0x8) !=3D 0) {

why not (len % (2 * sizeof(u32))) ?

> +	/* Format is: (<u32 start> <u32 count>)+ */
> +	len /=3D sizeof(u32);
> +	len /=3D 2;

len /=3D 2 * sizeof(u32);

> +	for (i =3D 0; i < len; i++, p +=3D 2)

for (len /=3D 2 * sizeof(u32); len; len--, p +=3D 2)

These are just style so you can ignore me if you like :-)

> +static int __devinit fsl_of_msi_probe(struct of_device *dev,
> +				const struct of_device_id *match)
> +{
> +	struct fsl_msi *msi;
> +	struct resource res;
> +	int err, i, count;
> +	int rc;
> +	int virt_msir;
> +	const u32 *p;
> +	struct fsl_msi_feature *tmp_data;
> +
> +	printk(KERN_DEBUG "Setting up Freescale MSI support\n");
> +
> +	msi =3D kzalloc(sizeof(struct fsl_msi), GFP_KERNEL);
> +	if (!msi) {
> +		dev_err(&dev->dev, "No memory for MSI structure\n");
> +		err =3D -ENOMEM;
> +		goto error_out;
> +	}
> +
> +	msi->of_node =3D dev->node;

You need to of_node_get dev->node [i.e. msi->of_node =3D
of_node_get(dev->node)] and if you delay this as far as possible, you
won't need of_node_put(msi->of_node) in the erro path.

> +	msi->irqhost =3D irq_alloc_host(of_node_get(dev->node),

irq_alloc_host should do the of_node_get if it needs to. Which it doesn't
(at the moment), so just leave it as you have it and it will be cleaned
up when irq_alloc_host is fixed.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__19_May_2008_13_33_37_+1000_y3g7+ui0bB=yTl57
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIMPUaTgG2atn1QN8RAhxiAJ97OcC6t7rSYiTKCbIm+gPQa7qncACfXKav
Oe1WujG3UlwNjxdS29/n2IU=
=7jD7
-----END PGP SIGNATURE-----

--Signature=_Mon__19_May_2008_13_33_37_+1000_y3g7+ui0bB=yTl57--
