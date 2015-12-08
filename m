Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0F3601A0F00
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Dec 2015 20:05:56 +1100 (AEDT)
Date: Tue, 8 Dec 2015 16:48:05 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Alexander Graf <agraf@suse.com>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH kernel 9/9] KVM: PPC: Add support for multiple-TCE hcalls
Message-ID: <20151208054805.GU20139@voom.fritz.box>
References: <1442314179-9706-1-git-send-email-aik@ozlabs.ru>
 <1442314179-9706-10-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Y2illNFYgwJwqOHD"
In-Reply-To: <1442314179-9706-10-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Y2illNFYgwJwqOHD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2015 at 08:49:39PM +1000, Alexey Kardashevskiy wrote:
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
>  Documentation/virtual/kvm/api.txt       |  25 ++++++
>  arch/powerpc/include/asm/kvm_ppc.h      |  12 +++
>  arch/powerpc/kvm/book3s_64_vio.c        | 111 +++++++++++++++++++++++-
>  arch/powerpc/kvm/book3s_64_vio_hv.c     | 145 ++++++++++++++++++++++++++=
++++--
>  arch/powerpc/kvm/book3s_hv.c            |  26 +++++-
>  arch/powerpc/kvm/book3s_hv_rmhandlers.S |   6 +-
>  arch/powerpc/kvm/book3s_pr_papr.c       |  35 ++++++++
>  arch/powerpc/kvm/powerpc.c              |   3 +
>  8 files changed, 350 insertions(+), 13 deletions(-)
>=20
> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kv=
m/api.txt
> index d86d831..593c62a 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -3019,6 +3019,31 @@ Returns: 0 on success, -1 on error
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
> index fcde896..e5b968e 100644
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
> index e347856..d3fc732 100644
> --- a/arch/powerpc/kvm/book3s_64_vio.c
> +++ b/arch/powerpc/kvm/book3s_64_vio.c
> @@ -14,6 +14,7 @@
>   *
>   * Copyright 2010 Paul Mackerras, IBM Corp. <paulus@au1.ibm.com>
>   * Copyright 2011 David Gibson, IBM Corporation <dwg@au1.ibm.com>
> + * Copyright 2013 Alexey Kardashevskiy, IBM Corporation <aik@au1.ibm.com>
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
>  static long kvmppc_stt_npages(unsigned long window_size)
>  {
> @@ -200,3 +200,110 @@ fail:
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
> +	if (ret)
> +		return ret;
> +
> +	ret =3D kvmppc_tce_validate(stt, tce);
> +	if (ret)
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
> +	if (tce_list & ~IOMMU_PAGE_MASK_4K)

IOMMU_PAGE_MASK_4K doesn't seem like the right thing here.  It is 4k,
but that restriction is derived from the smallest possible main memory
page size, rather than from anything to do with the IOMMU page size.

> +		return H_PARAMETER;
> +
> +	ret =3D kvmppc_ioba_validate(stt, ioba, npages);
> +	if (ret)
> +		return ret;
> +
> +	idx =3D srcu_read_lock(&vcpu->kvm->srcu);
> +	if (kvmppc_gpa_to_ua(vcpu->kvm, tce_list, &ua, NULL)) {
> +		ret =3D H_TOO_HARD;
> +		goto unlock_exit;
> +	}
> +	tces =3D (u64 *) ua;

The u64 * should have a usermem sparse annotation, no?

> +	for (i =3D 0; i < npages; ++i) {
> +		if (get_user(tce, tces + i)) {
> +			ret =3D H_PARAMETER;
> +			goto unlock_exit;
> +		}
> +		tce =3D be64_to_cpu(tce);
> +		ret =3D kvmppc_tce_validate(stt, tce);
> +		if (ret)
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
> +	if (ret)
> +		return ret;
> +
> +	ret =3D kvmppc_tce_validate(stt, tce_value);
> +	if (ret || (tce_value & (TCE_PCI_WRITE | TCE_PCI_READ)))
> +		return H_PARAMETER;
> +
> +	for (i =3D 0; i < npages; ++i, ioba +=3D IOMMU_PAGE_SIZE_4K)
> +		kvmppc_tce_put(stt, ioba >> IOMMU_PAGE_SHIFT_4K, tce_value);
> +
> +	return H_SUCCESS;
> +}
> +EXPORT_SYMBOL_GPL(kvmppc_h_stuff_tce);
> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3=
s_64_vio_hv.c
> index f0fd84c..bca7b12 100644
> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
> @@ -14,6 +14,7 @@
>   *
>   * Copyright 2010 Paul Mackerras, IBM Corp. <paulus@au1.ibm.com>
>   * Copyright 2011 David Gibson, IBM Corporation <dwg@au1.ibm.com>
> + * Copyright 2013 Alexey Kardashevskiy, IBM Corporation <aik@au1.ibm.com>
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
> @@ -151,11 +155,32 @@ void kvmppc_tce_put(struct kvmppc_spapr_tce_table *=
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

I'm kind of surprised there isn't already a function to do this somewhere.

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
> +	if (prmap)
> +		*prmap =3D real_vmalloc_addr(&memslot->arch.rmap[
> +				gfn - memslot->base_gfn]);
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
>  	long ret =3D H_TOO_HARD;
> @@ -178,7 +203,111 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsign=
ed long liobn,
> =20
>  	return ret;
>  }
> -EXPORT_SYMBOL_GPL(kvmppc_h_put_tce);
> +
> +static long kvmppc_rm_ua_to_hpa(struct kvm_vcpu *vcpu,
> +		unsigned long ua, unsigned long *phpa)
> +{
> +	pte_t *ptep, pte;
> +	unsigned shift =3D 0;
> +
> +	ptep =3D __find_linux_pte_or_hugepte(vcpu->arch.pgdir, ua, &shift);
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

Does it also need to be dirty, since you might be writing to this page?

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
> +	if (tce_list & ~IOMMU_PAGE_MASK_4K)
> +		return H_PARAMETER;
> +
> +	ret =3D kvmppc_ioba_validate(stt, ioba, npages);
> +	if (ret)
> +		return ret;
> +
> +	if (kvmppc_gpa_to_ua(vcpu->kvm, tce_list, &ua, &rmap))
> +		return H_TOO_HARD;
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
> +		if (ret)
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
> +{
> +	struct kvmppc_spapr_tce_table *stt;
> +	long i, ret;
> +
> +	stt =3D kvmppc_find_table(vcpu, liobn);
> +	if (!stt)
> +		return H_TOO_HARD;
> +
> +	ret =3D kvmppc_ioba_validate(stt, ioba, npages);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D kvmppc_tce_validate(stt, tce_value);
> +	if (ret || (tce_value & (TCE_PCI_WRITE | TCE_PCI_READ)))
> +		return H_PARAMETER;
> +
> +	for (i =3D 0; i < npages; ++i, ioba +=3D IOMMU_PAGE_SIZE_4K)
> +		kvmppc_tce_put(stt, ioba >> IOMMU_PAGE_SHIFT_4K, tce_value);
> +
> +	return H_SUCCESS;
> +}
> =20
>  long kvmppc_h_get_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
>  		      unsigned long ioba)
> @@ -202,3 +331,5 @@ long kvmppc_h_get_tce(struct kvm_vcpu *vcpu, unsigned=
 long liobn,
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(kvmppc_h_get_tce);
> +
> +#endif /* KVM_BOOK3S_HV_POSSIBLE */
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index c5edf17..408b1b1 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -775,7 +775,31 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
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
> index 2273dca..fd1997c 100644
> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> @@ -1917,7 +1917,7 @@ hcall_real_table:
>  	.long	DOTSYM(kvmppc_h_clear_ref) - hcall_real_table
>  	.long	DOTSYM(kvmppc_h_protect) - hcall_real_table
>  	.long	DOTSYM(kvmppc_h_get_tce) - hcall_real_table
> -	.long	DOTSYM(kvmppc_h_put_tce) - hcall_real_table
> +	.long	DOTSYM(kvmppc_rm_h_put_tce) - hcall_real_table
>  	.long	0		/* 0x24 - H_SET_SPRG0 */
>  	.long	DOTSYM(kvmppc_h_set_dabr) - hcall_real_table
>  	.long	0		/* 0x2c */
> @@ -1995,8 +1995,8 @@ hcall_real_table:
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
> index 2e51289..c7c2802 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -566,6 +566,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, lon=
g ext)
>  	case KVM_CAP_PPC_GET_SMMU_INFO:
>  		r =3D 1;
>  		break;
> +	case KVM_CAP_SPAPR_MULTITCE:
> +		r =3D 1;
> +		break;
>  #endif
>  	default:
>  		r =3D 0;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Y2illNFYgwJwqOHD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWZm8UAAoJEGw4ysog2bOS5zgP/2zoRkASE2oVtJ844zyomiF6
YPXCXxhny1gwQgYoCO2EgsxL6sXyIcd97w3+3rAOtc2sHfcWuo5iHdeB3qpMu9Le
rvfogf1nO4c/nhoP6TB3PLGspdQjeJ34d6wVAs+3U3PTRcbTpOc9TtCM6vzQavAo
dU1jYOIdYJhmuZaUUCycu1PmUYEg5M5BZmdY1dJru/j5LxHRNWaAsJE8Q1w5WPPL
E+D5+ogzqcqx7VX6xR0PSS4ESC/kd1I6VVkZKf2SiOCkq7K78b+4EPRQBsi1/oNe
UrBsJJeTJONverz5+egdxiBSKz1k2y/eKJoR4ERV28R2xpZwEs3TLEusgUB4CXPW
xuSIIqNYM6UO1A+2klxGMXF2HYutil+TJt/YcY3ZKe4jL8fysV5AWXS0cfT7GxCn
0ixqsx46zv4OanhF0lyRhTzGnikGb5S8nmaoJR1GGqEMFceb/4ms8Z/MgAR1wU1i
jDvJhQlLeRcRYDnMzCjuk3GPNa2RGxrSGbJl5z33/kA1BCZXofxNnRwv1eyWAp2y
OazsxaqnWTSOR56oLx+3Yy/WnLfjV0DSbBpMUDmKF5W2p1Xs//hIEebm6WAYmDKw
yVfRh6CTjKtWQkaMNgNk+OQyIofDAdoMNiuGZ82pFYlskA8m80nW49M4sBqRcdb5
8HYiM3FFBNs6gNaO9Htz
=2DMF
-----END PGP SIGNATURE-----

--Y2illNFYgwJwqOHD--
