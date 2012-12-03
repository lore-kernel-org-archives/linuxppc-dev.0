Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id CEFC22C008D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2012 10:26:40 +1100 (EST)
Date: Tue, 4 Dec 2012 10:26:31 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
 <linux-arm-kernel@lists.infradead.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: omap2plus_defconfig fails to build
Message-Id: <20121204102631.3d8d41e3e8a8c0eb71734e55@canb.auug.org.au>
In-Reply-To: <CAAfyv37BA4YMRFJsN5n7EeAD7iE3hzQ2PDqBAtqCju7JdxrvTA@mail.gmail.com>
References: <CAAfyv37BA4YMRFJsN5n7EeAD7iE3hzQ2PDqBAtqCju7JdxrvTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Tue__4_Dec_2012_10_26_31_+1100_igdx87enqEre_8/H"
Cc: Belisko Marek <marek.belisko@gmail.com>, linux-next@vger.kernel.org,
 Jon Hunter <jon-hunter@ti.com>, Nathan Fontenot <nfont@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Tue__4_Dec_2012_10_26_31_+1100_igdx87enqEre_8/H
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 29 Nov 2012 11:40:18 +0100 Belisko Marek <marek.belisko@gmail.com> =
wrote:
>
> I've update linux-next to next-20121129 and omap2plus_defconfig fails to =
build:
> arch/arm/mach-omap2/timer.c: In function 'omap_get_timer_dt':
> arch/arm/mach-omap2/timer.c:195: error: implicit declaration of
> function 'prom_add_property'

Caused by commit 9725f4451a9c ("ARM: OMAP: Add DT support for timer
driver") from the arm-soc tree interacting with commit 79d1c712958f
("powerpc+of: Rename the drivers/of prom_* functions to of_*") from the
powerpc tree.

I will fix this up in today' linux-next (by changing prom_add_property to
of_add_property).  Someone will need to remember to tell Linus when the
latter of those two commits gets merged.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Tue__4_Dec_2012_10_26_31_+1100_igdx87enqEre_8/H
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJQvTUnAAoJEECxmPOUX5FEoykP/0ZVMP1/+z/A4921KLQYlhTX
fNS3r+xj9e9ji7Rl2F8NzplcYmf+e+TiECCv2BlUz+TALtPvtXlTT+eX1yEtXlbs
0AsMy56Uw3KnsRV3HYzc7cW4sZRKPS0ARKE6vlqFzCki064e6VzZ5ytVqsn0E3KK
5RrWdrGHz2uo4fZPeMwkK9z6RJiVq/BEFl6tLdfgpJt5fnWz0jSWS01x8MhLccH4
WmglCULW0l/+qpOC3uEpomKSW/RNFBWsfDTuBEYaEP2DggmNWHWqHBwIwUHIY4f0
MVCsDel4DBmkjU7mXVe9PCU4YhuJem6eOMiBCLT+WLiQxM1bEueoM8YCzGt59fOc
ZR5Z+iekELpVQALLF3zRrhl/hRTI1tFmxImj75bvOPIYaThlmc1KFum1+7evZN2y
jY82y5wQqdrR3gOMWdyB2Om/ZsI8ZyL4UG7+Erx3AVOjR0TyM+P1+9rWt2hEECJ5
BK1VaLUxhO73fxTOm3j0pznSiFDW8ZfIa35Hp3AC37K3TG8NPKZF5mXLSZjvl/qS
3lsiiqETKXB7V5v90U6cqccfqPIiPEIq9HTCKUhcwbd1kDuo3SrU4eZZuv+ekay3
5G+BCVyviIJguEyfAFKjIlwWdvnfIuXzcMtfkCRYSghp+rC3j0ddb4+BWT+3bsFm
KaDOJiIos27k3fNY334J
=DZsT
-----END PGP SIGNATURE-----

--Signature=_Tue__4_Dec_2012_10_26_31_+1100_igdx87enqEre_8/H--
