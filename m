Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402ZGF5x5JzDr8d
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 16:46:45 +1100 (AEDT)
Date: Fri, 16 Mar 2018 16:46:14 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: build warning in drivers/macintosh/rack-meter.c
Message-ID: <20180316164614.07f2f573@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/L+yJKoauzBjFDTIxxkeKfwm"; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/L+yJKoauzBjFDTIxxkeKfwm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

These warnings have beeen around for a while now;

drivers/macintosh/rack-meter.c:157:2: warning: 'memset' used with length eq=
ual to number of elements without multiplication by element size [-Wmemset-=
elt-size]
  memset(rdma->buf1, 0, ARRAY_SIZE(rdma->buf1));
  ^~~~~~
drivers/macintosh/rack-meter.c:158:2: warning: 'memset' used with length eq=
ual to number of elements without multiplication by element size [-Wmemset-=
elt-size]
  memset(rdma->buf2, 0, ARRAY_SIZE(rdma->buf2));
  ^~~~~~

Introduced by commit

  4f7bef7a9f69 ("drivers: macintosh: rack-meter: fix bogus memsets")

I guess updating to a newer compiler has started generating these.

--=20
Cheers,
Stephen Rothwell

--Sig_/L+yJKoauzBjFDTIxxkeKfwm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqrWiYACgkQAVBC80lX
0Gy6+gf/UlVM2m1bPi4aXXU0k6QGnNIIUAWYLUjUjPqV6O7M0HxcTlZkm/dzg7Dh
W+yCyFSRiuXpMSLkRW7DEKPRpT/q6xl7YkO6aJ7LjmXpsaQBilYnKCyzuexVtirT
0w9iR1Fo2sRZ+v4vXYuQHS7AMyvu9m4bX+ChKismK6UkdTfIOs97N7vyssyo5vis
qT3ftyyToVFXdilXH1NnyN+Wm0Kw/y4QB25d0W2G0WT0vrWdCD6VrRuHn/kU5XdC
JKlAm9JwIu657VlVJqVtqznw0hn2h2WZY2iZLKjHgB4D7aiygMQ4zV1LPmz7dOjf
tB+idIgqycEeUlrqYsgmxErzDCNLqg==
=bTuU
-----END PGP SIGNATURE-----

--Sig_/L+yJKoauzBjFDTIxxkeKfwm--
