Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8D0602C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Feb 2014 02:46:44 +1100 (EST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH V3] KVM: PPC: BOOK3S: PR: Enable Little Endian PR guest
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1390891569-21161-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Thu, 6 Feb 2014 16:46:35 +0100
Message-Id: <F6CCE2DC-C5AF-4D89-89F5-01F4BC8A4C43@suse.de>
References: <1390891569-21161-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc <kvm-ppc@vger.kernel.org>,
 "kvm@vger.kernel.org mailing list" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 28.01.2014, at 07:46, Aneesh Kumar K.V =
<aneesh.kumar@linux.vnet.ibm.com> wrote:

> This patch make sure we inherit the LE bit correctly in different case
> so that we can run Little Endian distro in PR mode
>=20
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
> Changes from V2:
> * Move H_SET_MODE to qemu
>=20
>=20
> arch/powerpc/include/asm/kvm_host.h |  1 +
> arch/powerpc/kernel/asm-offsets.c   |  1 +
> arch/powerpc/kvm/book3s_64_mmu.c    |  2 +-
> arch/powerpc/kvm/book3s_pr.c        | 32 =
+++++++++++++++++++++++++++++++-
> 4 files changed, 34 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/kvm_host.h =
b/arch/powerpc/include/asm/kvm_host.h
> index 207b7826c9b1..f4be7be14330 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -550,6 +550,7 @@ struct kvm_vcpu_arch {
> #ifdef CONFIG_PPC_BOOK3S
> 	ulong fault_dar;
> 	u32 fault_dsisr;
> +	unsigned long intr_msr;

We already have a field with that name and semantics in the vcpu_arch =
struct. Just move that one to a more commonly accessible part of the =
struct.

> #endif
>=20
> #ifdef CONFIG_BOOKE
> diff --git a/arch/powerpc/kernel/asm-offsets.c =
b/arch/powerpc/kernel/asm-offsets.c
> index b754f629a177..7484676b8f25 100644
> --- a/arch/powerpc/kernel/asm-offsets.c
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@ -518,6 +518,7 @@ int main(void)
> 	DEFINE(VCPU_SLB_NR, offsetof(struct kvm_vcpu, arch.slb_nr));
> 	DEFINE(VCPU_FAULT_DSISR, offsetof(struct kvm_vcpu, =
arch.fault_dsisr));
> 	DEFINE(VCPU_FAULT_DAR, offsetof(struct kvm_vcpu, =
arch.fault_dar));
> +	DEFINE(VCPU_INTR_MSR, offsetof(struct kvm_vcpu, arch.intr_msr));

Same here:

arch/powerpc/kernel/asm-offsets.c:      DEFINE(VCPU_INTR_MSR, =
offsetof(struct kvm_vcpu, arch.intr_msr));

> 	DEFINE(VCPU_LAST_INST, offsetof(struct kvm_vcpu, =
arch.last_inst));
> 	DEFINE(VCPU_TRAP, offsetof(struct kvm_vcpu, arch.trap));
> 	DEFINE(VCPU_PTID, offsetof(struct kvm_vcpu, arch.ptid));
> diff --git a/arch/powerpc/kvm/book3s_64_mmu.c =
b/arch/powerpc/kvm/book3s_64_mmu.c
> index 83da1f868fd5..8231b83c493b 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu.c
> @@ -38,7 +38,7 @@
>=20
> static void kvmppc_mmu_book3s_64_reset_msr(struct kvm_vcpu *vcpu)
> {
> -	kvmppc_set_msr(vcpu, MSR_SF);
> +	kvmppc_set_msr(vcpu, vcpu->arch.intr_msr);
> }
>=20
> static struct kvmppc_slb *kvmppc_mmu_book3s_64_find_slbe(
> diff --git a/arch/powerpc/kvm/book3s_pr.c =
b/arch/powerpc/kvm/book3s_pr.c
> index eb070eb4da40..828056ec208f 100644
> --- a/arch/powerpc/kvm/book3s_pr.c
> +++ b/arch/powerpc/kvm/book3s_pr.c
> @@ -263,7 +263,7 @@ static void kvmppc_recalc_shadow_msr(struct =
kvm_vcpu *vcpu)
> 	ulong smsr =3D vcpu->arch.shared->msr;
>=20
> 	/* Guest MSR values */
> -	smsr &=3D MSR_FE0 | MSR_FE1 | MSR_SF | MSR_SE | MSR_BE;
> +	smsr &=3D MSR_FE0 | MSR_FE1 | MSR_SF | MSR_SE | MSR_BE | MSR_LE;
> 	/* Process MSR values */
> 	smsr |=3D MSR_ME | MSR_RI | MSR_IR | MSR_DR | MSR_PR | MSR_EE;
> 	/* External providers the guest reserved */
> @@ -1178,6 +1178,15 @@ static int kvmppc_get_one_reg_pr(struct =
kvm_vcpu *vcpu, u64 id,
> 		break;
> 	}
> #endif /* CONFIG_VSX */
> +	case KVM_REG_PPC_LPCR:
> +		/*
> +		 * We are only interested in the LPCR_ILE bit
> +		 */
> +		if (vcpu->arch.intr_msr & MSR_LE)
> +			*val =3D get_reg_val(id, LPCR_ILE);
> +		else
> +			*val =3D get_reg_val(id, 0);
> +		break;
> 	default:
> 		r =3D -EINVAL;
> 		break;
> @@ -1186,6 +1195,23 @@ static int kvmppc_get_one_reg_pr(struct =
kvm_vcpu *vcpu, u64 id,
> 	return r;
> }
>=20
> +static void kvmppc_set_lpcr_pr(struct kvm_vcpu *vcpu, u64 new_lpcr)
> +{
> +	struct kvm *kvm =3D vcpu->kvm;
> +	/*
> +	 * If ILE (interrupt little-endian) has changed, update the
> +	 * MSR_LE bit in the intr_msr for each vcpu in this vcore.
> +	 */
> +	if ((new_lpcr & LPCR_ILE) !=3D (vcpu->arch.intr_msr & MSR_LE)) {
> +		mutex_lock(&kvm->lock);

Why the lock?


Alex

> +		if (new_lpcr & LPCR_ILE)
> +			vcpu->arch.intr_msr |=3D MSR_LE;
> +		else
> +			vcpu->arch.intr_msr &=3D ~MSR_LE;
> +		mutex_unlock(&kvm->lock);
> +	}
> +}
> +
> static int kvmppc_set_one_reg_pr(struct kvm_vcpu *vcpu, u64 id,
> 				 union kvmppc_one_reg *val)
> {
> @@ -1209,6 +1235,9 @@ static int kvmppc_set_one_reg_pr(struct kvm_vcpu =
*vcpu, u64 id,
> 		break;
> 	}
> #endif /* CONFIG_VSX */
> +	case KVM_REG_PPC_LPCR:
> +		kvmppc_set_lpcr_pr(vcpu, set_reg_val(id, *val));
> +		break;
> 	default:
> 		r =3D -EINVAL;
> 		break;
> @@ -1261,6 +1290,7 @@ static struct kvm_vcpu =
*kvmppc_core_vcpu_create_pr(struct kvm *kvm,
> 	vcpu->arch.pvr =3D 0x3C0301;
> 	if (mmu_has_feature(MMU_FTR_1T_SEGMENT))
> 		vcpu->arch.pvr =3D mfspr(SPRN_PVR);
> +	vcpu->arch.intr_msr =3D MSR_SF;
> #else
> 	/* default to book3s_32 (750) */
> 	vcpu->arch.pvr =3D 0x84202;
> --=20
> 1.8.5.3
>=20
