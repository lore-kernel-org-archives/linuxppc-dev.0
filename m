Return-Path: <stratosk@semaphore.gr>
Received: from sema.semaphore.gr (unknown [78.46.194.137])
 (using TLSv1.1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C981A14008F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Apr 2014 07:19:08 +1000 (EST)
Message-ID: <534C4EDF.2050607@semaphore.gr>
Date: Tue, 15 Apr 2014 00:10:55 +0300
From: Stratos Karafotis <stratosk@semaphore.gr>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 18/20] cpufreq: pasemi: Use cpufreq_for_each_entry macro for
 iteration
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The cpufreq core supports the cpufreq_for_each_entry macro helper
for iteration over the cpufreq_frequency_table, so use it.

It should have no functional changes.

Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
---

Please note that I was no able to compile test this patch due to 
lack of cross compiler.

 drivers/cpufreq/pasemi-cpufreq.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/pasemi-cpufreq.c b/drivers/cpufreq/pasemi-cpufreq.c
index 84c84b5..9a64492 100644
--- a/drivers/cpufreq/pasemi-cpufreq.c
+++ b/drivers/cpufreq/pasemi-cpufreq.c
@@ -136,9 +136,10 @@ void restore_astate(int cpu)
 
 static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
+	struct cpufreq_frequency_table *pos;
 	const u32 *max_freqp;
 	u32 max_freq;
-	int i, cur_astate;
+	int cur_astate;
 	struct resource res;
 	struct device_node *cpu, *dn;
 	int err = -ENODEV;
@@ -197,10 +198,9 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	pr_debug("initializing frequency table\n");
 
 	/* initialize frequency table */
-	for (i=0; pas_freqs[i].frequency!=CPUFREQ_TABLE_END; i++) {
-		pas_freqs[i].frequency =
-			get_astate_freq(pas_freqs[i].driver_data) * 100000;
-		pr_debug("%d: %d\n", i, pas_freqs[i].frequency);
+	cpufreq_for_each_entry(pos, pas_freqs) {
+		pos->frequency = get_astate_freq(pos->driver_data) * 100000;
+		pr_debug("%lu: %d\n", pos - pas_freqs, pos->frequency);
 	}
 
 	cur_astate = get_cur_astate(policy->cpu);
-- 
1.9.0
