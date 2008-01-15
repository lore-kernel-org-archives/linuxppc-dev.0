Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 90853DDE34
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jan 2008 16:26:11 +1100 (EST)
Date: Tue, 15 Jan 2008 16:26:05 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: emac/zmii link warnings
Message-Id: <20080115162605.e41c6fb9.sfr@canb.auug.org.au>
In-Reply-To: <478C3A5D.5080209@pikatech.com>
References: <478C336D.2080307@pikatech.com>
	<20080115152748.d0a05e1b.sfr@canb.auug.org.au>
	<478C3A5D.5080209@pikatech.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__15_Jan_2008_16_26_05_+1100_J8ZkPeTC6d6NOGxD"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__15_Jan_2008_16_26_05_+1100_J8ZkPeTC6d6NOGxD
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 14 Jan 2008 23:45:17 -0500 Sean MacLennan <smaclennan@pikatech.com>=
 wrote:
>
> Stephen Rothwell wrote:
> > On Mon, 14 Jan 2008 23:15:41 -0500 Sean MacLennan <smaclennan@pikatech.=
com> wrote:
> >  =20
> >> I keep getting these link(?) warnings:
> >>
> >> WARNING: vmlinux.o(.data+0x16178): Section mismatch: reference to .ini=
t.text:emac_of_bus_notify (between 'emac_of_bus_notifier' and 'emac_phy_map=
_lock')
>
> > emac_of_bus_notify is marked __devinit and is referred to by
> > emac_of_bus_notifier (which is not marked thus) (in
> > drivers/net/ibm_newemac/core.c).
> =20
> Adding the __devinit to emacs_of_bus_notifier causes a problem with=20
> emac_phy_map_lock (a mutex). But removing the __devinit from=20
> emac_of_bus_notify cleans up that warning. Is the __devinit really=20
> necessary?

What problem do you get.  The correct fix is to mark emac_of_bus_notifier
as __devinitdata.  The __devinit marking of emac_of_bus_notify is not
strictly necessary, but some people care about the size of their kernels.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__15_Jan_2008_16_26_05_+1100_J8ZkPeTC6d6NOGxD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHjEPxTgG2atn1QN8RAgU1AKCJQQTcod2UY8gQtxXiwU+NsJs/ZwCfdpIK
m/Tfzwd2GRji69+99dYgqqM=
=d3K4
-----END PGP SIGNATURE-----

--Signature=_Tue__15_Jan_2008_16_26_05_+1100_J8ZkPeTC6d6NOGxD--
