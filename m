Return-Path: <SRS0=nZGU=SK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F43C10F13
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 14:15:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 195C521473
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 14:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="LGUUay/e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 195C521473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44dCB33MQGzDqLH
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 00:15:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=axtens.net
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=dja@axtens.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.b="LGUUay/e"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44dC7P53pWzDqLC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Apr 2019 00:13:05 +1000 (AEST)
Received: by mail-pf1-x441.google.com with SMTP id w25so6251014pfi.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Apr 2019 07:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=kGV1PBwjjGmfNXiIPhDPDObGucr/MBGAyK+Yp5pY11o=;
 b=LGUUay/eUvhDDpHsHLl5Mr25j7KXDCSTFsVgEY34ckQGVf/4TakCH+nTQ5j2RuUc0y
 riJHb1nR8AUZsXgeZw3I2yuJEP0ovl0yPvwUVyHtNe6pn1NocbxEH1tY8AH1KUfjhysE
 cWNxAE1917WLW4WgIIste1zzoXSZBalBwKGnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=kGV1PBwjjGmfNXiIPhDPDObGucr/MBGAyK+Yp5pY11o=;
 b=RgMNjW1Uhe/QMrOLSuR8mKd/ikdcdl28keKKm8mzGNw2DGJomLdwVW48BVqJ93BhzT
 +fVg3rdG7HDx3SVZlV/1AZiG51oByiOzl2BAR+DkiP1uTUSIGDbj1Xq7Aexox3ROWzjg
 JiaQZyHK7Z5KCo0V2oejEiaxJ9CGvK96weq0x3VJf59GRqjy0ITA2GWu6Y+axF9kyzHx
 nCEFf3Auflr53TETcRZCsWu7tj5d/mQOXTgcSVri6a0jLWbfRCuA1fjQVKquKkNVAPeK
 eDv0MCvoKzU8bt/f8jqlQ6PYBpCJGbCjh7eI+sl4RsmHzR3Ctgdl1F2h1CKME3TO/H75
 yRKw==
X-Gm-Message-State: APjAAAWFtYytfBZCvp2QxqwLLWcrjb5G+Rq4I77rVRPsjuk9wKsL1P14
 S0LwgJnIo9ujiD8Rce//Qd9ObQ==
X-Google-Smtp-Source: APXvYqyDD13SWkD0Vn1RpSBWh2QKPDJk0NOGJcjTZBMyUZwJKOEw1X4P09lO+tYnJqlPCJiPxmcfdA==
X-Received: by 2002:a63:3dca:: with SMTP id
 k193mr27917935pga.146.1554732783159; 
 Mon, 08 Apr 2019 07:13:03 -0700 (PDT)
Received: from localhost (124-171-136-51.dyn.iinet.net.au. [124.171.136.51])
 by smtp.gmail.com with ESMTPSA id c81sm10978867pfb.158.2019.04.08.07.13.00
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 08 Apr 2019 07:13:01 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Abhishek Goel <huntbag@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/2] cpuidle : auto-promotion for cpuidle states
In-Reply-To: <20190405091647.4169-2-huntbag@linux.vnet.ibm.com>
References: <20190405091647.4169-1-huntbag@linux.vnet.ibm.com>
 <20190405091647.4169-2-huntbag@linux.vnet.ibm.com>
Date: Tue, 09 Apr 2019 00:12:57 +1000
Message-ID: <87r2acwpp2.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Abhishek Goel <huntbag@linux.vnet.ibm.com>, daniel.lezcano@linaro.org,
 rjw@rjwysocki.net, ego@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Abhishek,

> Currently, the cpuidle governors (menu /ladder) determine what idle state
> an idling CPU should enter into based on heuristics that depend on the
> idle history on that CPU. Given that no predictive heuristic is perfect,
> there are cases where the governor predicts a shallow idle state, hoping
> that the CPU will be busy soon. However, if no new workload is scheduled
> on that CPU in the near future, the CPU will end up in the shallow state.
>
> In case of POWER, this is problematic, when the predicted state in the
> aforementioned scenario is a lite stop state, as such lite states will
> inhibit SMT folding, thereby depriving the other threads in the core from
> using the core resources.
>
> To address this, such lite states need to be autopromoted. The cpuidle-
> core can queue timer to correspond with the residency value of the next
> available state. Thus leading to auto-promotion to a deeper idle state as
> soon as possible.
>

This sounds sensible to me, although I'm not really qualified to offer a
full power-management opinion on it. I have some general code questions
and comments, however, which are below:

> Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
> ---
>
> v1->v2 : Removed timeout_needed and rebased to current upstream kernel
>
>  drivers/cpuidle/cpuidle.c          | 68 +++++++++++++++++++++++++++++-
>  drivers/cpuidle/governors/ladder.c |  3 +-
>  drivers/cpuidle/governors/menu.c   | 22 +++++++++-
>  include/linux/cpuidle.h            | 10 ++++-
>  4 files changed, 99 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 7f108309e..11ce43f19 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -36,6 +36,11 @@ static int enabled_devices;
>  static int off __read_mostly;
>  static int initialized __read_mostly;
>  
> +struct auto_promotion {
> +	struct hrtimer  hrtimer;
> +	unsigned long	timeout_us;
> +};
> +
>  int cpuidle_disabled(void)
>  {
>  	return off;
> @@ -188,6 +193,54 @@ int cpuidle_enter_s2idle(struct cpuidle_driver *drv, struct cpuidle_device *dev)
>  }
>  #endif /* CONFIG_SUSPEND */
>  
> +enum hrtimer_restart auto_promotion_hrtimer_callback(struct hrtimer *hrtimer)
> +{
> +	return HRTIMER_NORESTART;
> +}
> +
> +#ifdef CONFIG_CPU_IDLE_AUTO_PROMOTION
As far as I can tell, this config flag isn't defined until the next
patch, making this dead code for now. Is this intentional?

> +DEFINE_PER_CPU(struct auto_promotion, ap);

A quick grep suggests that most per-cpu variable have more descriptive
names, perhaps this one should too.

