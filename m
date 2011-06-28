Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5742AB6F6C
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Jun 2011 10:45:53 +1000 (EST)
Subject: Re: [PATCH] powerpc/timebase_read: don't return time older than
	cycle_last
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20110627215613.GA13676@schlenkerla.am.freescale.net>
References: <20110627215613.GA13676@schlenkerla.am.freescale.net>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 28 Jun 2011 10:45:43 +1000
Message-ID: <1309221943.32158.412.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-06-27 at 16:56 -0500, Scott Wood wrote:
> As is done in read_tsc() on x86, make sure that we don't return a timebase
> value smaller than cycle_last, which can happen on SMP if the timebases are
> not perfectly synchronized.  It is less expensive than total enforcement of
> monotonicity, since we don't need to add another variable and update it on
> each read, but it will prevent core timekeeping functions from translating
> a small timebase regression into a large jump forward.
> 
> Based on commit d8bb6f4c1670c8324e4135c61ef07486f7f17379 for x86.

You are applying a bandage on a wooden leg here .... userspace (vDSO)
will see the time going backward if you aren't well synchronized as
well, so you're stuffed anyways.

Cheers,
Ben.

> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  arch/powerpc/kernel/time.c |   15 ++++++++++++++-
>  1 files changed, 14 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
> index f33acfd..b66ce41 100644
> --- a/arch/powerpc/kernel/time.c
> +++ b/arch/powerpc/kernel/time.c
> @@ -806,9 +806,22 @@ static cycle_t rtc_read(struct clocksource *cs)
>  	return (cycle_t)get_rtc();
>  }
>  
> +/*
> + * We compare the timebase to the cycle_last value in the clocksource
> + * structure to avoid a nasty time-warp.  This can be observed in a very
> + * small window right after one CPU updated cycle_last under the xtime lock,
> + * and the other CPU reads a TSC value which is smaller than the cycle_last
> + * reference value due to a TSC which is slighty behind.  This delta is
> + * nowhere else observable, but in that case it results in a large forward
> + * time jump due to the unsigned delta calculation of the time keeping core
> + * code, which is necessary to support wrapping clocksources like pm timer.
> + */
>  static cycle_t timebase_read(struct clocksource *cs)
>  {
> -	return (cycle_t)get_tb();
> +	cycle_t ret = (cycle_t)get_tb();
> +
> +	return ret >= clocksource_timebase.cycle_last ?
> +	       ret : clocksource_timebase.cycle_last;
>  }
>  
>  void update_vsyscall(struct timespec *wall_time, struct timespec *wtm,
