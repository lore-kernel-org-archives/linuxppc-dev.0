Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CF7D1DDDF8
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 16:11:30 +1000 (EST)
Date: Mon, 15 Oct 2007 08:11:03 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] Hook compat_sys_nanosleep up to high res timer code
In-Reply-To: <20071014231616.GA24519@kryten>
Message-ID: <alpine.LFD.0.9999.0710150804290.22612@localhost.localdomain>
References: <20071014215437.GF26693@kryten> <200710150028.06493.arnd@arndb.de>
	<20071014231616.GA24519@kryten>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, mingo@elte.hu, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 14 Oct 2007, Anton Blanchard wrote:
> Hi Arnd,
>  
> > The code looks correct, but I think it would be nicer to change 
> > hrtimer_nanosleep to take a kernel pointer and have all three
> > callers (common_nsleep, sys_nanosleep and compat_sys_nanosleep)
> > do the copy_to_user/put_compat_timespec in the caller.
> 
> Good idea, I had considered that but thought a larger cleanup might run
> afoul of the merge rules :)

Looks good, except ....
 
> --- a/kernel/compat.c
> +++ b/kernel/compat.c
> @@ -40,62 +40,26 @@ int put_compat_timespec(const struct timespec *ts, struct compat_timespec __user
>  			__put_user(ts->tv_nsec, &cts->tv_nsec)) ? -EFAULT : 0;
>  }

Can you put this into a separate patch please ?
  
> --- a/kernel/hrtimer.c
> +++ b/kernel/hrtimer.c
>  	restart = &current_thread_info()->restart_block;
> @@ -1353,7 +1347,8 @@ long hrtimer_nanosleep(struct timespec *rqtp, struct timespec __user *rmtp,
>  asmlinkage long
>  sys_nanosleep(struct timespec __user *rqtp, struct timespec __user *rmtp)
>  {
> -	struct timespec tu;
> +	struct timespec tu, rmt;
> +	int ret;
>  
>  	if (copy_from_user(&tu, rqtp, sizeof(tu)))
>  		return -EFAULT;
> @@ -1361,7 +1356,14 @@ sys_nanosleep(struct timespec __user *rqtp, struct timespec __user *rmtp)
>  	if (!timespec_valid(&tu))
>  		return -EINVAL;
>  
> -	return hrtimer_nanosleep(&tu, rmtp, HRTIMER_MODE_REL, CLOCK_MONOTONIC);
> +	ret = hrtimer_nanosleep(&tu, &rmt, HRTIMER_MODE_REL, CLOCK_MONOTONIC);
> +
> +	if (ret) {

Can you check for rmtp as well ? rmtp is optional and can be NULL

> +		if (copy_to_user(rmtp, &rmt, sizeof(*rmtp)))
> +			return -EFAULT;
> +	}
> +
> +	return ret;
>  }
>  
>  /*
> diff --git a/kernel/posix-timers.c b/kernel/posix-timers.c
> index 7a15afb..fc7dac2 100644
> --- a/kernel/posix-timers.c
> +++ b/kernel/posix-timers.c
> @@ -980,9 +980,19 @@ sys_clock_getres(const clockid_t which_clock, struct timespec __user *tp)
>  static int common_nsleep(const clockid_t which_clock, int flags,
>  			 struct timespec *tsave, struct timespec __user *rmtp)
>  {
> -	return hrtimer_nanosleep(tsave, rmtp, flags & TIMER_ABSTIME ?
> +	struct timespec rmt;
> +	int ret;
> +
> +	ret = hrtimer_nanosleep(tsave, &rmt, flags & TIMER_ABSTIME ?
>  				 HRTIMER_MODE_ABS : HRTIMER_MODE_REL,
>  				 which_clock);
> +
> +	if (ret) {

Ditto.

> +		if (copy_to_user(rmtp, &rmt, sizeof(*rmtp)))
> +			return -EFAULT;
> +	}
> +
> +	return ret;
>  }

Thanks,

	tglx
