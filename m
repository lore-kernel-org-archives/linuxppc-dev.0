Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wnn3C2hn4zDqL9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 23:07:03 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 2/4] powerpc/64: context switch avoid reservation-clearing
 instruction
In-Reply-To: <20170608153609.19217-2-npiggin@gmail.com>
References: <20170608153609.19217-1-npiggin@gmail.com>
 <20170608153609.19217-2-npiggin@gmail.com>
Date: Wed, 14 Jun 2017 23:07:02 +1000
Message-ID: <8760fypvk9.fsf@concordia.ellerman.id.au>
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

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 803c3bc274c4..1f0688ad09d7 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2875,6 +2875,12 @@ context_switch(struct rq *rq, struct task_struct *prev,
>  	rq_unpin_lock(rq, rf);
>  	spin_release(&rq->lock.dep_map, 1, _THIS_IP_);
>  
> +	/*
> +	 * Some architectures require that a spin lock is taken before
> +	 * _switch. The rq_lock satisfies this condition. See powerpc
> +	 * _switch for details.
> +	 */
> +
>  	/* Here we just switch the register state and the stack. */
>  	switch_to(prev, next, prev);
>  	barrier();

I dropped this hunk, if you want to merge it you can resend it and get
an ack from Peterz.

cheers
