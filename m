Return-Path: <geert@linux-m68k.org>
Received: from wilson.telenet-ops.be (wilson.telenet-ops.be [195.130.132.42])
 by ozlabs.org (Postfix) with ESMTP id 2CF9A140307
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Apr 2014 20:05:28 +1000 (EST)
Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
 by wilson.telenet-ops.be (Postfix) with ESMTP id 45C35346F2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Apr 2014 11:53:34 +0200 (CEST)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 3/3] cpufreq: ppc: Fix handling of non-existent clocks
Date: Thu, 17 Apr 2014 11:53:27 +0200
Message-Id: <1397728407-13909-3-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1397728407-13909-1-git-send-email-geert+renesas@glider.be>
References: <1397728407-13909-1-git-send-email-geert+renesas@glider.be>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org,
 linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If the clock doesn't exist, clk_get_rate() returns -EINVAL, which becomes
a large number (freq is u32), failing the "freq < min_cpufreq" test.
Explicitly test for "(u32)-EINVAL" to fix this.

Update the comment, and fix a grammer issue while we're at it.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/cpufreq/ppc-corenet-cpufreq.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/ppc-corenet-cpufreq.c b/drivers/cpufreq/ppc-corenet-cpufreq.c
index 53881d78a931..7027eab814ce 100644
--- a/drivers/cpufreq/ppc-corenet-cpufreq.c
+++ b/drivers/cpufreq/ppc-corenet-cpufreq.c
@@ -179,10 +179,11 @@ static int corenet_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		clk = of_clk_get(data->parent, i);
 		freq = clk_get_rate(clk);
 		/*
-		 * the clock is valid if its frequency is not masked
-		 * and large than minimum allowed frequency.
+		 * the clock is valid if it exists, its frequency is not
+		 * masked, and larger than minimum allowed frequency.
 		 */
-		if (freq < min_cpufreq || (mask & (1 << i)))
+		if (freq == (u32)-EINVAL || freq < min_cpufreq ||
+		    (mask & (1 << i)))
 			table[i].frequency = CPUFREQ_ENTRY_INVALID;
 		else
 			table[i].frequency = freq / 1000;
-- 
1.7.9.5
