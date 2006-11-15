Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 6/16] cell: abstract spu management routines
From: Michael Ellerman <michael@ellerman.id.au>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <45599F91.9070802@am.sony.com>
References: <4554DA9C.9040102@am.sony.com>
	<1163475880.8048.78.camel@localhost.localdomain>
	<200611141055.22317.arnd@arndb.de>  <45599F91.9070802@am.sony.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-rP0OAGV3OrUG3794M2ZV"
Date: Wed, 15 Nov 2006 11:07:15 +1100
Message-Id: <1163549235.19171.4.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Arnd Bergmann <arnd@arndb.de>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-rP0OAGV3OrUG3794M2ZV
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-11-14 at 02:50 -0800, Geoff Levand wrote:
> Arnd Bergmann wrote:
> > On Tuesday 14 November 2006 04:44, Michael Ellerman wrote:
> >> OK, back to the task at hand :) =EF=BF=BDFor the moment I'd rather see=
 you leave
> >> out dump_data_fields(), as neither HV or baremetal implementations do
> >> anything. Just put the offending xmon code inside an #ifdef
> >> CONFIG_PPC_CELL_NATIVE. eg:
> >>=20
> >> Index: cell/arch/powerpc/xmon/xmon.c
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> --- cell.orig/arch/powerpc/xmon/xmon.c =EF=BF=BD2006-11-14 14:43:11.00=
0000000 +1100
> >> +++ cell/arch/powerpc/xmon/xmon.c =EF=BF=BD =EF=BF=BD =EF=BF=BD 2006-1=
1-14 14:42:35.000000000 +1100
> >> @@ -2807,12 +2807,11 @@ static void dump_spu_fields(struct spu *
> >> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =
=EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD in_be32(&spu->problem->sp=
u_status_R));
> >> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD DUMP_VALUE("0x%x", problem->sp=
u_npc_RW,
> >> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =
=EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD in_be32(&spu->problem->sp=
u_npc_RW));
> >> +#ifdef CONFIG_PPC_CELL_NATIVE
> >> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD DUMP_FIELD(spu, "0x%p", priv1)=
;
> >> -
> >> - =EF=BF=BD =EF=BF=BD =EF=BF=BD if (spu->priv1) {
> >> - =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD DUMP_VALUE("0x%lx", priv1->mfc_sr1_RW,
> >> - =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =
=EF=BF=BD in_be64(&spu->priv1->mfc_sr1_RW));
> >> - =EF=BF=BD =EF=BF=BD =EF=BF=BD }
> >> + =EF=BF=BD =EF=BF=BD =EF=BF=BD DUMP_VALUE("0x%lx", priv1->mfc_sr1_RW,
> >> + =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD in_be64(&spu->priv1->mfc_sr1_RW=
));
> >> +#endif
> >=20
> > Oops. Null pointer dereference.
> >=20
> > You can't do this if you want to compile in both native and PS3PF
> > support in a single kernel. I think your original code that prints
> > priv1 and the sr1 only if priv1 exists is fine on both ways.
>=20
> No, that won't work either since I moved priv1 to struct spu_pdata.
>=20
> +struct spu_pdata {
> +	int nid;
> +	struct device_node *devnode;
> +	struct spu_priv1 __iomem *priv1;
> +};

OK, I wasn't very clear. I didn't mean that patch was the final solution
- obviously it needs to take into account the movement of priv1 etc.

> The only way I see this working is to have a platform specific
> routine to dump those spu_pdata variables.  The problem is that
> only the spu platform code knows about the variables, and only the
> xmon code knows how to do the dump.  That is why I suggested earlier
> to re-work the xmon code to make a dump routine with global scope
> that can be called from the various spu platform=20
> spu_dump_pdata_fields() routines.
>=20
> Note that this is not specific to the native support, since I want
> to hook my platform code into xmon also, and I need to somehow
> dump my variables.  So the solution is not to add priv1 back into
> struct spu.

I'm not that bothered, but I really don't think we want to spend too
much effort engineering interfaces between xmon and the spu code - at
the end of the day xmon is just a hackish debugging aid for _kernel
developers_.

The simplest solution might just be to dump the address of the pdata
pointer, and leave it up to the xmon user to dump that and interpret it
as they see fit.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-rP0OAGV3OrUG3794M2ZV
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFWloydSjSd0sB4dIRAt8tAJ4ybsHY1UW7GQM8k+Ib8hdF7dMZnQCcCmNN
iarpERLC8MnPW1PU2LIaQho=
=VUKj
-----END PGP SIGNATURE-----

--=-rP0OAGV3OrUG3794M2ZV--
