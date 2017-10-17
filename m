Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yGKVG01xPzDrD6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 13:52:21 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id s75so299253pgs.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Oct 2017 19:52:20 -0700 (PDT)
Date: Tue, 17 Oct 2017 12:52:04 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Kees Cook <keescook@chromium.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/watchdog: Convert timers to use timer_setup()
Message-ID: <20171017125204.728b3a95@roar.ozlabs.ibm.com>
In-Reply-To: <20171016234710.GA102273@beast>
References: <20171016234710.GA102273@beast>
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

On Mon, 16 Oct 2017 16:47:10 -0700
Kees Cook <keescook@chromium.org> wrote:

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

Looks fine to me. Is this intended to be merged via the powerpc tree
in the next merge window?

Acked-by: Nicholas Piggin <npiggin@gmail.com>

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
