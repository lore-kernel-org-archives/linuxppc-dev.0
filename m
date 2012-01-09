Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 9EC1EB6FB9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2012 04:48:31 +1100 (EST)
Subject: Re: [RFC PATCH 15/16] KVM: PPC: booke: standard PPC floating point
 support
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20111221013445.GO8378@schlenkerla.am.freescale.net>
Date: Mon, 9 Jan 2012 18:48:26 +0100
Message-Id: <F0432B7A-E742-48B0-8016-3F2D0A800553@suse.de>
References: <20111221013445.GO8378@schlenkerla.am.freescale.net>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 21.12.2011, at 02:34, Scott Wood wrote:

> e500mc has a normal PPC FPU, rather than SPE which is found
> on e500v1/v2.
>=20
> Based on code from Liu Yu <yu.liu@freescale.com>.
>=20
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> arch/powerpc/include/asm/system.h |    1 +
> arch/powerpc/kvm/booke.c          |   44 =
+++++++++++++++++++++++++++++++++++++
> arch/powerpc/kvm/booke.h          |   30 +++++++++++++++++++++++++
> 3 files changed, 75 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/system.h =
b/arch/powerpc/include/asm/system.h
> index e30a13d..0561356 100644
> --- a/arch/powerpc/include/asm/system.h
> +++ b/arch/powerpc/include/asm/system.h
> @@ -140,6 +140,7 @@ extern void via_cuda_init(void);
> extern void read_rtc_time(void);
> extern void pmac_find_display(void);
> extern void giveup_fpu(struct task_struct *);
> +extern void load_up_fpu(void);
> extern void disable_kernel_fp(void);
> extern void enable_kernel_fp(void);
> extern void flush_fp_to_thread(struct task_struct *);
> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index cf63b93..4bf43f9 100644
> --- a/arch/powerpc/kvm/booke.c
> +++ b/arch/powerpc/kvm/booke.c
> @@ -460,6 +460,11 @@ void kvmppc_core_prepare_to_enter(struct kvm_vcpu =
*vcpu)
> int kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
> {
> 	int ret;
> +#ifdef CONFIG_PPC_FPU
> +	unsigned int fpscr;
> +	int fpexc_mode;
> +	u64 fpr[32];
> +#endif
>=20
> 	if (!vcpu->arch.sane) {
> 		kvm_run->exit_reason =3D KVM_EXIT_INTERNAL_ERROR;
> @@ -482,7 +487,46 @@ int kvmppc_vcpu_run(struct kvm_run *kvm_run, =
struct kvm_vcpu *vcpu)
> 	}
>=20
> 	kvm_guest_enter();
> +
> +#ifdef CONFIG_PPC_FPU
> +	/* Save userspace FPU state in stack */
> +	enable_kernel_fp();
> +	memcpy(fpr, current->thread.fpr, sizeof(current->thread.fpr));
> +	fpscr =3D current->thread.fpscr.val;
> +	fpexc_mode =3D current->thread.fpexc_mode;
> +
> +	/* Restore guest FPU state to thread */
> +	memcpy(current->thread.fpr, vcpu->arch.fpr, =
sizeof(vcpu->arch.fpr));
> +	current->thread.fpscr.val =3D vcpu->arch.fpscr;
> +
> +	/*
> +	 * Since we can't trap on MSR_FP in GS-mode, we consider the =
guest
> +	 * as always using the FPU.  Kernel usage of FP (via
> +	 * enable_kernel_fp()) in this thread must not occur while
> +	 * vcpu->fpu_active is set.
> +	 */
> +	vcpu->fpu_active =3D 1;
> +
> +	kvmppc_load_guest_fp(vcpu);
> +#endif

Do you think it's possible to combine this with the book3s_pr code, so =
we don't duplicate too much here?

> +
> 	ret =3D __kvmppc_vcpu_run(kvm_run, vcpu);
> +
> +#ifdef CONFIG_PPC_FPU
> +	kvmppc_save_guest_fp(vcpu);
> +
> +	vcpu->fpu_active =3D 0;
> +
> +	/* Save guest FPU state from thread */
> +	memcpy(vcpu->arch.fpr, current->thread.fpr, =
sizeof(vcpu->arch.fpr));
> +	vcpu->arch.fpscr =3D current->thread.fpscr.val;
> +
> +	/* Restore userspace FPU state from stack */
> +	memcpy(current->thread.fpr, fpr, sizeof(current->thread.fpr));
> +	current->thread.fpscr.val =3D fpscr;
> +	current->thread.fpexc_mode =3D fpexc_mode;
> +#endif
> +
> 	kvm_guest_exit();
>=20
> out:
> diff --git a/arch/powerpc/kvm/booke.h b/arch/powerpc/kvm/booke.h
> index d53bcf2..3bf5eda 100644
> --- a/arch/powerpc/kvm/booke.h
> +++ b/arch/powerpc/kvm/booke.h
> @@ -96,4 +96,34 @@ enum int_class {
>=20
> void kvmppc_set_pending_interrupt(struct kvm_vcpu *vcpu, enum =
int_class type);
>=20
> +/*
> + * Load up guest vcpu FP state if it's needed.
> + * It also set the MSR_FP in thread so that host know
> + * we're holding FPU, and then host can help to save
> + * guest vcpu FP state if other threads require to use FPU.
> + * This simulates an FP unavailable fault.
> + *
> + * It requires to be called with preemption disabled.
> + */
> +static inline void kvmppc_load_guest_fp(struct kvm_vcpu *vcpu)
> +{
> +#ifdef CONFIG_PPC_FPU
> +	if (vcpu->fpu_active && !(current->thread.regs->msr & MSR_FP)) {
> +		load_up_fpu();
> +		current->thread.regs->msr |=3D MSR_FP;

I'm having a hard time to grasp when shared->msr, shadow_msr and =
regs->msr is used in your code :).


Alex
