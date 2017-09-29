Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y3HB273l0zDsPN
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Sep 2017 13:30:02 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id e69so115639pfg.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Sep 2017 20:30:02 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 1/6] powerpc/watchdog: do not panic from locked CPU's IPI
 handler
Date: Fri, 29 Sep 2017 13:29:37 +1000
Message-Id: <20170929032942.4321-2-npiggin@gmail.com>
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
