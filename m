Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] Support for relocatable kdump kernel
From: Michael Ellerman <michael@ellerman.id.au>
To: Mohan Kumar <mohan@in.ibm.com>
In-Reply-To: <18684.5062.154465.668614@drongo.ozlabs.ibm.com>
References: <18684.5062.154465.668614@drongo.ozlabs.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-ssoWNeMs5ZBUF6upHM4T"
Date: Mon, 20 Oct 2008 17:43:58 +1100
Message-Id: <1224485038.9055.34.camel@localhost>
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


--=-ssoWNeMs5ZBUF6upHM4T
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

> > -------- Forwarded Message --------
> > From: Mohan Kumar M <mohan@in.ibm.com>
> > To: paulus@samba.org
> > Cc: linuxppc-dev@ozlabs.org, kexec@lists.infradead.org
> > Subject: [PATCH] Support for relocatable kdump kernel
> > Date: Mon, 13 Oct 2008 05:04:20 +0530
> >=20
> > Support for relocatable kdump kernel
> >=20
> > This patch adds relocatable kernel support for kdump. With this one can
> > use the same regular kernel to capture the kdump. A signature (0xfeed12=
34)
> > is passed in r8 from panic code to the next kernel through kexec_sequen=
ce
> > and purgatory code. The signature is used to differentiate between
> > relocatable kdump kernel and non-kdump kernels.

You should put a big fat warning here in the changelog. By changing the
calling sequence (adding to it), we now require that for a new kernel to
work as a kdump kernel it has to be loaded with new kexec tools.

> > The purgatory code compares the signature and sets the __kdump_flag in
> > head_64.S.  During the boot up, kernel code checks __kdump_flag and if =
it
> > is set, the kernel will behave as relocatable kdump kernel. This kernel
> > will boot at the address where it was loaded by kexec-tools ie at the
> > address reserved through crashkernel boot parameter
> >=20
> > CONFIG_CRASH_DUMP depends on CONFIG_RELOCATABLE option to build kdump
> > kernel as relocatable. So the same kernel can be used as production and
> > kdump kernel.

Those two statements aren't really related. A CONFIG_RELOCATABLE kernel
can be used as both a kdump and a normal kernel, and we need to make
sure that a CONFIG_CRASH_DUMP kernel can be used as both - ie. that
there's no code that uses CONFIG_CRASH_DUMP to do anything we /don't/
want in a normal kernel.

> > This patch incorporates the changes suggested by Paul Mackerrass to avo=
id
> > GOT use and to avoid two copies of the code.
> >=20
> > Signed-off-by: Mohan Kumar M <mohan@in.ibm.com>

> > diff --git a/Documentation/kdump/kdump.txt b/Documentation/kdump/kdump.=
txt
> > index 0705040..3f4bc84 100644
> > --- a/Documentation/kdump/kdump.txt
> > +++ b/Documentation/kdump/kdump.txt
> > @@ -109,7 +109,8 @@ There are two possible methods of using Kdump.
> >  2) Or use the system kernel binary itself as dump-capture kernel and t=
here is
> >     no need to build a separate dump-capture kernel. This is possible
> >     only with the architecutres which support a relocatable kernel. As
> > -   of today, i386, x86_64 and ia64 architectures support relocatable k=
ernel.
> > +   of today, i386, x86_64, ppc64 and ia64 architectures support reloca=
table
> > +   kernel.

This is a little bit unclear as the kernel now doesn't have a ppc64
architecture. You might want to say "64-bit powerpc (ppc64)", because
that matches the kernel arch and also kexec-tools (which still has
ppc32/64 IIRC)

