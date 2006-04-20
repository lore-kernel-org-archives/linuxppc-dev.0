Return-Path: <robbat2@gentoo.org>
Received: from mail.net-conex.com (pops.net-conex.com [204.244.176.3])
	by ozlabs.org (Postfix) with ESMTP id ED63E679E9
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Apr 2006 10:54:41 +1000 (EST)
Received: from curie.orbis-terrarum.net (S01060050da688d47.vc.shawcable.net
	[24.80.100.253])
	by mail.net-conex.com (8.13.4/8.12.11) with ESMTP id k3K0seoN006411
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Apr 2006 17:54:40 -0700
Date: Wed, 19 Apr 2006 17:54:45 -0700
From: "Robin H. Johnson" <robbat2@gentoo.org>
To: linuxppc-dev@ozlabs.org
Subject: Re: modules without a .toc section not loading
Message-ID: <20060420005445.GA24721@curie-int.vc.shawcable.net>
References: <20060420000220.GB22797@curie-int.vc.shawcable.net>
	<20060420002829.GD27430@bubble.grove.modra.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
In-Reply-To: <20060420002829.GD27430@bubble.grove.modra.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 20, 2006 at 09:58:30AM +0930, Alan Modra wrote:
> > Ideas for Solutions:
> > 1. Either the kernel needs to realize that it does not need a .toc
> > section (I'm uncertain about this, being new to PPC).
> > 2. GCC is at fault, and it should be generating a .toc.
> The former.
Ok, so in module_64.c, under what cases is .toc NOT needed?

I dug at the code, and the R_PPC_REL24 blocks need the contents of the
=2Etoc (via stub_for_addr -> create_stub -> my_r2), and I'm not certain
about it.

The R_PPC64_TOC/R_PPC64_TOC16/R_PPC64_TOC16_DS blocks shouldn't be hit
when there isn't a .toc* from what I figure.

If the R_PPC_REL24 block won't be hit when there isn't a .toc, the check
in module_frob_arch_sections, lines 194-197 can just be shortened as a
fix to the problem.

--=20
Robin Hugh Johnson
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2-ecc0.1.6 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks

iD8DBQFERtvVPpIsIjIzwiwRAnEQAJ9pqXBdL7rgtke3WrSjaOLdcSBwQgCfY5UR
6CCjaMLB6kzRBJkDx390Lho=
=IRpM
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
