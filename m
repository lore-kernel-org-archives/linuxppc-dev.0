Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EEB1F1A0D1D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 16:21:28 +1100 (AEDT)
Date: Mon, 15 Feb 2016 14:53:43 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Alexander Graf <agraf@suse.com>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH kernel v3 2/7] KVM: PPC: Rework H_PUT_TCE/H_GET_TCE
 handlers
Message-ID: <20160215035343.GU2732@voom.fritz.box>
References: <1455501309-47200-1-git-send-email-aik@ozlabs.ru>
 <1455501309-47200-3-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="TPGKQYD3WP7vMswh"
In-Reply-To: <1455501309-47200-3-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--TPGKQYD3WP7vMswh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 15, 2016 at 12:55:04PM +1100, Alexey Kardashevskiy wrote:
> This reworks the existing H_PUT_TCE/H_GET_TCE handlers to have following
> patches applied nicer.
>=20
> This moves the ioba boundaries check to a helper and adds a check for
> least bits which have to be zeros.
>=20
> The patch is pretty mechanical (only check for least ioba bits is added)
> so no change in behaviour is expected.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> Changelog:
> v3:
> * moved list_for_each_entry_lockless() to the next patch
> * added overflow check in kvmppc_ioba_validate() as H_STUFF_TCE handles
> more than just 512 TCEs at once
>=20
> v2:
> * compare @ret with H_SUCCESS instead of assuming H_SUCCESS is zero
> * made error reporting cleaner
> ---
>  arch/powerpc/kvm/book3s_64_vio_hv.c | 109 +++++++++++++++++++++++-------=
------
>  1 file changed, 71 insertions(+), 38 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3=
s_64_vio_hv.c
> index 89e96b3..f29ba2c 100644
> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
> @@ -35,71 +35,104 @@
>  #include <asm/ppc-opcode.h>
>  #include <asm/kvm_host.h>
>  #include <asm/udbg.h>
> +#include <asm/iommu.h>
> =20
>  #define TCES_PER_PAGE	(PAGE_SIZE / sizeof(u64))
> =20
> +/*
> + * Finds a TCE table descriptor by LIOBN.
> + *
> + * WARNING: This will be called in real or virtual mode on HV KVM and vi=
rtual
> + *          mode on PR KVM
> + */
> +static struct kvmppc_spapr_tce_table *kvmppc_find_table(struct kvm_vcpu =
*vcpu,
> +		unsigned long liobn)
> +{
> +	struct kvm *kvm =3D vcpu->kvm;
> +	struct kvmppc_spapr_tce_table *stt;
> +
> +	list_for_each_entry(stt, &kvm->arch.spapr_tce_tables, list)
> +		if (stt->liobn =3D=3D liobn)
> +			return stt;
> +
> +	return NULL;
> +}
> +
> +/*
> + * Validates IO address.
> + *
> + * WARNING: This will be called in real-mode on HV KVM and virtual
> + *          mode on PR KVM
> + */
> +static long kvmppc_ioba_validate(struct kvmppc_spapr_tce_table *stt,
> +		unsigned long ioba, unsigned long npages)
> +{
> +	unsigned long mask =3D (1ULL << IOMMU_PAGE_SHIFT_4K) - 1;
> +	unsigned long idx =3D ioba >> IOMMU_PAGE_SHIFT_4K;
> +	unsigned long size =3D stt->window_size >> IOMMU_PAGE_SHIFT_4K;
> +
> +	if ((ioba & mask) || (idx + npages > size) || (idx + npages < idx))
> +		return H_PARAMETER;
> +
> +	return H_SUCCESS;
> +}
> +
>  /* WARNING: This will be called in real-mode on HV KVM and virtual
>   *          mode on PR KVM
>   */
>  long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
>  		      unsigned long ioba, unsigned long tce)
>  {
> -	struct kvm *kvm =3D vcpu->kvm;
> -	struct kvmppc_spapr_tce_table *stt;
> +	struct kvmppc_spapr_tce_table *stt =3D kvmppc_find_table(vcpu, liobn);
> +	long ret;
> +	unsigned long idx;
> +	struct page *page;
> +	u64 *tbl;
> =20
>  	/* udbg_printf("H_PUT_TCE(): liobn=3D0x%lx ioba=3D0x%lx, tce=3D0x%lx\n"=
, */
>  	/* 	    liobn, ioba, tce); */
> =20
> -	list_for_each_entry(stt, &kvm->arch.spapr_tce_tables, list) {
> -		if (stt->liobn =3D=3D liobn) {
> -			unsigned long idx =3D ioba >> SPAPR_TCE_SHIFT;
> -			struct page *page;
> -			u64 *tbl;
> +	if (!stt)
> +		return H_TOO_HARD;
> =20
> -			/* udbg_printf("H_PUT_TCE: liobn 0x%lx =3D> stt=3D%p  window_size=3D0=
x%x\n", */
> -			/* 	    liobn, stt, stt->window_size); */
> -			if (ioba >=3D stt->window_size)
> -				return H_PARAMETER;
> +	ret =3D kvmppc_ioba_validate(stt, ioba, 1);
> +	if (ret !=3D H_SUCCESS)
> +		return ret;
> =20
> -			page =3D stt->pages[idx / TCES_PER_PAGE];
> -			tbl =3D (u64 *)page_address(page);
> +	idx =3D ioba >> SPAPR_TCE_SHIFT;
> +	page =3D stt->pages[idx / TCES_PER_PAGE];
> +	tbl =3D (u64 *)page_address(page);
> =20
> -			/* FIXME: Need to validate the TCE itself */
> -			/* udbg_printf("tce @ %p\n", &tbl[idx % TCES_PER_PAGE]); */
> -			tbl[idx % TCES_PER_PAGE] =3D tce;
> -			return H_SUCCESS;
> -		}
> -	}
> +	/* FIXME: Need to validate the TCE itself */
> +	/* udbg_printf("tce @ %p\n", &tbl[idx % TCES_PER_PAGE]); */
> +	tbl[idx % TCES_PER_PAGE] =3D tce;
> =20
> -	/* Didn't find the liobn, punt it to userspace */
> -	return H_TOO_HARD;
> +	return H_SUCCESS;
>  }
>  EXPORT_SYMBOL_GPL(kvmppc_h_put_tce);
> =20
>  long kvmppc_h_get_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
>  		      unsigned long ioba)
>  {
> -	struct kvm *kvm =3D vcpu->kvm;
> -	struct kvmppc_spapr_tce_table *stt;
> +	struct kvmppc_spapr_tce_table *stt =3D kvmppc_find_table(vcpu, liobn);
> +	long ret;
> +	unsigned long idx;
> +	struct page *page;
> +	u64 *tbl;
> =20
> -	list_for_each_entry(stt, &kvm->arch.spapr_tce_tables, list) {
> -		if (stt->liobn =3D=3D liobn) {
> -			unsigned long idx =3D ioba >> SPAPR_TCE_SHIFT;
> -			struct page *page;
> -			u64 *tbl;
> +	if (!stt)
> +		return H_TOO_HARD;
> =20
> -			if (ioba >=3D stt->window_size)
> -				return H_PARAMETER;
> +	ret =3D kvmppc_ioba_validate(stt, ioba, 1);
> +	if (ret !=3D H_SUCCESS)
> +		return ret;
> =20
> -			page =3D stt->pages[idx / TCES_PER_PAGE];
> -			tbl =3D (u64 *)page_address(page);
> +	idx =3D ioba >> SPAPR_TCE_SHIFT;
> +	page =3D stt->pages[idx / TCES_PER_PAGE];
> +	tbl =3D (u64 *)page_address(page);
> =20
> -			vcpu->arch.gpr[4] =3D tbl[idx % TCES_PER_PAGE];
> -			return H_SUCCESS;
> -		}
> -	}
> +	vcpu->arch.gpr[4] =3D tbl[idx % TCES_PER_PAGE];
> =20
> -	/* Didn't find the liobn, punt it to userspace */
> -	return H_TOO_HARD;
> +	return H_SUCCESS;
>  }
>  EXPORT_SYMBOL_GPL(kvmppc_h_get_tce);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--TPGKQYD3WP7vMswh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWwUvHAAoJEGw4ysog2bOSz/cQAJ9Wuz8CiW9nmsFtDnt7mmLF
whJ6aCzt8gLikmls1fFkZIxyvPY3VQLgaaOnr9LrhlSx5F2O8HxNg13w7YIyC+jQ
uV6XX8trMGwVkSaI11+UA034BpJXY0NNXhb0d77qJcQms65oM90fCw2iGBUK3xG9
jMNiGspj5GqBVN+brGI/mPY3SyXY2AEVU/5YWZMDWu+ELcckqer+pPydK5UFWbyo
vyWOSXpEokIDJJtEAR2i4pVu+c6sijJ0R0lZyQXnkBmkR+RG6BS8JCe39c28NsxL
Ye7jHhT2sxswlvcior9L5cvsY8X4VE+zRKG/6kvrlgJVL5Mv7AhHOmKCYkdHXHMA
dM6c5BR17cP3gXVLP9K7pVDBF4gCSbWpxa81Ko1BKUCze3JqWyi27tmjp2L+o1mp
KvfpXCuGGKObmcG9IMLgTQmWLxD0cYgpUBO9a3csUy2FH6IIS22GnoSa7XD/PfvV
3KV10DYhmdXD4+MLdTbG8gxezDZC4ZF8HHUw9q0nX4iBhddq29N4FEvFkCYAsGiY
foSI+9EDPZY5jj8AeQAONsp132bZVEKwXipHa2YX++WMxT06bktyzb5BnTU9IKLc
JWSdaGGgUpgLtQ3xjE8wh4vwJJD50Ogz31G0dC0mf9xireilZ79X3t4A0vgh+3P3
MIv5FjzTecxOMfjZFXbd
=csTm
-----END PGP SIGNATURE-----

--TPGKQYD3WP7vMswh--
