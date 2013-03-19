Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe003.messaging.microsoft.com [216.32.180.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4B7072C0156
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2013 04:26:37 +1100 (EST)
Date: Tue, 19 Mar 2013 12:26:25 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] KVM: PPC: e500: Expose MMU registers via ONE_REG
To: Mihai Caraman <mihai.caraman@freescale.com>
In-Reply-To: <1363713431-27926-1-git-send-email-mihai.caraman@freescale.com>
 (from mihai.caraman@freescale.com on Tue Mar 19 12:17:11 2013)
Message-ID: <1363713985.16671.12@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/19/2013 12:17:11 PM, Mihai Caraman wrote:
> diff --git a/arch/powerpc/kvm/e500_mmu.c b/arch/powerpc/kvm/e500_mmu.c
> index 66b6e31..b77b855 100644
> --- a/arch/powerpc/kvm/e500_mmu.c
> +++ b/arch/powerpc/kvm/e500_mmu.c
> @@ -596,6 +596,95 @@ int kvmppc_set_sregs_e500_tlb(struct kvm_vcpu =20
> *vcpu, struct kvm_sregs *sregs)
>  	return 0;
>  }
>=20
> +int kvmppc_get_one_reg_500_tlb(struct kvm_vcpu *vcpu, u64 id,
> +				union kvmppc_one_reg *val)

s/500/e500/

> +int kvmppc_set_one_reg_500_tlb(struct kvm_vcpu *vcpu, u64 id,
> +			       union kvmppc_one_reg *val)
> +{
> +	int r =3D 0;
> +	long int i;
> +
> +	switch (id) {
> +	case KVM_REG_PPC_MAS0:
> +		vcpu->arch.shared->mas0 =3D set_reg_val(id, *val);
> +		break;
> +	case KVM_REG_PPC_MAS1:
> +		vcpu->arch.shared->mas1 =3D set_reg_val(id, *val);
> +		break;
> +	case KVM_REG_PPC_MAS2:
> +		vcpu->arch.shared->mas2 =3D set_reg_val(id, *val);
> +		break;
> +	case KVM_REG_PPC_MAS7_3:
> +		vcpu->arch.shared->mas7_3 =3D set_reg_val(id, *val);
> +		break;
> +	case KVM_REG_PPC_MAS4:
> +		vcpu->arch.shared->mas4 =3D set_reg_val(id, *val);
> +		break;
> +	case KVM_REG_PPC_MAS6:
> +		vcpu->arch.shared->mas6 =3D set_reg_val(id, *val);
> +		break;
> +	case KVM_REG_PPC_MMUCFG: {
> +		u32 mmucfg =3D set_reg_val(id, *val);
> +		vcpu->arch.mmucfg =3D mmucfg & ~MMUCFG_LPIDSIZE;
> +		break;
> +	}

Do we really want to allow arbitrary MMUCFG changes?  It won't =20
magically make us able to support larger RAs, PIDs, different MAVN, etc.

> +	case KVM_REG_PPC_TLB0CFG:
> +	case KVM_REG_PPC_TLB1CFG:
> +	case KVM_REG_PPC_TLB2CFG:
> +	case KVM_REG_PPC_TLB3CFG: {
> +		u32 tlbncfg =3D set_reg_val(id, =20
> *val);			=09
> +		u32 geometry_mask =3D TLBnCFG_N_ENTRY | TLBnCFG_ASSOC;
> +		i =3D id - KVM_REG_PPC_TLB0CFG;
> +
> +		/* MMU geometry (way/size) can be set only using SW_TLB =20
> */
> +		if ((vcpu->arch.tlbcfg[i] & geometry_mask) !=3D
> +		    (tlbncfg & geometry_mask))
> +			r =3D -EINVAL;
> +
> +		vcpu->arch.tlbcfg[i] =3D set_reg_val(id, *val);
> +		break;
> +	}

Likewise -- just because QEMU sets a bit here doesn't mean KVM can =20
support it.

I thought the initial plan for setting these config registers was to =20
accept it if it exactly matches what KVM already has, and give an error =20
otherwise -- thus allowing for the possibliity of accepting certain =20
specific updates in the future.

-Scott=
