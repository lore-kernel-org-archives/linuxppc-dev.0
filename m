Return-Path: <srs0=ufkw=hy=gmail.com=npiggin@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40dJnb5c2hzDrLk
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 May 2018 16:26:59 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40dJnb4Ppfz8syK
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 May 2018 16:26:59 +1000 (AEST)
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40dJnb0KTqz9ryk
 for <linuxppc-dev@ozlabs.org>; Sat,  5 May 2018 16:26:58 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id o76so19035987pfi.5
 for <linuxppc-dev@ozlabs.org>; Fri, 04 May 2018 23:26:58 -0700 (PDT)
Date: Sat, 5 May 2018 16:26:40 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [RFC PATCH 1/4] powerpc/64: Save stack pointer when we hard
 disable interrupts
Message-ID: <20180505162640.06919112@roar.ozlabs.ibm.com>
In-Reply-To: <20180502130729.24077-1-mpe@ellerman.id.au>
References: <20180502130729.24077-1-mpe@ellerman.id.au>
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

On Wed,  2 May 2018 23:07:26 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> A CPU that gets stuck with interrupts hard disable can be difficult to
> debug, as on some platforms we have no way to interrupt the CPU to
> find out what it's doing.
> 
> A stop-gap is to have the CPU save it's stack pointer (r1) in its paca
> when it hard disables interrupts. That way if we can't interrupt it,
> we can at least trace the stack based on where it last disabled
> interrupts.
> 
> In some cases that will be total junk, but the stack trace code should
> handle that. In the simple case of a CPU that disable interrupts and
> then gets stuck in a loop, the stack trace should be informative.
> 
> We could clear the saved stack pointer when we enable interrupts, but
> that loses information which could be useful if we have nothing else
> to go on.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/include/asm/hw_irq.h    | 6 +++++-
>  arch/powerpc/include/asm/paca.h      | 2 +-
>  arch/powerpc/kernel/exceptions-64s.S | 1 +
>  arch/powerpc/xmon/xmon.c             | 2 ++
>  4 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
> index 855e17d158b1..35cb37be61fe 100644
> --- a/arch/powerpc/include/asm/hw_irq.h
> +++ b/arch/powerpc/include/asm/hw_irq.h
> @@ -237,8 +237,12 @@ static inline bool arch_irqs_disabled(void)
>  	__hard_irq_disable();						\
>  	flags = irq_soft_mask_set_return(IRQS_ALL_DISABLED);		\
>  	local_paca->irq_happened |= PACA_IRQ_HARD_DIS;			\
> -	if (!arch_irqs_disabled_flags(flags))				\
> +	if (!arch_irqs_disabled_flags(flags)) {				\
> +		asm ("stdx %%r1, 0, %1 ;"				\
> +		     : "=m" (local_paca->saved_r1)			\
> +		     : "b" (&local_paca->saved_r1));			\
>  		trace_hardirqs_off();					\
> +	}	

This is pretty neat, it would be good to have something that's not so
destructive as the NMI IPI.

Thanks,
Nick
