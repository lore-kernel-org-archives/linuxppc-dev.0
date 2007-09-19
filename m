Return-Path: <dwalker@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 12116DDF5F
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 01:46:49 +1000 (EST)
Subject: Re: [PATCH 2/5] Implement generic time of day clocksource for
	powerpc machines.
From: Daniel Walker <dwalker@mvista.com>
To: Tony Breeds <tony@bakeyournoodle.com>
In-Reply-To: <20070919064947.4B5A1399910@thor>
References: <20070919064947.4B5A1399910@thor>
Content-Type: text/plain
Date: Wed, 19 Sep 2007 08:43:14 -0700
Message-Id: <1190216594.11899.3.camel@imap.mvista.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
	Paul Mackerras <paulus@samba.org>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>, johnstul@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-09-19 at 16:49 +1000, Tony Breeds wrote:
> +/* clocksource code */
> +/* FIXME: provide an RTC clocksource /or/ use a better name */
> +static cycle_t timebase_read(void)
> +{
> +       if (__USE_RTC())
> +               return (cycle_t)get_rtc();
> +       return (cycle_t)get_tb();
> +}

If you switch to the rtc do the shift and mult need to change?

> +void update_vsyscall(struct timespec *wall_time, struct clocksource
> *clock)
> +{
> +       u64 t2x, stamp_xsec;
> +
> +       if (__USE_RTC() || clock != &clocksource_timebase)
> +               return;
> +
> +       /* Make userspace gettimeofday spin until we're done. */
> +       ++vdso_data->tb_update_count;
> +       smp_mb();
> +
> +       /* XXX this assumes clock->shift == 22 */
> +       /* 4611686018 ~= 2^(20+64-22) / 1e9 */
> +       t2x = (u64) clock->mult * 4611686018ULL;

It might make the code more readable if you put that constant into a
macro that gives it a name.

Daniel
