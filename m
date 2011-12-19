Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 19544B7051
 for <linuxppc-dev@ozlabs.org>; Tue, 20 Dec 2011 02:10:17 +1100 (EST)
Subject: Re: [PATCH v3 04/14] KVM: PPC: Keep page physical addresses in
 per-slot arrays
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20111212222821.GE18868@bloggs.ozlabs.ibm.com>
Date: Mon, 19 Dec 2011 16:10:09 +0100
Message-Id: <0B47C3B4-D198-4C10-A4B6-9FDE38584290@suse.de>
References: <20111212222347.GA18868@bloggs.ozlabs.ibm.com>
 <20111212222821.GE18868@bloggs.ozlabs.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 12.12.2011, at 23:28, Paul Mackerras wrote:

> This allocates an array for each memory slot that is added to store
> the physical addresses of the pages in the slot.  This array is
> vmalloc'd and accessed in kvmppc_h_enter using real_vmalloc_addr().
> This allows us to remove the ram_pginfo field from the kvm_arch
> struct, and removes the 64GB guest RAM limit that we had.
>=20
> We use the low-order bits of the array entries to store a flag
> indicating that we have done get_page on the corresponding page,
> and therefore need to call put_page when we are finished with the
> page.  Currently this is set for all pages except those in our
> special RMO regions.
>=20
> Signed-off-by: Paul Mackerras <paulus@samba.org>
> ---
> arch/powerpc/include/asm/kvm_host.h |    9 ++-
> arch/powerpc/kvm/book3s_64_mmu_hv.c |   18 +++---
> arch/powerpc/kvm/book3s_hv.c        |  114 =
+++++++++++++++++------------------
> arch/powerpc/kvm/book3s_hv_rm_mmu.c |   41 +++++++++++-
> 4 files changed, 107 insertions(+), 75 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/kvm_host.h =
b/arch/powerpc/include/asm/kvm_host.h
> index 629df2e..7a17ab5 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -38,6 +38,7 @@
> #define KVM_MEMORY_SLOTS 32
> /* memory slots that does not exposed to userspace */
> #define KVM_PRIVATE_MEM_SLOTS 4
> +#define KVM_MEM_SLOTS_NUM (KVM_MEMORY_SLOTS + KVM_PRIVATE_MEM_SLOTS)
>=20
> #ifdef CONFIG_KVM_MMIO
> #define KVM_COALESCED_MMIO_PAGE_OFFSET 1
> @@ -175,25 +176,27 @@ struct revmap_entry {
> 	unsigned long guest_rpte;
> };
>=20
> +/* Low-order bits in kvm->arch.slot_phys[][] */
> +#define KVMPPC_GOT_PAGE		0x80
> +
> struct kvm_arch {
> #ifdef CONFIG_KVM_BOOK3S_64_HV
> 	unsigned long hpt_virt;
> 	struct revmap_entry *revmap;
> -	unsigned long ram_npages;
> 	unsigned long ram_psize;
> 	unsigned long ram_porder;
> -	struct kvmppc_pginfo *ram_pginfo;
> 	unsigned int lpid;
> 	unsigned int host_lpid;
> 	unsigned long host_lpcr;
> 	unsigned long sdr1;
> 	unsigned long host_sdr1;
> 	int tlbie_lock;
> -	int n_rma_pages;
> 	unsigned long lpcr;
> 	unsigned long rmor;
> 	struct kvmppc_rma_info *rma;
> 	struct list_head spapr_tce_tables;
> +	unsigned long *slot_phys[KVM_MEM_SLOTS_NUM];
> +	int slot_npages[KVM_MEM_SLOTS_NUM];
> 	unsigned short last_vcpu[NR_CPUS];
> 	struct kvmppc_vcore *vcores[KVM_MAX_VCORES];
> #endif /* CONFIG_KVM_BOOK3S_64_HV */
> diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c =
b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> index 80ece8d..e4c6069 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> @@ -98,16 +98,16 @@ void kvmppc_free_hpt(struct kvm *kvm)
> void kvmppc_map_vrma(struct kvm *kvm, struct =
kvm_userspace_memory_region *mem)
> {
> 	unsigned long i;
> -	unsigned long npages =3D kvm->arch.ram_npages;
> -	unsigned long pfn;
> +	unsigned long npages;
> +	unsigned long pa;
> 	unsigned long *hpte;
> 	unsigned long hash;
> 	unsigned long porder =3D kvm->arch.ram_porder;
> 	struct revmap_entry *rev;
> -	struct kvmppc_pginfo *pginfo =3D kvm->arch.ram_pginfo;
> +	unsigned long *physp;
>=20
> -	if (!pginfo)
> -		return;
> +	physp =3D kvm->arch.slot_phys[mem->slot];
> +	npages =3D kvm->arch.slot_npages[mem->slot];
>=20
> 	/* VRMA can't be > 1TB */
> 	if (npages > 1ul << (40 - porder))
> @@ -117,9 +117,10 @@ void kvmppc_map_vrma(struct kvm *kvm, struct =
kvm_userspace_memory_region *mem)
> 		npages =3D HPT_NPTEG;
>=20
> 	for (i =3D 0; i < npages; ++i) {
> -		pfn =3D pginfo[i].pfn;
> -		if (!pfn)
> +		pa =3D physp[i];
> +		if (!pa)
> 			break;
> +		pa &=3D PAGE_MASK;
> 		/* can't use hpt_hash since va > 64 bits */
> 		hash =3D (i ^ (VRMA_VSID ^ (VRMA_VSID << 25))) & =
HPT_HASH_MASK;
> 		/*
> @@ -131,8 +132,7 @@ void kvmppc_map_vrma(struct kvm *kvm, struct =
kvm_userspace_memory_region *mem)
> 		hash =3D (hash << 3) + 7;
> 		hpte =3D (unsigned long *) (kvm->arch.hpt_virt + (hash =
<< 4));
> 		/* HPTE low word - RPN, protection, etc. */
> -		hpte[1] =3D (pfn << PAGE_SHIFT) | HPTE_R_R | HPTE_R_C |
> -			HPTE_R_M | PP_RWXX;
> +		hpte[1] =3D pa | HPTE_R_R | HPTE_R_C | HPTE_R_M | =
PP_RWXX;
> 		smp_wmb();
> 		hpte[0] =3D HPTE_V_1TB_SEG | (VRMA_VSID << (40 - 16)) |
> 			(i << (VRMA_PAGE_ORDER - 16)) | HPTE_V_BOLTED |
> diff --git a/arch/powerpc/kvm/book3s_hv.c =
b/arch/powerpc/kvm/book3s_hv.c
> index da7db14..86d3e4b 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -50,14 +50,6 @@
> #include <linux/vmalloc.h>
> #include <linux/highmem.h>
>=20
> -/*
> - * For now, limit memory to 64GB and require it to be large pages.
> - * This value is chosen because it makes the ram_pginfo array be
> - * 64kB in size, which is about as large as we want to be trying
> - * to allocate with kmalloc.
> - */
> -#define MAX_MEM_ORDER		36
> -
> #define LARGE_PAGE_ORDER	24	/* 16MB pages */
>=20
> /* #define EXIT_DEBUG */
> @@ -147,10 +139,12 @@ static unsigned long do_h_register_vpa(struct =
kvm_vcpu *vcpu,
> 				       unsigned long vcpuid, unsigned =
long vpa)
> {
> 	struct kvm *kvm =3D vcpu->kvm;
> -	unsigned long pg_index, ra, len;
> +	unsigned long gfn, pg_index, ra, len;
> 	unsigned long pg_offset;
> 	void *va;
> 	struct kvm_vcpu *tvcpu;
> +	struct kvm_memory_slot *memslot;
> +	unsigned long *physp;
>=20
> 	tvcpu =3D kvmppc_find_vcpu(kvm, vcpuid);
> 	if (!tvcpu)
> @@ -164,14 +158,20 @@ static unsigned long do_h_register_vpa(struct =
kvm_vcpu *vcpu,
> 		if (vpa & 0x7f)
> 			return H_PARAMETER;
> 		/* registering new area; convert logical addr to real */
> -		pg_index =3D vpa >> kvm->arch.ram_porder;
> -		pg_offset =3D vpa & (kvm->arch.ram_psize - 1);
> -		if (pg_index >=3D kvm->arch.ram_npages)
> +		gfn =3D vpa >> PAGE_SHIFT;
> +		memslot =3D gfn_to_memslot(kvm, gfn);
> +		if (!memslot || !(memslot->flags & KVM_MEMSLOT_INVALID))
> +			return H_PARAMETER;
> +		physp =3D kvm->arch.slot_phys[memslot->id];
> +		if (!physp)
> 			return H_PARAMETER;
> -		if (kvm->arch.ram_pginfo[pg_index].pfn =3D=3D 0)
> +		pg_index =3D (gfn - memslot->base_gfn) >>
> +			(kvm->arch.ram_porder - PAGE_SHIFT);
> +		pg_offset =3D vpa & (kvm->arch.ram_psize - 1);
> +		ra =3D physp[pg_index];
> +		if (!ra)
> 			return H_PARAMETER;
> -		ra =3D kvm->arch.ram_pginfo[pg_index].pfn << PAGE_SHIFT;
> -		ra |=3D pg_offset;
> +		ra =3D (ra & PAGE_MASK) | pg_offset;
> 		va =3D __va(ra);
> 		if (flags <=3D 1)
> 			len =3D *(unsigned short *)(va + 4);
> @@ -1108,12 +1108,11 @@ int kvmppc_core_prepare_memory_region(struct =
kvm *kvm,
> 				struct kvm_userspace_memory_region *mem)
> {
> 	unsigned long psize, porder;
> -	unsigned long i, npages, totalpages;
> -	unsigned long pg_ix;
> -	struct kvmppc_pginfo *pginfo;
> +	unsigned long i, npages;
> 	unsigned long hva;
> 	struct kvmppc_rma_info *ri =3D NULL;
> 	struct page *page;
> +	unsigned long *phys;
>=20
> 	/* For now, only allow 16MB pages */
> 	porder =3D LARGE_PAGE_ORDER;
> @@ -1125,20 +1124,21 @@ int kvmppc_core_prepare_memory_region(struct =
kvm *kvm,
> 		return -EINVAL;
> 	}
>=20
> +	/* Allocate a slot_phys array */
> 	npages =3D mem->memory_size >> porder;
> -	totalpages =3D (mem->guest_phys_addr + mem->memory_size) >> =
porder;
> -
> -	/* More memory than we have space to track? */
> -	if (totalpages > (1ul << (MAX_MEM_ORDER - LARGE_PAGE_ORDER)))
> -		return -EINVAL;
> +	phys =3D kvm->arch.slot_phys[mem->slot];
> +	if (!phys) {
> +		phys =3D vzalloc(npages * sizeof(unsigned long));
> +		if (!phys)
> +			return -ENOMEM;
> +		kvm->arch.slot_phys[mem->slot] =3D phys;
> +		kvm->arch.slot_npages[mem->slot] =3D npages;
> +	}
>=20
> 	/* Do we already have an RMA registered? */
> 	if (mem->guest_phys_addr =3D=3D 0 && kvm->arch.rma)
> 		return -EINVAL;
>=20
> -	if (totalpages > kvm->arch.ram_npages)
> -		kvm->arch.ram_npages =3D totalpages;
> -
> 	/* Is this one of our preallocated RMAs? */
> 	if (mem->guest_phys_addr =3D=3D 0) {
> 		struct vm_area_struct *vma;
> @@ -1171,7 +1171,6 @@ int kvmppc_core_prepare_memory_region(struct kvm =
*kvm,
> 		}
> 		atomic_inc(&ri->use_count);
> 		kvm->arch.rma =3D ri;
> -		kvm->arch.n_rma_pages =3D rma_size >> porder;
>=20
> 		/* Update LPCR and RMOR */
> 		lpcr =3D kvm->arch.lpcr;
> @@ -1195,12 +1194,9 @@ int kvmppc_core_prepare_memory_region(struct =
kvm *kvm,
> 			ri->base_pfn << PAGE_SHIFT, rma_size, lpcr);
> 	}
>=20
> -	pg_ix =3D mem->guest_phys_addr >> porder;
> -	pginfo =3D kvm->arch.ram_pginfo + pg_ix;
> -	for (i =3D 0; i < npages; ++i, ++pg_ix) {
> -		if (ri && pg_ix < kvm->arch.n_rma_pages) {
> -			pginfo[i].pfn =3D ri->base_pfn +
> -				(pg_ix << (porder - PAGE_SHIFT));
> +	for (i =3D 0; i < npages; ++i) {
> +		if (ri && i < ri->npages) {
> +			phys[i] =3D (ri->base_pfn << PAGE_SHIFT) + (i << =
porder);
> 			continue;
> 		}
> 		hva =3D mem->userspace_addr + (i << porder);
> @@ -1216,7 +1212,7 @@ int kvmppc_core_prepare_memory_region(struct kvm =
*kvm,
> 			       hva, compound_order(page));
> 			goto err;
> 		}
> -		pginfo[i].pfn =3D page_to_pfn(page);
> +		phys[i] =3D (page_to_pfn(page) << PAGE_SHIFT) | =
KVMPPC_GOT_PAGE;
> 	}
>=20
> 	return 0;
> @@ -1225,6 +1221,28 @@ int kvmppc_core_prepare_memory_region(struct =
kvm *kvm,
> 	return -EINVAL;
> }
>=20
> +static void unpin_slot(struct kvm *kvm, int slot_id)
> +{
> +	unsigned long *physp;
> +	unsigned long j, npages, pfn;
> +	struct page *page;
> +
> +	physp =3D kvm->arch.slot_phys[slot_id];
> +	npages =3D kvm->arch.slot_npages[slot_id];
> +	if (physp) {
> +		for (j =3D 0; j < npages; j++) {
> +			if (!(physp[j] & KVMPPC_GOT_PAGE))
> +				continue;
> +			pfn =3D physp[j] >> PAGE_SHIFT;
> +			page =3D pfn_to_page(pfn);
> +			SetPageDirty(page);
> +			put_page(page);
> +		}
> +		vfree(physp);
> +		kvm->arch.slot_phys[slot_id] =3D NULL;
> +	}
> +}
> +
> void kvmppc_core_commit_memory_region(struct kvm *kvm,
> 				struct kvm_userspace_memory_region *mem)
> {
> @@ -1236,8 +1254,6 @@ void kvmppc_core_commit_memory_region(struct kvm =
*kvm,
> int kvmppc_core_init_vm(struct kvm *kvm)
> {
> 	long r;
> -	unsigned long npages =3D 1ul << (MAX_MEM_ORDER - =
LARGE_PAGE_ORDER);
> -	long err =3D -ENOMEM;
> 	unsigned long lpcr;
>=20
> 	/* Allocate hashed page table */
> @@ -1247,19 +1263,9 @@ int kvmppc_core_init_vm(struct kvm *kvm)
>=20
> 	INIT_LIST_HEAD(&kvm->arch.spapr_tce_tables);
>=20
> -	kvm->arch.ram_pginfo =3D kzalloc(npages * sizeof(struct =
kvmppc_pginfo),
> -				       GFP_KERNEL);
> -	if (!kvm->arch.ram_pginfo) {
> -		pr_err("kvmppc_core_init_vm: couldn't alloc %lu =
bytes\n",
> -		       npages * sizeof(struct kvmppc_pginfo));
> -		goto out_free;
> -	}
> -
> -	kvm->arch.ram_npages =3D 0;
> 	kvm->arch.ram_psize =3D 1ul << LARGE_PAGE_ORDER;
> 	kvm->arch.ram_porder =3D LARGE_PAGE_ORDER;
> 	kvm->arch.rma =3D NULL;
> -	kvm->arch.n_rma_pages =3D 0;
>=20
> 	kvm->arch.host_sdr1 =3D mfspr(SPRN_SDR1);
>=20
> @@ -1282,25 +1288,15 @@ int kvmppc_core_init_vm(struct kvm *kvm)
> 	kvm->arch.lpcr =3D lpcr;
>=20
> 	return 0;
> -
> - out_free:
> -	kvmppc_free_hpt(kvm);
> -	return err;
> }
>=20
> void kvmppc_core_destroy_vm(struct kvm *kvm)
> {
> -	struct kvmppc_pginfo *pginfo;
> 	unsigned long i;
>=20
> -	if (kvm->arch.ram_pginfo) {
> -		pginfo =3D kvm->arch.ram_pginfo;
> -		kvm->arch.ram_pginfo =3D NULL;
> -		for (i =3D kvm->arch.n_rma_pages; i < =
kvm->arch.ram_npages; ++i)
> -			if (pginfo[i].pfn)
> -				put_page(pfn_to_page(pginfo[i].pfn));
> -		kfree(pginfo);
> -	}
> +	for (i =3D 0; i < KVM_MEM_SLOTS_NUM; i++)
> +		unpin_slot(kvm, i);
> +
> 	if (kvm->arch.rma) {
> 		kvm_release_rma(kvm->arch.rma);
> 		kvm->arch.rma =3D NULL;
> diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c =
b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
> index 6148493..84dae82 100644
> --- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
> +++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
> @@ -20,6 +20,25 @@
> #include <asm/synch.h>
> #include <asm/ppc-opcode.h>
>=20
> +/*
> + * Since this file is built in even if KVM is a module, we need
> + * a local copy of this function for the case where kvm_main.c is
> + * modular.
> + */
> +static struct kvm_memory_slot *builtin_gfn_to_memslot(struct kvm =
*kvm,
> +						gfn_t gfn)
> +{

Shouldn't this rather be in a header file then? I'd rather not have this =
code duplicated. Please follow up with a patch to merge this copy and =
the real one into something in a header file.


Alex
