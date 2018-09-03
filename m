Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 423bR30w9CzF38n
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Sep 2018 13:43:27 +1000 (AEST)
Date: Mon, 3 Sep 2018 13:28:44 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH kernel] KVM: PPC: Avoid mapping compound pages to TCEs in
 real mode
Message-ID: <20180903032844.GD2679@umbus.fritz.box>
References: <20180831060850.33010-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cQXOx3fnlpmgJsTP"
In-Reply-To: <20180831060850.33010-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--cQXOx3fnlpmgJsTP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 31, 2018 at 04:08:50PM +1000, Alexey Kardashevskiy wrote:
> At the moment the real mode handler of H_PUT_TCE calls iommu_tce_xchg_rm()
> which in turn reads the old TCE and if it was a valid entry - marks
> the physical page dirty if it was mapped for writing. Since it is
> the real mode, realmode_pfn_to_page() is used instead of pfn_to_page()
> to get the page struct. However SetPageDirty() itself reads the compound
> page head and returns a virtual address for the head page struct and
> setting dirty bit for that kills the system.
>=20
> This moves dirty bit setting before updating the hardware table

Um.. but now you're setting DIRTY based on the *new* TCE's
permissions, instead of the old TCE's permissions, which I don't think
is correct.

> to make
> sure compound pages are never mapped in the real mode so when H_PUT_TCE
> or H_STUFF_TCE try clearing a TCE, they won't get a compound page to mark
> dirty.
>=20
> This changes kvmppc_rm_tce_validate() to check if the preregistered
> memory is backed with pages bigger than hardware IOMMU pages; if this is
> the case, we forward the request to the virtual mode handlers where it
> can be safely processed.
>=20
> The second check makes the first check rather unnecessary but since
> the actual crash happened at the SetPageDirty() call site, this marks
> the spot with WARN_ON_ONCE.
>=20
> In order to keep virtual and real mode handlers in sync, this adjusts
> iommu_tce_xchg() as well.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>=20
> This is made on top of:
> [PATCH kernel 0/4] KVM: PPC: Some error handling rework
>   KVM: PPC: Validate all tces before updating tables
>   KVM: PPC: Inform the userspace about TCE update failures
>   KVM: PPC: Validate TCEs against preregistered memory page sizes
>   KVM: PPC: Propagate errors to the guest when failed instead of
>     ignoring
> ---
>  arch/powerpc/include/asm/mmu_context.h |  3 ++-
>  arch/powerpc/kernel/iommu.c            | 19 ++++++++-----------
>  arch/powerpc/kvm/book3s_64_vio_hv.c    | 15 +++++++++++----
>  arch/powerpc/mm/mmu_context_iommu.c    |  4 +++-
>  4 files changed, 24 insertions(+), 17 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/includ=
e/asm/mmu_context.h
> index b2f89b6..073d72f9b 100644
> --- a/arch/powerpc/include/asm/mmu_context.h
> +++ b/arch/powerpc/include/asm/mmu_context.h
> @@ -31,7 +31,8 @@ extern void mm_iommu_cleanup(struct mm_struct *mm);
>  extern struct mm_iommu_table_group_mem_t *mm_iommu_lookup(struct mm_stru=
ct *mm,
>  		unsigned long ua, unsigned long size);
>  extern struct mm_iommu_table_group_mem_t *mm_iommu_lookup_rm(
> -		struct mm_struct *mm, unsigned long ua, unsigned long size);
> +		struct mm_struct *mm, unsigned long ua, unsigned long size,
> +		unsigned int *pshift);
>  extern struct mm_iommu_table_group_mem_t *mm_iommu_find(struct mm_struct=
 *mm,
>  		unsigned long ua, unsigned long entries);
>  extern long mm_iommu_ua_to_hpa(struct mm_iommu_table_group_mem_t *mem,
> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> index af7a20d..62e014d 100644
> --- a/arch/powerpc/kernel/iommu.c
> +++ b/arch/powerpc/kernel/iommu.c
> @@ -998,12 +998,11 @@ long iommu_tce_xchg(struct iommu_table *tbl, unsign=
ed long entry,
>  {
>  	long ret;
> =20
> -	ret =3D tbl->it_ops->exchange(tbl, entry, hpa, direction);
> -
> -	if (!ret && ((*direction =3D=3D DMA_FROM_DEVICE) ||
> -			(*direction =3D=3D DMA_BIDIRECTIONAL)))
> +	if (*direction =3D=3D DMA_FROM_DEVICE || *direction =3D=3D DMA_BIDIRECT=
IONAL)
>  		SetPageDirty(pfn_to_page(*hpa >> PAGE_SHIFT));
> =20
> +	ret =3D tbl->it_ops->exchange(tbl, entry, hpa, direction);
> +
>  	/* if (unlikely(ret))
>  		pr_err("iommu_tce: %s failed on hwaddr=3D%lx ioba=3D%lx kva=3D%lx ret=
=3D%d\n",
>  			__func__, hwaddr, entry << tbl->it_page_shift,
> @@ -1019,20 +1018,18 @@ long iommu_tce_xchg_rm(struct iommu_table *tbl, u=
nsigned long entry,
>  {
>  	long ret;
> =20
> -	ret =3D tbl->it_ops->exchange_rm(tbl, entry, hpa, direction);
> -
> -	if (!ret && ((*direction =3D=3D DMA_FROM_DEVICE) ||
> -			(*direction =3D=3D DMA_BIDIRECTIONAL))) {
> +	if (*direction =3D=3D DMA_FROM_DEVICE || *direction =3D=3D DMA_BIDIRECT=
IONAL) {
>  		struct page *pg =3D realmode_pfn_to_page(*hpa >> PAGE_SHIFT);
> =20
>  		if (likely(pg)) {
> +			if (WARN_ON_ONCE(PageCompound(pg)))
> +				return -EPERM;
>  			SetPageDirty(pg);
> -		} else {
> -			tbl->it_ops->exchange_rm(tbl, entry, hpa, direction);
> -			ret =3D -EFAULT;
>  		}
>  	}
> =20
> +	ret =3D tbl->it_ops->exchange_rm(tbl, entry, hpa, direction);
> +
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(iommu_tce_xchg_rm);
> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3=
s_64_vio_hv.c
> index 8d82133..ce4d2f4 100644
> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
> @@ -118,11 +118,17 @@ static long kvmppc_rm_tce_validate(struct kvmppc_sp=
apr_tce_table *stt,
>  		unsigned long hpa =3D 0;
>  		struct mm_iommu_table_group_mem_t *mem;
>  		long shift =3D stit->tbl->it_page_shift;
> +		unsigned int memshift =3D 0;
> =20
> -		mem =3D mm_iommu_lookup_rm(stt->kvm->mm, ua, 1ULL << shift);
> +		mem =3D mm_iommu_lookup_rm(stt->kvm->mm, ua, 1ULL << shift,
> +				&memshift);
>  		if (!mem)
>  			return H_TOO_HARD;
> =20
> +		/* Marking compound pages dirty in real mode is too complex */
> +		if (memshift > shift)
> +			return H_TOO_HARD;
> +
>  		if (mm_iommu_ua_to_hpa_rm(mem, ua, shift, &hpa))
>  			return H_TOO_HARD;
>  	}
> @@ -222,7 +228,7 @@ static long kvmppc_rm_tce_iommu_mapped_dec(struct kvm=
 *kvm,
>  		/* it_userspace allocation might be delayed */
>  		return H_TOO_HARD;
> =20
> -	mem =3D mm_iommu_lookup_rm(kvm->mm, be64_to_cpu(*pua), pgsize);
> +	mem =3D mm_iommu_lookup_rm(kvm->mm, be64_to_cpu(*pua), pgsize, NULL);
>  	if (!mem)
>  		return H_TOO_HARD;
> =20
> @@ -287,7 +293,7 @@ static long kvmppc_rm_tce_iommu_do_map(struct kvm *kv=
m, struct iommu_table *tbl,
>  		/* it_userspace allocation might be delayed */
>  		return H_TOO_HARD;
> =20
> -	mem =3D mm_iommu_lookup_rm(kvm->mm, ua, 1ULL << tbl->it_page_shift);
> +	mem =3D mm_iommu_lookup_rm(kvm->mm, ua, 1ULL << tbl->it_page_shift, NUL=
L);
>  	if (!mem)
>  		return H_TOO_HARD;
> =20
> @@ -472,7 +478,8 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vc=
pu,
>  		if (kvmppc_gpa_to_ua(vcpu->kvm, tce_list, &ua, NULL))
>  			return H_TOO_HARD;
> =20
> -		mem =3D mm_iommu_lookup_rm(vcpu->kvm->mm, ua, IOMMU_PAGE_SIZE_4K);
> +		mem =3D mm_iommu_lookup_rm(vcpu->kvm->mm, ua, IOMMU_PAGE_SIZE_4K,
> +				NULL);
>  		if (mem)
>  			prereg =3D mm_iommu_ua_to_hpa_rm(mem, ua,
>  					IOMMU_PAGE_SHIFT_4K, &tces) =3D=3D 0;
> diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_co=
ntext_iommu.c
> index c9ee9e2..5c31fa5 100644
> --- a/arch/powerpc/mm/mmu_context_iommu.c
> +++ b/arch/powerpc/mm/mmu_context_iommu.c
> @@ -344,7 +344,7 @@ struct mm_iommu_table_group_mem_t *mm_iommu_lookup(st=
ruct mm_struct *mm,
>  EXPORT_SYMBOL_GPL(mm_iommu_lookup);
> =20
>  struct mm_iommu_table_group_mem_t *mm_iommu_lookup_rm(struct mm_struct *=
mm,
> -		unsigned long ua, unsigned long size)
> +		unsigned long ua, unsigned long size, unsigned int *pshift)
>  {
>  	struct mm_iommu_table_group_mem_t *mem, *ret =3D NULL;
> =20
> @@ -354,6 +354,8 @@ struct mm_iommu_table_group_mem_t *mm_iommu_lookup_rm=
(struct mm_struct *mm,
>  				(ua + size <=3D mem->ua +
>  				 (mem->entries << PAGE_SHIFT))) {
>  			ret =3D mem;
> +			if (pshift)
> +				*pshift =3D mem->pageshift;
>  			break;
>  		}
>  	}

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--cQXOx3fnlpmgJsTP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAluMqmoACgkQbDjKyiDZ
s5KRrA/8CzeCk6ssuNkkhI3+q1QavUIJt7idWKOHpsDxkcH4YVNZ/bxKY+6PjAfx
Rc5vADUan0Budd8BXGhdMODtDsjgOfIJXlPbuf1DvKfwGofw4C5mvn6ap8YyD1pB
6mB4lZ5R0V4WmlKKWkDVDdLMr6eqs0+gXmWSaNlDZV5IGXXUjXKTm0cKogNmDIDF
5d6LAThQdIUbHGYz6MZAMCy7IP+eMBRs5LlQId0ZM8Gue2XuE7h90VoKQ3KKov2+
O/LwcmwPfYQixJ8Ir0rAY8KFiPEI64m1fq/opijc5Jc16HO9D+WMIOIjTRq9DHDM
oMItPziW5XnAO5g7nJw5o4+cy852t7QSfLMx4/rtWbGFaH9oHniRgsovagRG8pHq
dWbWIGoYJBF3atosQBFzqTYFFioLhAm0+RfEX8I5O0Iy4wK7R2yz0raAsORIS2Cu
A9zuksbDL77P/lpe4AO2H8gWtt1dKmM+r6cbrPJ8ocwv9AyvCvw793LFaLTbZrjY
CWeSbDFGsDa1Jnqo0d27OtBpK1WS3RUNS5k+8i8aEG7/nGPQzQmx2AnsREx+SmK5
GQXYCmi4+8PVNn5YH2LJNSoj6F3jLw2phj8Aw3pfnNvL+y/pGN+aUu2afwYDPmt+
3HKlGtutFn/rK8XpjfWexbyaffjTKaSmZxuXkHcKak5lS4vXRww=
=cEwt
-----END PGP SIGNATURE-----

--cQXOx3fnlpmgJsTP--
