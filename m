Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AB77EB6EEE
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2012 10:47:54 +1100 (EST)
Message-ID: <1330300068.20389.63.camel@pasglop>
Subject: Re: [PATCH] powerpc: icswx: fix race condition where threads do not
 get their ACOP register updated in time.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jimi Xenidis <jimix@pobox.com>
Date: Mon, 27 Feb 2012 10:47:48 +1100
In-Reply-To: <1329948466-325-1-git-send-email-jimix@pobox.com>
References: <1329948466-325-1-git-send-email-jimix@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


>  
> +	/*
> +	 * We could be here because another thread has enabled acop
> +	 * but the ACOP register has yet to be updated.
> +	 *
> +	 * This should have been taken care of by the IPI to sync all
> +	 * the threads (see smp_call_function(sync_cop, mm, 1)), but
> +	 * that could take forever if there are a significant amount
> +	 * of threads.
> +	 *
> +	 * Given the number of threads on some of these systems,
> +	 * perhaps this is the best way to sync ACOP rather than whack
> +	 * every thread with an IPI.
> +	 */

This is actually pretty standard stuff... If it was me I would make it
all lazy and avoid the IPI completely but it doesn't necessarily hurt
that much. In any case the "recovery" is indeed needed and you should
probably also remove the pr_debug, it's really just spam.
 
> +	if (acop_copro_type_bit(ct) && current->active_mm->context.acop) {

Shouldn't that be "&" ? In fact, gcc would even warn so either make
it acop_check_copro(acop, ct) or do a (x & y) != 0

Cheers,
Ben.

> +		pr_debug("%s[%d]: Spurrious ACOP Fault, CT: %d, bit: 0x%llx "
> +			"SPR: 0x%lx, mm->acop: 0x%lx\n",
> +			current->comm, current->pid,
> +			ct, acop_copro_type_bit(ct), mfspr(SPRN_ACOP),
> +			current->active_mm->context.acop);
> +
> +		sync_cop(current->active_mm);
> +		return 0;
> +	}
> +
> +	/* check for alternate policy */
>  	if (!acop_use_cop(ct))
>  		return 0;
>  
>  	/* at this point the CT is unknown to the system */
> -	pr_warn("%s[%d]: Coprocessor %d is unavailable",
> +	pr_warn("%s[%d]: Coprocessor %d is unavailable\n",
>  		current->comm, current->pid, ct);
>  
>  	/* get inst if we don't already have it */
> diff --git a/arch/powerpc/mm/icswx.h b/arch/powerpc/mm/icswx.h
> index 42176bd..6dedc08 100644
> --- a/arch/powerpc/mm/icswx.h
> +++ b/arch/powerpc/mm/icswx.h
> @@ -59,4 +59,10 @@ extern void free_cop_pid(int free_pid);
>  
>  extern int acop_handle_fault(struct pt_regs *regs, unsigned long address,
>  			     unsigned long error_code);
> +
> +static inline u64 acop_copro_type_bit(unsigned int type)
> +{
> +	return 1ULL << (63 - type);
> +}
> +
>  #endif /* !_ARCH_POWERPC_MM_ICSWX_H_ */
