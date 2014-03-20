Return-Path: <ego@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 08D7D2C010B
 for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2014 23:11:14 +1100 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Thu, 20 Mar 2014 22:11:13 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id C61B62BB003F
 for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2014 23:11:11 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2KBoxMo7078196
 for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2014 22:50:59 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2KCBA2X004137
 for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2014 23:11:11 +1100
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-pm@vger.kernel.org
Subject: [PATCH v3 4/5] powernv:cpufreq: Export nominal frequency via sysfs.
Date: Thu, 20 Mar 2014 17:40:59 +0530
Message-Id: <1395317460-14811-5-git-send-email-ego@linux.vnet.ibm.com>
In-Reply-To: <1395317460-14811-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1395317460-14811-1-git-send-email-ego@linux.vnet.ibm.com>
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

Create a driver attribute named cpuinfo_nominal_freq which
creates a sysfs read-only file named cpuinfo_nominal_freq. Export
the frequency corresponding to the nominal_pstate through this
interface.

Nominal frequency is the highest non-turbo frequency for the
platform.  This is generally used for setting governor policies from
user space for optimal energy efficiency.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 drivers/cpufreq/powernv-cpufreq.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index e7b0292..46bee8a 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -142,8 +142,30 @@ static unsigned int pstate_id_to_freq(int pstate_id)
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
