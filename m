Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 94A911A0F1E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Dec 2015 13:45:05 +1100 (AEDT)
Date: Tue, 8 Dec 2015 13:18:04 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Alexander Graf <agraf@suse.com>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH kernel 3/9] KVM: PPC: Rework H_PUT_TCE/H_GET_TCE handlers
Message-ID: <20151208021804.GI20139@voom.fritz.box>
References: <1442314179-9706-1-git-send-email-aik@ozlabs.ru>
 <1442314179-9706-4-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Li7ckgedzMh1NgdW"
In-Reply-To: <1442314179-9706-4-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Li7ckgedzMh1NgdW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2015 at 08:49:33PM +1000, Alexey Kardashevskiy wrote:
> This reworks the existing H_PUT_TCE/H_GET_TCE handlers to have one
> exit path. This allows next patch to add locks nicely.

I don't see a problem with the actual code, but it doesn't seem to
match this description: I still see multiple return statements for
h_put_tce at least.

> This moves the ioba boundaries check to a helper and adds a check for
> least bits which have to be zeros.
>=20
> The patch is pretty mechanical (only check for least ioba bits is added)
> so no change in behaviour is expected.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  arch/powerpc/kvm/book3s_64_vio_hv.c | 102 +++++++++++++++++++++++-------=
------
>  1 file changed, 66 insertions(+), 36 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3=
s_64_vio_hv.c
> index 89e96b3..8ae12ac 100644
> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
> @@ -35,71 +35,101 @@
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
> +	list_for_each_entry_rcu_notrace(stt, &kvm->arch.spapr_tce_tables, list)
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
> +	if ((ioba & mask) || (size + npages <=3D idx))
> +		return H_PARAMETER;

Not sure if it's worth a check for overflow in (size+npages) there.

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
> +	long ret =3D H_TOO_HARD;
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
> +		return ret;
> =20
> -			/* udbg_printf("H_PUT_TCE: liobn 0x%lx =3D> stt=3D%p  window_size=3D0=
x%x\n", */
> -			/* 	    liobn, stt, stt->window_size); */
> -			if (ioba >=3D stt->window_size)
> -				return H_PARAMETER;
> +	ret =3D kvmppc_ioba_validate(stt, ioba, 1);
> +	if (ret)
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
> +	return ret;

So, this relies on the fact that kvmppc_ioba_validate() would have
returned H_SUCCESS some distance above.  This seems rather fragile if
you insert anything else which alters ret in between.  Since this is
the success path, I think it's clearer to explicitly return H_SUCCESS.

>  }
>  EXPORT_SYMBOL_GPL(kvmppc_h_put_tce);
> =20
>  long kvmppc_h_get_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
>  		      unsigned long ioba)
>  {
> -	struct kvm *kvm =3D vcpu->kvm;
> -	struct kvmppc_spapr_tce_table *stt;
> +	struct kvmppc_spapr_tce_table *stt =3D kvmppc_find_table(vcpu, liobn);
> +	long ret =3D H_TOO_HARD;
> =20
> -	list_for_each_entry(stt, &kvm->arch.spapr_tce_tables, list) {
> -		if (stt->liobn =3D=3D liobn) {
> +
> +	if (stt) {
> +		ret =3D kvmppc_ioba_validate(stt, ioba, 1);
> +		if (!ret) {

This relies on the fact that H_SUCCESS =3D=3D 0, I'm not sure if that's
something we're already doing elsewhere or not.


>  			unsigned long idx =3D ioba >> SPAPR_TCE_SHIFT;
> -			struct page *page;
> -			u64 *tbl;
> -
> -			if (ioba >=3D stt->window_size)
> -				return H_PARAMETER;
> -
> -			page =3D stt->pages[idx / TCES_PER_PAGE];
> -			tbl =3D (u64 *)page_address(page);
> +			struct page *page =3D stt->pages[idx / TCES_PER_PAGE];
> +			u64 *tbl =3D (u64 *)page_address(page);
> =20
>  			vcpu->arch.gpr[4] =3D tbl[idx % TCES_PER_PAGE];
> -			return H_SUCCESS;
>  		}
>  	}
> =20
> -	/* Didn't find the liobn, punt it to userspace */
> -	return H_TOO_HARD;
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(kvmppc_h_get_tce);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Li7ckgedzMh1NgdW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWZj3bAAoJEGw4ysog2bOSrcUQAJif76EcOYC/mFjsDlJI3K7T
J92GGSjC0f5fD9Apj3aK1lG9GJsEusC/kGlAaJn21Sq8WN8Rg86nnLv8fshrPayy
d0jYWKGqzIZUPPhgIz4lo52goSYMkBnQxERisMMdh1lvmBBP1cy+uFubOuegEk1M
XgNoLn5mUI+NQuSYAi4PTvHVIUbE8RgN4w5v3UC0cwnVXB74cGUZ/WuLc6WSZdfY
QRtOC8+UH9hZKDUdrtBzj8FKzEjZFlVqEwSMkTW05An1lOkpbmAaxOEvfY/HK9cE
IrvQAEnyJs+cSoozNPVt4lglsFKr0E5QhOWrMb+AnOvY3vbxJMTb/Od1bLarqDVI
Km9VHIg00nPPsvGnX1gsry/5e1vTrEFtk5flT49Phhva8RI6KP/fserIov8Wu+s2
C7S/cFrCWSE8bp/4pFLiJFuVTtj+q4IbVQj3R1jOCMGRmFrlp61LnahuC2d6F1vo
ZslHqQZJB7whRz81fThu7e0zQHDzS6Edmnkr9lEwd3HThh1lZYqx0LC5Orc5rlkW
mXrHFjFbBNB4W8ZucYdQoWW8TmVBZFrKFg0EDckevOMFkp2sv2eML/g6mWVoXsLS
86jJ5AcC6WjYKW1EkItUKoPhd07J7/JEmdByfuerw0fWbHu1EGwYyo1wNifPWBSG
hfR6q6aTaQYHEURFz20e
=weyc
-----END PGP SIGNATURE-----

--Li7ckgedzMh1NgdW--
