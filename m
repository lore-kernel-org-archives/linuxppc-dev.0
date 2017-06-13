Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wn95L1rLRzDqLq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 23:06:46 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id v14so18698849pgn.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 06:06:46 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 "Vaidyanathan Srinivasan" <svaidy@linux.vnet.ibm.com>
Subject: [PATCH 10/13] powerpc/64s: cpuidle read mostly for common globals
Date: Tue, 13 Jun 2017 23:05:54 +1000
Message-Id: <20170613130557.26315-11-npiggin@gmail.com>
In-Reply-To: <20170613130557.26315-1-npiggin@gmail.com>
References: <20170613130557.26315-1-npiggin@gmail.com>
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
index 50b3c2e0306f..9d03326ac05e 100644
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
