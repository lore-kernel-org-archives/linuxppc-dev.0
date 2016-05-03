Return-Path: <akshay.adiga@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzlX96xBpzDq6B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 May 2016 01:31:53 +1000 (AEST)
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <akshay.adiga@linux.vnet.ibm.com>;
 Tue, 3 May 2016 21:00:49 +0530
Received: from d28relay06.in.ibm.com (d28relay06.in.ibm.com [9.184.220.150])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 807B51258175
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 20:52:08 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay06.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u43FK5LV53149704
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 20:50:05 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u43FK3Rf020253
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 20:50:04 +0530
From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: [PATCH-next v2 0/2] cpufreq: powernv: Fixes for Global pstate
 management
Date: Tue,  3 May 2016 20:49:34 +0530
Message-Id: <1462288776-26721-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fixes are based on patch https://patchwork.ozlabs.org/patch/612058/ which
is in Rafael's linux-next.

- Patch [1] fixes WARN_ON in powernv_target_index()
- Patch [2] Deleting any pending timer to saves an unnecessary irq call
 in powernv_target_index()

Akshay Adiga (2):
  cpufreq: powernv: Move smp_call_function_any() out of irq safe block
  cpufreq: powernv: del_timer_sync when global and local pstate are
    equal

 drivers/cpufreq/powernv-cpufreq.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

-- 
2.5.5
