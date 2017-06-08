Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wk90M5tcczDqNZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Jun 2017 01:52:03 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id v14so5009477pgn.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Jun 2017 08:52:03 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 "Shreyas B . Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: [PATCH 10/14] powerpc/64s: cpuidle set polling before enabling irqs
Date: Fri,  9 Jun 2017 01:51:09 +1000
Message-Id: <20170608155113.21300-11-npiggin@gmail.com>
In-Reply-To: <20170608155113.21300-1-npiggin@gmail.com>
References: <20170608155113.21300-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

local_irq_enable can cause interrupts to be taken which could
take significant amount of processing time. The idle process
should set its polling flag before this, so another process that
wakes it during this time will not have to send an IPI.

Expand the TIF_POLLING_NRFLAG coverage to as large as possible.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 drivers/cpuidle/cpuidle-powernv.c | 4 +++-
 drivers/cpuidle/cpuidle-pseries.c | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 150b971c303b..0ee4660efb5f 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -51,9 +51,10 @@ static int snooze_loop(struct cpuidle_device *dev,
 {
 	u64 snooze_exit_time;
 
-	local_irq_enable();
 	set_thread_flag(TIF_POLLING_NRFLAG);
 
+	local_irq_enable();
+
 	snooze_exit_time = get_tb() + snooze_timeout;
 	ppc64_runlatch_off();
 	HMT_very_low();
@@ -66,6 +67,7 @@ static int snooze_loop(struct cpuidle_device *dev,
 	ppc64_runlatch_on();
 	clear_thread_flag(TIF_POLLING_NRFLAG);
 	smp_mb();
+
 	return index;
 }
 
diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
index 166ccd711ec9..7b12bb2ea70f 100644
--- a/drivers/cpuidle/cpuidle-pseries.c
+++ b/drivers/cpuidle/cpuidle-pseries.c
@@ -62,9 +62,10 @@ static int snooze_loop(struct cpuidle_device *dev,
 	unsigned long in_purr;
 	u64 snooze_exit_time;
 
+	set_thread_flag(TIF_POLLING_NRFLAG);
+
 	idle_loop_prolog(&in_purr);
 	local_irq_enable();
-	set_thread_flag(TIF_POLLING_NRFLAG);
 	snooze_exit_time = get_tb() + snooze_timeout;
 
 	while (!need_resched()) {
-- 
2.11.0
