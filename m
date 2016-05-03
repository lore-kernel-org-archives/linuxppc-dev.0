Return-Path: <akshay.adiga@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzbys5S0mzDq6B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 19:51:01 +1000 (AEST)
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <akshay.adiga@linux.vnet.ibm.com>;
 Tue, 3 May 2016 15:10:58 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 8A189394004E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 15:10:55 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u439f0Ag23462296
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 15:11:00 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u439erX3028853
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 15:10:53 +0530
From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: [PATCH -next 0/2] cpufreq: powernv: Fixes for Global pstate management
Date: Tue,  3 May 2016 15:10:46 +0530
Message-Id: <1462268448-19954-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fixes are based on patch https://patchwork.ozlabs.org/patch/612058/ which is
in Rafael's linux-next.

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
