Return-Path: <mark.rutland@arm.com>
Received: from cam-admin0.cambridge.arm.com (cam-admin0.cambridge.arm.com
 [217.140.96.50])
 by lists.ozlabs.org (Postfix) with ESMTP id 1B0511A0C59
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Dec 2014 00:53:46 +1100 (AEDT)
Date: Fri, 5 Dec 2014 13:39:08 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH] tick-broadcast: Register for hrtimer based broadcast as
 the default broadcast mode
Message-ID: <20141205133908.GA21313@leverpostej>
References: <20141205124756.25803.4988.stgit@preeti.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141205124756.25803.4988.stgit@preeti.in.ibm.com>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
 Will Deacon <Will.Deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "jingchang.lu@freescale.com" <jingchang.lu@freescale.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "fweisbec@gmail.com" <fweisbec@gmail.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "shawn.guo@linaro.org" <shawn.guo@linaro.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Preeti,

Moving this out of the architecture code looks good to me!

I have a couple of minor comments below.

On Fri, Dec 05, 2014 at 12:47:57PM +0000, Preeti U Murthy wrote:
> Commit 5d1638acb9f62fa7 added a hrtimer based broadcast mode for those
> platforms in which local timers stop when CPUs enter deep idle states. The
> commit expected the platforms to register for this mode explicitly when they
> lacked a better external device to wake up CPUs in deep idle. Given that
> more platforms are beginning to use this mode, we can avoid the call to
> set it up on every platform that requires it, by registering for the hrtimer
> based broadcast mode in the core code before clock devices begin to get
> initialized.
> 
> So if there exists a better broadcast device, it will overide the hrtimer
> based one; else there is a backup mechanism when a wakeup device is required.
> This commit also helps detect cases where the platform fails to register for
> a broadcast device but invokes the help of one when entering deep idle states.
> Currently we do not handle this situation at all and invoke the help of the
> broadcast clock device without checking for its existence. Registering a default
> broadcast mode will handle such buggy cases properly.
> 
> Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> ---
> 
>  arch/arm64/kernel/time.c   |    2 --
>  arch/powerpc/kernel/time.c |    1 -
>  kernel/time/timekeeping.c  |    4 ++++
>  3 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/time.c b/arch/arm64/kernel/time.c
> index 1a7125c..47baaa8 100644
> --- a/arch/arm64/kernel/time.c
> +++ b/arch/arm64/kernel/time.c
> @@ -70,8 +70,6 @@ void __init time_init(void)
>  	of_clk_init(NULL);
>  	clocksource_of_init();
>  
> -	tick_setup_hrtimer_broadcast();
> -
>  	arch_timer_rate = arch_timer_get_rate();
>  	if (!arch_timer_rate)
>  		panic("Unable to initialise architected timer.\n");
> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
> index 7505599..51433a8 100644
> --- a/arch/powerpc/kernel/time.c
> +++ b/arch/powerpc/kernel/time.c
> @@ -942,7 +942,6 @@ void __init time_init(void)
>  	clocksource_init();
>  
>  	init_decrementer_clockevent();
> -	tick_setup_hrtimer_broadcast();
>  }
>  
>  
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index ec1791f..6044a51 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -1016,6 +1016,10 @@ void __init timekeeping_init(void)
>  		boot.tv_sec = 0;
>  		boot.tv_nsec = 0;
>  	}
> +	/* Register for hrtimer based broadcast as the default timekeeping
> +	 * mode in deep idle states.
> +	 */

Nit: for code style this should have a newline after the '/*' (and we
should probably have a newline before that anyway.

> +	tick_setup_hrtimer_broadcast();

We register the generic dummy timer via an early_initcall, which keeps
all the logic in the dummy timer driver. Are we able to do the same of
the broadcast hrtimer? Or is there some ordering constraint we need to
meet?

Thanks,
Mark.

>  
>  	raw_spin_lock_irqsave(&timekeeper_lock, flags);
>  	write_seqcount_begin(&tk_core.seq);
> 
> 
