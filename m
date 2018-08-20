Return-Path: <npiggin@gmail.com>
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41v8dr3NHRzDqp5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 20:08:31 +1000 (AEST)
Received: by mail-pg1-x542.google.com with SMTP id a11-v6so6543093pgw.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 03:08:31 -0700 (PDT)
Date: Mon, 20 Aug 2018 20:08:22 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [RFC PATCH 1/5] powerpc/64s/hash: convert SLB miss handlers to C
Message-ID: <20180820200822.111a659e@roar.ozlabs.ibm.com>
In-Reply-To: <20180820094200.13003-2-npiggin@gmail.com>
References: <20180820094200.13003-1-npiggin@gmail.com>
 <20180820094200.13003-2-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 20 Aug 2018 19:41:56 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:


> +long do_slb_fault(struct pt_regs *regs, unsigned long ea)
> +{
> +	unsigned long id = REGION_ID(ea);
> +
> +	/* IRQs are not reconciled here, so can't check irqs_disabled */
> +	VM_WARN_ON(mfmsr() & MSR_EE);
> +
> +	/*
> +	 * SLB kernel faults must be very careful not to touch anything
> +	 * that is not bolted. E.g., PACA and global variables are okay,
> +	 * mm->context stuff is not.
> +	 *
> +	 * SLB user faults can access all of kernel memory, but must be
> +	 * careful not to touch things like IRQ state because it is not
> +	 * "reconciled" here. The difficulty is that we must use
> +	 * fast_exception_return to return from kernel SLB faults without
> +	 * looking at possible non-bolted memory. We could test user vs
> +	 * kernel faults in the interrupt handler asm and do a full fault,
> +	 * reconcile, ret_from_except for user faults which would make them
> +	 * first class kernel code. But for performance it's probably nicer
> +	 * if they go via fast_exception_return too.
> +	 */
> +	if (id >= KERNEL_REGION_ID) {
> +		return slb_allocate_kernel(ea, id);
> +	} else {
> +		struct mm_struct *mm = current->mm;
> +
> +		if (unlikely(!mm))
> +			return -EFAULT;
>  
> -	handle_multi_context_slb_miss(context, ea);
> -	exception_exit(prev_state);
> -	return;
> +		return slb_allocate_user(mm, ea);
> +	}
> +}
>  
> -slb_bad_addr:
> +void do_bad_slb_fault(struct pt_regs *regs, unsigned long ea, long err)
> +{
>  	if (user_mode(regs))
>  		_exception(SIGSEGV, regs, SEGV_BNDERR, ea);
>  	else
>  		bad_page_fault(regs, ea, SIGSEGV);
> -	exception_exit(prev_state);
>  }

I knew I forgot something -- forgot to test MSR[RI] here. That can be
done just by returning a different error from do_slb_fault if RI is
clear, and do_bad_slb_fault will call unrecoverable_exception() if it
sees that code.

Thanks,
Nick
