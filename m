Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 49945DDDF3
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Dec 2007 09:39:20 +1100 (EST)
Date: Sun, 23 Dec 2007 09:39:11 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Zhang Wei <wei.zhang@FREESCALE.COM>
Subject: Re: [PATCH 2/3] (Resend part #1) Add the RapidIO support to powerpc
	architecture with memory mapping support.
Message-Id: <20071223093911.3fd4d1e5.sfr@canb.auug.org.au>
In-Reply-To: <11982311233889-git-send-email-wei.zhang@freescale.com>
References: <11982311233889-git-send-email-wei.zhang@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sun__23_Dec_2007_09_39_11_+1100_eY6fKJf9ig6FVyk+"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sun__23_Dec_2007_09_39_11_+1100_eY6fKJf9ig6FVyk+
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

This is a very large patch.  It may be easier to review if it could be
split on some logical way, that is at all possible (I don't know either
way).  This is just a quick note about some more trivial things.

On Fri, 21 Dec 2007 17:58:43 +0800 Zhang Wei <wei.zhang@FREESCALE.COM> wrot=
e:
>
> +struct rio_priv {
> +	volatile void __iomem *regs_win;
> +	volatile struct rio_atmu_regs __iomem *atmu_regs;
> +	volatile struct rio_atmu_regs __iomem *maint_atmu_regs;
> +	volatile struct rio_atmu_regs __iomem *dbell_atmu_regs;
> +	volatile void __iomem *dbell_win;
> +	volatile void __iomem *maint_win;
> +	volatile struct rio_msg_regs __iomem *msg_regs;

Paulus has said that any pointer marked __iomem does not need to be
volatile ...

> +static int of_cells_get(struct device_node *np, const char *str)
> +{
> +	struct device_node *tmp =3D NULL;
> +	const int *var =3D NULL;

These initializations are unnecessary.

> +	var =3D of_get_property(np, str, NULL);
> +	tmp =3D of_get_parent(np);
> +
> +	while (!var && tmp) {
> +		var =3D (int *)of_get_property(tmp, str, NULL);

While I applaud the number of casts remove by this patch, this one is an
unnecessary addition.

> +		of_node_put(tmp);
> +		tmp =3D of_get_parent(np);

You should do the above two line in the opposite order. Also do you
really want to keep getting the parent of the same node over and over
(i.e. you never change np)?

> +	}

You probably want a final of_node_put(tmp).


> +	INFO("Phy type: ");
> +	switch (phy_type) {
> +	case RIO_PHY_SERIAL:
> +		printk("serial\n");
> +		break;
> +	case RIO_PHY_PARALLEL:
> +		printk("parallel");

Missing \n

> +	port =3D kzalloc(sizeof(struct rio_mport), GFP_KERNEL);
> +	if (!port) {
> +		ERR("Can't alloc memory for 'port'\n");
> +		rc =3D -ENOMEM;
> +		goto err;
> +	}
>  	port->id =3D 0;
>  	port->index =3D 0;

These two could go as you just allocated zeroed memory.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sun__23_Dec_2007_09_39_11_+1100_eY6fKJf9ig6FVyk+
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHbZIVTgG2atn1QN8RAvZdAKCZq6ZaJeClWP9NnEB/CTqJPuW7/ACfaw89
m119sHZ5gNsXPB9/OJaoxk8=
=ZHf6
-----END PGP SIGNATURE-----

--Signature=_Sun__23_Dec_2007_09_39_11_+1100_eY6fKJf9ig6FVyk+--
