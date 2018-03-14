Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401QCY3LK5zDrBW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 19:40:25 +1100 (AEDT)
Date: Wed, 14 Mar 2018 19:39:57 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-next
 <linux-next@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 Kees Cook <keescook@chromium.org>, mpe <mpe@ellerman.id.au>, sachinp
 <sachinp@linux.vnet.ibm.com>
Subject: Re: [linux-next][bisected c7c133f3][gcc 4.8.5] build fail with
 error: first argument to =?UTF-8?B?4oCYX19idWlsdGluX2Nob29zZV9leHBy4oCZ?=
 not a constant
Message-ID: <20180314193957.5f835d33@canb.auug.org.au>
In-Reply-To: <1521016194.31953.9.camel@abdul.in.ibm.com>
References: <1521016194.31953.9.camel@abdul.in.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/21sGLEFcpkIqcEbljcmmAvq"; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/21sGLEFcpkIqcEbljcmmAvq
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Abdul,

On Wed, 14 Mar 2018 13:59:54 +0530 Abdul Haleem <abdhalee@linux.vnet.ibm.co=
m> wrote:
>
> Today's next kernel fails to build with gcc 4.8.5 on powerpc machine.

Thanks for the report.  Just for the future, please include  the
next-XXXXXXXX tag when making reports about linux-next.

> ./include/linux/jiffies.h: In function =E2=80=98jiffies_delta_to_clock_t=
=E2=80=99:
> ./include/linux/kernel.h:855:2: error: first argument to =E2=80=98__built=
in_choose_expr=E2=80=99 not a constant
>   __builtin_choose_expr(__builtin_constant_p(x) &&  \
>   ^
> ./include/linux/kernel.h:867:19: note: in expansion of macro =E2=80=98__m=
ax=E2=80=99
>  #define max(x, y) __max(typeof(x), typeof(y), x, y)
>=20
> Machine Type: Power8 Baremetal
> gcc: 4.8.5
>=20
>=20
> Builds fine when below patch is reverted
> c7c133f3 kernel.h: skip single-eval logic on literals in min()/max()

Those patches have been removed from today's linux-next (next-20180314).

--=20
Cheers,
Stephen Rothwell

--Sig_/21sGLEFcpkIqcEbljcmmAvq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqo390ACgkQAVBC80lX
0GwkHgf/a+Lef+M+WPHetI1QbQzaOstol7l3phUCYNXFdk+Kver6ehX3oZYIr5S9
IJYYhifaiNZida7Ie9nRLEvAHGQfLqDCmL4oGtBP5qIel0z+Z0i+iTt+ByvGWAUE
/zjj/YEYxlfPOLSc/xO/DPiXjRrVU+TXBQhT1+YyKyB3nfDgPaySGnO+E6R8Z+SE
qJyNARoPHGPf/MQQRzmMGXuSW76ugyDy66CX9GWseHJYOPgU/QdnOqwPegVbmXkb
FAuBl/ogb86QhrrxL9TrjC7oPNBE2UynMLfGH17NHZgeBuG2abCHnhpBiLDGKINm
F5SuC4xhgVqShEX7ekRiH6gizLL5kw==
=6n8K
-----END PGP SIGNATURE-----

--Sig_/21sGLEFcpkIqcEbljcmmAvq--
