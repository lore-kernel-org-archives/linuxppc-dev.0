Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 588781A010A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 22:08:17 +1100 (AEDT)
Date: Tue, 8 Mar 2016 22:08:12 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH kernel 8/9] KVM: PPC: Add in-kernel handling for VFIO
Message-ID: <20160308110812.GC22546@voom.fritz.box>
References: <1457322077-26640-1-git-send-email-aik@ozlabs.ru>
 <1457322077-26640-9-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Ro1PRY3Rtw8g7IwX"
In-Reply-To: <1457322077-26640-9-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Ro1PRY3Rtw8g7IwX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 07, 2016 at 02:41:16PM +1100, Alexey Kardashevskiy wrote:
> This allows the host kernel to handle H_PUT_TCE, H_PUT_TCE_INDIRECT
> and H_STUFF_TCE requests targeted an IOMMU TCE table used for VFIO
> without passing them to user space which saves time on switching
> to user space and back.
>=20
> Both real and virtual modes are supported. The kernel tries to
> handle a TCE request in the real mode, if fails it passes the request
> to the virtual mode to complete the operation. If it a virtual mode
> handler fails, the request is passed to user space; this is not expected
> to happen ever though.

Well... not expect to happen with a qemu which uses this.  Presumably
it will fall back to userspace routinely if you have an old qemu that
doesn't add the liobn mappings.

> The first user of this is VFIO on POWER. Trampolines to the VFIO external
> user API functions are required for this patch.

I'm not sure what you mean by "trampoline" here.

> This uses a VFIO KVM device to associate a logical bus number (LIOBN)
> with an VFIO IOMMU group fd and enable in-kernel handling of map/unmap
> requests.

Group fd?  Or container fd?  The group fd wouldn't make a lot of
sense.

> To make use of the feature, the user space has to create a guest view
> of the TCE table via KVM_CAP_SPAPR_TCE/KVM_CAP_SPAPR_TCE_64 and
> then associate a LIOBN with this table via VFIO KVM device,
> a KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE_LIOBN property (which is added in
> the next patch).
>=20
> Tests show that this patch increases transmission speed from 220MB/s
> to 750..1020MB/s on 10Gb network (Chelsea CXGB3 10Gb ethernet card).

Is that with or without DDW (i.e. with or without a 64-bit DMA window)?

> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  arch/powerpc/kvm/book3s_64_vio.c    | 184 ++++++++++++++++++++++++++++++=
+++++
>  arch/powerpc/kvm/book3s_64_vio_hv.c | 186 ++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 370 insertions(+)
>=20
> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_6=
4_vio.c
> index 7965fc7..9417d12 100644
> --- a/arch/powerpc/kvm/book3s_64_vio.c
> +++ b/arch/powerpc/kvm/book3s_64_vio.c
> @@ -33,6 +33,7 @@
>  #include <asm/kvm_ppc.h>
>  #include <asm/kvm_book3s.h>
>  #include <asm/mmu-hash64.h>
> +#include <asm/mmu_context.h>
>  #include <asm/hvcall.h>
>  #include <asm/synch.h>
>  #include <asm/ppc-opcode.h>
> @@ -317,11 +318,161 @@ fail:
>  	return ret;
>  }
> =20
> +static long kvmppc_tce_iommu_mapped_dec(struct iommu_table *tbl,
> +		unsigned long entry)
> +{
> +	struct mm_iommu_table_group_mem_t *mem =3D NULL;
> +	const unsigned long pgsize =3D 1ULL << tbl->it_page_shift;
> +	unsigned long *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
> +
> +	if (!pua)
> +		return H_HARDWARE;
> +
> +	mem =3D mm_iommu_lookup(*pua, pgsize);
> +	if (!mem)
> +		return H_HARDWARE;
> +
> +	mm_iommu_mapped_dec(mem);
> +
> +	*pua =3D 0;
> +
> +	return H_SUCCESS;
> +}
> +
> +static long kvmppc_tce_iommu_unmap(struct iommu_table *tbl,
> +		unsigned long entry)
> +{
> +	enum dma_data_direction dir =3D DMA_NONE;
> +	unsigned long hpa =3D 0;
> +
> +	if (iommu_tce_xchg(tbl, entry, &hpa, &dir))
> +		return H_HARDWARE;
> +
> +	if (dir =3D=3D DMA_NONE)
> +		return H_SUCCESS;
> +
> +	return kvmppc_tce_iommu_mapped_dec(tbl, entry);
> +}
> +
> +long kvmppc_tce_iommu_map(struct kvm *kvm, struct iommu_table *tbl,
> +		unsigned long entry, unsigned long gpa,
> +		enum dma_data_direction dir)
> +{
> +	long ret;
> +	unsigned long hpa, ua, *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
> +	struct mm_iommu_table_group_mem_t *mem;
> +
> +	if (!pua)
> +		return H_HARDWARE;

H_HARDWARE?  Or H_PARAMETER?  This essentially means the guest has
supplied a bad physical address, doesn't it?

> +	if (kvmppc_gpa_to_ua(kvm, gpa, &ua, NULL))
> +		return H_HARDWARE;
> +
> +	mem =3D mm_iommu_lookup(ua, 1ULL << tbl->it_page_shift);
> +	if (!mem)
> +		return H_HARDWARE;
> +
> +	if (mm_iommu_ua_to_hpa(mem, ua, &hpa))
> +		return H_HARDWARE;
> +
> +	if (mm_iommu_mapped_inc(mem))
> +		return H_HARDWARE;
> +
> +	ret =3D iommu_tce_xchg(tbl, entry, &hpa, &dir);
> +	if (ret) {
> +		mm_iommu_mapped_dec(mem);
> +		return H_TOO_HARD;
> +	}
> +
> +	if (dir !=3D DMA_NONE)
> +		kvmppc_tce_iommu_mapped_dec(tbl, entry);
> +
> +	*pua =3D ua;

IIUC this means you have a copy of the UA for every group attached to
the TCE table, but they'll all be the same.  Any way to avoid that
duplication?

> +	return 0;
> +}
> +
> +long kvmppc_h_put_tce_iommu(struct kvm_vcpu *vcpu,
> +		struct iommu_table *tbl,
> +		unsigned long liobn, unsigned long ioba,
> +		unsigned long tce)
> +{
> +	long idx, ret =3D H_HARDWARE;
> +	const unsigned long entry =3D ioba >> tbl->it_page_shift;
> +	const unsigned long gpa =3D tce & ~(TCE_PCI_READ | TCE_PCI_WRITE);
> +	const enum dma_data_direction dir =3D iommu_tce_direction(tce);
> +
> +	/* Clear TCE */
> +	if (dir =3D=3D DMA_NONE) {
> +		if (iommu_tce_clear_param_check(tbl, ioba, 0, 1))
> +			return H_PARAMETER;
> +
> +		return kvmppc_tce_iommu_unmap(tbl, entry);
> +	}
> +
> +	/* Put TCE */
> +	if (iommu_tce_put_param_check(tbl, ioba, tce))
> +		return H_PARAMETER;
> +
> +	idx =3D srcu_read_lock(&vcpu->kvm->srcu);
> +	ret =3D kvmppc_tce_iommu_map(vcpu->kvm, tbl, entry, gpa, dir);
> +	srcu_read_unlock(&vcpu->kvm->srcu, idx);
> +
> +	return ret;
> +}
> +
> +static long kvmppc_h_put_tce_indirect_iommu(struct kvm_vcpu *vcpu,
> +		struct iommu_table *tbl, unsigned long ioba,
> +		u64 __user *tces, unsigned long npages)
> +{
> +	unsigned long i, ret, tce, gpa;
> +	const unsigned long entry =3D ioba >> tbl->it_page_shift;
> +
> +	for (i =3D 0; i < npages; ++i) {
> +		gpa =3D be64_to_cpu(tces[i]) & ~(TCE_PCI_READ | TCE_PCI_WRITE);
> +
> +		if (iommu_tce_put_param_check(tbl, ioba +
> +				(i << tbl->it_page_shift), gpa))
> +			return H_PARAMETER;
> +	}
> +
> +	for (i =3D 0; i < npages; ++i) {
> +		tce =3D be64_to_cpu(tces[i]);

tces is a user address, which means it should only be dereferenced via
get_user() or copy_from_user() helpers.

> +		gpa =3D tce & ~(TCE_PCI_READ | TCE_PCI_WRITE);
> +
> +		ret =3D kvmppc_tce_iommu_map(vcpu->kvm, tbl, entry + i, gpa,
> +				iommu_tce_direction(tce));
> +		if (ret !=3D H_SUCCESS)
> +			return ret;
> +	}
> +
> +	return H_SUCCESS;
> +}
> +
> +long kvmppc_h_stuff_tce_iommu(struct kvm_vcpu *vcpu,
> +		struct iommu_table *tbl,
> +		unsigned long liobn, unsigned long ioba,
> +		unsigned long tce_value, unsigned long npages)
> +{
> +	unsigned long i;
> +	const unsigned long entry =3D ioba >> tbl->it_page_shift;
> +
> +	if (iommu_tce_clear_param_check(tbl, ioba, tce_value, npages))
> +		return H_PARAMETER;
> +
> +	for (i =3D 0; i < npages; ++i)
> +		kvmppc_tce_iommu_unmap(tbl, entry + i);
> +
> +	return H_SUCCESS;
> +}
> +
>  long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
>  		      unsigned long ioba, unsigned long tce)
>  {
>  	struct kvmppc_spapr_tce_table *stt =3D kvmppc_find_table(vcpu, liobn);
>  	long ret;
> +	struct kvmppc_spapr_tce_group *kg;
> +	struct iommu_table *tbltmp =3D NULL;
> =20
>  	/* udbg_printf("H_PUT_TCE(): liobn=3D0x%lx ioba=3D0x%lx, tce=3D0x%lx\n"=
, */
>  	/* 	    liobn, ioba, tce); */
> @@ -337,6 +488,15 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigne=
d long liobn,
>  	if (ret !=3D H_SUCCESS)
>  		return ret;
> =20
> +	list_for_each_entry_lockless(kg, &stt->groups, next) {
> +		if (kg->tbl =3D=3D tbltmp)
> +			continue;
> +		tbltmp =3D kg->tbl;
> +		ret =3D kvmppc_h_put_tce_iommu(vcpu, kg->tbl, liobn, ioba, tce);
> +		if (ret !=3D H_SUCCESS)
> +			return ret;
> +	}
> +
>  	kvmppc_tce_put(stt, ioba >> stt->page_shift, tce);
> =20
>  	return H_SUCCESS;
> @@ -351,6 +511,8 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
>  	long i, ret =3D H_SUCCESS, idx;
>  	unsigned long entry, ua =3D 0;
>  	u64 __user *tces, tce;
> +	struct kvmppc_spapr_tce_group *kg;
> +	struct iommu_table *tbltmp =3D NULL;
> =20
>  	stt =3D kvmppc_find_table(vcpu, liobn);
>  	if (!stt)
> @@ -378,6 +540,16 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
>  	}
>  	tces =3D (u64 __user *) ua;
> =20
> +	list_for_each_entry_lockless(kg, &stt->groups, next) {
> +		if (kg->tbl =3D=3D tbltmp)
> +			continue;
> +		tbltmp =3D kg->tbl;
> +		ret =3D kvmppc_h_put_tce_indirect_iommu(vcpu,
> +				kg->tbl, ioba, tces, npages);
> +		if (ret !=3D H_SUCCESS)
> +			goto unlock_exit;
> +	}
> +
>  	for (i =3D 0; i < npages; ++i) {
>  		if (get_user(tce, tces + i)) {
>  			ret =3D H_TOO_HARD;
> @@ -405,6 +577,8 @@ long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
>  {
>  	struct kvmppc_spapr_tce_table *stt;
>  	long i, ret;
> +	struct kvmppc_spapr_tce_group *kg;
> +	struct iommu_table *tbltmp =3D NULL;
> =20
>  	stt =3D kvmppc_find_table(vcpu, liobn);
>  	if (!stt)
> @@ -418,6 +592,16 @@ long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
>  	if (tce_value & (TCE_PCI_WRITE | TCE_PCI_READ))
>  		return H_PARAMETER;
> =20
> +	list_for_each_entry_lockless(kg, &stt->groups, next) {
> +		if (kg->tbl =3D=3D tbltmp)
> +			continue;
> +		tbltmp =3D kg->tbl;
> +		ret =3D kvmppc_h_stuff_tce_iommu(vcpu, kg->tbl, liobn, ioba,
> +				tce_value, npages);
> +		if (ret !=3D H_SUCCESS)
> +			return ret;
> +	}
> +
>  	for (i =3D 0; i < npages; ++i, ioba +=3D (1ULL << stt->page_shift))
>  		kvmppc_tce_put(stt, ioba >> stt->page_shift, tce_value);
> =20
> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3=
s_64_vio_hv.c
> index 11163ae..6567d6c 100644
> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
> @@ -26,6 +26,7 @@
>  #include <linux/slab.h>
>  #include <linux/hugetlb.h>
>  #include <linux/list.h>
> +#include <linux/iommu.h>
> =20
>  #include <asm/tlbflush.h>
>  #include <asm/kvm_ppc.h>
> @@ -212,11 +213,162 @@ static struct mm_iommu_table_group_mem_t *kvmppc_r=
m_iommu_lookup(
>  	return mm_iommu_lookup_rm(mm, ua, size);
>  }
> =20
> +static long kvmppc_rm_tce_iommu_mapped_dec(struct kvm_vcpu *vcpu,
> +		struct iommu_table *tbl, unsigned long entry)
> +{
> +	struct mm_iommu_table_group_mem_t *mem =3D NULL;
> +	const unsigned long pgsize =3D 1ULL << tbl->it_page_shift;
> +	unsigned long *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
> +
> +	if (!pua)
> +		return H_SUCCESS;
> +
> +	pua =3D (void *) vmalloc_to_phys(pua);
> +	if (!pua)
> +		return H_SUCCESS;
> +
> +	mem =3D kvmppc_rm_iommu_lookup(vcpu, *pua, pgsize);
> +	if (!mem)
> +		return H_HARDWARE;
> +
> +	mm_iommu_mapped_dec(mem);
> +
> +	*pua =3D 0;
> +
> +	return H_SUCCESS;
> +}
> +
> +static long kvmppc_rm_tce_iommu_unmap(struct kvm_vcpu *vcpu,
> +		struct iommu_table *tbl, unsigned long entry)
> +{
> +	enum dma_data_direction dir =3D DMA_NONE;
> +	unsigned long hpa =3D 0;
> +
> +	if (iommu_tce_xchg_rm(tbl, entry, &hpa, &dir))
> +		return H_HARDWARE;
> +
> +	if (dir =3D=3D DMA_NONE)
> +		return H_SUCCESS;
> +
> +	return kvmppc_rm_tce_iommu_mapped_dec(vcpu, tbl, entry);
> +}
> +
> +long kvmppc_rm_tce_iommu_map(struct kvm_vcpu *vcpu, struct iommu_table *=
tbl,
> +		unsigned long entry, unsigned long gpa,
> +		enum dma_data_direction dir)
> +{
> +	long ret;
> +	unsigned long hpa =3D 0, ua;
> +	unsigned long *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
> +	struct mm_iommu_table_group_mem_t *mem;
> +
> +	if (kvmppc_gpa_to_ua(vcpu->kvm, gpa, &ua, NULL))
> +		return H_HARDWARE;
> +	mem =3D kvmppc_rm_iommu_lookup(vcpu, ua, 1ULL << tbl->it_page_shift);
> +	if (!mem)
> +		return H_HARDWARE;
> +
> +	if (mm_iommu_rm_ua_to_hpa(mem, ua, &hpa))
> +		return H_HARDWARE;
> +
> +	pua =3D (void *) vmalloc_to_phys(pua);
> +	if (!pua)
> +		return H_HARDWARE;
> +
> +	if (mm_iommu_mapped_inc(mem))
> +		return H_HARDWARE;
> +
> +	ret =3D iommu_tce_xchg_rm(tbl, entry, &hpa, &dir);
> +	if (ret) {
> +		mm_iommu_mapped_dec(mem);
> +		return H_TOO_HARD;
> +	}
> +
> +	if (dir !=3D DMA_NONE)
> +		kvmppc_rm_tce_iommu_mapped_dec(vcpu, tbl, entry);
> +
> +	*pua =3D ua;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(kvmppc_rm_tce_iommu_map);
> +
> +static long kvmppc_rm_h_put_tce_iommu(struct kvm_vcpu *vcpu,
> +		struct iommu_table *tbl, unsigned long liobn,
> +		unsigned long ioba, unsigned long tce)
> +{
> +	const unsigned long entry =3D ioba >> tbl->it_page_shift;
> +	const unsigned long gpa =3D tce & ~(TCE_PCI_READ | TCE_PCI_WRITE);
> +	const enum dma_data_direction dir =3D iommu_tce_direction(tce);
> +
> +	/* Clear TCE */
> +	if (dir =3D=3D DMA_NONE) {
> +		if (iommu_tce_clear_param_check(tbl, ioba, 0, 1))
> +			return H_PARAMETER;
> +
> +		return kvmppc_rm_tce_iommu_unmap(vcpu, tbl, entry);
> +	}
> +
> +	/* Put TCE */
> +	if (iommu_tce_put_param_check(tbl, ioba, gpa))
> +		return H_PARAMETER;
> +
> +	return kvmppc_rm_tce_iommu_map(vcpu, tbl, entry, gpa, dir);
> +}
> +
> +static long kvmppc_rm_h_put_tce_indirect_iommu(struct kvm_vcpu *vcpu,
> +		struct iommu_table *tbl, unsigned long ioba,
> +		u64 *tces, unsigned long npages)
> +{
> +	unsigned long i, ret, tce, gpa;
> +	const unsigned long entry =3D ioba >> tbl->it_page_shift;
> +
> +	for (i =3D 0; i < npages; ++i) {
> +		gpa =3D be64_to_cpu(tces[i]) & ~(TCE_PCI_READ | TCE_PCI_WRITE);
> +
> +		if (iommu_tce_put_param_check(tbl, ioba +
> +				(i << tbl->it_page_shift), gpa))
> +			return H_PARAMETER;
> +	}
> +
> +	for (i =3D 0; i < npages; ++i) {
> +		tce =3D be64_to_cpu(tces[i]);
> +		gpa =3D tce & ~(TCE_PCI_READ | TCE_PCI_WRITE);
> +
> +		ret =3D kvmppc_rm_tce_iommu_map(vcpu, tbl, entry + i, gpa,
> +				iommu_tce_direction(tce));
> +		if (ret !=3D H_SUCCESS)
> +			return ret;
> +	}
> +
> +	return H_SUCCESS;
> +}
> +
> +static long kvmppc_rm_h_stuff_tce_iommu(struct kvm_vcpu *vcpu,
> +		struct iommu_table *tbl,
> +		unsigned long liobn, unsigned long ioba,
> +		unsigned long tce_value, unsigned long npages)
> +{
> +	unsigned long i;
> +	const unsigned long entry =3D ioba >> tbl->it_page_shift;
> +
> +	if (iommu_tce_clear_param_check(tbl, ioba, tce_value, npages))
> +		return H_PARAMETER;
> +
> +	for (i =3D 0; i < npages; ++i)
> +		kvmppc_rm_tce_iommu_unmap(vcpu, tbl, entry + i);
> +
> +	return H_SUCCESS;
> +}
> +
>  long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
>  		unsigned long ioba, unsigned long tce)
>  {
>  	struct kvmppc_spapr_tce_table *stt =3D kvmppc_find_table(vcpu, liobn);
>  	long ret;
> +	struct kvmppc_spapr_tce_group *kg;
> +	struct iommu_table *tbltmp =3D NULL;
> =20
>  	/* udbg_printf("H_PUT_TCE(): liobn=3D0x%lx ioba=3D0x%lx, tce=3D0x%lx\n"=
, */
>  	/* 	    liobn, ioba, tce); */
> @@ -232,6 +384,16 @@ long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, unsi=
gned long liobn,
>  	if (ret !=3D H_SUCCESS)
>  		return ret;
> =20
> +	list_for_each_entry_lockless(kg, &stt->groups, next) {
> +		if (kg->tbl =3D=3D tbltmp)
> +			continue;
> +		tbltmp =3D kg->tbl;
> +		ret =3D kvmppc_rm_h_put_tce_iommu(vcpu, kg->tbl,
> +				liobn, ioba, tce);
> +		if (ret !=3D H_SUCCESS)
> +			return ret;
> +	}
> +
>  	kvmppc_tce_put(stt, ioba >> stt->page_shift, tce);
> =20
>  	return H_SUCCESS;
> @@ -272,6 +434,7 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vc=
pu,
>  	long i, ret =3D H_SUCCESS;
>  	unsigned long tces, entry, ua =3D 0;
>  	unsigned long *rmap =3D NULL;
> +	struct iommu_table *tbltmp =3D NULL;
> =20
>  	stt =3D kvmppc_find_table(vcpu, liobn);
>  	if (!stt)
> @@ -299,6 +462,7 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vc=
pu,
>  		 * depend on hpt.
>  		 */
>  		struct mm_iommu_table_group_mem_t *mem;
> +		struct kvmppc_spapr_tce_group *kg;
> =20
>  		if (kvmppc_gpa_to_ua(vcpu->kvm, tce_list, &ua, NULL))
>  			return H_TOO_HARD;
> @@ -306,6 +470,16 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *v=
cpu,
>  		mem =3D kvmppc_rm_iommu_lookup(vcpu, ua, IOMMU_PAGE_SIZE_4K);
>  		if (!mem || mm_iommu_rm_ua_to_hpa(mem, ua, &tces))
>  			return H_TOO_HARD;
> +
> +		list_for_each_entry_lockless(kg, &stt->groups, next) {
> +			if (kg->tbl =3D=3D tbltmp)
> +				continue;
> +			tbltmp =3D kg->tbl;
> +			ret =3D kvmppc_rm_h_put_tce_indirect_iommu(vcpu,
> +					kg->tbl, ioba, (u64 *)tces, npages);
> +			if (ret !=3D H_SUCCESS)
> +				return ret;
> +		}
>  	} else {
>  		/*
>  		 * This is emulated devices case.
> @@ -355,6 +529,8 @@ long kvmppc_rm_h_stuff_tce(struct kvm_vcpu *vcpu,
>  {
>  	struct kvmppc_spapr_tce_table *stt;
>  	long i, ret;
> +	struct kvmppc_spapr_tce_group *kg;
> +	struct iommu_table *tbltmp =3D NULL;
> =20
>  	stt =3D kvmppc_find_table(vcpu, liobn);
>  	if (!stt)
> @@ -368,6 +544,16 @@ long kvmppc_rm_h_stuff_tce(struct kvm_vcpu *vcpu,
>  	if (tce_value & (TCE_PCI_WRITE | TCE_PCI_READ))
>  		return H_PARAMETER;
> =20
> +	list_for_each_entry_lockless(kg, &stt->groups, next) {
> +		if (kg->tbl =3D=3D tbltmp)
> +			continue;
> +		tbltmp =3D kg->tbl;
> +		ret =3D kvmppc_rm_h_stuff_tce_iommu(vcpu, kg->tbl,
> +				liobn, ioba, tce_value, npages);
> +		if (ret !=3D H_SUCCESS)
> +			return ret;
> +	}
> +
>  	for (i =3D 0; i < npages; ++i, ioba +=3D (1ULL << stt->page_shift))
>  		kvmppc_tce_put(stt, ioba >> stt->page_shift, tce_value);
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Ro1PRY3Rtw8g7IwX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW3rKcAAoJEGw4ysog2bOSABcQAKuy7JyckKGJf+LV1J9ihl0D
5IKWdJrJoBmjEeIYYAJf3hpIZcFzNTmtwSCTU5Af76RLSsKJiiRBZtPIiJAQfVMJ
yOjgJCfbggjO3sOwzr/7ZquDyefnwCZ0a7usBPQ5G4oSG1XBYi+8Gtz/aU0Og5TL
3OuvABWkTn3aZyRX7eFu404FYNOIHW5Sg4VXTUsWLry5lBIURI8SlWr4qYWcLv4F
ze+z6+J92Nzpm5u+tWKjpIUZrhHNK5RjR2KHunz0ASH9EXshX400hYDAH8D3aEA7
GT47zaWQHEMR0pgC7HoEA9lMKG74GQBLntnjNtFPradjWqyax1aFscpmgGcedrJq
qky9qFcYDOOltQhNr9jhasAaqo0yFAjGjRQvUx6YGtvuoC0ia/+G65vY8+/ilKtj
fRCV+yVmvYqWNv6eOtTOtMMtepqMlIHK2N3Dn7eqst0tP8IiEYHvLugayG4a719S
VLUghCOqfRAPfPlWZqP/9rO2Gjy9HKPO1KD+TDaO9HlDRvOFiITjRUgX5wh/XF9Z
OhrtBFIf84IsbPYIJAatgazeaAT+KmLFfwzL7+F9uMAZ4S5eXXlX3rWYF/mkF6OC
9J2Acf3I02c+ZOc/IUmjYkhjdGK6xlH/Ez3X28vaJJMpGBI0nrQSm1OOe3bkV7/r
SrHUmIbEoscDC+t8+XDl
=WHds
-----END PGP SIGNATURE-----

--Ro1PRY3Rtw8g7IwX--
