Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C7FF51A17C8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 21:26:42 +1100 (AEDT)
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D96B0140297
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Jan 2016 21:26:41 +1100 (AEDT)
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Tue, 12 Jan 2016 15:56:39 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 259CB3940064
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Jan 2016 15:56:36 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0CAQRSg61472964
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Jan 2016 15:56:28 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0CAQQSL021571
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Jan 2016 15:56:27 +0530
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
 pc@us.ibm.com, anton@samba.org, ego@linux.vnet.ibm.com,
 shreyas@linux.vnet.ibm.com,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH RESEND v4 1/4] cpufreq: powernv: Remove cpu_to_chip_id() from
 hot-path
Date: Tue, 12 Jan 2016 04:24:24 -0600
Message-Id: <1452594267-12844-2-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
In-Reply-To: <1452594267-12844-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1452594267-12844-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

cpu_to_chip_id() does a DT walk through to find out the chip id by taking a
contended device tree lock. This adds an unnecessary overhead in a hot-path.
So instead of cpu_to_chip_id() use PIR of the cpu to find the chip id.

Reported-by: Anton Blanchard <anton@samba.org>
Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
 drivers/cpufreq/powernv-cpufreq.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index cb50138..597a084 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -39,6 +39,7 @@
 #define PMSR_PSAFE_ENABLE	(1UL << 30)
 #define PMSR_SPR_EM_DISABLE	(1UL << 31)
 #define PMSR_MAX(x)		((x >> 32) & 0xFF)
+#define pir_to_chip_id(pir)	(((pir) >> 7) & 0x3f)
 
 static struct cpufreq_frequency_table powernv_freqs[POWERNV_MAX_PSTATES+1];
 static bool rebooting, throttled, occ_reset;
@@ -312,13 +313,14 @@ static inline unsigned int get_nominal_index(void)
 static void powernv_cpufreq_throttle_check(void *data)
 {
 	unsigned int cpu = smp_processor_id();
+	unsigned int chip_id = pir_to_chip_id(hard_smp_processor_id());
 	unsigned long pmsr;
 	int pmsr_pmax, i;
 
 	pmsr = get_pmspr(SPRN_PMSR);
 
 	for (i = 0; i < nr_chips; i++)
-		if (chips[i].id == cpu_to_chip_id(cpu))
+		if (chips[i].id == chip_id)
 			break;
 
 	/* Check for Pmax Capping */
@@ -558,7 +560,8 @@ static int init_chip_info(void)
 	unsigned int prev_chip_id = UINT_MAX;
 
 	for_each_possible_cpu(cpu) {
-		unsigned int id = cpu_to_chip_id(cpu);
+		unsigned int id =
+			pir_to_chip_id(get_hard_smp_processor_id(cpu));
 
 		if (prev_chip_id != id) {
 			prev_chip_id = id;
-- 
1.9.1
