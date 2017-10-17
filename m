Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yGLmB0Nm8zDrD6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 14:49:30 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Kees Cook <keescook@chromium.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/watchdog: Convert timers to use timer_setup()
In-Reply-To: <20171016234710.GA102273@beast>
References: <20171016234710.GA102273@beast>
Date: Tue, 17 Oct 2017 14:49:29 +1100
Message-ID: <87o9p6juwm.fsf@concordia.ellerman.id.au>
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

Kees Cook <keescook@chromium.org> writes:

> In preparation for unconditionally passing the struct timer_list pointer to
> all timer callbacks, switch to using the new timer_setup() and from_timer()
> to pass the timer pointer explicitly.
>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/powerpc/kernel/watchdog.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
> index 15e209a37c2d..50797528b5e1 100644
> --- a/arch/powerpc/kernel/watchdog.c
> +++ b/arch/powerpc/kernel/watchdog.c
> @@ -263,9 +263,8 @@ static void wd_timer_reset(unsigned int cpu, struct timer_list *t)
>  	add_timer_on(t, cpu);
>  }
>  
> -static void wd_timer_fn(unsigned long data)
> +static void wd_timer_fn(struct timer_list *t)

At first glance this looks like it will break, changing the signature,
but the new timer_setup() force-casts to the old signature (for now),
and we can fit a pointer in an unsigned long so it's OK.

>  {
> -	struct timer_list *t = this_cpu_ptr(&wd_timer);
>  	int cpu = smp_processor_id();
>  
>  	watchdog_timer_interrupt(cpu);
> @@ -292,7 +291,7 @@ static void start_watchdog_timer_on(unsigned int cpu)
>  
>  	per_cpu(wd_timer_tb, cpu) = get_tb();
>  
> -	setup_pinned_timer(t, wd_timer_fn, 0);
> +	timer_setup(t, wd_timer_fn, TIMER_PINNED);
>  	wd_timer_reset(cpu, t);
>  }
>  

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
