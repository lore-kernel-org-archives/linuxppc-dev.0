Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6946A2C009B
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Dec 2012 00:28:31 +1100 (EST)
Subject: Re: [PATCH 05/12] KVM: PPC: e500: Add emulation helper for getting
 instruction ea
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1349972009-23027-6-git-send-email-mihai.caraman@freescale.com>
Date: Sat, 1 Dec 2012 14:28:21 +0100
Message-Id: <5CA8A52E-D775-495F-8F57-6F9CCD9611A0@suse.de>
References: <1349972009-23027-1-git-send-email-mihai.caraman@freescale.com>
 <1349972009-23027-6-git-send-email-mihai.caraman@freescale.com>
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

> Add emulation helper for getting instruction ea and refactor tlb =
instruction
> emulation to use it.
>=20
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> ---
> v1: use _t_ype instead of _t_arget _r_egister in tlbilx emulation.
>=20
> arch/powerpc/include/asm/kvm_ppc.h |   11 +++++++++++
> arch/powerpc/kvm/e500.h            |    6 +++---
> arch/powerpc/kvm/e500_emulate.c    |   15 ++++++++++-----
> arch/powerpc/kvm/e500_tlb.c        |   33 =
+++++++++++----------------------
> 4 files changed, 35 insertions(+), 30 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/kvm_ppc.h =
b/arch/powerpc/include/asm/kvm_ppc.h
> index 609cca3..a08e756 100644
> --- a/arch/powerpc/include/asm/kvm_ppc.h
> +++ b/arch/powerpc/include/asm/kvm_ppc.h
> @@ -293,4 +293,15 @@ static inline void kvmppc_lazy_ee_enable(void)
> #endif
> }
>=20
> +static inline ulong kvmppc_get_ea_indexed(struct kvm_vcpu *vcpu, int =
ra, int rb)
> +{
> +	ulong ea;
> +
> +	ea =3D kvmppc_get_gpr(vcpu, rb);
> +	if (ra)
> +		ea +=3D kvmppc_get_gpr(vcpu, ra);
> +
> +	return ea;
> +}
> +
> #endif /* __POWERPC_KVM_PPC_H__ */
> diff --git a/arch/powerpc/kvm/e500.h b/arch/powerpc/kvm/e500.h
> index d162286..32e98a7 100644
> --- a/arch/powerpc/kvm/e500.h
> +++ b/arch/powerpc/kvm/e500.h
> @@ -129,9 +129,9 @@ int kvmppc_e500_emul_mt_mmucsr0(struct =
kvmppc_vcpu_e500 *vcpu_e500,
> 				ulong value);
> int kvmppc_e500_emul_tlbwe(struct kvm_vcpu *vcpu);
> int kvmppc_e500_emul_tlbre(struct kvm_vcpu *vcpu);
> -int kvmppc_e500_emul_tlbivax(struct kvm_vcpu *vcpu, int ra, int rb);
> -int kvmppc_e500_emul_tlbilx(struct kvm_vcpu *vcpu, int rt, int ra, =
int rb);
> -int kvmppc_e500_emul_tlbsx(struct kvm_vcpu *vcpu, int rb);
> +int kvmppc_e500_emul_tlbivax(struct kvm_vcpu *vcpu, gva_t ea);
> +int kvmppc_e500_emul_tlbilx(struct kvm_vcpu *vcpu, int type, gva_t =
ea);
> +int kvmppc_e500_emul_tlbsx(struct kvm_vcpu *vcpu, gva_t ea);
> int kvmppc_e500_tlb_init(struct kvmppc_vcpu_e500 *vcpu_e500);
> void kvmppc_e500_tlb_uninit(struct kvmppc_vcpu_e500 *vcpu_e500);
>=20
> diff --git a/arch/powerpc/kvm/e500_emulate.c =
b/arch/powerpc/kvm/e500_emulate.c
> index e04b0ef..3bf2486 100644
> --- a/arch/powerpc/kvm/e500_emulate.c
> +++ b/arch/powerpc/kvm/e500_emulate.c
> @@ -88,7 +88,7 @@ int kvmppc_core_emulate_op(struct kvm_run *run, =
struct kvm_vcpu *vcpu,
> 	int emulated =3D EMULATE_DONE;
> 	int ra =3D get_ra(inst);
> 	int rb =3D get_rb(inst);
> -	int rt =3D get_rt(inst);

The function scope rt variable shouldn't hurt, as the compiler will be =
smart enough to only calculate it when it's actually used.

> +	gva_t ea;
>=20
> 	switch (get_op(inst)) {
> 	case 31:
> @@ -113,15 +113,20 @@ int kvmppc_core_emulate_op(struct kvm_run *run, =
struct kvm_vcpu *vcpu,
> 			break;
>=20
> 		case XOP_TLBSX:
> -			emulated =3D kvmppc_e500_emul_tlbsx(vcpu,rb);
> +			ea =3D kvmppc_get_ea_indexed(vcpu, ra, rb);
> +			emulated =3D kvmppc_e500_emul_tlbsx(vcpu, ea);
> 			break;
>=20
> -		case XOP_TLBILX:
> -			emulated =3D kvmppc_e500_emul_tlbilx(vcpu, rt, =
ra, rb);
> +		case XOP_TLBILX: {
> +			int t =3D (inst >> 21) & 0x3;

so we can remove this

> +			ea =3D kvmppc_get_ea_indexed(vcpu, ra, rb);
> +			emulated =3D kvmppc_e500_emul_tlbilx(vcpu, t, =
ea);

and instead here pass rt & 3.

The rest of the patch looks fine, so I'll do the change while applying =
it.


Alex
