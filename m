Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 8ED61DDE37
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 10:14:36 +1100 (EST)
Date: Fri, 21 Dec 2007 10:14:25 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH 1/4] sbc8560: add basic support for Wind River SBC8560
	as powerpc
Message-Id: <20071221101425.3408278c.sfr@canb.auug.org.au>
In-Reply-To: <11981624732110-git-send-email-paul.gortmaker@windriver.com>
References: <11981624722785-git-send-email-paul.gortmaker@windriver.com>
	<11981624732110-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__21_Dec_2007_10_14_25_+1100_5fm4AwXxiBFk3wRc"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__21_Dec_2007_10_14_25_+1100_5fm4AwXxiBFk3wRc
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Paul,

Just a couple of comments.

On Thu, 20 Dec 2007 09:54:29 -0500 Paul Gortmaker <paul.gortmaker@windriver=
.com> wrote:
>
> +++ b/arch/powerpc/platforms/85xx/sbc8560.c
> +static void cpm2_cascade(unsigned int irq, struct irq_desc *desc)
> +{
> +	int cascade_irq;
> +
> +	while ((cascade_irq =3D cpm2_get_irq()) >=3D 0) {
> +		generic_handle_irq(cascade_irq);
> +	}

The braces are unnecessary.

> +static void __init sbc8560_pic_init(void)
> +{
> +	struct mpic *mpic;
> +	struct resource r;
> +	struct device_node *np =3D NULL;
> +#ifdef CONFIG_CPM2
> +	int irq;
> +#endif
> +
> +	np =3D of_find_node_by_type(np, "open-pic");
> +
> +	if (np =3D=3D NULL) {

We often say "if (!np)" and leave out the blank line above.

> +	if(of_address_to_resource(np, 0, &r)) {
          ^
Put a space here.

> +#ifdef CONFIG_CPM2
> +	/* Setup CPM2 PIC */
> +	np =3D of_find_compatible_node(NULL, NULL, "fsl,cpm2-pic");
> +	if (np =3D=3D NULL) {
> +		printk(KERN_ERR "PIC init: can not find fsl,cpm2-pic node\n");
> +		return;
> +	}
> +	irq =3D irq_of_parse_and_map(np, 0);
> +
> +	cpm2_pic_init(np);

Need an of_node_pit(np) - cpm2_pic_init() does its own of_node_get.

> +static struct cpm_pin sbc8560_pins[] =3D {

const?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__21_Dec_2007_10_14_25_+1100_5fm4AwXxiBFk3wRc
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD4DBQFHavdaTgG2atn1QN8RAltCAJ9TsSMguXAbwXpr1vyEz1sOdce6XwCWLiWI
gg0rknTfd4DiGPDMvJzsig==
=ODr5
-----END PGP SIGNATURE-----

--Signature=_Fri__21_Dec_2007_10_14_25_+1100_5fm4AwXxiBFk3wRc--
