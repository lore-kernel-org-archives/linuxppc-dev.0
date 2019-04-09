Return-Path: <SRS0=YLyy=SL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6593C10F0E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 10:04:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 147832083E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 10:04:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 147832083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44djYl6D9CzDqL2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 20:04:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.167.195; helo=mail-oi1-f195.google.com;
 envelope-from=rjwysocki@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com
 [209.85.167.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44djVY71gYzDq8W
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Apr 2019 20:01:25 +1000 (AEST)
Received: by mail-oi1-f195.google.com with SMTP id x188so12985470oia.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Apr 2019 03:01:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KRxph3b0OYBtaL79FzbaTlaoVbIYtKI0HcnduwI2Heo=;
 b=jQyFSxHORvXekMmlUhqvqr7egrkFpmHrYxevnVICTbHnoA1Frg3xBK1xuw8vZMmVCZ
 /586NAxmZPcKfCOQr2TV1f9ay4vi6HTBGZh82hb3YI0QPtwgAu3oTQlmQH0g+Hhje3K0
 b8W2FTOnPvCzGppQ4k/J4LqJWcxwEbhUxQlHBKE5rvT0LYSn/hR70OohwuBrneZWbUuv
 RhLvx0CPe0HiIFZo+uWAi0urG92b1fnBHdFol/4hEVdgQ6WJyVIyYv0G3sYvbKdxyk4J
 8KhYsyJqeR0dJjb11b3hutTde246oY9p+uTJqFSTu88Uv5PzUk6MlepFW5xvn9V9vJ/K
 MhLA==
X-Gm-Message-State: APjAAAVcWxNr0N4Hi7EN4JpRoBDqNp1HDSuiFz61mMJQ66mXdGd6+dbP
 LttiuSUNocV93/eCxRLyESxMPFu2DH2MAQeHDHA=
X-Google-Smtp-Source: APXvYqxhwQT6WMql3nWuEvqkiyAKTxj9AphvcSlTz3/1dSWwWej3dTbHucjo93ciF93pwdp84viqyVZcEdYpuu82Ars=
X-Received: by 2002:aca:4c08:: with SMTP id z8mr20237073oia.30.1554804082815; 
 Tue, 09 Apr 2019 03:01:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190405091647.4169-1-huntbag@linux.vnet.ibm.com>
 <20190405091647.4169-2-huntbag@linux.vnet.ibm.com>
In-Reply-To: <20190405091647.4169-2-huntbag@linux.vnet.ibm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 9 Apr 2019 12:01:11 +0200
Message-ID: <CAJZ5v0h+jyPQ=NofwV4ha6zBqk7E1gF1xE9CoBfKYfb3jBTbig@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] cpuidle : auto-promotion for cpuidle states
To: Abhishek Goel <huntbag@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Apr 5, 2019 at 11:17 AM Abhishek Goel
<huntbag@linux.vnet.ibm.com> wrote:
>
> Currently, the cpuidle governors (menu /ladder) determine what idle state

There are three governors in 5.1-rc.

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
> To address this, such lite states need to be autopromoted.

I don't quite agree with this statement and it doesn't even match what
the patch does AFAICS.  "Autopromotion" would be going from the given
state to a deeper one without running state selection in between, but
that's not what's going on here.

> The cpuidle-core can queue timer to correspond with the residency value of the next
> available state. Thus leading to auto-promotion to a deeper idle state as
> soon as possible.

No, it doesn't automatically cause a deeper state to be used next
time.  It simply kicks the CPU out of the idle state and one more
iteration of the idle loop runs on it.  Whether or not a deeper state
will be selected in that iteration depends on the governor
computations carried out in it.

Now, this appears to be almost analogous to the "polling" state used
on x86 which uses the next idle state's target residency as a timeout.

While generally I'm not a big fan of setting up timers in the idle
loop (it sort of feels like pulling your own hair in order to get
yourself out of a swamp), if idle states like these are there in your
platform, setting up a timer to get out of them in the driver's
->enter() routine might not be particularly objectionable.  Doing that
in the core is a whole different story, though.

