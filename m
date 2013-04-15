Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.pcug.org.au [203.10.76.10])
 by ozlabs.org (Postfix) with ESMTP id 693572C0107
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2013 02:17:55 +1000 (EST)
Date: Tue, 16 Apr 2013 02:17:47 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 1/2] powerpc: remove section changes from _GLOBAL() and
 friends
Message-Id: <20130416021747.a9608ca92eb68495493e061b@canb.auug.org.au>
In-Reply-To: <20130415233040.ca38e79ce08c519554baa865@canb.auug.org.au>
References: <20121129105525.0e47b3b3e51aebe7ded3b7b6@canb.auug.org.au>
 <20130415120016.GB12701@concordia>
 <20130415233040.ca38e79ce08c519554baa865@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Tue__16_Apr_2013_02_17_47_+1000_.V8DgYf_wTu7xifZ"
Cc: Alan Modra <amodra@au1.ibm.com>, ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Tue__16_Apr_2013_02_17_47_+1000_.V8DgYf_wTu7xifZ
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Mon, 15 Apr 2013 23:30:40 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Mon, 15 Apr 2013 22:00:17 +1000 Michael Ellerman <michael@ellerman.id.=
au> wrote:
> >
> > On Thu, Nov 29, 2012 at 10:55:25AM +1100, Stephen Rothwell wrote:
> > > These sometimes produce unexpected results and make it hard to put the
> > > start up code (for 64 bit) into the .head.text section.
> >=20
> > ...
> >=20
> > > diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kern=
el/head_fsl_booke.S
> > > index 6f62a73..4ec5625 100644
> > > --- a/arch/powerpc/kernel/head_fsl_booke.S
> > > +++ b/arch/powerpc/kernel/head_fsl_booke.S
> > > @@ -776,6 +776,8 @@ tlb_write_entry:
> > >  	mfspr	r10, SPRN_SPRG_RSCRATCH0
> > >  	rfi					/* Force context change */
> > > =20
> > > +	,text
> > > +
> >=20
> > I'm assuming this should be .text ?
>=20
> Indeed.  Oops :-)

BTW, those patches are almost certainly stale by now and would need to be
redone before be included on the kernel proper.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Tue__16_Apr_2013_02_17_47_+1000_.V8DgYf_wTu7xifZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJRbCgrAAoJEECxmPOUX5FEsAkP/1u9awx/v9DJwo0rcVAdXEL6
kAH+WiqFEOwx01413YaEdwJlada14BaPxQ+pKsv21A+kbBKTBUyz0kvaMI/Iz51w
ZoLNVW4rKE56Pr/TPPuRIffDEzULnqN1uDdTMq6HMU4MNPurOepWXar1jxHEyyoW
EH5EdP/q53uQP6pVj3pphU8u0nymRUikLOgh9mwInNDEMPMfUm8MdJbSEZarN6K5
nZ8WG0jDu9hlttBgdxmeyaTmeZ2usWACyQ3a4fgvpYXPWCIqx+SH6oviy+ms5s6G
ziHQVws/Rref07r+PRHNEiOne+5EsutlPd9WDkHHQNQpq7uDtbq5YjIWlyWJTRIy
cS4rfukf3K/a/dtiCrJaKG8RQjHD89zWbkyu5jdZgUF+ewjvTH67+QrspJrQjXIB
lfkIGVHa4UxqSR6vZ0FK/3y1OjcX+PB9vcvS8oWpJZEw6Aidra3+GH0m/D9TAb3v
dczXWvex848xleNKuoaW+enR57zUwWU+igiYRGVDQjwiICcBH4CrW7L6sPONrmS8
2d/m5sEqmTbRPxa4k206r25ENB74dXZXipKEKR/rwNaFo5v16KFrua4JWVUKpPNd
Ke5SlOYP9Zin5lSeUa0uuQKWl3BfEb9OG00nvhc6h6qHMTZue3NaHsrNO2t0DMrc
+JtdxKxOoaSwRdhhFGJv
=VYXS
-----END PGP SIGNATURE-----

--Signature=_Tue__16_Apr_2013_02_17_47_+1000_.V8DgYf_wTu7xifZ--
