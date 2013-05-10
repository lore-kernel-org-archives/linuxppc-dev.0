Return-Path: <dgibson@ozlabs.org>
Date: Fri, 10 May 2013 16:51:01 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH 2/6] KVM: PPC: Add support for multiple-TCE hcalls
Message-ID: <20130510065101.GF23358@truffula.fritz.box>
References: <1367825157-27231-1-git-send-email-aik@ozlabs.ru>
 <1367825157-27231-3-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="WlEyl6ow+jlIgNUh"
In-Reply-To: <1367825157-27231-3-git-send-email-aik@ozlabs.ru>
Cc: kvm@vger.kernel.org, Joerg Roedel <joerg.roedel@amd.com>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--WlEyl6ow+jlIgNUh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 06, 2013 at 05:25:53PM +1000, Alexey Kardashevskiy wrote:
> This adds real mode handlers for the H_PUT_TCE_INDIRECT and
> H_STUFF_TCE hypercalls for QEMU emulated devices such as virtio
> devices or emulated PCI.  These calls allow adding multiple entries
> (up to 512) into the TCE table in one call which saves time on
> transition to/from real mode.
>=20
> This adds a guest physical to host real address converter
> and calls the existing H_PUT_TCE handler. The converting function
> is going to be fully utilized by upcoming VFIO supporting patches.
>=20
> This also implements the KVM_CAP_PPC_MULTITCE capability,
> so in order to support the functionality of this patch, QEMU
> needs to query for this capability and set the "hcall-multi-tce"
> hypertas property only if the capability is present, otherwise
> there will be serious performance degradation.


Hrm.  Clearly I didn't read this carefully enough before.  There are
some problems here.

[snip]
> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_6=
4_vio.c
> index 72ffc89..643ac1e 100644
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
> @@ -36,9 +37,14 @@
>  #include <asm/ppc-opcode.h>
>  #include <asm/kvm_host.h>
>  #include <asm/udbg.h>
> +#include <asm/iommu.h>
> =20
>  #define TCES_PER_PAGE	(PAGE_SIZE / sizeof(u64))
> +#define ERROR_ADDR      (~(unsigned long)0x0)
> =20
> +/*
> + * TCE tables handlers.
> + */
>  static long kvmppc_stt_npages(unsigned long window_size)
>  {
>  	return ALIGN((window_size >> SPAPR_TCE_SHIFT)
> @@ -148,3 +154,111 @@ fail:
>  	}
>  	return ret;
>  }
> +
> +/*
> + * Virtual mode handling of IOMMU map/unmap.
> + */
> +/* Converts guest physical address into host virtual */
> +static unsigned long get_virt_address(struct kvm_vcpu *vcpu,
> +		unsigned long gpa)

This should probably return a void * rather than an unsigned long.
Well, actually a void __user *.

