Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yXhPY6RppzDrLH
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Nov 2017 22:53:05 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 hbabu@us.ibm.com, nicholas.piggin@gmail.com, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 13/18] powerpc: Add support for setting SPRN_TIDR
In-Reply-To: <1510107838-15181-14-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1510107838-15181-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1510107838-15181-14-git-send-email-sukadev@linux.vnet.ibm.com>
Date: Thu, 09 Nov 2017 22:53:04 +1100
Message-ID: <87bmkbpt27.fsf@concordia.ellerman.id.au>
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

Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> writes:

> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index 37ed60b..d861fcd 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1120,6 +1120,13 @@ static inline void restore_sprs(struct thread_struct *old_thread,
>  			mtspr(SPRN_TAR, new_thread->tar);
>  	}
>  #endif
> +#ifdef CONFIG_PPC64
> +	if (old_thread->tidr != new_thread->tidr) {
> +		/* TIDR should be non-zero only with ISA3.0. */
> +		WARN_ON_ONCE(!cpu_has_feature(CPU_FTR_ARCH_300));

This is silly, just make the whole block depend on CPU_FTR_ARCH_300.

I've fixed it up.

> @@ -1466,6 +1581,10 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
>  
>  	clear_task_ebb(dst);
>  
> +#ifdef CONFIG_PPC64
> +	dst->thread.tidr = 0;
> +#endif
> +
>  	return 0;
>  }

This is called from clone().


> @@ -1576,6 +1695,9 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
>  #endif
>  
>  	setup_ksp_vsid(p, sp);
> +#ifdef CONFIG_PPC64
> +	p->thread.tidr = 0;
> +#endif
  
And so is this.

So I think you only need the latter.

That does mean you're clearing the TIDR on fork(), but not exec().

Typically you'd do the reverse, ie. clear it on exec() but leave it the
same on fork().

Because this is a "thread id" I think it does make sense to clear it on
fork(), otherwise you potentially have two processes with the same id
and only one of them will be woken up by the AS_notify.

So I'll drop the clear from arch_dup_task_struct().

cheers
