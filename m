Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 07B10DDD0A
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 18:06:41 +1100 (EST)
Date: Thu, 24 Jan 2008 18:06:35 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] 85xx: Port STX GP3 board over from arch/ppc
Message-Id: <20080124180635.2d91155e.sfr@canb.auug.org.au>
In-Reply-To: <Pine.LNX.4.64.0801240041530.22238@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0801240041530.22238@blarg.am.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__24_Jan_2008_18_06_35_+1100_IQ9B6+OhjSJeDKpH"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__24_Jan_2008_18_06_35_+1100_IQ9B6+OhjSJeDKpH
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Kumar,

On Thu, 24 Jan 2008 00:43:38 -0600 (CST) Kumar Gala <galak@kernel.crashing.=
org> wrote:
>
> Let's see what sfr finds wrong with this patch :)

A challenge! :-)

> +++ b/arch/powerpc/platforms/85xx/stx_gp3.c
> +static void __init stx_gp3_pic_init(void)

> +	np =3D of_find_node_by_type(np, "open-pic");
                                  ^^
Use NULL explicitly and then you don't need to initialise np.

> +	if (of_address_to_resource(np, 0, &r)) {
> +		printk(KERN_ERR "Could not map mpic register space\n");
> +		of_node_put(np);
> +		return;
> +	}
> +
> +	mpic =3D mpic_alloc(np, r.start,
> +			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
> +			0, 256, " OpenPIC  ");
> +	BUG_ON(mpic =3D=3D NULL);

Isn't that a little excessive?

> +	irq =3D irq_of_parse_and_map(np, 0);
> +
> +	cpm2_pic_init(np);
> +	of_node_put(np);
> +	set_irq_chained_handler(irq, cpm2_cascade);

What if irq_of_parse_and_map returns NO_IRQ?

> +static const struct cpm_pin mpc8560_ads_pins[] =3D {

__initdata and not const, please.

> +static int __init stx_gp3_probe(void)
> +{
> +        unsigned long root =3D of_get_flat_dt_root();
> +
> +        return of_flat_dt_is_compatible(root, "stx,gp3-8560");

You should include <asm/prom.h> to use the flattened device tree accessors.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__24_Jan_2008_18_06_35_+1100_IQ9B6+OhjSJeDKpH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHmDj/TgG2atn1QN8RArKRAJkBPGlFIXqOebgr3xAh+pDHNvnivQCfZx7q
KAJSrhzQzx2tgMRwtYbUd8M=
=cWWB
-----END PGP SIGNATURE-----

--Signature=_Thu__24_Jan_2008_18_06_35_+1100_IQ9B6+OhjSJeDKpH--
