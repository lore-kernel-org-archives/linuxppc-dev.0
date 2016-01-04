Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 03B361A0045
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jan 2016 20:25:45 +1100 (AEDT)
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4230B1402E2
 for <linuxppc-dev@ozlabs.org>; Mon,  4 Jan 2016 20:25:44 +1100 (AEDT)
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Mon, 4 Jan 2016 14:55:40 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 98B901258066
 for <linuxppc-dev@ozlabs.org>; Mon,  4 Jan 2016 14:56:17 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u049PZP11114386
 for <linuxppc-dev@ozlabs.org>; Mon, 4 Jan 2016 14:55:35 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u049PYAg007236
 for <linuxppc-dev@ozlabs.org>; Mon, 4 Jan 2016 14:55:34 +0530
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
 pc@us.ibm.com, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v3 0/2] cpufreq: powernv: Redesign the presentation of
 throttle notification
Date: Mon,  4 Jan 2016 14:55:25 +0530
Message-Id: <1451899527-14359-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
In-Reply-To: <1451686914-3761-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1451686914-3761-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
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
message. Some boxes may not sustain the max turbo frequency in all
conditions and can be throttled frequently. This can lead to the
flooding of console with throttle messages. So this patchset aims to
redesign the presentation of this event via sysfs counters and
tracepoints. 

This patchset will add a perf trace point "power:powernv_throttle" and
sysfs throttle counter stats in /sys/devices/system/cpu/cpufreq/chipN.

Changes from v2:
- Fixed kbuild test warning.
drivers/cpufreq/powernv-cpufreq.c:609:2: warning: ignoring return
value of 'kstrtoint', declared with attribute warn_unused_result
[-Wunused-result]

Shilpasri G Bhat (2):
  cpufreq: powernv/tracing: Add powernv_throttle tracepoint
  cpufreq: powernv: Redesign the presentation of throttle notification

 drivers/cpufreq/powernv-cpufreq.c | 256 +++++++++++++++++++++++++++++++-------
 include/trace/events/power.h      |  22 ++++
 kernel/trace/power-traces.c       |   1 +
 3 files changed, 236 insertions(+), 43 deletions(-)

-- 
1.9.3