> > =20
> >  Building a relocatable kernel is advantageous from the point of view t=
hat
> >  one does not have to build a second kernel for capturing the dump. But
> > @@ -207,8 +208,15 @@ Dump-capture kernel config options (Arch Dependent=
, i386 and x86_64)
> >  Dump-capture kernel config options (Arch Dependent, ppc64)
> >  ----------------------------------------------------------
> > =20
> > -*  Make and install the kernel and its modules. DO NOT add this kernel
> > -   to the boot loader configuration files.
> > +1) Enable "Build a kdump crash kernel" support under "Kernel" options:
> > +
> > +   CONFIG_CRASH_DUMP=3Dy
> > +
> > +2)   Enable "Build a relocatable kernel" support
> > +
> > +   CONFIG_RELOCATABLE=3Dy
> > +
> > +   Make and install the kernel and its modules.
> > =20
> >  Dump-capture kernel config options (Arch Dependent, ia64)
> >  ----------------------------------------------------------
> > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> > index 17c988b..6b3e840 100644
> > --- a/arch/powerpc/Kconfig
> > +++ b/arch/powerpc/Kconfig
> > @@ -321,11 +321,11 @@ config KEXEC
> > =20
> >  config CRASH_DUMP
> >  	bool "Build a kdump crash kernel"
> > -	depends on PPC_MULTIPLATFORM && PPC64
> > +	depends on PPC_MULTIPLATFORM && PPC64 && RELOCATABLE
> >  	help
> >  	  Build a kernel suitable for use as a kdump capture kernel.
> > -	  The kernel will be linked at a different address than normal, and
> > -	  so can only be used for Kdump.
> > +	  The same kernel binary can be used as production kernel and dump ca=
pture
> > +	  kernel
> > =20
> >  	  Don't change this unless you know what you are doing.
> > =20
> > @@ -824,11 +824,9 @@ config PAGE_OFFSET
> >  	default "0xc000000000000000"
> >  config KERNEL_START
> >  	hex
> > -	default "0xc000000002000000" if CRASH_DUMP
> >  	default "0xc000000000000000"
> >  config PHYSICAL_START
> >  	hex
> > -	default "0x02000000" if CRASH_DUMP
> >  	default "0x00000000"
> >  endif
> > =20
> > diff --git a/arch/powerpc/include/asm/kdump.h b/arch/powerpc/include/as=
m/kdump.h
> > index f6c93c7..5308754 100644
> > --- a/arch/powerpc/include/asm/kdump.h
> > +++ b/arch/powerpc/include/asm/kdump.h
> > @@ -9,6 +9,12 @@
> >   * Reserve to the end of the FWNMI area, see head_64.S */
> >  #define KDUMP_RESERVE_LIMIT	0x10000 /* 64K */
> > =20
> > +/*
> > + * Used to differentiate between relocatable kdump kernel and other
> > + * kernels
> > + */
> > +#define KDUMP_SIGNATURE	0xfeed1234
> > +
> >  #ifdef CONFIG_CRASH_DUMP
> > =20
> >  #define KDUMP_TRAMPOLINE_START	0x0100
> > @@ -19,11 +25,21 @@
> >  #endif /* CONFIG_CRASH_DUMP */
> > =20
> >  #ifndef __ASSEMBLY__
> > +
> > +extern unsigned long long __kdump_flag;

Why long long ?

> >  #ifdef CONFIG_CRASH_DUMP
> > +#ifdef CONFIG_RELOCATABLE
> > +
> > +static inline void reserve_kdump_trampoline(void) { ; }
> > +static inline void setup_kdump_trampoline(void) { ; }
> > +
> > +#else
> > =20
> >  extern void reserve_kdump_trampoline(void);
> >  extern void setup_kdump_trampoline(void);
> > =20
> > +#endif /* CONFIG_RELOCATABLE */

You've disabled the else case with your Kconfig changes, so you should
just rip all that code out.

> >  static inline void reserve_kdump_trampoline(void) { ; }
> > diff --git a/arch/powerpc/kernel/crash_dump.c b/arch/powerpc/kernel/cra=
sh_dump.c
> > index a323c9b..eaf9d6d 100644
> > --- a/arch/powerpc/kernel/crash_dump.c
> > +++ b/arch/powerpc/kernel/crash_dump.c
> > @@ -27,6 +27,7 @@
> >  #define DBG(fmt...)
> >  #endif
> > =20
> > +#ifndef CONFIG_RELOCATABLE
> >  void __init reserve_kdump_trampoline(void)
> >  {
> >  	lmb_reserve(0, KDUMP_RESERVE_LIMIT);
> > @@ -65,6 +66,7 @@ void __init setup_kdump_trampoline(void)
> > =20
> >  	DBG(" <- setup_kdump_trampoline()\n");
> >  }
> > +#endif /* CONFIG_RELOCATABLE */
> > =20
> >  #ifdef CONFIG_PROC_VMCORE
> >  static int __init parse_elfcorehdr(char *p)
> > diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_6=
4.S
> > index e409338..5b12b10 100644
> > --- a/arch/powerpc/kernel/head_64.S
> > +++ b/arch/powerpc/kernel/head_64.S
> > @@ -97,6 +97,14 @@ __secondary_hold_spinloop:
> >  __secondary_hold_acknowledge:
> >  	.llong	0x0
> > =20
> > +	/* This flag is set only for kdump kernels so that */
> > +	/* it will be relocatable. Purgatory code user space kexec-tools */
> > +	/* sets this flag. Do not move this variable as purgatory code */
> > +	/* relies on the position of this variables */
> > +	.globl	__kdump_flag
> > +__kdump_flag:
> > +	.llong	0x0

