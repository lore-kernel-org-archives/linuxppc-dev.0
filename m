Return-Path: <SRS0=+Gyc=SY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CB2C282E1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 06:37:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3609C2075A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 06:37:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3609C2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44ncMC1yhZzDqT3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 16:37:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=huntbag@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44ncHx53KkzDqMd
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 16:34:37 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3M6Xk3L031649
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 02:34:34 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2s12391v6q-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 02:34:33 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <huntbag@linux.vnet.ibm.com>;
 Mon, 22 Apr 2019 07:34:31 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 22 Apr 2019 07:34:28 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3M6YR3c55312534
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Apr 2019 06:34:27 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C512152057;
 Mon, 22 Apr 2019 06:34:27 +0000 (GMT)
Received: from boston16h.aus.stglabs.ibm.com (unknown [9.3.23.78])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6864352051;
 Mon, 22 Apr 2019 06:34:26 +0000 (GMT)
From: Abhishek Goel <huntbag@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-pm@vger.kernel.org
Subject: [PATCH 1/1] cpuidle-powernv : forced wakeup for stop lite states
Date: Mon, 22 Apr 2019 01:32:31 -0500
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190422063231.51043-1-huntbag@linux.vnet.ibm.com>
References: <20190422063231.51043-1-huntbag@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19042206-0008-0000-0000-000002DC3A44
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042206-0009-0000-0000-0000224884CF
Message-Id: <20190422063231.51043-2-huntbag@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-21_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904220049
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: ego@linux.vnet.ibm.com, daniel.lezcano@linaro.org, rjw@rjwysocki.net,
 Abhishek Goel <huntbag@linux.vnet.ibm.com>, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Currently, the cpuidle governors determine what idle state a idling CPU
should enter into based on heuristics that depend on the idle history on
that CPU. Given that no predictive heuristic is perfect, there are cases
where the governor predicts a shallow idle state, hoping that the CPU will
be busy soon. However, if no new workload is scheduled on that CPU in the
near future, the CPU will end up in the shallow state.

In case of POWER, this is problematic, when the predicted state in the
aforementioned scenario is a lite stop state, as such lite states will
inhibit SMT folding, thereby depriving the other threads in the core from
using the core resources.

So we do not want to get stucked in such states for longer duration. To
address this, the cpuidle-core can queue timer to correspond with the
residency value of the next available state. This timer will forcefully
wakeup the cpu. Few such iterations will essentially train the governor to
select a deeper state for that cpu, as the timer here corresponds to the
next available cpuidle state residency. Cpu will be kicked out of the lite
state and end up in a non-lite state.

Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal-api.h |  1 +
 drivers/cpuidle/cpuidle-powernv.c   | 71 ++++++++++++++++++++++++++++-
 2 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 870fb7b23..735dec731 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -226,6 +226,7 @@
  */
 
 #define OPAL_PM_TIMEBASE_STOP		0x00000002
+#define OPAL_PM_LOSE_USER_CONTEXT	0x00001000
 #define OPAL_PM_LOSE_HYP_CONTEXT	0x00002000
 #define OPAL_PM_LOSE_FULL_CONTEXT	0x00004000
 #define OPAL_PM_NAP_ENABLED		0x00010000
diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 84b1ebe21..30b877962 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -15,6 +15,7 @@
 #include <linux/clockchips.h>
 #include <linux/of.h>
 #include <linux/slab.h>
+#include <linux/hrtimer.h>
 
 #include <asm/machdep.h>
 #include <asm/firmware.h>
