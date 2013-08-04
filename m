Return-Path: <haokexin@gmail.com>
Received: from mail-pa0-x234.google.com (mail-pa0-x234.google.com
 [IPv6:2607:f8b0:400e:c03::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 633B92C0092
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Aug 2013 10:50:46 +1000 (EST)
Received: by mail-pa0-f52.google.com with SMTP id kq13so1970770pab.11
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Aug 2013 17:50:44 -0700 (PDT)
Date: Sun, 4 Aug 2013 08:50:35 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 7/8] powerpc/fsl_booke: make sure PAGE_OFFSET map to
 memstart_addr for relocatable kernel
Message-ID: <20130804005035.GE19141@pek-khao-d1.corp.ad.wrs.com>
References: <1372942454-25191-1-git-send-email-haokexin@gmail.com>
 <1372942454-25191-8-git-send-email-haokexin@gmail.com>
 <1374884277.30721.39@snotra>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="EgVrEAR5UttbsTXg"
In-Reply-To: <1374884277.30721.39@snotra>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--EgVrEAR5UttbsTXg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2013 at 07:17:57PM -0500, Scott Wood wrote:
> On 07/04/2013 07:54:13 AM, Kevin Hao wrote:
> >@@ -1222,6 +1266,9 @@ _GLOBAL(switch_to_as1)
> > /*
> >  * Restore to the address space 0 and also invalidate the tlb
> >entry created
> >  * by switch_to_as1.
> >+ * r3 - the tlb entry which should be invalidated
> >+ * r4 - __pa(PAGE_OFFSET in AS0) - pa(PAGE_OFFSET in AS1)
> >+ * r5 - device tree virtual address
> > */
> > _GLOBAL(restore_to_as0)
> > 	mflr	r0
> >@@ -1230,7 +1277,15 @@ _GLOBAL(restore_to_as0)
> > 0:	mflr	r9
> > 	addi	r9,r9,1f - 0b
> >
> >-	mfmsr	r7
> >+	/*
> >+	 * We may map the PAGE_OFFSET in AS0 to a different physical
> >address,
> >+	 * so we need calculate the right jump and device tree address
> >based
> >+	 * on the offset passed by r4.
> >+	*/
>=20
> Whitespace

Fixed.

>=20
> >+	subf	r9,r4,r9
> >+	subf	r5,r4,r5
> >+
> >+2:	mfmsr	r7
> > 	li	r8,(MSR_IS | MSR_DS)
> > 	andc	r7,r7,r8
> >
> >@@ -1249,9 +1304,19 @@ _GLOBAL(restore_to_as0)
> > 	mtspr	SPRN_MAS1,r9
> > 	tlbwe
> > 	isync
> >+
> >+	cmpwi	r4,0
> >+	bne	3f
> > 	mtlr	r0
> > 	blr
> >
> >+	/*
> >+	 * The PAGE_OFFSET will map to a different physical address,
> >+	 * jump to _start to do another relocation again.
> >+	*/
> >+3:	mr	r3,r5
> >+	bl	_start
> >+
> > /*
> >  * We put a few things here that have to be page-aligned. This stuff
> >  * goes at the beginning of the data segment, which is page-aligned.
> >diff --git a/arch/powerpc/mm/fsl_booke_mmu.c
> >b/arch/powerpc/mm/fsl_booke_mmu.c
> >index 8f60ef8..dd283fd 100644
> >--- a/arch/powerpc/mm/fsl_booke_mmu.c
> >+++ b/arch/powerpc/mm/fsl_booke_mmu.c
> >@@ -224,7 +224,7 @@ void __init adjust_total_lowmem(void)
> >
> > 	i =3D switch_to_as1();
> > 	__max_low_memory =3D map_mem_in_cams(ram, CONFIG_LOWMEM_CAM_NUM);
> >-	restore_to_as0(i);
> >+	restore_to_as0(i, 0, 0);
>=20
> The device tree virtual address is zero?

No. But if the __pa(PAGE_OFFSET in AS0) is equal to __pa(PAGE_OFFSET in AS1=
),
that mean we don't need to do another relocation and the device tree virtual
address is useless in this case.

>=20
> > 	pr_info("Memory CAM mapping: ");
> > 	for (i =3D 0; i < tlbcam_index - 1; i++)
> >@@ -245,30 +245,56 @@ void setup_initial_memory_limit(phys_addr_t
> >first_memblock_base,
> > }
> >
> > #ifdef CONFIG_RELOCATABLE
> >-notrace void __init relocate_init(phys_addr_t start)
> >+int __initdata is_second_reloc;
> >+notrace void __init relocate_init(u64 dt_ptr, phys_addr_t start)
> > {
> > 	unsigned long base =3D KERNELBASE;
> >
> >-	/*
> >-	 * Relocatable kernel support based on processing of dynamic
> >-	 * relocation entries.
> >-	 * Compute the virt_phys_offset :
> >-	 * virt_phys_offset =3D stext.run - kernstart_addr
> >-	 *
> >-	 * stext.run =3D (KERNELBASE & ~0xfffffff) + (kernstart_addr &
> >0xfffffff)
> >-	 * When we relocate, we have :
> >-	 *
> >-	 *	(kernstart_addr & 0xfffffff) =3D (stext.run & 0xfffffff)
> >-	 *
> >-	 * hence:
> >-	 *  virt_phys_offset =3D (KERNELBASE & ~0xfffffff) -
> >-	 *                              (kernstart_addr & ~0xfffffff)
> >-	 *
> >-	 */
> > 	kernstart_addr =3D start;
> >-	start &=3D ~0xfffffff;
> >-	base &=3D ~0xfffffff;
> >-	virt_phys_offset =3D base - start;
> >+	if (!is_second_reloc) {
>=20
> Since it's at the end of a function and one side is much shorter
> than the
> other, please do:
>=20
> 	if (is_second_reloc) {
> 		virt_phys_offset =3D PAGE_OFFSET - memstart_addr;
> 		return;
> 	}
>=20
> 	/* the rest of the code goes here without having to indent
> everything */
>=20

Yes, this looks much better. Changed.

> Otherwise, please use positive logic for if/else constructs.
>=20
> >+		phys_addr_t size;
> >+
> >+		/*
> >+		 * Relocatable kernel support based on processing of dynamic
> >+		 * relocation entries. Before we get the real memstart_addr,
> >+		 * We will compute the virt_phys_offset like this:
> >+		 * virt_phys_offset =3D stext.run - kernstart_addr
> >+		 *
> >+		 * stext.run =3D (KERNELBASE & ~0xfffffff) +
> >+		 *				(kernstart_addr & 0xfffffff)
> >+		 * When we relocate, we have :
> >+		 *
> >+		 *	(kernstart_addr & 0xfffffff) =3D (stext.run & 0xfffffff)
> >+		 *
> >+		 * hence:
> >+		 *  virt_phys_offset =3D (KERNELBASE & ~0xfffffff) -
> >+		 *                              (kernstart_addr & ~0xfffffff)
> >+		 *
> >+		 */
> >+		start &=3D ~0xfffffff;
> >+		base &=3D ~0xfffffff;
> >+		virt_phys_offset =3D base - start;
> >+		early_get_first_memblock_info(__va(dt_ptr), &size);
> >+		/*
> >+		 * We now get the memstart_addr, then we should check if this
> >+		 * address is the same as what the PAGE_OFFSET map to now. If
> >+		 * not we have to change the map of PAGE_OFFSET to
> >memstart_addr
> >+		 * and do a second relocation.
> >+		 */
> >+		if (start !=3D memstart_addr) {
> >+			unsigned long ram;
> >+			int n, offset =3D memstart_addr - start;
> >+
> >+			is_second_reloc =3D 1;
> >+			ram =3D size;
> >+			n =3D switch_to_as1();
> >+			map_mem_in_cams(ram, CONFIG_LOWMEM_CAM_NUM);
>=20
> Do we really need this much RAM mapped at this point?

Not really.

>  Why can't we
> continue
> with the same size TLB entry that we've been using, until the second
> relocation?

OK, I will change it to use 64M.

>=20
> >+			restore_to_as0(n, offset, __va(dt_ptr));
> >+			/* We should never reach here */
> >+			panic("Relocation error");
>=20
> Where is execution supposed to resume?  It looks like you're
> expecting it
> to resume from _start,

Yes.

> but why?

For second relocation, we need to:
  * do the real relocate
  * set the interrupt vector
  * zero the BSS

So starting from the _start will avoid to duplicate these codes.

>  And where is this effect of
> restore_to_as0() documented?

There is a comment about this in restore_to_as0.

        /*  =20
         * The PAGE_OFFSET will map to a different physical address,
         * jump to _start to do another relocation again.
        */
3:      mr      r3,r5
        bl      _start

Thanks,
Kevin
>=20
> -Scott

--EgVrEAR5UttbsTXg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJR/aVbAAoJEJNY7TDerrFxxBAH/jJ2Y78aSq4BftkyzEgtzseb
nb5NvwGKFLOTO9l/RK2jVXzDQqnR6zUZ3m8RfvmNMyaMT4wmmU/N+ym6WDdpXVEZ
pDVfUhDd5PLqKGeuPs1PPhXjYh40MCNOCzBcIywVWjunrTIaMFBGE5brx4WWcGVc
SCru1kRvp2pqlqwwk6SfaP5XCEgfnQhDNigH7xRFrsUPz/sZCtDGgD0rt/hOh/W3
DOyVhUkEyzjfjE2/iTJghebYPdgbUMN7prcwfk1ge8r883tZdEK2cjyWclBMuPkk
nFvDjJcI/sBdI7aaSxxOT7SVvco97DVvd1VPUC2sXBFC3LcF2ViGgHkLSj8W5Iw=
=DAzE
-----END PGP SIGNATURE-----

--EgVrEAR5UttbsTXg--
