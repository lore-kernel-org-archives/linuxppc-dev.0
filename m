Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BA42D1A0060
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 16:50:26 +1100 (AEDT)
Date: Wed, 9 Mar 2016 16:45:44 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH kernel 9/9] KVM: PPC: VFIO device: support SPAPR TCE
Message-ID: <20160309054544.GM22546@voom.fritz.box>
References: <1457322077-26640-1-git-send-email-aik@ozlabs.ru>
 <1457322077-26640-10-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="V/VNt6jARIhH3MER"
In-Reply-To: <1457322077-26640-10-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--V/VNt6jARIhH3MER
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 07, 2016 at 02:41:17PM +1100, Alexey Kardashevskiy wrote:
> sPAPR TCE IOMMU is para-virtualized and the guest does map/unmap
> via hypercalls which take a logical bus id (LIOBN) as a target IOMMU
> identifier. LIOBNs are made up, advertised to guest systems and
> linked to IOMMU groups by the user space.
> In order to enable acceleration for IOMMU operations in KVM, we need
> to tell KVM the information about the LIOBN-to-group mapping.
>=20
> For that, a new KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE_LIOBN parameter
> is added which accepts:
> - a VFIO group fd and IO base address to find the actual hardware
> TCE table;
> - a LIOBN to assign to the found table.
>=20
> Before notifying KVM about new link, this check the group for being
> registered with KVM device in order to release them at unexpected KVM
> finish.
>=20
> This advertises the new KVM_CAP_SPAPR_TCE_VFIO capability to the user
> space.
>=20
> While we are here, this also fixes VFIO KVM device compiling to let it
> link to a KVM module.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  Documentation/virtual/kvm/devices/vfio.txt |  21 +++++-
>  arch/powerpc/kvm/Kconfig                   |   1 +
>  arch/powerpc/kvm/Makefile                  |   5 +-
>  arch/powerpc/kvm/powerpc.c                 |   1 +
>  include/uapi/linux/kvm.h                   |   9 +++
>  virt/kvm/vfio.c                            | 106 +++++++++++++++++++++++=
++++++
>  6 files changed, 140 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/virtual/kvm/devices/vfio.txt b/Documentation/v=
irtual/kvm/devices/vfio.txt
> index ef51740..c0d3eb7 100644
> --- a/Documentation/virtual/kvm/devices/vfio.txt
> +++ b/Documentation/virtual/kvm/devices/vfio.txt
> @@ -16,7 +16,24 @@ Groups:
> =20
>  KVM_DEV_VFIO_GROUP attributes:
>    KVM_DEV_VFIO_GROUP_ADD: Add a VFIO group to VFIO-KVM device tracking
> +	kvm_device_attr.addr points to an int32_t file descriptor
> +	for the VFIO group.

AFAICT these changes are accurate for VFIO as it is already, in which
case it might be clearer to put them in a separate patch.

>    KVM_DEV_VFIO_GROUP_DEL: Remove a VFIO group from VFIO-KVM device track=
ing
> +	kvm_device_attr.addr points to an int32_t file descriptor
> +	for the VFIO group.
> =20
> -For each, kvm_device_attr.addr points to an int32_t file descriptor
> -for the VFIO group.
> +  KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE_LIOBN: sets a liobn for a VFIO group
> +	kvm_device_attr.addr points to a struct:
> +		struct kvm_vfio_spapr_tce_liobn {
> +			__u32	argsz;
> +			__s32	fd;
> +			__u32	liobn;
> +			__u8	pad[4];
> +			__u64	start_addr;
> +		};
> +		where
> +		@argsz is the size of kvm_vfio_spapr_tce_liobn;
> +		@fd is a file descriptor for a VFIO group;
> +		@liobn is a logical bus id to be associated with the group;
> +		@start_addr is a DMA window offset on the IO (PCI) bus

For the cause of DDW and multiple windows, I'm assuming you can call
this multiple times with different LIOBNs and the same IOMMU group?

> diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
> index 1059846..dfa3488 100644
> --- a/arch/powerpc/kvm/Kconfig
> +++ b/arch/powerpc/kvm/Kconfig
> @@ -65,6 +65,7 @@ config KVM_BOOK3S_64
>  	select KVM
>  	select KVM_BOOK3S_PR_POSSIBLE if !KVM_BOOK3S_HV_POSSIBLE
>  	select SPAPR_TCE_IOMMU if IOMMU_SUPPORT
> +	select KVM_VFIO if VFIO
>  	---help---
>  	  Support running unmodified book3s_64 and book3s_32 guest kernels
>  	  in virtual machines on book3s_64 host processors.
> diff --git a/arch/powerpc/kvm/Makefile b/arch/powerpc/kvm/Makefile
> index 7f7b6d8..71f577c 100644
> --- a/arch/powerpc/kvm/Makefile
> +++ b/arch/powerpc/kvm/Makefile
> @@ -8,7 +8,7 @@ ccflags-y :=3D -Ivirt/kvm -Iarch/powerpc/kvm
>  KVM :=3D ../../../virt/kvm
> =20
>  common-objs-y =3D $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o \
> -		$(KVM)/eventfd.o $(KVM)/vfio.o
> +		$(KVM)/eventfd.o

