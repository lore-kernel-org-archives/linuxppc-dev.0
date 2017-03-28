Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vsX576BpQzDqC2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Mar 2017 11:36:27 +1100 (AEDT)
Date: Tue, 28 Mar 2017 11:14:06 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH kernel] KVM: PPC: Preserve storage control bits
Message-ID: <20170328001406.GB13461@umbus.fritz.box>
References: <20170324064922.18429-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9zSXsLTf0vkW971A"
In-Reply-To: <20170324064922.18429-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--9zSXsLTf0vkW971A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 24, 2017 at 05:49:22PM +1100, Alexey Kardashevskiy wrote:
> PR KVM page fault handler performs eaddr to pte translation for a guest,
> however kvmppc_mmu_book3s_64_xlate() does not preserve WIMG bits
> (storage control) in the kvmppc_pte struct. If PR KVM is running as
> a second level guest under HV KVM, and PR KVM tries inserting HPT entry,
> this fails in HV KVM if it already has this mapping.
>=20
> This preserves WIMG bits between kvmppc_mmu_book3s_64_xlate() and
> kvmppc_mmu_map_page().
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>=20
> This allows MMIO BAR mapping for nested guest with VFIO.
>=20
> This is the check in HV KVM which failed:
>=20
> arch/powerpc/kvm/book3s_hv_rm_mmu.c
> long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
> [...]
>=20
>         /*If we had host pte mapping then  Check WIMG */
>         if (ptep && !hpte_cache_flags_ok(ptel, is_ci)) {
>                 if (is_ci)
>                         return H_PARAMETER;
>                 /*
>                  * Allow guest to map emulated device memory as
>                  * uncacheable, but actually make it cacheable.
>                  */
>                 ptel &=3D ~(HPTE_R_W|HPTE_R_I|HPTE_R_G);
>                 ptel |=3D HPTE_R_M;
>         }
> ---
>  arch/powerpc/include/asm/kvm_host.h   | 1 +
>  arch/powerpc/kvm/book3s_64_mmu.c      | 1 +
>  arch/powerpc/kvm/book3s_64_mmu_host.c | 2 ++
>  arch/powerpc/kvm/book3s_pr.c          | 2 +-
>  4 files changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/a=
sm/kvm_host.h
> index 7bba8f415627..bf6822cd4f86 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -345,6 +345,7 @@ struct kvmppc_pte {
>  	bool may_read		: 1;
>  	bool may_write		: 1;
>  	bool may_execute	: 1;
> +	unsigned long wimg;
>  	u8 page_size;		/* MMU_PAGE_xxx */
>  };
> =20
> diff --git a/arch/powerpc/kvm/book3s_64_mmu.c b/arch/powerpc/kvm/book3s_6=
4_mmu.c
> index 70153578131a..29ebe2fd5867 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu.c
> @@ -319,6 +319,7 @@ static int kvmppc_mmu_book3s_64_xlate(struct kvm_vcpu=
 *vcpu, gva_t eaddr,
>  		gpte->may_execute =3D true;
>  	gpte->may_read =3D false;
>  	gpte->may_write =3D false;
> +	gpte->wimg =3D r & HPTE_R_WIMG;
> =20
>  	switch (pp) {
>  	case 0:
> diff --git a/arch/powerpc/kvm/book3s_64_mmu_host.c b/arch/powerpc/kvm/boo=
k3s_64_mmu_host.c
> index 4b4e927c4822..145a61892c48 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu_host.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu_host.c
> @@ -145,6 +145,8 @@ int kvmppc_mmu_map_page(struct kvm_vcpu *vcpu, struct=
 kvmppc_pte *orig_pte,
>  	else
>  		kvmppc_mmu_flush_icache(pfn);
> =20
> +	rflags =3D (rflags & ~HPTE_R_WIMG) | orig_pte->wimg;
> +
>  	/*
>  	 * Use 64K pages if possible; otherwise, on 64K page kernels,
>  	 * we need to transfer 4 more bits from guest real to host real addr.
> diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
> index ce437b98477e..f026b062c0ed 100644
> --- a/arch/powerpc/kvm/book3s_pr.c
> +++ b/arch/powerpc/kvm/book3s_pr.c
> @@ -537,7 +537,7 @@ int kvmppc_handle_pagefault(struct kvm_run *run, stru=
ct kvm_vcpu *vcpu,
>  	int r =3D RESUME_GUEST;
>  	int relocated;
>  	int page_found =3D 0;
> -	struct kvmppc_pte pte;
> +	struct kvmppc_pte pte =3D { 0 };
>  	bool dr =3D (kvmppc_get_msr(vcpu) & MSR_DR) ? true : false;
>  	bool ir =3D (kvmppc_get_msr(vcpu) & MSR_IR) ? true : false;
>  	u64 vsid;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9zSXsLTf0vkW971A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY2arNAAoJEGw4ysog2bOSDawP/2lcVQbNWzi31ZL/bC9lSa7C
OegTDoDpclLnAIL2FWG6Fuqc4z/8HciRHPdrLLmsh9GLoJd2vX6Wp/9E4QKraGoK
QrbKc9x61vHVfDD4rRW3h5RsNULj7+2zfSwsWVprXd001sR1OfGAGACe2z28uYpv
57mRgdDqjC1ex3/ZlWQhsmyrCxJrDKKoKgMOqb5HI1KGbyntV1G93KA7YhuMuLiO
zZlQevGOIBifG6AI1byPC5BMUZq6j19EHVNNjpzjsx4d/1caUN7zsxfxIjxXOAt2
lIV5rx/Kq9flU2l7f6FcvH8uZ/OCB1Bqi8rJV+5wfl31I3QoW7g8r7SKuPzRpaVA
ZoBKONDfgZ1DaPJfFdyeJh6no9Qb+u5Hd1zAeElBRTa3tuNHQ2oJS1w2slW/57nD
wtaBlvtE+mIKCR20P+inpJdlizpRxOeTDnfMQFGAKDw4Q3KOdn9AUK9jpPncx8wR
yEf40gYn/UMtPm4diqk5SgCSN/I/+XYNj5xoEU4P0BzMdG/7C4P1XVsV2jwKUV5J
dDFSKjzd92uFbMk153r3OWUsi3HypdsIWlcXzw97EJwqEqfMhVzudUp1TgRdQLmO
jFMaBeX5NQxQXgxJaKilGCG1/fGW5uAp4FJxOkm/v3e/wfAZubdo/mloSArpSJWW
G7JnX8vdDK2kvW7QjJOM
=UsFL
-----END PGP SIGNATURE-----

--9zSXsLTf0vkW971A--
