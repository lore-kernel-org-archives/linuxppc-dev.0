Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5EA492C0093
 for <linuxppc-dev@ozlabs.org>; Mon, 29 Oct 2012 20:15:19 +1100 (EST)
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
 by mail-out.m-online.net (Postfix) with ESMTP id 3XqqsH67Lwz4KK7p
 for <linuxppc-dev@ozlabs.org>; Mon, 29 Oct 2012 10:15:15 +0100 (CET)
Received: from igel.home (ppp-88-217-107-89.dynamic.mnet-online.de
 [88.217.107.89])
 by mail.mnet-online.de (Postfix) with ESMTPA id 3XqqsH11Mnzbbg4
 for <linuxppc-dev@ozlabs.org>; Mon, 29 Oct 2012 10:15:15 +0100 (CET)
From: Andreas Schwab <schwab@linux-m68k.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powermac/cpufreq_32: set non-infinite transition time for
 7447A driver
Date: Mon, 29 Oct 2012 10:15:14 +0100
Message-ID: <m24nld1vx9.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The transition time for the 7447A is around 8ms which makes it possible
to use the ondemand governor.  This has been tested on the iBook G4
(PowerBook6,7).

Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
---
 arch/powerpc/platforms/powermac/cpufreq_32.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powermac/cpufreq_32.c b/arch/powerpc/platforms/powermac/cpufreq_32.c
index 6417119..311b804 100644
--- a/arch/powerpc/platforms/powermac/cpufreq_32.c
+++ b/arch/powerpc/platforms/powermac/cpufreq_32.c
@@ -55,6 +55,7 @@ static unsigned int low_freq;
 static unsigned int hi_freq;
 static unsigned int cur_freq;
 static unsigned int sleep_freq;
+static unsigned long transition_latency;
 
 /*
  * Different models uses different mechanisms to switch the frequency
@@ -403,7 +404,7 @@ static int pmac_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	if (policy->cpu != 0)
 		return -ENODEV;
 
-	policy->cpuinfo.transition_latency	= CPUFREQ_ETERNAL;
+	policy->cpuinfo.transition_latency	= transition_latency;
 	policy->cur = cur_freq;
 
 	cpufreq_frequency_table_get_attr(pmac_cpu_freqs, policy->cpu);
@@ -658,12 +659,14 @@ static int __init pmac_cpufreq_setup(void)
 	if (!value)
 		goto out;
 	cur_freq = (*value) / 1000;
+	transition_latency = CPUFREQ_ETERNAL;
 
 	/*  Check for 7447A based MacRISC3 */
 	if (of_machine_is_compatible("MacRISC3") &&
 	    of_get_property(cpunode, "dynamic-power-step", NULL) &&
 	    PVR_VER(mfspr(SPRN_PVR)) == 0x8003) {
 		pmac_cpufreq_init_7447A(cpunode);
+		transition_latency = 8000000;
 	/* Check for other MacRISC3 machines */
 	} else if (of_machine_is_compatible("PowerBook3,4") ||
 		   of_machine_is_compatible("PowerBook3,5") ||
-- 
1.8.0


-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
