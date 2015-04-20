Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 51DED1A0007
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2015 06:48:16 +1000 (AEST)
Date: Mon, 20 Apr 2015 22:48:06 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH 05/11] time/posix-timers:Convert to the 64bit methods
 for k_clock callback functions
In-Reply-To: <1429509459-17068-6-git-send-email-baolin.wang@linaro.org>
Message-ID: <alpine.DEB.2.11.1504202243070.13914@nanos>
References: <1429509459-17068-1-git-send-email-baolin.wang@linaro.org>
 <1429509459-17068-6-git-send-email-baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: pang.xunlei@linaro.org, peterz@infradead.org, heiko.carstens@de.ibm.com,
 paulus@samba.org, cl@linux.com, heenasirwani@gmail.com,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, y2038@lists.linaro.org,
 rafael.j.wysocki@intel.com, ahh@google.com, fweisbec@gmail.com, pjt@google.com,
 riel@redhat.com, arnd@arndb.de, richardcochran@gmail.com,
 schwidefsky@de.ibm.com, john.stultz@linaro.org, rth@twiddle.net,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, tj@kernel.org, linux390@de.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 20 Apr 2015, Baolin Wang wrote:
>  /* Set clock_realtime */
>  static int posix_clock_realtime_set(const clockid_t which_clock,
> -				    const struct timespec *tp)
> +				    const struct timespec64 *tp)
>  {
> -	return do_sys_settimeofday(tp, NULL);
> +	struct timespec ts = timespec64_to_timespec(*tp);
> +
> +	return do_sys_settimeofday(&ts, NULL);

Sigh. No. We first provide a proper function for this, which takes a
timespec64, i.e. do_sys_settimeofday64() instead of having this
wrapper mess all over the place.

>  	/* SIGEV_NONE timers are not queued ! See common_timer_get */
>  	if (((timr->it_sigev_notify & ~SIGEV_THREAD_ID) == SIGEV_NONE)) {
> diff --git a/kernel/time/timekeeping.h b/kernel/time/timekeeping.h
> index 1d91416..144af14 100644
> --- a/kernel/time/timekeeping.h
> +++ b/kernel/time/timekeeping.h
> @@ -15,7 +15,7 @@ extern u64 timekeeping_max_deferment(void);
>  extern int timekeeping_inject_offset(struct timespec *ts);
>  extern s32 timekeeping_get_tai_offset(void);
>  extern void timekeeping_set_tai_offset(s32 tai_offset);
> -extern void timekeeping_clocktai(struct timespec *ts);
> +extern void timekeeping_clocktai(struct timespec64 *ts);

# git grep timekeeping_clocktai() is your friend.

Thanks,

	tglx
