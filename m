Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 1A665DDF84
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 10:05:53 +1000 (EST)
Date: Fri, 11 Apr 2008 10:05:41 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH 1/3] powerpc: Add support for Wind River SBC8641D board
Message-Id: <20080411100541.e45b92f4.sfr@canb.auug.org.au>
In-Reply-To: <0006b107cbf99a968352d9369a8e26304d4bf13a.1207868891.git.paul.gortmaker@windriver.com>
References: <1207869739-19892-1-git-send-email-paul.gortmaker@windriver.com>
	<0006b107cbf99a968352d9369a8e26304d4bf13a.1207868891.git.paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__11_Apr_2008_10_05_41_+1000_JbAG.PZCEK9iYkov"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__11_Apr_2008_10_05_41_+1000_JbAG.PZCEK9iYkov
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Paul,

Just a couple of comments.

On Thu, 10 Apr 2008 19:22:17 -0400 Paul Gortmaker <paul.gortmaker@windriver=
.com> wrote:
>
> +++ b/arch/powerpc/platforms/86xx/sbc8641d.c
> +#undef DEBUG
> +
> +#ifdef DEBUG
> +#define DBG(fmt...) do { printk(KERN_ERR fmt); } while(0)
                                   ^^^^^^^^
Not KERN_DEBUG?  Also, if you include linux/kernel.h you can use pr_debug()=
 instead.

> +sbc8641_init_irq(void)
> +{
> +	struct mpic *mpic1;
> +	struct device_node *np;
> +	struct resource res;
> +
> +	/* Determine PIC address. */
> +	np =3D of_find_node_by_type(NULL, "open-pic");
> +	if (np =3D=3D NULL)
> +		return;
> +	of_address_to_resource(np, 0, &res);
> +
> +	/* Alloc mpic structure and per isu has 16 INT entries. */
> +	mpic1 =3D mpic_alloc(np, res.start,
> +			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
> +			0, 256, " MPIC     ");
> +	BUG_ON(mpic1 =3D=3D NULL);
> +
> +	mpic_init(mpic1);

You need an of_node_put(np) in here somewhere (probably after the mpic_allo=
c).

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__11_Apr_2008_10_05_41_+1000_JbAG.PZCEK9iYkov
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH/qtaTgG2atn1QN8RApwsAJ0f+bVoLk/fow79LsuCgzTQ5iqMiACfRr3D
AAhyUyNI4yh2yK5U0gJnDHc=
=X8qk
-----END PGP SIGNATURE-----

--Signature=_Fri__11_Apr_2008_10_05_41_+1000_JbAG.PZCEK9iYkov--
