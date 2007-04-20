Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: save trap number in bad_stack
From: Michael Ellerman <michael@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1177024678.7286.23.camel@localhost.localdomain>
References: <20070416062347.GA20196@lixom.net>
	<1177024678.7286.23.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-wA6z+nAQx78R3ArWQED3"
Date: Fri, 20 Apr 2007 12:18:44 +1000
Message-Id: <1177035524.6890.7.camel@concordia.ozlabs.ibm.com>
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


--=-wA6z+nAQx78R3ArWQED3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-04-20 at 09:17 +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2007-04-16 at 01:23 -0500, Olof Johansson wrote:
> > Save the trap number in the case of getting a bad stack in an exception
> > handler. It is sometimes useful to know what exception it was that caus=
ed
> > this to happen. Without this, no trap is reported.
> >=20
> >=20
> > Signed-off-by: Olof Johansson <olof@lixom.net>
> >=20
> > Index: linux-2.6/arch/powerpc/kernel/asm-offsets.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-2.6.orig/arch/powerpc/kernel/asm-offsets.c
> > +++ linux-2.6/arch/powerpc/kernel/asm-offsets.c
> > @@ -139,6 +139,7 @@ int main(void)
> >  	DEFINE(PACA_SYSTEM_TIME, offsetof(struct paca_struct, system_time));
> >  	DEFINE(PACA_SLBSHADOWPTR, offsetof(struct paca_struct, slb_shadow_ptr=
));
> >  	DEFINE(PACA_DATA_OFFSET, offsetof(struct paca_struct, data_offset));
> > +	DEFINE(PACA_TRAP_SAVE, offsetof(struct paca_struct, trap_save));
> > =20
> >  	DEFINE(SLBSHADOW_STACKVSID,
> >  	       offsetof(struct slb_shadow, save_area[SLB_NUM_BOLTED - 1].vsid=
));
> > Index: linux-2.6/include/asm-powerpc/paca.h
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-2.6.orig/include/asm-powerpc/paca.h
> > +++ linux-2.6/include/asm-powerpc/paca.h
> > @@ -81,6 +81,8 @@ struct paca_struct {
> >  	u64 exslb[10];		/* used for SLB/segment table misses
> >   				 * on the linear mapping */
> > =20
> > +	u64 trap_save;			/* Used when bad stack is encountered */
>=20
> Can you put it elsewhere in the PACA (around less frequently used
> bits) ? This is a pretty hot area of the PACA...

It's only set in the bad_stack case though.

You should put it after cpu_start, there's a bit hole there, and
trap_save is readonly during normal operation, so it shouldn't be a
performance hit.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-wA6z+nAQx78R3ArWQED3
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBGKCMDdSjSd0sB4dIRAijAAJ9PtORoAw0YXhPBU624ZAcH6BQk/wCbBMW2
sikaOjBUlt71LbWl/+Vgqr0=
=cYYz
-----END PGP SIGNATURE-----

--=-wA6z+nAQx78R3ArWQED3--
