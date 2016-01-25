Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 940231A0C63
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jan 2016 11:43:11 +1100 (AEDT)
Date: Mon, 25 Jan 2016 11:44:02 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH kernel v2 6/6] KVM: PPC: Add support for multiple-TCE
 hcalls
Message-ID: <20160125004402.GF27454@voom.redhat.com>
References: <1453361977-19589-1-git-send-email-aik@ozlabs.ru>
 <1453361977-19589-7-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="KJKxYQkVikLexIKR"
In-Reply-To: <1453361977-19589-7-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--KJKxYQkVikLexIKR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 21, 2016 at 06:39:37PM +1100, Alexey Kardashevskiy wrote:
> This adds real and virtual mode handlers for the H_PUT_TCE_INDIRECT and
> H_STUFF_TCE hypercalls for user space emulated devices such as IBMVIO
> devices or emulated PCI.  These calls allow adding multiple entries
> (up to 512) into the TCE table in one call which saves time on
> transition between kernel and user space.
>=20
> This implements the KVM_CAP_PPC_MULTITCE capability. When present,
> the kernel will try handling H_PUT_TCE_INDIRECT and H_STUFF_TCE.
> If they can not be handled by the kernel, they are passed on to
> the user space. The user space still has to have an implementation
> for these.
>=20
> Both HV and PR-syle KVM are supported.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> Changes:
> v2:
> * compare @ret with H_SUCCESS instead of assuming H_SUCCESS is zero
> * s/~IOMMU_PAGE_MASK_4K/SZ_4K-1/ when testing @tce_list
> ---
>  Documentation/virtual/kvm/api.txt       |  25 ++++++
>  arch/powerpc/include/asm/kvm_ppc.h      |  12 +++
>  arch/powerpc/kvm/book3s_64_vio.c        | 110 +++++++++++++++++++++++-
>  arch/powerpc/kvm/book3s_64_vio_hv.c     | 145 ++++++++++++++++++++++++++=
++++--
>  arch/powerpc/kvm/book3s_hv.c            |  26 +++++-
>  arch/powerpc/kvm/book3s_hv_rmhandlers.S |   6 +-
>  arch/powerpc/kvm/book3s_pr_papr.c       |  35 ++++++++
>  arch/powerpc/kvm/powerpc.c              |   3 +
>  8 files changed, 349 insertions(+), 13 deletions(-)
>=20
> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kv=
m/api.txt
> index 07e4cdf..da39435 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -3035,6 +3035,31 @@ Returns: 0 on success, -1 on error
> =20
>  Queues an SMI on the thread's vcpu.
> =20
> +4.97 KVM_CAP_PPC_MULTITCE
> +
> +Capability: KVM_CAP_PPC_MULTITCE
> +Architectures: ppc
> +Type: vm
> +
> +This capability means the kernel is capable of handling hypercalls
> +H_PUT_TCE_INDIRECT and H_STUFF_TCE without passing those into the user
> +space. This significantly accelerates DMA operations for PPC KVM guests.
> +User space should expect that its handlers for these hypercalls
> +are not going to be called if user space previously registered LIOBN
> +in KVM (via KVM_CREATE_SPAPR_TCE or similar calls).
> +
> +In order to enable H_PUT_TCE_INDIRECT and H_STUFF_TCE use in the guest,
> +user space might have to advertise it for the guest. For example,
> +IBM pSeries (sPAPR) guest starts using them if "hcall-multi-tce" is
> +present in the "ibm,hypertas-functions" device-tree property.
> +
> +The hypercalls mentioned above may or may not be processed successfully
> +in the kernel based fast path. If they can not be handled by the kernel,
> +they will get passed on to user space. So user space still has to have
> +an implementation for these despite the in kernel acceleration.
> +
> +This capability is always enabled.
> +
>  5. The kvm_run structure
>  ------------------------
> =20
> diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/as=
m/kvm_ppc.h
> index 9513911..4cadee5 100644
> --- a/arch/powerpc/include/asm/kvm_ppc.h
> +++ b/arch/powerpc/include/asm/kvm_ppc.h
> @@ -166,12 +166,24 @@ extern int kvmppc_pseries_do_hcall(struct kvm_vcpu =
*vcpu);
> =20
>  extern long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>  				struct kvm_create_spapr_tce *args);
> +extern struct kvmppc_spapr_tce_table *kvmppc_find_table(
> +		struct kvm_vcpu *vcpu, unsigned long liobn);
>  extern long kvmppc_ioba_validate(struct kvmppc_spapr_tce_table *stt,
>  		unsigned long ioba, unsigned long npages);
>  extern long kvmppc_tce_validate(struct kvmppc_spapr_tce_table *tt,
>  		unsigned long tce);
> +extern long kvmppc_gpa_to_ua(struct kvm *kvm, unsigned long gpa,
> +		unsigned long *ua, unsigned long **prmap);