@@ -43,6 +44,40 @@ struct stop_psscr_table {
 
 static struct stop_psscr_table stop_psscr_table[CPUIDLE_STATE_MAX] __read_mostly;
 
+DEFINE_PER_CPU(struct hrtimer, forced_wakeup_timer);
+
+static int forced_wakeup_time_compute(struct cpuidle_device *dev,
+				      struct cpuidle_driver *drv,
+				      int index)
+{
+	int i, timeout_us = 0;
+
+	for (i = index + 1; i < drv->state_count; i++) {
+		if (drv->states[i].disabled || dev->states_usage[i].disable)
+			continue;
+		timeout_us = drv->states[i].target_residency +
+				2 * drv->states[i].exit_latency;
+		break;
+	}
+
+	return timeout_us;
+}
+
+enum hrtimer_restart forced_wakeup_hrtimer_callback(struct hrtimer *hrtimer)
+{
+	return HRTIMER_NORESTART;
+}
+
+static void forced_wakeup_timer_init(int cpu, struct cpuidle_driver *drv)
+{
+	struct hrtimer *cpu_forced_wakeup_timer = &per_cpu(forced_wakeup_timer,
+								cpu);
+
+	hrtimer_init(cpu_forced_wakeup_timer, CLOCK_MONOTONIC,
+			HRTIMER_MODE_REL);
+	cpu_forced_wakeup_timer->function = forced_wakeup_hrtimer_callback;
+}
+
 static u64 default_snooze_timeout __read_mostly;
 static bool snooze_timeout_en __read_mostly;
 
@@ -103,6 +138,28 @@ static int snooze_loop(struct cpuidle_device *dev,
 	return index;
 }
 
+static int stop_lite_loop(struct cpuidle_device *dev,
+			  struct cpuidle_driver *drv,
+			  int index)
+{
+	int timeout_us;
+	struct hrtimer *this_timer = &per_cpu(forced_wakeup_timer, dev->cpu);
+
+	timeout_us = forced_wakeup_time_compute(dev, drv, index);
+
+	if (timeout_us > 0)
+		hrtimer_start(this_timer, ns_to_ktime(timeout_us * 1000),
+						HRTIMER_MODE_REL_PINNED);
+
+	power9_idle_type(stop_psscr_table[index].val,
+			 stop_psscr_table[index].mask);
+
+	if (unlikely(hrtimer_is_queued(this_timer)))
+		hrtimer_cancel(this_timer);
+
+	return index;
+}
+
 static int nap_loop(struct cpuidle_device *dev,
 			struct cpuidle_driver *drv,
 			int index)
@@ -190,7 +247,7 @@ static int powernv_cpuidle_cpu_dead(unsigned int cpu)
  */
 static int powernv_cpuidle_driver_init(void)
 {
-	int idle_state;
+	int idle_state, cpu;
 	struct cpuidle_driver *drv = &powernv_idle_driver;
 
 	drv->state_count = 0;
@@ -224,6 +281,9 @@ static int powernv_cpuidle_driver_init(void)
 
 	drv->cpumask = (struct cpumask *)cpu_present_mask;
 
+	for_each_cpu(cpu, drv->cpumask)
+		forced_wakeup_timer_init(cpu, drv);
+
 	return 0;
 }
 
@@ -299,6 +359,7 @@ static int powernv_add_idle_states(void)
 	for (i = 0; i < dt_idle_states; i++) {
 		unsigned int exit_latency, target_residency;
 		bool stops_timebase = false;
+		bool lose_user_context = false;
 		struct pnv_idle_states_t *state = &pnv_idle_states[i];
 
 		/*
@@ -324,6 +385,9 @@ static int powernv_add_idle_states(void)
 		if (has_stop_states && !(state->valid))
 				continue;
 
+		if (state->flags & OPAL_PM_LOSE_USER_CONTEXT)
+			lose_user_context = true;
+
 		if (state->flags & OPAL_PM_TIMEBASE_STOP)
 			stops_timebase = true;
 
@@ -332,6 +396,11 @@ static int powernv_add_idle_states(void)
 			add_powernv_state(nr_idle_states, "Nap",
 					  CPUIDLE_FLAG_NONE, nap_loop,
 					  target_residency, exit_latency, 0, 0);
+		} else if (has_stop_states && !lose_user_context) {
+			add_powernv_state(nr_idle_states, state->name,
+					  CPUIDLE_FLAG_NONE, stop_lite_loop,
+					  target_residency, exit_latency,
+					  state->psscr_val, state->psscr_mask);
 		} else if (has_stop_states && !stops_timebase) {
 			add_powernv_state(nr_idle_states, state->name,
 					  CPUIDLE_FLAG_NONE, stop_loop,
-- 
2.17.1

