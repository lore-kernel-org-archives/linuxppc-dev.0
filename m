Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 65AAFDDF70
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 16:30:04 +1100 (EST)
Date: Wed, 9 Jan 2008 16:29:53 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: [PATCH 2/3 v2] Add initial iomega StorCenter board port.
Message-Id: <20080109162953.c100bc4a.sfr@canb.auug.org.au>
In-Reply-To: <E1JCMbN-0002mN-MD@jdl.com>
References: <E1JCMbN-0002mN-MD@jdl.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__9_Jan_2008_16_29_53_+1100_qabl4gJsvu=_IL2k"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__9_Jan_2008_16_29_53_+1100_qabl4gJsvu=_IL2k
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jon,

On Tue, 08 Jan 2008 16:07:17 -0600 Jon Loeliger <jdl@jdl.com> wrote:
>
> +static void __init storcenter_init_IRQ(void)
> +{
> +	struct mpic *mpic;
> +	struct device_node *dnp;
> +	const void *prop;
> +	int size;
> +	phys_addr_t paddr;
> +
> +	dnp =3D of_find_node_by_type(NULL, "open-pic");
> +	if (dnp =3D=3D NULL)
> +		return;
> +
> +	prop =3D of_get_property(dnp, "reg", &size);
> +	paddr =3D (phys_addr_t)of_translate_address(dnp, prop);
> +	mpic =3D mpic_alloc(dnp, paddr, MPIC_PRIMARY | MPIC_WANTS_RESET,
> +			4, 32, " EPIC     ");
> +	BUG_ON(mpic =3D=3D NULL);

> +	mpic_assign_isu(mpic, 0, paddr + 0x10200);
> +	mpic_assign_isu(mpic, 1, paddr + 0x10220);
> +	mpic_assign_isu(mpic, 2, paddr + 0x10240);
> +	mpic_assign_isu(mpic, 3, paddr + 0x10260);
> +	mpic_assign_isu(mpic, 4, paddr + 0x10280);
> +	mpic_assign_isu(mpic, 5, paddr + 0x11120);
> +	mpic_assign_isu(mpic, 6, paddr + 0x11140);
> +
> +	mpic_init(mpic);
> +}

The above needs a of_node_put(dnp) somewhere.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__9_Jan_2008_16_29_53_+1100_qabl4gJsvu=_IL2k
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHhFvUTgG2atn1QN8RAuvqAJ4vC2We1tslVNwnbaMgHcQhseWBfACfdGi5
JV/NjgTimGs/JjM+MPt6hpk=
=t2ud
-----END PGP SIGNATURE-----

--Signature=_Wed__9_Jan_2008_16_29_53_+1100_qabl4gJsvu=_IL2k--
