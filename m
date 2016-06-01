Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rKL0V3bCdzDqYf
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Jun 2016 16:23:54 +1000 (AEST)
Message-ID: <1464762233.30958.135.camel@neuling.org>
Subject: Re: [PATCH 2/2] KVM: PPC: hypervisor large decrementer support
From: Michael Neuling <mikey@neuling.org>
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@samba.org>
Date: Wed, 01 Jun 2016 16:23:53 +1000
In-Reply-To: <1464679016-10347-2-git-send-email-oohall@gmail.com>
References: <1464675936.30958.22.camel@neuling.org>
 <1464679016-10347-1-git-send-email-oohall@gmail.com>
 <1464679016-10347-2-git-send-email-oohall@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-05-31 at 17:16 +1000, Oliver O'Halloran wrote:
> Power ISAv3 extends the width of the decrementer register from 32 bits.
> The enlarged register width is implementation dependent, but reads from
> these registers are automatically sign extended to produce a 64 bit
> output when operating in large mode. The HDEC always operates in large
> mode while the DEC register can be operated in 32bit mode or large mode
> depending on the setting of the LPCR.LD bit.
>=20
> Currently the hypervisor assumes that reads from the DEC and HDEC
> register produce a 32 bit result which it sign extends to 64 bits using
> the extsw instruction. This behaviour can result in the guest DEC
> register value being corrupted by the hypervisor when the guest is
> operating in LD mode since the results of the extsw instruction only
> depends on the value of bit 31 in the register to be sign extended.
>=20
> This patch adds the GET_DEC() and GET_HDEC() assembly macros for reading
> from the decrementer registers. These macros will return the current
> decrementer value as a 64 bit quantity regardless of=C2=A0the Host CPU or
> guest decrementer operating mode. Additionally this patch corrects
> several uses of decrementer values that assume a 32 bit register width.
>=20
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Neuling <mikey@neuling.org>
> ---
> =C2=A0arch/powerpc/include/asm/exception-64s.h | 29 +++++++++++++++++++++=
+++
> =C2=A0arch/powerpc/include/asm/kvm_host.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0|=C2=A0=C2=A02 +-
> =C2=A0arch/powerpc/include/asm/kvm_ppc.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0|=C2=A0=C2=A02 +-
> =C2=A0arch/powerpc/include/uapi/asm/kvm.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0|=C2=A0=C2=A02 +-
> =C2=A0arch/powerpc/kvm/book3s_hv_interrupts.S=C2=A0=C2=A0|=C2=A0=C2=A03 +=
--
> =C2=A0arch/powerpc/kvm/book3s_hv_rmhandlers.S=C2=A0=C2=A0| 38 +++++++++++=
+++++++--------------
> =C2=A0arch/powerpc/kvm/emulate.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A06 ++---
> =C2=A07 files changed, 57 insertions(+), 25 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/incl=
ude/asm/exception-64s.h
> index 93ae809fe5ea..4fa303bf6d5b 100644
> --- a/arch/powerpc/include/asm/exception-64s.h
> +++ b/arch/powerpc/include/asm/exception-64s.h
> @@ -545,4 +545,33 @@ END_FTR_SECTION_IFSET(CPU_FTR_CAN_NAP)
> =C2=A0#define FINISH_NAP
> =C2=A0#endif
> =C2=A0
> +/*
> + * On ISAv3 processors the DEC register can be extended from 32 bits to =
64 by
> + * setting the LD flag the LPCR. The decrementer value is a signed quant=
ity so
> + * sign exension is required when operating in 32 bit mode. The GET_DEC(=
) and
> + * GET_HDEC() handle this sign extension and yield a 64 bit result indep=
endent
> + * of the LD mode.
> + *
> + * NB: It's possible run with LD mode disabled on ISAv3 so GET_DEC() doe=
s not
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0use a CPU_FEATURE section. A feature sec=
tion is used for GET_HDEC because
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0it has no mode bit. It is always 64 bits=
 for ISAv3 processors.
> + */
> +
> +#define IS_LD_ENABLED(reg)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> +	mfspr=C2=A0=C2=A0reg,SPRN_LPCR;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> +	andis. reg,reg,(LPCR_LD >> 16);

