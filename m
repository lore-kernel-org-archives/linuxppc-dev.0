Return-Path: <victora@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xD1p10LzXzDrF9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 03:57:44 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6KHrw17128766
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 13:57:42 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bu05ju99h-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 13:57:41 -0400
Received: from localhost
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <victora@linux.vnet.ibm.com>;
 Thu, 20 Jul 2017 14:57:39 -0300
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay04.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6KHvbrC4325460
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 14:57:37 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6KHvbHP014335
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 14:57:37 -0300
From: Victor Aoqui <victora@linux.vnet.ibm.com>
To: rjw@rjwysocki.net, daniel.lezcano@linaro.org, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: ltc-interlock@lists.linux.ibm.com, victora@br.ibm.com,
 victora@linux.vnet.ibm.com, mauricfo@linux.vnet.ibm.com
Subject: [PATCH] drivers: cpuidle: Disable preemption before get_lppaca
 function call in pseries_idle_probe function
Date: Thu, 20 Jul 2017 14:57:35 -0300
Message-Id: <20170720175735.3957-1-victora@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When CONFIG_PREEMPT=y, the following warning shows up:

BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
caller is pseries_processor_idle_init+0x58/0x21c

This warning shows up because preemption cannot occur when using
get_paca(), otherwise the paca_struct it points to may be the wrong one
just after.

For this reason, preemption needs to be disabled before
lppaca_shared_proc(get_lppaca()).

Signed-off-by: Victor Aoqui <victora@linux.vnet.ibm.com>
---
 drivers/cpuidle/cpuidle-pseries.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
index e9b3853..d6dda8c 100644
--- a/drivers/cpuidle/cpuidle-pseries.c
+++ b/drivers/cpuidle/cpuidle-pseries.c
@@ -233,12 +233,16 @@ static int pseries_cpuidle_driver_init(void)
  */
 static int pseries_idle_probe(void)
 {
+	int retval;
 
 	if (cpuidle_disable != IDLE_NO_OVERRIDE)
 		return -ENODEV;
 
 	if (firmware_has_feature(FW_FEATURE_SPLPAR)) {
-		if (lppaca_shared_proc(get_lppaca())) {
+		preempt_disable();
+		retval = lppaca_shared_proc(get_lppaca());
+		preempt_enable();
+		if (retval) {
 			cpuidle_state_table = shared_states;
 			max_idle_state = ARRAY_SIZE(shared_states);
 		} else {
-- 
1.8.3.1
