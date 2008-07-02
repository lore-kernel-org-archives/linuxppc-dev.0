Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: fixup lwsync at runtime
From: Michael Ellerman <michael@ellerman.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <DBD7C7F7-1EBB-4D73-88A0-72D079E800DB@kernel.crashing.org>
References: <Pine.LNX.4.64.0807010031241.23830@blarg.am.freescale.net>
	<1214893753.8055.13.camel@localhost>
	<DBD7C7F7-1EBB-4D73-88A0-72D079E800DB@kernel.crashing.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-9ZTo3r3yaMcldu11PpTm"
Date: Wed, 02 Jul 2008 19:34:08 +1000
Message-Id: <1214991248.7436.5.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-9ZTo3r3yaMcldu11PpTm
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, 2008-07-01 at 09:48 -0500, Kumar Gala wrote:
> On Jul 1, 2008, at 1:29 AM, Michael Ellerman wrote:

> >> diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/=20
> >> setup_32.c
> >> index 9e83add..0109e7f 100644
> >> --- a/arch/powerpc/kernel/setup_32.c
> >> +++ b/arch/powerpc/kernel/setup_32.c
> >> @@ -101,6 +101,10 @@ unsigned long __init early_init(unsigned long =20
> >> dt_ptr)
> >> 			  PTRRELOC(&__start___ftr_fixup),
> >> 			  PTRRELOC(&__stop___ftr_fixup));
> >>
> >> +	do_lwsync_fixups(spec->cpu_features,
> >> +			 PTRRELOC(&__start___lwsync_fixup),
> >> +			 PTRRELOC(&__stop___lwsync_fixup));
> >> +
> >
> > This could be changed to use cur_cpu_spec->cpu_features, and then all
> > the call sites would be passing that, which would mean
> > do_lwsync_fixups() could just check cur_cpu_spec->cpu_features =20
> > directly.
>=20
> cur_cpu_spec and spec at this point arent the same thing.

Aren't they? I must be missing something:

struct cpu_spec * __init identify_cpu(unsigned long offset, unsigned int pv=
r)
{
        struct cpu_spec *s =3D cpu_specs;
        struct cpu_spec *t =3D &the_cpu_spec;
        int i;

        for (i =3D 0; i < ARRAY_SIZE(cpu_specs); i++,s++)
                if ((pvr & s->pvr_mask) =3D=3D s->pvr_value) {
			...
                        *t =3D *s;
                        *PTRRELOC(&cur_cpu_spec) =3D &the_cpu_spec;
			...
                        return s;

then:

unsigned long __init early_init(unsigned long dt_ptr)
=EF=BB=BF{
	...
	spec =3D identify_cpu(offset, mfspr(SPRN_PVR));

        do_feature_fixups(spec->cpu_features,
                          PTRRELOC(&__start___ftr_fixup),
                          PTRRELOC(&__stop___ftr_fixup));
}


cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-9ZTo3r3yaMcldu11PpTm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIa0uPdSjSd0sB4dIRApiRAJ9AgEj7S4U4hWgz3nMRNKxQOLzb6QCdGIY9
gm7jB3nJ3VQOdbyJ/iBq1KE=
=EFfi
-----END PGP SIGNATURE-----

--=-9ZTo3r3yaMcldu11PpTm--
