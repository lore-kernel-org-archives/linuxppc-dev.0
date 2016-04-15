Return-Path: <akshay.adiga@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qmSNt4M6FzDq62
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Apr 2016 16:31:26 +1000 (AEST)
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <akshay.adiga@linux.vnet.ibm.com>;
 Fri, 15 Apr 2016 16:31:24 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 04DD22BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Apr 2016 16:31:22 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3F6VDK99961948
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Apr 2016 16:31:21 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3F6Umi9010533
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Apr 2016 16:30:49 +1000
From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: ego@linux.vnet.ibm.com, Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: [PATCH v2 0/2] cpufreq: powernv: Ramp-down global pstate slower than
 local-pstate
Date: Fri, 15 Apr 2016 11:58:57 +0530
Message-Id: <1460701739-31549-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
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
- Handled case when cpufreq_table_validate_and_show() fails
- changed int queue_gpstate_timer() to void queue_gpstate_timer()


Akshay Adiga (1):
  cpufreq: powernv: Ramp-down global pstate slower than local-pstate

Shilpasri G Bhat (1):
  cpufreq: powernv: Remove flag use-case of policy->driver_data

 drivers/cpufreq/powernv-cpufreq.c | 272 +++++++++++++++++++++++++++++++++++---
 1 file changed, 257 insertions(+), 15 deletions(-)

-- 
2.5.5
