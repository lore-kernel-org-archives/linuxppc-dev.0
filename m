Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3thkgT3RcnzDwGw
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 13:01:57 +1100 (AEDT)
Date: Mon, 19 Dec 2016 11:04:56 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Thomas Huth <thuth@redhat.com>
Cc: paulus@samba.org, michael@ellerman.id.au, benh@kernel.crashing.org,
 sjitindarsingh@gmail.com, lvivier@redhat.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH 04/11] powerpc/kvm: Don't store values derivable from HPT
 order
Message-ID: <20161219000456.GJ12146@umbus.fritz.box>
References: <20161215055404.29351-1-david@gibson.dropbear.id.au>
 <20161215055404.29351-5-david@gibson.dropbear.id.au>
 <db1ccf7b-7355-e0d4-ac36-26cc9c833105@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="GvznHscUikHnwW2p"
In-Reply-To: <db1ccf7b-7355-e0d4-ac36-26cc9c833105@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--GvznHscUikHnwW2p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 16, 2016 at 11:39:26AM +0100, Thomas Huth wrote:
> On 15.12.2016 06:53, David Gibson wrote:
> > Currently the kvm_hpt_info structure stores the hashed page table's ord=
er,
> > and also the number of HPTEs it contains and a mask for its size.  The
> > last two can be easily derived from the order, so remove them and just
> > calculate them as necessary with a couple of helper inlines.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> [...]
> > diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/boo=
k3s_64_mmu_hv.c
> > index b5799d1..fe88132 100644
> > --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
> > +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> > @@ -83,15 +83,11 @@ long kvmppc_alloc_hpt(struct kvm *kvm, u32 *htab_or=
derp)
> > =20
> >  	kvm->arch.hpt.virt =3D hpt;
> >  	kvm->arch.hpt.order =3D order;
> > -	/* HPTEs are 2**4 bytes long */
> > -	kvm->arch.hpt.npte =3D 1ul << (order - 4);
> > -	/* 128 (2**7) bytes in each HPTEG */
> > -	kvm->arch.hpt.mask =3D (1ul << (order - 7)) - 1;
> > =20
> >  	atomic64_set(&kvm->arch.mmio_update, 0);
> > =20
> >  	/* Allocate reverse map array */
> > -	rev =3D vmalloc(sizeof(struct revmap_entry) * kvm->arch.hpt.npte);
> > +	rev =3D vmalloc(sizeof(struct revmap_entry) * kvmppc_hpt_npte(&kvm->a=
rch.hpt));
> >  	if (!rev) {
> >  		pr_err("kvmppc_alloc_hpt: Couldn't alloc reverse map array\n");
> >  		goto out_freehpt;
> > @@ -194,8 +190,8 @@ void kvmppc_map_vrma(struct kvm_vcpu *vcpu, struct =
kvm_memory_slot *memslot,
> >  	if (npages > 1ul << (40 - porder))
> >  		npages =3D 1ul << (40 - porder);
> >  	/* Can't use more than 1 HPTE per HPTEG */
> > -	if (npages > kvm->arch.hpt.mask + 1)
> > -		npages =3D kvm->arch.hpt.mask + 1;
> > +	if (npages > kvmppc_hpt_mask(&kvm->arch.hpt) + 1)
> > +		npages =3D kvmppc_hpt_mask(&kvm->arch.hpt) + 1;
> > =20
> >  	hp0 =3D HPTE_V_1TB_SEG | (VRMA_VSID << (40 - 16)) |
> >  		HPTE_V_BOLTED | hpte0_pgsize_encoding(psize);
> > @@ -205,7 +201,8 @@ void kvmppc_map_vrma(struct kvm_vcpu *vcpu, struct =
kvm_memory_slot *memslot,
> >  	for (i =3D 0; i < npages; ++i) {
> >  		addr =3D i << porder;
> >  		/* can't use hpt_hash since va > 64 bits */
> > -		hash =3D (i ^ (VRMA_VSID ^ (VRMA_VSID << 25))) & kvm->arch.hpt.mask;
> > +		hash =3D (i ^ (VRMA_VSID ^ (VRMA_VSID << 25)))
> > +			& kvmppc_hpt_mask(&kvm->arch.hpt);
> >  		/*
> >  		 * We assume that the hash table is empty and no
> >  		 * vcpus are using it at this stage.  Since we create
>=20
> kvmppc_hpt_mask() is now called three times in kvmppc_map_vrma() ... you
> could use a local variable to store the value so that the calculation
> has only be done once here.

Well, I was assuming that inlining plus gcc's common subexpression
elimination would deal with that.

>=20
> > @@ -1306,7 +1303,7 @@ static ssize_t kvm_htab_read(struct file *file, c=
har __user *buf,
> > =20
> >  		/* Skip uninteresting entries, i.e. clean on not-first pass */
> >  		if (!first_pass) {
> > -			while (i < kvm->arch.hpt.npte &&
> > +			while (i < kvmppc_hpt_npte(&kvm->arch.hpt) &&
> >  			       !hpte_dirty(revp, hptp)) {
> >  				++i;
> >  				hptp +=3D 2;
> > @@ -1316,7 +1313,7 @@ static ssize_t kvm_htab_read(struct file *file, c=
har __user *buf,
> >  		hdr.index =3D i;
> > =20
> >  		/* Grab a series of valid entries */
> > -		while (i < kvm->arch.hpt.npte &&
> > +		while (i < kvmppc_hpt_npte(&kvm->arch.hpt) &&
> >  		       hdr.n_valid < 0xffff &&
> >  		       nb + HPTE_SIZE < count &&
> >  		       record_hpte(flags, hptp, hpte, revp, 1, first_pass)) {
> > @@ -1332,7 +1329,7 @@ static ssize_t kvm_htab_read(struct file *file, c=
har __user *buf,
> >  			++revp;
> >  		}
> >  		/* Now skip invalid entries while we can */
> > -		while (i < kvm->arch.hpt.npte &&
> > +		while (i < kvmppc_hpt_npte(&kvm->arch.hpt) &&
> >  		       hdr.n_invalid < 0xffff &&
> >  		       record_hpte(flags, hptp, hpte, revp, 0, first_pass)) {
> >  			/* found an invalid entry */
>=20
> Dito, you could use a local variable to store the value from
> kvmppc_hpt_npte()
>=20
> Anyway, apart from these nits, patch looks fine to me, so:
>=20
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--GvznHscUikHnwW2p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYVyQoAAoJEGw4ysog2bOSzQYP/30oiFemzRYuk5YeVUKmyida
xHDZYrYJ32DFJy92tgOW0uLB0VQ04inMv2MdB+peMuhRBK4/C+V0XevPzKqHP1Wo
PcCr7HlFPIxWpLRNpIoRaVbsUuShrgikk24rtSxv5/CaCvrnqabeKhbFp61y5VWe
6YeN+YlOSzq1z4r0Sam86gSJj7tNgZuYsF7Wte2F0C/4JLquFXg6Vor21dn1OiDK
3R8r1JHkb5xFw8Uw+b2DPoa4mMBZhQsLlAiYGajAox9fJ5ocyjUPdUWdoTVJ0O+2
GyHe8DCdMO8/Xw17kLZxbEbE7wbn5yIEe+iXsA3a+31ll4O66x6W6b+VZsuN0Ej8
sWGR6R7stjIRv2bnMxnUBKERbyIrHKCz8bv584kzNLt+0yH6+IaebbwbI07UOUqO
2sDIo2gxEsHfGmjpLUEL0AzZ9NsvzyMB+vg+QKLBJX+Bm1S/+lrpbTvZiMyZax2i
8smsadjdHQgW25NmE00S1ZbbwSmAqDO7bXmZ/pu1+Px4/U1XIHamwxlrk7OILNbo
5qriFkOS76YSmA7lRi298hnkx3WOt5d/sArlE5yWO28MgpylXSioqNtf30qxd39Y
wO1NGfVqO+ABwQtbDuF9jpTeD/4RL4zUZ04C7ZS9Jlz0K9SeHpa11ca0FNlJiHzC
octkQypoKj+bh1QNKSla
=mHge
-----END PGP SIGNATURE-----

--GvznHscUikHnwW2p--