> +
> +static void cpuidle_auto_promotion_start(int cpu, struct cpuidle_state *state)
> +{
> +	struct auto_promotion *this_ap = &per_cpu(ap, cpu);
> +
> +	if (state->flags & CPUIDLE_FLAG_AUTO_PROMOTION)
> +		hrtimer_start(&this_ap->hrtimer, ns_to_ktime(this_ap->timeout_us
> +					* 1000), HRTIMER_MODE_REL_PINNED);
Would it be clearer to have both sides of the multiplication on the same
line? i.e.
+		hrtimer_start(&this_ap->hrtimer,
+			      ns_to_ktime(this_ap->timeout_us * 1000),
+			      HRTIMER_MODE_REL_PINNED);

> +}
> +
> +static void cpuidle_auto_promotion_cancel(int cpu)
> +{
> +	struct hrtimer *hrtimer;
> +
> +	hrtimer = &per_cpu(ap, cpu).hrtimer;
> +	if (hrtimer_is_queued(hrtimer))
> +		hrtimer_cancel(hrtimer);
> +}
> +
> +static void cpuidle_auto_promotion_update(int cpu, unsigned long timeout)
> +{
> +	per_cpu(ap, cpu).timeout_us = timeout;
> +}
> +
> +static void cpuidle_auto_promotion_init(int cpu, struct cpuidle_driver *drv)
> +{
> +	struct auto_promotion *this_ap = &per_cpu(ap, cpu);
> +
> +	hrtimer_init(&this_ap->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +	this_ap->hrtimer.function = auto_promotion_hrtimer_callback;
> +}
> +#else
> +static inline void cpuidle_auto_promotion_start(int cpu, struct cpuidle_state
> +						*state) { }
> +static inline void cpuidle_auto_promotion_cancel(int cpu) { }
> +static inline void cpuidle_auto_promotion_update(int cpu, unsigned long
> +						timeout) { }
> +static inline void cpuidle_auto_promotion_init(int cpu, struct cpuidle_driver
> +						*drv) { }

Several of these have the type, then a line break, and then the name
(unsigned long\n  timeout). This is a bit harder to read, they should
probably all be on the same line.

> +#endif
> +
>  /**
>   * cpuidle_enter_state - enter the state and update stats
>   * @dev: cpuidle device for this cpu
> @@ -225,12 +278,17 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
>  	trace_cpu_idle_rcuidle(index, dev->cpu);
>  	time_start = ns_to_ktime(local_clock());
>  
> +	cpuidle_auto_promotion_start(dev->cpu, target_state);
> +
>  	stop_critical_timings();
>  	entered_state = target_state->enter(dev, drv, index);
>  	start_critical_timings();
>  
>  	sched_clock_idle_wakeup_event();
>  	time_end = ns_to_ktime(local_clock());
> +
> +	cpuidle_auto_promotion_cancel(dev->cpu);
> +
>  	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, dev->cpu);
>  
>  	/* The cpu is no longer idle or about to enter idle. */
> @@ -312,7 +370,13 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
>  int cpuidle_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>  		   bool *stop_tick)
>  {
> -	return cpuidle_curr_governor->select(drv, dev, stop_tick);
> +	unsigned long timeout_us, ret;
> +
> +	timeout_us = UINT_MAX;
> +	ret = cpuidle_curr_governor->select(drv, dev, stop_tick, &timeout_us);
> +	cpuidle_auto_promotion_update(dev->cpu, timeout_us);
> +
> +	return ret;
>  }
>  
>  /**
> @@ -658,6 +722,8 @@ int cpuidle_register(struct cpuidle_driver *drv,
>  		device = &per_cpu(cpuidle_dev, cpu);
>  		device->cpu = cpu;
>  
> +		cpuidle_auto_promotion_init(cpu, drv);
> +
>  #ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
>  		/*
>  		 * On multiplatform for ARM, the coupled idle states could be
> diff --git a/drivers/cpuidle/governors/ladder.c b/drivers/cpuidle/governors/ladder.c
> index f0dddc66a..65b518dd7 100644
> --- a/drivers/cpuidle/governors/ladder.c
> +++ b/drivers/cpuidle/governors/ladder.c
> @@ -64,7 +64,8 @@ static inline void ladder_do_selection(struct ladder_device *ldev,
>   * @dummy: not used

I think you need an addition to the docstring for your new variable.

>   */
>  static int ladder_select_state(struct cpuidle_driver *drv,
> -			       struct cpuidle_device *dev, bool *dummy)
> +			       struct cpuidle_device *dev, bool *dummy,
> +			       unsigned long *unused)
>  {
>  	struct ladder_device *ldev = this_cpu_ptr(&ladder_devices);
>  	struct ladder_device_state *last_state;
> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
> index 5951604e7..835e337de 100644
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -276,7 +276,7 @@ static unsigned int get_typical_interval(struct menu_device *data,
>   * @stop_tick: indication on whether or not to stop the tick

Likewise here.

>   */
>  static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
> -		       bool *stop_tick)
> +		       bool *stop_tick, unsigned long *timeout)
>  {
>  	struct menu_device *data = this_cpu_ptr(&menu_devices);
>  	int latency_req = cpuidle_governor_latency_req(dev->cpu);
> @@ -442,6 +442,26 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>  		}
>  	}
>  
> +#ifdef CPUIDLE_FLAG_AUTO_PROMOTION
> +	if (drv->states[idx].flags & CPUIDLE_FLAG_AUTO_PROMOTION) {
> +		/*
> +		 * Timeout is intended to be defined as sum of target residency
> +		 * of next available state, entry latency and exit latency. If
> +		 * time interval equal to timeout is spent in current state,
> +		 * and if it is a shallow lite state, we may want to auto-
> +		 * promote from such state.

This comment makes sense if you already understand auto-promotion. That's
fair enough - you wrote it and you presumably understand what your code
does :) But for me it's a bit confusing! I think you want to start with
a sentence about what autopromotion is (preferably not using
power-specific terminology) and then explain the calculation of the
timeouts.

> +		 */
> +		for (i = idx + 1; i < drv->state_count; i++) {
> +			if (drv->states[i].disabled ||
> +					dev->states_usage[i].disable)
> +				continue;
> +			*timeout = drv->states[i].target_residency +
> +					2 * drv->states[i].exit_latency;
> +			break;
> +		}
> +	}
> +#endif
> +
>  	return idx;
>  }
>  
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index 3b3947232..84d76d1ec 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -72,6 +72,13 @@ struct cpuidle_state {
>  #define CPUIDLE_FLAG_POLLING	BIT(0) /* polling state */
>  #define CPUIDLE_FLAG_COUPLED	BIT(1) /* state applies to multiple cpus */
>  #define CPUIDLE_FLAG_TIMER_STOP BIT(2) /* timer is stopped on this state */
> +/*
> + * State with only and only fast state bit set don't even lose user context.
"only and only"?
> + * But such states prevent other sibling threads from thread folding benefits.
> + * And hence we don't want to stay for too long in such states and want to
> + * auto-promote from it.

I think this comment mixes Power-specific and generic concepts. (But I'm
not a PM expert so tell me if I'm wrong here.) I think, if I've
understood correctly: in the generic code, the bit represents a state
that we do not want to linger in, which we want to definitely leave
after some time. On Power, we have a state that doesn't lose user
context but which prevents thread folding, so this is an example of a
state where we want to auto-promote.

> + */
> +#define CPUIDLE_FLAG_AUTO_PROMOTION	BIT(3)
>  
>  struct cpuidle_device_kobj;
>  struct cpuidle_state_kobj;
> @@ -243,7 +250,8 @@ struct cpuidle_governor {
>  
>  	int  (*select)		(struct cpuidle_driver *drv,
>  					struct cpuidle_device *dev,
> -					bool *stop_tick);
> +					bool *stop_tick, unsigned long
> +					*timeout);
>  	void (*reflect)		(struct cpuidle_device *dev, int index);
>  };
>  
> -- 
> 2.17.1
