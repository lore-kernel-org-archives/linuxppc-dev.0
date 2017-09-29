Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y3HB934nLzDsPN
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Sep 2017 13:30:09 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id u136so164637pgc.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Sep 2017 20:30:09 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 3/6] powerpc/watchdog: do not trigger SMP crash from
 touch_nmi_watchdog
Date: Fri, 29 Sep 2017 13:29:39 +1000
Message-Id: <20170929032942.4321-4-npiggin@gmail.com>
In-Reply-To: <20170929032942.4321-1-npiggin@gmail.com>
References: <20170929032942.4321-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In xmon, touch_nmi_watchdog() is not expected to be checking that
other CPUs have not touched the watchdog, so the code will just
call touch_nmi_watchdog() once before re-enabling hard interrupts.

Just update our CPU's state, and ignore apparently stuck SMP threads.

Arguably touch_nmi_watchdog should check for SMP lockups, and
callers should be fixed, but that's not trivial for the input code
of xmon.
---
 arch/powerpc/kernel/watchdog.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
index 920e61c79f47..1fb9379dc683 100644
--- a/arch/powerpc/kernel/watchdog.c
+++ b/arch/powerpc/kernel/watchdog.c
@@ -277,9 +277,12 @@ void arch_touch_nmi_watchdog(void)
 {
 	unsigned long ticks = tb_ticks_per_usec * wd_timer_period_ms * 1000;
 	int cpu = smp_processor_id();
+	u64 tb = get_tb();
 
-	if (get_tb() - per_cpu(wd_timer_tb, cpu) >= ticks)
-		watchdog_timer_interrupt(cpu);
+	if (tb - per_cpu(wd_timer_tb, cpu) >= ticks) {
+		per_cpu(wd_timer_tb, cpu) = tb;
+		wd_smp_clear_cpu_pending(cpu, tb);
+	}
 }
 EXPORT_SYMBOL(arch_touch_nmi_watchdog);
 
-- 
2.13.3
