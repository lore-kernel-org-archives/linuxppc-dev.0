Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 1DBA5DDF26
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Jul 2008 17:08:24 +1000 (EST)
Date: Wed, 2 Jul 2008 17:08:14 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/85xx: Add support for MPC8536DS
Message-Id: <20080702170814.de282293.sfr@canb.auug.org.au>
In-Reply-To: <Pine.LNX.4.64.0807020201030.24791@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0807020201030.24791@blarg.am.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__2_Jul_2008_17_08_14_+1000_rwm.udh2EaV/iIc6"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__2_Jul_2008_17_08_14_+1000_rwm.udh2EaV/iIc6
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Kumar,

On Wed, 2 Jul 2008 02:01:10 -0500 (CDT) Kumar Gala <galak@kernel.crashing.o=
rg> wrote:
>
> +void __init mpc8536_ds_pic_init(void)
> +{
> +	struct mpic *mpic;
> +	struct resource r;
> +	struct device_node *np =3D NULL;

You don't need to initialise this.

> +	np =3D of_find_node_by_type(np, "open-pic");
> +

Extra blank line.

> +	if (np =3D=3D NULL) {
> +		printk(KERN_ERR "Could not find open-pic node\n");
> +		return;
> +	}
> +
> +	if (of_address_to_resource(np, 0, &r)) {
> +		printk(KERN_ERR "Failed to map mpic register space\n");
> +		of_node_put(np);
> +		return;
> +	}
> +
> +	mpic =3D mpic_alloc(np, r.start,
> +			  MPIC_PRIMARY | MPIC_WANTS_RESET |
> +			  MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS,
> +			0, 256, " OpenPIC  ");
> +	BUG_ON(mpic =3D=3D NULL);
> +
> +	mpic_init(mpic);

You leak a reference to np here.

> +static struct of_device_id mpc8536_ds_ids[] =3D {

__initdata, please.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__2_Jul_2008_17_08_14_+1000_rwm.udh2EaV/iIc6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhrKV4ACgkQjjKRsyhoI8wF0wCdGDYcZVhSxHNBaWR5348scVbb
xlMAn3Em4dLVX6oe8OBa23+GFs0KFo4D
=7nim
-----END PGP SIGNATURE-----

--Signature=_Wed__2_Jul_2008_17_08_14_+1000_rwm.udh2EaV/iIc6--
