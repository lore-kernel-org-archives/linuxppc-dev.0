Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r8vKB3Gd7zDqCJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 May 2016 22:54:06 +1000 (AEST)
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3r8vK94NVQz9t6M
 for <linuxppc-dev@ozlabs.org>; Wed, 18 May 2016 22:54:05 +1000 (AEST)
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Wed, 18 May 2016 18:24:02 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id E6191E0040
 for <linuxppc-dev@ozlabs.org>; Wed, 18 May 2016 18:27:06 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4ICrp3I12779924
 for <linuxppc-dev@ozlabs.org>; Wed, 18 May 2016 18:23:51 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4ICrrOn011326
 for <linuxppc-dev@ozlabs.org>; Wed, 18 May 2016 18:23:54 +0530
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: rjw@rjwysocki.net
Cc: viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, ego@linux.vnet.ibm.com,
 shreyas@linux.vnet.ibm.com, akshay.adiga@linux.vnet.ibm.com,
 linuxppc-dev@ozlabs.org, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [RFC PATCH] Increase in idle power with schedutil
Date: Wed, 18 May 2016 18:23:39 +0530
Message-Id: <1463576020-18597-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds driver callback for fast_switch and below observations
on schedutil governor are done with this patch.

In POWER8 there is a regression observed with schedutil compared to
ondemand. With schedutil the frequency is not ramping down and is
mostly stuck at max frequency during idle . This is because of the
watchdog timer, an RT task which is fired every 4 seconds which
results in requesting max frequency.

In a completely idle system, when there are no processes running apart
from few short running housekeeping tasks (like watchdog) the system is
stuck at max frequency due to 'cpufreq_trigger_update()'

static inline void cpufreq_trigger_update(u64 time)
{
        cpufreq_update_util(time, ULONG_MAX, 0);
}

If there is no noise apart from the watchdog timer the cpu is held at
max frequency for no good reason. On a 16 core system I can see an
increase in 20% idle power with schedutil compared to ondemand
governor.

Below is the trace with 'sched:sched_switch' and 'power:cpu_frequency'
events. Here the watchdog timer that runs for a very small period is
requesting Pmax and this gets triggered regularly.

<idle>-0  19059.992912: sched_switch: prev_comm=swapper/16  prev_state=R
				==> next_comm=watchdog/16 
watchdog/16-107 19059.992914: cpu_frequency: state=4322000 cpu_id=16
watchdog/16-107 19059.992915: sched_switch: prev_comm=watchdog/16 prev_state=S
	 			==> next_comm=swapper/16 

However adding a cpufreq hook in pick_next_task_idle() to decrease the
frequency helped to reduce the problem.

static inline void cpufreq_trigger_idle(u64 time)
{
       cpufreq_update_util(time, 0, 1);
}

This might not be the right fix for the problem, however this thread
is reporting the other short-comings of cpufreq_trigger_update().

Shilpasri G Bhat (1):
  cpufreq: powernv: Add fast_switch callback

 drivers/cpufreq/powernv-cpufreq.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

-- 
1.9.3
