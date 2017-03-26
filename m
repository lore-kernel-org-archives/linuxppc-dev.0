Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vrv2b07XczDqBv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Mar 2017 10:47:03 +1100 (AEDT)
Date: Mon, 27 Mar 2017 09:43:21 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH kernel] KVM: PPC: Exit KVM on failed mapping
Message-ID: <20170326224321.GQ19078@umbus.fritz.box>
References: <20170324064810.18325-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xSu31lw3TgkWXnjh"
In-Reply-To: <20170324064810.18325-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--xSu31lw3TgkWXnjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 24, 2017 at 05:48:10PM +1100, Alexey Kardashevskiy wrote:
> At the moment kvmppc_mmu_map_page() returns -1 if
> mmu_hash_ops.hpte_insert() fails for any reason so the page fault handler
> resumes the guest and it faults on the same address again.
>=20
> This adds distinction to kvmppc_mmu_map_page() to return -EIO if
> mmu_hash_ops.hpte_insert() failed for a reason other than full pteg.
> At the moment only pSeries_lpar_hpte_insert() returns -2 if
> plpar_pte_enter() failed with a code other than H_PTEG_FULL.
> Other mmu_hash_ops.hpte_insert() instances can only fail with
> -1 "full pteg".
>=20
> With this change, if PR KVM fails to update HPT, it can signal
> the userspace about this instead of returning to guest and having
> the very same page fault over and over again.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>=20
> This was found with nested KVM+VFIO when PR KVM was trying to map MMIO BAR
> of a VFIO PCI device but since it would not preserve WIMG bits, HV KVM
> would fail, mmu_hash_ops.hpte_insert() would return error and PR KVM
> would just continue and trap again on the same memory access.
>=20
> With this patch but without "KVM: PPC: Preserve storage control bits"
> nested QEMU will abort with informative screen instead of endlessly
> trying to proceed further in booting.
> ---
>  arch/powerpc/kvm/book3s_64_mmu_host.c | 5 ++++-
>  arch/powerpc/kvm/book3s_pr.c          | 6 +++++-
>  2 files changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/book3s_64_mmu_host.c b/arch/powerpc/kvm/boo=
k3s_64_mmu_host.c
> index a587e8f4fd26..4b4e927c4822 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu_host.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu_host.c
> @@ -177,12 +177,15 @@ int kvmppc_mmu_map_page(struct kvm_vcpu *vcpu, stru=
ct kvmppc_pte *orig_pte,
>  	ret =3D mmu_hash_ops.hpte_insert(hpteg, vpn, hpaddr, rflags, vflags,
>  				       hpsize, hpsize, MMU_SEGSIZE_256M);
> =20
> -	if (ret < 0) {
> +	if (ret =3D=3D -1) {
>  		/* If we couldn't map a primary PTE, try a secondary */
>  		hash =3D ~hash;
>  		vflags ^=3D HPTE_V_SECONDARY;
>  		attempt++;
>  		goto map_again;
> +	} else if (ret < 0) {
> +		r =3D -EIO;
> +		goto out_unlock;
>  	} else {
>  		trace_kvm_book3s_64_mmu_map(rflags, hpteg,
>  					    vpn, hpaddr, orig_pte);
> diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
> index 633502f52bbb..ce437b98477e 100644
> --- a/arch/powerpc/kvm/book3s_pr.c
> +++ b/arch/powerpc/kvm/book3s_pr.c
> @@ -625,7 +625,11 @@ int kvmppc_handle_pagefault(struct kvm_run *run, str=
uct kvm_vcpu *vcpu,
>  			kvmppc_mmu_unmap_page(vcpu, &pte);
>  		}
>  		/* The guest's PTE is not mapped yet. Map on the host */
> -		kvmppc_mmu_map_page(vcpu, &pte, iswrite);
> +		if (kvmppc_mmu_map_page(vcpu, &pte, iswrite) =3D=3D -EIO) {
> +			/* Exit KVM if mapping failed */
> +			run->exit_reason =3D KVM_EXIT_INTERNAL_ERROR;
> +			return RESUME_HOST;
> +		}
>  		if (data)
>  			vcpu->stat.sp_storage++;
>  		else if (vcpu->arch.mmu.is_dcbz32(vcpu) &&

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--xSu31lw3TgkWXnjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY2EQJAAoJEGw4ysog2bOSX3EQANFs6X22DqZz2dt4FXuArM5J
zfdxoCY9CGpwdxFxE+PkKqivTeF/4I6/fuypUGRZrUeqOPavhrKAZn5TUfElBkyN
wb+F71bCuczKZzFdQcPbFXn5zCiPtjmE8gsWDiJGkwl/LibXQ5Z+MKPRbb4ZJcew
/T4F44eAg+fE0/nKoE1qpS8e1C0EGTTkAUOCJEAp3Ckq94vfFssFGLMhT6Ye0U2H
p7RLYAKzQ2QTlcus+hOpbnSEjWdEVCWwbg2SLnf59fRNY83TsDCPeSkJtSk4EH1Q
7QOVN/u9uEEoFVzAMNgRn27W0shAHIbVEwt1xjG9sACTFKUitzH8bU+Vf/gATqr+
jmABPULwRm3Bq2auHuc536kA5CIlDMqQXtDVGH8H7uZs5tDbjqg+JeNHbf10Tw17
pYy15fNSZBqCorYDGiBoTaq3NQ/emEiJlYyg4CxVjgn8bd1MQCGqHRxxt69O/QXJ
z2s/sNXqXt8in3SS243YGLARJJwcAPIAdwVLiqcNpdRsl7F61+vrpShvELn1NiAt
Hm31mDpIbkvOWeyMXtlBjC178URI0XUaPccxvZ8Plkmo0LvyMT2Cjt7kKdzjoUc4
Xk/X/Naig8hyd0gQaDXl3jixOd6LFXiH6xPlzWyq8LCV/WiT9hSmEO8GtMECRnav
pZ/24ZmplR7qsvXT4KFR
=emQb
-----END PGP SIGNATURE-----

--xSu31lw3TgkWXnjh--
