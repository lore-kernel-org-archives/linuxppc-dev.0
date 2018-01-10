Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zH3ly2HldzF0hF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 09:37:02 +1100 (AEDT)
Date: Thu, 11 Jan 2018 09:36:58 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH RESEND 1/1] KVM: PPC: Book3S: Add MMIO emulation for VMX
 instructions
Message-ID: <20180110223658.GB24294@fergus.ozlabs.ibm.com>
References: <20180108182931.355-1-joserz@linux.vnet.ibm.com>
 <20180108182931.355-2-joserz@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180108182931.355-2-joserz@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 08, 2018 at 04:29:31PM -0200, Jose Ricardo Ziviani wrote:
> This patch provides the MMIO load/store vector indexed
> X-Form emulation.
> 
> Instructions implemented: lvx, stvx
> 
> Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>

What testing has been done of this patch?  In particular, what
combinations of endianness of host and guest have been tested?  For a
cross-endian situation (endianness of guest different from host) you
would need to load the two halves of the VMX register image in
reversed order (note that lvx/stvx are different from lxvd2x/stxvd2x
and lxvw4x/stxvw4x in this respect), and I don't see that being done.

Also, lvx/stvx mask off the bottom 4 bits of the EA, and I don't see
that being done.

[snip]

> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 1915e86cef6f..7d0f60359ee0 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -832,23 +832,7 @@ void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *cons,
>  		kvm->arch.kvm_ops->irq_bypass_del_producer(cons, prod);
>  }
>  
> -#ifdef CONFIG_VSX
> -static inline int kvmppc_get_vsr_dword_offset(int index)
> -{
> -	int offset;
> -
> -	if ((index != 0) && (index != 1))
> -		return -1;
> -
> -#ifdef __BIG_ENDIAN
> -	offset =  index;
> -#else
> -	offset = 1 - index;
> -#endif
> -
> -	return offset;
> -}
> -

Why does this function need to be moved down in the file?

> +#ifdef CONFIG_ALTIVEC
>  static inline int kvmppc_get_vsr_word_offset(int index)
>  {
>  	int offset;
> @@ -864,6 +848,40 @@ static inline int kvmppc_get_vsr_word_offset(int index)
>  	return offset;
>  }
>  
> +static inline void kvmppc_set_vmx_dword(struct kvm_vcpu *vcpu,
> +		u64 gpr)
> +{
> +	int index = vcpu->arch.io_gpr & KVM_MMIO_REG_MASK;
> +	u64 hi = gpr >> 32;
> +	u64 lo = gpr & 0xffffffff;
> +
> +	if (vcpu->arch.mmio_vmx_copy_nums == 1) {
> +		VCPU_VSX_VR(vcpu, index).u[kvmppc_get_vsr_word_offset(2)] = hi;
> +		VCPU_VSX_VR(vcpu, index).u[kvmppc_get_vsr_word_offset(3)] = lo;
> +	} else if (vcpu->arch.mmio_vmx_copy_nums == 2) {
> +		VCPU_VSX_VR(vcpu, index).u[kvmppc_get_vsr_word_offset(0)] = hi;
> +		VCPU_VSX_VR(vcpu, index).u[kvmppc_get_vsr_word_offset(1)] = lo;
> +	}

This splitting of the value into hi/lo words looks to me like you're
assuming a big-endian byte ordering.  It looks like it will end up
swapping the words in each half of the register on a little-endian
host (regardless of the endianness of the guest).

> +}
> +#endif /* CONFIG_ALTIVEC */
> +
> +#ifdef CONFIG_VSX
> +static inline int kvmppc_get_vsr_dword_offset(int index)
> +{
> +	int offset;
> +
> +	if ((index != 0) && (index != 1))
> +		return -1;
> +
> +#ifdef __BIG_ENDIAN
> +	offset =  index;
> +#else
> +	offset = 1 - index;
> +#endif
> +
> +	return offset;
> +}
> +
>  static inline void kvmppc_set_vsr_dword(struct kvm_vcpu *vcpu,
>  	u64 gpr)
>  {
> @@ -1027,6 +1045,11 @@ static void kvmppc_complete_mmio_load(struct kvm_vcpu *vcpu,
>  				KVMPPC_VSX_COPY_DWORD_LOAD_DUMP)
>  			kvmppc_set_vsr_dword_dump(vcpu, gpr);
>  		break;
> +#endif
> +#ifdef CONFIG_ALTIVEC
> +	case KVM_MMIO_REG_VMX:
> +		kvmppc_set_vmx_dword(vcpu, gpr);
> +		break;
>  #endif
>  	default:
>  		BUG();
> @@ -1307,6 +1330,99 @@ static int kvmppc_emulate_mmio_vsx_loadstore(struct kvm_vcpu *vcpu,
>  }
>  #endif /* CONFIG_VSX */
>  
> +#ifdef CONFIG_ALTIVEC
> +/* handle quadword load access in two halves */
> +int kvmppc_handle_load128_by2x64(struct kvm_run *run, struct kvm_vcpu *vcpu,
> +		unsigned int rt, int is_default_endian)
> +{
> +	enum emulation_result emulated = EMULATE_DONE;
> +
> +	while (vcpu->arch.mmio_vmx_copy_nums) {
> +		emulated = __kvmppc_handle_load(run, vcpu, rt, 8,
> +				is_default_endian, 0);
> +		if (emulated != EMULATE_DONE)
> +			break;
> +
> +		vcpu->arch.mmio_vmx_copy_nums--;
> +	}
> +	return emulated;
> +}
> +
> +static inline int kvmppc_get_vmx_data(struct kvm_vcpu *vcpu, int rs, u64 *val)
> +{
> +
> +	if (vcpu->arch.mmio_vmx_copy_nums == 1) {
> +		*val = VCPU_VSX_VR(vcpu, rs).u[kvmppc_get_vsr_word_offset(2)];
> +		*val = (*val << 32) | VCPU_VSX_VR(vcpu, rs).
> +			u[kvmppc_get_vsr_word_offset(3)];
> +		return 0;
> +	} else if (vcpu->arch.mmio_vmx_copy_nums == 2) {
> +		*val = VCPU_VSX_VR(vcpu, rs).u[kvmppc_get_vsr_word_offset(0)];
> +		*val = (*val << 32) | VCPU_VSX_VR(vcpu, rs).
> +			u[kvmppc_get_vsr_word_offset(1)];
> +		return 0;
> +	}
> +	return -1;
> +}

Once again, the way this puts two word values together to get a
doubleword looks wrong for a little-endian host.

Paul.
