Return-Path: <ego@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 720372C0125
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Mar 2014 22:11:29 +1100 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Mon, 10 Mar 2014 16:41:26 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 2997D394005E
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Mar 2014 16:41:24 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2ABBS2R10158338
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Mar 2014 16:41:28 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2ABBN5k003332
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Mar 2014 16:41:23 +0530
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 5/6] powernv:cpufreq: Export nominal frequency via sysfs.
Date: Mon, 10 Mar 2014 16:41:00 +0530
Message-Id: <1394449861-8688-6-git-send-email-ego@linux.vnet.ibm.com>
In-Reply-To: <1394449861-8688-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1394449861-8688-1-git-send-email-ego@linux.vnet.ibm.com>
Cc: srivatsa.bhat@linux.vnet.ibm.com,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
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
index 0ecd163..183bbc4 100644
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
