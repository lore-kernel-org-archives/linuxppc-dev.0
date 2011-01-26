Return-Path: <lasaine@lvk.cs.msu.su>
Received: from mail.lvk.cs.msu.su (gate.lvk.cs.msu.su [158.250.17.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.lvk.cs.msu.su", Issuer "CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id EC3A41007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 Jan 2011 04:36:09 +1100 (EST)
Date: Wed, 26 Jan 2011 20:35:58 +0300
From: Alexander Gordeev <lasaine@lvk.cs.msu.su>
To: "David Laight" <David.Laight@ACULAB.COM>
Subject: Re: [PATCH V8 03/10] USB/ppc4xx: Add Synopsys DWC OTG CoreInterface
	Layer
Message-ID: <20110126203558.4d2ed74e@desktopvm.lvknet>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8AC2C@saturn3.aculab.com>
References: <20110126191734.5dff9641@desktopvm.lvknet>
	<AE90C24D6B3A694183C094C60CF0A2F6D8AC2C@saturn3.aculab.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA256;
	boundary="Sig_/bIA4kTh0X2C5FMF27oy94IS";
	protocol="application/pgp-signature"
Cc: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/bIA4kTh0X2C5FMF27oy94IS
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

=D0=92 Wed, 26 Jan 2011 16:35:05 -0000
"David Laight" <David.Laight@ACULAB.COM> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> =20
> > Also in_le32/out_le32/in_be32/out_be32 are=20
> > architecture-specific AFAIK.
>=20
> Isn't the whole patch architecture-specific ?

I use this driver on MIPS board right now. :)
This core from Synopsys is used in many SOCs with various architectures.

> > I'd suggest using readl/writel for LE ops and
> > __be32_to_cpu(__raw_readl(addr))/__raw_writel(__cpu_to_be32(b),addr)
> > for BE ops.
>=20
> Since the ppc doesn't have a byteswap instruction (and the LE
> memory transfers might even be slow!) you really don't want to
> be doing software byteswap.
>=20
> Not to mention the horrific synchronistion instructions
> that in_le32() and out_le32() actually contain.
>=20
> I didn't find __raw_readl() when I was looking for asm
> patterns that byteswapped memory transfers.
>=20
> I did find st_le32() and ld_le32() in arch/powerpc/include/asm/swab.h
> but that file is actually quite difficult to #include because
> there is another swab.h that gets included instead.

I see. readl/writel are defined in asm-generic/io.h. So IMHO there
should be also le and be versions that can be redefined in
arch-specific code.

--=20
  Alexander

--Sig_/bIA4kTh0X2C5FMF27oy94IS
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBCAAGBQJNQFt+AAoJEElrwznyooJb8SQIAIyhKdD6VNlbE8H8ZfHy/82T
l0p5QXvK+PKE4HQeo728694Nx+/xs/bWZgtnWjJ3W0XZF+rFMP1ZL86jvPR4GimR
uk5llaUlICLW+Ybs+U5ZnCcJ91P45ku6exWxgdckh1RKokwtyLduEtm6dmYdg/CH
A3JrLBYLSYJLLKZQfaefLeH2ygdiGzqqya9k0jB5XAZ4xhH0ozNLNnq76QkZLMNI
h9gygurPRECH5yhi2EwyGhZbPWHbZAofcPwF2GE9VzaQfcsEZ/SaDVVXDKuw/oqZ
1O+ywUmUt8bd/vFEWbckh2zWfVZLV8Wss+3Rmjv2Q91JbDUVtIYoJtR4/tjLdTY=
=8d8X
-----END PGP SIGNATURE-----

--Sig_/bIA4kTh0X2C5FMF27oy94IS--
