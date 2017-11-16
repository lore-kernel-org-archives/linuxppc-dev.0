Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yd5Zh6hZxzDr77
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Nov 2017 03:01:16 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id 207so18079752pgc.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 08:01:16 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 4/4] cpuidle/powernv: avoid double irq enable coming out of
 idle
Date: Fri, 17 Nov 2017 02:00:52 +1000
Message-Id: <20171116160052.18672-5-npiggin@gmail.com>
In-Reply-To: <20171116160052.18672-1-npiggin@gmail.com>
References: <20171116160052.18672-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since e1689795a7 ("cpuidle: Add common time keeping and irq enabling"),
cpuidle drivers are expected to return from ->enter with irqs disabled.

Update the cpuidle-powernv snooze and cede loops to disable irqs before
returning.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 drivers/cpuidle/cpuidle-pseries.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
index a187a39fb866..0f2b697cbb27 100644
--- a/drivers/cpuidle/cpuidle-pseries.c
+++ b/drivers/cpuidle/cpuidle-pseries.c
@@ -51,8 +51,6 @@ static inline void idle_loop_epilog(unsigned long in_purr)
 	get_lppaca()->wait_state_cycles = cpu_to_be64(wait_cycles);
 	get_lppaca()->idle = 0;
 
-	if (irqs_disabled())
-		local_irq_enable();
 	ppc64_runlatch_on();
 }
 
@@ -87,6 +85,8 @@ static int snooze_loop(struct cpuidle_device *dev,
 	HMT_medium();
 	clear_thread_flag(TIF_POLLING_NRFLAG);
 
+	local_irq_disable();
+
 	idle_loop_epilog(in_purr);
 
 	return index;
@@ -121,6 +121,7 @@ static int dedicated_cede_loop(struct cpuidle_device *dev,
 	HMT_medium();
 	check_and_cede_processor();
 
+	local_irq_disable();
 	get_lppaca()->donate_dedicated_cpu = 0;
 
 	idle_loop_epilog(in_purr);
@@ -145,6 +146,7 @@ static int shared_cede_loop(struct cpuidle_device *dev,
 	 */
 	check_and_cede_processor();
 
+	local_irq_disable();
 	idle_loop_epilog(in_purr);
 
 	return index;
-- 
2.15.0