I guess the __ matches the other flags here, it's not the prettiest
though. For client code (like in iommu.c) it'd be nice to have static
inline, perhaps is_kdump_kernel() that hides this.

> >  #ifdef CONFIG_PPC_ISERIES
> >  	/*
> >  	 * At offset 0x20, there is a pointer to iSeries LPAR data.
> > @@ -1384,8 +1392,13 @@ _STATIC(__after_prom_start)
> >  	/* process relocations for the final address of the kernel */
> >  	lis	r25,PAGE_OFFSET@highest	/* compute virtual base of kernel */
> >  	sldi	r25,r25,32
> > +#ifdef CONFIG_CRASH_DUMP
> > +	ld	r7,__kdump_flag-_stext(r26)
> > +	cmpldi	cr0,r7,1	/* relocatable kernel ? */

You don't use the signature here?

> > +	bne	1f
> >  	add	r25,r25,r26
> > -	mr	r3,r25
> > +#endif
> > +1:	mr	r3,r25
> >  	bl	.relocate
> >  #endif
> > =20
> > @@ -1401,9 +1414,21 @@ _STATIC(__after_prom_start)
> >  	beq	9f			/* have already put us at zero */
> >  	li	r6,0x100		/* Start offset, the first 0x100 */
> >  					/* bytes were copied earlier.	 */
> > -#ifdef CONFIG_RELOCATABLE
> > +
> > +#ifdef CONFIG_CRASH_DUMP
> > +/*
> > + * Check if the kernel has to be running as relocatable kernel based o=
n the
> > + * variable __kdump_flag, if it is set the kernel is treated as reloca=
tble
> > + * kernel, otherwise it will be moved to PHYSICAL_START
> > + */
> > +	ld	r7,__kdump_flag-_stext(r26)
> > +	cmpldi	cr0,r7,1
> > +	bne	regular
> > +
> >  	li	r5,__end_interrupts - _stext	/* just copy interrupts */
> > -#else
> > +	b	5f
> > +regular:
> > +#endif
> >  	lis	r5,(copy_to_here - _stext)@ha
> >  	addi	r5,r5,(copy_to_here - _stext)@l /* # bytes of memory to copy */

I'm jet lagged to hell, so I'm not sure I can trust my parsing of this.
But I think this definitely breaks CONFIG_RELOCATABLE without
CRASH_DUMP, and I'm not sure it's right otherwise.

> > @@ -1420,8 +1445,7 @@ p_end:	.llong	_end - _stext
> >  4:	/* Now copy the rest of the kernel up to _end */
> >  	addis	r5,r26,(p_end - _stext)@ha
> >  	ld	r5,(p_end - _stext)@l(r5)	/* get _end */
> > -#endif
> > -	bl	.copy_and_flush		/* copy the rest */
> > +5:	bl	.copy_and_flush		/* copy the rest */
> > =20
> >  9:	b	.start_here_multiplatform
> > =20
> > diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> > index 550a193..24f7797 100644
> > --- a/arch/powerpc/kernel/iommu.c
> > +++ b/arch/powerpc/kernel/iommu.c
> > @@ -494,7 +494,7 @@ struct iommu_table *iommu_init_table(struct iommu_t=
able *tbl, int nid)
> >  	spin_lock_init(&tbl->it_lock);
> > =20
> >  #ifdef CONFIG_CRASH_DUMP
> > -	if (ppc_md.tce_get) {
> > +	if (ppc_md.tce_get && __kdump_flag) {
> >  		unsigned long index;
> >  		unsigned long tceval;
> >  		unsigned long tcecount =3D 0;


I see more code that needs this sort of treatment in pseries/iommu.c and
cell/ras.c

> > diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/=
machine_kexec.c
> > index aab7688..ac2a21f 100644
> > --- a/arch/powerpc/kernel/machine_kexec.c
> > +++ b/arch/powerpc/kernel/machine_kexec.c
> > @@ -88,11 +88,13 @@ void __init reserve_crashkernel(void)
> > =20
> >  	crash_size =3D crashk_res.end - crashk_res.start + 1;
> > =20
> > +#ifndef CONFIG_RELOCATABLE
> >  	if (crashk_res.start !=3D KDUMP_KERNELBASE)
> >  		printk("Crash kernel location must be 0x%x\n",
> >  				KDUMP_KERNELBASE);

We still need code here for the RELOCATABLE case that checks a) the
kernel is being allocated inside the RMO, and b) that it's 64k aligned.