Putting a userspace address into an unsigned long is pretty nasty: it
should be a something __user *.

> +extern void kvmppc_tce_put(struct kvmppc_spapr_tce_table *tt,
> +		unsigned long idx, unsigned long tce);
>  extern long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
>  			     unsigned long ioba, unsigned long tce);
> +extern long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
> +		unsigned long liobn, unsigned long ioba,
> +		unsigned long tce_list, unsigned long npages);
> +extern long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
> +		unsigned long liobn, unsigned long ioba,
> +		unsigned long tce_value, unsigned long npages);
>  extern long kvmppc_h_get_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
>  			     unsigned long ioba);
>  extern struct page *kvm_alloc_hpt(unsigned long nr_pages);
> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_6=
4_vio.c
> index 975f0ab..987f406 100644
> --- a/arch/powerpc/kvm/book3s_64_vio.c
> +++ b/arch/powerpc/kvm/book3s_64_vio.c
> @@ -14,6 +14,7 @@
>   *
>   * Copyright 2010 Paul Mackerras, IBM Corp. <paulus@au1.ibm.com>
>   * Copyright 2011 David Gibson, IBM Corporation <dwg@au1.ibm.com>
> + * Copyright 2016 Alexey Kardashevskiy, IBM Corporation <aik@au1.ibm.com>
>   */
> =20
>  #include <linux/types.h>
> @@ -37,8 +38,7 @@
>  #include <asm/kvm_host.h>
>  #include <asm/udbg.h>
>  #include <asm/iommu.h>
> -
> -#define TCES_PER_PAGE	(PAGE_SIZE / sizeof(u64))
> +#include <asm/tce.h>
> =20
>  static unsigned long kvmppc_stt_npages(unsigned long window_size)
>  {
> @@ -200,3 +200,109 @@ fail:
>  	}
>  	return ret;
>  }
> +
> +long kvmppc_h_put_tce(struct kvm_vcpu *vcpu,
> +		unsigned long liobn, unsigned long ioba,
> +		unsigned long tce)
> +{
> +	long ret;
> +	struct kvmppc_spapr_tce_table *stt;
> +
> +	stt =3D kvmppc_find_table(vcpu, liobn);
> +	if (!stt)
> +		return H_TOO_HARD;
> +
> +	ret =3D kvmppc_ioba_validate(stt, ioba, 1);
> +	if (ret !=3D H_SUCCESS)
> +		return ret;
> +
> +	ret =3D kvmppc_tce_validate(stt, tce);
> +	if (ret !=3D H_SUCCESS)
> +		return ret;
> +
> +	kvmppc_tce_put(stt, ioba >> IOMMU_PAGE_SHIFT_4K, tce);
> +
> +	return H_SUCCESS;
> +}
> +EXPORT_SYMBOL_GPL(kvmppc_h_put_tce);
> +
> +long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
> +		unsigned long liobn, unsigned long ioba,
> +		unsigned long tce_list, unsigned long npages)
> +{
> +	struct kvmppc_spapr_tce_table *stt;
> +	long i, ret =3D H_SUCCESS, idx;
> +	unsigned long entry, ua =3D 0;
> +	u64 __user *tces, tce;
> +
> +	stt =3D kvmppc_find_table(vcpu, liobn);
> +	if (!stt)
> +		return H_TOO_HARD;
> +
> +	entry =3D ioba >> IOMMU_PAGE_SHIFT_4K;
> +	/*
> +	 * SPAPR spec says that the maximum size of the list is 512 TCEs
> +	 * so the whole table fits in 4K page
> +	 */
> +	if (npages > 512)
> +		return H_PARAMETER;
> +
> +	if (tce_list & (SZ_4K - 1))
> +		return H_PARAMETER;
> +
> +	ret =3D kvmppc_ioba_validate(stt, ioba, npages);
> +	if (ret !=3D H_SUCCESS)
> +		return ret;
> +
> +	idx =3D srcu_read_lock(&vcpu->kvm->srcu);
> +	if (kvmppc_gpa_to_ua(vcpu->kvm, tce_list, &ua, NULL)) {
> +		ret =3D H_TOO_HARD;
> +		goto unlock_exit;
> +	}
> +	tces =3D (u64 __user *) ua;
> +
> +	for (i =3D 0; i < npages; ++i) {
> +		if (get_user(tce, tces + i)) {
> +			ret =3D H_PARAMETER;
> +			goto unlock_exit;
> +		}
> +		tce =3D be64_to_cpu(tce);
> +
> +		ret =3D kvmppc_tce_validate(stt, tce);
> +		if (ret !=3D H_SUCCESS)
> +			goto unlock_exit;
> +
> +		kvmppc_tce_put(stt, entry + i, tce);
> +	}
> +
> +unlock_exit:
> +	srcu_read_unlock(&vcpu->kvm->srcu, idx);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(kvmppc_h_put_tce_indirect);
> +
> +long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
> +		unsigned long liobn, unsigned long ioba,
> +		unsigned long tce_value, unsigned long npages)
> +{
> +	struct kvmppc_spapr_tce_table *stt;
> +	long i, ret;
> +
> +	stt =3D kvmppc_find_table(vcpu, liobn);
> +	if (!stt)
> +		return H_TOO_HARD;
> +
> +	ret =3D kvmppc_ioba_validate(stt, ioba, npages);
> +	if (ret !=3D H_SUCCESS)
> +		return ret;
> +
> +	if (tce_value & (TCE_PCI_WRITE | TCE_PCI_READ))
> +		return H_PARAMETER;

Do we really need to allow no-permission but non-zero TCEs?

> +
> +	for (i =3D 0; i < npages; ++i, ioba +=3D IOMMU_PAGE_SIZE_4K)
> +		kvmppc_tce_put(stt, ioba >> IOMMU_PAGE_SHIFT_4K, tce_value);
> +
> +	return H_SUCCESS;
> +}
> +EXPORT_SYMBOL_GPL(kvmppc_h_stuff_tce);
> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3=
s_64_vio_hv.c
> index 8cd3a95..58c63ed 100644
> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
> @@ -14,6 +14,7 @@
>   *
>   * Copyright 2010 Paul Mackerras, IBM Corp. <paulus@au1.ibm.com>
>   * Copyright 2011 David Gibson, IBM Corporation <dwg@au1.ibm.com>
> + * Copyright 2016 Alexey Kardashevskiy, IBM Corporation <aik@au1.ibm.com>
>   */
> =20
>  #include <linux/types.h>
> @@ -30,6 +31,7 @@
>  #include <asm/kvm_ppc.h>
>  #include <asm/kvm_book3s.h>
>  #include <asm/mmu-hash64.h>
> +#include <asm/mmu_context.h>
>  #include <asm/hvcall.h>
>  #include <asm/synch.h>
>  #include <asm/ppc-opcode.h>
> @@ -37,6 +39,7 @@
>  #include <asm/udbg.h>
>  #include <asm/iommu.h>
>  #include <asm/tce.h>
> +#include <asm/iommu.h>
> =20
>  #define TCES_PER_PAGE	(PAGE_SIZE / sizeof(u64))
> =20
> @@ -46,7 +49,7 @@
>   * WARNING: This will be called in real or virtual mode on HV KVM and vi=
rtual
>   *          mode on PR KVM
>   */
> -static struct kvmppc_spapr_tce_table *kvmppc_find_table(struct kvm_vcpu =
*vcpu,
> +struct kvmppc_spapr_tce_table *kvmppc_find_table(struct kvm_vcpu *vcpu,
>  		unsigned long liobn)
>  {
>  	struct kvm *kvm =3D vcpu->kvm;
> @@ -58,6 +61,7 @@ static struct kvmppc_spapr_tce_table *kvmppc_find_table=
(struct kvm_vcpu *vcpu,
> =20
>  	return NULL;
>  }
> +EXPORT_SYMBOL_GPL(kvmppc_find_table);
> =20
>  /*
>   * Validates IO address.
> @@ -150,11 +154,31 @@ void kvmppc_tce_put(struct kvmppc_spapr_tce_table *=
stt,
>  }
>  EXPORT_SYMBOL_GPL(kvmppc_tce_put);
> =20
> -/* WARNING: This will be called in real-mode on HV KVM and virtual
> - *          mode on PR KVM
> - */
> -long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
> -		      unsigned long ioba, unsigned long tce)
> +long kvmppc_gpa_to_ua(struct kvm *kvm, unsigned long gpa,
> +		unsigned long *ua, unsigned long **prmap)
> +{
> +	unsigned long gfn =3D gpa >> PAGE_SHIFT;
> +	struct kvm_memory_slot *memslot;
> +
> +	memslot =3D search_memslots(kvm_memslots(kvm), gfn);
> +	if (!memslot)
> +		return -EINVAL;
> +
> +	*ua =3D __gfn_to_hva_memslot(memslot, gfn) |
> +		(gpa & ~(PAGE_MASK | TCE_PCI_READ | TCE_PCI_WRITE));
> +
> +#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE

It's a bit odd to see a test for HV_POSSIBLE in a file named
book3s_64_vio_hv.c


> +	if (prmap)
> +		*prmap =3D &memslot->arch.rmap[gfn - memslot->base_gfn];
> +#endif
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(kvmppc_gpa_to_ua);
> +
> +#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> +long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
> +		unsigned long ioba, unsigned long tce)
>  {
>  	struct kvmppc_spapr_tce_table *stt =3D kvmppc_find_table(vcpu, liobn);
>  	long ret;
> @@ -177,7 +201,112 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsign=
ed long liobn,
> =20
>  	return H_SUCCESS;
>  }
> -EXPORT_SYMBOL_GPL(kvmppc_h_put_tce);
> +
> +static long kvmppc_rm_ua_to_hpa(struct kvm_vcpu *vcpu,
> +		unsigned long ua, unsigned long *phpa)

ua should be a something __user * rather than an unsigned long.  And
come to that hpa should be a something * rather than an unsigned long.

> +{
> +	pte_t *ptep, pte;
> +	unsigned shift =3D 0;
> +
> +	ptep =3D __find_linux_pte_or_hugepte(vcpu->arch.pgdir, ua, NULL, &shift=
);
> +	if (!ptep || !pte_present(*ptep))
> +		return -ENXIO;
> +	pte =3D *ptep;
> +
> +	if (!shift)
> +		shift =3D PAGE_SHIFT;
> +
> +	/* Avoid handling anything potentially complicated in realmode */
> +	if (shift > PAGE_SHIFT)
> +		return -EAGAIN;
> +
> +	if (!pte_young(pte))
> +		return -EAGAIN;
> +
> +	*phpa =3D (pte_pfn(pte) << PAGE_SHIFT) | (ua & ((1ULL << shift) - 1)) |
> +			(ua & ~PAGE_MASK);
> +
> +	return 0;
> +}
> +
> +long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
> +		unsigned long liobn, unsigned long ioba,
> +		unsigned long tce_list,	unsigned long npages)
> +{
> +	struct kvmppc_spapr_tce_table *stt;
> +	long i, ret =3D H_SUCCESS;
> +	unsigned long tces, entry, ua =3D 0;
> +	unsigned long *rmap =3D NULL;
> +
> +	stt =3D kvmppc_find_table(vcpu, liobn);
> +	if (!stt)
> +		return H_TOO_HARD;
> +
> +	entry =3D ioba >> IOMMU_PAGE_SHIFT_4K;
> +	/*
> +	 * The spec says that the maximum size of the list is 512 TCEs
> +	 * so the whole table addressed resides in 4K page
> +	 */
> +	if (npages > 512)
> +		return H_PARAMETER;
> +
> +	if (tce_list & (SZ_4K - 1))
> +		return H_PARAMETER;
> +
> +	ret =3D kvmppc_ioba_validate(stt, ioba, npages);
> +	if (ret !=3D H_SUCCESS)
> +		return ret;
> +
> +	if (kvmppc_gpa_to_ua(vcpu->kvm, tce_list, &ua, &rmap))
> +		return H_TOO_HARD;
> +
> +	rmap =3D (void *) vmalloc_to_phys(rmap);
> +
> +	lock_rmap(rmap);
> +	if (kvmppc_rm_ua_to_hpa(vcpu, ua, &tces)) {
> +		ret =3D H_TOO_HARD;
> +		goto unlock_exit;
> +	}
> +
> +	for (i =3D 0; i < npages; ++i) {
> +		unsigned long tce =3D be64_to_cpu(((u64 *)tces)[i]);
> +
> +		ret =3D kvmppc_tce_validate(stt, tce);
> +		if (ret !=3D H_SUCCESS)
> +			goto unlock_exit;
> +
> +		kvmppc_tce_put(stt, entry + i, tce);
> +	}
> +
> +unlock_exit:
> +	unlock_rmap(rmap);
> +
> +	return ret;
> +}
> +
> +long kvmppc_rm_h_stuff_tce(struct kvm_vcpu *vcpu,
> +		unsigned long liobn, unsigned long ioba,
> +		unsigned long tce_value, unsigned long npages)

