Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rvWWQ05PTzDqR4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jul 2016 19:16:50 +1000 (AEST)
Date: Wed, 20 Jul 2016 19:16:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, aik@ozlabs.ru, mpe@ellerman.id.au,
 agraf@suse.de, qemu-devel@nongnu.org, paulus@samba.org
Subject: Re: [PATCH v2 1/1] KVM: PPC: Introduce KVM_CAP_PPC_HTM
Message-ID: <20160720091642.GD27358@voom.fritz.box>
References: <7286403003b30fc87740f1c1d6cb67d8f8eaafd7.1468986094.git.sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="q9KOos5vDmpwPx9o"
In-Reply-To: <7286403003b30fc87740f1c1d6cb67d8f8eaafd7.1468986094.git.sam.bobroff@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--q9KOos5vDmpwPx9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 20, 2016 at 01:41:36PM +1000, Sam Bobroff wrote:
> Introduce a new KVM capability, KVM_CAP_PPC_HTM, that can be queried to
> determine if a PowerPC KVM guest should use HTM (Hardware Transactional
> Memory).
>=20
> This will be used by QEMU to populate the pa-features bits in the
> guest's device tree.
>=20
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>=20
> v2:
>=20
> * Use CPU_FTR_TM_COMP instead of CPU_FTR_TM.
> * I didn't unbreak the line, as with the extra characters checkpatch will
>   complain if I do. I did move the break to a more usual place.
>=20
>  arch/powerpc/kvm/powerpc.c | 4 ++++
>  include/uapi/linux/kvm.h   | 1 +
>  2 files changed, 5 insertions(+)
>=20
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 02416fe..5ebc8ff 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -588,6 +588,10 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, lo=
ng ext)
>  		r =3D 1;
>  		break;
>  #endif
> +	case KVM_CAP_PPC_HTM:
> +		r =3D cpu_has_feature(CPU_FTR_TM_COMP) &&
> +		    is_kvmppc_hv_enabled(kvm);
> +		break;
>  	default:
>  		r =3D 0;
>  		break;
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 05ebf47..f421d0e 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -866,6 +866,7 @@ struct kvm_ppc_smmu_info {
>  #define KVM_CAP_ARM_PMU_V3 126
>  #define KVM_CAP_VCPU_ATTRIBUTES 127
>  #define KVM_CAP_MAX_VCPU_ID 128
> +#define KVM_CAP_PPC_HTM 129
> =20
>  #ifdef KVM_CAP_IRQ_ROUTING
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--q9KOos5vDmpwPx9o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXj0F5AAoJEGw4ysog2bOSXtwQAIeVu6nVCDZgod/lmktXo+Te
Pv9OSxoOLgyfw+pIWIEODBb71RRler0+7WQf7QhSO1n8cCXxJ0SijENDfXgHkQef
d+y4oKZyTXem9c9ZBf4KxupXja0O3Lxc3er7j1fKNKp16pRuVyOzI+v7lUjLat0I
hgZwxIQhMcyJeddz0ijYc/GM4wj6SuUaktzNb1Q6ZuHLODy4Ewga5Z82kMna683W
iWcKE0A2OYEQJC3OSeDFv07Lw5rPkU6kdh/Yfk3sYjmkYE0RQ7FLEmS1/6n9KVRL
VEkaMZALTPCmgvu1/b5O2r7JJl7kYHkysAH9nvRWssVM0n/mofB7YsSkJWN02Ll8
5kcM2LADcyVVEKXZko1Wao13TuFMcG1WbMuJj54akKqVom9qEC97lG2xIUmlQQYb
hIitaGnB2AqVXJscBY64T8UcAumupW5waJgg/wdiwK9NufdgH4gud/i+2JucflBu
3GHCqLCt9fH6ilGI2eKqG3UXg6o4pa8KVCGxByMtU3VWSS6s0ttgoMDt3qfkzUBB
pfeaidcaInU2hH2fhLwzVAlLTv01QPfogmm/oCMvwCFWblJf0w9AD1h3JHThooaa
Ffd5Jb30caK1ucD5y8wuKbZ+qfXNSyD5dA4uTEpNY1wlC7NYQFRmla0/y0hsePV/
G3Rm844v7pQcPjSNq5Bj
=BTPv
-----END PGP SIGNATURE-----

--q9KOos5vDmpwPx9o--
