Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 575F81A0C62
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jan 2016 11:43:11 +1100 (AEDT)
Date: Mon, 25 Jan 2016 11:12:36 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH kernel v2 5/6] KVM: PPC: Move reusable bits of H_PUT_TCE
 handler to helpers
Message-ID: <20160125001236.GD27454@voom.redhat.com>
References: <1453361977-19589-1-git-send-email-aik@ozlabs.ru>
 <1453361977-19589-6-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="6a4z/rxILaXg6B+u"
In-Reply-To: <1453361977-19589-6-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--6a4z/rxILaXg6B+u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 21, 2016 at 06:39:36PM +1100, Alexey Kardashevskiy wrote:
> Upcoming multi-tce support (H_PUT_TCE_INDIRECT/H_STUFF_TCE hypercalls)
> will validate TCE (not to have unexpected bits) and IO address
> (to be within the DMA window boundaries).
>=20
> This introduces helpers to validate TCE and IO address. The helpers are
> exported as they compile into vmlinux (to work in realmode) and will be
> used later by KVM kernel module in virtual mode.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> Changes:
> v2:
> * added note to the commit log about why new helpers are exported
> * did not add a note that xxx_validate() validate TCEs for KVM (not for
> host kernel DMA) as the helper names and file location tell what are
> they for
> ---
>  arch/powerpc/include/asm/kvm_ppc.h  |  4 ++
>  arch/powerpc/kvm/book3s_64_vio_hv.c | 92 +++++++++++++++++++++++++++++++=
+-----
>  2 files changed, 84 insertions(+), 12 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/as=
m/kvm_ppc.h
> index 2241d53..9513911 100644
> --- a/arch/powerpc/include/asm/kvm_ppc.h
> +++ b/arch/powerpc/include/asm/kvm_ppc.h
> @@ -166,6 +166,10 @@ extern int kvmppc_pseries_do_hcall(struct kvm_vcpu *=
vcpu);
> =20
>  extern long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>  				struct kvm_create_spapr_tce *args);
> +extern long kvmppc_ioba_validate(struct kvmppc_spapr_tce_table *stt,
> +		unsigned long ioba, unsigned long npages);
> +extern long kvmppc_tce_validate(struct kvmppc_spapr_tce_table *tt,
> +		unsigned long tce);
>  extern long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
>  			     unsigned long ioba, unsigned long tce);
>  extern long kvmppc_h_get_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3=
s_64_vio_hv.c
> index e142171..8cd3a95 100644
> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
> @@ -36,6 +36,7 @@
>  #include <asm/kvm_host.h>
>  #include <asm/udbg.h>
>  #include <asm/iommu.h>
> +#include <asm/tce.h>
> =20
>  #define TCES_PER_PAGE	(PAGE_SIZE / sizeof(u64))
> =20
> @@ -64,18 +65,90 @@ static struct kvmppc_spapr_tce_table *kvmppc_find_tab=
le(struct kvm_vcpu *vcpu,
>   * WARNING: This will be called in real-mode on HV KVM and virtual
>   *          mode on PR KVM
>   */
> -static long kvmppc_ioba_validate(struct kvmppc_spapr_tce_table *stt,
> +long kvmppc_ioba_validate(struct kvmppc_spapr_tce_table *stt,
>  		unsigned long ioba, unsigned long npages)
>  {
> -	unsigned long mask =3D (1ULL << IOMMU_PAGE_SHIFT_4K) - 1;
> +	unsigned long mask =3D IOMMU_PAGE_MASK_4K;
>  	unsigned long idx =3D ioba >> IOMMU_PAGE_SHIFT_4K;
>  	unsigned long size =3D stt->window_size >> IOMMU_PAGE_SHIFT_4K;
> =20
> -	if ((ioba & mask) || (idx + npages > size))
> +	if ((ioba & ~mask) || (idx + npages > size))
>  		return H_PARAMETER;
> =20
>  	return H_SUCCESS;
>  }
> +EXPORT_SYMBOL_GPL(kvmppc_ioba_validate);
> +
> +/*
> + * Validates TCE address.
> + * At the moment flags and page mask are validated.
> + * As the host kernel does not access those addresses (just puts them
> + * to the table and user space is supposed to process them), we can skip
> + * checking other things (such as TCE is a guest RAM address or the page
> + * was actually allocated).
> + *
> + * WARNING: This will be called in real-mode on HV KVM and virtual
> + *          mode on PR KVM
> + */
> +long kvmppc_tce_validate(struct kvmppc_spapr_tce_table *stt,
>  unsigned long tce)

It would be nice to write this in terms of kvmppc_ioba_validate() above.

> +{
> +	unsigned long mask =3D IOMMU_PAGE_MASK_4K | TCE_PCI_WRITE | TCE_PCI_REA=
D;
> +
> +	if (tce & ~mask)
> +		return H_PARAMETER;
> +
> +	return H_SUCCESS;
> +}
> +EXPORT_SYMBOL_GPL(kvmppc_tce_validate);
> +
> +/* Note on the use of page_address() in real mode,
> + *
> + * It is safe to use page_address() in real mode on ppc64 because
> + * page_address() is always defined as lowmem_page_address()
> + * which returns __va(PFN_PHYS(page_to_pfn(page))) which is arithmetial
> + * operation and does not access page struct.
> + *
> + * Theoretically page_address() could be defined different
> + * but either WANT_PAGE_VIRTUAL or HASHED_PAGE_VIRTUAL
> + * should be enabled.
> + * WANT_PAGE_VIRTUAL is never enabled on ppc32/ppc64,
> + * HASHED_PAGE_VIRTUAL could be enabled for ppc32 only and only
> + * if CONFIG_HIGHMEM is defined. As CONFIG_SPARSEMEM_VMEMMAP
> + * is not expected to be enabled on ppc32, page_address()
> + * is safe for ppc32 as well.
> + *
> + * WARNING: This will be called in real-mode on HV KVM and virtual
> + *          mode on PR KVM
> + */
> +static u64 *kvmppc_page_address(struct page *page)
> +{
> +#if defined(HASHED_PAGE_VIRTUAL) || defined(WANT_PAGE_VIRTUAL)
> +#error TODO: fix to avoid page_address() here
> +#endif
> +	return (u64 *) page_address(page);
> +}
> +
> +/*
> + * Handles TCE requests for emulated devices.
> + * Puts guest TCE values to the table and expects user space to convert =
them.
> + * Called in both real and virtual modes.
> + * Cannot fail so kvmppc_tce_validate must be called before it.
> + *
> + * WARNING: This will be called in real-mode on HV KVM and virtual
> + *          mode on PR KVM
> + */
> +void kvmppc_tce_put(struct kvmppc_spapr_tce_table *stt,
> +		unsigned long idx, unsigned long tce)
> +{
> +	struct page *page;
> +	u64 *tbl;
> +
> +	page =3D stt->pages[idx / TCES_PER_PAGE];
> +	tbl =3D kvmppc_page_address(page);
> +
> +	tbl[idx % TCES_PER_PAGE] =3D tce;
> +}
> +EXPORT_SYMBOL_GPL(kvmppc_tce_put);
> =20
>  /* WARNING: This will be called in real-mode on HV KVM and virtual
>   *          mode on PR KVM
> @@ -85,9 +158,6 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned =
long liobn,
>  {
>  	struct kvmppc_spapr_tce_table *stt =3D kvmppc_find_table(vcpu, liobn);
>  	long ret;
> -	unsigned long idx;
> -	struct page *page;
> -	u64 *tbl;
> =20
>  	/* udbg_printf("H_PUT_TCE(): liobn=3D0x%lx ioba=3D0x%lx, tce=3D0x%lx\n"=
, */
>  	/* 	    liobn, ioba, tce); */
> @@ -99,13 +169,11 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigne=
d long liobn,
>  	if (ret !=3D H_SUCCESS)
>  		return ret;
> =20
> -	idx =3D ioba >> IOMMU_PAGE_SHIFT_4K;
> -	page =3D stt->pages[idx / TCES_PER_PAGE];
> -	tbl =3D (u64 *)page_address(page);
> +	ret =3D kvmppc_tce_validate(stt, tce);
> +	if (ret !=3D H_SUCCESS)
> +		return ret;
> =20
> -	/* FIXME: Need to validate the TCE itself */
> -	/* udbg_printf("tce @ %p\n", &tbl[idx % TCES_PER_PAGE]); */
> -	tbl[idx % TCES_PER_PAGE] =3D tce;
> +	kvmppc_tce_put(stt, ioba >> IOMMU_PAGE_SHIFT_4K, tce);
> =20
>  	return H_SUCCESS;
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6a4z/rxILaXg6B+u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWpWhzAAoJEGw4ysog2bOSAtgP/joCtbedocheT1dxXy1mA3DE
CnsoZkM1xqEv1+vQ4opCtrgqlAjNsO4XOWtE87CzMPL/2hf4GNKalCz/UE4c4g4N
eD+FTNdz7gEJkTH3zqXHjZ3AS1UBN8uwZOcZADkFAjAQfmxDqhKEFRZpeFbWD798
IisZ/2dCuoJFKphLkAta0HSpXtG6j5WdvXj6fwX1qt8ePmw4YMyeY4L9TTR9nbKL
Rn7iHv3sYseHKhQG2vuxRt9ot1xNs7pMLXJac2GuOIQEM4BVqW5oaKrulmN5k8hL
awfbyiUwWOMIkhxFoyTS0QaRJupqiCm49dx7H057+gdueg5xwRxGtjvPEE7zF0QR
c4YhGsRonSAc4fGtD7UfpxMpHpcxNSZqBFcKkEsOGmXW+TRlOiweSBwpSeZN3Uiu
I47A7YOec7W3j5VHkCOrmz7cNgEjZhHfxNy24Cf95Q5ybNQ6jigLmDdS6wY059NX
QlaOmq4lNNUEiffU2h3OLoMDQqV+nr+YFdjHhjxcdh9IRPsfGY5KNCwHiS47XBtC
8/4peKV5CGUJmivBk8u08c0J7bAFKRnHBZ6PlXoJvdshnxH2n9J3FSa+CF56MN24
4O9qVhcOkojOEE0Th0LVQNylCMfysK14fRgk8zjttvL4QtqXxWRX1g3LvU3PmIWO
AhYyZYT04EFKzW/6yb7W
=zAum
-----END PGP SIGNATURE-----

--6a4z/rxILaXg6B+u--
