Return-Path: <akshay.adiga@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHTbv4SBTzDvhR
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 23:00:11 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAEC00R5092476
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 07:00:09 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26q9cwab46-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 07:00:06 -0500
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <akshay.adiga@linux.vnet.ibm.com>;
 Mon, 14 Nov 2016 21:59:46 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id F1FE73578053
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 22:59:43 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAEBxhuU4391218
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 22:59:43 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAEBxhhS013506
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 22:59:43 +1100
From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: ego@linux.vnet.ibm.com, Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: [PATCH -next] powernv: cpufreq: Fix uninitialized lpstate_idx in
 gpstates_timer_handler
Date: Mon, 14 Nov 2016 17:29:27 +0530
Message-Id: <1479124767-20165-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

lpstate_idx remains uninitialized in the case when elapsed_time
is greater than MAX_RAMP_DOWN_TIME. At the end of rampdown
global pstate should be equal to local pstate.

Fixes: 20b15b766354 ("cpufreq: powernv: Use PMCR to verify global and
localpstate")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
---
 drivers/cpufreq/powernv-cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index c82304b..c5c5bc3 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -624,6 +624,7 @@ void gpstate_timer_handler(unsigned long data)
 
 	if (gpstates->elapsed_time > MAX_RAMP_DOWN_TIME) {
 		gpstate_idx = pstate_to_idx(freq_data.pstate_id);
+		lpstate_idx = gpstate_idx;
 		reset_gpstates(policy);
 		gpstates->highest_lpstate_idx = gpstate_idx;
 	} else {
-- 
2.5.5
