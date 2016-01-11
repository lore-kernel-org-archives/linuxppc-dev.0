Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7C2DA1A0DC6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 07:56:51 +1100 (AEDT)
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 803CF140779
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Jan 2016 07:56:50 +1100 (AEDT)
Received: from localhost
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Tue, 12 Jan 2016 02:26:47 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 1E43D1258059
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Jan 2016 02:27:31 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0BKuiWY17432798
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Jan 2016 02:26:44 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0BKuhAN024393
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Jan 2016 02:26:44 +0530
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
 pc@us.ibm.com, anton@samba.org, ego@linux.vnet.ibm.com,
 <stable@vger.kernel.org>, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v4 1/4] cpufreq: powernv: Remove cpu_to_chip_id() from hot-path
Date: Mon, 11 Jan 2016 14:54:37 -0600
Message-Id: <1452545680-11976-2-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
In-Reply-To: <1452545680-11976-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1451899527-14359-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1452545680-11976-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
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
