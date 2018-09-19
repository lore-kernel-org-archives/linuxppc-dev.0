Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42FdgC6pQCzF3Jh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 21:58:47 +1000 (AEST)
Date: Wed, 19 Sep 2018 13:58:36 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Ingo Molnar <mingo@redhat.com>, segher@kernel.crashing.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 1/2] sched: move stack_canary field at the top of
 task_struct
Message-ID: <20180919115836.GE24124@hirez.programming.kicks-ass.net>
References: <d60ce7dd74704b0ca0a857186f30de4006b63534.1537355312.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d60ce7dd74704b0ca0a857186f30de4006b63534.1537355312.git.christophe.leroy@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 19, 2018 at 11:14:43AM +0000, Christophe Leroy wrote:
> In order to allow the use of non global stack protector canary,
> the stack canary needs to be located at a know offset defined
> in Makefile via -mstack-protector-guard-offset.
> 
> On powerpc/32, register r2 points to current task_struct at
> all time, the stack_canary located inside task_struct can be
> used directly if it is located in a known place.
> 
> In order to allow that, this patch moves the stack_canary field
> out of the randomized area of task_struct.

And you cannot use something like asm-offsets to extract this?

> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  include/linux/sched.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 977cb57d7bc9..1d977b8a4bac 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -601,6 +601,10 @@ struct task_struct {
>  	/* -1 unrunnable, 0 runnable, >0 stopped: */
>  	volatile long			state;
>  
> +#ifdef CONFIG_STACKPROTECTOR
> +	/* Canary value for the -fstack-protector GCC feature: */
> +	unsigned long			stack_canary;
> +#endif
>  	/*
>  	 * This begins the randomizable portion of task_struct. Only
>  	 * scheduling-critical items should be added above here.

Might as well put it before state, right after the task_info thing.