Unlike put_indirect, this code appears to be identical to the non
realmode code - can you combine them?

> +{
> +	struct kvmppc_spapr_tce_table *stt;
> +	long i, ret;
> +
> +	stt =3D kvmppc_find_table(vcpu, liobn);
> +	if (!stt)
> +		return H_TOO_HARD;
> +
> +	ret =3D kvmppc_ioba_validate(stt, ioba, npages);
> +	if (ret !=3D H_SUCCESS)
> +		return ret;
> +
> +	if (tce_value & (TCE_PCI_WRITE | TCE_PCI_READ))
> +		return H_PARAMETER;
> +
> +	for (i =3D 0; i < npages; ++i, ioba +=3D IOMMU_PAGE_SIZE_4K)
> +		kvmppc_tce_put(stt, ioba >> IOMMU_PAGE_SHIFT_4K, tce_value);
> +
> +	return H_SUCCESS;
> +}
> =20
>  long kvmppc_h_get_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
>  		unsigned long ioba)
> @@ -204,3 +333,5 @@ long kvmppc_h_get_tce(struct kvm_vcpu *vcpu, unsigned=
 long liobn,
>  	return H_SUCCESS;
>  }
>  EXPORT_SYMBOL_GPL(kvmppc_h_get_tce);
> +
> +#endif /* KVM_BOOK3S_HV_POSSIBLE */
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index cff207b..df3fbae 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -768,7 +768,31 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
>  		if (kvmppc_xics_enabled(vcpu)) {
>  			ret =3D kvmppc_xics_hcall(vcpu, req);
>  			break;
> -		} /* fallthrough */
> +		}
> +		return RESUME_HOST;
> +	case H_PUT_TCE:
> +		ret =3D kvmppc_h_put_tce(vcpu, kvmppc_get_gpr(vcpu, 4),
> +						kvmppc_get_gpr(vcpu, 5),
> +						kvmppc_get_gpr(vcpu, 6));
> +		if (ret =3D=3D H_TOO_HARD)
> +			return RESUME_HOST;
> +		break;
> +	case H_PUT_TCE_INDIRECT:
> +		ret =3D kvmppc_h_put_tce_indirect(vcpu, kvmppc_get_gpr(vcpu, 4),
> +						kvmppc_get_gpr(vcpu, 5),
> +						kvmppc_get_gpr(vcpu, 6),
> +						kvmppc_get_gpr(vcpu, 7));
> +		if (ret =3D=3D H_TOO_HARD)
> +			return RESUME_HOST;
> +		break;
> +	case H_STUFF_TCE:
> +		ret =3D kvmppc_h_stuff_tce(vcpu, kvmppc_get_gpr(vcpu, 4),
> +						kvmppc_get_gpr(vcpu, 5),
> +						kvmppc_get_gpr(vcpu, 6),
> +						kvmppc_get_gpr(vcpu, 7));
> +		if (ret =3D=3D H_TOO_HARD)
> +			return RESUME_HOST;
> +		break;
>  	default:
>  		return RESUME_HOST;
>  	}
> diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/b=
ook3s_hv_rmhandlers.S
> index 3c6badc..3bf6e72 100644
> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> @@ -1928,7 +1928,7 @@ hcall_real_table:
>  	.long	DOTSYM(kvmppc_h_clear_ref) - hcall_real_table
>  	.long	DOTSYM(kvmppc_h_protect) - hcall_real_table
>  	.long	DOTSYM(kvmppc_h_get_tce) - hcall_real_table
> -	.long	DOTSYM(kvmppc_h_put_tce) - hcall_real_table
> +	.long	DOTSYM(kvmppc_rm_h_put_tce) - hcall_real_table
>  	.long	0		/* 0x24 - H_SET_SPRG0 */
>  	.long	DOTSYM(kvmppc_h_set_dabr) - hcall_real_table
>  	.long	0		/* 0x2c */
> @@ -2006,8 +2006,8 @@ hcall_real_table:
>  	.long	0		/* 0x12c */
>  	.long	0		/* 0x130 */
>  	.long	DOTSYM(kvmppc_h_set_xdabr) - hcall_real_table
> -	.long	0		/* 0x138 */
> -	.long	0		/* 0x13c */
> +	.long	DOTSYM(kvmppc_rm_h_stuff_tce) - hcall_real_table
> +	.long	DOTSYM(kvmppc_rm_h_put_tce_indirect) - hcall_real_table
>  	.long	0		/* 0x140 */
>  	.long	0		/* 0x144 */
>  	.long	0		/* 0x148 */
> diff --git a/arch/powerpc/kvm/book3s_pr_papr.c b/arch/powerpc/kvm/book3s_=
pr_papr.c
> index f2c75a1..02176fd 100644
> --- a/arch/powerpc/kvm/book3s_pr_papr.c
> +++ b/arch/powerpc/kvm/book3s_pr_papr.c
> @@ -280,6 +280,37 @@ static int kvmppc_h_pr_logical_ci_store(struct kvm_v=
cpu *vcpu)
>  	return EMULATE_DONE;
>  }
> =20
> +static int kvmppc_h_pr_put_tce_indirect(struct kvm_vcpu *vcpu)
> +{
> +	unsigned long liobn =3D kvmppc_get_gpr(vcpu, 4);
> +	unsigned long ioba =3D kvmppc_get_gpr(vcpu, 5);
> +	unsigned long tce =3D kvmppc_get_gpr(vcpu, 6);
> +	unsigned long npages =3D kvmppc_get_gpr(vcpu, 7);
> +	long rc;
> +
> +	rc =3D kvmppc_h_put_tce_indirect(vcpu, liobn, ioba,
> +			tce, npages);
> +	if (rc =3D=3D H_TOO_HARD)
> +		return EMULATE_FAIL;
> +	kvmppc_set_gpr(vcpu, 3, rc);
> +	return EMULATE_DONE;
> +}
> +
> +static int kvmppc_h_pr_stuff_tce(struct kvm_vcpu *vcpu)
> +{
> +	unsigned long liobn =3D kvmppc_get_gpr(vcpu, 4);
> +	unsigned long ioba =3D kvmppc_get_gpr(vcpu, 5);
> +	unsigned long tce_value =3D kvmppc_get_gpr(vcpu, 6);
> +	unsigned long npages =3D kvmppc_get_gpr(vcpu, 7);
> +	long rc;
> +
> +	rc =3D kvmppc_h_stuff_tce(vcpu, liobn, ioba, tce_value, npages);
> +	if (rc =3D=3D H_TOO_HARD)
> +		return EMULATE_FAIL;
> +	kvmppc_set_gpr(vcpu, 3, rc);
> +	return EMULATE_DONE;
> +}
> +
>  static int kvmppc_h_pr_xics_hcall(struct kvm_vcpu *vcpu, u32 cmd)
>  {
>  	long rc =3D kvmppc_xics_hcall(vcpu, cmd);
> @@ -306,6 +337,10 @@ int kvmppc_h_pr(struct kvm_vcpu *vcpu, unsigned long=
 cmd)
>  		return kvmppc_h_pr_bulk_remove(vcpu);
>  	case H_PUT_TCE:
>  		return kvmppc_h_pr_put_tce(vcpu);
> +	case H_PUT_TCE_INDIRECT:
> +		return kvmppc_h_pr_put_tce_indirect(vcpu);
> +	case H_STUFF_TCE:
> +		return kvmppc_h_pr_stuff_tce(vcpu);
>  	case H_CEDE:
>  		kvmppc_set_msr_fast(vcpu, kvmppc_get_msr(vcpu) | MSR_EE);
>  		kvm_vcpu_block(vcpu);
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 6fd2405..164735c 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -569,6 +569,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, lon=
g ext)
>  	case KVM_CAP_PPC_GET_SMMU_INFO:
>  		r =3D 1;
>  		break;
> +	case KVM_CAP_SPAPR_MULTITCE:
> +		r =3D 1;
> +		break;

