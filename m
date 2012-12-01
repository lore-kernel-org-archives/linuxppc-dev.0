Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 79EA22C00A5
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Dec 2012 01:15:11 +1100 (EST)
Subject: Re: [PATCH 12/12] KVM: PPC: booke: Get/set guest EPCR register using
 ONE_REG interface
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1349972009-23027-13-git-send-email-mihai.caraman@freescale.com>
Date: Sat, 1 Dec 2012 15:15:04 +0100
Message-Id: <AE131F8B-E781-4E89-B70A-19393C4905DB@suse.de>
References: <1349972009-23027-1-git-send-email-mihai.caraman@freescale.com>
 <1349972009-23027-13-git-send-email-mihai.caraman@freescale.com>
To: Mihai Caraman <mihai.caraman@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 11.10.2012, at 18:13, Mihai Caraman wrote:

> Implement ONE_REG interface for EPCR register adding KVM_REG_PPC_EPCR =
to
> the list of ONE_REG PPC supported registers.
>=20
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> ---
> Documentation/virtual/kvm/api.txt |    1 +
> arch/powerpc/include/asm/kvm.h    |    2 ++
> arch/powerpc/kvm/booke.c          |   16 ++++++++++++++++
> 3 files changed, 19 insertions(+), 0 deletions(-)
>=20
> diff --git a/Documentation/virtual/kvm/api.txt =
b/Documentation/virtual/kvm/api.txt
> index e726d76..c78dff4 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -1773,6 +1773,7 @@ registers, find a list below:
>   PPC   | KVM_REG_PPC_VPA_ADDR  | 64
>   PPC   | KVM_REG_PPC_VPA_SLB   | 128
>   PPC   | KVM_REG_PPC_VPA_DTL   | 128
> +  PPC   | KVM_REG_PPC_EPCR	| 32
>=20
> 4.69 KVM_GET_ONE_REG
>=20
> diff --git a/arch/powerpc/include/asm/kvm.h =
b/arch/powerpc/include/asm/kvm.h
> index b89ae4d..beb6b20 100644
> --- a/arch/powerpc/include/asm/kvm.h
> +++ b/arch/powerpc/include/asm/kvm.h
> @@ -386,4 +386,6 @@ struct kvm_book3e_206_tlb_params {
> #define KVM_REG_PPC_VPA_SLB	(KVM_REG_PPC | KVM_REG_SIZE_U128 | 0x83)
> #define KVM_REG_PPC_VPA_DTL	(KVM_REG_PPC | KVM_REG_SIZE_U128 | 0x84)
>=20
> +#define KVM_REG_PPC_EPCR	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x85)
> +
> #endif /* __LINUX_KVM_POWERPC_H */
> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index d396374..60b8237 100644
> --- a/arch/powerpc/kvm/booke.c
> +++ b/arch/powerpc/kvm/booke.c
> @@ -1395,6 +1395,12 @@ int kvm_vcpu_ioctl_get_one_reg(struct kvm_vcpu =
*vcpu, struct kvm_one_reg *reg)
> 				 &vcpu->arch.dbg_reg.dac[dac], =
sizeof(u64));
> 		break;
> 	}
> +#if defined(CONFIG_64BIT) && defined(CONFIG_KVM_BOOKE_HV)

No need for the HV dependency here.

> +	case KVM_REG_PPC_EPCR:
> +		r =3D copy_to_user((u32 __user *)(long)reg->addr,
> +				 &vcpu->arch.epcr, sizeof(u32));

This can be put_user. The reason we don't do it for the other ONE_REG =
variables is that they are u64s which can't be put_user'd on 32bit =
systems.

> +		break;
> +#endif
> 	default:
> 		break;
> 	}
> @@ -1422,6 +1428,16 @@ int kvm_vcpu_ioctl_set_one_reg(struct kvm_vcpu =
*vcpu, struct kvm_one_reg *reg)
> 			     (u64 __user *)(long)reg->addr, =
sizeof(u64));
> 		break;
> 	}
> +#if defined(CONFIG_64BIT) && defined(CONFIG_KVM_BOOKE_HV)

Same as above

> +	case KVM_REG_PPC_EPCR: {
> +		u32 new_epcr;
> +		r =3D copy_from_user(&new_epcr,
> +			     (u32 __user *)(long)reg->addr, =
sizeof(u32));

Same as above.

I'll fix those up for you when applying the patch.


Alex

> +		if (r =3D=3D 0)
> +			kvmppc_set_epcr(vcpu, new_epcr);
> +		break;
> +	}
> +#endif
> 	default:
> 		break;
> 	}
> --=20
> 1.7.4.1
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
