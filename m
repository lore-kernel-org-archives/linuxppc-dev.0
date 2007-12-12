Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 1/2] Make setjmp/longjmp code generic
From: Michael Ellerman <michael@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <20071212054512.882AC62C070@localhost.localdomain>
References: <20071212054512.882AC62C070@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-s5Mp8zZHiPNhlpaDM0Sr"
Date: Thu, 13 Dec 2007 09:56:55 +1100
Message-Id: <1197500215.7695.11.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, RAISCH@de.ibm.com,
	Paul Mackerras <paulus@samba.org>, THEMANN@de.ibm.com
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-s5Mp8zZHiPNhlpaDM0Sr
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-12-12 at 16:45 +1100, Michael Neuling wrote:
> This makes the setjmp/longjmp code used by xmon, generically available
> to other code.  It also removes the requirement for debugger hooks to
> be only called on 0x300 (data storage) exception.
>=20
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
>=20
>  arch/powerpc/kernel/misc_64.S |  124 +++++++++++++++++++++++++++++++++++=
+++
>  arch/powerpc/mm/fault.c       |    6 -
>  arch/powerpc/xmon/Makefile    |    2=20
>  arch/powerpc/xmon/setjmp.S    |  135 -----------------------------------=
-------
>  arch/powerpc/xmon/xmon.c      |   10 ---
>  include/asm-powerpc/setjmp.h  |   12 +++
>  6 files changed, 142 insertions(+), 147 deletions(-)
>=20
> Index: linux-2.6-ozlabs/arch/powerpc/kernel/misc_64.S
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6-ozlabs.orig/arch/powerpc/kernel/misc_64.S
> +++ linux-2.6-ozlabs/arch/powerpc/kernel/misc_64.S
> @@ -518,6 +518,130 @@ _GLOBAL(giveup_altivec)
> =20
>  #endif /* CONFIG_ALTIVEC */
> =20
> +_GLOBAL(setjmp)
> +	mflr	r0
> +	PPC_STL	r0,0(r3)
> +	PPC_STL	r1,SZL(r3)
> +	PPC_STL	r2,2*SZL(r3)
> +	mfcr	r0
> +	PPC_STL	r0,3*SZL(r3)
> +	PPC_STL	r13,4*SZL(r3)
> +	PPC_STL	r14,5*SZL(r3)
> +	PPC_STL	r15,6*SZL(r3)
> +	PPC_STL	r16,7*SZL(r3)
> +	PPC_STL	r17,8*SZL(r3)
> +	PPC_STL	r18,9*SZL(r3)
> +	PPC_STL	r19,10*SZL(r3)
> +	PPC_STL	r20,11*SZL(r3)
> +	PPC_STL	r21,12*SZL(r3)
> +	PPC_STL	r22,13*SZL(r3)
> +	PPC_STL	r23,14*SZL(r3)
> +	PPC_STL	r24,15*SZL(r3)
> +	PPC_STL	r25,16*SZL(r3)
> +	PPC_STL	r26,17*SZL(r3)
> +	PPC_STL	r27,18*SZL(r3)
> +	PPC_STL	r28,19*SZL(r3)
> +	PPC_STL	r29,20*SZL(r3)
> +	PPC_STL	r30,21*SZL(r3)
> +	PPC_STL	r31,22*SZL(r3)
> +	li	r3,0
> +	blr
> +
> +_GLOBAL(longjmp)
> +	PPC_LCMPI r4,0
> +	bne	1f
> +	li	r4,1
> +1:	PPC_LL	r13,4*SZL(r3)
> +	PPC_LL	r14,5*SZL(r3)
> +	PPC_LL	r15,6*SZL(r3)
> +	PPC_LL	r16,7*SZL(r3)
> +	PPC_LL	r17,8*SZL(r3)
> +	PPC_LL	r18,9*SZL(r3)
> +	PPC_LL	r19,10*SZL(r3)
> +	PPC_LL	r20,11*SZL(r3)
> +	PPC_LL	r21,12*SZL(r3)
> +	PPC_LL	r22,13*SZL(r3)
> +	PPC_LL	r23,14*SZL(r3)
> +	PPC_LL	r24,15*SZL(r3)
> +	PPC_LL	r25,16*SZL(r3)
> +	PPC_LL	r26,17*SZL(r3)
> +	PPC_LL	r27,18*SZL(r3)
> +	PPC_LL	r28,19*SZL(r3)
> +	PPC_LL	r29,20*SZL(r3)
> +	PPC_LL	r30,21*SZL(r3)
> +	PPC_LL	r31,22*SZL(r3)
> +	PPC_LL	r0,3*SZL(r3)
> +	mtcrf	0x38,r0
> +	PPC_LL	r0,0(r3)
> +	PPC_LL	r1,SZL(r3)
> +	PPC_LL	r2,2*SZL(r3)
> +	mtlr	r0
> +	mr	r3,r4
> +	blr
> +
> +#ifdef CONFIG_XMON
> +/*
> + * Grab the register values as they are now.
> + * This won't do a particularily good job because we really
> + * want our caller's caller's registers, and our caller has
> + * already executed its prologue.
> + * ToDo: We could reach back into the caller's save area to do
> + * a better job of representing the caller's state (note that
> + * that will be different for 32-bit and 64-bit, because of the
> + * different ABIs, though).
> + */
> +_GLOBAL(xmon_save_regs)
> +	PPC_STL	r0,0*SZL(r3)
> +	PPC_STL	r2,2*SZL(r3)
> +	PPC_STL	r3,3*SZL(r3)
> +	PPC_STL	r4,4*SZL(r3)

Does xmon_save_regs belong here?

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-s5Mp8zZHiPNhlpaDM0Sr
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHYGc3dSjSd0sB4dIRAnXYAKCsFVK1aG9VdIGdf45f16i8KJS+6QCcDmZL
UO/CB2n9zf8oi3ZS3lPtvLU=
=BnVr
-----END PGP SIGNATURE-----

--=-s5Mp8zZHiPNhlpaDM0Sr--