Hmm, usual practice has been not to enable new KVM hcalls, unless
userspace (qemu) explicitly enables them with ENABLE_HCALL.  I don't
see an obvious way this extension could break, but it's probably
safest to continue that pattern.

>  #endif
>  	default:
>  		r =3D 0;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--KJKxYQkVikLexIKR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWpW/RAAoJEGw4ysog2bOSIlUQAMUOiWMg/NcGmtFMFeaSwWfE
Yhp/MVp49Z2QtwHrg3P16uZeAkqrx34B24COD6I8XBqhEY7ENkFUZZxeIt48C1qx
7urqb86jqdwHg/envcscfs+hgy5AW86LXCrIYZn+bpmhZoxWC9pQVcVPHuw3BSui
ZCvT24JnN8IOPwPUgN940vh0jsWun4CwX2EjsKrwccrKcVU7NMxzNUcPWDp/uphL
G00bbHdyxd3Syguv+Z7dydobS7Ul4AhpZX48R4pkaPmjDRYb0YRUOq/XYxqMdBaE
TCtayzvJLM9nsRRLz38JGfmyADEaN+fDWVaOoR/gR/eh6ajpvfLb0pD40TociEP+
K3+Ayo8J67X2aitvE074CLbZ0wdeGuUwnWQr+nssBtx0Wip6u6utzUvrqi7CiidH
GaTg7DzjrYR7nYBZfEQL1Ai3Nxt9CuHnyeGYCHGEGeLM0YWYEfRFRMdMp8BuVfAx
nRmRGh2Q2gkjly/j12iq7Ce3aA4FOON4N5yn1n2laO3ysAWCTqBa3+7I+Y7aZrqD
qt3WFLXsul+JH2QXeqjA8QPPt3/UJb/wukI2bP0ecaqr/Dxv1G9kOYRNg8NDYQxj
qBO4o+1nr59bX1ChrWrk0WzuZXv4iNpdhBc/Co/r26RSnOcP/hQJR6FY8swk2DgY
mFfWYmxXHaTNpJKRbm0W
=Pg07
-----END PGP SIGNATURE-----

--KJKxYQkVikLexIKR--
