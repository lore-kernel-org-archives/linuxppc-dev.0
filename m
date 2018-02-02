Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zXhVs38cpzF0Xl
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Feb 2018 13:57:57 +1100 (AEDT)
Date: Fri, 2 Feb 2018 13:55:56 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org, lvivier@redhat.com
Subject: Re: [PATCH v5 1/1] KVM: PPC: Book3S: Add MMIO emulation for VMX
 instructions
Message-ID: <20180202025556.bx4lo7f763l2esvx@oak.ozlabs.ibm.com>
References: <20180201181539.9650-1-joserz@linux.vnet.ibm.com>
 <20180201181539.9650-2-joserz@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180201181539.9650-2-joserz@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 01, 2018 at 04:15:39PM -0200, Jose Ricardo Ziviani wrote:
> This patch provides the MMIO load/store vector indexed
> X-Form emulation.
> 
> Instructions implemented:
> lvx: the quadword in storage addressed by the result of EA &
> 0xffff_ffff_ffff_fff0 is loaded into VRT.
> 
> stvx: the contents of VRS are stored into the quadword in storage
> addressed by the result of EA & 0xffff_ffff_ffff_fff0.
> 
> Reported-by: Gopesh Kumar Chaudhary <gopchaud@in.ibm.com>
> Reported-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
> Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/kvm_host.h   |   2 +
>  arch/powerpc/include/asm/kvm_ppc.h    |   4 +
>  arch/powerpc/include/asm/ppc-opcode.h |   6 ++
>  arch/powerpc/kvm/emulate_loadstore.c  |  34 ++++++++
>  arch/powerpc/kvm/powerpc.c            | 153 +++++++++++++++++++++++++++++++++-
>  5 files changed, 198 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
> index 3aa5b577cd60..045acc843e98 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -690,6 +690,7 @@ struct kvm_vcpu_arch {
>  	u8 mmio_vsx_offset;
>  	u8 mmio_vsx_copy_type;
>  	u8 mmio_vsx_tx_sx_enabled;
> +	u8 mmio_vmx_copy_nums;
>  	u8 osi_needed;
>  	u8 osi_enabled;
>  	u8 papr_enabled;
> @@ -800,6 +801,7 @@ struct kvm_vcpu_arch {
>  #define KVM_MMIO_REG_QPR	0x0040
>  #define KVM_MMIO_REG_FQPR	0x0060
>  #define KVM_MMIO_REG_VSX	0x0080
> +#define KVM_MMIO_REG_VMX	0x00c0
>  
>  #define __KVM_HAVE_ARCH_WQP
>  #define __KVM_HAVE_CREATE_DEVICE
> diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
> index 9db18287b5f4..7765a800ddae 100644
> --- a/arch/powerpc/include/asm/kvm_ppc.h
> +++ b/arch/powerpc/include/asm/kvm_ppc.h
> @@ -81,6 +81,10 @@ extern int kvmppc_handle_loads(struct kvm_run *run, struct kvm_vcpu *vcpu,
>  extern int kvmppc_handle_vsx_load(struct kvm_run *run, struct kvm_vcpu *vcpu,
>  				unsigned int rt, unsigned int bytes,
>  			int is_default_endian, int mmio_sign_extend);
> +extern int kvmppc_handle_load128_by2x64(struct kvm_run *run,
> +		struct kvm_vcpu *vcpu, unsigned int rt, int is_default_endian);
> +extern int kvmppc_handle_store128_by2x64(struct kvm_run *run,
> +		struct kvm_vcpu *vcpu, unsigned int rs, int is_default_endian);
>  extern int kvmppc_handle_store(struct kvm_run *run, struct kvm_vcpu *vcpu,
>  			       u64 val, unsigned int bytes,
>  			       int is_default_endian);
> diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
> index ab5c1588b487..f1083bcf449c 100644
> --- a/arch/powerpc/include/asm/ppc-opcode.h
> +++ b/arch/powerpc/include/asm/ppc-opcode.h
> @@ -156,6 +156,12 @@
>  #define OP_31_XOP_LFDX          599
>  #define OP_31_XOP_LFDUX		631
>  
> +/* VMX Vector Load Instructions */
> +#define OP_31_XOP_LVX           103
> +
> +/* VMX Vector Store Instructions */
> +#define OP_31_XOP_STVX          231
> +
>  #define OP_LWZ  32
>  #define OP_STFS 52
>  #define OP_STFSU 53
> diff --git a/arch/powerpc/kvm/emulate_loadstore.c b/arch/powerpc/kvm/emulate_loadstore.c
> index af833531af31..332b82eafd48 100644
> --- a/arch/powerpc/kvm/emulate_loadstore.c
> +++ b/arch/powerpc/kvm/emulate_loadstore.c
> @@ -58,6 +58,18 @@ static bool kvmppc_check_vsx_disabled(struct kvm_vcpu *vcpu)
>  }
>  #endif /* CONFIG_VSX */
>  
> +#ifdef CONFIG_ALTIVEC
> +static bool kvmppc_check_altivec_disabled(struct kvm_vcpu *vcpu)
> +{
> +	if (!(kvmppc_get_msr(vcpu) & MSR_VEC)) {
> +		kvmppc_core_queue_vec_unavail(vcpu);
> +		return true;
> +	}
> +
> +	return false;
> +}
> +#endif /* CONFIG_ALTIVEC */
> +
>  /*
>   * XXX to do:
>   * lfiwax, lfiwzx
> @@ -98,6 +110,7 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
>  	vcpu->arch.mmio_vsx_copy_type = KVMPPC_VSX_COPY_NONE;
>  	vcpu->arch.mmio_sp64_extend = 0;
>  	vcpu->arch.mmio_sign_extend = 0;
> +	vcpu->arch.mmio_vmx_copy_nums = 0;
>  
>  	switch (get_op(inst)) {
>  	case 31:
> @@ -459,6 +472,27 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
>  							 rs, 4, 1);
>  			break;
>  #endif /* CONFIG_VSX */
> +
> +#ifdef CONFIG_ALTIVEC
> +		case OP_31_XOP_LVX:
> +			if (kvmppc_check_altivec_disabled(vcpu))
> +				return EMULATE_DONE;
> +			vcpu->arch.vaddr_accessed &= ~0xFULL;
> +			vcpu->arch.mmio_vmx_copy_nums = 2;
> +			emulated = kvmppc_handle_load128_by2x64(run, vcpu,
> +					KVM_MMIO_REG_VMX|rt, 1);
> +			break;
> +
> +		case OP_31_XOP_STVX:
> +			if (kvmppc_check_altivec_disabled(vcpu))
> +				return EMULATE_DONE;
> +			vcpu->arch.vaddr_accessed &= ~0xFULL;
> +			vcpu->arch.mmio_vmx_copy_nums = 2;
> +			emulated = kvmppc_handle_store128_by2x64(run, vcpu,
> +					rs, 1);
> +			break;
> +#endif /* CONFIG_ALTIVEC */
> +
>  		default:
>  			emulated = EMULATE_FAIL;
>  			break;
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 1915e86cef6f..a19f42120b38 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -832,7 +832,7 @@ void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *cons,
>  		kvm->arch.kvm_ops->irq_bypass_del_producer(cons, prod);
>  }
>  
> -#ifdef CONFIG_VSX
> +#ifdef CONFIG_ALTIVEC
>  static inline int kvmppc_get_vsr_dword_offset(int index)
>  {
>  	int offset;
> @@ -848,7 +848,9 @@ static inline int kvmppc_get_vsr_dword_offset(int index)
>  
>  	return offset;
>  }
> +#endif /* CONFIG_ALTIVEC */
>  
> +#ifdef CONFIG_VSX
>  static inline int kvmppc_get_vsr_word_offset(int index)

You make the dword version available with ALTIVEC && ~VSX, but in fact
it's the word version that you use below.  However, I don't think we
actually want either of them (see below).

>  {
>  	int offset;
> @@ -925,6 +927,31 @@ static inline void kvmppc_set_vsr_word(struct kvm_vcpu *vcpu,
>  }
>  #endif /* CONFIG_VSX */
>  
> +#ifdef CONFIG_ALTIVEC
> +static inline void kvmppc_set_vmx_dword(struct kvm_vcpu *vcpu,
> +		u64 gpr)
> +{
> +	int index = vcpu->arch.io_gpr & KVM_MMIO_REG_MASK;
> +	u32 hi, lo;
> +
> +#ifdef __BIG_ENDIAN
> +	hi = gpr >> 32;
> +	lo = gpr & 0xffffffff;
> +#else
> +	lo = gpr >> 32;
> +	hi = gpr & 0xffffffff;
> +#endif
> +
> +	if (vcpu->arch.mmio_vmx_copy_nums == 1) {
> +		VCPU_VSX_VR(vcpu, index).u[kvmppc_get_vsr_word_offset(2)] = lo;
> +		VCPU_VSX_VR(vcpu, index).u[kvmppc_get_vsr_word_offset(3)] = hi;
> +	} else if (vcpu->arch.mmio_vmx_copy_nums == 2) {
> +		VCPU_VSX_VR(vcpu, index).u[kvmppc_get_vsr_word_offset(0)] = lo;
> +		VCPU_VSX_VR(vcpu, index).u[kvmppc_get_vsr_word_offset(1)] = hi;
> +	}

Since what we're doing is a 16-byte load, the main thing we have to do
here in handling a cross-endian situation is to swap the two 8-byte
halves.  The byte-swapping within each 8-byte half has already been
handled more generically.

I suggest the following code.  It is simpler and passes my test case.

static inline void kvmppc_set_vmx_dword(struct kvm_vcpu *vcpu,
		u64 gpr)
{
	int index = vcpu->arch.io_gpr & KVM_MMIO_REG_MASK;
	u32 hi, lo;
	u32 di;

#ifdef __BIG_ENDIAN
	hi = gpr >> 32;
	lo = gpr & 0xffffffff;
#else
	lo = gpr >> 32;
	hi = gpr & 0xffffffff;
#endif

	di = 2 - vcpu->arch.mmio_vmx_copy_nums;		/* doubleword index */
	if (di > 1)
		return;
	if (vcpu->arch.mmio_host_swabbed)
		di = 1 - di;

	VCPU_VSX_VR(vcpu, index).u[di * 2] = hi;
	VCPU_VSX_VR(vcpu, index).u[di * 2 + 1] = lo;
}

> +static inline int kvmppc_get_vmx_data(struct kvm_vcpu *vcpu, int rs, u64 *val)
> +{
> +	vector128 vrs = VCPU_VSX_VR(vcpu, rs);
> +
> +	if (vcpu->arch.mmio_vmx_copy_nums == 1) {
> +#ifdef __BIG_ENDIAN
> +		*val = vrs.u[kvmppc_get_vsr_word_offset(3)];
> +		*val = (*val << 32) | vrs.u[kvmppc_get_vsr_word_offset(2)];
> +#else
> +		*val = vrs.u[kvmppc_get_vsr_word_offset(2)];
> +		*val = (*val << 32) | vrs.u[kvmppc_get_vsr_word_offset(3)];
> +#endif
> +		return 0;
> +	} else if (vcpu->arch.mmio_vmx_copy_nums == 2) {
> +#ifdef __BIG_ENDIAN
> +		*val = vrs.u[kvmppc_get_vsr_word_offset(1)];
> +		*val = (*val << 32) | vrs.u[kvmppc_get_vsr_word_offset(0)];
> +#else
> +		*val = vrs.u[kvmppc_get_vsr_word_offset(0)];
> +		*val = (*val << 32) | vrs.u[kvmppc_get_vsr_word_offset(1)];
> +#endif
> +		return 0;
> +	}
> +	return -1;

Once again the main thing is to swap the two halves.  My suggested
code is:

static inline int kvmppc_get_vmx_data(struct kvm_vcpu *vcpu, int rs, u64 *val)
{
	vector128 vrs = VCPU_VSX_VR(vcpu, rs);
	u32 di;
	u64 w0, w1;

	di = 2 - vcpu->arch.mmio_vmx_copy_nums;		/* doubleword index */
	if (di > 1)
		return -1;
	if (vcpu->arch.mmio_host_swabbed)
		di = 1 - di;

	w0 = vrs.u[di * 2];
	w1 = vrs.u[di * 2 + 1];

#ifdef __BIG_ENDIAN
	*val = (w0 << 32) | w1;
#else
	*val = (w1 << 32) | w0;
#endif
	return 0;
}

Paul.
