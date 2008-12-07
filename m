Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 87B38DDDED
	for <linuxppc-dev@ozlabs.org>; Sun,  7 Dec 2008 16:43:40 +1100 (EST)
Date: Sun, 7 Dec 2008 16:43:33 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH linux-next] powerpc/powermac: Add missing of_node_put
Message-Id: <20081207164333.78b69d16.sfr@canb.auug.org.au>
In-Reply-To: <18747.13668.304923.709761@cargo.ozlabs.ibm.com>
References: <200812021445.18670.npalix@diku.dk>
	<20081206163449.60757c4a.akpm@linux-foundation.org>
	<18747.13668.304923.709761@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sun__7_Dec_2008_16_43_33_+1100_9cAgL=Z0Rx4qNG1v"
Cc: Nicolas Palix <npalix@diku.dk>, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Julia Lawall <julia@diku.dk>, Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sun__7_Dec_2008_16_43_33_+1100_9cAgL=Z0Rx4qNG1v
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Sun, 7 Dec 2008 13:31:00 +1100 Paul Mackerras <paulus@samba.org> wrote:
>
> I'm really in two minds about applying any of the of_node_put patches
> that only affect powermacs.  The reference counts only matter on
> platforms where we update the OF device tree at runtime, which is
> currently only IBM pSeries machines.  Since we don't have any hotplug
> on powermacs, and never will have, the OF device tree is completely
> static and we don't actually need refcounts on the nodes at all, so
> who cares if they're a bit higher than they might be?
>=20
> In particular, the VIA whose node we're looking for here is built-in
> on the motherboard, and there can never be more than one, and it can
> never be removed.

I my mind it is about consistent use of the API and good examples for
people to copy.  Also, in about a year you will be presented with the
same set of patches when a new pair of eyes looks at the same code and
notices the discrepancy ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sun__7_Dec_2008_16_43_33_+1100_9cAgL=Z0Rx4qNG1v
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkk7YoUACgkQjjKRsyhoI8yITgCgqhiy2EiAy7rT/UeREir6DnDl
DFQAoJazqJL2ZCW+NMAj8s8iWyhmdOPV
=p+Ht
-----END PGP SIGNATURE-----

--Signature=_Sun__7_Dec_2008_16_43_33_+1100_9cAgL=Z0Rx4qNG1v--
