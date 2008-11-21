Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4B4E7DDDEF
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Nov 2008 03:02:39 +1100 (EST)
Subject: Re: [PATCH] IB/ehca: Fix lockdep failures for shca_list_lock
From: Johannes Berg <johannes@sipsolutions.net>
To: Joachim Fenkes <fenkes@de.ibm.com>
In-Reply-To: <200811211637.15300.fenkes@de.ibm.com>
References: <200806061835.43802.fenkes@de.ibm.com>
	<48499C11.7030504@gmail.com>  <200811211637.15300.fenkes@de.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-lE2xKnnJ7qgNxVLjKvvc"
Date: Fri, 21 Nov 2008 17:02:27 +0100
Message-Id: <1227283347.3599.8.camel@johannes.berg>
Mime-Version: 1.0
Cc: LKML <linux-kernel@vger.kernel.org>, OF-EWG <ewg@lists.openfabrics.org>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>,
	OF-General <general@lists.openfabrics.org>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-lE2xKnnJ7qgNxVLjKvvc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2008-11-21 at 16:37 +0100, Joachim Fenkes wrote:

> +	u64 flags;

> -	spin_lock(&shca_list_lock);
> +	spin_lock_irqsave(&shca_list_lock, flags);

That's wrong and I think will give a warning on all machines where
u64 !=3D unsigned long. Might not particularly matter in this case.

Also, generally it seems wrong to say "fix lockdep failure" when the
patch really fixes a bug that lockdep happened to find.

johannes

--=-lE2xKnnJ7qgNxVLjKvvc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJJJtuOAAoJEKVg1VMiehFY3SgP+wQxUP8OH09UEvYbkTm3Wb82
r3LUyHaDNlla4X8D4/qlc7bKyam39YddIeT95GV7/pbZJ/rMV/ZoQSZWK963OqLN
Y27da78iwCeR5Hy+JosDkMskp8hQR6XG+GJB9U9GDwnOBNV7ah9tRBqxFkeT7ZtZ
pSgT+7I6Cpjuxd7J7JD2xRPwwtEeQi+yfHwCH0V5ihYe2fBmsDmh4ipjAr0CtB+W
85npS0K8NNmmUdjuN6DXs7yln6Aur1L1cBGbjG7tfCWRv6W/iC7e9AzuFIlqg6pw
LXRGOx482BU6y1oDSn5wSfmt2VxDu7Fm9p3Ql14gtIcIU1iy/v5JcxGlZAZZ7ETK
3MAchChmB0ElplTKpP1eW6Hah9Y6BgU2oTArlDohUPrScv7uW57YhYhi25sjU6ho
JlIfx6SAQVPP+S2wntAj2aHiuWgTLhSTAkbbwWJv/bi0+Nyy2k3aVUlqSf9LmXek
YGYdkHsp9PlfOCMRuS5o/yjZeWrayTfT54NWD5ZxLEd7Iblvz/DwNiioiY/KIGVQ
bJ6GGCgcN/w8LyMD8Bs+gnY19eYEMTWgO9b1JSpdihJFqOurRqrKz5j1dnRuXjwW
MXMjfdpcL084fNbBh4f+HjypcTfx7S43WnPiG6lSF08Z36uHeLd5gR16n6zrSmBK
DoSGG7IwJXMoIHCWJ2ru
=2bTj
-----END PGP SIGNATURE-----

--=-lE2xKnnJ7qgNxVLjKvvc--
