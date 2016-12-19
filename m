Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3thkgT2lG5zDwGs
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 13:01:57 +1100 (AEDT)
Date: Mon, 19 Dec 2016 11:24:58 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Thomas Huth <thuth@redhat.com>
Cc: paulus@samba.org, michael@ellerman.id.au, benh@kernel.crashing.org,
 sjitindarsingh@gmail.com, lvivier@redhat.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH 05/11] powerpc/kvm: Split HPT allocation from activation
Message-ID: <20161219002458.GK12146@umbus.fritz.box>
References: <20161215055404.29351-1-david@gibson.dropbear.id.au>
 <20161215055404.29351-6-david@gibson.dropbear.id.au>
 <e2b1693f-494f-a6d8-3c66-6591566a303b@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VJJoKLVEFXdmHQwR"
In-Reply-To: <e2b1693f-494f-a6d8-3c66-6591566a303b@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--VJJoKLVEFXdmHQwR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 16, 2016 at 12:57:26PM +0100, Thomas Huth wrote:
> On 15.12.2016 06:53, David Gibson wrote:
> > Currently, kvmppc_alloc_hpt() both allocates a new hashed page table (H=
PT)
> > and sets it up as the active page table for a VM.  For the upcoming HPT
> > resize implementation we're going to want to allocate HPTs separately f=
rom
> > activating them.
> >=20
> > So, split the allocation itself out into kvmppc_allocate_hpt() and perf=
orm
> > the activation with a new kvmppc_set_hpt() function.  Likewise we split
> > kvmppc_free_hpt(), which just frees the HPT, from kvmppc_release_hpt()
> > which unsets it as an active HPT, then frees it.
> >=20
> > We also move the logic to fall back to smaller HPT sizes if the first t=
ry
> > fails into the single caller which used that behaviour,
> > kvmppc_hv_setup_htab_rma().  This introduces a slight semantic change, =
in
> > that previously if the initial attempt at CMA allocation failed, we wou=
ld
> > fall back to attempting smaller sizes with the page allocator.  Now, we
> > try first CMA, then the page allocator at each size.  As far as I can t=
ell
> > this change should be harmless.
> >=20
> > To match, we make kvmppc_free_hpt() just free the actual HPT itself.  T=
he
> > call to kvmppc_free_lpid() that was there, we move to the single caller.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  arch/powerpc/include/asm/kvm_book3s_64.h |  3 ++
> >  arch/powerpc/include/asm/kvm_ppc.h       |  5 +-
> >  arch/powerpc/kvm/book3s_64_mmu_hv.c      | 90 ++++++++++++++++--------=
--------
> >  arch/powerpc/kvm/book3s_hv.c             | 18 +++++--
> >  4 files changed, 65 insertions(+), 51 deletions(-)
> >=20
> > diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/in=
clude/asm/kvm_book3s_64.h
> > index 8810327..6dc4004 100644
> > --- a/arch/powerpc/include/asm/kvm_book3s_64.h
> > +++ b/arch/powerpc/include/asm/kvm_book3s_64.h
> > @@ -22,6 +22,9 @@
> > =20
> >  #include <asm/book3s/64/mmu-hash.h>
> > =20
> > +/* Power architecture requires HPT is at least 256kB */
> > +#define PPC_MIN_HPT_ORDER	18
> > +
> >  #ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
> >  static inline struct kvmppc_book3s_shadow_vcpu *svcpu_get(struct kvm_v=
cpu *vcpu)
> >  {
> > diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/=
asm/kvm_ppc.h
> > index 3db6be9..41575b8 100644
> > --- a/arch/powerpc/include/asm/kvm_ppc.h
> > +++ b/arch/powerpc/include/asm/kvm_ppc.h
> > @@ -155,9 +155,10 @@ extern void kvmppc_core_destroy_mmu(struct kvm_vcp=
u *vcpu);
> >  extern int kvmppc_kvm_pv(struct kvm_vcpu *vcpu);
> >  extern void kvmppc_map_magic(struct kvm_vcpu *vcpu);
> > =20
> > -extern long kvmppc_alloc_hpt(struct kvm *kvm, u32 *htab_orderp);
> > +extern int kvmppc_allocate_hpt(struct kvm_hpt_info *info, u32 order);
> > +extern void kvmppc_set_hpt(struct kvm *kvm, struct kvm_hpt_info *info);
> >  extern long kvmppc_alloc_reset_hpt(struct kvm *kvm, u32 *htab_orderp);
> > -extern void kvmppc_free_hpt(struct kvm *kvm);
> > +extern void kvmppc_free_hpt(struct kvm_hpt_info *info);
> >  extern long kvmppc_prepare_vrma(struct kvm *kvm,
> >  				struct kvm_userspace_memory_region *mem);
> >  extern void kvmppc_map_vrma(struct kvm_vcpu *vcpu,
> > diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/boo=
k3s_64_mmu_hv.c
> > index fe88132..68bb228 100644
> > --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
> > +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> > @@ -40,76 +40,70 @@
> > =20
> >  #include "trace_hv.h"
> > =20
> > -/* Power architecture requires HPT is at least 256kB */
> > -#define PPC_MIN_HPT_ORDER	18
> > -
> >  static long kvmppc_virtmode_do_h_enter(struct kvm *kvm, unsigned long =
flags,
> >  				long pte_index, unsigned long pteh,
> >  				unsigned long ptel, unsigned long *pte_idx_ret);
> >  static void kvmppc_rmap_reset(struct kvm *kvm);
> > =20
> > -long kvmppc_alloc_hpt(struct kvm *kvm, u32 *htab_orderp)
> > +int kvmppc_allocate_hpt(struct kvm_hpt_info *info, u32 order)
> >  {
> >  	unsigned long hpt =3D 0;
> > -	struct revmap_entry *rev;
> > +	int cma =3D 0;
> >  	struct page *page =3D NULL;
> > -	long order =3D KVM_DEFAULT_HPT_ORDER;
> > -
> > -	if (htab_orderp) {
> > -		order =3D *htab_orderp;
> > -		if (order < PPC_MIN_HPT_ORDER)
> > -			order =3D PPC_MIN_HPT_ORDER;
> > -	}
>=20
> Not sure, but as far as I can see, *htab_orderp could still be provided
> from userspace via kvm_arch_vm_ioctl_hv() -> kvmppc_alloc_reset_hpt() ?
> In that case, I think you should still check that the order is bigger
> than PPC_MIN_HPT_ORDER, and return an error code otherwise?
> Or if you feel confident that this value can never be supplied by
> userspace anymore, add at least a BUG_ON(order < PPC_MIN_HPT_ORDER) here?

Ah, you're right, I do need to check this.

> > +	struct revmap_entry *rev;
> > +	unsigned long npte;
> > =20
> > -	kvm->arch.hpt.cma =3D 0;
> > +	hpt =3D 0;
> > +	cma =3D 0;
>=20
> Both hpt and cma are initialized to zero in the variable declarations
> already, so the above two lines are redundant.

Oops.  I even spotted that one at some point, then forgot about it
again.

> >  	page =3D kvm_alloc_hpt_cma(1ul << (order - PAGE_SHIFT));
> >  	if (page) {
> >  		hpt =3D (unsigned long)pfn_to_kaddr(page_to_pfn(page));
> >  		memset((void *)hpt, 0, (1ul << order));
> > -		kvm->arch.hpt.cma =3D 1;
> > +		cma =3D 1;
> >  	}
> > =20
> > -	/* Lastly try successively smaller sizes from the page allocator */
> > -	/* Only do this if userspace didn't specify a size via ioctl */
> > -	while (!hpt && order > PPC_MIN_HPT_ORDER && !htab_orderp) {
> > -		hpt =3D __get_free_pages(GFP_KERNEL|__GFP_ZERO|__GFP_REPEAT|
> > -				       __GFP_NOWARN, order - PAGE_SHIFT);
> > -		if (!hpt)
> > -			--order;
> > -	}
> > +	if (!hpt)
> > +		hpt =3D __get_free_pages(GFP_KERNEL|__GFP_ZERO|__GFP_REPEAT
> > +				       |__GFP_NOWARN, order - PAGE_SHIFT);
> > =20
> >  	if (!hpt)
> >  		return -ENOMEM;
> > =20
> > -	kvm->arch.hpt.virt =3D hpt;
> > -	kvm->arch.hpt.order =3D order;
> > -
> > -	atomic64_set(&kvm->arch.mmio_update, 0);
> > +	/* HPTEs are 2**4 bytes long */
> > +	npte =3D 1ul << (order - 4);
> > =20
> >  	/* Allocate reverse map array */
> > -	rev =3D vmalloc(sizeof(struct revmap_entry) * kvmppc_hpt_npte(&kvm->a=
rch.hpt));
> > +	rev =3D vmalloc(sizeof(struct revmap_entry) * npte);
> >  	if (!rev) {
> > -		pr_err("kvmppc_alloc_hpt: Couldn't alloc reverse map array\n");
> > +		pr_err("kvmppc_allocate_hpt: Couldn't alloc reverse map array\n");
> >  		goto out_freehpt;
>=20
> So here you jump to out_freehpt before setting info->virt ...
>=20
> >  	}
> > -	kvm->arch.hpt.rev =3D rev;
> > -	kvm->arch.sdr1 =3D __pa(hpt) | (order - 18);
> > =20
> > -	pr_info("KVM guest htab at %lx (order %ld), LPID %x\n",
> > -		hpt, order, kvm->arch.lpid);
> > +	info->order =3D order;
> > +	info->virt =3D hpt;
> > +	info->cma =3D cma;
> > +	info->rev =3D rev;
> > =20
> > -	if (htab_orderp)
> > -		*htab_orderp =3D order;
> >  	return 0;
> > =20
> >   out_freehpt:
> > -	if (kvm->arch.hpt.cma)
> > +	if (cma)
> >  		kvm_free_hpt_cma(page, 1 << (order - PAGE_SHIFT));
> >  	else
> > -		free_pages(hpt, order - PAGE_SHIFT);
> > +		free_pages(info->virt, order - PAGE_SHIFT);
>=20
> ... but here you free info->virt which has not been set in case of the
> "goto" above. That's clearly wrong.

Good catch.  Also, there's only one use of that label, so there's not
really any reason to use a goto at all.  Adjusted.

> >  	return -ENOMEM;
> >  }
> > =20
> > +void kvmppc_set_hpt(struct kvm *kvm, struct kvm_hpt_info *info)
> > +{
> > +	atomic64_set(&kvm->arch.mmio_update, 0);
> > +	kvm->arch.hpt =3D *info;
> > +	kvm->arch.sdr1 =3D __pa(info->virt) | (info->order - 18);
> > +
> > +	pr_info("KVM guest htab at %lx (order %ld), LPID %x\n",
> > +		info->virt, (long)info->order, kvm->arch.lpid);
>=20
> Not directly related to your patch, but these messages pop up in the
> dmesg each time I start a guest ... for the normal user who does not
> have a clue what "htab" means, this can be pretty much annoying. Could
> you maybe turn this into a pr_debug() instead?

Maybe, but that's not really in scope for these patches.

> > +}
> > +
> >  long kvmppc_alloc_reset_hpt(struct kvm *kvm, u32 *htab_orderp)
> >  {
> >  	long err =3D -EBUSY;
> > @@ -138,24 +132,28 @@ long kvmppc_alloc_reset_hpt(struct kvm *kvm, u32 =
*htab_orderp)
> >  		*htab_orderp =3D order;
> >  		err =3D 0;
> >  	} else {
> > -		err =3D kvmppc_alloc_hpt(kvm, htab_orderp);
> > -		order =3D *htab_orderp;
> > +		struct kvm_hpt_info info;
> > +
> > +		err =3D kvmppc_allocate_hpt(&info, *htab_orderp);
> > +		if (err < 0)
> > +			goto out;
> > +		kvmppc_set_hpt(kvm, &info);
>=20
> Just a matter of taste (I dislike gotos if avoidable), but you could
> also do:
>=20
> 	err =3D kvmppc_allocate_hpt(&info, *htab_orderp);
> 	if (!err)
> 		kvmppc_set_hpt(kvm, &info);
>=20
> ... and that's even one line shorter ;-)

Hrm.  I'd prefer to keep the goto: when most 1-line if statements are
the exception/failure case, it's very easy to miss that here it's the
success case.

> >  	}
> >   out:
> >  	mutex_unlock(&kvm->lock);
> >  	return err;
> >  }
> > =20
> > -void kvmppc_free_hpt(struct kvm *kvm)
> > +void kvmppc_free_hpt(struct kvm_hpt_info *info)
> >  {
> > -	kvmppc_free_lpid(kvm->arch.lpid);
> > -	vfree(kvm->arch.hpt.rev);
> > -	if (kvm->arch.hpt.cma)
> > -		kvm_free_hpt_cma(virt_to_page(kvm->arch.hpt.virt),
> > -				 1 << (kvm->arch.hpt.order - PAGE_SHIFT));
> > +	vfree(info->rev);
> > +	if (info->cma)
> > +		kvm_free_hpt_cma(virt_to_page(info->virt),
> > +				 1 << (info->order - PAGE_SHIFT));
> >  	else
> > -		free_pages(kvm->arch.hpt.virt,
> > -			   kvm->arch.hpt.order - PAGE_SHIFT);
> > +		free_pages(info->virt, info->order - PAGE_SHIFT);
> > +	info->virt =3D 0;
> > +	info->order =3D 0;
> >  }
> > =20
> >  /* Bits in first HPTE dword for pagesize 4k, 64k or 16M */
> > diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> > index 78baa2b..71c5adb 100644
> > --- a/arch/powerpc/kvm/book3s_hv.c
> > +++ b/arch/powerpc/kvm/book3s_hv.c
> > @@ -3115,11 +3115,22 @@ static int kvmppc_hv_setup_htab_rma(struct kvm_=
vcpu *vcpu)
> > =20
> >  	/* Allocate hashed page table (if not done already) and reset it */
> >  	if (!kvm->arch.hpt.virt) {
> > -		err =3D kvmppc_alloc_hpt(kvm, NULL);
> > -		if (err) {
> > +		int order =3D KVM_DEFAULT_HPT_ORDER;
> > +		struct kvm_hpt_info info;
> > +
> > +		err =3D kvmppc_allocate_hpt(&info, order);
> > +		/* If we get here, it means userspace didn't specify a
> > +		 * size explicitly.  So, try successively smaller
> > +		 * sizes if the default failed. */
> > +		while (err < 0 && --order >=3D PPC_MIN_HPT_ORDER)
> > +			err  =3D kvmppc_allocate_hpt(&info, order);
>=20
> Not sure, but maybe replace "err < 0" with "err =3D=3D -ENOMEM" in the wh=
ile
> condition? Or should it also loop on other future possible errors types?

No, I think you're right.  Looping only on -ENOMEM is a better idea.

> > +		if (err < 0) {
> >  			pr_err("KVM: Couldn't alloc HPT\n");
> >  			goto out;
> >  		}
> > +
> > +		kvmppc_set_hpt(kvm, &info);
> >  	}
> > =20
> >  	/* Look up the memslot for guest physical address 0 */
> > @@ -3357,7 +3368,8 @@ static void kvmppc_core_destroy_vm_hv(struct kvm =
*kvm)
> > =20
> >  	kvmppc_free_vcores(kvm);
> > =20
> > -	kvmppc_free_hpt(kvm);
> > +	kvmppc_free_lpid(kvm->arch.lpid);
> > +	kvmppc_free_hpt(&kvm->arch.hpt);
> > =20
> >  	kvmppc_free_pimap(kvm);
> >  }
> >=20
>=20
>  Thomas
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--VJJoKLVEFXdmHQwR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYVyjYAAoJEGw4ysog2bOSXZ8QAKSn92STOVdaITZLU3e0OYk2
BHmBH7cy3EsldxhrRea7iypjnn4GOg+nCBo8+q8D3EWaO6eRMJ9UMXNuqitkufke
1mYyR94Z6ncX6wqNEWdP9nS70GMRF/D3IiWm6B7CLNOXLaUSx3mjcy+hNS5Uu6kf
0lHkiCPykDuOCfsH6uMV4a3kYmHhvX6OgSR9YR+9MAMB2hSRMC84cpcxLJxXO4Gf
NTWkYJs6eu1QTYMX5d+W6G2Q8ruZ/XwrAni/5x0YrMlTSf9iSrq8kp7sv5rtJ4NG
yY2lWhDuYoCBo2XSaRFjFUbOCAh6mWKsjCf1TdDJDqO3ozjKxjS5KPXHFRXJjgjB
Q7iUXkjO30cyxUrNbXSECzNB6lA9bUYfTGYb5YP4THBFnTsRLxuf3kgp/4QixgD/
6jlkI7jA/QSPiAzG550ixxFwpTAXKqdFa1twusxEmde/3fUOMP4V3Q+YvQbmy3O0
rSxbTYgBMMEB48NaWzVq6Mps5/xI9OIF8Pa1TwVIWR/lP1T4p/hCqVpda/etsOKi
PsFUHsWqY8dVkNhYyHNeONiMSfWwNEtfHyEJIvjk9smSC2q0NjaCrvb4cRMP0TY3
7V+WqC5Lfp0NCGa9MHJZpbDWvar1XdNDEYCJafQ1tvTWF5CMKYz1PnsNJftA8vZo
HqaGyoND04Le4fMafGPo
=whkK
-----END PGP SIGNATURE-----

--VJJoKLVEFXdmHQwR--
