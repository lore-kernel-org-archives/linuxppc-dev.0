Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id DA72EB7128
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 15 Jun 2009 10:56:37 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BA8E5DDD04
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jun 2009 10:56:37 +1000 (EST)
Subject: Re: [OOPS] hugetlbfs tests with 2.6.30-rc8-git1
From: Michael Ellerman <michael@ellerman.id.au>
To: Sachin Sant <sachinp@in.ibm.com>
In-Reply-To: <4A34E12B.4010000@in.ibm.com>
References: <4A290195.3080807@in.ibm.com> <1244233062.31984.6.camel@pasglop>
	<4A34E12B.4010000@in.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-HHIu+kZIzYetzmIYeunL"
Date: Mon, 15 Jun 2009 10:56:36 +1000
Message-Id: <1245027396.7705.23.camel@concordia>
Mime-Version: 1.0
Cc: Mel Gorman <mel@csn.ul.ie>, linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-HHIu+kZIzYetzmIYeunL
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2009-06-14 at 17:08 +0530, Sachin Sant wrote:
> Benjamin Herrenschmidt wrote:
> > On Fri, 2009-06-05 at 16:59 +0530, Sachin Sant wrote:
> >  =20
> >> While executing Hugetlbfs tests against 2.6.30-rc8-git1 on a
> >> Power 6 box observed the following OOPS message.
> I was able to recreate this with 2.6.30-git7.

Hi Sachin,

Rather than "-git7" can you tell us the actual SHA, I don't know what
git7 is.

> Here is the supporting data.
>=20
>  cpu 0x1: Vector: 300 (Data Access) at [c0000000fe9b3220]
>     pc: c00000000003d620: .hpte_need_flush+0x1bc/0x2d8
>     lr: c00000000003d4d0: .hpte_need_flush+0x6c/0x2d8
>     sp: c0000000fe9b34a0
>    msr: 8000000000009032
>    dar: c0000000283b0d78

This address looks pretty innocuous, but I notice you have
DEBUG_PAGEALLOC=3Dy, so presumably that's why it's triggering.

I can't see from the snippet of disassembly you posted where in the C
code we are, can you work it out?

cheers


--=-HHIu+kZIzYetzmIYeunL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAko1nEQACgkQdSjSd0sB4dJfMACfZAsBD/0jlJzuHfIthMexGuGG
yAkAoKvjO1Ev2DSkcr6i8ilvfBWFUTlk
=o3sS
-----END PGP SIGNATURE-----

--=-HHIu+kZIzYetzmIYeunL--
