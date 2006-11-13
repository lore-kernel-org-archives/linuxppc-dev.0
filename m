Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 14/16] powerpc: add ps3 platform OS params support
From: Michael Ellerman <michael@ellerman.id.au>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <4557E45C.10703@am.sony.com>
References: <4554DB20.9020200@am.sony.com>
	<1163381393.7410.39.camel@localhost.localdomain>
	<4557E45C.10703@am.sony.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-JHm6JdQCln6H/EEKgkIW"
Date: Mon, 13 Nov 2006 15:02:16 +1100
Message-Id: <1163390536.7410.61.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-JHm6JdQCln6H/EEKgkIW
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2006-11-12 at 19:19 -0800, Geoff Levand wrote:
> > Is it an offset (from something) or a segment number?
> >=20
> >> + * @ldr_format: ldr_format flag.
> >> + * @ldr_size: Size of bootloader image in bytes.
> >=20
> > If these three all describe the same thing, the bootloader, it'd be goo=
d
> > if the names were similar, eg: bootloader_offset, bootloader_format,
> > bootloader_size.
>=20
>=20
> These names came from the docs.  I think it would be best to keep them th=
e
> same to avoid confusion.

I'm not sure I like that argument, if we followed it throughout the
kernel we'd have one unholy mess, but I'm not that fussed.

>=20
> It is not so convenient to view, but the other os area is documented in t=
he
> iso image CELL-Linux-CL_20061110-ADDON.iso at
> http://ftp.uk.linux.org/pub/linux/Sony-PS3/.

Any chance we can get that in some sort of non-insane format? Like a
PDF? :)
=20
> >> +static int __init verify_header(const struct header *header)
> >> +{
> >> +	if (memcmp(header->magic_num, "cell_ext_os_area", 16)) {
> >> +		pr_debug("%s:%d magic_num failed\n", __func__, __LINE__);
> >> +		return -1;
> >> +	}
> >> +
> >> +	if (header->hdr_version !=3D 1) {
> >> +		pr_debug("%s:%d hdr_version failed\n", __func__, __LINE__);
> >> +		return -1;
> >> +	}
> >=20
> > Is version 2 not going to be backward compatible? Could it be >=3D 1 ?
>=20
>=20
> I have absolutely no clue what the next version number will be, nor the
> compatibility, etc.  I'll set this when the version changes.

Except you'll have trouble changing it on the installed base of millions
of PS3s running Linux :) - At the moment if firmware bump the version on
you, you've got an unbootable system until the user does a kernel
upgrade. But it's your baby.

>=20
>=20
> >> +	dump_header(header);
> >> +	dump_params(params);
> >> +
> >> +	os_params.rtc_diff =3D params->rtc_diff;
> >> +	os_params.av_multi_out =3D params->av_multi_out;
> >> +	if (0) { /* currently not used */
> >=20
> > Why not?
>=20
>=20
> The drivers aren't ported yet.  I suppose I could take this out though.

Not fussed, but if you leave it in, expand the comment so no one else
needs to ask :)

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-JHm6JdQCln6H/EEKgkIW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFV+5IdSjSd0sB4dIRAr+PAJwJLsUm4ppQRKypaeg8qPWl9ZbxjwCeNabe
hmrUtJvsL+vW3VfG60/BxaE=
=y8Ro
-----END PGP SIGNATURE-----

--=-JHm6JdQCln6H/EEKgkIW--
