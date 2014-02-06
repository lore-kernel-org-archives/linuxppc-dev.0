Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 505AB2C009C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Feb 2014 02:52:27 +1100 (EST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH V3] POWERPC: BOOK3S: KVM: Use the saved dsisr and dar
 values on book3s 64
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1390891190-20186-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Thu, 6 Feb 2014 16:52:20 +0100
Message-Id: <B9A06A28-6DAD-40FE-B66F-41DDC3C30CD5@suse.de>
References: <1390891190-20186-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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


On 28.01.2014, at 07:39, Aneesh Kumar K.V =
<aneesh.kumar@linux.vnet.ibm.com> wrote:

> Although it's optional IBM POWER cpus always had DAR value set on
> alignment interrupt. So don't try to compute these values.
>=20
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
> Changes from V2:
> * Depend on cpu feature flag to decide whether to use fault_dsir or =
not
>=20
> arch/powerpc/include/asm/cputable.h    |  1 +
> arch/powerpc/include/asm/disassemble.h | 34 +++++++++++++++++
> arch/powerpc/kernel/align.c            | 34 +----------------
> arch/powerpc/kernel/cputable.c         | 15 +++++++-
> arch/powerpc/kvm/book3s_emulate.c      | 69 =
++++++++++++++++------------------
> 5 files changed, 82 insertions(+), 71 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/cputable.h =
b/arch/powerpc/include/asm/cputable.h
> index 0d4939ba48e7..1922dce6124d 100644
> --- a/arch/powerpc/include/asm/cputable.h
> +++ b/arch/powerpc/include/asm/cputable.h
> @@ -555,6 +555,7 @@ static inline int cpu_has_feature(unsigned long =
feature)
> }
>=20
> #define HBP_NUM 1
> +extern struct cpu_spec *find_cpuspec(unsigned int pvr);
>=20
> #endif /* !__ASSEMBLY__ */
>=20
> diff --git a/arch/powerpc/include/asm/disassemble.h =
b/arch/powerpc/include/asm/disassemble.h
> index 856f8deb557a..6330a61b875a 100644
> --- a/arch/powerpc/include/asm/disassemble.h
> +++ b/arch/powerpc/include/asm/disassemble.h
> @@ -81,4 +81,38 @@ static inline unsigned int get_oc(u32 inst)
> {
> 	return (inst >> 11) & 0x7fff;
> }
> +
> +#define IS_XFORM(inst)	(get_op(inst)  =3D=3D 31)
> +#define IS_DSFORM(inst)	(get_op(inst) >=3D 56)
> +
> +/*
> + * Create a DSISR value from the instruction
> + */
> +static inline unsigned make_dsisr(unsigned instr)
> +{
> +	unsigned dsisr;
> +
> +
> +	/* bits  6:15 --> 22:31 */
> +	dsisr =3D (instr & 0x03ff0000) >> 16;
> +
> +	if (IS_XFORM(instr)) {
> +		/* bits 29:30 --> 15:16 */
> +		dsisr |=3D (instr & 0x00000006) << 14;
> +		/* bit     25 -->    17 */
> +		dsisr |=3D (instr & 0x00000040) << 8;
> +		/* bits 21:24 --> 18:21 */
> +		dsisr |=3D (instr & 0x00000780) << 3;
> +	} else {
> +		/* bit      5 -->    17 */
> +		dsisr |=3D (instr & 0x04000000) >> 12;
> +		/* bits  1: 4 --> 18:21 */
> +		dsisr |=3D (instr & 0x78000000) >> 17;
> +		/* bits 30:31 --> 12:13 */
> +		if (IS_DSFORM(instr))
> +			dsisr |=3D (instr & 0x00000003) << 18;
> +	}
> +
> +	return dsisr;
> +}
> #endif /* __ASM_PPC_DISASSEMBLE_H__ */
> diff --git a/arch/powerpc/kernel/align.c b/arch/powerpc/kernel/align.c
> index de91f3ae631e..111d93ec7f34 100644
> --- a/arch/powerpc/kernel/align.c
> +++ b/arch/powerpc/kernel/align.c
> @@ -25,14 +25,13 @@
> #include <asm/cputable.h>
> #include <asm/emulated_ops.h>
> #include <asm/switch_to.h>
> +#include <asm/disassemble.h>
>=20
> struct aligninfo {
> 	unsigned char len;
> 	unsigned char flags;
> };
>=20
> -#define IS_XFORM(inst)	(((inst) >> 26) =3D=3D 31)
> -#define IS_DSFORM(inst)	(((inst) >> 26) >=3D 56)
>=20
> #define INVALID	{ 0, 0 }
>=20
> @@ -192,37 +191,6 @@ static struct aligninfo aligninfo[128] =3D {
> };
>=20
> /*
> - * Create a DSISR value from the instruction
> - */
> -static inline unsigned make_dsisr(unsigned instr)
> -{
> -	unsigned dsisr;
> -
> -
> -	/* bits  6:15 --> 22:31 */
> -	dsisr =3D (instr & 0x03ff0000) >> 16;
> -
> -	if (IS_XFORM(instr)) {
> -		/* bits 29:30 --> 15:16 */
> -		dsisr |=3D (instr & 0x00000006) << 14;
> -		/* bit     25 -->    17 */
> -		dsisr |=3D (instr & 0x00000040) << 8;
> -		/* bits 21:24 --> 18:21 */
> -		dsisr |=3D (instr & 0x00000780) << 3;
> -	} else {
> -		/* bit      5 -->    17 */
> -		dsisr |=3D (instr & 0x04000000) >> 12;
> -		/* bits  1: 4 --> 18:21 */
> -		dsisr |=3D (instr & 0x78000000) >> 17;
> -		/* bits 30:31 --> 12:13 */
> -		if (IS_DSFORM(instr))
> -			dsisr |=3D (instr & 0x00000003) << 18;
> -	}
> -
> -	return dsisr;
> -}
> -
> -/*
>  * The dcbz (data cache block zero) instruction
>  * gives an alignment fault if used on non-cacheable
>  * memory.  We handle the fault mainly for the
> diff --git a/arch/powerpc/kernel/cputable.c =
b/arch/powerpc/kernel/cputable.c
> index 597d954e5860..b367f5b772f6 100644
> --- a/arch/powerpc/kernel/cputable.c
> +++ b/arch/powerpc/kernel/cputable.c
> @@ -116,7 +116,7 @@ extern void __restore_cpu_e6500(void);
> 				 PPC_FEATURE_BOOKE)
> #endif
>=20
> -static struct cpu_spec __initdata cpu_specs[] =3D {
> +static struct cpu_spec cpu_specs[] =3D {
> #ifdef CONFIG_PPC_BOOK3S_64
> 	{	/* Power3 */
> 		.pvr_mask		=3D 0xffff0000,
> @@ -2258,3 +2258,16 @@ struct cpu_spec * __init identify_cpu(unsigned =
long offset, unsigned int pvr)
>=20
> 	return NULL;
> }
> +
> +struct cpu_spec *find_cpuspec(unsigned int pvr)
> +{
> +	int i;
> +	struct cpu_spec *s =3D cpu_specs;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(cpu_specs); i++, s++) {
> +		if ((pvr & s->pvr_mask) =3D=3D s->pvr_value)
> +			return s;
> +	}
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(find_cpuspec);
> diff --git a/arch/powerpc/kvm/book3s_emulate.c =
b/arch/powerpc/kvm/book3s_emulate.c
> index 99d40f8977e8..a7d54aa203d0 100644
> --- a/arch/powerpc/kvm/book3s_emulate.c
> +++ b/arch/powerpc/kvm/book3s_emulate.c
> @@ -569,48 +569,42 @@ unprivileged:
>=20
> u32 kvmppc_alignment_dsisr(struct kvm_vcpu *vcpu, unsigned int inst)
> {
> -	u32 dsisr =3D 0;
> -
> -	/*
> -	 * This is what the spec says about DSISR bits (not mentioned =3D =
0):
> -	 *
> -	 * 12:13		[DS]	Set to bits 30:31
> -	 * 15:16		[X]	Set to bits 29:30
> -	 * 17			[X]	Set to bit 25
> -	 *			[D/DS]	Set to bit 5
> -	 * 18:21		[X]	Set to bits 21:24
> -	 *			[D/DS]	Set to bits 1:4
> -	 * 22:26			Set to bits 6:10 (RT/RS/FRT/FRS)
> -	 * 27:31			Set to bits 11:15 (RA)
> -	 */
> -
> -	switch (get_op(inst)) {
> -	/* D-form */
> -	case OP_LFS:
> -	case OP_LFD:
> -	case OP_STFD:
> -	case OP_STFS:
> -		dsisr |=3D (inst >> 12) & 0x4000;	/* bit 17 */
> -		dsisr |=3D (inst >> 17) & 0x3c00; /* bits 18:21 */
> -		break;
> -	/* X-form */
> -	case 31:
> -		dsisr |=3D (inst << 14) & 0x18000; /* bits 15:16 */
> -		dsisr |=3D (inst << 8)  & 0x04000; /* bit 17 */
> -		dsisr |=3D (inst << 3)  & 0x03c00; /* bits 18:21 */
> -		break;
> -	default:
> -		printk(KERN_INFO "KVM: Unaligned instruction 0x%x\n", =
inst);
> -		break;
> +	struct cpu_spec *s =3D find_cpuspec(vcpu->arch.pvr);

What if we don't find the pvr?

> +
> +	if (s->cpu_features & CPU_FTR_NODSISRALIGN) {
> +		/*
> +		 * We don't care much we pass the DSISR we found on =
fault

Please indicate that this if() checks the guest cpu, while the other =
if() checks the host cpu.

> +		 */
> +		return vcpu->arch.fault_dsisr;
> +	} else if (cpu_has_feature(CPU_FTR_NODSISRALIGN)) {
> +		/*
> +		 * Fault DSISR is not valid, and virualized cpu expect a

virtualized

> +		 * proper DSISR, so build one
> +		 *
> +		 * Mac OS X has some applications - namely the Finder - =
that
> +		 * require alignment interrupts to work properly. So we =
need
> +		 * to implement them.
> +		 *
> +		 * But the spec for 970 and 750 also looks different. =
While 750
> +		 * requires the DSISR and DAR fields to reflect some =
instruction
> +		 * bits (DSISR) and the fault address (DAR), the 970 =
declares
> +		 * this as an optional feature. So we need to =
reconstruct DSISR
> +		 * and DAR manually.
> +		 */
> +		return make_dsisr(inst);

I quite frankly don't see why we're jumping through so many hoops here. =
Why doesn't dsisr reconstruction work in LE mode? And why do we care if =
the guest isn't guaranteed a working dsisr value?


Alex

> +	} else {
> +		/*
> +		 * We have valid dsisr on fault
> +		 */
> +		return vcpu->arch.fault_dsisr;
> 	}
> -
> -	dsisr |=3D (inst >> 16) & 0x03ff; /* bits 22:31 */
> -
> -	return dsisr;
> }
>=20
> ulong kvmppc_alignment_dar(struct kvm_vcpu *vcpu, unsigned int inst)
> {
> +#ifdef CONFIG_PPC_BOOK3S_64
> +	return vcpu->arch.fault_dar;
> +#else
> 	ulong dar =3D 0;
> 	ulong ra =3D get_ra(inst);
> 	ulong rb =3D get_rb(inst);
> @@ -635,4 +629,5 @@ ulong kvmppc_alignment_dar(struct kvm_vcpu *vcpu, =
unsigned int inst)
> 	}
>=20
> 	return dar;
> +#endif
> }
> --=20
> 1.8.5.3
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
