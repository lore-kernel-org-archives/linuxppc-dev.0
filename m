Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.pcug.org.au [203.10.76.10])
 by ozlabs.org (Postfix) with ESMTP id 6F0922C0122
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2013 13:08:45 +1000 (EST)
Date: Fri, 26 Apr 2013 13:08:44 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 5/13] Use ARRAY_SIZE to iterate over
 firmware_features_table array
Message-Id: <20130426130844.52bb646e98c6f5233f263bf3@canb.auug.org.au>
In-Reply-To: <5178005C.1070204@linux.vnet.ibm.com>
References: <5177FB74.2050709@linux.vnet.ibm.com>
 <5178005C.1070204@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Fri__26_Apr_2013_13_08_44_+1000_rNv/K23078w_.NVb"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Fri__26_Apr_2013_13_08_44_+1000_rNv/K23078w_.NVb
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nathan,

On Wed, 24 Apr 2013 10:55:08 -0500 Nathan Fontenot <nfont@linux.vnet.ibm.co=
m> wrote:
>
> When iterating over the entries in firmware_features_table we only need
> to go over the actual number of entries in the array instead of declaring
> it to be bigger and checking to make sure there is a valid entry in every
> slot.
>=20
> This patch removes the FIRMWARE_MAX_FEATURES #define and replaces the
> array looping with the use of ARRAY_SIZE().
>=20

Suggested-by: Stephen Rothwell <sfr@canb.auug.org.au>

> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> @@ -77,12 +77,10 @@
>  	pr_debug(" -> fw_feature_init()\n");
> =20
>  	for (s =3D hypertas; s < hypertas + len; s +=3D strlen(s) + 1) {
> -		for (i =3D 0; i < FIRMWARE_MAX_FEATURES; i++) {
> +		for (i =3D 0; i < ARRAY_SIZE(firmware_features_table); i++) {

You should explicitly include linux/kernel.h to use ARRAY_SIZE().

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Fri__26_Apr_2013_13_08_44_+1000_rNv/K23078w_.NVb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJRee+8AAoJEECxmPOUX5FErRgP/RrI9gYelbFjZSiI+8fJNerj
VXZj6rrW+kpBf6WbydkgLWUnr2V/QCNFdmpUUKIeSwopoaM4o4AjgDHA1gZ9eapk
3A2fHeTsfqYp/yJGUbL9L2Y9ecxBqZHQkBmoKR3P6fHftrUY6d0Y9IuzsVJuh0cJ
NJVvj0Kt8srfsTe2Y3sJkKycHskNLw0ZGYEYe9vmSI2UFEjz2epRmgcuhnfG3pGL
Svt1SpseyAo+VTz5YvwqS5Y4alI8P5j8jta0npfPiEs82xFTNhVeuHYi3gPCwYmw
PFPe17D+MyB6qgfTJgPZIgObP3PksF9DWHPYILu1L4yIKvCup1WHueiQQozIKmcU
6tT7IV+XpF1PFCTXU5PObmO8r+C7i3l2umyDbMVcM0TH8Kb7ifY6Ds975QnNRRy0
MFSMTvNtgRmpjR6KBhMpYqCuImTXXm7xqY9KJ4h5O7tuH2gqTiXlLuxNg/L6tApU
RsaG9cbvXy+S+GgHLJnbvdUsnm06XWi/ReK2b/Wer4vNSpBmGCehjiY0TyTCcH9O
AeM6O3b3/Ay9jdqu0DikD914IkeeLrbSRefgoUuNdX5zzFX8V1xpGTO/572cgfev
hmjSYkLJpahw/J5bZhWFIGD/dBQhUodO/dyjbCz+8t8mzaL2Vajlky8+PtAqL/xt
sX6bvyvoXfU9PIYEGiL8
=d0oV
-----END PGP SIGNATURE-----

--Signature=_Fri__26_Apr_2013_13_08_44_+1000_rNv/K23078w_.NVb--
