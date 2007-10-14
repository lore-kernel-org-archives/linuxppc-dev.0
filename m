Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 42656DDDFF
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Oct 2007 15:59:33 +1000 (EST)
Date: Sun, 14 Oct 2007 15:59:21 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH v3 3/9] add Freescale SerDes PHY support
Message-Id: <20071014155921.0df7e068.sfr@canb.auug.org.au>
In-Reply-To: <1192195728-24189-4-git-send-email-leoli@freescale.com>
References: <1192195728-24189-1-git-send-email-leoli@freescale.com>
	<1192195728-24189-2-git-send-email-leoli@freescale.com>
	<1192195728-24189-3-git-send-email-leoli@freescale.com>
	<1192195728-24189-4-git-send-email-leoli@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sun__14_Oct_2007_15_59_21_+1000_6HHriHOe1Rq5VN7H"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sun__14_Oct_2007_15_59_21_+1000_6HHriHOe1Rq5VN7H
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 12 Oct 2007 21:28:42 +0800 Li Yang <leoli@freescale.com> wrote:
>
> +++ b/arch/powerpc/sysdev/fsl_serdes.c
> +static int __init setup_serdes(struct device_node *np)
> +{
> +	void __iomem *regs;
> +	const void *prot;

Maybe "const char *prot" (it is used as a string).

> +	const unsigned int *freq;
> +	struct resource res;
> +	u32 rfcks;
> +
> +	of_address_to_resource(np, 0, &res);
> +	regs =3D ioremap(res.start, res.end - res.start + 1);
> +
> +	prot =3D of_get_property(np, "protocol", NULL);
> +	if (!prot)
> +		return -EINVAL;
> +	freq =3D of_get_property(np, "clock", NULL);
> +	switch (*freq) {

You should probably check for !freq.  I guess it depends on how much we
trust the device tree.

> +static int __init fsl_serdes_init(void) {
> +	struct device_node *np;
> +
> +	for (np =3D NULL; (np =3D of_find_compatible_node(np, NULL, "fsl,serdes=
")) !=3D NULL;)

	for_each_compatible_node(np, NULL, "fsl,serdes")

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sun__14_Oct_2007_15_59_21_+1000_6HHriHOe1Rq5VN7H
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHEbA/TgG2atn1QN8RAuSGAJ4qcajovdtpyYysbaXpY18O7THuHACgjIkJ
W74O6KQfB372/k9EIsWfb6k=
=G2HP
-----END PGP SIGNATURE-----

--Signature=_Sun__14_Oct_2007_15_59_21_+1000_6HHriHOe1Rq5VN7H--