> > =20
> >  	crashk_res.start =3D KDUMP_KERNELBASE;
> > +#endif
> >  	crash_size =3D PAGE_ALIGN(crash_size);
> >  	crashk_res.end =3D crashk_res.start + crash_size - 1;
> > =20
> > diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kern=
el/machine_kexec_64.c
> > index a168514..6a45a9e 100644
> > --- a/arch/powerpc/kernel/machine_kexec_64.c
> > +++ b/arch/powerpc/kernel/machine_kexec_64.c
> > @@ -255,11 +255,13 @@ static union thread_union kexec_stack
> >  /* Our assembly helper, in kexec_stub.S */
> >  extern NORET_TYPE void kexec_sequence(void *newstack, unsigned long st=
art,
> >  					void *image, void *control,
> > -					void (*clear_all)(void)) ATTRIB_NORET;
> > +					void (*clear_all)(void),
> > +				unsigned long long kdump_flag) ATTRIB_NORET;
> > =20
> >  /* too late to fail here */
> >  void default_machine_kexec(struct kimage *image)
> >  {
> > +	unsigned long long kdump_flag =3D 0;
> >  	/* prepare control code if any */
> > =20
> >  	/*
> > @@ -270,8 +272,10 @@ void default_machine_kexec(struct kimage *image)
> >          * using debugger IPI.
> >          */
> > =20
> > -       if (crashing_cpu =3D=3D -1)
> > -               kexec_prepare_cpus();
> > +	if (crashing_cpu =3D=3D -1)
> > +		kexec_prepare_cpus();
> > +	else
> > +		kdump_flag =3D KDUMP_SIGNATURE;
> > =20
> >  	/* switch to a staticly allocated stack.  Based on irq stack code.
> >  	 * XXX: the task struct will likely be invalid once we do the copy!
> > @@ -284,7 +288,7 @@ void default_machine_kexec(struct kimage *image)
> >  	 */
> >  	kexec_sequence(&kexec_stack, image->start, image,
> >  			page_address(image->control_code_page),
> > -			ppc_md.hpte_clear_all);
> > +			ppc_md.hpte_clear_all, kdump_flag);
> >  	/* NOTREACHED */
> >  }
> > =20
> > diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_6=
4.S
> > index 4dd70cf..c93e5f7 100644
> > --- a/arch/powerpc/kernel/misc_64.S
> > +++ b/arch/powerpc/kernel/misc_64.S
> > @@ -609,10 +609,13 @@ real_mode:	/* assume normal blr return */
> > =20
> >=20
> >  /*
> > - * kexec_sequence(newstack, start, image, control, clear_all())
> > + * kexec_sequence(newstack, start, image, control, clear_all(), kdump_=
flag)
> >   *
> >   * does the grungy work with stack switching and real mode switches
> >   * also does simple calls to other code
> > + *
> > + * kdump_flag says whether the next kernel should be running at the re=
served
> > + * load address as needed for relocatable kdump kernel
> >   */

Doesn't it just say "we crashed in the first kernel" - what the 2nd
kernel does is up to it.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-ssoWNeMs5ZBUF6upHM4T
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBI/CiudSjSd0sB4dIRAnejAJ98VKw9Szlj0D/xE5c3IgVQnK+CtACeL7kk
LMmvnfHz70P0c32iK+0EvBI=
=5uQM
-----END PGP SIGNATURE-----

--=-ssoWNeMs5ZBUF6upHM4T--
