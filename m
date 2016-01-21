Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6E1DA1A001D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2016 20:39:59 +1100 (AEDT)
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4252C1402EC
 for <linuxppc-dev@ozlabs.org>; Thu, 21 Jan 2016 20:39:59 +1100 (AEDT)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Thu, 21 Jan 2016 19:39:57 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 8B70C3578053
 for <linuxppc-dev@ozlabs.org>; Thu, 21 Jan 2016 20:39:54 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0L9dmek42139842
 for <linuxppc-dev@ozlabs.org>; Thu, 21 Jan 2016 20:39:56 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0L9dLxd017722
 for <linuxppc-dev@ozlabs.org>; Thu, 21 Jan 2016 20:39:22 +1100
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
 pc@us.ibm.com, anton@samba.org, ego@linux.vnet.ibm.com,
 shreyas@linux.vnet.ibm.com,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v5 0/5] cpufreq: powernv: Redesign the presentation of
 throttle notification and solve bug-fixes in the driver
Date: Thu, 21 Jan 2016 15:08:54 +0530
Message-Id: <1453369139-10203-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In POWER8, OCC(On-Chip-Controller) can throttle the frequency of the
CPU when the chip crosses its thermal and power limits. Currently,
powernv-cpufreq driver detects and reports this event as a console
message. Some machines may not sustain the max turbo frequency in all
conditions and can be throttled frequently. This can lead to the
flooding of console with throttle messages. So this patchset aims to
redesign the presentation of this event via sysfs counters and
tracepoints. And it also fixes couple of bugs reported in the driver.

- Patch [1] fixes the cpu hot-plug bug in powernv_cpufreq_work_fn().
- Patch [2] solves a bug in powernv_cpufreq_throttle_check(), which
  calls in to cpu_to_chip_id() in hot path which reads DT every time
  to find the chip id.
- Patches [3] to [5] will add a perf trace point
  "power:powernv_throttle" and sysfs throttle counter stats in
  /sys/devices/system/cpu/cpufreq/chipN.

Changes from v4:
- Fix a hot-plug bug in powernv_cpufreq_work_fn()
- Changes wrt Gautham's and Shreyas's comments 

Changes from v3:
- Add a fix to replace cpu_to_chip_id() with simpler PIR shift to 
  obtain the chip id.
- Break patch2 in to two patches separating the tracepoint and sysfs
  attribute changes.

Changes from v2:
- Fixed kbuild test warning.
drivers/cpufreq/powernv-cpufreq.c:609:2: warning: ignoring return
value of 'kstrtoint', declared with attribute warn_unused_result
[-Wunused-result]

Shilpasri G Bhat (5):
  cpufreq: powernv: Hot-plug safe the kworker thread
  cpufreq: powernv: Remove cpu_to_chip_id() from hot-path
  cpufreq: powernv/tracing: Add powernv_throttle tracepoint
  cpufreq: powernv: Replace pr_info with trace print for throttle event
  cpufreq: powernv: Add sysfs attributes to show throttle stats

 drivers/cpufreq/powernv-cpufreq.c | 312 +++++++++++++++++++++++++++++++-------
 include/trace/events/power.h      |  22 +++
 kernel/trace/power-traces.c       |   1 +
 3 files changed, 280 insertions(+), 55 deletions(-)

-- 
1.9.3
