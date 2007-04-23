Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] [v2] powerpc: save trap number in bad_stack
From: Michael Ellerman <michael@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20070423232217.08e420a6.sfr@canb.auug.org.au>
References: <20070416062347.GA20196@lixom.net>
	<20070422233821.GB28479@lixom.net>
	<20070423232217.08e420a6.sfr@canb.auug.org.au>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-EjZEBKh/IXlEtq+HntOc"
Date: Mon, 23 Apr 2007 23:33:12 +1000
Message-Id: <1177335192.10341.2.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org, paulus@samba.org,
	anton@samba.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-EjZEBKh/IXlEtq+HntOc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-04-23 at 23:22 +1000, Stephen Rothwell wrote:
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

The only time it's written to is when we detect a bad stack pointer,
after which we promptly panic, so it's essentially read-only (in fact
unused) during normal operation. Plus there's a massive gap there in
paca_struct before the start of the second cacheline.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-EjZEBKh/IXlEtq+HntOc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGLLWYdSjSd0sB4dIRAsaXAKCqVTEP6IN9cdI7rXKMWa1Eek8tvACgrCxL
3cTrxGua/TWQzgPeOzZJHd0=
=TkYM
-----END PGP SIGNATURE-----

--=-EjZEBKh/IXlEtq+HntOc--
