Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xwfJC4BYTzDrT1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Sep 2017 18:27:23 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id m30so4890730pgn.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Sep 2017 01:27:23 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 1/5] powerpc/watchdog: do not panic from locked CPU's IPI
 handler
Date: Mon, 18 Sep 2017 18:27:02 +1000
Message-Id: <20170918082706.6485-2-npiggin@gmail.com>
In-Reply-To: <20170918082706.6485-1-npiggin@gmail.com>
References: <20170918082706.6485-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The SMP watchdog will detect locked CPUs and IPI them to print a
backtrace and registers. If panic on hard lockup is enabled, do
not panic from this handler, because that can cause recursion into
the IPI layer during the panic.

The caller already panics in this case.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/watchdog.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
index 2f6eadd9408d..532a1adbe89b 100644
--- a/arch/powerpc/kernel/watchdog.c
+++ b/arch/powerpc/kernel/watchdog.c
@@ -97,8 +97,7 @@ static void wd_lockup_ipi(struct pt_regs *regs)
 	else
 		dump_stack();
 
-	if (hardlockup_panic)
-		nmi_panic(regs, "Hard LOCKUP");
+	/* Do not panic from here because that can recurse into NMI IPI layer */
 }
 
 static void set_cpumask_stuck(const struct cpumask *cpumask, u64 tb)
-- 
2.13.3
