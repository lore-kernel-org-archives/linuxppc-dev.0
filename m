Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9XTd6tm4zDr21
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 14:48:53 +1000 (AEST)
Date: Fri, 12 Aug 2016 14:45:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH kernel 13/15] KVM: PPC: Pass kvm* to kvmppc_find_table()
Message-ID: <20160812044549.GP16493@voom.fritz.box>
References: <1470213656-1042-1-git-send-email-aik@ozlabs.ru>
 <1470213656-1042-14-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="+W7ryvxEk4RRyt+P"
In-Reply-To: <1470213656-1042-14-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--+W7ryvxEk4RRyt+P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 03, 2016 at 06:40:54PM +1000, Alexey Kardashevskiy wrote:
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
> index 2544eda..7f1abe9 100644
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
> index c379ff5..15df8ae 100644
> --- a/arch/powerpc/kvm/book3s_64_vio.c
> +++ b/arch/powerpc/kvm/book3s_64_vio.c
> @@ -212,12 +212,13 @@ fail:
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
> index a3be4bd..8a6834e 100644
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

--+W7ryvxEk4RRyt+P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXrVR9AAoJEGw4ysog2bOSbAQP/04F/q8S4GRlUwukbzOkJchl
YiELmEj53ws6rFaEWbeWmomtEXNNw7DEoogcy+H/+l1w5yRmkCnT92VLNSLo5q+f
hLqezjHFUNI/dzSI3cqQLNyPy3uE6Cj04mgFSYj0NFBW26qSOoQhqJtN3Tpp/p/y
eS3nCMX94hcXihIejVxZszzsMmXCWdptF+r2i44cmB9Oh//5J9H8IWZGwKEZlTvL
gtkkl8x51M/UFphsWYLfJGPjyjhxXONbSUp8vp/Kevaf0ooaIBaYVUh4gQhHavmu
pZCM+v0I3R/i0dzb4A/VKCWblKaH5qbSCRp/3ByZXWqgJEWBkKWgZ4oPAhFNJbF0
h6rDGQ9Mek0UQOkS87aO9kLlqHWPr7QTXGA5AHOejUfKOVlovssHzluRw6OSVS9h
PxEvtrXoMRRPjQfPH6ThgtWQ7V/A1Sj6xL5p/lD8wCVjQqLl94zxINF+XVw/dyFK
fb5jbMTQD96JGf+A0AnY5j+TUvjpYL2gi/RcCOD2Tet+swGG9eBpxpaAlBl6+S57
tEpR3ggRc4VKtsUtF0EgZhzEc2kD05FAG5tfGvYNXiVTt5psSoi1k0yIseP+wuGi
EpTPXmME9rNs7+TP0nbcSeLwqAbO5GVwdR5c9yCqG/xy7h5CRw9ZK4OWBFO1wjqg
n22+3C+Cfp2g4iU0r6Bl
=mf3P
-----END PGP SIGNATURE-----

--+W7ryvxEk4RRyt+P--
