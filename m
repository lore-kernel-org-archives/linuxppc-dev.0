Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46E341A006F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 10:45:15 +1100 (AEDT)
Date: Tue, 16 Feb 2016 09:59:46 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Alexander Graf <agraf@suse.com>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH kernel v3 6/7] KVM: PPC: Move reusable bits of H_PUT_TCE
 handler to helpers
Message-ID: <20160215225946.GA2269@voom.redhat.com>
References: <1455501309-47200-1-git-send-email-aik@ozlabs.ru>
 <1455501309-47200-7-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
In-Reply-To: <1455501309-47200-7-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 15, 2016 at 12:55:08PM +1100, Alexey Kardashevskiy wrote:
> Upcoming multi-tce support (H_PUT_TCE_INDIRECT/H_STUFF_TCE hypercalls)
> will validate TCE (not to have unexpected bits) and IO address
> (to be within the DMA window boundaries).
>=20
> This introduces helpers to validate TCE and IO address. The helpers are
> exported as they compile into vmlinux (to work in realmode) and will be
> used later by KVM kernel module in virtual mode.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>


> ---
> Changes:
> v3:
> * inverted @mask in kvmppc_tce_validate() to match the same variable in
> kvmppc_ioba_validate()
> * s/arithmetial/arithmetic/
> * s/should be enabled/would have to be enabled/
>=20
> v2:
> * added note to the commit log about why new helpers are exported
> * did not add a note that xxx_validate() validate TCEs for KVM (not for
> host kernel DMA) as the helper names and file location tell what are
> they for
> ---
>  arch/powerpc/include/asm/kvm_ppc.h  |  4 ++
>  arch/powerpc/kvm/book3s_64_vio_hv.c | 89 +++++++++++++++++++++++++++++++=
+-----
>  2 files changed, 83 insertions(+), 10 deletions(-)
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
> index 0ce4ffb..b608fdd 100644
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
> @@ -64,7 +65,7 @@ static struct kvmppc_spapr_tce_table *kvmppc_find_table=
(struct kvm_vcpu *vcpu,
>   * WARNING: This will be called in real-mode on HV KVM and virtual
>   *          mode on PR KVM
>   */
> -static long kvmppc_ioba_validate(struct kvmppc_spapr_tce_table *stt,
> +long kvmppc_ioba_validate(struct kvmppc_spapr_tce_table *stt,
>  		unsigned long ioba, unsigned long npages)
>  {
>  	unsigned long mask =3D (1ULL << IOMMU_PAGE_SHIFT_4K) - 1;
> @@ -76,6 +77,79 @@ static long kvmppc_ioba_validate(struct kvmppc_spapr_t=
ce_table *stt,
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
> +long kvmppc_tce_validate(struct kvmppc_spapr_tce_table *stt, unsigned lo=
ng tce)
> +{
> +	unsigned long mask =3D
> +			~(IOMMU_PAGE_MASK_4K | TCE_PCI_WRITE | TCE_PCI_READ);
> +
> +	if (tce & mask)
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
> + * which returns __va(PFN_PHYS(page_to_pfn(page))) which is arithmetic
> + * operation and does not access page struct.
> + *
> + * Theoretically page_address() could be defined different
> + * but either WANT_PAGE_VIRTUAL or HASHED_PAGE_VIRTUAL
> + * would have to be enabled.
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
> @@ -85,9 +159,6 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned =
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
> @@ -99,13 +170,11 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigne=
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

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWwlhiAAoJEGw4ysog2bOSiM0P/1cOMYz7YOGBqMWNhi4P86SC
lVZitqXWI0Rv1glOzcFsEV3LS0H5HsnSCWhkVtG0uRryPRAyweGQemyZybhRbKWQ
RjeXVxuLD5s0JwrBFpm/kTXV1XmQenHTJq105bPjGxBzj1wF6vti72rgbMedqpjP
6h71By5QdYeO2iVPJpTwx/NcZPTf+GFHXuXnmtIqyrwsayEe6R6WcbHJVWaDiWr1
0xD230zESDbTEkQ5tQyBVCbH+Tg3qkJ6JkJfi33A2OeGR8Z/Z1gdSufNIiy50NHw
JkSpc/BeWaWzbi+kvWQAal/f58i3G9Kag8/EVDK2q5LmnlPzm/m3Zr4ZZfq4eyyp
PmW0nv/R08+UNa7KiUezTP6HZe2Ji5ehgVrzx4IWRnlNljrfmfm3evdpQKmxdink
/BMoluvSxPQml1qkwuWYlhYOnZDSIE3IENW50iUF/h+9o7tW4pTltHJJnO2duFgE
TmAFUznabwK0JLsXDTTJvQ+rANuqU67kM48xxEA5OcASCfN/Oi5YmNIGq6k5oNEx
q8Hz0bh5DuiuOei5QqPeeNKRvD8KfzN24eD5Z4DJuROXnK34I66dsjyB3Eh1Yk1L
zcZVePRpE++Xm+/EP4jNTc6ATZr7uCpzrIE55WOOZndRZNSWWi/luO4LeODvX6GD
FWyT2Xynps0LFqQxXf12
=orYX
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
