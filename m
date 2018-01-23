Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zQfYr6ynGzDqsP
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jan 2018 18:09:36 +1100 (AEDT)
Date: Tue, 23 Jan 2018 16:49:16 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: wei.guo.simon@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH 04/26] KVM: PPC: Book3S PR: add C function wrapper for
 _kvmppc_save/restore_tm()
Message-ID: <20180123054916.GC3924@fergus.ozlabs.ibm.com>
References: <1515665499-31710-1-git-send-email-wei.guo.simon@gmail.com>
 <1515665499-31710-5-git-send-email-wei.guo.simon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1515665499-31710-5-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 11, 2018 at 06:11:17PM +0800, wei.guo.simon@gmail.com wrote:
> From: Simon Guo <wei.guo.simon@gmail.com>
> 
> Currently _kvmppc_save/restore_tm() APIs can only be invoked from
> assembly function. This patch adds C function wrappers for them so
> that they can be safely called from C function.
> 
> Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>

[snip]

> --- a/arch/powerpc/include/asm/asm-prototypes.h
> +++ b/arch/powerpc/include/asm/asm-prototypes.h
> @@ -126,4 +126,11 @@ unsigned long __init prom_init(unsigned long r3, unsigned long r4,
>  void _mcount(void);
>  unsigned long prepare_ftrace_return(unsigned long parent, unsigned long ip);
>  
> +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> +/* Transaction memory related */
> +struct kvm_vcpu;
> +void _kvmppc_restore_tm_pr(struct kvm_vcpu *vcpu, u64 guest_msr);
> +void _kvmppc_save_tm_pr(struct kvm_vcpu *vcpu, u64 guest_msr);
> +#endif

It's not generally necessary to have ifdefs around function
declarations.  If the function is never defined because the feature
is not configured in, that is fine.

> @@ -149,6 +149,58 @@ _GLOBAL(kvmppc_save_tm)
>  	blr
>  
>  /*
> + * _kvmppc_save_tm() is a wrapper around __kvmppc_save_tm(), so that it can
> + * be invoked from C function by PR KVM only.
> + */
> +_GLOBAL(_kvmppc_save_tm_pr)
> +	mflr	r5
> +	std	r5, PPC_LR_STKOFF(r1)
> +	stdu    r1, -SWITCH_FRAME_SIZE(r1)
> +	SAVE_NVGPRS(r1)
> +
> +	/* save MSR since TM/math bits might be impacted
> +	 * by __kvmppc_save_tm().
> +	 */
> +	mfmsr	r5
> +	SAVE_GPR(5, r1)
> +
> +	/* also save DSCR/CR so that it can be recovered later */
> +	mfspr   r6, SPRN_DSCR
> +	SAVE_GPR(6, r1)
> +
> +	mfcr    r7
> +	stw     r7, _CCR(r1)
> +
> +	/* allocate stack frame for __kvmppc_save_tm since
> +	 * it will save LR into its stackframe and we don't
> +	 * want to corrupt _kvmppc_save_tm_pr's.
> +	 */
> +	stdu    r1, -PPC_MIN_STKFRM(r1)

You don't need to do this.  In the PowerPC ELF ABI, functions always
save their LR (i.e. their return address) in their *caller's* stack
frame, not their own.  You have established a stack frame for
_kvmppc_save_tm_pr above, and that is sufficient.  Same comment
applies for _kvmppc_restore_tm_pr.

Paul.
