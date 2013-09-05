Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 85EFA2C00CB
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Sep 2013 21:50:43 +1000 (EST)
Message-ID: <1378381835.4321.169.camel@pasglop>
Subject: Re: [PATCH] powerpc: Fix possible deadlock on page fault
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Thu, 05 Sep 2013 21:50:35 +1000
In-Reply-To: <87a9jrwkuc.fsf@linux.vnet.ibm.com>
References: <1378365422-25203-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20130905095316.GA18222@iris.ozlabs.ibm.com>
 <87a9jrwkuc.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-09-05 at 17:18 +0530, Aneesh Kumar K.V wrote:
> Paul Mackerras <paulus@samba.org> writes:
> 
> > On Thu, Sep 05, 2013 at 12:47:02PM +0530, Aneesh Kumar K.V wrote:
> >
> >> @@ -280,6 +280,13 @@ int __kprobes do_page_fault(struct pt_regs *regs, unsigned long address,
> >>  
> >>  	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
> >>  
> >> +	/*
> >> +	 * We want to do this outside mmap_sem, because reading code around nip
> >> +	 * can result in fault, which will cause a deadlock when called with
> >> +	 * mmap_sem held
> >> +	 */
> >> +	store_update = store_updates_sp(regs);
> >
> > We should only call store_updates_sp() if user_mode(regs); that was
> > the previous behaviour.
> 
> Updated to 
> 
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index 8726779..fad7af6 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -206,7 +206,7 @@ int __kprobes do_page_fault(struct pt_regs *regs, unsigned long address,
>  	int trap = TRAP(regs);
>   	int is_exec = trap == 0x400;
>  	int fault;
> -	int rc = 0;
> +	int rc = 0, store_update = 0;

Keep the "sp", in the name, it's confusing otherwise. It's not just
about "store update", it's about specifically recognizing instructions
used to update the stack frame in order to let them and only them
significantly lower the stack pointer.

Cheers,
Ben.

>  #if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
>  	/*
> @@ -280,6 +280,14 @@ int __kprobes do_page_fault(struct pt_regs *regs, unsigned long address,
>  
>  	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
>  
> +	/*
> +	 * We want to do this outside mmap_sem, because reading code around nip
> +	 * can result in fault, which will cause a deadlock when called with
> +	 * mmap_sem held
> +	 */
> +	if (user_mode(regs))
> +		store_update = store_updates_sp(regs);
> +
>  	/* When running in the kernel we expect faults to occur only to
>  	 * addresses in user space.  All other faults represent errors in the
>  	 * kernel and should generate an OOPS.  Unfortunately, in the case of an
> @@ -345,8 +353,7 @@ retry:
>  		 * between the last mapped region and the stack will
>  		 * expand the stack rather than segfaulting.
>  		 */
> -		if (address + 2048 < uregs->gpr[1]
> -		    && (!user_mode(regs) || !store_updates_sp(regs)))
> +		if (address + 2048 < uregs->gpr[1] && !store_update)
>  			goto bad_area;
>  	}
>  	if (expand_stack(vma, address))
