Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 894F21A02E6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jan 2016 16:36:33 +1100 (AEDT)
Date: Mon, 25 Jan 2016 16:37:27 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH kernel 4/4] KVM: PPC: Add support for 64bit TCE windows
Message-ID: <20160125053727.GE32205@voom.redhat.com>
References: <1453364126-22527-1-git-send-email-aik@ozlabs.ru>
 <1453364126-22527-5-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="JBi0ZxuS5uaEhkUZ"
In-Reply-To: <1453364126-22527-5-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--JBi0ZxuS5uaEhkUZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 21, 2016 at 07:15:26PM +1100, Alexey Kardashevskiy wrote:
> The existing KVM_CREATE_SPAPR_TCE only supports 32bit windows which is not
> enough for directly mapped windows as the guest can get more than 4GB.
>=20
> This adds KVM_CREATE_SPAPR_TCE_64 ioctl and advertises it
> via KVM_CAP_SPAPR_TCE_64 capability.
>=20
> Since 64bit windows are to support Dynamic DMA windows (DDW), let's add
> @bus_offset and @page_shift which are also required by DDW.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  Documentation/virtual/kvm/api.txt   | 32 ++++++++++++++++++++++++++++++++
>  arch/powerpc/include/asm/kvm_ppc.h  |  2 +-
>  arch/powerpc/include/uapi/asm/kvm.h |  9 +++++++++
>  arch/powerpc/kvm/book3s_64_vio.c    | 10 +++++++---
>  arch/powerpc/kvm/powerpc.c          | 25 ++++++++++++++++++++++++-
>  include/uapi/linux/kvm.h            |  2 ++
>  6 files changed, 75 insertions(+), 5 deletions(-)
>=20
> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kv=
m/api.txt
> index da39435..d1c5655 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -3060,6 +3060,38 @@ an implementation for these despite the in kernel =
acceleration.
> =20
>  This capability is always enabled.
> =20
> +4.96 KVM_CREATE_SPAPR_TCE_64
> +
> +Capability: KVM_CAP_SPAPR_TCE_64
> +Architectures: powerpc
> +Type: vm ioctl
> +Parameters: struct kvm_create_spapr_tce_64 (in)
> +Returns: file descriptor for manipulating the created TCE table
> +
> +This is an extension for KVM_CAP_SPAPR_TCE which only supports 32bit
> +windows, described in 4.62 KVM_CREATE_SPAPR_TCE
> +
> +This capability uses extended struct in ioctl interface:
> +
> +/* for KVM_CAP_SPAPR_TCE_64 */
> +struct kvm_create_spapr_tce_64 {
> +	__u64 liobn;
> +	__u32 page_shift;
> +	__u64 offset;	/* in pages */
> +	__u64 size; 	/* in pages */
> +	__u32 flags;

Best to move page_shift after offset and size, so the structure
doesn't get an alignment gap.

> +};
> +
> +The aim of extension is to support an additional bigger DMA window with
> +a variable page size.
> +KVM_CREATE_SPAPR_TCE_64 receives a 64bit window size, an IOMMU page shif=
t and
> +a bus offset of the corresponding DMA window, @size and @offset are numb=
ers
> +of IOMMU pages.
> +
> +@flags are not used at the moment.
> +
> +The rest of functionality is identical to KVM_CREATE_SPAPR_TCE.
> +
>  5. The kvm_run structure
>  ------------------------
> =20
> diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/as=
m/kvm_ppc.h
> index 4cadee5..6e4d1dc 100644
> --- a/arch/powerpc/include/asm/kvm_ppc.h
> +++ b/arch/powerpc/include/asm/kvm_ppc.h
> @@ -165,7 +165,7 @@ extern void kvmppc_map_vrma(struct kvm_vcpu *vcpu,
>  extern int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu);
> =20
>  extern long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
> -				struct kvm_create_spapr_tce *args);
> +				struct kvm_create_spapr_tce_64 *args);
>  extern struct kvmppc_spapr_tce_table *kvmppc_find_table(
>  		struct kvm_vcpu *vcpu, unsigned long liobn);
>  extern long kvmppc_ioba_validate(struct kvmppc_spapr_tce_table *stt,
> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/u=
api/asm/kvm.h
> index ab4d473..9c8b4cbc 100644
> --- a/arch/powerpc/include/uapi/asm/kvm.h
> +++ b/arch/powerpc/include/uapi/asm/kvm.h
> @@ -333,6 +333,15 @@ struct kvm_create_spapr_tce {
>  	__u32 window_size;
>  };
> =20
> +/* for KVM_CAP_SPAPR_TCE_64 */
> +struct kvm_create_spapr_tce_64 {
> +	__u64 liobn;
> +	__u32 page_shift;
> +	__u64 offset;	/* in pages */
> +	__u64 size;	/* in pages */
> +	__u32 flags;
> +};
> +
>  /* for KVM_ALLOCATE_RMA */
>  struct kvm_allocate_rma {
>  	__u64 rma_size;
> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_6=
4_vio.c
> index 85ee572..5479446 100644
> --- a/arch/powerpc/kvm/book3s_64_vio.c
> +++ b/arch/powerpc/kvm/book3s_64_vio.c
> @@ -144,20 +144,23 @@ static const struct file_operations kvm_spapr_tce_f=
ops =3D {
>  };
> =20
>  long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
> -				   struct kvm_create_spapr_tce *args)
> +				   struct kvm_create_spapr_tce_64 *args)
>  {
>  	struct kvmppc_spapr_tce_table *stt =3D NULL;
>  	unsigned long npages, size;
>  	int ret =3D -ENOMEM;
>  	int i;
> =20
> +	if (!args->size)
> +		return -EINVAL;
> +
>  	/* Check this LIOBN hasn't been previously allocated */
>  	list_for_each_entry(stt, &kvm->arch.spapr_tce_tables, list) {
>  		if (stt->liobn =3D=3D args->liobn)
>  			return -EBUSY;
>  	}
> =20
> -	size =3D args->window_size >> IOMMU_PAGE_SHIFT_4K;
> +	size =3D args->size;

Doesn't this need some kind of bounds on the allowed size?

>  	npages =3D kvmppc_stt_npages(size);
>  	ret =3D kvmppc_account_memlimit(npages, true);
>  	if (ret) {
> @@ -171,7 +174,8 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>  		goto fail;
> =20
>  	stt->liobn =3D args->liobn;
> -	stt->page_shift =3D IOMMU_PAGE_SHIFT_4K;
> +	stt->page_shift =3D args->page_shift;
> +	stt->offset =3D args->offset;
>  	stt->size =3D size;
>  	stt->kvm =3D kvm;
> =20
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 164735c..2b0fe92 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -33,6 +33,7 @@
>  #include <asm/tlbflush.h>
>  #include <asm/cputhreads.h>
>  #include <asm/irqflags.h>
> +#include <asm/iommu.h>
>  #include "timing.h"
>  #include "irq.h"
>  #include "../mm/mmu_decl.h"
> @@ -509,6 +510,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, lon=
g ext)
> =20
>  #ifdef CONFIG_PPC_BOOK3S_64
>  	case KVM_CAP_SPAPR_TCE:
> +	case KVM_CAP_SPAPR_TCE_64:
>  	case KVM_CAP_PPC_ALLOC_HTAB:
>  	case KVM_CAP_PPC_RTAS:
>  	case KVM_CAP_PPC_FIXUP_HCALL:
> @@ -1334,13 +1336,34 @@ long kvm_arch_vm_ioctl(struct file *filp,
>  		break;
>  	}
>  #ifdef CONFIG_PPC_BOOK3S_64
> +	case KVM_CREATE_SPAPR_TCE_64: {
> +		struct kvm_create_spapr_tce_64 create_tce_64;
> +
> +		r =3D -EFAULT;
> +		if (copy_from_user(&create_tce_64, argp, sizeof(create_tce_64)))
> +			goto out;
> +		if (create_tce_64.flags) {
> +			r =3D -EINVAL;
> +			goto out;
> +		}
> +		r =3D kvm_vm_ioctl_create_spapr_tce(kvm, &create_tce_64);
> +		goto out;
> +	}
>  	case KVM_CREATE_SPAPR_TCE: {
>  		struct kvm_create_spapr_tce create_tce;
> +		struct kvm_create_spapr_tce_64 create_tce_64;
> =20
>  		r =3D -EFAULT;
>  		if (copy_from_user(&create_tce, argp, sizeof(create_tce)))
>  			goto out;
> -		r =3D kvm_vm_ioctl_create_spapr_tce(kvm, &create_tce);
> +
> +		create_tce_64.liobn =3D create_tce.liobn;
> +		create_tce_64.page_shift =3D IOMMU_PAGE_SHIFT_4K;
> +		create_tce_64.offset =3D 0;
> +		create_tce_64.size =3D create_tce.window_size >>
> +				IOMMU_PAGE_SHIFT_4K;
> +		create_tce_64.flags =3D 0;
> +		r =3D kvm_vm_ioctl_create_spapr_tce(kvm, &create_tce_64);
>  		goto out;
>  	}
>  	case KVM_PPC_GET_SMMU_INFO: {
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 8ce5f64..b06208b 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1143,6 +1143,8 @@ struct kvm_s390_ucas_mapping {
>  /* Available with KVM_CAP_PPC_ALLOC_HTAB */
>  #define KVM_PPC_ALLOCATE_HTAB	  _IOWR(KVMIO, 0xa7, __u32)
>  #define KVM_CREATE_SPAPR_TCE	  _IOW(KVMIO,  0xa8, struct kvm_create_spap=
r_tce)
> +#define KVM_CREATE_SPAPR_TCE_64	  _IOW(KVMIO,  0xa8, \
> +				       struct kvm_create_spapr_tce_64)
>  /* Available with KVM_CAP_RMA */
>  #define KVM_ALLOCATE_RMA	  _IOR(KVMIO,  0xa9, struct kvm_allocate_rma)
>  /* Available with KVM_CAP_PPC_HTAB_FD */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--JBi0ZxuS5uaEhkUZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWpbSXAAoJEGw4ysog2bOSm9sP/0yfyG8Vn3oEbJrw2SN47BQe
CfpmSbdYu2VorItfuGilu0AGdSphcDgWN/tZ99a1AN1cSnVE6e/Zf3r+5W3LPCK/
Z9a+lvhLDv5Z18gi9v3GazewkZ87W8S++W2BlmVlWUehlbWw6axo5my/9r+NWDQm
OIdUTWIRBUrofL7wxygFUDDG8MCxnA7oGgixAcADDN53iltSv8IdSWBMTWY5g/Rk
pq3zXQPc6OqiZNX4zDt0fHgB5qFp7v1R4JLVArNL+bq5xVLX3a1h/O/ceJAwIIii
IgC7NDmV/vPhFIo8RuqVKmURd8iAL+BSVaMVSGtMNkHc0LBf6Sn919Tf2hzLrJpB
LhzufD6DRWRutu/MU+l7fxYFZO7QezNvB+IshdClwDmHQvEgWLwzCpSYVRMlTZ6J
wl3YmPFhC74kBLYHs/mbDlnHmpzkDG0PL5yPkb/mhOdHd6LR1PpXICdMhkPoXEQi
jI63E1rAU4wZoVqWwo++dhSCWcDNM5h/cLoLVLj1klLc0uEnlmt0wN7KZOlXWolb
vZ2mOPyXJ55LWwACdPdBUBV4I5pzaudmW2cNmzrto0FK3BwKT8SQlvhR1V4pfw1T
wRVm6ZX+pu5lihIEI/F+nBkWWG3ihSw/+PEczcU1RAgktN+dXXEVvSWhdMefmaeL
hejP0PmwKAGMDITEUwA8
=IS4Q
-----END PGP SIGNATURE-----

--JBi0ZxuS5uaEhkUZ--
