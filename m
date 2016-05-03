Return-Path: <akshay.adiga@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [125.16.236.8])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzblL544qzDqBv
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 19:41:02 +1000 (AEST)
Received: from localhost
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <akshay.adiga@linux.vnet.ibm.com>;
 Tue, 3 May 2016 15:10:57 +0530
Received: from d28relay10.in.ibm.com (d28relay10.in.ibm.com [9.184.220.161])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 310343940060
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 15:10:56 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay10.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u439euuZ18874418
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 15:10:56 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u439esCf028903
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 15:10:55 +0530
From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: [PATCH -next 2/2] cpufreq: powernv: del_timer_sync when global and
 local pstate are equal
Date: Tue,  3 May 2016 15:10:48 +0530
Message-Id: <1462268448-19954-3-git-send-email-akshay.adiga@linux.vnet.ibm.com>
In-Reply-To: <1462268448-19954-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
References: <1462268448-19954-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Deleting pending gpstates->timer for the policy when global and local pstate
are equal while executing target_index(). This saves an unnecessary
irq call.

Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
---
Patch is based on Rafael's linux-next
 drivers/cpufreq/powernv-cpufreq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 1f0e20c..54c4536 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -647,6 +647,8 @@ static int powernv_cpufreq_target_index(struct cpufreq_policy *policy,
 	 */
 	if (gpstate_id != freq_data.pstate_id)
 		queue_gpstate_timer(gpstates);
+	else
+		del_timer_sync(&gpstates->timer);
 
 gpstates_done:
 	freq_data.gpstate_id = gpstate_id;
-- 
2.5.5
