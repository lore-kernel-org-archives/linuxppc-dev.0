Return-Path: <dwalker@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 406FBDDE9B
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 14:09:30 +1000 (EST)
Subject: Re: [PATCH v2 2/4] Implement generic time of day clocksource for
	powerpc machines.
From: Daniel Walker <dwalker@mvista.com>
To: Tony Breeds <tony@bakeyournoodle.com>
In-Reply-To: <20070921032603.07AF232C889@thor>
References: <20070921032603.07AF232C889@thor>
Content-Type: text/plain
Date: Thu, 20 Sep 2007 21:05:46 -0700
Message-Id: <1190347546.15347.27.camel@imap.mvista.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
	Paul Mackerras <paulus@samba.org>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-09-21 at 13:26 +1000, Tony Breeds wrote:
> +
> +       if (__USE_RTC())
> +               clock = &clocksource_rtc;
> +       else
> +               clock = &clocksource_timebase;
> +
> +       clock->mult = clocksource_hz2mult(tb_ticks_per_sec,
> clock->shift);

I don't think the RTC frequency isn't the same as the timebase? Seems
like the RTC only case about seconds at the lowest level. If that's the
case then the jiffies clock might be better to use .. The other thing I
wonder is if the __USE_RTC boards might have lower level clocks that
could be used instead ..

Daniel
