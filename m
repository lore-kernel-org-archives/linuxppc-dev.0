Return-Path: <viresh.kumar@linaro.org>
Received: from mail-pg0-x230.google.com (mail-pg0-x230.google.com
 [IPv6:2607:f8b0:400e:c05::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xCCXV1TYKzDrT4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 20:13:14 +1000 (AEST)
Received: by mail-pg0-x230.google.com with SMTP id k14so28720079pgr.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 03:13:14 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
 Vincent Guittot <vincent.guittot@linaro.org>, linux@dominikbrodowski.net,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Ingo Molnar <mingo@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Len Brown <lenb@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH V3 0/9] cpufreq: transition-latency cleanups
Date: Wed, 19 Jul 2017 15:42:40 +0530
Message-Id: <cover.1500373914.git.viresh.kumar@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Rafael,

This series tries to cleanup the code around transition-latency and its
users. Some of the old legacy code, which may not make much sense now,
is dropped as well. And some code consolidation is also done across
governors.

Based of: v4.13-rc1
Tested on: ARM64 Hikey board.

I have pushed it here as well (which gets tested by kbuild test bot):

git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/transition-latency

V2->V3:
- Rearranged patches to keep related stuff together
- Introduce CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING flag (Rafael)
- Minor optimization in cpufreq_policy_transition_delay_us() and moved
  it to cpufreq.c (Rafael)
- Allow dynamic switching for drivers which don't know their transition
  latency.

V1->V2:
- While we still get rid of the limitation of 10ms for using
  ondemand/conservative, but we preserve the earlier behavior where the
  transition latency set to CPUFREQ_ETERNAL would not allow use of
  ondemand/conservative governors. Thanks to Dominik for his feedback on
  that.

--
viresh

Viresh Kumar (9):
  cpufreq: governor: Drop min_sampling_rate
  cpufreq: Use transition_delay_us for legacy governors as well
  cpufreq: Cap the default transition delay value to 10 ms
  cpufreq: Don't set transition_latency for setpolicy drivers
  cpufreq: arm_big_little: Make ->get_transition_latency() mandatory
  cpufreq: Replace "max_transition_latency" with "dynamic_switching"
  cpufreq: schedutil: Set dynamic_switching to true
  cpufreq: Add CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING cpufreq driver flag
  cpufreq: Allow dynamic switching with CPUFREQ_ETERNAL latency

 Documentation/admin-guide/pm/cpufreq.rst |  8 --------
 drivers/cpufreq/arm_big_little.c         | 10 ++++------
 drivers/cpufreq/cpufreq-nforce2.c        |  2 +-
 drivers/cpufreq/cpufreq.c                | 34 ++++++++++++++++++++++++++++----
 drivers/cpufreq/cpufreq_conservative.c   |  6 ------
 drivers/cpufreq/cpufreq_governor.c       | 17 ++--------------
 drivers/cpufreq/cpufreq_governor.h       |  3 +--
 drivers/cpufreq/cpufreq_ondemand.c       | 12 -----------
 drivers/cpufreq/elanfreq.c               |  4 +---
 drivers/cpufreq/gx-suspmod.c             |  2 +-
 drivers/cpufreq/intel_pstate.c           |  1 -
 drivers/cpufreq/longrun.c                |  1 -
 drivers/cpufreq/pmac32-cpufreq.c         |  7 +++++--
 drivers/cpufreq/sa1100-cpufreq.c         |  5 +++--
 drivers/cpufreq/sa1110-cpufreq.c         |  5 +++--
 drivers/cpufreq/sh-cpufreq.c             |  3 +--
 drivers/cpufreq/speedstep-smi.c          |  2 +-
 drivers/cpufreq/unicore2-cpufreq.c       |  3 +--
 include/linux/cpufreq.h                  | 18 ++++++++---------
 kernel/sched/cpufreq_schedutil.c         | 12 ++---------
 20 files changed, 65 insertions(+), 90 deletions(-)

-- 
2.13.0.71.gd7076ec9c9cb
