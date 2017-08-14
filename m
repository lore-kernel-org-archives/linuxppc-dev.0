Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWCjz1mhXzDr54
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 21:16:55 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, apopple@au1.ibm.com, hbabu@us.ibm.com,
 oohall@gmail.com, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 14/17] powerpc: Add support for setting SPRN_TIDR
In-Reply-To: <1502233622-9330-15-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1502233622-9330-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1502233622-9330-15-git-send-email-sukadev@linux.vnet.ibm.com>
Date: Mon, 14 Aug 2017 21:16:53 +1000
Message-ID: <87pobyqtzu.fsf@concordia.ellerman.id.au>
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

> We need the SPRN_TIDR to bet set for use with fast thread-wakeup
> (core-to-core wakeup).  Each thread in a process needs to have a
> unique id within the process but as explained below, for now, we
> assign globally unique thread ids to all threads in the system.

Each thread in a process already has a unique id, ie. its pid (in the
init PID namespace), accessible in the kernel as task_pid_nr(task).

So if that's all we need, we don't need a new allocator, and we don't
need to store it in the thread_struct.

Also 99.99% of processes aren't going to care about the TIDR, so we
should avoid setting it in the common case. ie. it should start out zero
and only be initialised in the FTW code, or a helper that it calls.

> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index 9f3e2c9..6123859 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1213,6 +1213,16 @@ struct task_struct *__switch_to(struct task_struct *prev,
>  		hard_irq_disable();
>  	}
>  
> +#ifdef CONFIG_PPC_VAS
> +	mtspr(SPRN_TIDR, new->thread.tidr);
> +#endif

That should be in restore_sprs().

It should also check that the TIDR is initialised, and only switch it
when necessary.

> +	/*
> +	 * We can't take a PMU exception inside _switch() since there is a
> +	 * window where the kernel stack SLB and the kernel stack are out
> +	 * of sync. Hard disable here.
> +	 */
> +	hard_irq_disable();

We removed that in June in:

 e4c0fc5f72bc ("powerpc/64s: Leave interrupts hard enabled in context switch for radix")

You've obviously picked it up somewhere along the line during a rebase,
please be more careful!

cheers