Please don't disable the VFIO device for the non-book3s case.  I added
it (even though it didn't do anything until now) so that libvirt
wouldn't choke when it finds it's not available.  Obviously the new
ioctl needs to be only for the right IOMMU setup, but the device
itself should be available always.

>  CFLAGS_e500_mmu.o :=3D -I.
>  CFLAGS_e500_mmu_host.o :=3D -I.
> @@ -87,6 +87,9 @@ endif
>  kvm-book3s_64-objs-$(CONFIG_KVM_XICS) +=3D \
>  	book3s_xics.o
> =20
> +kvm-book3s_64-objs-$(CONFIG_KVM_VFIO) +=3D \
> +	$(KVM)/vfio.o \
> +
>  kvm-book3s_64-module-objs +=3D \
>  	$(KVM)/kvm_main.o \
>  	$(KVM)/eventfd.o \
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 19aa59b..63f188d 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -521,6 +521,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, lon=
g ext)
>  #ifdef CONFIG_PPC_BOOK3S_64
>  	case KVM_CAP_SPAPR_TCE:
>  	case KVM_CAP_SPAPR_TCE_64:
> +	case KVM_CAP_SPAPR_TCE_VFIO:
>  	case KVM_CAP_PPC_ALLOC_HTAB:
>  	case KVM_CAP_PPC_RTAS:
>  	case KVM_CAP_PPC_FIXUP_HCALL:
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 080ffbf..f1abbea 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1056,6 +1056,7 @@ struct kvm_device_attr {
>  #define  KVM_DEV_VFIO_GROUP			1
>  #define   KVM_DEV_VFIO_GROUP_ADD			1
>  #define   KVM_DEV_VFIO_GROUP_DEL			2
> +#define   KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE_LIOBN	3
> =20
>  enum kvm_device_type {
>  	KVM_DEV_TYPE_FSL_MPIC_20	=3D 1,
> @@ -1075,6 +1076,14 @@ enum kvm_device_type {
>  	KVM_DEV_TYPE_MAX,
>  };
> =20
> +struct kvm_vfio_spapr_tce_liobn {
> +	__u32	argsz;
> +	__s32	fd;
> +	__u32	liobn;
> +	__u8	pad[4];
> +	__u64	start_addr;
> +};
> +
>  /*
>   * ioctls for VM fds
>   */
> diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
> index 1dd087d..87c771e 100644
> --- a/virt/kvm/vfio.c
> +++ b/virt/kvm/vfio.c
> @@ -20,6 +20,10 @@
>  #include <linux/vfio.h>
>  #include "vfio.h"
> =20
> +#ifdef CONFIG_SPAPR_TCE_IOMMU
> +#include <asm/kvm_ppc.h>
> +#endif
> +
>  struct kvm_vfio_group {
>  	struct list_head node;
>  	struct vfio_group *vfio_group;
> @@ -60,6 +64,22 @@ static void kvm_vfio_group_put_external_user(struct vf=
io_group *vfio_group)
>  	symbol_put(vfio_group_put_external_user);
>  }
> =20
> +static int kvm_vfio_external_user_iommu_id(struct vfio_group *vfio_group)
> +{
> +	int (*fn)(struct vfio_group *);
> +	int ret =3D -1;

Should this be -ESOMETHING?

> +	fn =3D symbol_get(vfio_external_user_iommu_id);
> +	if (!fn)
> +		return ret;
> +
> +	ret =3D fn(vfio_group);
> +
> +	symbol_put(vfio_external_user_iommu_id);
> +
> +	return ret;
> +}
> +
>  static bool kvm_vfio_group_is_coherent(struct vfio_group *vfio_group)
>  {
>  	long (*fn)(struct vfio_group *, unsigned long);
> @@ -110,6 +130,22 @@ static void kvm_vfio_update_coherency(struct kvm_dev=
ice *dev)
>  	mutex_unlock(&kv->lock);
>  }
> =20
> +#ifdef CONFIG_SPAPR_TCE_IOMMU
> +static void kvm_vfio_spapr_detach_iommu_group(struct kvm *kvm,
> +		struct vfio_group *vfio_group)


Shouldn't this go in the same patch that introduced the attach
function?

> +{
> +	int group_id;
> +	struct iommu_group *grp;
> +
> +	group_id =3D kvm_vfio_external_user_iommu_id(vfio_group);
> +	grp =3D iommu_group_get_by_id(group_id);
> +	if (grp) {
> +		kvm_spapr_tce_detach_iommu_group(kvm, grp);
> +		iommu_group_put(grp);
> +	}
> +}
> +#endif
> +
>  static int kvm_vfio_set_group(struct kvm_device *dev, long attr, u64 arg)
>  {
>  	struct kvm_vfio *kv =3D dev->private;
> @@ -186,6 +222,10 @@ static int kvm_vfio_set_group(struct kvm_device *dev=
, long attr, u64 arg)
>  				continue;
> =20
>  			list_del(&kvg->node);
> +#ifdef CONFIG_SPAPR_TCE_IOMMU

Better to make a no-op version of the call than have to #ifdef at the
callsite.

> +			kvm_vfio_spapr_detach_iommu_group(dev->kvm,
> +					kvg->vfio_group);
> +#endif
>  			kvm_vfio_group_put_external_user(kvg->vfio_group);
>  			kfree(kvg);
>  			ret =3D 0;
> @@ -201,6 +241,69 @@ static int kvm_vfio_set_group(struct kvm_device *dev=
, long attr, u64 arg)
>  		kvm_vfio_update_coherency(dev);
> =20
>  		return ret;
> +
> +#ifdef CONFIG_SPAPR_TCE_IOMMU
> +	case KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE_LIOBN: {
> +		struct kvm_vfio_spapr_tce_liobn param;
> +		unsigned long minsz;
> +		struct kvm_vfio *kv =3D dev->private;
> +		struct vfio_group *vfio_group;
> +		struct kvm_vfio_group *kvg;
> +		struct fd f;
> +
> +		minsz =3D offsetofend(struct kvm_vfio_spapr_tce_liobn,
> +				start_addr);
> +
> +		if (copy_from_user(&param, (void __user *)arg, minsz))
> +			return -EFAULT;
> +
> +		if (param.argsz < minsz)
> +			return -EINVAL;
> +
> +		f =3D fdget(param.fd);
> +		if (!f.file)
> +			return -EBADF;
> +
> +		vfio_group =3D kvm_vfio_group_get_external_user(f.file);
> +		fdput(f);
> +
> +		if (IS_ERR(vfio_group))
> +			return PTR_ERR(vfio_group);
> +
> +		ret =3D -ENOENT;

Shouldn't there be some runtime test for the type of the IOMMU?  It's
possible a kernel could be built for a platform supporting multiple
IOMMU types.

> +		mutex_lock(&kv->lock);
> +
> +		list_for_each_entry(kvg, &kv->group_list, node) {
> +			int group_id;
> +			struct iommu_group *grp;
> +
> +			if (kvg->vfio_group !=3D vfio_group)
> +				continue;
> +
> +			group_id =3D kvm_vfio_external_user_iommu_id(
> +					kvg->vfio_group);
> +			grp =3D iommu_group_get_by_id(group_id);
> +			if (!grp) {
> +				ret =3D -EFAULT;
> +				break;
> +			}
> +
> +			ret =3D kvm_spapr_tce_attach_iommu_group(dev->kvm,
> +					param.liobn, param.start_addr,
> +					grp);
> +			if (ret)
> +				iommu_group_put(grp);
> +			break;
> +		}
> +
> +		mutex_unlock(&kv->lock);
> +
> +		kvm_vfio_group_put_external_user(vfio_group);
> +
> +		return ret;
> +	}
> +#endif /* CONFIG_SPAPR_TCE_IOMMU */
>  	}
> =20
>  	return -ENXIO;
> @@ -225,6 +328,9 @@ static int kvm_vfio_has_attr(struct kvm_device *dev,
>  		switch (attr->attr) {
>  		case KVM_DEV_VFIO_GROUP_ADD:
>  		case KVM_DEV_VFIO_GROUP_DEL:
> +#ifdef CONFIG_SPAPR_TCE_IOMMU
> +		case KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE_LIOBN:
> +#endif
>  			return 0;
>  		}
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--V/VNt6jARIhH3MER
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW37iIAAoJEGw4ysog2bOSCu8P/3lIQCTxPxPv9aM5IeBYsV8W
5Jmwpx11D9yO4iq4GCHzSLcOA8Qc/Uk8wxe6HjKaJub762UzSKgnznV2MHgY66bo
mCcAz8H+jL5RngXMJKJ/fU27GXsuOL2ZJo8SdJlBbRtfnShInAli9xIvPRiAu5iI
TP1+xm14w7+FHOk8dPOQsigyD64zOmqTGobmCeYox+N53CEUgDnblgR6o8Ndg6FK
rwMsAdB+lPoBPFogMIVMK70MHz6OJVpNKx4A7svWFiFersM3SfKrTwoaurJdGGn8
kK+FpAKPP4g3ZaW0oCpt4VifmBp6dBGA/T6bK+uXkTSH/sxrC7YPLclcVrRTDpUg
F8Ro6gjCXhHq9ghN5NIiIfKhVxvVQGC9Ur45h7hHQZ4yrPN1rpwRcva1WaWJL5sr
V0WhoCt/Q0f4wky/rPk+2Fvj+fILZ04Do848220s5444hdVKWcuWheA0vvx7lfU5
QNjyiHbSMUIC2leNKaDvXt+BPOdrNBeGdvxKxSxDZo6GB0Yd5KD0XCWrrP//ub6r
f6fDzP3UUX+3m1Tk5swJ72ArULE2PmEJvyeL4Wz+BYPrQLneW/1ykL1g46gxYi9B
5TCBVSe7NXaeClRfxm5fRUAtCIpPHl+9T3WuRq1+PXOztsn5ASh0Qi2Fn9yoTLbP
vKbyC8S6xxzuajZTxrUW
=sjUh
-----END PGP SIGNATURE-----

--V/VNt6jARIhH3MER--