> +{
> +	unsigned long hva, gfn =3D gpa >> PAGE_SHIFT;
> +	struct kvm_memory_slot *memslot;
> +
> +	memslot =3D search_memslots(kvm_memslots(vcpu->kvm), gfn);
> +	if (!memslot)
> +		return ERROR_ADDR;
> +
> +	/*
> +	 * Convert gfn to hva preserving flags and an offset
> +	 * within a system page
> +	 */
> +	hva =3D __gfn_to_hva_memslot(memslot, gfn) + (gpa & ~PAGE_MASK);
> +	return hva;
> +}
> +
> +long kvmppc_virtmode_h_put_tce(struct kvm_vcpu *vcpu,
> +		unsigned long liobn, unsigned long ioba,
> +		unsigned long tce)
> +{
> +	struct kvmppc_spapr_tce_table *tt;
> +
> +	tt =3D kvmppc_find_tce_table(vcpu, liobn);
> +	/* Didn't find the liobn, put it to userspace */
> +	if (!tt)
> +		return H_TOO_HARD;
> +
> +	/* Emulated IO */
> +	return kvmppc_emulated_h_put_tce(tt, ioba, tce);
> +}
> +
> +long kvmppc_virtmode_h_put_tce_indirect(struct kvm_vcpu *vcpu,
> +		unsigned long liobn, unsigned long ioba,
> +		unsigned long tce_list, unsigned long npages)
> +{
> +	struct kvmppc_spapr_tce_table *tt;
> +	long i;
> +	unsigned long tces;
> +
> +	/* The whole table addressed by tce_list resides in 4K page */
> +	if (npages > 512)
> +		return H_PARAMETER;

So, that doesn't actually verify what the comment says it does - only
that the list is < 4K in total.  You need to check the alignment of
tce_list as well.

> +
> +	tt =3D kvmppc_find_tce_table(vcpu, liobn);
> +	/* Didn't find the liobn, put it to userspace */
> +	if (!tt)
> +		return H_TOO_HARD;
> +
> +	tces =3D get_virt_address(vcpu, tce_list);
> +	if (tces =3D=3D ERROR_ADDR)
> +		return H_TOO_HARD;
> +
> +	/* Emulated IO */

This comment doesn't seem to have any bearing on the test which
follows it.

> +	if ((ioba + (npages << IOMMU_PAGE_SHIFT)) > tt->window_size)
> +		return H_PARAMETER;
> +
> +	for (i =3D 0; i < npages; ++i) {
> +		unsigned long tce;
> +		unsigned long ptce =3D tces + i * sizeof(unsigned long);
> +
> +		if (get_user(tce, (unsigned long __user *)ptce))
> +			break;
> +
> +		if (kvmppc_emulated_h_put_tce(tt,
> +				ioba + (i << IOMMU_PAGE_SHIFT),	tce))
> +			break;
> +	}
> +	if (i =3D=3D npages)
> +		return H_SUCCESS;
> +
> +	/* Failed, do cleanup */
> +	do {
> +		--i;
> +		kvmppc_emulated_h_put_tce(tt, ioba + (i << IOMMU_PAGE_SHIFT),
> +				0);
> +	} while (i);

Hrm, so, actually PAPR specifies that this hcall is supposed to first
copy the given tces to hypervisor memory, then translate (and
validate) them all, and only then touch the actual TCE table.  Rather
more complicated to do, but I guess we should - that would get rid of
the need for this partial cleanup in the failure case.

> +
> +	return H_PARAMETER;
> +}
> +
> +long kvmppc_virtmode_h_stuff_tce(struct kvm_vcpu *vcpu,
> +		unsigned long liobn, unsigned long ioba,
> +		unsigned long tce_value, unsigned long npages)
> +{
> +	struct kvmppc_spapr_tce_table *tt;
> +	long i;
> +
> +	tt =3D kvmppc_find_tce_table(vcpu, liobn);
> +	/* Didn't find the liobn, put it to userspace */
> +	if (!tt)
> +		return H_TOO_HARD;
> +
> +	/* Emulated IO */
> +	if ((ioba + (npages << IOMMU_PAGE_SHIFT)) > tt->window_size)
> +		return H_PARAMETER;
> +
> +	for (i =3D 0; i < npages; ++i, ioba +=3D IOMMU_PAGE_SIZE)
> +		kvmppc_emulated_h_put_tce(tt, ioba, tce_value);
> +
> +	return H_SUCCESS;
> +}
> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3=
s_64_vio_hv.c
> index 30c2f3b..55fdf7a 100644
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
> @@ -35,42 +36,214 @@
>  #include <asm/ppc-opcode.h>
>  #include <asm/kvm_host.h>
>  #include <asm/udbg.h>
> +#include <asm/iommu.h>
> +#include <asm/tce.h>
> =20
>  #define TCES_PER_PAGE	(PAGE_SIZE / sizeof(u64))
> +#define ERROR_ADDR      (~(unsigned long)0x0)
> =20
> -/* WARNING: This will be called in real-mode on HV KVM and virtual
> - *          mode on PR KVM
> +/*
> + * Finds a TCE table descriptor by LIOBN.
>   */
> +struct kvmppc_spapr_tce_table *kvmppc_find_tce_table(struct kvm_vcpu *vc=
pu,
> +		unsigned long liobn)
> +{
> +	struct kvmppc_spapr_tce_table *tt;
> +
> +	list_for_each_entry(tt, &vcpu->kvm->arch.spapr_tce_tables, list) {
> +		if (tt->liobn =3D=3D liobn)
> +			return tt;
> +	}
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(kvmppc_find_tce_table);
> +
> +/*
> + * kvmppc_emulated_h_put_tce() handles TCE requests for devices emulated
> + * by QEMU. It puts guest TCE values into the table and expects
> + * the QEMU to convert them later in the QEMU device implementation.
> + * Works in both real and virtual modes.
> + */
> +long kvmppc_emulated_h_put_tce(struct kvmppc_spapr_tce_table *tt,
> +		unsigned long ioba, unsigned long tce)
> +{
> +	unsigned long idx =3D ioba >> SPAPR_TCE_SHIFT;
> +	struct page *page;
> +	u64 *tbl;
> +
> +	/* udbg_printf("H_PUT_TCE: liobn 0x%lx =3D> tt=3D%p  window_size=3D0x%x=
\n", */
> +	/*	    liobn, tt, tt->window_size); */
> +	if (ioba >=3D tt->window_size) {
> +		/* pr_err("%s failed on ioba=3D%lx\n", __func__, ioba); */
> +		return H_PARAMETER;
> +	}
> +	/*
> +	 * Note on the use of page_address() in real mode,
> +	 *
> +	 * It is safe to use page_address() in real mode on ppc64 because
> +	 * page_address() is always defined as lowmem_page_address()
> +	 * which returns __va(PFN_PHYS(page_to_pfn(page))) which is arithmetial
> +	 * operation and does not access page struct.
> +	 *
> +	 * Theoretically page_address() could be defined different
> +	 * but either WANT_PAGE_VIRTUAL or HASHED_PAGE_VIRTUAL
> +	 * should be enabled.
> +	 * WANT_PAGE_VIRTUAL is never enabled on ppc32/ppc64,
> +	 * HASHED_PAGE_VIRTUAL could be enabled for ppc32 only and only
> +	 * if CONFIG_HIGHMEM is defined. As CONFIG_SPARSEMEM_VMEMMAP
> +	 * is not expected to be enabled on ppc32, page_address()
> +	 * is safe for ppc32 as well.
> +	 */
> +#if defined(HASHED_PAGE_VIRTUAL) || defined(WANT_PAGE_VIRTUAL)
> +#error TODO: fix to avoid page_address() here
> +#endif
> +	page =3D tt->pages[idx / TCES_PER_PAGE];
> +	tbl =3D (u64 *)page_address(page);
> +
> +	/*
> +	 * Validate TCE address.
> +	 * At the moment only flags are validated
> +	 * as other check will significantly slow down
> +	 * or can make it even impossible to handle TCE requests
> +	 * in real mode.
> +	 */
> +	if (tce & ~(IOMMU_PAGE_MASK | TCE_PCI_WRITE | TCE_PCI_READ))
> +		return H_PARAMETER;
> +
> +	/* udbg_printf("tce @ %p\n", &tbl[idx % TCES_PER_PAGE]); */
> +	tbl[idx % TCES_PER_PAGE] =3D tce;
> +
> +	return H_SUCCESS;
> +}
> +EXPORT_SYMBOL_GPL(kvmppc_emulated_h_put_tce);
> +
> +#ifdef CONFIG_KVM_BOOK3S_64_HV
> +/*
> + * Converts guest physical address into host real address.
> + * Also returns pte and page size if the page is present in page table.
> + */
> +static unsigned long get_real_address(struct kvm_vcpu *vcpu,
> +		unsigned long gpa, bool writing,
> +		pte_t *ptep, unsigned long *pg_sizep)

The only caller doesn't use the ptep and pg_sizep pointers, so there's
no point implementing them.

> +{
> +	struct kvm_memory_slot *memslot;
> +	pte_t pte;
> +	unsigned long hva, pg_size =3D 0, hwaddr, offset;
> +	unsigned long gfn =3D gpa >> PAGE_SHIFT;
> +
> +	/* Find a KVM memslot */
> +	memslot =3D search_memslots(kvm_memslots(vcpu->kvm), gfn);
> +	if (!memslot)
> +		return ERROR_ADDR;
> +
> +	/* Convert guest physical address to host virtual */
> +	hva =3D __gfn_to_hva_memslot(memslot, gfn);
> +
> +	/* Find a PTE and determine the size */
> +	pte =3D lookup_linux_pte(vcpu->arch.pgdir, hva,
> +			writing, &pg_size);
> +	if (!pte_present(pte))
> +		return ERROR_ADDR;
> +
> +	/* Calculate host phys address keeping flags and offset in the page */
> +	offset =3D gpa & (pg_size - 1);
> +
> +	/* pte_pfn(pte) should return an address aligned to pg_size */
> +	hwaddr =3D (pte_pfn(pte) << PAGE_SHIFT) + offset;
> +
> +	/* Copy outer values if required */
> +	if (pg_sizep)
> +		*pg_sizep =3D pg_size;
> +	if (ptep)
> +		*ptep =3D pte;
> +
> +	return hwaddr;
> +}
> +
>  long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
>  		      unsigned long ioba, unsigned long tce)
>  {
> -	struct kvm *kvm =3D vcpu->kvm;
> -	struct kvmppc_spapr_tce_table *stt;
> -
> -	/* udbg_printf("H_PUT_TCE(): liobn=3D0x%lx ioba=3D0x%lx, tce=3D0x%lx\n"=
, */
> -	/* 	    liobn, ioba, tce); */
> -
> -	list_for_each_entry(stt, &kvm->arch.spapr_tce_tables, list) {
> -		if (stt->liobn =3D=3D liobn) {
> -			unsigned long idx =3D ioba >> SPAPR_TCE_SHIFT;
> -			struct page *page;
> -			u64 *tbl;
> -
> -			/* udbg_printf("H_PUT_TCE: liobn 0x%lx =3D> stt=3D%p  window_size=3D0=
x%x\n", */
> -			/* 	    liobn, stt, stt->window_size); */
> -			if (ioba >=3D stt->window_size)
> -				return H_PARAMETER;
> -
> -			page =3D stt->pages[idx / TCES_PER_PAGE];
> -			tbl =3D (u64 *)page_address(page);
> -
> -			/* FIXME: Need to validate the TCE itself */
> -			/* udbg_printf("tce @ %p\n", &tbl[idx % TCES_PER_PAGE]); */
> -			tbl[idx % TCES_PER_PAGE] =3D tce;
> -			return H_SUCCESS;
> -		}
> +	struct kvmppc_spapr_tce_table *tt;
> +
> +	tt =3D kvmppc_find_tce_table(vcpu, liobn);
> +	/* Didn't find the liobn, put it to virtual space */
> +	if (!tt)
> +		return H_TOO_HARD;
> +
> +	/* Emulated IO */
> +	return kvmppc_emulated_h_put_tce(tt, ioba, tce);
> +}
> +
> +long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
> +		unsigned long liobn, unsigned long ioba,
> +		unsigned long tce_list,	unsigned long npages)
> +{
> +	struct kvmppc_spapr_tce_table *tt;
> +	long i;
> +	unsigned long tces;
> +
> +	/* The whole table addressed by tce_list resides in 4K page */
> +	if (npages > 512)
> +		return H_PARAMETER;
> +
> +	tt =3D kvmppc_find_tce_table(vcpu, liobn);
> +	/* Didn't find the liobn, put it to virtual space */
> +	if (!tt)
> +		return H_TOO_HARD;
> +
> +	tces =3D get_real_address(vcpu, tce_list, false, NULL, NULL);
> +	if (tces =3D=3D ERROR_ADDR)
> +		return H_TOO_HARD;
> +
> +	/* Emulated IO */
> +	if ((ioba + (npages << IOMMU_PAGE_SHIFT)) > tt->window_size)
> +		return H_PARAMETER;
> +
> +	for (i =3D 0; i < npages; ++i) {
> +		unsigned long tce;
> +		unsigned long ptce =3D tces + i * sizeof(unsigned long);
> +
> +		if (get_user(tce, (unsigned long __user *)ptce))
> +			break;

Uh.  get_user() should not be used from real mode.  You'll need to
dereference the pointer directly here.

> +
> +		if (kvmppc_emulated_h_put_tce(tt,
> +				ioba + (i << IOMMU_PAGE_SHIFT), tce))
> +			break;
>  	}
> +	if (i =3D=3D npages)
> +		return H_SUCCESS;
> +
> +	/* Failed, do cleanup */
> +	do {
> +		--i;
> +		kvmppc_emulated_h_put_tce(tt, ioba + (i << IOMMU_PAGE_SHIFT),
> +				0);
> +	} while (i);
> +
> +	return H_PARAMETER;
> +}
> =20
> -	/* Didn't find the liobn, punt it to userspace */
> -	return H_TOO_HARD;
> +long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
> +		unsigned long liobn, unsigned long ioba,
> +		unsigned long tce_value, unsigned long npages)
> +{
> +	struct kvmppc_spapr_tce_table *tt;
> +	long i;
> +
> +	tt =3D kvmppc_find_tce_table(vcpu, liobn);
> +	/* Didn't find the liobn, put it to virtual space */
> +	if (!tt)
> +		return H_TOO_HARD;
> +
> +	/* Emulated IO */
> +	if ((ioba + (npages << IOMMU_PAGE_SHIFT)) > tt->window_size)
> +		return H_PARAMETER;
> +
> +	for (i =3D 0; i < npages; ++i, ioba +=3D IOMMU_PAGE_SIZE)
> +		kvmppc_emulated_h_put_tce(tt, ioba, tce_value);
> +
> +	return H_SUCCESS;
>  }
> +
> +#endif /* CONFIG_KVM_BOOK3S_64_HV */
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index e5afdcb..6eb6f44 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -565,6 +565,29 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
>  			ret =3D kvmppc_xics_hcall(vcpu, req);
>  			break;
>  		} /* fallthrough */


