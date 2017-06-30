Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wzTff07GNzDr61
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jun 2017 18:07:54 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id e199so16173120pfh.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jun 2017 01:07:53 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, Don Zickus <dzickus@redhat.com>,
 santosiv@in.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/64s: watchdog false positive warning at CPU unplug
Date: Fri, 30 Jun 2017 18:07:40 +1000
Message-Id: <20170630080740.20766-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CPU unplug will call stop_wd_on_cpu regardless if the watchdog has
been configured to be enabled on that CPU. Don't warn in the case
it's not in our enabled mask, this is a valid case.

Fixes: powerpc-64s-implement-arch-specific-hardlockup-watchdog.patch
Reported-by: Santosh Sivaraj <santosiv@in.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/watchdog.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
index d46040c0da40..93395a53336b 100644
--- a/arch/powerpc/kernel/watchdog.c
+++ b/arch/powerpc/kernel/watchdog.c
@@ -310,10 +310,8 @@ static int start_wd_on_cpu(unsigned int cpu)
 
 static int stop_wd_on_cpu(unsigned int cpu)
 {
-	if (!cpumask_test_cpu(cpu, &wd_cpus_enabled)) {
-		WARN_ON(1);
-		return 0;
-	}
+	if (!cpumask_test_cpu(cpu, &wd_cpus_enabled))
+		return 0; /* Can happen in CPU unplug case */
 
 	stop_watchdog_timer_on(cpu);
 
-- 
2.11.0
