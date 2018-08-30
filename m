Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42184y2ZbzzF36b
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Aug 2018 14:04:18 +1000 (AEST)
Date: Thu, 30 Aug 2018 14:03:22 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH kernel 3/4] KVM: PPC: Validate TCEs against preregistered
 memory page sizes
Message-ID: <20180830040322.GI2222@umbus.fritz.box>
References: <20180830031647.34134-1-aik@ozlabs.ru>
 <20180830031647.34134-4-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+ZmrHH5cGjskQnY1"
In-Reply-To: <20180830031647.34134-4-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--+ZmrHH5cGjskQnY1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 30, 2018 at 01:16:46PM +1000, Alexey Kardashevskiy wrote:
> The userspace can request an arbitrary supported page size for a DMA
> window and this works fine as long as the mapped memory is backed with
> the pages of the same or bigger size; if this is not the case,
> mm_iommu_ua_to_hpa{_rm}() fail and tables do not populated with
> dangerously incorrect TCEs.
>=20
> However since it is quite easy to misconfigure the KVM and we do not do
> reverts to all changes made to TCE tables if an error happens in a middle,
> we better do the acceptable page size validation before we even touch
> the tables.
>=20
> This enhances kvmppc_tce_validate() to check the hardware IOMMU page sizes
> against the preregistered memory page sizes.
>=20
> Since the new check uses real/virtual mode helpers, this renames
> kvmppc_tce_validate() to kvmppc_rm_tce_validate() to handle the real mode
> case and mirrors it for the virtual mode under the old name. The real
> mode handler is not used for the virtual mode as:
> 1. it uses _lockless() list traversing primitives instead of RCU;
> 2. realmode's mm_iommu_ua_to_hpa_rm() uses vmalloc_to_phys() which
> virtual mode does not have to use and since on POWER9+radix only virtual
> mode handlers actually work, we do not want to slow down that path even
> a bit.
>=20
> This removes EXPORT_SYMBOL_GPL(kvmppc_tce_validate) as the validators
> are static now.
>=20
> >From now on the attempts on mapping IOMMU pages bigger than allowed will
> result in KVM exit.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/include/asm/kvm_ppc.h  |  2 --
>  arch/powerpc/kvm/book3s_64_vio.c    | 42 +++++++++++++++++++++++++++++++=
++++++
>  arch/powerpc/kvm/book3s_64_vio_hv.c | 30 +++++++++++++++++++-------
>  3 files changed, 65 insertions(+), 9 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/as=
m/kvm_ppc.h
> index e991821..2f5d431 100644
> --- a/arch/powerpc/include/asm/kvm_ppc.h
> +++ b/arch/powerpc/include/asm/kvm_ppc.h
> @@ -194,8 +194,6 @@ extern struct kvmppc_spapr_tce_table *kvmppc_find_tab=
le(
>  		(iommu_tce_check_ioba((stt)->page_shift, (stt)->offset, \
>  				(stt)->size, (ioba), (npages)) ?        \
>  				H_PARAMETER : H_SUCCESS)
> -extern long kvmppc_tce_validate(struct kvmppc_spapr_tce_table *tt,
> -		unsigned long tce);
>  extern long kvmppc_gpa_to_ua(struct kvm *kvm, unsigned long gpa,
>  		unsigned long *ua, unsigned long **prmap);
>  extern void kvmppc_tce_put(struct kvmppc_spapr_tce_table *tt,
> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_6=
4_vio.c
> index 3e8ac98..5cd2a66 100644
> --- a/arch/powerpc/kvm/book3s_64_vio.c
> +++ b/arch/powerpc/kvm/book3s_64_vio.c
> @@ -363,6 +363,41 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>  	return ret;
>  }
> =20
> +static long kvmppc_tce_validate(struct kvmppc_spapr_tce_table *stt,
> +		unsigned long tce)
> +{
> +	unsigned long gpa =3D tce & ~(TCE_PCI_READ | TCE_PCI_WRITE);
> +	enum dma_data_direction dir =3D iommu_tce_direction(tce);
> +	struct kvmppc_spapr_tce_iommu_table *stit;
> +	unsigned long ua =3D 0;
> +
> +	/* Allow userspace to poison TCE table */
> +	if (dir =3D=3D DMA_NONE)
> +		return H_SUCCESS;
> +
> +	if (iommu_tce_check_gpa(stt->page_shift, gpa))
> +		return H_TOO_HARD;
> +
> +	if (kvmppc_gpa_to_ua(stt->kvm, tce & ~(TCE_PCI_READ | TCE_PCI_WRITE),
> +				&ua, NULL))
> +		return H_TOO_HARD;
> +
> +	list_for_each_entry_rcu(stit, &stt->iommu_tables, next) {
> +		unsigned long hpa =3D 0;
> +		struct mm_iommu_table_group_mem_t *mem;
> +		long shift =3D stit->tbl->it_page_shift;
> +
> +		mem =3D mm_iommu_lookup(stt->kvm->mm, ua, 1ULL << shift);
> +		if (!mem)
> +			return H_TOO_HARD;
> +
> +		if (mm_iommu_ua_to_hpa(mem, ua, shift, &hpa))
> +			return H_TOO_HARD;
> +	}
> +
> +	return H_SUCCESS;
> +}
> +
>  static void kvmppc_clear_tce(struct iommu_table *tbl, unsigned long entr=
y)
>  {
>  	unsigned long hpa =3D 0;
> @@ -602,6 +637,13 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
>  	}
> =20
>  	for (i =3D 0; i < npages; ++i) {
> +		/*
> +		 * This get_user() may produce a different result than few
> +		 * lines in the validation loop above but we translate it
> +		 * again little later anyway and if that fails, we simply stop
> +		 * and return error as it is likely the userspace shooting
> +		 * itself in a foot.
> +		 */
>  		if (get_user(tce, tces + i)) {
>  			ret =3D H_TOO_HARD;
>  			goto unlock_exit;
> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3=
s_64_vio_hv.c
> index 9584d9b..e79ffbb 100644
> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
> @@ -94,14 +94,14 @@ EXPORT_SYMBOL_GPL(kvmppc_find_table);
>   * to the table and user space is supposed to process them), we can skip
>   * checking other things (such as TCE is a guest RAM address or the page
>   * was actually allocated).
> - *
> - * WARNING: This will be called in real-mode on HV KVM and virtual
> - *          mode on PR KVM
>   */
> -long kvmppc_tce_validate(struct kvmppc_spapr_tce_table *stt, unsigned lo=
ng tce)
> +static long kvmppc_rm_tce_validate(struct kvmppc_spapr_tce_table *stt,
> +		unsigned long tce)
>  {
>  	unsigned long gpa =3D tce & ~(TCE_PCI_READ | TCE_PCI_WRITE);
>  	enum dma_data_direction dir =3D iommu_tce_direction(tce);
> +	struct kvmppc_spapr_tce_iommu_table *stit;
> +	unsigned long ua =3D 0;
> =20
>  	/* Allow userspace to poison TCE table */
>  	if (dir =3D=3D DMA_NONE)
> @@ -110,9 +110,25 @@ long kvmppc_tce_validate(struct kvmppc_spapr_tce_tab=
le *stt, unsigned long tce)
>  	if (iommu_tce_check_gpa(stt->page_shift, gpa))
>  		return H_PARAMETER;
> =20
> +	if (kvmppc_gpa_to_ua(stt->kvm, tce & ~(TCE_PCI_READ | TCE_PCI_WRITE),
> +				&ua, NULL))
> +		return H_TOO_HARD;
> +
> +	list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
> +		unsigned long hpa =3D 0;
> +		struct mm_iommu_table_group_mem_t *mem;
> +		long shift =3D stit->tbl->it_page_shift;
> +
> +		mem =3D mm_iommu_lookup_rm(stt->kvm->mm, ua, 1ULL << shift);
> +		if (!mem)
> +			return H_TOO_HARD;
> +
> +		if (mm_iommu_ua_to_hpa_rm(mem, ua, shift, &hpa))
> +			return H_TOO_HARD;
> +	}
> +
>  	return H_SUCCESS;
>  }
> -EXPORT_SYMBOL_GPL(kvmppc_tce_validate);
> =20
>  /* Note on the use of page_address() in real mode,
>   *
> @@ -345,7 +361,7 @@ long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, unsig=
ned long liobn,
>  	if (ret !=3D H_SUCCESS)
>  		return ret;
> =20
> -	ret =3D kvmppc_tce_validate(stt, tce);
> +	ret =3D kvmppc_rm_tce_validate(stt, tce);
>  	if (ret !=3D H_SUCCESS)
>  		return ret;
> =20
> @@ -498,7 +514,7 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vc=
pu,
>  	for (i =3D 0; i < npages; ++i) {
>  		unsigned long tce =3D be64_to_cpu(((u64 *)tces)[i]);
> =20
> -		ret =3D kvmppc_tce_validate(stt, tce);
> +		ret =3D kvmppc_rm_tce_validate(stt, tce);
>  		if (ret !=3D H_SUCCESS)
>  			goto unlock_exit;
>  	}

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--+ZmrHH5cGjskQnY1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAluHbIoACgkQbDjKyiDZ
s5L1QA//WP4Ny1gBnbdqcY+TCwhJap3wLi+v2CzwPGKKU4gmWHgjEJkDOUdpQsNG
qgqZe0UNefASuhGiDPsJ8yLv/xoZSCS4A4U3uaLEDhF7gG0WOOBhso39lJHgQpoi
t5D4d49qchVFSi2S8FLbFgMKR6ZroaJtMYDrMQH7A1U/b5Yr/b9Tn+5QCnc9cZjs
9VtOhVJHKjlRCtBw+PWrkS6MRaciiy4sbrMjsaVl/LU9WfHIVM4ueYTJB8POvL2i
fRcO6L1rMyop7kCPsjuVCm6qRtwkIMDjTa/hyn+hxrsYxKnHOVvBkSHQRLQK20NE
8N6+JLSey/pLubSjuz6m67758Mx9A9Wjleik4BaOBji1QPgNrBEKuYxedt994/JV
T5IrFI0nNfN4NQcHpTn3YHG4sqCJgPVC9L9wa1LWxky/91TarnLpk9CO15iSHDug
ffj65ZD6JT919NBsb5p9Ka/9bAc9UqdW1EqcqxnhFEIjEBLX77oPC69xzkAL2mNL
eiitAE03m/BTcLGga54kQJnjJYYG7R8DrQHTbe9F/eXRhsvF+cevtcyucXiDodpz
3eG/cSQVgP+wMOCumpeZ0VJRzyONgmwA9A+GwkTh3oP5QArypnMbTVCgsaUBtdwm
LYBo44afK8dlxeDp9GxayPDokbzNrNBbBnfQGs5C3dyq3wKaA5k=
=jfVV
-----END PGP SIGNATURE-----

--+ZmrHH5cGjskQnY1--
