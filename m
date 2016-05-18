Return-Path: <rjwysocki@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r96Mc1c3LzDq8b
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 07:11:56 +1000 (AEST)
Received: from mail-wm0-x243.google.com (mail-wm0-x243.google.com
 [IPv6:2a00:1450:400c:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3r96Mb3P1Gz9t6Z
 for <linuxppc-dev@ozlabs.org>; Thu, 19 May 2016 07:11:55 +1000 (AEST)
Received: by mail-wm0-x243.google.com with SMTP id r12so16062339wme.0
 for <linuxppc-dev@ozlabs.org>; Wed, 18 May 2016 14:11:55 -0700 (PDT)
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <1463576020-18597-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1463576020-18597-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Date: Wed, 18 May 2016 23:11:51 +0200
Message-ID: <CAJZ5v0jv+fD-ZKjLBepL9Fkn1JFROO3nGHX_3-=PuzGSAALB5g@mail.gmail.com>
Subject: Re: [RFC PATCH] Increase in idle power with schedutil
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 shreyas@linux.vnet.ibm.com, akshay.adiga@linux.vnet.ibm.com,
 linuxppc-dev@ozlabs.org, Steve Muckle <steve.muckle@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 18, 2016 at 2:53 PM, Shilpasri G Bhat
<shilpa.bhat@linux.vnet.ibm.com> wrote:
> This patch adds driver callback for fast_switch and below observations
> on schedutil governor are done with this patch.
>
> In POWER8 there is a regression observed with schedutil compared to
> ondemand. With schedutil the frequency is not ramping down and is
> mostly stuck at max frequency during idle . This is because of the
> watchdog timer, an RT task which is fired every 4 seconds which
> results in requesting max frequency.

Well, yes, that would be problematic.

I guess the Steve Muckle's cross-CPU utilization updates series might
help (you can find it in the linux-pm patchwork).

> In a completely idle system, when there are no processes running apart
> from few short running housekeeping tasks (like watchdog) the system is
> stuck at max frequency due to 'cpufreq_trigger_update()'
>
> static inline void cpufreq_trigger_update(u64 time)
> {
>         cpufreq_update_util(time, ULONG_MAX, 0);
> }
>
> If there is no noise apart from the watchdog timer the cpu is held at
> max frequency for no good reason. On a 16 core system I can see an
> increase in 20% idle power with schedutil compared to ondemand
> governor.
>
> Below is the trace with 'sched:sched_switch' and 'power:cpu_frequency'
> events. Here the watchdog timer that runs for a very small period is
> requesting Pmax and this gets triggered regularly.
>
> <idle>-0  19059.992912: sched_switch: prev_comm=swapper/16  prev_state=R
>                                 ==> next_comm=watchdog/16
> watchdog/16-107 19059.992914: cpu_frequency: state=4322000 cpu_id=16
> watchdog/16-107 19059.992915: sched_switch: prev_comm=watchdog/16 prev_state=S
>                                 ==> next_comm=swapper/16
>
> However adding a cpufreq hook in pick_next_task_idle() to decrease the
> frequency helped to reduce the problem.
>
> static inline void cpufreq_trigger_idle(u64 time)
> {
>        cpufreq_update_util(time, 0, 1);
> }
>
> This might not be the right fix for the problem, however this thread
> is reporting the other short-comings of cpufreq_trigger_update().