FWIW you can use:
=C2=A0 =C2=A0 =C2=A0 =C2=A0 andis. reg,reg,(LPCR_LD)@ha

> +#define GET_DEC(reg)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0\
> +	IS_LD_ENABLED(reg);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> +	mfspr reg, SPRN_DEC;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> +	bne 99f;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0\
> +	extsw reg, reg;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> +99:

It's a little painful that GET_DEC() is now 2 SPR moves. =C2=A0SPR moves ca=
n be
a bit expensive. =C2=A0Probably ok for now, but might be nice to store the =
guest
dec LD state somewhere so we don't have to retrieve it from the LPCR SPR.

Actually, it's probably best to do this now since checking the LD bit in
the LPCR on P8 is a bit dodgy and unnecessary. There is a kvm->arch.lpcr
you might be able use for this and you can add an asm-offsets for it too
(like KVM_LPID).

Is GET_DEC ever run in HV=3D0, where the guest couldn't read the LPCR?

Also, this now trashes cr0... have you checked that's ok in the paths it's
used?

> +
> +#define GET_HDEC(reg) \
> +	mfspr reg, SPRN_HDEC;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0\
> +BEGIN_FTR_SECTION=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0\
> +	extsw reg, reg;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> +END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
> +
> =C2=A0#endif	/* _ASM_POWERPC_EXCEPTION_H */
> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/a=
sm/kvm_host.h
> index ec35af34a3fb..ddea233e2cce 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -520,7 +520,7 @@ struct kvm_vcpu_arch {
> =C2=A0	ulong mcsrr0;
> =C2=A0	ulong mcsrr1;
> =C2=A0	ulong mcsr;
> -	u32 dec;
> +	u64 dec;
> =C2=A0#ifdef CONFIG_BOOKE
> =C2=A0	u32 decar;
> =C2=A0#endif
> diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/as=
m/kvm_ppc.h
> index 2544edabe7f3..4de0102930e9 100644
> --- a/arch/powerpc/include/asm/kvm_ppc.h
> +++ b/arch/powerpc/include/asm/kvm_ppc.h
> @@ -94,7 +94,7 @@ extern int kvmppc_emulate_instruction(struct kvm_run *r=
un,
> =C2=A0extern int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu);
> =C2=A0extern int kvmppc_emulate_mmio(struct kvm_run *run, struct kvm_vcpu=
 *vcpu);
> =C2=A0extern void kvmppc_emulate_dec(struct kvm_vcpu *vcpu);
> -extern u32 kvmppc_get_dec(struct kvm_vcpu *vcpu, u64 tb);
> +extern u64 kvmppc_get_dec(struct kvm_vcpu *vcpu, u64 tb);
> =C2=A0extern void kvmppc_decrementer_func(struct kvm_vcpu *vcpu);
> =C2=A0extern int kvmppc_sanity_check(struct kvm_vcpu *vcpu);
> =C2=A0extern int kvmppc_subarch_vcpu_init(struct kvm_vcpu *vcpu);
> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/u=
api/asm/kvm.h
> index c93cf35ce379..2dd92e841127 100644
> --- a/arch/powerpc/include/uapi/asm/kvm.h
> +++ b/arch/powerpc/include/uapi/asm/kvm.h
> @@ -215,7 +215,7 @@ struct kvm_sregs {
> =C2=A0			__u32 tsr;	/* KVM_SREGS_E_UPDATE_TSR */
> =C2=A0			__u32 tcr;
> =C2=A0			__u32 decar;
> -			__u32 dec;	/* KVM_SREGS_E_UPDATE_DEC */
> +			__u64 dec;	/* KVM_SREGS_E_UPDATE_DEC */
> =C2=A0
> =C2=A0			/*
> =C2=A0			=C2=A0* Userspace can read TB directly, but the
> diff --git a/arch/powerpc/kvm/book3s_hv_interrupts.S b/arch/powerpc/kvm/b=
ook3s_hv_interrupts.S
> index 0fdc4a28970b..b408f72385e4 100644
> --- a/arch/powerpc/kvm/book3s_hv_interrupts.S
> +++ b/arch/powerpc/kvm/book3s_hv_interrupts.S
> @@ -121,10 +121,9 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
> =C2=A0	=C2=A0* Put whatever is in the decrementer into the
> =C2=A0	=C2=A0* hypervisor decrementer.
> =C2=A0	=C2=A0*/
> -	mfspr	r8,SPRN_DEC
> +	GET_DEC(r8)
> =C2=A0	mftb	r7
> =C2=A0	mtspr	SPRN_HDEC,r8
> -	extsw	r8,r8
> =C2=A0	add	r8,r8,r7
> =C2=A0	std	r8,HSTATE_DECEXP(r13)
> =C2=A0
> diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/b=
ook3s_hv_rmhandlers.S
> index e571ad277398..718e5581494e 100644
> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> @@ -183,6 +183,10 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
> =C2=A0kvmppc_primary_no_guest:
> =C2=A0	/* We handle this much like a ceded vcpu */
> =C2=A0	/* put the HDEC into the DEC, since HDEC interrupts don't wake us =
*/
> +
> +	/* XXX: ISA v3 only says the HDEC is at least as large as the DEC, but
> +	=C2=A0*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0this code assumes we can fit=
 HDEC in DEC. This is probably
> +	=C2=A0*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0not an issue in practice, bu=
t... */
> =C2=A0	mfspr	r3, SPRN_HDEC
> =C2=A0	mtspr	SPRN_DEC, r3
> =C2=A0	/*
> @@ -249,9 +253,9 @@ kvm_novcpu_wakeup:
> =C2=A0	bge	kvm_novcpu_exit
> =C2=A0
> =C2=A0	/* See if our timeslice has expired (HDEC is negative) */
> -	mfspr	r0, SPRN_HDEC
> +	GET_HDEC(r0);
> =C2=A0	li	r12, BOOK3S_INTERRUPT_HV_DECREMENTER
> -	cmpwi	r0, 0
> +	cmpdi	r0, 0
> =C2=A0	blt	kvm_novcpu_exit
> =C2=A0
> =C2=A0	/* Got an IPI but other vcpus aren't yet exiting, must be a lateco=
mer */
> @@ -340,8 +344,9 @@ kvm_secondary_got_guest:
> =C2=A0	lbz	r4, HSTATE_PTID(r13)
> =C2=A0	cmpwi	r4, 0
> =C2=A0	bne	63f
> -	lis	r6, 0x7fff
> -	ori	r6, r6, 0xffff
> +
> +	LOAD_REG_ADDR(r6, decrementer_max);
> +	ld	r6,0(r6);
> =C2=A0	mtspr	SPRN_HDEC, r6
> =C2=A0	/* and set per-LPAR registers, if doing dynamic micro-threading */
> =C2=A0	ld	r6, HSTATE_SPLIT_MODE(r13)
> @@ -897,7 +902,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_207S)
> =C2=A0	mftb	r7
> =C2=A0	subf	r3,r7,r8
> =C2=A0	mtspr	SPRN_DEC,r3
> -	stw	r3,VCPU_DEC(r4)
> +	std	r3,VCPU_DEC(r4)
> =C2=A0
> =C2=A0	ld	r5, VCPU_SPRG0(r4)
> =C2=A0	ld	r6, VCPU_SPRG1(r4)
> @@ -953,8 +958,8 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_207S)
> =C2=A0	isync
> =C2=A0
> =C2=A0	/* Check if HDEC expires soon */
> -	mfspr	r3, SPRN_HDEC
> -	cmpwi	r3, 512		/* 1 microsecond */
> +	GET_HDEC(r3)
> +	cmpdi	r3, 512		/* 1 microsecond */
> =C2=A0	blt	hdec_soon
> =C2=A0
> =C2=A0	ld	r6, VCPU_CTR(r4)
> @@ -990,8 +995,9 @@ deliver_guest_interrupt:
> =C2=A0	beq	5f
> =C2=A0	li	r0, BOOK3S_INTERRUPT_EXTERNAL
> =C2=A0	bne	cr1, 12f
> -	mfspr	r0, SPRN_DEC
> -	cmpwi	r0, 0
> +
> +	GET_DEC(r0)
> +	cmpdi	r0, 0

