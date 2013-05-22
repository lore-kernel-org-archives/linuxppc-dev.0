Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5150C2C00A9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 May 2013 07:07:13 +1000 (EST)
Date: Wed, 22 May 2013 16:06:57 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/4] KVM: PPC: Add support for IOMMU in-kernel handling
To: Alexey Kardashevskiy <aik@ozlabs.ru>
In-Reply-To: <1369105607-20957-4-git-send-email-aik@ozlabs.ru> (from
 aik@ozlabs.ru on Mon May 20 22:06:46 2013)
Message-ID: <1369256817.1374.29@scott-Lenovo-G560>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Alexander Graf <agraf@suse.de>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/20/2013 10:06:46 PM, Alexey Kardashevskiy wrote:
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 8465c2a..da6bf61 100644
> --- a/arch/powerpc/kvm/powerpc.c
> @@ -396,6 +396,7 @@ int kvm_dev_ioctl_check_extension(long ext)
> +++ b/arch/powerpc/kvm/powerpc.c
>  		break;
>  #endif
>  	case KVM_CAP_SPAPR_MULTITCE:
> +	case KVM_CAP_SPAPR_TCE_IOMMU:
>  		r =3D 1;
>  		break;
>  	default:

Don't advertise SPAPR capabilities if it's not book3s -- and probably =20
there's some additional limitation that would be appropriate.

> @@ -1025,6 +1026,17 @@ long kvm_arch_vm_ioctl(struct file *filp,
>  		r =3D kvm_vm_ioctl_create_spapr_tce(kvm, &create_tce);
>  		goto out;
>  	}
> +	case KVM_CREATE_SPAPR_TCE_IOMMU: {
> +		struct kvm_create_spapr_tce_iommu create_tce_iommu;
> +		struct kvm *kvm =3D filp->private_data;
> +
> +		r =3D -EFAULT;
> +		if (copy_from_user(&create_tce_iommu, argp,
> +				sizeof(create_tce_iommu)))
> +			goto out;
> +		r =3D kvm_vm_ioctl_create_spapr_tce_iommu(kvm, =20
> &create_tce_iommu);
> +		goto out;
> +	}
>  #endif /* CONFIG_PPC_BOOK3S_64 */
>=20
>  #ifdef CONFIG_KVM_BOOK3S_64_HV
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 5a2afda..450c82a 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -667,6 +667,7 @@ struct kvm_ppc_smmu_info {
>  #define KVM_CAP_PPC_RTAS 91
>  #define KVM_CAP_IRQ_XICS 92
>  #define KVM_CAP_SPAPR_MULTITCE (0x110000 + 89)
> +#define KVM_CAP_SPAPR_TCE_IOMMU (0x110000 + 90)

Hmm...

> @@ -939,6 +940,9 @@ struct kvm_s390_ucas_mapping {
>  #define KVM_GET_DEVICE_ATTR	  _IOW(KVMIO,  0xe2, struct =20
> kvm_device_attr)
>  #define KVM_HAS_DEVICE_ATTR	  _IOW(KVMIO,  0xe3, struct =20
> kvm_device_attr)
>=20
> +/* ioctl for SPAPR TCE IOMMU */
> +#define KVM_CREATE_SPAPR_TCE_IOMMU _IOW(KVMIO,  0xe4, struct =20
> kvm_create_spapr_tce_iommu)

Shouldn't this go under the vm ioctl section?

-Scott=
