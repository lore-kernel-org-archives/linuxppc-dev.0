Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B5C5A1A0007
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2015 06:41:14 +1000 (AEST)
Date: Mon, 20 Apr 2015 22:40:57 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH 04/11] posix timers:Introduce the 64bit methods with
 timespec64 type for k_clock structure
In-Reply-To: <1429509459-17068-5-git-send-email-baolin.wang@linaro.org>
Message-ID: <alpine.DEB.2.11.1504202131500.13914@nanos>
References: <1429509459-17068-1-git-send-email-baolin.wang@linaro.org>
 <1429509459-17068-5-git-send-email-baolin.wang@linaro.org>
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
> @@ -771,6 +771,7 @@ SYSCALL_DEFINE2(timer_gettime, timer_t, timer_id,
>  		struct itimerspec __user *, setting)
>  {
>  	struct itimerspec cur_setting;
> +	struct itimerspec64 cur_setting64;
>  	struct k_itimer *timr;
>  	struct k_clock *kc;
>  	unsigned long flags;
> @@ -781,10 +782,16 @@ SYSCALL_DEFINE2(timer_gettime, timer_t, timer_id,
>  		return -EINVAL;
>  
>  	kc = clockid_to_kclock(timr->it_clock);
> -	if (WARN_ON_ONCE(!kc || !kc->timer_get))
> +	if (WARN_ON_ONCE(!kc || (!kc->timer_get && !kc->timer_get64))) {
>  		ret = -EINVAL;
> -	else
> -		kc->timer_get(timr, &cur_setting);
> +	} else {
> +		if (kc->timer_get64) {
> +			kc->timer_get64(timr, &cur_setting64);
> +			cur_setting = itimerspec64_to_itimerspec(cur_setting64);
> +		} else {
> +			kc->timer_get(timr, &cur_setting);
> +		}
> +	}

This is really horrible. You add a metric ton of conditionals to every
syscall just to remove them later again. I have not yet checked the
end result, but this approach is error prone as hell and just
introduces completely useless code churn.

It's useless because you do not factor out the guts of the syscall
functions so we can reuse the very same logic for the future 2038 safe
syscalls which we need to introduce for 32bit machines.

Take a look at the compat syscalls. They do the right thing.

COMPAT_SYSCALL_DEFINE2(timer_gettime, timer_t, timer_id,
                       struct compat_itimerspec __user *, setting)
{
        long err;
        mm_segment_t oldfs;
        struct itimerspec ts;

        oldfs = get_fs();
        set_fs(KERNEL_DS);
        err = sys_timer_gettime(timer_id,
                                (struct itimerspec __user *) &ts);
        set_fs(oldfs);
        if (!err && put_compat_itimerspec(setting, &ts))
                return -EFAULT;
        return err;
}

So we can be clever and do the following:

1) Preparatory work in posix-timer.c (Patch #1)

- Split out the guts of the syscall and change the syscall
  implementation

static int __timer_gettime(timer_t timer_id, struct itimerspec *cur_setting)
{
	struct k_itimer *timr;
	struct k_clock *kc;
	unsigned long flags;
	int ret = 0;

	timr = lock_timer(timer_id, &flags);
	if (!timr)
		return -EINVAL;

	kc = clockid_to_kclock(timr->it_clock);
	if (WARN_ON_ONCE(!kc || !kc->timer_get))
		ret = -EINVAL;
	else
		kc->timer_get(timr, &cur_setting);

	unlock_timer(timr, flags);
	return ret;
}

/* Get the time remaining on a POSIX.1b interval timer. */
SYSCALL_DEFINE2(timer_gettime, timer_t, timer_id,
		struct itimerspec __user *, setting)
{
	struct itimerspec cur_setting;
	int ret = __timer_gettime(timer_id, &cur_setting);

	if (!ret && copy_to_user(setting, &cur_setting, sizeof (cur_setting)))
		return -EFAULT;

	return ret;
}


2) Do the 64bit infrastructure work in posix-timer.c (Patch #2)

- Introduce k_clock->timer_get64() and provide a stub function

static int default_timer_get64(struct k_clock *kc, struct k_itimer *timr,
       	   		       struct itimerspec64 *cur_setting64)
{
	struct itimerspec cur_setting;

	kc->timer_get(timer, &cur_setting);
	return 0;
}

- Add the following to posix_timers_register_clock()

       if (kc->timer_get && !kc->timer_get64)
       	  	kc->timer_get64 = default_timer_get64;


- Convert __timer_gettime to 64bit

-static int __timer_gettime(timer_t timer_id, struct itimerspec64 *cur_setting)
+static int __timer_gettime(timer_t timer_id, struct itimerspec *cur_setting)
{
...
	kc = clockid_to_kclock(timr->it_clock);
+	if (WARN_ON_ONCE(!kc || !kc->timer))
-	if (WARN_ON_ONCE(!kc || !kc->timer_get64))
		ret = -EINVAL;
	else
-		kc->timer_get(timr, &cur_setting);
+		kc->timer_get64(timr, &cur_setting);

	unlock_timer(timr, flags);
	return ret;
}

- Change the syscall implementation in the following way:

/* Get the time remaining on a POSIX.1b interval timer. */
SYSCALL_DEFINE2(timer_gettime, timer_t, timer_id,
		struct itimerspec __user *, setting)
{
#ifdef CONFIG_64BIT
	struct itimerspec64 cur_setting;
	int ret = __timer_gettime(timer_id, &cur_setting);
#else
	struct itimerspec64 cur_setting64;
	struct itimerspec cur_setting;
	int ret = __timer_gettime(timer_id, &cur_setting64);

	if (!ret)
		cur_setting = itimerspec64_to_itimerspec(&cur_setting64);
#endif
	if (!ret && copy_to_user(setting, &cur_setting, sizeof (cur_setting)))
		return -EFAULT;
	return ret;
}

The result is two simple to review patches with minimal code churn.

The nice thing is that once we introduce new syscalls for 32bit
machines, e.g. sys_timer_gettime64(), all we need to do is:

/* Get the time remaining on a POSIX.1b interval timer. */
SYSCALL_DEFINE2(timer_gettime64, timer_t, timer_id,
		struct itimerspec64 __user *, setting)
{
	struct itimerspec64 cur_setting64;
	int ret = __timer_gettime(timer_id, &cur_setting64);

	if (!ret && copy_to_user(setting, &cur_setting, sizeof (cur_setting)))
		return -EFAULT;

	return ret;
}

And on 64bit timer_gettime64() and timer_gettime() are the same, so we
just need to do a clever mapping of timer_gettime() to
timer_gettime64(). Not rocket science....

For 32 bit we provide the old timer_gettime() for non converted
applications:

#ifdef CONFIG_32BIT_OLD_TIMESPEC_SYSCALLS
/* Get the time remaining on a POSIX.1b interval timer in the old timespec format. */
SYSCALL_DEFINE2(timer_gettime, timer_t, timer_id,
		struct itimerspec __user *, setting)
{
	struct itimerspec64 cur_setting64;
	struct itimerspec cur_setting;
	int ret = __timer_gettime(timer_id, &cur_setting64);

	if (!ret) {
		cur_setting = itimerspec64_to_itimerspec(&cur_setting64);

		if (copy_to_user(setting, &cur_setting, sizeof (cur_setting)))
		   	return -EFAULT;
	}
	return ret;
}
#endif

Simple, isn't it? No useless churn. Proper refactoring for the next
step. No useless copying for 64 bit.

3) Change one implementation after the other (Patches #3 - N)


4) Remove timer_get and the default implementation for timer_get64 and
   the hack in posix_timers_register_clock(). (Patch #N+1)
    
Send that lot out and let it review. Once this is fine we can move to
the next syscall.

Thanks,

	tglx
