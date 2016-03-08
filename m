Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 030E81A01EA
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 17:33:02 +1100 (AEDT)
Date: Tue, 8 Mar 2016 17:32:18 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH kernel 7/9] KVM: PPC: Create a virtual-mode only TCE
 table handlers
Message-ID: <20160308063218.GB22546@voom.fritz.box>
References: <1457322077-26640-1-git-send-email-aik@ozlabs.ru>
 <1457322077-26640-8-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="C311HLcnHV2CzHlo"
In-Reply-To: <1457322077-26640-8-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--C311HLcnHV2CzHlo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 07, 2016 at 02:41:15PM +1100, Alexey Kardashevskiy wrote:
> In-kernel VFIO acceleration needs different handling in real and virtual
> modes which makes it hard to support both modes in the same handler.
>=20
> This creates a copy of kvmppc_rm_h_stuff_tce and kvmppc_rm_h_put_tce
> in addition to the existing kvmppc_rm_h_put_tce_indirect.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/kvm/book3s_64_vio.c        | 52 +++++++++++++++++++++++++++=
++++++
>  arch/powerpc/kvm/book3s_64_vio_hv.c     |  8 ++---
>  arch/powerpc/kvm/book3s_hv_rmhandlers.S |  4 +--
>  3 files changed, 57 insertions(+), 7 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_6=
4_vio.c
> index 846d16d..7965fc7 100644
> --- a/arch/powerpc/kvm/book3s_64_vio.c
> +++ b/arch/powerpc/kvm/book3s_64_vio.c
> @@ -317,6 +317,32 @@ fail:
>  	return ret;
>  }
> =20
> +long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
> +		      unsigned long ioba, unsigned long tce)
> +{
> +	struct kvmppc_spapr_tce_table *stt =3D kvmppc_find_table(vcpu, liobn);
> +	long ret;
> +
> +	/* udbg_printf("H_PUT_TCE(): liobn=3D0x%lx ioba=3D0x%lx, tce=3D0x%lx\n"=
, */
> +	/* 	    liobn, ioba, tce); */
> +
> +	if (!stt)
> +		return H_TOO_HARD;
> +
> +	ret =3D kvmppc_ioba_validate(stt, ioba, 1);
> +	if (ret !=3D H_SUCCESS)
> +		return ret;
> +
> +	ret =3D kvmppc_tce_validate(stt, tce);
> +	if (ret !=3D H_SUCCESS)
> +		return ret;
> +
> +	kvmppc_tce_put(stt, ioba >> stt->page_shift, tce);
> +
> +	return H_SUCCESS;
> +}
> +EXPORT_SYMBOL_GPL(kvmppc_h_put_tce);
> +
>  long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
>  		unsigned long liobn, unsigned long ioba,
>  		unsigned long tce_list, unsigned long npages)
> @@ -372,3 +398,29 @@ unlock_exit:
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(kvmppc_h_put_tce_indirect);
> +
> +long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
> +		unsigned long liobn, unsigned long ioba,
> +		unsigned long tce_value, unsigned long npages)
> +{
> +	struct kvmppc_spapr_tce_table *stt;
> +	long i, ret;
> +
> +	stt =3D kvmppc_find_table(vcpu, liobn);
> +	if (!stt)
> +		return H_TOO_HARD;
> +
> +	ret =3D kvmppc_ioba_validate(stt, ioba, npages);
> +	if (ret !=3D H_SUCCESS)
> +		return ret;
> +
> +	/* Check permission bits only to allow userspace poison TCE for debug */
> +	if (tce_value & (TCE_PCI_WRITE | TCE_PCI_READ))
> +		return H_PARAMETER;
> +
> +	for (i =3D 0; i < npages; ++i, ioba +=3D (1ULL << stt->page_shift))
> +		kvmppc_tce_put(stt, ioba >> stt->page_shift, tce_value);
> +
> +	return H_SUCCESS;
> +}
> +EXPORT_SYMBOL_GPL(kvmppc_h_stuff_tce);
> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3=
s_64_vio_hv.c
> index af155f6..11163ae 100644
> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
> @@ -212,8 +212,8 @@ static struct mm_iommu_table_group_mem_t *kvmppc_rm_i=
ommu_lookup(
>  	return mm_iommu_lookup_rm(mm, ua, size);
>  }
> =20
> -long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
> -		      unsigned long ioba, unsigned long tce)
> +long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
> +		unsigned long ioba, unsigned long tce)
>  {
>  	struct kvmppc_spapr_tce_table *stt =3D kvmppc_find_table(vcpu, liobn);
>  	long ret;
> @@ -236,7 +236,6 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned=
 long liobn,
> =20
>  	return H_SUCCESS;
>  }
> -EXPORT_SYMBOL_GPL(kvmppc_h_put_tce);
> =20
>  static long kvmppc_rm_ua_to_hpa(struct kvm_vcpu *vcpu,
>  		unsigned long ua, unsigned long *phpa)
> @@ -350,7 +349,7 @@ unlock_exit:
>  	return ret;
>  }
> =20
> -long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
> +long kvmppc_rm_h_stuff_tce(struct kvm_vcpu *vcpu,
>  		unsigned long liobn, unsigned long ioba,
>  		unsigned long tce_value, unsigned long npages)
>  {
> @@ -374,7 +373,6 @@ long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
> =20
>  	return H_SUCCESS;
>  }
> -EXPORT_SYMBOL_GPL(kvmppc_h_stuff_tce);
> =20
>  long kvmppc_h_get_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
>  		      unsigned long ioba)
> diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/b=
ook3s_hv_rmhandlers.S
> index ed16182..d6dad2c 100644
> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> @@ -1928,7 +1928,7 @@ hcall_real_table:
>  	.long	DOTSYM(kvmppc_h_clear_ref) - hcall_real_table
>  	.long	DOTSYM(kvmppc_h_protect) - hcall_real_table
>  	.long	DOTSYM(kvmppc_h_get_tce) - hcall_real_table
> -	.long	DOTSYM(kvmppc_h_put_tce) - hcall_real_table
> +	.long	DOTSYM(kvmppc_rm_h_put_tce) - hcall_real_table
>  	.long	0		/* 0x24 - H_SET_SPRG0 */
>  	.long	DOTSYM(kvmppc_h_set_dabr) - hcall_real_table
>  	.long	0		/* 0x2c */
> @@ -2006,7 +2006,7 @@ hcall_real_table:
>  	.long	0		/* 0x12c */
>  	.long	0		/* 0x130 */
>  	.long	DOTSYM(kvmppc_h_set_xdabr) - hcall_real_table
> -	.long	DOTSYM(kvmppc_h_stuff_tce) - hcall_real_table
> +	.long	DOTSYM(kvmppc_rm_h_stuff_tce) - hcall_real_table
>  	.long	DOTSYM(kvmppc_rm_h_put_tce_indirect) - hcall_real_table
>  	.long	0		/* 0x140 */
>  	.long	0		/* 0x144 */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--C311HLcnHV2CzHlo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW3nHyAAoJEGw4ysog2bOSxN8P+gIvu4XWPdU9i8MEAfHszvNr
/tfyA98rb10fGRmSO508t37I52c81KxEdrvsNYpHhjTTVq6nAdf4I5PgKWw4nCap
xmR6Msm1r5EOfNuMLdVSBvxroTvRx1tO413DIB9fVKn8B8wGzjrAkRHdCxLog2Lj
ZltmOxsS2Kw3x/nWC+jw8xsZim0SoVbmsp8z6KuWuGxOt63UafpUjmRVFkjUo2RO
LEpYBqUPlAG5J4F1/JhBA4Oin4zS2zVuJTZh94Bz4ppISu2+5C8K4x2QmJz8gVN9
asQ94cDhoSMQq4jAgf3c//H/Em42HjeaCiJUzyka4chY0m8gykJXGn841i1Bqx01
8PXXjjnoilVmYx7ILgJK+Bkb7XVcKfGZESlAso7t5SY5iOEWByyJ3zwKKFOE7PAX
34d0yqDNN0i6/bcDZ550SMf5fCDglCPC9mIk564KKMIHC31BH5w/KinAxiPyNqX9
LCEQ6KmidOEqJtHFXGpbnz0SPbAfwRbfd2mXnpGWe41NjxXC8R1OczsyrgdfKTkg
czmA1Lsf6Pu/L+IuaRYUSJd3iAKZEZelEI4wfX2HDf7BUA4CeS9rPocrwM1x8xSh
J+o6e93uD6u0T5S6Hc0Cba7aam6k+ESuWL1eSOoUZkcuKIlbRyhLHLY9kLGcmH/F
RGFaEveWeKtqP+G88+fk
=JD3+
-----END PGP SIGNATURE-----

--C311HLcnHV2CzHlo--
