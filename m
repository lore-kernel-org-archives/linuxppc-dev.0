Return-Path: <paulus@ozlabs.org>
Date: Thu, 6 Mar 2014 22:18:36 +1100
From: Paul Mackerras <paulus@samba.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] Revert "KVM: PPC: Book3S HV: Add new state for
 transactional memory"
Message-ID: <20140306111836.GA5729@iris.ozlabs.ibm.com>
References: <1394102170-22126-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1394102170-22126-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>, kvm@vger.kernel.org, agraf@suse.de,
 kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 06, 2014 at 04:06:09PM +0530, Aneesh Kumar K.V wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> 
> This reverts commit 7b490411c37f7ab7965cbdfe5e3ec28eadb6db5b which cause
> the below crash in the host.
> 
> Unable to handle kernel paging request for data at address 0xf00000001223f278
> Faulting instruction address: 0xc000000000202a00

Why exactly does it cause that crash?  What is the actual problem here?
Under what specific circumstances do you see the crash?

> cpu 0x30: Vector: 300 (Data Access) at [c000001e4debb2d0]
>     pc: c000000000202a00: .kfree+0x40/0x200
>     lr: c000000000098338: .kvmppc_core_destroy_vm_hv+0x38/0x90
>     sp: c000001e4debb550
>    msr: 9000000000009032
>    dar: f00000001223f278
>  dsisr: 40000000
>   current = 0xc000001e4de195c0
>   paca    = 0xc00000000fefb000   softe: 0        irq_happened: 0x01
>     pid   = 29379, comm = qemu-system-ppc
> enter ? for help
> [c000001e4debb5e0] c000000000098338 .kvmppc_core_destroy_vm_hv+0x38/0x90
> [c000001e4debb670] c000000000087f80 .kvmppc_core_destroy_vm+0x30/0x70
> [c000001e4debb6f0] c000000000084f28 .kvm_arch_destroy_vm+0xd8/0x120
> [c000001e4debb780] c000000000080218 .kvm_put_kvm+0x198/0x2e0
> [c000001e4debb820] c0000000000880d4 .kvm_spapr_tce_release+0xe4/0x110
> [c000001e4debb8b0] c000000000218578 .__fput+0xb8/0x2a0
> [c000001e4debb950] c0000000000d9af4 .task_work_run+0x114/0x150
> [c000001e4debb9f0] c0000000000b31e8 .do_exit+0x328/0xbc0
> [c000001e4debbae0] c0000000000b4cd4 .do_group_exit+0x54/0xf0
> [c000001e4debbb70] c0000000000c8448 .get_signal_to_deliver+0x1e8/0x6f0
> [c000001e4debbc70] c000000000017ee4 .do_signal+0x54/0x320
> [c000001e4debbdb0] c0000000000182e8 .do_notify_resume+0x68/0x80
> [c000001e4debbe30] c00000000000a7b0 .ret_from_except_lite+0x5c/0x60
> --- Exception: c00 (System Call) at 00003fffb38a4744
> SP (3ffd36ffe360) is in userspace
> 30:mon> zr
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/kvm_host.h     | 24 ++---------
>  arch/powerpc/kernel/asm-offsets.c       | 19 ++-------
>  arch/powerpc/kvm/book3s_hv.c            |  4 --
>  arch/powerpc/kvm/book3s_hv_rmhandlers.S | 75 +--------------------------------
>  4 files changed, 8 insertions(+), 114 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
> index 1eaea2dea174..7726a3bc8ff0 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -475,6 +475,9 @@ struct kvm_vcpu_arch {
>  	ulong ppr;
>  	ulong pspb;
>  	ulong fscr;
> +	ulong tfhar;
> +	ulong tfiar;
> +	ulong texasr;
>  	ulong ebbhr;
>  	ulong ebbrr;
>  	ulong bescr;
> @@ -523,27 +526,6 @@ struct kvm_vcpu_arch {
>  	u64 siar;
>  	u64 sdar;
>  	u64 sier;
> -#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> -	u64 tfhar;
> -	u64 texasr;
> -	u64 tfiar;
> -
> -	u32 cr_tm;
> -	u64 lr_tm;
> -	u64 ctr_tm;
> -	u64 amr_tm;
> -	u64 ppr_tm;
> -	u64 dscr_tm;
> -	u64 tar_tm;
> -
> -	ulong gpr_tm[32];
> -
> -	struct thread_fp_state fp_tm;
> -
> -	struct thread_vr_state vr_tm;
> -	u32 vrsave_tm; /* also USPRG0 */
> -
> -#endif
>  
>  #ifdef CONFIG_KVM_EXIT_TIMING
>  	struct mutex exit_timing_lock;
> diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
> index b5aacf72ae6f..936d445b961a 100644
> --- a/arch/powerpc/kernel/asm-offsets.c
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@ -534,6 +534,9 @@ int main(void)
>  	DEFINE(VCPU_PPR, offsetof(struct kvm_vcpu, arch.ppr));
>  	DEFINE(VCPU_FSCR, offsetof(struct kvm_vcpu, arch.fscr));
>  	DEFINE(VCPU_PSPB, offsetof(struct kvm_vcpu, arch.pspb));
> +	DEFINE(VCPU_TFHAR, offsetof(struct kvm_vcpu, arch.tfhar));
> +	DEFINE(VCPU_TFIAR, offsetof(struct kvm_vcpu, arch.tfiar));
> +	DEFINE(VCPU_TEXASR, offsetof(struct kvm_vcpu, arch.texasr));
>  	DEFINE(VCPU_EBBHR, offsetof(struct kvm_vcpu, arch.ebbhr));
>  	DEFINE(VCPU_EBBRR, offsetof(struct kvm_vcpu, arch.ebbrr));
>  	DEFINE(VCPU_BESCR, offsetof(struct kvm_vcpu, arch.bescr));
> @@ -555,22 +558,6 @@ int main(void)
>  	DEFINE(VCPU_SLB_E, offsetof(struct kvmppc_slb, orige));
>  	DEFINE(VCPU_SLB_V, offsetof(struct kvmppc_slb, origv));
>  	DEFINE(VCPU_SLB_SIZE, sizeof(struct kvmppc_slb));
> -#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> -	DEFINE(VCPU_TFHAR, offsetof(struct kvm_vcpu, arch.tfhar));
> -	DEFINE(VCPU_TFIAR, offsetof(struct kvm_vcpu, arch.tfiar));
> -	DEFINE(VCPU_TEXASR, offsetof(struct kvm_vcpu, arch.texasr));
> -	DEFINE(VCPU_GPR_TM, offsetof(struct kvm_vcpu, arch.gpr_tm));
> -	DEFINE(VCPU_FPRS_TM, offsetof(struct kvm_vcpu, arch.fp_tm.fpr));
> -	DEFINE(VCPU_VRS_TM, offsetof(struct kvm_vcpu, arch.vr_tm.vr));
> -	DEFINE(VCPU_VRSAVE_TM, offsetof(struct kvm_vcpu, arch.vrsave_tm));
> -	DEFINE(VCPU_CR_TM, offsetof(struct kvm_vcpu, arch.cr_tm));
> -	DEFINE(VCPU_LR_TM, offsetof(struct kvm_vcpu, arch.lr_tm));
> -	DEFINE(VCPU_CTR_TM, offsetof(struct kvm_vcpu, arch.ctr_tm));
> -	DEFINE(VCPU_AMR_TM, offsetof(struct kvm_vcpu, arch.amr_tm));
> -	DEFINE(VCPU_PPR_TM, offsetof(struct kvm_vcpu, arch.ppr_tm));
> -	DEFINE(VCPU_DSCR_TM, offsetof(struct kvm_vcpu, arch.dscr_tm));
> -	DEFINE(VCPU_TAR_TM, offsetof(struct kvm_vcpu, arch.tar_tm));
> -#endif
>  
>  #ifdef CONFIG_PPC_BOOK3S_64
>  #ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 3b498d942a22..71f2e8e6e7b1 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -879,7 +879,6 @@ static int kvmppc_get_one_reg_hv(struct kvm_vcpu *vcpu, u64 id,
>  	case KVM_REG_PPC_IAMR:
>  		*val = get_reg_val(id, vcpu->arch.iamr);
>  		break;
> -#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
>  	case KVM_REG_PPC_TFHAR:
>  		*val = get_reg_val(id, vcpu->arch.tfhar);
>  		break;
> @@ -889,7 +888,6 @@ static int kvmppc_get_one_reg_hv(struct kvm_vcpu *vcpu, u64 id,
>  	case KVM_REG_PPC_TEXASR:
>  		*val = get_reg_val(id, vcpu->arch.texasr);
>  		break;
> -#endif
>  	case KVM_REG_PPC_FSCR:
>  		*val = get_reg_val(id, vcpu->arch.fscr);
>  		break;
> @@ -1039,7 +1037,6 @@ static int kvmppc_set_one_reg_hv(struct kvm_vcpu *vcpu, u64 id,
>  	case KVM_REG_PPC_IAMR:
>  		vcpu->arch.iamr = set_reg_val(id, *val);
>  		break;
> -#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
>  	case KVM_REG_PPC_TFHAR:
>  		vcpu->arch.tfhar = set_reg_val(id, *val);
>  		break;
> @@ -1049,7 +1046,6 @@ static int kvmppc_set_one_reg_hv(struct kvm_vcpu *vcpu, u64 id,
>  	case KVM_REG_PPC_TEXASR:
>  		vcpu->arch.texasr = set_reg_val(id, *val);
>  		break;
> -#endif
>  	case KVM_REG_PPC_FSCR:
>  		vcpu->arch.fscr = set_reg_val(id, *val);
>  		break;
> diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> index e66d4ec04d95..557a47800ca1 100644
> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> @@ -704,15 +704,13 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_207S)
>  	ld	r6, VCPU_VTB(r4)
>  	mtspr	SPRN_IC, r5
>  	mtspr	SPRN_VTB, r6
> -#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
>  	ld	r5, VCPU_TFHAR(r4)
>  	ld	r6, VCPU_TFIAR(r4)
>  	ld	r7, VCPU_TEXASR(r4)
> +	ld	r8, VCPU_EBBHR(r4)
>  	mtspr	SPRN_TFHAR, r5
>  	mtspr	SPRN_TFIAR, r6
>  	mtspr	SPRN_TEXASR, r7
> -#endif
> -	ld	r8, VCPU_EBBHR(r4)
>  	mtspr	SPRN_EBBHR, r8
>  	ld	r5, VCPU_EBBRR(r4)
>  	ld	r6, VCPU_BESCR(r4)
> @@ -1122,15 +1120,13 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_207S)
>  	std	r5, VCPU_IC(r9)
>  	std	r6, VCPU_VTB(r9)
>  	std	r7, VCPU_TAR(r9)
> -#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
>  	mfspr	r5, SPRN_TFHAR
>  	mfspr	r6, SPRN_TFIAR
>  	mfspr	r7, SPRN_TEXASR
> +	mfspr	r8, SPRN_EBBHR
>  	std	r5, VCPU_TFHAR(r9)
>  	std	r6, VCPU_TFIAR(r9)
>  	std	r7, VCPU_TEXASR(r9)
> -#endif
> -	mfspr	r8, SPRN_EBBHR
>  	std	r8, VCPU_EBBHR(r9)
>  	mfspr	r5, SPRN_EBBRR
>  	mfspr	r6, SPRN_BESCR
> @@ -1504,73 +1500,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
>  1:	addi	r8,r8,16
>  	.endr
>  
> -	/* Save DEC */
> -	mfspr	r5,SPRN_DEC
> -	mftb	r6
> -	extsw	r5,r5
> -	add	r5,r5,r6
> -	std	r5,VCPU_DEC_EXPIRES(r9)
> -
> -BEGIN_FTR_SECTION
> -	b	8f
> -END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_207S)
> -	/* Turn on TM so we can access TFHAR/TFIAR/TEXASR */
> -	mfmsr	r8
> -	li	r0, 1
> -	rldimi	r8, r0, MSR_TM_LG, 63-MSR_TM_LG
> -	mtmsrd	r8
> -
> -	/* Save POWER8-specific registers */
> -	mfspr	r5, SPRN_IAMR
> -	mfspr	r6, SPRN_PSPB
> -	mfspr	r7, SPRN_FSCR
> -	std	r5, VCPU_IAMR(r9)
> -	stw	r6, VCPU_PSPB(r9)
> -	std	r7, VCPU_FSCR(r9)
> -	mfspr	r5, SPRN_IC
> -	mfspr	r6, SPRN_VTB
> -	mfspr	r7, SPRN_TAR
> -	std	r5, VCPU_IC(r9)
> -	std	r6, VCPU_VTB(r9)
> -	std	r7, VCPU_TAR(r9)
> -#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> -	mfspr	r5, SPRN_TFHAR
> -	mfspr	r6, SPRN_TFIAR
> -	mfspr	r7, SPRN_TEXASR
> -	std	r5, VCPU_TFHAR(r9)
> -	std	r6, VCPU_TFIAR(r9)
> -	std	r7, VCPU_TEXASR(r9)
> -#endif
> -	mfspr	r8, SPRN_EBBHR
> -	std	r8, VCPU_EBBHR(r9)
> -	mfspr	r5, SPRN_EBBRR
> -	mfspr	r6, SPRN_BESCR
> -	mfspr	r7, SPRN_CSIGR
> -	mfspr	r8, SPRN_TACR
> -	std	r5, VCPU_EBBRR(r9)
> -	std	r6, VCPU_BESCR(r9)
> -	std	r7, VCPU_CSIGR(r9)
> -	std	r8, VCPU_TACR(r9)
> -	mfspr	r5, SPRN_TCSCR
> -	mfspr	r6, SPRN_ACOP
> -	mfspr	r7, SPRN_PID
> -	mfspr	r8, SPRN_WORT
> -	std	r5, VCPU_TCSCR(r9)
> -	std	r6, VCPU_ACOP(r9)
> -	stw	r7, VCPU_GUEST_PID(r9)
> -	std	r8, VCPU_WORT(r9)
> -8:
> -
> -	/* Save and reset AMR and UAMOR before turning on the MMU */
> -BEGIN_FTR_SECTION
> -	mfspr	r5,SPRN_AMR
> -	mfspr	r6,SPRN_UAMOR
> -	std	r5,VCPU_AMR(r9)
> -	std	r6,VCPU_UAMOR(r9)
> -	li	r6,0
> -	mtspr	SPRN_AMR,r6
> -END_FTR_SECTION_IFSET(CPU_FTR_ARCH_206)
> -
>  	/* Unset guest mode */
>  	li	r0, KVM_GUEST_MODE_NONE
>  	stb	r0, HSTATE_IN_GUEST(r13)
> -- 
> 1.8.3.2

Paul.
