Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40bT8m5vGKzF2S0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 16:37:12 +1000 (AEST)
Date: Wed, 2 May 2018 15:49:26 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH kernel 2/2] KVM: PPC: Allow backing bigger guest IOMMU
 pages with smaller physical pages
Message-ID: <20180502054926.GB3517@umbus.fritz.box>
References: <20180502040723.20545-1-aik@ozlabs.ru>
 <20180502040723.20545-3-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
In-Reply-To: <20180502040723.20545-3-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 02, 2018 at 02:07:23PM +1000, Alexey Kardashevskiy wrote:
> At the moment we only support in the host the IOMMU page sizes which
> the guest is aware of, which is 4KB/64KB/16MB. However P9 does not support
> 16MB IOMMU pages, 2MB and 1GB pages are supported instead. We can still
> emulate bigger guest pages (for example 16MB) with smaller host pages
> (4KB/64KB/2MB).
>=20
> This allows the physical IOMMU pages to use a page size smaller or equal
> than the guest visible IOMMU page size.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Except for one possible nit..

> ---
>  arch/powerpc/kvm/book3s_64_vio.c    | 66 +++++++++++++++++++++++++++++--=
------
>  arch/powerpc/kvm/book3s_64_vio_hv.c | 52 +++++++++++++++++++++++++----
>  2 files changed, 98 insertions(+), 20 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_6=
4_vio.c
> index 041e54d..e10d6a3 100644
> --- a/arch/powerpc/kvm/book3s_64_vio.c
> +++ b/arch/powerpc/kvm/book3s_64_vio.c
> @@ -176,14 +176,12 @@ extern long kvm_spapr_tce_attach_iommu_group(struct=
 kvm *kvm, int tablefd,
> =20
>  		if (!tbltmp)
>  			continue;
> -		/*
> -		 * Make sure hardware table parameters are exactly the same;
> -		 * this is used in the TCE handlers where boundary checks
> -		 * use only the first attached table.
> -		 */
> -		if ((tbltmp->it_page_shift =3D=3D stt->page_shift) &&
> -				(tbltmp->it_offset =3D=3D stt->offset) &&
> -				(tbltmp->it_size =3D=3D stt->size)) {
> +		/* Make sure hardware table parameters are compatible */
> +		if ((tbltmp->it_page_shift <=3D stt->page_shift) &&
> +				(tbltmp->it_offset << tbltmp->it_page_shift =3D=3D
> +				 stt->offset << stt->page_shift) &&
> +				(tbltmp->it_size << tbltmp->it_page_shift =3D=3D
> +				 stt->size << stt->page_shift)) {

Do we need to worry about stt->offset << stt->page_shift overflowing
with a buggy or malicious userspace?

>  			/*
>  			 * Reference the table to avoid races with
>  			 * add/remove DMA windows.
> @@ -396,7 +394,7 @@ static long kvmppc_tce_iommu_mapped_dec(struct kvm *k=
vm,
>  	return H_SUCCESS;
>  }
> =20
> -static long kvmppc_tce_iommu_unmap(struct kvm *kvm,
> +static long kvmppc_tce_iommu_do_unmap(struct kvm *kvm,
>  		struct iommu_table *tbl, unsigned long entry)
>  {
>  	enum dma_data_direction dir =3D DMA_NONE;
> @@ -416,7 +414,25 @@ static long kvmppc_tce_iommu_unmap(struct kvm *kvm,
>  	return ret;
>  }
> =20
> -long kvmppc_tce_iommu_map(struct kvm *kvm, struct iommu_table *tbl,
> +static long kvmppc_tce_iommu_unmap(struct kvm *kvm,
> +		struct kvmppc_spapr_tce_table *stt, struct iommu_table *tbl,
> +		unsigned long entry)
> +{
> +	unsigned long ret =3D H_SUCCESS;
> +	unsigned long subpages =3D 1ULL << (stt->page_shift - tbl->it_page_shif=
t);
> +	unsigned long io_entry =3D entry * subpages;
> +	unsigned long subpg;
> +
> +	for (subpg =3D 0; subpg < subpages; ++subpg) {
> +		ret =3D kvmppc_tce_iommu_do_unmap(kvm, tbl, io_entry + subpg);
> +		if (ret !=3D H_SUCCESS)
> +			break;
> +	}
> +
> +	return ret;
> +}
> +
> +long kvmppc_tce_iommu_do_map(struct kvm *kvm, struct iommu_table *tbl,
>  		unsigned long entry, unsigned long ua,
>  		enum dma_data_direction dir)
>  {
> @@ -453,6 +469,28 @@ long kvmppc_tce_iommu_map(struct kvm *kvm, struct io=
mmu_table *tbl,
>  	return 0;
>  }
> =20
> +static long kvmppc_tce_iommu_map(struct kvm *kvm,
> +		struct kvmppc_spapr_tce_table *stt, struct iommu_table *tbl,
> +		unsigned long entry, unsigned long ua,
> +		enum dma_data_direction dir)
> +{
> +	unsigned long ret =3D H_SUCCESS;
> +	unsigned long subpages =3D 1ULL << (stt->page_shift - tbl->it_page_shif=
t);
> +	unsigned long io_entry =3D entry * subpages;
> +	unsigned long subpg, pgoff;
> +
> +	for (subpg =3D 0, pgoff =3D 0; subpg < subpages;
> +			++subpg, pgoff +=3D IOMMU_PAGE_SIZE(tbl)) {
> +
> +		ret =3D kvmppc_tce_iommu_do_map(kvm, tbl,
> +				io_entry + subpg, ua + pgoff, dir);
> +		if (ret !=3D H_SUCCESS)
> +			break;
> +	}
> +
> +	return ret;
> +}
> +
>  long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
>  		      unsigned long ioba, unsigned long tce)
>  {
> @@ -491,10 +529,10 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsign=
ed long liobn,
> =20
>  	list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
>  		if (dir =3D=3D DMA_NONE)
> -			ret =3D kvmppc_tce_iommu_unmap(vcpu->kvm,
> +			ret =3D kvmppc_tce_iommu_unmap(vcpu->kvm, stt,
>  					stit->tbl, entry);
>  		else
> -			ret =3D kvmppc_tce_iommu_map(vcpu->kvm, stit->tbl,
> +			ret =3D kvmppc_tce_iommu_map(vcpu->kvm, stt, stit->tbl,
>  					entry, ua, dir);
> =20
>  		if (ret =3D=3D H_SUCCESS)
> @@ -570,7 +608,7 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
>  			return H_PARAMETER;
> =20
>  		list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
> -			ret =3D kvmppc_tce_iommu_map(vcpu->kvm,
> +			ret =3D kvmppc_tce_iommu_map(vcpu->kvm, stt,
>  					stit->tbl, entry + i, ua,
>  					iommu_tce_direction(tce));
> =20
> @@ -618,7 +656,7 @@ long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
>  		unsigned long entry =3D ioba >> stt->page_shift;
> =20
>  		for (i =3D 0; i < npages; ++i) {
> -			ret =3D kvmppc_tce_iommu_unmap(vcpu->kvm,
> +			ret =3D kvmppc_tce_iommu_unmap(vcpu->kvm, stt,
>  					stit->tbl, entry + i);
> =20
>  			if (ret =3D=3D H_SUCCESS)
> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3=
s_64_vio_hv.c
> index e220fab..258e786 100644
> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
> @@ -221,7 +221,7 @@ static long kvmppc_rm_tce_iommu_mapped_dec(struct kvm=
 *kvm,
>  	return H_SUCCESS;
>  }
> =20
> -static long kvmppc_rm_tce_iommu_unmap(struct kvm *kvm,
> +static long kvmppc_rm_tce_iommu_do_unmap(struct kvm *kvm,
>  		struct iommu_table *tbl, unsigned long entry)
>  {
>  	enum dma_data_direction dir =3D DMA_NONE;
> @@ -245,7 +245,25 @@ static long kvmppc_rm_tce_iommu_unmap(struct kvm *kv=
m,
>  	return ret;
>  }
> =20
> -static long kvmppc_rm_tce_iommu_map(struct kvm *kvm, struct iommu_table =
*tbl,
> +static long kvmppc_rm_tce_iommu_unmap(struct kvm *kvm,
> +		struct kvmppc_spapr_tce_table *stt, struct iommu_table *tbl,
> +		unsigned long entry)
> +{
> +	unsigned long ret =3D H_SUCCESS;
> +	unsigned long subpages =3D 1ULL << (stt->page_shift - tbl->it_page_shif=
t);
> +	unsigned long io_entry =3D entry * subpages;
> +	unsigned long subpg;
> +
> +	for (subpg =3D 0; subpg < subpages; ++subpg) {
> +		ret =3D kvmppc_rm_tce_iommu_do_unmap(kvm, tbl, io_entry + subpg);
> +		if (ret !=3D H_SUCCESS)
> +			break;
> +	}
> +
> +	return ret;
> +}
> +
> +static long kvmppc_rm_tce_iommu_do_map(struct kvm *kvm, struct iommu_tab=
le *tbl,
>  		unsigned long entry, unsigned long ua,
>  		enum dma_data_direction dir)
>  {
> @@ -290,6 +308,28 @@ static long kvmppc_rm_tce_iommu_map(struct kvm *kvm,=
 struct iommu_table *tbl,
>  	return 0;
>  }
> =20
> +static long kvmppc_rm_tce_iommu_map(struct kvm *kvm,
> +		struct kvmppc_spapr_tce_table *stt, struct iommu_table *tbl,
> +		unsigned long entry, unsigned long ua,
> +		enum dma_data_direction dir)
> +{
> +	unsigned long ret =3D H_SUCCESS;
> +	unsigned long subpages =3D 1ULL << (stt->page_shift - tbl->it_page_shif=
t);
> +	unsigned long io_entry =3D entry * subpages;
> +	unsigned long subpg, pgoff;
> +
> +	for (subpg =3D 0, pgoff =3D 0; subpg < subpages;
> +			++subpg, pgoff +=3D IOMMU_PAGE_SIZE(tbl)) {
> +
> +		ret =3D kvmppc_rm_tce_iommu_do_map(kvm, tbl,
> +				io_entry + subpg, ua + pgoff, dir);
> +		if (ret !=3D H_SUCCESS)
> +			break;
> +	}
> +
> +	return ret;
> +}
> +
>  long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
>  		unsigned long ioba, unsigned long tce)
>  {
> @@ -327,10 +367,10 @@ long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, uns=
igned long liobn,
> =20
>  	list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
>  		if (dir =3D=3D DMA_NONE)
> -			ret =3D kvmppc_rm_tce_iommu_unmap(vcpu->kvm,
> +			ret =3D kvmppc_rm_tce_iommu_unmap(vcpu->kvm, stt,
>  					stit->tbl, entry);
>  		else
> -			ret =3D kvmppc_rm_tce_iommu_map(vcpu->kvm,
> +			ret =3D kvmppc_rm_tce_iommu_map(vcpu->kvm, stt,
>  					stit->tbl, entry, ua, dir);
> =20
>  		if (ret =3D=3D H_SUCCESS)
> @@ -477,7 +517,7 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vc=
pu,
>  			return H_PARAMETER;
> =20
>  		list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
> -			ret =3D kvmppc_rm_tce_iommu_map(vcpu->kvm,
> +			ret =3D kvmppc_rm_tce_iommu_map(vcpu->kvm, stt,
>  					stit->tbl, entry + i, ua,
>  					iommu_tce_direction(tce));
> =20
> @@ -529,7 +569,7 @@ long kvmppc_rm_h_stuff_tce(struct kvm_vcpu *vcpu,
>  		unsigned long entry =3D ioba >> stt->page_shift;
> =20
>  		for (i =3D 0; i < npages; ++i) {
> -			ret =3D kvmppc_rm_tce_iommu_unmap(vcpu->kvm,
> +			ret =3D kvmppc_rm_tce_iommu_unmap(vcpu->kvm, stt,
>  					stit->tbl, entry + i);
> =20
>  			if (ret =3D=3D H_SUCCESS)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrpUWYACgkQbDjKyiDZ
s5JQ7BAAsXIjoxrR87I9JrCtQ79QtMxyQxSya2TsjeyZZCMytt9blSt55tixQQyZ
yzxGOjCiIIw1MISOo+dcpNCVUcrEMfu75r/d7+10fKIF89slUWQz64UJ6YhITmv4
E+fSFQzgVeodYOOaU9l6MQc86znTQG/5bMWsDHKPThcKwL42mtweXX1sw4NbcWhv
NoLwaGN9G4y+0sAFCi7DfyUzNAGQTtVVInYsE/Rp6yh/qfjBPaM/VND232RguQq3
c8WE3iTdD0NVlMP30UDnrhhL8K+4lZmSVrYOekFdkInmrEd2uZrzCtBGTsr8Dn7K
EUxK9r9oe+oNaf9Imvrr/LkSS5+hX6r9pu3YPmV85hYBs5ozTyY5iKJmiZmBE0Pj
kKAIyWq9FuU+w2FG2qlis0za1Qi+9O3vaROvn2U4Yn6Sg0NTfhS4D48iC1vp5nNJ
2ikYJKqsxp2cUN9sAb5mQVKPUEEWWqTerIARqCjzW5A3jevCJwV6pMVkcgS0MG3w
r5CNlUmkHBi5lmY8NT/JMUA6fDPYlgx76C3AoreVxO0A5Nra12wjQeZO2O66mF6v
PVwFbPjtsHJBVLL5EURTkfG1+/ekJwecPeqMEJciO1NCQVuPdIgSHFuHJIXYf8v0
qFV6mf6IEFqeHx9qBZr4w43oJ6kkHx5+2aOnoh/pqTV4YqBt2PY=
=ILK8
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--
