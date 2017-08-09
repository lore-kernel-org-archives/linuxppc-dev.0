Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xS9rS6KkjzDr2j
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Aug 2017 22:42:00 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id 123so5801667pga.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Aug 2017 05:42:00 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Paul Mackerras <paulus@samba.org>
Subject: [PATCH 4/6] powerpc/watchdog: Fix final-check recovered case
Date: Wed,  9 Aug 2017 22:41:24 +1000
Message-Id: <20170809124126.28907-5-npiggin@gmail.com>
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

When the watchdog decides to panic, it takes the lock and double
checks everything (to avoid races with the CPU being unstuck or
panic()ed by something else).

The exit label was misplaced and would result in all-CPUs backtrace
and watchdog panic even in the case that the condition was found to be
resolved.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/watchdog.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
index 2806383d2339..5a69654075c1 100644
--- a/arch/powerpc/kernel/watchdog.c
+++ b/arch/powerpc/kernel/watchdog.c
@@ -144,7 +144,6 @@ static void watchdog_smp_panic(int cpu, u64 tb)
 	for_each_cpu(c, &wd_smp_cpus_pending)
 		set_cpu_stuck(c, tb);
 
-out:
 	wd_smp_unlock(&flags);
 
 	printk_safe_flush();
@@ -157,6 +156,11 @@ static void watchdog_smp_panic(int cpu, u64 tb)
 
 	if (hardlockup_panic)
 		nmi_panic(NULL, "Hard LOCKUP");
+
+	return;
+
+out:
+	wd_smp_unlock(&flags);
 }
 
 static void wd_smp_clear_cpu_pending(int cpu, u64 tb)
-- 
2.13.3
