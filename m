Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 5428FDDEA2
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jan 2008 15:27:54 +1100 (EST)
Date: Tue, 15 Jan 2008 15:27:48 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: emac/zmii link warnings
Message-Id: <20080115152748.d0a05e1b.sfr@canb.auug.org.au>
In-Reply-To: <478C336D.2080307@pikatech.com>
References: <478C336D.2080307@pikatech.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__15_Jan_2008_15_27_48_+1100_6gXqq1VudM=O3NhX"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__15_Jan_2008_15_27_48_+1100_6gXqq1VudM=O3NhX
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 14 Jan 2008 23:15:41 -0500 Sean MacLennan <smaclennan@pikatech.com>=
 wrote:
>
> I keep getting these link(?) warnings:
>=20
> WARNING: vmlinux.o(.data+0x16178): Section mismatch: reference to .init.t=
ext:emac_of_bus_notify (between 'emac_of_bus_notifier' and 'emac_phy_map_lo=
ck')

emac_of_bus_notify is marked __devinit and is referred to by
emac_of_bus_notifier (which is not marked thus) (in
drivers/net/ibm_newemac/core.c).

> WARNING: vmlinux.o(.init.text+0x16ba8): Section mismatch: reference to .e=
xit.text:zmii_detach (between 'emac_probe' and 'zmii_probe')
> WARNING: vmlinux.o(.init.text+0x16bb4): Section mismatch: reference to .e=
xit.text:mal_unregister_commac (between 'emac_probe' and 'zmii_probe')

These will be similar but function calls.

> Any hints as to what might be wrong? Or are they "normal".

They need to be fixed.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__15_Jan_2008_15_27_48_+1100_6gXqq1VudM=O3NhX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHjDZITgG2atn1QN8RAla6AKCKRQs6nG8a+3Ls9OBCuTX2PEiPwgCeJqh8
dZMJPfMJ/tzRdnfwgiN/6LY=
=vZCV
-----END PGP SIGNATURE-----

--Signature=_Tue__15_Jan_2008_15_27_48_+1100_6gXqq1VudM=O3NhX--