We could just use mfspr DEC here since we are just comparing to 0. =C2=A0It
should work in any mode.

> =C2=A0	li	r0, BOOK3S_INTERRUPT_DECREMENTER
> =C2=A0	bge	5f
> =C2=A0
> @@ -1206,8 +1212,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
> =C2=A0	/* See if this is a leftover HDEC interrupt */
> =C2=A0	cmpwi	r12,BOOK3S_INTERRUPT_HV_DECREMENTER
> =C2=A0	bne	2f
> -	mfspr	r3,SPRN_HDEC
> -	cmpwi	r3,0
> +	GET_HDEC(r3);
> +	cmpdi	r3,0
> =C2=A0	mr	r4,r9
> =C2=A0	bge	fast_guest_return
> =C2=A02:
> @@ -1326,9 +1332,8 @@ mc_cont:
> =C2=A0	mtspr	SPRN_SPURR,r4
> =C2=A0
> =C2=A0	/* Save DEC */
> -	mfspr	r5,SPRN_DEC
> +	GET_DEC(r5);
> =C2=A0	mftb	r6
> -	extsw	r5,r5
> =C2=A0	add	r5,r5,r6
> =C2=A0	/* r5 is a guest timebase value here, convert to host TB */
> =C2=A0	ld	r3,HSTATE_KVM_VCORE(r13)
> @@ -2250,15 +2255,14 @@ _GLOBAL(kvmppc_h_cede)		/* r3 =3D vcpu pointer, r=
11 =3D msr, r13 =3D paca */
> =C2=A0	=C2=A0* no later than the end of our timeslice (HDEC interrupts
> =C2=A0	=C2=A0* don't wake us from nap).
> =C2=A0	=C2=A0*/
> -	mfspr	r3, SPRN_DEC
> -	mfspr	r4, SPRN_HDEC
> +	GET_DEC(r3);
> +	GET_HDEC(r4);
> =C2=A0	mftb	r5
> -	cmpw	r3, r4
> +	cmpd	r3, r4
> =C2=A0	ble	67f
> =C2=A0	mtspr	SPRN_DEC, r4
> =C2=A067:
> =C2=A0	/* save expiry time of guest decrementer */
> -	extsw	r3, r3
> =C2=A0	add	r3, r3, r5
> =C2=A0	ld	r4, HSTATE_KVM_VCPU(r13)
> =C2=A0	ld	r5, HSTATE_KVM_VCORE(r13)
> diff --git a/arch/powerpc/kvm/emulate.c b/arch/powerpc/kvm/emulate.c
> index 5cc2e7af3a7b..5d065c04f2d5 100644
> --- a/arch/powerpc/kvm/emulate.c
> +++ b/arch/powerpc/kvm/emulate.c
> @@ -39,7 +39,7 @@ void kvmppc_emulate_dec(struct kvm_vcpu *vcpu)
> =C2=A0	unsigned long dec_nsec;
> =C2=A0	unsigned long long dec_time;
> =C2=A0
> -	pr_debug("mtDEC: %x\n", vcpu->arch.dec);
> +	pr_debug("mtDEC: %llx\n", vcpu->arch.dec);
> =C2=A0	hrtimer_try_to_cancel(&vcpu->arch.dec_timer);
> =C2=A0
> =C2=A0#ifdef CONFIG_PPC_BOOK3S
> @@ -47,7 +47,7 @@ void kvmppc_emulate_dec(struct kvm_vcpu *vcpu)
> =C2=A0	kvmppc_core_dequeue_dec(vcpu);
> =C2=A0
> =C2=A0	/* POWER4+ triggers a dec interrupt if the value is < 0 */
> -	if (vcpu->arch.dec & 0x80000000) {
> +	if ((s64) vcpu->arch.dec < 0) {
> =C2=A0		kvmppc_core_queue_dec(vcpu);
> =C2=A0		return;
> =C2=A0	}
> @@ -78,7 +78,7 @@ void kvmppc_emulate_dec(struct kvm_vcpu *vcpu)
> =C2=A0	vcpu->arch.dec_jiffies =3D get_tb();
> =C2=A0}
> =C2=A0
> -u32 kvmppc_get_dec(struct kvm_vcpu *vcpu, u64 tb)
> +u64 kvmppc_get_dec(struct kvm_vcpu *vcpu, u64 tb)
> =C2=A0{
> =C2=A0	u64 jd =3D tb - vcpu->arch.dec_jiffies;
> =C2=A0