Generally, this adds quite a bit of complexity (on the "ugly" side of
things IMO) to the core to cover a corner case present in one
platform, while IMO it can be covered in the driver for that platform
directly.

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
> +       struct hrtimer  hrtimer;
> +       unsigned long   timeout_us;
> +};
> +
>  int cpuidle_disabled(void)
>  {
>         return off;
> @@ -188,6 +193,54 @@ int cpuidle_enter_s2idle(struct cpuidle_driver *drv, struct cpuidle_device *dev)
>  }
>  #endif /* CONFIG_SUSPEND */
>
> +enum hrtimer_restart auto_promotion_hrtimer_callback(struct hrtimer *hrtimer)
> +{
> +       return HRTIMER_NORESTART;
> +}
> +
> +#ifdef CONFIG_CPU_IDLE_AUTO_PROMOTION
> +DEFINE_PER_CPU(struct auto_promotion, ap);
> +
> +static void cpuidle_auto_promotion_start(int cpu, struct cpuidle_state *state)
> +{
> +       struct auto_promotion *this_ap = &per_cpu(ap, cpu);
> +
> +       if (state->flags & CPUIDLE_FLAG_AUTO_PROMOTION)
> +               hrtimer_start(&this_ap->hrtimer, ns_to_ktime(this_ap->timeout_us
> +                                       * 1000), HRTIMER_MODE_REL_PINNED);
> +}
> +
> +static void cpuidle_auto_promotion_cancel(int cpu)
> +{
> +       struct hrtimer *hrtimer;
> +
> +       hrtimer = &per_cpu(ap, cpu).hrtimer;
> +       if (hrtimer_is_queued(hrtimer))
> +               hrtimer_cancel(hrtimer);
> +}
> +
> +static void cpuidle_auto_promotion_update(int cpu, unsigned long timeout)
> +{
> +       per_cpu(ap, cpu).timeout_us = timeout;
> +}
> +
> +static void cpuidle_auto_promotion_init(int cpu, struct cpuidle_driver *drv)
> +{
> +       struct auto_promotion *this_ap = &per_cpu(ap, cpu);
> +
> +       hrtimer_init(&this_ap->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +       this_ap->hrtimer.function = auto_promotion_hrtimer_callback;
> +}
> +#else
> +static inline void cpuidle_auto_promotion_start(int cpu, struct cpuidle_state
> +                                               *state) { }
> +static inline void cpuidle_auto_promotion_cancel(int cpu) { }
> +static inline void cpuidle_auto_promotion_update(int cpu, unsigned long
> +                                               timeout) { }
> +static inline void cpuidle_auto_promotion_init(int cpu, struct cpuidle_driver
> +                                               *drv) { }
> +#endif
> +
>  /**
>   * cpuidle_enter_state - enter the state and update stats
>   * @dev: cpuidle device for this cpu
> @@ -225,12 +278,17 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
>         trace_cpu_idle_rcuidle(index, dev->cpu);
>         time_start = ns_to_ktime(local_clock());
>
> +       cpuidle_auto_promotion_start(dev->cpu, target_state);

First off, I wouldn't call it "auto-promotion", because it just adds a
timeout to trigger if the CPU spends too much time in the target
state.

Second, and more important, I don't see why this cannot be done in
target_state->enter() just for the state in which it is needed (in
analogy with the "polling" state).

> +
>         stop_critical_timings();
>         entered_state = target_state->enter(dev, drv, index);
>         start_critical_timings();
>
>         sched_clock_idle_wakeup_event();
>         time_end = ns_to_ktime(local_clock());
> +
> +       cpuidle_auto_promotion_cancel(dev->cpu);
> +
>         trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, dev->cpu);
>
>         /* The cpu is no longer idle or about to enter idle. */
> @@ -312,7 +370,13 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
>  int cpuidle_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>                    bool *stop_tick)
>  {
> -       return cpuidle_curr_governor->select(drv, dev, stop_tick);
> +       unsigned long timeout_us, ret;
> +
> +       timeout_us = UINT_MAX;
> +       ret = cpuidle_curr_governor->select(drv, dev, stop_tick, &timeout_us);
> +       cpuidle_auto_promotion_update(dev->cpu, timeout_us);
> +
> +       return ret;
>  }
>
>  /**
> @@ -658,6 +722,8 @@ int cpuidle_register(struct cpuidle_driver *drv,
>                 device = &per_cpu(cpuidle_dev, cpu);
>                 device->cpu = cpu;
>
> +               cpuidle_auto_promotion_init(cpu, drv);
> +
>  #ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
>                 /*
>                  * On multiplatform for ARM, the coupled idle states could be
> diff --git a/drivers/cpuidle/governors/ladder.c b/drivers/cpuidle/governors/ladder.c
> index f0dddc66a..65b518dd7 100644
> --- a/drivers/cpuidle/governors/ladder.c
> +++ b/drivers/cpuidle/governors/ladder.c
> @@ -64,7 +64,8 @@ static inline void ladder_do_selection(struct ladder_device *ldev,
>   * @dummy: not used
>   */
>  static int ladder_select_state(struct cpuidle_driver *drv,
> -                              struct cpuidle_device *dev, bool *dummy)
> +                              struct cpuidle_device *dev, bool *dummy,
> +                              unsigned long *unused)
>  {
>         struct ladder_device *ldev = this_cpu_ptr(&ladder_devices);
>         struct ladder_device_state *last_state;
> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
> index 5951604e7..835e337de 100644
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -276,7 +276,7 @@ static unsigned int get_typical_interval(struct menu_device *data,
>   * @stop_tick: indication on whether or not to stop the tick
>   */
>  static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
> -                      bool *stop_tick)
> +                      bool *stop_tick, unsigned long *timeout)
>  {
>         struct menu_device *data = this_cpu_ptr(&menu_devices);
>         int latency_req = cpuidle_governor_latency_req(dev->cpu);
> @@ -442,6 +442,26 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>                 }
>         }
>
> +#ifdef CPUIDLE_FLAG_AUTO_PROMOTION
> +       if (drv->states[idx].flags & CPUIDLE_FLAG_AUTO_PROMOTION) {
> +               /*
> +                * Timeout is intended to be defined as sum of target residency
> +                * of next available state, entry latency and exit latency. If
> +                * time interval equal to timeout is spent in current state,
> +                * and if it is a shallow lite state, we may want to auto-
> +                * promote from such state.
> +                */
> +               for (i = idx + 1; i < drv->state_count; i++) {
> +                       if (drv->states[i].disabled ||
> +                                       dev->states_usage[i].disable)
> +                               continue;
> +                       *timeout = drv->states[i].target_residency +
> +                                       2 * drv->states[i].exit_latency;
> +                       break;
> +               }
> +       }
> +#endif

