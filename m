Return-Path: <ego@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A0B992C014B
 for <linuxppc-dev@ozlabs.org>; Mon,  3 Mar 2014 19:34:08 +1100 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Mon, 3 Mar 2014 14:04:05 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id A2BB91258053
 for <linuxppc-dev@ozlabs.org>; Mon,  3 Mar 2014 14:06:10 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s238Y5Ee56819768
 for <linuxppc-dev@ozlabs.org>; Mon, 3 Mar 2014 14:04:06 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s238Xxe2016649
 for <linuxppc-dev@ozlabs.org>; Mon, 3 Mar 2014 14:04:00 +0530
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, Ben Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 "Srivatsa S . Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH 2/4] powernv:cpufreq: Export nominal frequency via sysfs.
Date: Mon,  3 Mar 2014 14:03:43 +0530
Message-Id: <1393835625-25102-3-git-send-email-ego@linux.vnet.ibm.com>
In-Reply-To: <1393835625-25102-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1393835625-25102-1-git-send-email-ego@linux.vnet.ibm.com>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

Create a driver attribute named cpuinfo_nominal_frequency which
creates a sysfs read-only file named cpuinfo_nominal_frequency. Export
the frequency corresponding to the nominal_pstate through this
interface.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 drivers/cpufreq/powernv-cpufreq.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index d0a8dee..c59eb26 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -137,8 +137,30 @@ static unsigned int pstate_id_to_freq(int pstate_id)
 	return powernv_freqs[i].frequency;
 }
 
+/**
+ * show_cpuinfo_nominal_freq - Show the nominal CPU frequency as indicated by
+ * the firmware
+ */
+static ssize_t show_cpuinfo_nominal_freq(struct cpufreq_policy *policy,
+					char *buf)
+{
+	int nominal_freq;
+	nominal_freq = pstate_id_to_freq(powernv_pstate_info.pstate_nominal_id);
+	return sprintf(buf, "%u\n", nominal_freq);
+}
+
+
+struct freq_attr cpufreq_freq_attr_cpuinfo_nominal_freq = {
+	.attr = { .name = "cpuinfo_nominal_freq",
+		  .mode = 0444,
+		},
+	.show = show_cpuinfo_nominal_freq,
+};
+
+
 static struct freq_attr *powernv_cpu_freq_attr[] = {
 	&cpufreq_freq_attr_scaling_available_freqs,
+	&cpufreq_freq_attr_cpuinfo_nominal_freq,
 	NULL,
 };
 
-- 
1.8.3.1