As paulus already pointed out, inserting this code here breaks the no
kernel xics case badly because of the fallthrough above.

> +	case H_PUT_TCE:
> +		ret =3D kvmppc_virtmode_h_put_tce(vcpu, kvmppc_get_gpr(vcpu, 4),
> +						kvmppc_get_gpr(vcpu, 5),
> +						kvmppc_get_gpr(vcpu, 6));
> +		if (ret =3D=3D H_TOO_HARD)
> +			return RESUME_HOST;
> +		break;
> +	case H_PUT_TCE_INDIRECT:
> +		ret =3D kvmppc_virtmode_h_put_tce_indirect(vcpu, kvmppc_get_gpr(vcpu, =
4),
> +						kvmppc_get_gpr(vcpu, 5),
> +						kvmppc_get_gpr(vcpu, 6),
> +						kvmppc_get_gpr(vcpu, 7));
> +		if (ret =3D=3D H_TOO_HARD)
> +			return RESUME_HOST;
> +		break;
> +	case H_STUFF_TCE:
> +		ret =3D kvmppc_virtmode_h_stuff_tce(vcpu, kvmppc_get_gpr(vcpu, 4),
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
> index d3e26be..4d73406 100644
> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> @@ -1472,6 +1472,12 @@ hcall_real_table:
>  	.long	0		/* 0x11c */
>  	.long	0		/* 0x120 */
>  	.long	.kvmppc_h_bulk_remove - hcall_real_table
> +	.long	0		/* 0x128 */
> +	.long	0		/* 0x12c */
> +	.long	0		/* 0x130 */
> +	.long	0		/* 0x134 */
> +	.long	.kvmppc_h_stuff_tce - hcall_real_table
> +	.long	.kvmppc_h_put_tce_indirect - hcall_real_table
>  hcall_real_table_end:
> =20
>  ignore_hdec:
> diff --git a/arch/powerpc/kvm/book3s_pr_papr.c b/arch/powerpc/kvm/book3s_=
pr_papr.c
> index 8352cac..603e4f2 100644
> --- a/arch/powerpc/kvm/book3s_pr_papr.c
> +++ b/arch/powerpc/kvm/book3s_pr_papr.c
> @@ -220,7 +220,38 @@ static int kvmppc_h_pr_put_tce(struct kvm_vcpu *vcpu)
>  	unsigned long tce =3D kvmppc_get_gpr(vcpu, 6);
>  	long rc;
> =20
> -	rc =3D kvmppc_h_put_tce(vcpu, liobn, ioba, tce);
> +	rc =3D kvmppc_virtmode_h_put_tce(vcpu, liobn, ioba, tce);
> +	if (rc =3D=3D H_TOO_HARD)
> +		return EMULATE_FAIL;
> +	kvmppc_set_gpr(vcpu, 3, rc);
> +	return EMULATE_DONE;
> +}
> +
> +static int kvmppc_h_pr_put_tce_indirect(struct kvm_vcpu *vcpu)
> +{
> +	unsigned long liobn =3D kvmppc_get_gpr(vcpu, 4);
> +	unsigned long ioba =3D kvmppc_get_gpr(vcpu, 5);
> +	unsigned long tce =3D kvmppc_get_gpr(vcpu, 6);
> +	unsigned long npages =3D kvmppc_get_gpr(vcpu, 7);
> +	long rc;
> +
> +	rc =3D kvmppc_virtmode_h_put_tce_indirect(vcpu, liobn, ioba,
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
> +	rc =3D kvmppc_virtmode_h_stuff_tce(vcpu, liobn, ioba, tce_value, npages=
);
>  	if (rc =3D=3D H_TOO_HARD)
>  		return EMULATE_FAIL;
>  	kvmppc_set_gpr(vcpu, 3, rc);
> @@ -249,6 +280,10 @@ int kvmppc_h_pr(struct kvm_vcpu *vcpu, unsigned long=
 cmd)
>  		return kvmppc_h_pr_bulk_remove(vcpu);
>  	case H_PUT_TCE:
>  		return kvmppc_h_pr_put_tce(vcpu);
> +	case H_PUT_TCE_INDIRECT:
> +		return kvmppc_h_pr_put_tce_indirect(vcpu);
> +	case H_STUFF_TCE:
> +		return kvmppc_h_pr_stuff_tce(vcpu);
>  	case H_CEDE:
>  		vcpu->arch.shared->msr |=3D MSR_EE;
>  		kvm_vcpu_block(vcpu);
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index f9c159e..b7ad589 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -384,6 +384,9 @@ int kvm_dev_ioctl_check_extension(long ext)
>  		r =3D 1;
>  		break;
>  #endif
> +	case KVM_CAP_SPAPR_MULTITCE:
> +		r =3D 1;
> +		break;
>  	default:
>  		r =3D 0;
>  		break;
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 6f49c87..6c04da1 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -640,6 +640,7 @@ struct kvm_ppc_smmu_info {
>  #define KVM_CAP_PPC_HTAB_FD 84
>  #define KVM_CAP_PPC_RTAS (0x100000 + 87)
>  #define KVM_CAP_SPAPR_XICS (0x100000 + 88)
> +#define KVM_CAP_SPAPR_MULTITCE (0x110000 + 89)
> =20
>  #ifdef KVM_CAP_IRQ_ROUTING
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--WlEyl6ow+jlIgNUh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlGMmNUACgkQaILKxv3ab8YZ7gCfYWA+GLTUCSJg5SbeToR24meW
scEAn2m3k8iylUz8s/P/OBWV2z2m5Kp3
=r3x9
-----END PGP SIGNATURE-----

--WlEyl6ow+jlIgNUh--
