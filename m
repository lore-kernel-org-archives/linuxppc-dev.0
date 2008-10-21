Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] Support for relocatable kdump kernel
From: Michael Ellerman <michael@ellerman.id.au>
To: Mohan Kumar M <mohan@in.ibm.com>
In-Reply-To: <48FC5097.5090908@in.ibm.com>
References: <18684.5062.154465.668614@drongo.ozlabs.ibm.com>
	<1224485038.9055.34.camel@localhost>  <48FC5097.5090908@in.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-6nwjk3DqcyQkYDcoLCcN"
Date: Tue, 21 Oct 2008 17:03:38 +1100
Message-Id: <1224569019.8228.29.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	kexec <kexec@lists.infradead.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-6nwjk3DqcyQkYDcoLCcN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2008-10-20 at 15:04 +0530, Mohan Kumar M wrote:
> Michael Ellerman wrote:
> >>>  #ifdef CONFIG_CRASH_DUMP
> >>> +#ifdef CONFIG_RELOCATABLE
> >>> +
> >>> +static inline void reserve_kdump_trampoline(void) { ; }
> >>> +static inline void setup_kdump_trampoline(void) { ; }
> >>> +
> >>> +#else
> >>> =20
> >>>  extern void reserve_kdump_trampoline(void);
> >>>  extern void setup_kdump_trampoline(void);
> >>> =20
> >>> +#endif /* CONFIG_RELOCATABLE */
> >=20
> > You've disabled the else case with your Kconfig changes, so you should
> > just rip all that code out.
>=20
> I made Kconfig changes only to the 64 bit powerpc path and still the 32=20
> bit powerpc code uses the legacy kdump code. So we need to retain some=20
> of legacy kdump code.

Does it? I see CONFIG_CRASH_DUMP depending on PPC64, so there is no
32-bit kdump possible. Or is someone working on it out-of-tree?

> >>> diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head=
_64.S
> >>> index e409338..5b12b10 100644
> >>> --- a/arch/powerpc/kernel/head_64.S
> >>> +++ b/arch/powerpc/kernel/head_64.S
> >>> @@ -97,6 +97,14 @@ __secondary_hold_spinloop:
> >>>  __secondary_hold_acknowledge:
> >>>  	.llong	0x0
> >>> =20
> >>> +	/* This flag is set only for kdump kernels so that */
> >>> +	/* it will be relocatable. Purgatory code user space kexec-tools */
> >>> +	/* sets this flag. Do not move this variable as purgatory code */
> >>> +	/* relies on the position of this variables */
> >>> +	.globl	__kdump_flag
> >>> +__kdump_flag:
> >>> +	.llong	0x0
> >=20
> > I guess the __ matches the other flags here, it's not the prettiest
> > though. For client code (like in iommu.c) it'd be nice to have static
> > inline, perhaps is_kdump_kernel() that hides this.
> >=20
> Do you expect a function to do the checking in iommu.c?

You'd use the function in iommu.c, but it should be defined in some
header.

> >>>  #ifdef CONFIG_PPC_ISERIES
> >>>  	/*
> >>>  	 * At offset 0x20, there is a pointer to iSeries LPAR data.
> >>> @@ -1384,8 +1392,13 @@ _STATIC(__after_prom_start)
> >>>  	/* process relocations for the final address of the kernel */
> >>>  	lis	r25,PAGE_OFFSET@highest	/* compute virtual base of kernel */
> >>>  	sldi	r25,r25,32
> >>> +#ifdef CONFIG_CRASH_DUMP
> >>> +	ld	r7,__kdump_flag-_stext(r26)
> >>> +	cmpldi	cr0,r7,1	/* relocatable kernel ? */
> >=20
> > You don't use the signature here?
>=20
> kexec-tools check the signature and based on the signature it sets=20
> __kdump_flag to 1 (or 0). So kernel code just checks whether its set or n=
ot.

OK. Does old purgatory ensure that the register is 0? Otherwise I think
it's possible that a new kernel could get confused by cruft left in that
register by an old purgatory - causing the 2nd kernel to think it's a
kdump kernel when it shouldn't be.

> >>> @@ -1401,9 +1414,21 @@ _STATIC(__after_prom_start)
> >>>  	beq	9f			/* have already put us at zero */
> >>>  	li	r6,0x100		/* Start offset, the first 0x100 */
> >>>  					/* bytes were copied earlier.	 */
> >>> -#ifdef CONFIG_RELOCATABLE
> >>> +
> >>> +#ifdef CONFIG_CRASH_DUMP
> >>> +/*
> >>> + * Check if the kernel has to be running as relocatable kernel based=
 on the
> >>> + * variable __kdump_flag, if it is set the kernel is treated as relo=
catble
> >>> + * kernel, otherwise it will be moved to PHYSICAL_START
> >>> + */
> >>> +	ld	r7,__kdump_flag-_stext(r26)
> >>> +	cmpldi	cr0,r7,1
> >>> +	bne	regular
> >>> +
> >>>  	li	r5,__end_interrupts - _stext	/* just copy interrupts */
> >>> -#else
> >>> +	b	5f
> >>> +regular:
> >>> +#endif
> >>>  	lis	r5,(copy_to_here - _stext)@ha
> >>>  	addi	r5,r5,(copy_to_here - _stext)@l /* # bytes of memory to copy *=
/
> >=20
> > I'm jet lagged to hell, so I'm not sure I can trust my parsing of this.
> > But I think this definitely breaks CONFIG_RELOCATABLE without
> > CRASH_DUMP, and I'm not sure it's right otherwise.
> >
> Hmmm, I compiled and tried the kernel with 3 config option combinations:=20
> 1. CONFIG_RELOCATABLE and CONFIG_CRASH_DUMP 2. CONFIG_RELOCATABLE 3.=20
> Without CONFIG_RELOCATABLE (without CONFIG_CRASH_DUMP)
>=20
> All of the above 3 combinations worked. This patch relies on Pauls'=20
> patch5 in the relocatable kernel patcheset.

OK if you've tested.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-6nwjk3DqcyQkYDcoLCcN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBI/XC6dSjSd0sB4dIRAh3bAKCeProvtOPy3IdeumnWWQbW8kWIRQCgi2Rs
vvLDg5eRhx9fmN23+Ap0j6I=
=PksV
-----END PGP SIGNATURE-----

--=-6nwjk3DqcyQkYDcoLCcN--
