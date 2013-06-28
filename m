Return-Path: <haokexin@gmail.com>
Received: from mail-pb0-x235.google.com (mail-pb0-x235.google.com
 [IPv6:2607:f8b0:400e:c01::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A56D32C02EE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 11:36:50 +1000 (EST)
Received: by mail-pb0-f53.google.com with SMTP id xb12so1614091pbc.40
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 18:36:48 -0700 (PDT)
Date: Fri, 28 Jun 2013 09:36:37 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/2] powerpc: enable the relocatable support for the fsl
 booke 32bit kernel
Message-ID: <20130628013637.GA3173@pek-khao-d1.corp.ad.wrs.com>
References: <1372298434-20220-2-git-send-email-haokexin@gmail.com>
 <1372363114.8183.54@snotra>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
In-Reply-To: <1372363114.8183.54@snotra>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2013 at 02:58:34PM -0500, Scott Wood wrote:
> On 06/26/2013 09:00:33 PM, Kevin Hao wrote:
> >This is based on the codes in the head_44x.S. Since we always align to
> >256M before mapping the PAGE_OFFSET for a relocatable kernel, we also
> >change the init tlb map to 256M size.
>=20
> Why 256M?

For two reasons:
  1. This is the size which both e500v1 and e500v2 support.
  2. Since we always use the PAGE_OFFSET as 0xc0000000, the 256M is
     max alignment value we can use for this virtual address.

>=20
> This tightens the alignment requirement for dynamic memstart.

Yes. But since RELOCATABLE is a superset of DYNAMIC_MEMSTART, we can always
use RELOCATABLE instead of DYNAMIC_MEMSTART for fsl booke board in any case=
s.
So DYNAMIC_MEMSTART will seem not so useful after we enable this feature.

>  And
> what about boards with less than 256 MiB of RAM?

It should be fine. We just create the map in the tlb. The MM still use
the real size of memory.

>=20
> >@@ -176,6 +176,8 @@ skpinv:	addi	r6,r6,1				/* Increment */
> > /* 7. Jump to KERNELBASE mapping */
> > 	lis	r6,(KERNELBASE & ~0xfff)@h
> > 	ori	r6,r6,(KERNELBASE & ~0xfff)@l
> >+	rlwinm	r7,r25,0,4,31
> >+	add	r6,r7,r6
>=20
> Please consider using the more readable form of rlwinm/rlwimi:
>=20
> 	rlwinm	r7,r25,0,0x0fffffff

Sure.

>=20
> > #elif defined(ENTRY_MAPPING_KEXEC_SETUP)
> > /*
> >diff --git a/arch/powerpc/kernel/head_fsl_booke.S
> >b/arch/powerpc/kernel/head_fsl_booke.S
> >index d10a7ca..c3b4c8e53 100644
> >--- a/arch/powerpc/kernel/head_fsl_booke.S
> >+++ b/arch/powerpc/kernel/head_fsl_booke.S
> >@@ -83,10 +83,43 @@ _ENTRY(_start);
> > 	andc	r31,r20,r18		/* r31 =3D page base */
> > 	or	r31,r31,r19		/* r31 =3D devtree phys addr */
> > 	mfspr	r30,SPRN_MAS7
> >-
> >-	li	r25,0			/* phys kernel start (low) */
> > 	li	r24,0			/* CPU number */
> >-	li	r23,0			/* phys kernel start (high) */
> >+
> >+#ifdef CONFIG_RELOCATABLE
> >+	bl	0f				/* Get our runtime address */
> >+0:	mflr	r3				/* Make it accessible */
> >+	addis	r3,r3,(_stext - 0b)@ha
> >+	addi	r3,r3,(_stext - 0b)@l 	/* Get our current runtime base */
> >+
> >+	/* Translate _stext address to physical, save in r23/r25 */
> >+	tlbsx	0,r3			/* must succeed */
> >+
> >+	mfspr	r16,SPRN_MAS1
> >+	mfspr	r20,SPRN_MAS3
> >+	rlwinm	r17,r16,25,0x1f		/* r17 =3D log2(page size) */
> >+	li	r18,1024
> >+	slw	r18,r18,r17		/* r18 =3D page size */
> >+	addi	r18,r18,-1
> >+	and	r19,r3,r18		/* r19 =3D page offset */
> >+	andc	r25,r20,r18		/* r25 =3D page base */
> >+	or	r25,r25,r19		/* r25 =3D _stext phys addr */
> >+	mfspr	r23,SPRN_MAS7
>=20
> This duplicates the code for finding the device tree physical
> address... maybe factor it out into a function?

Sure.

>=20
> >@@ -197,7 +230,58 @@ _ENTRY(__early_start)
> >
> > 	bl	early_init
> >
> >-#ifdef CONFIG_DYNAMIC_MEMSTART
> >+#ifdef CONFIG_RELOCATABLE
> >+	/*
> >+	 * Relocatable kernel support based on processing of dynamic
> >+	 * relocation entries.
> >+	 *
> >+	 * r25/r23 will contain RPN/ERPN for the start address of memory
>=20
> The start of memory or the start of the kernel?

Should be the start of the kernel. Will fix the comment.

>=20
> >+	 */
> >+	lis	r3,kernstart_addr@ha
> >+	la	r3,kernstart_addr@l(r3)
> >+
> >+#ifdef CONFIG_PHYS_64BIT
> >+	stw	r23,0(r3)
> >+	stw	r25,4(r3)
> >+#else
> >+	stw	r25,0(r3)
> >+#endif
>=20
> This part looks the same for relocatable and dynamic memstart -- can
> you avoid duplicating?

OK.

>=20
> >+	/*
> >+	 * Compute the virt_phys_offset :
> >+	 * virt_phys_offset =3D stext.run - kernstart_addr
> >+	 *
> >+	 * stext.run =3D (KERNELBASE & ~0xfffffff) + (kernstart_addr &
> >0xfffffff)
> >+	 * When we relocate, we have :
> >+	 *
> >+	 *	(kernstart_addr & 0xfffffff) =3D (stext.run & 0xfffffff)
> >+	 *
> >+	 * hence:
> >+	 *  virt_phys_offset =3D (KERNELBASE & ~0xfffffff) -
> >+	 *                              (kernstart_addr & ~0xfffffff)
> >+	 *
> >+	 */
> >+
> >+	/* KERNELBASE&~0xfffffff =3D> (r4,r5) */
>=20
> >+	li	r4, 0		/* higer 32bit */
> >+	lis	r5,KERNELBASE@h
>=20
> Please be consistent with whitespace.

Fixed.

Thanks,
Kevin

>=20
> -Scott

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJRzOilAAoJEJNY7TDerrFxIF8H/26yFh/nDwK8ZcV9iM44Vya2
mNcZV0Z4Cke98qtbr0r4k8uZPUhcN/3qjde2qIbnttc386k2dXOdvqu+MTqiM1Py
QInOdA70cEmpCyW1eWQCQdvs36/ozXbtyWFJ5wZIhn7sqt2RlKBh779dQ98BWArb
NWUikI9N9S0zBIHEJYi+ddaKSfHJHIenFbkgBArujWGQww2v/DRkT/JAvPjLZrIO
j34dc3lk2RBRQdoAClLZ8/L4ZMI9HI0R+5hwe6z9JU+GUBKEtQZ4qhb6jPPAC480
1Ltn7V4JRr8+VQi+C9dm5HgOtxyaQufeuETI66pqbje3L3rWlcLRPeoO4+IKqyg=
=jP9B
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
