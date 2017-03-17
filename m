Return-Path: <aik@ozlabs.ru>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vl42L5nzVzDqZD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Mar 2017 23:11:38 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id 79so859023pgf.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Mar 2017 05:11:38 -0700 (PDT)
Subject: Re: [PATCH kernel] KVM: PPC: Add MMIO emulation for stdx (store
 doubleword indexed)
To: linuxppc-dev@lists.ozlabs.org
References: <20170317083138.36527-1-aik@ozlabs.ru>
Cc: Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <0aa18ddc-4715-8b2c-9d7f-44566aaf5d20@ozlabs.ru>
Date: Fri, 17 Mar 2017 23:11:30 +1100
MIME-Version: 1.0
In-Reply-To: <20170317083138.36527-1-aik@ozlabs.ru>
Content-Type: text/plain; charset=koi8-r
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 17/03/17 19:31, Alexey Kardashevskiy wrote:
> This adds missing stdx emulation which allow Mellanox driver from
> recent kernels work when MMIO emulation is enforced in the userspace.


btw what would its load counterpart? Load Doubleword Indexed - ldx RT,RA,RB?


> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  arch/powerpc/include/asm/ppc-opcode.h | 1 +
>  arch/powerpc/kvm/emulate_loadstore.c  | 6 ++++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
> index e7d6d86563ee..ca1bbe49590b 100644
> --- a/arch/powerpc/include/asm/ppc-opcode.h
> +++ b/arch/powerpc/include/asm/ppc-opcode.h
> @@ -92,6 +92,7 @@
>  #define OP_31_XOP_TRAP_64   68
>  #define OP_31_XOP_DCBF      86
>  #define OP_31_XOP_LBZX      87
> +#define OP_31_XOP_STDX      149
>  #define OP_31_XOP_STWX      151
>  #define OP_31_XOP_STBX      215
>  #define OP_31_XOP_LBZUX     119
> diff --git a/arch/powerpc/kvm/emulate_loadstore.c b/arch/powerpc/kvm/emulate_loadstore.c
> index 6d3c0ee1d744..9fdbeb8ea86c 100644
> --- a/arch/powerpc/kvm/emulate_loadstore.c
> +++ b/arch/powerpc/kvm/emulate_loadstore.c
> @@ -82,6 +82,12 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
>  			kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
>  			break;
>  
> +		case OP_31_XOP_STDX:
> +			emulated = kvmppc_handle_store(run, vcpu,
> +						       kvmppc_get_gpr(vcpu, rs),
> +							8, 1);
> +			break;
> +
>  		case OP_31_XOP_STWX:
>  			emulated = kvmppc_handle_store(run, vcpu,
>  						       kvmppc_get_gpr(vcpu, rs),
> 


-- 
Alexey
