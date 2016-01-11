Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B7B2F1A0D35
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 07:56:42 +1100 (AEDT)
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E8BD5140662
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Jan 2016 07:56:41 +1100 (AEDT)
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Tue, 12 Jan 2016 02:26:38 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id D912C3940066
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Jan 2016 02:26:35 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0BKuZK854526196
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Jan 2016 02:26:35 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0BKuY71024088
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Jan 2016 02:26:35 +0530
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
 pc@us.ibm.com, anton@samba.org, ego@linux.vnet.ibm.com,
 <stable@vger.kernel.org>, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v4 0/4] cpufreq: powernv: Redesign the presentation of
 throttle notification
Date: Mon, 11 Jan 2016 14:54:36 -0600
Message-Id: <1452545680-11976-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
In-Reply-To: <1451899527-14359-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1451899527-14359-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
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
tracepoints. 

Patches [2] to [4] will add a perf trace point "power:powernv_throttle" and
sysfs throttle counter stats in /sys/devices/system/cpu/cpufreq/chipN.
Patch [1] solves a bug in powernv_cpufreq_throttle_check(), which calls in to
cpu_to_chip_id() in hot path which reads DT every time to find the chip id.

Changes from v3:
- Add a fix to replace cpu_to_chip_id() with simpler PIR shift to obtain the
  chip id.
- Break patch2 in to two patches separating the tracepoint and sysfs attribute
  changes.

Changes from v2:
- Fixed kbuild test warning.
drivers/cpufreq/powernv-cpufreq.c:609:2: warning: ignoring return
value of 'kstrtoint', declared with attribute warn_unused_result
[-Wunused-result]

Shilpasri G Bhat (4):
  cpufreq: powernv: Remove cpu_to_chip_id() from hot-path
  cpufreq: powernv/tracing: Add powernv_throttle tracepoint
  cpufreq: powernv: Add a trace print for the throttle event
  cpufreq: powernv: Add sysfs attributes to show throttle stats

 drivers/cpufreq/powernv-cpufreq.c | 279 +++++++++++++++++++++++++++++++-------
 include/trace/events/power.h      |  22 +++
 kernel/trace/power-traces.c       |   1 +
 3 files changed, 250 insertions(+), 52 deletions(-)

-- 
1.9.1