Why do you need to do the above in the governor at all?

The driver's ->enter() callback knows what state has been selected, it
can check what the next available state is and set up the timer
accordingly.

I don't see the need to pass the timeout from the governor to the core
anyway when the next thing the governor does is to return the selected
state index.

> +
>         return idx;
>  }
>
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index 3b3947232..84d76d1ec 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -72,6 +72,13 @@ struct cpuidle_state {
>  #define CPUIDLE_FLAG_POLLING   BIT(0) /* polling state */
>  #define CPUIDLE_FLAG_COUPLED   BIT(1) /* state applies to multiple cpus */
>  #define CPUIDLE_FLAG_TIMER_STOP BIT(2) /* timer is stopped on this state */
> +/*
> + * State with only and only fast state bit set don't even lose user context.
> + * But such states prevent other sibling threads from thread folding benefits.
> + * And hence we don't want to stay for too long in such states and want to
> + * auto-promote from it.
> + */
> +#define CPUIDLE_FLAG_AUTO_PROMOTION    BIT(3)
>
>  struct cpuidle_device_kobj;
>  struct cpuidle_state_kobj;
> @@ -243,7 +250,8 @@ struct cpuidle_governor {
>
>         int  (*select)          (struct cpuidle_driver *drv,
>                                         struct cpuidle_device *dev,
> -                                       bool *stop_tick);
> +                                       bool *stop_tick, unsigned long
> +                                       *timeout);
>         void (*reflect)         (struct cpuidle_device *dev, int index);
>  };
>
> --
> 2.17.1
>
