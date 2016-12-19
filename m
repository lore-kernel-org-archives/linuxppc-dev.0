Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3thkgT4cNqzDwGy
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 13:01:57 +1100 (AEDT)
Date: Mon, 19 Dec 2016 11:48:09 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Thomas Huth <thuth@redhat.com>
Cc: paulus@samba.org, michael@ellerman.id.au, benh@kernel.crashing.org,
 sjitindarsingh@gmail.com, lvivier@redhat.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH 06/11] powerpc/kvm: Allow KVM_PPC_ALLOCATE_HTAB ioctl()
 to change HPT size
Message-ID: <20161219004809.GL12146@umbus.fritz.box>
References: <20161215055404.29351-1-david@gibson.dropbear.id.au>
 <20161215055404.29351-7-david@gibson.dropbear.id.au>
 <6c2566ea-cc80-4c02-27a2-258284d8f98b@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="CqfQkoYPE/jGoa5Q"
In-Reply-To: <6c2566ea-cc80-4c02-27a2-258284d8f98b@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--CqfQkoYPE/jGoa5Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 16, 2016 at 01:44:57PM +0100, Thomas Huth wrote:
> On 15.12.2016 06:53, David Gibson wrote:
> > The KVM_PPC_ALLOCATE_HTAB ioctl() is used to set the size of hashed page
> > table (HPT) that userspace expects a guest VM to have, and is also used=
 to
> > clear that HPT when necessary (e.g. guest reboot).
> >=20
> > At present, once the ioctl() is called for the first time, the HPT size=
 can
> > never be changed thereafter - it will be cleared but always sized as fr=
om
> > the first call.
> >=20
> > With upcoming HPT resize implementation, we're going to need to allow
> > userspace to resize the HPT at reset (to change it back to the default =
size
> > if the guest changed it).
> >=20
> > So, we need to allow this ioctl() to change the HPT size.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  arch/powerpc/include/asm/kvm_ppc.h  |  2 +-
> >  arch/powerpc/kvm/book3s_64_mmu_hv.c | 53 ++++++++++++++++++++---------=
--------
> >  arch/powerpc/kvm/book3s_hv.c        |  5 +---
> >  3 files changed, 30 insertions(+), 30 deletions(-)
> >=20
> > diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/=
asm/kvm_ppc.h
> > index 41575b8..3b837bc 100644
> > --- a/arch/powerpc/include/asm/kvm_ppc.h
> > +++ b/arch/powerpc/include/asm/kvm_ppc.h
> > @@ -157,7 +157,7 @@ extern void kvmppc_map_magic(struct kvm_vcpu *vcpu);
> > =20
> >  extern int kvmppc_allocate_hpt(struct kvm_hpt_info *info, u32 order);
> >  extern void kvmppc_set_hpt(struct kvm *kvm, struct kvm_hpt_info *info);
> > -extern long kvmppc_alloc_reset_hpt(struct kvm *kvm, u32 *htab_orderp);
> > +extern long kvmppc_alloc_reset_hpt(struct kvm *kvm, int order);
> >  extern void kvmppc_free_hpt(struct kvm_hpt_info *info);
> >  extern long kvmppc_prepare_vrma(struct kvm *kvm,
> >  				struct kvm_userspace_memory_region *mem);
> > diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/boo=
k3s_64_mmu_hv.c
> > index 68bb228..8e5ac2f 100644
> > --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
> > +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> > @@ -104,10 +104,22 @@ void kvmppc_set_hpt(struct kvm *kvm, struct kvm_h=
pt_info *info)
> >  		info->virt, (long)info->order, kvm->arch.lpid);
> >  }
> > =20
> > -long kvmppc_alloc_reset_hpt(struct kvm *kvm, u32 *htab_orderp)
> > +void kvmppc_free_hpt(struct kvm_hpt_info *info)
> > +{
> > +	vfree(info->rev);
> > +	if (info->cma)
> > +		kvm_free_hpt_cma(virt_to_page(info->virt),
> > +				 1 << (info->order - PAGE_SHIFT));
> > +	else
> > +		free_pages(info->virt, info->order - PAGE_SHIFT);
> > +	info->virt =3D 0;
> > +	info->order =3D 0;
> > +}
>=20
> Why do you need to move kvmppc_free_hpt() around? Seems like unecessary
> code churn to me?

Previously, kvmppc_free_hpt() wasn't needed in
kvmppc_alloc_reset_hpt(), now it is.  So we need to move it above that
function.  I could move it in the previous patch, but that would
obscure what the actual changes are to it, so it seemed better to do
it here.

