Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40dL5z5TNgzDrLk
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 May 2018 17:26:15 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id a14so19124369pfi.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 May 2018 00:26:15 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH v2 1/2] powerpc/watchdog: don't update the watchdog timestamp
 if a lockup is detected
Date: Sat,  5 May 2018 17:25:59 +1000
Message-Id: <20180505072600.13270-2-npiggin@gmail.com>
In-Reply-To: <20180505072600.13270-1-npiggin@gmail.com>
References: <20180505072600.13270-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The watchdog heartbeat timestamp is updated when the local heartbeat
timer fires (or touch_nmi_watchdog() is called).

This is an interesting data point, so don't overwrite it when the
soft-NMI interrupt detects a hard lockup. That code came from a pre-
merge version to prevent hard lockup messages flood, but that's taken
care of with the stuck CPU logic now, so there is no reason to
update the heartbeat timestamp here.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/watchdog.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
index 6256dc3b0087..0bc701f9ab35 100644
--- a/arch/powerpc/kernel/watchdog.c
+++ b/arch/powerpc/kernel/watchdog.c
@@ -245,8 +245,6 @@ void soft_nmi_interrupt(struct pt_regs *regs)
 
 	tb = get_tb();
 	if (tb - per_cpu(wd_timer_tb, cpu) >= wd_panic_timeout_tb) {
-		per_cpu(wd_timer_tb, cpu) = tb;
-
 		wd_smp_lock(&flags);
 		if (cpumask_test_cpu(cpu, &wd_smp_cpus_stuck)) {
 			wd_smp_unlock(&flags);
-- 
2.17.0
