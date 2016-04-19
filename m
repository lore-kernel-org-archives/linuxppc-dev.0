Return-Path: <akshay.adiga@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qq0np2PyQzDqBH
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 19:58:22 +1000 (AEST)
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <akshay.adiga@linux.vnet.ibm.com>;
 Tue, 19 Apr 2016 15:28:20 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3J9wCYe19530004
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 15:28:13 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3J9w6ER020864
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 15:28:08 +0530
From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: ego@linux.vnet.ibm.com, Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: [PATCH v3 0/2] cpufreq: powernv: Ramp-down global pstate slower than
 local-pstate
Date: Tue, 19 Apr 2016 15:27:59 +0530
Message-Id: <1461059881-14434-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The frequency transition latency from pmin to pmax is observed to be in few
millisecond granurality. And it usually happens to take a performance penalty
during sudden frequency rampup requests.

This patch set solves this problem by using a chip-level entity called "global
pstates". Global pstate manages elements across other dependent core chiplets.
Typically, the element that needs to be managed is the voltage setting.
So by holding global pstates higher than local pstate for some amount of time
( ~5 seconds) the subsequent rampups could be made faster.

(1/2) patch removes the flag from cpufreq_policy->driver_data, so that it can
be used for tracking global pstates.

(2/2) patch adds code for global pstate management.
- The iozone results with this patchset, shows improvements in almost all cases.
- YCSB workload on redis with various  target operations per second shows 
better MaxLatency with this patch.

Changes from v1:
- Fixed coding style
- Added a routine to reset global_pstate_info instead of hacky memset
- Handled case where cpufreq_table_validate_and_show() fails
- changed int queue_gpstate_timer() to void queue_gpstate_timer()

Changes from v2:
- dropped the unreated change. 

Akshay Adiga (1):
  cpufreq: powernv: Ramp-down global pstate slower than local-pstate

Shilpasri G Bhat (1):
  cpufreq: powernv: Remove flag use-case of policy->driver_data

 drivers/cpufreq/powernv-cpufreq.c | 269 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 256 insertions(+), 13 deletions(-)

-- 
2.5.5