>=20
> > +long kvmppc_alloc_reset_hpt(struct kvm *kvm, int order)
> >  {
> >  	long err =3D -EBUSY;
> > -	long order;
> > +	struct kvm_hpt_info info;
> > =20
> >  	mutex_lock(&kvm->lock);
> >  	if (kvm->arch.hpte_setup_done) {
> > @@ -119,8 +131,9 @@ long kvmppc_alloc_reset_hpt(struct kvm *kvm, u32 *h=
tab_orderp)
> >  			goto out;
> >  		}
> >  	}
> > -	if (kvm->arch.hpt.virt) {
> > -		order =3D kvm->arch.hpt.order;
> > +	if (kvm->arch.hpt.order =3D=3D order) {
> > +		/* We already have a suitable HPT */
> > +
> >  		/* Set the entire HPT to 0, i.e. invalid HPTEs */
> >  		memset((void *)kvm->arch.hpt.virt, 0, 1ul << order);
> >  		/*
> > @@ -129,33 +142,23 @@ long kvmppc_alloc_reset_hpt(struct kvm *kvm, u32 =
*htab_orderp)
> >  		kvmppc_rmap_reset(kvm);
> >  		/* Ensure that each vcpu will flush its TLB on next entry. */
> >  		cpumask_setall(&kvm->arch.need_tlb_flush);
> > -		*htab_orderp =3D order;
> >  		err =3D 0;
> > -	} else {
> > -		struct kvm_hpt_info info;
> > -
> > -		err =3D kvmppc_allocate_hpt(&info, *htab_orderp);
> > -		if (err < 0)
> > -			goto out;
> > -		kvmppc_set_hpt(kvm, &info);
> > +		goto out;
> >  	}
> > - out:
> > +
> > +	if (kvm->arch.hpt.virt)
> > +		kvmppc_free_hpt(&kvm->arch.hpt);
> > +
> > +	err =3D kvmppc_allocate_hpt(&info, order);
> > +	if (err < 0)
> > +		goto out;
> > +	kvmppc_set_hpt(kvm, &info);
> > +
> > +out:
> >  	mutex_unlock(&kvm->lock);
> >  	return err;
> >  }
> > =20
> > -void kvmppc_free_hpt(struct kvm_hpt_info *info)
> > -{
> > -	vfree(info->rev);
> > -	if (info->cma)
> > -		kvm_free_hpt_cma(virt_to_page(info->virt),
> > -				 1 << (info->order - PAGE_SHIFT));
> > -	else
> > -		free_pages(info->virt, info->order - PAGE_SHIFT);
> > -	info->virt =3D 0;
> > -	info->order =3D 0;
> > -}
> > -
> >  /* Bits in first HPTE dword for pagesize 4k, 64k or 16M */
> >  static inline unsigned long hpte0_pgsize_encoding(unsigned long pgsize)
> >  {
> > diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> > index 71c5adb..957e473 100644
> > --- a/arch/powerpc/kvm/book3s_hv.c
> > +++ b/arch/powerpc/kvm/book3s_hv.c
> > @@ -3600,12 +3600,9 @@ static long kvm_arch_vm_ioctl_hv(struct file *fi=
lp,
> >  		r =3D -EFAULT;
> >  		if (get_user(htab_order, (u32 __user *)argp))
> >  			break;
> > -		r =3D kvmppc_alloc_reset_hpt(kvm, &htab_order);
> > +		r =3D kvmppc_alloc_reset_hpt(kvm, htab_order);
> >  		if (r)
> >  			break;
> > -		r =3D -EFAULT;
> > -		if (put_user(htab_order, (u32 __user *)argp))
> > -			break;
>=20
> Now that htab_order is not changed anymore by the kernel, I'm pretty
> sure you need some checks on the value here before calling
> kvmppc_alloc_reset_hpt(), e.g. return an error code if htab_order <
> PPC_MIN_HPT_ORDER.

Right.  I've done that by putting the checks into
kvmppc_allocate_hpt() in the earlier patch.

> And, I'm not sure if I got that right, but in former times, the
> htab_order from the userspace application was just a suggestion, and now
> it's mandatory, right? So if an old userspace used a very high value
> here (or even something smaller than PPC_MIN_HPT_ORDER like 0), the
> kernel fixed this up and the userspace could run happily with the fixed
> value afterwards. But since this value from userspace if mandatory now,
> such an userspace application is broken now. So maybe it's better to
> introduce a new ioctl for this new behavior instead, to avoid breaking
> old userspace applications?

A long time ago it was just a hint.  However, that behaviour was
already changed in 572abd5 "KVM: PPC: Book3S HV: Don't fall back to
smaller HPT size in allocation ioctl".  This is important: without
that we could get a different HPT size on the two ends of a migration,
which broke things nastily.

> Anyway, you should also update Documentation/virtual/kvm/api.txt to
> reflect the new behavior.

Good point.  Done.

>=20
> >  		r =3D 0;
> >  		break;
> >  	}
>=20
>  Thomas
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--CqfQkoYPE/jGoa5Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYVy5HAAoJEGw4ysog2bOSI08QAMmllJ74DpeHx9lk3AvsQNel
BaD7EhI09e0Lwt5QN56am3Sr3e2fGWhzIe0zr6/QNL/qqqBqD5BtqYWYvxYQrw7G
FHcvKQVR61h9atUW2dWW9QTnwp1DPMLiljfDJxUnyf+Z3TgCOP40XEpkGAbz1kKe
pzFDcPOPRgspG5CMlCXOmUfSyPH0oh10RC7phruL6E5bnTsemVt4YbAFobr+FZ3G
URnp1XIBPhtuFJcuCvuACFZDUEnkbfhl9MSAcetiUcHu3DX7NUI2rUJTx/z7+1Hn
KUorNKo1E4uziTieMnw814NMRlIT3S80FQWWwGGRH7Sy62cdto3QqRh/rDU0SbGy
FaKTupz66HYExcVswH0SzrBO3mX7/cpZW2MdcPJ3dteHbjgopbORzYApkYDZ4u5i
uiRxvo+w4sh8dmnANdeK/kNKnmaUs3f8jkKZZ6FVx5Jihg1A7RR5IUKBQnumXBi2
KttRVDh3j1pAUoZdCsNQk3EgTLpK6RjgEH3CPC4XblIU1RmsZJNXX9FWLvhKrkQl
uaO1D0vhsZOh4dhjSrnDDKE2qY+s60c+msg5AP3zd3TvtifpN1ewGgYyVDL/S6/S
RuAEgwgcP+c9ikAcAbm6tiLjA4TDWCEXAQzpv+HohK1OqcpKf7wZLV2yF1F1uwwj
jfygCDAV1LFYnAZQiw5U
=fRQw
-----END PGP SIGNATURE-----

--CqfQkoYPE/jGoa5Q--
