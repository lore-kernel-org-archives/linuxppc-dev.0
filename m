Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: fixup lwsync at runtime
From: Michael Ellerman <michael@ellerman.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <46F3C08B-4F8E-42A2-BDE8-6849D33CA4A0@kernel.crashing.org>
References: <Pine.LNX.4.64.0807010031241.23830@blarg.am.freescale.net>
	<1214893753.8055.13.camel@localhost>
	<DBD7C7F7-1EBB-4D73-88A0-72D079E800DB@kernel.crashing.org>
	<1214991248.7436.5.camel@localhost>
	<46F3C08B-4F8E-42A2-BDE8-6849D33CA4A0@kernel.crashing.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-N68KlsO7CtLU9VQijCkH"
Date: Thu, 03 Jul 2008 15:55:26 +1000
Message-Id: <1215064526.17950.0.camel@localhost>
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


--=-N68KlsO7CtLU9VQijCkH
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2008-07-02 at 10:57 -0500, Kumar Gala wrote:
> On Jul 2, 2008, at 4:34 AM, Michael Ellerman wrote:
>=20
> > On Tue, 2008-07-01 at 09:48 -0500, Kumar Gala wrote:
> >> On Jul 1, 2008, at 1:29 AM, Michael Ellerman wrote:
> >
> >>>> diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/
> >>>> setup_32.c
> >>>> index 9e83add..0109e7f 100644
> >>>> --- a/arch/powerpc/kernel/setup_32.c
> >>>> +++ b/arch/powerpc/kernel/setup_32.c
> >>>> @@ -101,6 +101,10 @@ unsigned long __init early_init(unsigned long
> >>>> dt_ptr)
> >>>> 			  PTRRELOC(&__start___ftr_fixup),
> >>>> 			  PTRRELOC(&__stop___ftr_fixup));
> >>>>
> >>>> +	do_lwsync_fixups(spec->cpu_features,
> >>>> +			 PTRRELOC(&__start___lwsync_fixup),
> >>>> +			 PTRRELOC(&__stop___lwsync_fixup));
> >>>> +
> >>>
> >>> This could be changed to use cur_cpu_spec->cpu_features, and then =20
> >>> all
> >>> the call sites would be passing that, which would mean
> >>> do_lwsync_fixups() could just check cur_cpu_spec->cpu_features
> >>> directly.
> >>
> >> cur_cpu_spec and spec at this point arent the same thing.
> >
> > Aren't they? I must be missing something:
>=20
> There is an issue with how ppc32 classic gets here and relocation.  If =20
> I change the call to:
>=20
>          do_lwsync_fixups(cur_cpu_spec->cpu_features,
>                           PTRRELOC(&__start___lwsync_fixup),
>                           PTRRELOC(&__stop___lwsync_fixup));
>=20
> I can't boot on a 6xx based machine anymore.

OK, I guess it needs a PTRRELOC(), but it's not that important, don't
worry about it.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-N68KlsO7CtLU9VQijCkH
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIbGnOdSjSd0sB4dIRAn6LAJ9u4UUrkzRVHsL3CImEkovO4TYzUgCeK2vA
voSp1epg+CykrvrwVK4RoVw=
=J4HW
-----END PGP SIGNATURE-----

--=-N68KlsO7CtLU9VQijCkH--
