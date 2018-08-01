Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41gqbF0vrSzF14j
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Aug 2018 09:42:01 +1000 (AEST)
Date: Thu, 2 Aug 2018 09:41:54 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, PowerPC <linuxppc-dev@lists.ozlabs.org>, Geert
 Uytterhoeven <geert@linux-m68k.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Finn Thain <fthain@telegraphics.com.au>
Subject: Re: linux-next: manual merge of the powerpc tree with the m68k tree
Message-ID: <20180802094154.6d88f03c@canb.auug.org.au>
In-Reply-To: <20180802092708.10e1a71d@canb.auug.org.au>
References: <20180802092708.10e1a71d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ueoUXmnaVYBQFrUPw1y_OhP"; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/ueoUXmnaVYBQFrUPw1y_OhP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

[forgot the conflict resolution ...]

On Thu, 2 Aug 2018 09:27:20 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the powerpc tree got a conflict in:
>=20
>   arch/m68k/mac/misc.c
>=20
> between commit:
>=20
>   5b9bfb8ec467 ("m68k: mac: Use time64_t in RTC handling")
>=20
> from the m68k tree and commit:
>=20
>   ebd722275f9c ("macintosh/via-pmu: Replace via-pmu68k driver with via-pm=
u driver")
>=20
> from the powerpc tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/m68k/mac/misc.c
index 19e9d8eef1f2,28090a44fa09..3534aa6a4dc2
--- a/arch/m68k/mac/misc.c
+++ b/arch/m68k/mac/misc.c
@@@ -90,11 -85,11 +90,11 @@@ static void cuda_write_pram(int offset
  }
  #endif /* CONFIG_ADB_CUDA */
 =20
- #ifdef CONFIG_ADB_PMU68K
+ #ifdef CONFIG_ADB_PMU
 -static long pmu_read_time(void)
 +static time64_t pmu_read_time(void)
  {
  	struct adb_request req;
 -	long time;
 +	time64_t time;
 =20
  	if (pmu_request(&req, NULL, 1, PMU_READ_RTC) < 0)
  		return 0;

--Sig_/ueoUXmnaVYBQFrUPw1y_OhP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltiRUIACgkQAVBC80lX
0GwP5QgAjLqv9cJbv3AFS8UVchlz4SN09xP6c10N8MShtoFvWAQgAanD3vfMexCl
MzRRU9Ovm2n5IgW1kQik2ZiYmZQ8VaxEq+QNRiB0sPx5ibLm45coFHkRXftvyS7J
rJVm0BUwF+zCz/hhAIbe1w1CHfHW6HUbM636GeH8fdrkPF9pcsNb/5S3pUp7Xy26
Du43W6HCGUWmIBRKxF+BxVHmTe16HfMXmR9VRG0zR4rxUbZFToq4pf+vzEw7DkQM
UdWg70jWN205VnVUQNdoCiDtwBjD84JUIfSlkZqs2c4HI1ZqbNOnDS4XaVjO7xLt
RRgMPQQaiue5JeIcMhcecb2KxpwJlw==
=7H9a
-----END PGP SIGNATURE-----

--Sig_/ueoUXmnaVYBQFrUPw1y_OhP--
