Return-Path: <dgibson@ozlabs.org>
Date: Mon, 23 Apr 2007 23:39:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] [v2] powerpc: save trap number in bad_stack
Message-ID: <20070423133913.GA12965@localhost.localdomain>
References: <20070416062347.GA20196@lixom.net>
	<20070422233821.GB28479@lixom.net>
	<20070423232217.08e420a6.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
In-Reply-To: <20070423232217.08e420a6.sfr@canb.auug.org.au>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org, paulus@samba.org,
	anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 23, 2007 at 11:22:17PM +1000, Stephen Rothwell wrote:
> On Sun, 22 Apr 2007 18:38:21 -0500 olof@lixom.net (Olof Johansson) wrote:
> >
> > --- powerpc.orig/include/asm-powerpc/paca.h
> > +++ powerpc/include/asm-powerpc/paca.h
> > @@ -68,6 +68,7 @@ struct paca_struct {
> >  	void *emergency_sp;		/* pointer to emergency stack */
> >  	u64 data_offset;		/* per cpu data offset */
> >  	s16 hw_cpu_id;			/* Physical processor number */
> > +	u16 trap_save;			/* Used when bad stack is encountered */
>=20
> Please read the comment at the top of the struct:
>=20
>         /*
>          * Because hw_cpu_id, unlike other paca fields, is accessed
>          * routinely from other CPUs (from the IRQ code), we stick to
>          * read-only (after boot) fields in the first cacheline to
>          * avoid cacheline bouncing.
>          */
>=20
> So please move this out of the first cache line.

Afaict, Olof's patch only writes to that field when we're about to
enter the bad_stack path.  In that case we're sufficiently screwed
that I don't think some extra cacheline bouncing matters.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGLLcBaILKxv3ab8YRAupDAJ4iDtvaBqfCSBLt6F2xQMlMOFJSTgCeNCbr
bZdE5nbgzz8DMLe/ZYTG8Do=
=GoFw
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
