Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17976.5964.593278.752595@cargo.ozlabs.ibm.com>
Date: Wed, 2 May 2007 14:45:00 +1000
From: Paul Mackerras <paulus@samba.org>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] powermac: proper time of day after resume
In-Reply-To: <1170357390.4036.9.camel@johannes.berg>
References: <20061213123819.403286000@sipsolutions.net>
	<20061213123945.386891000@sipsolutions.net>
	<1169620444.18754.66.camel@localhost.localdomain>
	<1170357390.4036.9.camel@johannes.berg>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Johannes Berg writes:

> +static int timer_resume(struct sys_device *dev)
> +{
> +	struct timeval tv;
> +	struct timespec ts;
> +	struct rtc_time cur_rtc_tm;
> +	unsigned long cur_rtc_time, diff;
> +
> +	/* get current RTC time and convert to seconds */
> +	get_rtc_time(&cur_rtc_tm);
> +	rtc_tm_to_time(&cur_rtc_tm, &cur_rtc_time);

Why not just use get_boot_time() here?  Or if not that, then use
mktime() instead of rtc_tm_to_time().  Either way we don't need to
select RTC_LIB.

> +	diff = cur_rtc_time - suspend_rtc_time;
> +
> +	/* adjust time of day by seconds that elapsed while
> +	 * we were suspended */
> +	do_gettimeofday(&tv);
> +	ts.tv_sec = tv.tv_sec + diff;
> +	ts.tv_nsec = tv.tv_usec * NSEC_PER_USEC;
> +	do_settimeofday(&ts);

This will fail if ts.tv_nsec ends up being >= NSEC_PER_SEC.

Paul.
