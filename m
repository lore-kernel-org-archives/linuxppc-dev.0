Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ynNzT70VFzDr4S
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Nov 2017 15:03:01 +1100 (AEDT)
Date: Thu, 30 Nov 2017 14:45:58 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Serhii Popovych <spopovyc@redhat.com>
Cc: linux-kernel@vger.kernel.org, michael@ellerman.id.au, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH 2/4] KVM: PPC: Book3S HV: Improve
 kvmppc_allocate_hpt()/kvmppc_free_hpt()
Message-ID: <20171130034558.GP3023@umbus.fritz.box>
References: <1511973506-65683-1-git-send-email-spopovyc@redhat.com>
 <1511973506-65683-3-git-send-email-spopovyc@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xNm6VWMD3PcA105u"
In-Reply-To: <1511973506-65683-3-git-send-email-spopovyc@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--xNm6VWMD3PcA105u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2017 at 11:38:24AM -0500, Serhii Popovych wrote:
> There are several points of improvements:
>=20
>   1) Make kvmppc_free_hpt() check if allocation is made before attempt
>      to release. This follows kfree(p) semantics where p =3D=3D NULL.
>=20
>   2) Return initialized @info parameter from kvmppc_allocate_hpt()
>      even if allocation fails.
>=20
>      This allows to use kvmppc_free_hpt() in the caller without
>      checking that preceded kvmppc_allocate_hpt() was successful
>=20
>          p =3D kmalloc(size, gfp);
>          kfree(p);
>=20
>      which is correct for both p !=3D NULL and p =3D=3D NULL. Followup
>      change will rely on this behaviour.
>=20
>   3) Better code reuse: kvmppc_free_hpt() can be reused on error
>      path in kvmppc_allocate_hpt() to avoid code duplication.
>=20
>   4) No need to check for !hpt if allocated from CMA: neither
>      pfn_to_kaddr() nor page_to_pfn() is 0 in case of page !=3D NULL.
>=20
> Signed-off-by: Serhii Popovych <spopovyc@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/kvm/book3s_64_mmu_hv.c | 54 ++++++++++++++++++-------------=
------
>  1 file changed, 26 insertions(+), 28 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3=
s_64_mmu_hv.c
> index 0534aab..3e9abd9 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> @@ -82,47 +82,44 @@ struct kvm_resize_hpt {
>  int kvmppc_allocate_hpt(struct kvm_hpt_info *info, u32 order)
>  {
>  	unsigned long hpt =3D 0;
> -	int cma =3D 0;
> -	struct page *page =3D NULL;
> -	struct revmap_entry *rev;
> +	int err, cma =3D 0;
> +	struct page *page;
> +	struct revmap_entry *rev =3D NULL;
>  	unsigned long npte;
> =20
> +	err =3D -EINVAL;
>  	if ((order < PPC_MIN_HPT_ORDER) || (order > PPC_MAX_HPT_ORDER))
> -		return -EINVAL;
> +		goto out;
> =20
> +	err =3D -ENOMEM;
>  	page =3D kvm_alloc_hpt_cma(1ul << (order - PAGE_SHIFT));
>  	if (page) {
>  		hpt =3D (unsigned long)pfn_to_kaddr(page_to_pfn(page));
>  		memset((void *)hpt, 0, (1ul << order));
>  		cma =3D 1;
> -	}
> -
> -	if (!hpt)
> +	} else {
>  		hpt =3D __get_free_pages(GFP_KERNEL|__GFP_ZERO|__GFP_RETRY_MAYFAIL
>  				       |__GFP_NOWARN, order - PAGE_SHIFT);
> -
> -	if (!hpt)
> -		return -ENOMEM;
> +		if (!hpt)
> +			goto out;
> +	}
> =20
>  	/* HPTEs are 2**4 bytes long */
>  	npte =3D 1ul << (order - 4);
> =20
>  	/* Allocate reverse map array */
> -	rev =3D vmalloc(sizeof(struct revmap_entry) * npte);
> -	if (!rev) {
> -		if (cma)
> -			kvm_free_hpt_cma(page, 1 << (order - PAGE_SHIFT));
> -		else
> -			free_pages(hpt, order - PAGE_SHIFT);
> -		return -ENOMEM;
> -	}
> -
> +	rev =3D vmalloc(sizeof(*rev) * npte);
> +	if (rev)
> +		err =3D 0;
> +out:
>  	info->order =3D order;
>  	info->virt =3D hpt;
>  	info->cma =3D cma;
>  	info->rev =3D rev;
> =20
> -	return 0;
> +	if (err)
> +		kvmppc_free_hpt(info);
> +	return err;
>  }
> =20
>  void kvmppc_set_hpt(struct kvm *kvm, struct kvm_hpt_info *info)
> @@ -190,12 +187,14 @@ void kvmppc_free_hpt(struct kvm_hpt_info *info)
>  {
>  	vfree(info->rev);
>  	info->rev =3D NULL;
> -	if (info->cma)
> -		kvm_free_hpt_cma(virt_to_page(info->virt),
> -				 1 << (info->order - PAGE_SHIFT));
> -	else if (info->virt)
> -		free_pages(info->virt, info->order - PAGE_SHIFT);
> -	info->virt =3D 0;
> +	if (info->virt) {
> +		if (info->cma)
> +			kvm_free_hpt_cma(virt_to_page(info->virt),
> +					 1 << (info->order - PAGE_SHIFT));
> +		else
> +			free_pages(info->virt, info->order - PAGE_SHIFT);
> +		info->virt =3D 0;
> +	}
>  	info->order =3D 0;
>  }
> =20
> @@ -1423,8 +1422,7 @@ static void resize_hpt_release(struct kvm *kvm, str=
uct kvm_resize_hpt *resize)
>  	if (!resize)
>  		return;
> =20
> -	if (resize->hpt.virt)
> -		kvmppc_free_hpt(&resize->hpt);
> +	kvmppc_free_hpt(&resize->hpt);
> =20
>  	kvm->arch.resize_hpt =3D NULL;
>  	kfree(resize);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--xNm6VWMD3PcA105u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloffvUACgkQbDjKyiDZ
s5LQfQ/9EdvrqvRBkH5UV/sTaevMDOyQ26ln1S+4XmwBpDYehptamA0ySmOKSZeZ
iBKIlLzujg0MbTTLpKGLa1u5kT7wqtjUK2YA7qNxAaGy/e+jaWYGgGcmSL3qWgmD
AQ4OPJGUbqEnkanZ6YtTm0EaCbUP0GXPU6qLY4HjPDSnx7D2/ZW5C+ZRCNs6KtG5
PiJ/5SZqA81wxcyGEfU0rCx2tvQWYltDEKl8Mhq28gb7LlyZLACoWeyDt2oGvexf
0wHT6rz+JxRiZS5fyxILUQLbwEQxookpzQ3du43mw/5dyF6BPgl5SAe459qXQA9t
Fn+IwvDxDycWlDlbSO3oheUdJsQTPftOzVH6tFnA+NBIl+kwnNMh3OvH8p1wBrbZ
GC3/PlTFCMbhtsFbgrbdflApQhTYz+D/lNjAAH7AOrHk59+TsQkSnVlFLOSVEVPl
jf4lspDVB9GT+Srrnip/sxiupVUYA0aK6yaSrsxMEDwYKlUx8+46FQv3/apKWR0W
BYoIpNb4c8LnuZyQGm0csp062+wRL78foxBQ1zEloxhPB5CRKYKxMkWlD6Xdwufa
K6HF7REoWoUAiTJQ/u/mySDnyHlrkbaaOVtiXg/ieQ8u42jwa2BT5uGiGsTJOlTR
1p3T2W7wQLk50YYIkMKO0Roj1hRqouK5i6PzoUF2N7whL/0wDPA=
=eg2a
-----END PGP SIGNATURE-----

--xNm6VWMD3PcA105u--
