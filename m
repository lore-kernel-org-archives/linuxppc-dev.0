Return-Path: <ego@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A95971400AE
 for <linuxppc-dev@ozlabs.org>; Tue,  1 Apr 2014 18:13:44 +1100 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Tue, 1 Apr 2014 12:43:42 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id C624F125803E
 for <linuxppc-dev@ozlabs.org>; Tue,  1 Apr 2014 12:46:07 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s317DZ6W66060400
 for <linuxppc-dev@ozlabs.org>; Tue, 1 Apr 2014 12:43:35 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s317DcFo024557
 for <linuxppc-dev@ozlabs.org>; Tue, 1 Apr 2014 12:43:38 +0530
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>, rjw@rjwysocki.net,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH REPOST v5 3/3] powernv,
 cpufreq: Use cpufreq_frequency_table.driver_data to store pstate ids
Date: Tue,  1 Apr 2014 12:43:27 +0530
Message-Id: <1396336408-20954-2-git-send-email-ego@linux.vnet.ibm.com>
In-Reply-To: <1396336408-20954-1-git-send-email-ego@linux.vnet.ibm.com>
References: <CAKohpo=jvswNPmUPEbS79bSp9ZWC1e3DjaEUX=O4CWMXfufHrw@mail.gmail.com>
 <1396336408-20954-1-git-send-email-ego@linux.vnet.ibm.com>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Linux PM list <linux-pm@vger.kernel.org>, linux-kernel@vger.kernel.org,
 cpufreq@vger.kernel.org, linuxppc-dev@ozlabs.org,
 Anton Blanchard <anton@samba.org>, srivatsa.bhat@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

The .driver_data field in the cpufreq_frequency_table was supposed to
be private to the drivers. However at some later point, it was being
used to indicate if the particular frequency in the table is the
BOOST_FREQUENCY. After patches [1] and [2], the .driver_data is once
again private to the driver. Thus we can safely use
cpufreq_frequency_table.driver_data to store pstate_ids instead of
having to maintain a separate array powernv_pstate_ids[] for this
purpose.

[1]:
  Subject: cpufreq: don't print value of .driver_data from core
  From   : Viresh Kumar <viresh.kumar@ linaro.org>
  url    : http://marc.info/?l=linux-pm&m=139601421504709&w=2

[2]:
  Subject: cpufreq: create another field .flags in cpufreq_frequency_table
  From   : Viresh Kumar <viresh.kumar@linaro.org>
  url    : http://marc.info/?l=linux-pm&m=139601416804702&w=2

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 drivers/cpufreq/powernv-cpufreq.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index e1e5197..9edccc6 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -33,7 +33,6 @@
 #define POWERNV_MAX_PSTATES	256
 
 static struct cpufreq_frequency_table powernv_freqs[POWERNV_MAX_PSTATES+1];
-static int powernv_pstate_ids[POWERNV_MAX_PSTATES+1];
 
 /*
  * Note: The set of pstates consists of contiguous integers, the
@@ -112,7 +111,7 @@ static int init_powernv_pstates(void)
 
 		pr_debug("PState id %d freq %d MHz\n", id, freq);
 		powernv_freqs[i].frequency = freq * 1000; /* kHz */
-		powernv_pstate_ids[i] = id;
+		powernv_freqs[i].driver_data = id;
 	}
 	/* End of list marker entry */
 	powernv_freqs[i].frequency = CPUFREQ_TABLE_END;
@@ -283,7 +282,7 @@ static int powernv_cpufreq_target_index(struct cpufreq_policy *policy,
 {
 	struct powernv_smp_call_data freq_data;
 
-	freq_data.pstate_id = powernv_pstate_ids[new_index];
+	freq_data.pstate_id = powernv_freqs[new_index].driver_data;
 
 	/*
 	 * Use smp_call_function to send IPI and execute the
-- 
1.8.3.1
