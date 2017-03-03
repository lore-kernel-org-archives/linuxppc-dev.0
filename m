Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vZJRS1T9FzDqHH
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Mar 2017 16:59:32 +1100 (AEDT)
Date: Fri, 3 Mar 2017 16:08:56 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH kernel v6 09/10] KVM: PPC: iommu: Unify TCE checking
Message-ID: <20170303050856.GI667@umbus.fritz.box>
References: <20170302085644.41828-1-aik@ozlabs.ru>
 <20170302085644.41828-10-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0NB0lE7sNnW8+0qW"
In-Reply-To: <20170302085644.41828-10-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--0NB0lE7sNnW8+0qW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 02, 2017 at 07:56:43PM +1100, Alexey Kardashevskiy wrote:
> This reworks helpers for checking TCE update parameters in way they
> can be used in KVM.
>=20
> This should cause no behavioral change.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> Changes:
> v6:
> * s/tce/gpa/ as TCE without permission bits is a GPA and this is what is
> passed everywhere
> ---
>  arch/powerpc/include/asm/iommu.h    | 20 +++++++++++++++-----
>  arch/powerpc/include/asm/kvm_ppc.h  |  6 ++++--
>  arch/powerpc/kernel/iommu.c         | 37 +++++++++++++------------------=
------
>  arch/powerpc/kvm/book3s_64_vio_hv.c | 31 +++++++------------------------
>  4 files changed, 39 insertions(+), 55 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/=
iommu.h
> index 82e77ebf85f4..1e6b03339a68 100644
> --- a/arch/powerpc/include/asm/iommu.h
> +++ b/arch/powerpc/include/asm/iommu.h
> @@ -296,11 +296,21 @@ static inline void iommu_restore(void)
>  #endif
> =20
>  /* The API to support IOMMU operations for VFIO */
> -extern int iommu_tce_clear_param_check(struct iommu_table *tbl,
> -		unsigned long ioba, unsigned long tce_value,
> -		unsigned long npages);
> -extern int iommu_tce_put_param_check(struct iommu_table *tbl,
> -		unsigned long ioba, unsigned long tce);
> +extern int iommu_tce_check_ioba(unsigned long page_shift,
> +		unsigned long offset, unsigned long size,
> +		unsigned long ioba, unsigned long npages);
> +extern int iommu_tce_check_gpa(unsigned long page_shift,
> +		unsigned long gpa);
> +
> +#define iommu_tce_clear_param_check(tbl, ioba, tce_value, npages) \
> +		(iommu_tce_check_ioba((tbl)->it_page_shift,       \
> +				(tbl)->it_offset, (tbl)->it_size, \
> +				(ioba), (npages)) || (tce_value))
> +#define iommu_tce_put_param_check(tbl, ioba, gpa)                 \
> +		(iommu_tce_check_ioba((tbl)->it_page_shift,       \
> +				(tbl)->it_offset, (tbl)->it_size, \
> +				(ioba), 1) ||                     \
> +		iommu_tce_check_gpa((tbl)->it_page_shift, (gpa)))
> =20
>  extern void iommu_flush_tce(struct iommu_table *tbl);
>  extern int iommu_take_ownership(struct iommu_table *tbl);
> diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/as=
m/kvm_ppc.h
> index eba8988d8443..72c2a155641f 100644
> --- a/arch/powerpc/include/asm/kvm_ppc.h
> +++ b/arch/powerpc/include/asm/kvm_ppc.h
> @@ -169,8 +169,10 @@ extern long kvm_vm_ioctl_create_spapr_tce(struct kvm=
 *kvm,
>  				struct kvm_create_spapr_tce_64 *args);
>  extern struct kvmppc_spapr_tce_table *kvmppc_find_table(
>  		struct kvm *kvm, unsigned long liobn);
> -extern long kvmppc_ioba_validate(struct kvmppc_spapr_tce_table *stt,
> -		unsigned long ioba, unsigned long npages);
> +#define kvmppc_ioba_validate(stt, ioba, npages)                         \
> +		(iommu_tce_check_ioba((stt)->page_shift, (stt)->offset, \
> +				(stt)->size, (ioba), (npages)) ?        \
> +				H_PARAMETER : H_SUCCESS)
>  extern long kvmppc_tce_validate(struct kvmppc_spapr_tce_table *tt,
>  		unsigned long tce);
>  extern long kvmppc_gpa_to_ua(struct kvm *kvm, unsigned long gpa,
> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> index d02b8d22fb50..4269f9f1623b 100644
> --- a/arch/powerpc/kernel/iommu.c
> +++ b/arch/powerpc/kernel/iommu.c
> @@ -960,47 +960,36 @@ void iommu_flush_tce(struct iommu_table *tbl)
>  }
>  EXPORT_SYMBOL_GPL(iommu_flush_tce);
> =20
> -int iommu_tce_clear_param_check(struct iommu_table *tbl,
> -		unsigned long ioba, unsigned long tce_value,
> -		unsigned long npages)
> +int iommu_tce_check_ioba(unsigned long page_shift,
> +		unsigned long offset, unsigned long size,
> +		unsigned long ioba, unsigned long npages)
>  {
> -	/* tbl->it_ops->clear() does not support any value but 0 */
> -	if (tce_value)
> -		return -EINVAL;
> +	unsigned long mask =3D (1UL << page_shift) - 1;
> =20
> -	if (ioba & ~IOMMU_PAGE_MASK(tbl))
> +	if (ioba & mask)
>  		return -EINVAL;
> =20
> -	ioba >>=3D tbl->it_page_shift;
> -	if (ioba < tbl->it_offset)
> +	ioba >>=3D page_shift;
> +	if (ioba < offset)
>  		return -EINVAL;
> =20
> -	if ((ioba + npages) > (tbl->it_offset + tbl->it_size))
> +	if ((ioba + 1) > (offset + size))
>  		return -EINVAL;
> =20
>  	return 0;
>  }
> -EXPORT_SYMBOL_GPL(iommu_tce_clear_param_check);
> +EXPORT_SYMBOL_GPL(iommu_tce_check_ioba);
> =20
> -int iommu_tce_put_param_check(struct iommu_table *tbl,
> -		unsigned long ioba, unsigned long tce)
> +int iommu_tce_check_gpa(unsigned long page_shift, unsigned long gpa)
>  {
> -	if (tce & ~IOMMU_PAGE_MASK(tbl))
> -		return -EINVAL;
> -
> -	if (ioba & ~IOMMU_PAGE_MASK(tbl))
> -		return -EINVAL;
> -
> -	ioba >>=3D tbl->it_page_shift;
> -	if (ioba < tbl->it_offset)
> -		return -EINVAL;
> +	unsigned long mask =3D (1UL << page_shift) - 1;
> =20
> -	if ((ioba + 1) > (tbl->it_offset + tbl->it_size))
> +	if (gpa & mask)
>  		return -EINVAL;
> =20
>  	return 0;
>  }
> -EXPORT_SYMBOL_GPL(iommu_tce_put_param_check);
> +EXPORT_SYMBOL_GPL(iommu_tce_check_gpa);
> =20
>  long iommu_tce_xchg(struct iommu_table *tbl, unsigned long entry,
>  		unsigned long *hpa, enum dma_data_direction *direction)
> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3=
s_64_vio_hv.c
> index 0f145fc7a3a5..440d3ab5dc32 100644
> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
> @@ -62,27 +62,6 @@ struct kvmppc_spapr_tce_table *kvmppc_find_table(struc=
t kvm *kvm,
>  EXPORT_SYMBOL_GPL(kvmppc_find_table);
> =20
>  /*
> - * Validates IO address.
> - *
> - * WARNING: This will be called in real-mode on HV KVM and virtual
> - *          mode on PR KVM
> - */
> -long kvmppc_ioba_validate(struct kvmppc_spapr_tce_table *stt,
> -		unsigned long ioba, unsigned long npages)
> -{
> -	unsigned long mask =3D (1ULL << stt->page_shift) - 1;
> -	unsigned long idx =3D ioba >> stt->page_shift;
> -
> -	if ((ioba & mask) || (idx < stt->offset) ||
> -			(idx - stt->offset + npages > stt->size) ||
> -			(idx + npages < idx))
> -		return H_PARAMETER;
> -
> -	return H_SUCCESS;
> -}
> -EXPORT_SYMBOL_GPL(kvmppc_ioba_validate);
> -
> -/*
>   * Validates TCE address.
>   * At the moment flags and page mask are validated.
>   * As the host kernel does not access those addresses (just puts them
> @@ -95,10 +74,14 @@ EXPORT_SYMBOL_GPL(kvmppc_ioba_validate);
>   */
>  long kvmppc_tce_validate(struct kvmppc_spapr_tce_table *stt, unsigned lo=
ng tce)
>  {
> -	unsigned long page_mask =3D ~((1ULL << stt->page_shift) - 1);
> -	unsigned long mask =3D ~(page_mask | TCE_PCI_WRITE | TCE_PCI_READ);
> +	unsigned long gpa =3D tce & ~(TCE_PCI_READ | TCE_PCI_WRITE);
> +	enum dma_data_direction dir =3D iommu_tce_direction(tce);
> =20
> -	if (tce & mask)
> +	/* Allow userspace to poison TCE table */
> +	if (dir =3D=3D DMA_NONE)
> +		return H_SUCCESS;
> +
> +	if (iommu_tce_check_gpa(stt->page_shift, gpa))
>  		return H_PARAMETER;
> =20
>  	return H_SUCCESS;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--0NB0lE7sNnW8+0qW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYuPpoAAoJEGw4ysog2bOSYt4P/3fO7gR5cvI6JhZEHGrGPcB3
6B+GxwT/T5SzKQjTm7iJm6bDL+KMmkYnuXENfRJG/TL4h8OCaUraYiNvZ8pD3NFk
u2V12SBzDQX9LdV+Azi0sDOhY9p4AGsjCg5+GuMwA7PNvopW29M9B5VSCwCd1eC6
HyJhldng/onasRvi7uuxqL50/c6qybPHJOL/blP1b05odoSRM1pLLnumxsihuYSP
RZMlfhh2HHnSjpdJwqroMlW6yleU+VKjKP0GF6KQWCM/midSNFLEnk+cVLesoMcY
oTd7mamFTyXN+QSbTqstYeQOEIzIDZ96we54bNZOQE+Q3A/ym9WHWGPYhLf7frRa
kv9Hukbf4rLhnmyKAEWajHK2d2gG0lm5bTe+9yuF9cf6V5g+9+jMI5EJfo841ij4
z9oGCMaZW25depwBo2h9YUlYpC1Io3tBmia53qoWvLi7yBDs4Re0zQsLI64cxB3d
vnqkUt+C86ylJIy7FDtGVE9xZqYXa6ik7JVpBj30Ib1GpCIl7HkavefqT/HLj1SX
6sE4qZQ431KuwSlDC1RBmhi8QFNkUUjo2xX3R/W0tocRF8nUrq/vv21OEhEgPvQA
n0mmK/VPts37ZXZ9O7+kiU8L+fbioOvaIOKvZeSdl3f2CV64mITWoNFCmc9ERWeS
nzrlJWbouV7mATHglsoc
=RiIV
-----END PGP SIGNATURE-----

--0NB0lE7sNnW8+0qW--
