Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id DC760DDDEB
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 11:56:08 +1000 (EST)
Date: Thu, 26 Jul 2007 11:56:01 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: will_schmidt@vnet.ibm.com
Subject: Re: [PATCH] [POWERPC] iSeries: fix section mismatch warnings
Message-Id: <20070726115601.7733fb96.sfr@canb.auug.org.au>
In-Reply-To: <1185382531.22237.46.camel@farscape.rchland.ibm.com>
References: <20070725092735.0a5a1c52.sfr@canb.auug.org.au>
	<1185382531.22237.46.camel@farscape.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__26_Jul_2007_11_56_01_+1000_79Rd8y9ScHaGFWjm"
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__26_Jul_2007_11_56_01_+1000_79Rd8y9ScHaGFWjm
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Will,

On Wed, 25 Jul 2007 11:55:31 -0500 Will Schmidt <will_schmidt@vnet.ibm.com>=
 wrote:
>
> >  	cmpwi	0,r24,0			/* Are we processor 0? */
> > -	beq	.__start_initialization_iSeries	/* Start up the first processor */
> > -	mfspr	r4,SPRN_CTRLF
> > +	bne	1f
> > +	b	.__start_initialization_iSeries	/* Start up the first processor */
> > +1:	mfspr	r4,SPRN_CTRLF
> >  	li	r5,CTRL_RUNLATCH	/* Turn off the run light */
>=20
> This part isnt clicking for me..=20
> How does changing a "beq" to a "bne" over a "b" fit into changing
> __start_initialization_iSeries static? =20

Because I moved __start_initialization_iSeries into another section, it
ends up too far away for a conditional branch so something adds a jump
table to the .text section and changes this branch to be via that table.
Unfortunately, the jump table ends up at the start of the .text and ruins
our carefully laid out kernel image.  By inverting the test I can turn
the branch into an unconditional one which has a larger possible offse
(effectively building the jump table manually).

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__26_Jul_2007_11_56_01_+1000_79Rd8y9ScHaGFWjm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGp/82TgG2atn1QN8RAr24AJ9t5fqxcKDg2gecQZoVjt5xmyPmKgCcCnCL
lze3N2tIZZoQJl3TuMRh0t4=
=RJeT
-----END PGP SIGNATURE-----

--Signature=_Thu__26_Jul_2007_11_56_01_+1000_79Rd8y9ScHaGFWjm--
