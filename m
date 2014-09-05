Return-Path: <preeti@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5FC341A17F6
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Sep 2014 17:40:45 +1000 (EST)
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9852D14009C
 for <linuxppc-dev@ozlabs.org>; Fri,  5 Sep 2014 17:40:44 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Fri, 5 Sep 2014 01:40:42 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 884943E4003D
 for <linuxppc-dev@ozlabs.org>; Fri,  5 Sep 2014 01:40:40 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s857cmf28126778
 for <linuxppc-dev@ozlabs.org>; Fri, 5 Sep 2014 09:38:48 +0200
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s857edRQ019667
 for <linuxppc-dev@ozlabs.org>; Fri, 5 Sep 2014 01:40:40 -0600
Subject: [PATCH V2 2/2] powernv/cpufreq: Set the pstate of the last
 hotplugged out cpu in policy->cpus to minimum
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
To: viresh.kumar@linaro.org, rjw@rjwysocki.net
Date: Fri, 05 Sep 2014 13:10:33 +0530
Message-ID: <20140905074023.3629.88028.stgit@preeti.in.ibm.com>
In-Reply-To: <20140905073812.3629.29175.stgit@preeti.in.ibm.com>
References: <20140905073812.3629.29175.stgit@preeti.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-pm@vger.kernel.org, dirk.j.brandewie@intel.com,
 shreyas@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 patrick.marlier@gmail.com, linuxppc-dev@ozlabs.org, dirk.brandewie@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Its possible today that the pstate of a core is held at a high even after the
entire core is hotplugged out if a load had just run on  the hotplugged cpu. This is
fair, since it is assumed that the pstate does not matter to a cpu in a deep idle
state, which is the expected state of a hotplugged core on powerpc. However on powerpc,
the pstate at a socket level is held at the maximum of the pstates of each core. Even
if the pstates of the active cores on that socket is low, the socket pstate is held
high due to the pstate of the hotplugged core in the above mentioned scenario. This
can cost significant amount of power loss for no good.

Besides, since it is a non active core, nothing can be done from the kernel's end
to set the frequency of the core right. Hence make use of the stop_cpu callback
to explicitly set the pstate of the core to a minimum when the last cpu of the
core gets hotplugged out.

Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
---

 drivers/cpufreq/powernv-cpufreq.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 379c083..5a628f1 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -317,6 +317,14 @@ static int powernv_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	return cpufreq_table_validate_and_show(policy, powernv_freqs);
 }
 
+static void powernv_cpufreq_stop_cpu(struct cpufreq_policy *policy)
+{
+	struct powernv_smp_call_data freq_data;
+
+	freq_data.pstate_id = powernv_pstate_info.min;
+	smp_call_function_single(policy->cpu, set_pstate, &freq_data, 1);
+}
+
 static struct cpufreq_driver powernv_cpufreq_driver = {
 	.name		= "powernv-cpufreq",
 	.flags		= CPUFREQ_CONST_LOOPS,
@@ -324,6 +332,7 @@ static struct cpufreq_driver powernv_cpufreq_driver = {
 	.verify		= cpufreq_generic_frequency_table_verify,
 	.target_index	= powernv_cpufreq_target_index,
 	.get		= powernv_cpufreq_get,
+	.stop_cpu	= powernv_cpufreq_stop_cpu,
 	.attr		= powernv_cpu_freq_attr,
 };
 
