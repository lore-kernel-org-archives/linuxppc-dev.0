Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id B4E9EDDEBA
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 11:32:32 +1100 (EST)
Date: Tue, 8 Jan 2008 11:32:19 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH 3/7] sbc8560: add support for Wind River SBC8560 in
	arch/powerpc
Message-Id: <20080108113219.860ac365.sfr@canb.auug.org.au>
In-Reply-To: <11997159352727-git-send-email-paul.gortmaker@windriver.com>
References: <11997159321859-git-send-email-paul.gortmaker@windriver.com>
	<11997159331132-git-send-email-paul.gortmaker@windriver.com>
	<11997159342128-git-send-email-paul.gortmaker@windriver.com>
	<11997159352727-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__8_Jan_2008_11_32_19_+1100_w.R6p1Dz.Qs=bc4n"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__8_Jan_2008_11_32_19_+1100_w.R6p1Dz.Qs=bc4n
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Mon,  7 Jan 2008 09:25:28 -0500 Paul Gortmaker <paul.gortmaker@windriver=
.com> wrote:
>
> +++ b/arch/powerpc/platforms/85xx/sbc8560.c
>
> +static void __init sbc8560_pic_init(void)
> +{
>
> +#ifdef CONFIG_CPM2
> +	/* Setup CPM2 PIC */
> +	np =3D of_find_compatible_node(NULL, NULL, "fsl,cpm2-pic");
> +	if (np =3D=3D NULL) {
> +		printk(KERN_ERR "PIC init: can not find fsl,cpm2-pic node\n");
> +		return;
> +	}
> +	irq =3D irq_of_parse_and_map(np, 0);

What happens if that fails?

> +
> +	cpm2_pic_init(np);
> +	of_node_put(np);
> +	set_irq_chained_handler(irq, cpm2_cascade);

Does passing NO_IRQ matter here (in the case that irq_of_parse_and_map fail=
s)?

> +static const struct cpm_pin sbc8560_pins[] =3D {

Of course, these could be __initdata (but not const as well).  Sorry
about not mentioning this last time and it is a trivial change that
should not stop this stuff going in.

> +static int __init sbc8560_probe(void)
> +{
> +        unsigned long root =3D of_get_flat_dt_root();
> +
> +        return of_flat_dt_is_compatible(root, "SBC8560");

To use the flattened device tree accessors, you should include asm/prom.h

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__8_Jan_2008_11_32_19_+1100_w.R6p1Dz.Qs=bc4n
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHgsSaTgG2atn1QN8RApS7AJ0Vr0YSH14tftrFTCvwC0sriLR2RQCdGYu7
3uXm8JwOE9bcBH6fmLVrx0U=
=x9v/
-----END PGP SIGNATURE-----

--Signature=_Tue__8_Jan_2008_11_32_19_+1100_w.R6p1Dz.Qs=bc4n--
