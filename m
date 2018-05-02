Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40bT8m3f5QzF2Rp
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 16:37:12 +1000 (AEST)
Date: Wed, 2 May 2018 15:41:20 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH kernel 1/2] KVM: PPC: Use correct page shift in H_STUFF_TCE
Message-ID: <20180502054120.GA3517@umbus.fritz.box>
References: <20180502040723.20545-1-aik@ozlabs.ru>
 <20180502040723.20545-2-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
In-Reply-To: <20180502040723.20545-2-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 02, 2018 at 02:07:22PM +1000, Alexey Kardashevskiy wrote:
> The other TCE handlers use page shift from the guest visible TCE table
> (described by kvmppc_spapr_tce_iommu_table) so let's make H_STUFF_TCE
> handlers do the same thing.
>=20
> This should cause no behavioral change now but soon we will allow
> the iommu_table::it_page_shift being different from from the emulated
> table page size so this will play a role.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/kvm/book3s_64_vio.c    | 2 +-
>  arch/powerpc/kvm/book3s_64_vio_hv.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_6=
4_vio.c
> index 4dffa61..041e54d 100644
> --- a/arch/powerpc/kvm/book3s_64_vio.c
> +++ b/arch/powerpc/kvm/book3s_64_vio.c
> @@ -615,7 +615,7 @@ long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
>  		return H_PARAMETER;
> =20
>  	list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
> -		unsigned long entry =3D ioba >> stit->tbl->it_page_shift;
> +		unsigned long entry =3D ioba >> stt->page_shift;
> =20
>  		for (i =3D 0; i < npages; ++i) {
>  			ret =3D kvmppc_tce_iommu_unmap(vcpu->kvm,
> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3=
s_64_vio_hv.c
> index 6651f73..e220fab 100644
> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
> @@ -526,7 +526,7 @@ long kvmppc_rm_h_stuff_tce(struct kvm_vcpu *vcpu,
>  		return H_PARAMETER;
> =20
>  	list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
> -		unsigned long entry =3D ioba >> stit->tbl->it_page_shift;
> +		unsigned long entry =3D ioba >> stt->page_shift;
> =20
>  		for (i =3D 0; i < npages; ++i) {
>  			ret =3D kvmppc_rm_tce_iommu_unmap(vcpu->kvm,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrpT34ACgkQbDjKyiDZ
s5JYjw//VDS5807o+T1XBG9/T0V26CRmFexEuru3UBDpuTeBlYSvYnM9M5jZwt4Q
fyZmAALQb5z7ADgjmt+iPQ+85eP2rwreaIsKAexAhsiVTGkHV7saR5i+U4SLri7i
IaNFzv+DSlTBguHhMu6PpKyOQJSAdMvoSeOTv4IpbizcWkPIWD908fWOQ0NKnOJF
A1C6n9s0BM0vY63/5z9UcgHg0N3UGlBzXjbKyVbbQ3ZGl2pBsEfPSqzBa7nSsvZF
nVZCVBOCAuuSy626ZO3CWaU1l6yYAjqVO5/bokjM7X2zp3pcNWlxTewzYTFjYd7Y
RtHRORH0Byam4TuR+n49FzecHlyEy53hC7r/61xWYkMmG2ZQOUzPBcGnNx6nFAh1
9t3pDTUTKiLdzTwtEieAWNktHahLo/7VhlXiczab1sdVnkyNQAU5dYXZL3fAv390
BFnQ2ha77WCELQhREcFl63+/FwyjVYm4Ud1goW01JK8+pQhVqbbDHp8mPvC7O1Jr
hM5KL+jaOAUayyTRpu3X1DthrC6YNhBDOqRNg8xWzSieq7tCe4I6+Nm1IeHaBB4G
a06nxUdsBHF01U57yhToqVVIX5JH6GlKo6IUTvnFM8W1H02VCZmJ08mjDVW9YVil
4IJiZ+H99GJP+21WK/Emu2OznLBNj0jORkYkBmJ93CCiQqBGwqk=
=OIdK
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
