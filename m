Return-Path: <richardcochran@gmail.com>
Received: from mail-wi0-x22d.google.com (mail-wi0-x22d.google.com
 [IPv6:2a00:1450:400c:c05::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1C6551A1E36
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 18:42:41 +1000 (AEST)
Received: by wiax7 with SMTP id x7so77839332wia.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 01:42:36 -0700 (PDT)
Date: Mon, 20 Apr 2015 10:42:30 +0200
From: Richard Cochran <richardcochran@gmail.com>
To: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH 11/11] k_clock:Remove the 32bit methods with timespec type
Message-ID: <20150420084229.GA4608@localhost.localdomain>
References: <1429509459-17068-1-git-send-email-baolin.wang@linaro.org>
 <1429509459-17068-12-git-send-email-baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1429509459-17068-12-git-send-email-baolin.wang@linaro.org>
Cc: pang.xunlei@linaro.org, peterz@infradead.org, heiko.carstens@de.ibm.com,
 paulus@samba.org, cl@linux.com, heenasirwani@gmail.com,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, y2038@lists.linaro.org,
 rafael.j.wysocki@intel.com, ahh@google.com, fweisbec@gmail.com, pjt@google.com,
 riel@redhat.com, arnd@arndb.de, schwidefsky@de.ibm.com, john.stultz@linaro.org,
 tglx@linutronix.de, rth@twiddle.net, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tj@kernel.org,
 linux390@de.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 20, 2015 at 01:57:39PM +0800, Baolin Wang wrote:

> @@ -911,18 +907,14 @@ retry:
>  		return -EINVAL;
>  
>  	kc = clockid_to_kclock(timr->it_clock);
> -	if (WARN_ON_ONCE(!kc || (!kc->timer_set && !kc->timer_set64))) {
> +	if (WARN_ON_ONCE(!kc || !kc->timer_set64)) {
>  		error = -EINVAL;
>  	} else {
> -		if (kc->timer_set64) {
> -			new_spec64 = itimerspec_to_itimerspec64(new_spec);
> -			error = kc->timer_set64(timr, flags, &new_spec64,
> -						&old_spec64);
> -			if (old_setting)
> -				old_spec = itimerspec64_to_itimerspec(old_spec64);
> -		} else {
> -			error = kc->timer_set(timr, flags, &new_spec, rtn);
> -		}
> +		new_spec64 = itimerspec_to_itimerspec64(new_spec);
> +		error = kc->timer_set64(timr, flags, &new_spec64,
> +					&old_spec64);

This statement can fit on one line.

> +		if (old_setting)
> +			old_spec = itimerspec64_to_itimerspec(old_spec64);
>  	}
>  
>  	unlock_timer(timr, flag);

> @@ -1057,14 +1045,13 @@ SYSCALL_DEFINE2(clock_gettime, const clockid_t, which_clock,
>  	if (!kc)
>  		return -EINVAL;
>  
> -	if (kc->clock_get64) {
> -		error = kc->clock_get64(which_clock, &kernel_tp64);
> -		kernel_tp = timespec64_to_timespec(kernel_tp64);
> -	} else {
> -		error = kc->clock_get(which_clock, &kernel_tp);
> -	}
> +	error = kc->clock_get64(which_clock, &kernel_tp64);
> +	if (!error)
> +		return error;

Wrong test, should be: if (error) ...

> +
> +	kernel_tp = timespec64_to_timespec(kernel_tp64);
>  
> -	if (!error && copy_to_user(tp, &kernel_tp, sizeof (kernel_tp)))

The (!error && ...) was correct here!

> +	if (copy_to_user(tp, &kernel_tp, sizeof (kernel_tp)))
>  		error = -EFAULT;
>  
>  	return error;

You can simplify this like so:

	return copy_to_user(tp, &kernel_tp, sizeof(kernel_tp)) ? -EFAULT : 0;

> @@ -1104,14 +1091,13 @@ SYSCALL_DEFINE2(clock_getres, const clockid_t, which_clock,
>  	if (!kc)
>  		return -EINVAL;
>  
> -	if (kc->clock_getres64) {
> -		error = kc->clock_getres64(which_clock, &rtn_tp64);
> -		rtn_tp = timespec64_to_timespec(rtn_tp64);
> -	} else {
> -		error = kc->clock_getres(which_clock, &rtn_tp);
> -	}
> +	error = kc->clock_getres64(which_clock, &rtn_tp64);
> +	if (!error)
> +		return error;

Also wrong.

> +
> +	rtn_tp = timespec64_to_timespec(rtn_tp64);
>  
> -	if (!error && tp && copy_to_user(tp, &rtn_tp, sizeof (rtn_tp)))
> +	if (tp && copy_to_user(tp, &rtn_tp, sizeof (rtn_tp)))
>  		error = -EFAULT;
>  
>  	return error;
> -- 
> 1.7.9.5
> 

Thanks,
Richard
