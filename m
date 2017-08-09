Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xS9rQ6BjmzDr4x
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Aug 2017 22:41:58 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id u185so5826399pgb.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Aug 2017 05:41:58 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Paul Mackerras <paulus@samba.org>
Subject: [PATCH 3/6] powerpc/watchdog: Moderate touch_nmi_watchdog overhead
Date: Wed,  9 Aug 2017 22:41:23 +1000
Message-Id: <20170809124126.28907-4-npiggin@gmail.com>
In-Reply-To: <20170809124126.28907-1-npiggin@gmail.com>
References: <20170809124126.28907-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some code can go into a tight loop calling touch_nmi_watchdog (e.g.,
stop_machine CPU hotplug code). This can cause contention on watchdog
locks particularly if all CPUs with watchdog enabled are spinning in
the loops.

Avoid this storm of activity by running the watchdog timer callback
from this path if we have exceeded the timer period since it was last
run.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/watchdog.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
index 3a26c3401acc..2806383d2339 100644
--- a/arch/powerpc/kernel/watchdog.c
+++ b/arch/powerpc/kernel/watchdog.c
@@ -266,9 +266,11 @@ static void wd_timer_fn(unsigned long data)
 
 void arch_touch_nmi_watchdog(void)
 {
+	unsigned long ticks = tb_ticks_per_usec * wd_timer_period_ms * 1000;
 	int cpu = smp_processor_id();
 
-	watchdog_timer_interrupt(cpu);
+	if (get_tb() - per_cpu(wd_timer_tb, cpu) >= ticks)
+		watchdog_timer_interrupt(cpu);
 }
 EXPORT_SYMBOL(arch_touch_nmi_watchdog);
 
-- 
2.13.3
