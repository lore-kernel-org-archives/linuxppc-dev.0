Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tfwtz1FSJzDw6C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 14:35:39 +1100 (AEDT)
Date: Fri, 16 Dec 2016 12:32:35 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH kernel 8/9] KVM: PPC: Pass kvm* to kvmppc_find_table()
Message-ID: <20161216013235.GE12146@umbus.fritz.box>
References: <20161208081956.26221-1-aik@ozlabs.ru>
 <20161208081956.26221-9-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bi5JUZtvcfApsciF"
In-Reply-To: <20161208081956.26221-9-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--bi5JUZtvcfApsciF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 08, 2016 at 07:19:55PM +1100, Alexey Kardashevskiy wrote:
> The guest view TCE tables are per KVM anyway (not per VCPU) so pass kvm*
> there. This will be used in the following patches where we will be
> attaching VFIO containers to LIOBNs via ioctl() to KVM (rather than
> to VCPU).
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/include/asm/kvm_ppc.h  |  2 +-
>  arch/powerpc/kvm/book3s_64_vio.c    |  7 ++++---
>  arch/powerpc/kvm/book3s_64_vio_hv.c | 13 +++++++------
>  3 files changed, 12 insertions(+), 10 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/as=
m/kvm_ppc.h
> index f6e49640dbe1..0a21c8503974 100644
> --- a/arch/powerpc/include/asm/kvm_ppc.h
> +++ b/arch/powerpc/include/asm/kvm_ppc.h
> @@ -167,7 +167,7 @@ extern int kvmppc_pseries_do_hcall(struct kvm_vcpu *v=
cpu);
>  extern long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>  				struct kvm_create_spapr_tce_64 *args);
>  extern struct kvmppc_spapr_tce_table *kvmppc_find_table(
> -		struct kvm_vcpu *vcpu, unsigned long liobn);
> +		struct kvm *kvm, unsigned long liobn);
>  extern long kvmppc_ioba_validate(struct kvmppc_spapr_tce_table *stt,
>  		unsigned long ioba, unsigned long npages);
>  extern long kvmppc_tce_validate(struct kvmppc_spapr_tce_table *tt,
> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_6=
4_vio.c
> index c379ff5a4438..15df8ae627d9 100644
> --- a/arch/powerpc/kvm/book3s_64_vio.c
> +++ b/arch/powerpc/kvm/book3s_64_vio.c
> @@ -212,12 +212,13 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>  long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
>  		      unsigned long ioba, unsigned long tce)
>  {
> -	struct kvmppc_spapr_tce_table *stt =3D kvmppc_find_table(vcpu, liobn);
> +	struct kvmppc_spapr_tce_table *stt;
>  	long ret;
> =20
>  	/* udbg_printf("H_PUT_TCE(): liobn=3D0x%lx ioba=3D0x%lx, tce=3D0x%lx\n"=
, */
>  	/* 	    liobn, ioba, tce); */
> =20
> +	stt =3D kvmppc_find_table(vcpu->kvm, liobn);
>  	if (!stt)
>  		return H_TOO_HARD;
> =20
> @@ -245,7 +246,7 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
>  	u64 __user *tces;
>  	u64 tce;
> =20
> -	stt =3D kvmppc_find_table(vcpu, liobn);
> +	stt =3D kvmppc_find_table(vcpu->kvm, liobn);
>  	if (!stt)
>  		return H_TOO_HARD;
> =20
> @@ -299,7 +300,7 @@ long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
>  	struct kvmppc_spapr_tce_table *stt;
>  	long i, ret;
> =20
> -	stt =3D kvmppc_find_table(vcpu, liobn);
> +	stt =3D kvmppc_find_table(vcpu->kvm, liobn);
>  	if (!stt)
>  		return H_TOO_HARD;
> =20
> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3=
s_64_vio_hv.c
> index a3be4bd6188f..8a6834e6e1c8 100644
> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
> @@ -49,10 +49,9 @@
>   * WARNING: This will be called in real or virtual mode on HV KVM and vi=
rtual
>   *          mode on PR KVM
>   */
> -struct kvmppc_spapr_tce_table *kvmppc_find_table(struct kvm_vcpu *vcpu,
> +struct kvmppc_spapr_tce_table *kvmppc_find_table(struct kvm *kvm,
>  		unsigned long liobn)
>  {
> -	struct kvm *kvm =3D vcpu->kvm;
>  	struct kvmppc_spapr_tce_table *stt;
> =20
>  	list_for_each_entry_lockless(stt, &kvm->arch.spapr_tce_tables, list)
> @@ -194,12 +193,13 @@ static struct mm_iommu_table_group_mem_t *kvmppc_rm=
_iommu_lookup(
>  long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
>  		unsigned long ioba, unsigned long tce)
>  {
> -	struct kvmppc_spapr_tce_table *stt =3D kvmppc_find_table(vcpu, liobn);
> +	struct kvmppc_spapr_tce_table *stt;
>  	long ret;
> =20
>  	/* udbg_printf("H_PUT_TCE(): liobn=3D0x%lx ioba=3D0x%lx, tce=3D0x%lx\n"=
, */
>  	/* 	    liobn, ioba, tce); */
> =20
> +	stt =3D kvmppc_find_table(vcpu->kvm, liobn);
>  	if (!stt)
>  		return H_TOO_HARD;
> =20
> @@ -252,7 +252,7 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vc=
pu,
>  	unsigned long tces, entry, ua =3D 0;
>  	unsigned long *rmap =3D NULL;
> =20
> -	stt =3D kvmppc_find_table(vcpu, liobn);
> +	stt =3D kvmppc_find_table(vcpu->kvm, liobn);
>  	if (!stt)
>  		return H_TOO_HARD;
> =20
> @@ -335,7 +335,7 @@ long kvmppc_rm_h_stuff_tce(struct kvm_vcpu *vcpu,
>  	struct kvmppc_spapr_tce_table *stt;
>  	long i, ret;
> =20
> -	stt =3D kvmppc_find_table(vcpu, liobn);
> +	stt =3D kvmppc_find_table(vcpu->kvm, liobn);
>  	if (!stt)
>  		return H_TOO_HARD;
> =20
> @@ -356,12 +356,13 @@ long kvmppc_rm_h_stuff_tce(struct kvm_vcpu *vcpu,
>  long kvmppc_h_get_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
>  		      unsigned long ioba)
>  {
> -	struct kvmppc_spapr_tce_table *stt =3D kvmppc_find_table(vcpu, liobn);
> +	struct kvmppc_spapr_tce_table *stt;
>  	long ret;
>  	unsigned long idx;
>  	struct page *page;
>  	u64 *tbl;
> =20
> +	stt =3D kvmppc_find_table(vcpu->kvm, liobn);
>  	if (!stt)
>  		return H_TOO_HARD;
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--bi5JUZtvcfApsciF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYU0QxAAoJEGw4ysog2bOSQpAP/RQ+zq7rv43DF2GRb+7/gu1h
KE3veYjoAk8tZrRs3HIAu9g+kniPIO2pIhKHXq/xa2YkkRxA4z98zVZH65RHod29
01AJ/M0QlqNMTx7e3ejIc/IKY0I4TfIdE+8MNEk2QOyfK0Mf7gE6G19utgK4VW7E
dqHarz3r+YJb/r0n6L8o6pwRSkn2CNz7NymqynqglYdvseKpZL0SYP9jgAe28iHz
klhKvRafjOKfh/zTVNOyQbEtmeHpeSHwJ1ZDjvXeHrdiXC4w/02oKmfTcJZ6jwkI
+SMgVrUNdO4br/APF2AJ18L7JTaM/GnEh5qqGCEeqIgs/Xyf/p4RwC0+h2iUtKib
vhp4a9KL5dGs8zTS0Eh6iQNteqWxfIqCQF5pf9LPP00rIoybvtgmK+gEZ+0OrJsD
uTniCZ0hIJRVX0U5umfvBpGpzFmvHUw4aIdoumIcy6BZor1tFzffaswvaKnC5BZt
otR9cAKWrRWJHLW3zPrm3D4R7hZ+Ha8XW/V8wtKedahfoNFIxM/RQ+HQkz4qujj9
ObKIvBPWtFxR0uJafKW3ZjL7HBuFFuUhWG0+z8cZA0z/sJkzc0onjjWFGh0LBcMZ
B2fOqeOgnThfGsTe4A4D+vR51UxZBFM6KqctRsBM2itIgENS371+3zCtHPjbxchL
EW0AsiKfcAj42Ejuc6pC
=BMCU
-----END PGP SIGNATURE-----

--bi5JUZtvcfApsciF--
