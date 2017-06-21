Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wsnyD0dHHzDq88
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 12:01:40 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, akpm@linux-foundation.org,
 Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] powerpc/64: Initialise thread_info for emergency stacks
In-Reply-To: <20170620135801.13272-1-npiggin@gmail.com>
References: <20170620135801.13272-1-npiggin@gmail.com>
Date: Wed, 21 Jun 2017 12:01:37 +1000
Message-ID: <87shiut7y6.fsf@concordia.ellerman.id.au>
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

Nicholas Piggin <npiggin@gmail.com> writes:

> diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
> index a941cc6fc3e9..5995e4b2996d 100644
> --- a/arch/powerpc/include/asm/thread_info.h
> +++ b/arch/powerpc/include/asm/thread_info.h
> @@ -62,6 +63,24 @@ struct thread_info {
>  
>  #define THREAD_SIZE_ORDER	(THREAD_SHIFT - PAGE_SHIFT)
>  
> +/*
> + * Emergency stacks are used for a range of things, from asynchronous
> + * NMIs (system reset, machine check) to synchronous, process context.
> + * Set HARDIRQ_OFFSET because we don't know exactly what context we
> + * come from or if it had a valid stack, which is about the best we
> + * can do.
> + * TODO: what to do with accounting?
> + */
> +#define emstack_init_thread_info(ti, c)		\
> +do {						\
> +	(ti)->task = NULL;			\
> +	(ti)->cpu = (c);			\
> +	(ti)->preempt_count = HARDIRQ_OFFSET;	\
> +	(ti)->local_flags = 0;			\
> +	(ti)->flags = 0;			\
> +	klp_init_thread_info(ti);		\
> +} while (0)

Why don't we just bzero() the whole thing? Like we do for the other
stacks?

cheers
