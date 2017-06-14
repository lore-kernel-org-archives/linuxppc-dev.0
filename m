Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wnmyp47MYzDqLG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 23:03:14 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id w12so16684066pfk.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 06:03:14 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] cpuidle: powerpc: read mostly for common globals
Date: Wed, 14 Jun 2017 23:02:40 +1000
Message-Id: <20170614130241.19865-3-npiggin@gmail.com>
In-Reply-To: <20170614130241.19865-1-npiggin@gmail.com>
References: <20170614130241.19865-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ensure these don't get put into bouncing cachelines.

Reviewed-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 drivers/cpuidle/cpuidle-powernv.c | 10 +++++-----
 drivers/cpuidle/cpuidle-pseries.c |  8 ++++----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 77bc50ad9f57..abf2ffcd4a0a 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -32,18 +32,18 @@ static struct cpuidle_driver powernv_idle_driver = {
 	.owner            = THIS_MODULE,
 };
 
-static int max_idle_state;
-static struct cpuidle_state *cpuidle_state_table;
+static int max_idle_state __read_mostly;
+static struct cpuidle_state *cpuidle_state_table __read_mostly;
 
 struct stop_psscr_table {
 	u64 val;
 	u64 mask;
 };
 
-static struct stop_psscr_table stop_psscr_table[CPUIDLE_STATE_MAX];
+static struct stop_psscr_table stop_psscr_table[CPUIDLE_STATE_MAX] __read_mostly;
 
-static u64 snooze_timeout;
-static bool snooze_timeout_en;
+static u64 snooze_timeout __read_mostly;
+static bool snooze_timeout_en __read_mostly;
 
 static int snooze_loop(struct cpuidle_device *dev,
 			struct cpuidle_driver *drv,
diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
index 7b12bb2ea70f..a404f352d284 100644
--- a/drivers/cpuidle/cpuidle-pseries.c
+++ b/drivers/cpuidle/cpuidle-pseries.c
@@ -25,10 +25,10 @@ struct cpuidle_driver pseries_idle_driver = {
 	.owner            = THIS_MODULE,
 };
 
-static int max_idle_state;
-static struct cpuidle_state *cpuidle_state_table;
-static u64 snooze_timeout;
-static bool snooze_timeout_en;
+static int max_idle_state __read_mostly;
+static struct cpuidle_state *cpuidle_state_table __read_mostly;
+static u64 snooze_timeout __read_mostly;
+static bool snooze_timeout_en __read_mostly;
 
 static inline void idle_loop_prolog(unsigned long *in_purr)
 {
-- 
2.11.0
