Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D499B1A0B12
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Dec 2015 17:13:41 +1100 (AEDT)
Received: from mail-pa0-x232.google.com (mail-pa0-x232.google.com
 [IPv6:2607:f8b0:400e:c03::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1538F1402C4
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Dec 2015 17:13:41 +1100 (AEDT)
Received: by mail-pa0-x232.google.com with SMTP id tl7so312269pab.3
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Dec 2015 22:13:40 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>, paulus@ozlabs.org,
 linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org
Cc: mahesh@linux.vnet.ibm.com, david@gibson.dropbear.id.au, agraf@suse.de,
 michaele@au1.ibm.com, kvm@vger.kernel.org
Subject: Re: [PATCH v2] KVM: PPC: Exit guest upon fatal machine check exception
In-Reply-To: <20151216055612.10203.28496.stgit@aravindap>
References: <20151216055612.10203.28496.stgit@aravindap>
Date: Wed, 16 Dec 2015 17:13:34 +1100
Message-ID: <8760zyc44x.fsf@gamma.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,


> This patch also introduces a new KVM capability to
> control how KVM behaves on machine check exception.
> Without this capability, KVM redirects machine check
> exceptions to guest's 0x200 vector if the address in
> error belongs to guest. With this capability KVM
> causes a guest exit with NMI exit reason.
>
> This is required to avoid problems if a new kernel/KVM
> is used with an old QEMU for guests that don't issue
> "ibm,nmi-register". As old QEMU does not understand the
> NMI exit type, it treats it as a fatal error. However,
> the guest could have handled the machine check error
> if the exception was delivered to guest's 0x200 interrupt
> vector instead of NMI exit in case of old QEMU.
>
> Change Log v2:
>   - Added KVM capability

I'm not really qualified to review the contents of this patch, but I'm
happy that the changes in v2 address the concern I had for version 1:
thank you.

Regards,
Daniel

>
> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/kvm_host.h     |    1 +
>  arch/powerpc/kernel/asm-offsets.c       |    1 +
>  arch/powerpc/kvm/book3s_hv.c            |   12 +++-------
>  arch/powerpc/kvm/book3s_hv_rmhandlers.S |   37 +++++++++++++++----------------
>  arch/powerpc/kvm/powerpc.c              |    7 ++++++
>  include/uapi/linux/kvm.h                |    1 +
>  6 files changed, 31 insertions(+), 28 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
> index 827a38d..8a652ba 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -243,6 +243,7 @@ struct kvm_arch {
>  	int hpt_cma_alloc;
>  	struct dentry *debugfs_dir;
>  	struct dentry *htab_dentry;
> +	u8 fwnmi_enabled;
>  #endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
>  #ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
>  	struct mutex hpt_mutex;
> diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
> index 221d584..6a4e81a 100644
> --- a/arch/powerpc/kernel/asm-offsets.c
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@ -506,6 +506,7 @@ int main(void)
>  	DEFINE(KVM_ENABLED_HCALLS, offsetof(struct kvm, arch.enabled_hcalls));
>  	DEFINE(KVM_LPCR, offsetof(struct kvm, arch.lpcr));
>  	DEFINE(KVM_VRMA_SLB_V, offsetof(struct kvm, arch.vrma_slb_v));
> +	DEFINE(KVM_FWNMI, offsetof(struct kvm, arch.fwnmi_enabled));
>  	DEFINE(VCPU_DSISR, offsetof(struct kvm_vcpu, arch.shregs.dsisr));
>  	DEFINE(VCPU_DAR, offsetof(struct kvm_vcpu, arch.shregs.dar));
>  	DEFINE(VCPU_VPA, offsetof(struct kvm_vcpu, arch.vpa.pinned_addr));
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 2280497..1b1dff0 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -859,15 +859,9 @@ static int kvmppc_handle_exit_hv(struct kvm_run *run, struct kvm_vcpu *vcpu,
>  		r = RESUME_GUEST;
>  		break;
>  	case BOOK3S_INTERRUPT_MACHINE_CHECK:
> -		/*
> -		 * Deliver a machine check interrupt to the guest.
> -		 * We have to do this, even if the host has handled the
> -		 * machine check, because machine checks use SRR0/1 and
> -		 * the interrupt might have trashed guest state in them.
> -		 */
> -		kvmppc_book3s_queue_irqprio(vcpu,
> -					    BOOK3S_INTERRUPT_MACHINE_CHECK);
> -		r = RESUME_GUEST;
> +		/* Exit to guest with KVM_EXIT_NMI as exit reason */
> +		run->exit_reason = KVM_EXIT_NMI;
> +		r = RESUME_HOST;
>  		break;
>  	case BOOK3S_INTERRUPT_PROGRAM:
>  	{
> diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> index b98889e..f43c124 100644
> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> @@ -147,7 +147,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
>  	addi	r1, r1, 112
>  	ld	r7, HSTATE_HOST_MSR(r13)
>  
> -	cmpwi	cr1, r12, BOOK3S_INTERRUPT_MACHINE_CHECK
>  	cmpwi	r12, BOOK3S_INTERRUPT_EXTERNAL
>  	beq	11f
>  	cmpwi	cr2, r12, BOOK3S_INTERRUPT_HMI
> @@ -160,7 +159,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
>  	mtmsrd	r6, 1			/* Clear RI in MSR */
>  	mtsrr0	r8
>  	mtsrr1	r7
> -	beq	cr1, 13f		/* machine check */
>  	RFI
>  
>  	/* On POWER7, we have external interrupts set to use HSRR0/1 */
> @@ -168,8 +166,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
>  	mtspr	SPRN_HSRR1, r7
>  	ba	0x500
>  
> -13:	b	machine_check_fwnmi
> -
>  14:	mtspr	SPRN_HSRR0, r8
>  	mtspr	SPRN_HSRR1, r7
>  	b	hmi_exception_after_realmode
> @@ -2381,24 +2377,27 @@ machine_check_realmode:
>  	ld	r9, HSTATE_KVM_VCPU(r13)
>  	li	r12, BOOK3S_INTERRUPT_MACHINE_CHECK
>  	/*
> -	 * Deliver unhandled/fatal (e.g. UE) MCE errors to guest through
> -	 * machine check interrupt (set HSRR0 to 0x200). And for handled
> -	 * errors (no-fatal), just go back to guest execution with current
> -	 * HSRR0 instead of exiting guest. This new approach will inject
> -	 * machine check to guest for fatal error causing guest to crash.
> -	 *
> -	 * The old code used to return to host for unhandled errors which
> -	 * was causing guest to hang with soft lockups inside guest and
> -	 * makes it difficult to recover guest instance.
> +	 * Deliver unhandled/fatal (e.g. UE) MCE errors to guest
> +	 * by exiting the guest with KVM_EXIT_NMI exit reason (exit
> +	 * reason set later based on trap). For handled errors
> +	 * (no-fatal), go back to guest execution with current HSRR0
> +	 * instead of exiting the guest. This approach will cause
> +	 * the guest to exit in case of fatal machine check error.
>  	 */
> -	ld	r10, VCPU_PC(r9)
> -	ld	r11, VCPU_MSR(r9)
> -	bne	2f	/* Continue guest execution. */
> -	/* If not, deliver a machine check.  SRR0/1 are already set */
> -	li	r10, BOOK3S_INTERRUPT_MACHINE_CHECK
> +	bne	2f	/* Continue guest execution? */
> +	/* If not, check if guest is capable of handling NMI exit */
> +	ld	r3, VCPU_KVM(r9)
> +	ld	r3, KVM_FWNMI(r3)
> +	cmpdi	r3, 1		/* FWNMI capable? */
> +	bne	1f	/* Deliver machine check via guest's 0x200 vector */
> +	b	mc_cont
> +1:	li	r10, BOOK3S_INTERRUPT_MACHINE_CHECK
>  	ld	r11, VCPU_MSR(r9)
>  	bl	kvmppc_msr_interrupt
> -2:	b	fast_interrupt_c_return
> +	b	fast_interrupt_c_return
> +2:	ld	r10, VCPU_PC(r9)
> +	ld	r11, VCPU_MSR(r9)
> +	b	fast_interrupt_c_return
>  
>  /*
>   * Check the reason we woke from nap, and take appropriate action.
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 2e51289..3e57636 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -567,6 +567,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  		r = 1;
>  		break;
>  #endif
> +	case KVM_CAP_PPC_FWNMI:
> +		r = 1;
> +		break;
>  	default:
>  		r = 0;
>  		break;
> @@ -1129,6 +1132,10 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
>  		break;
>  	}
>  #endif /* CONFIG_KVM_XICS */
> +	case KVM_CAP_PPC_FWNMI:
> +		r = 0;
> +		vcpu->kvm->arch.fwnmi_enabled = true;
> +		break;
>  	default:
>  		r = -EINVAL;
>  		break;
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index a9256f0..2daf4b4 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -824,6 +824,7 @@ struct kvm_ppc_smmu_info {
>  #define KVM_CAP_MULTI_ADDRESS_SPACE 118
>  #define KVM_CAP_GUEST_DEBUG_HW_BPS 119
>  #define KVM_CAP_GUEST_DEBUG_HW_WPS 120
> +#define KVM_CAP_PPC_FWNMI 121
>  
>  #ifdef KVM_CAP_IRQ_ROUTING
>  
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
