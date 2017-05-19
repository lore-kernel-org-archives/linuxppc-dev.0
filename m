Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wTrMx2JbjzDqf0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 May 2017 00:41:17 +1000 (AEST)
From: Anton Blanchard <anton@ozlabs.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 npiggin@gmail.com, mikey@neuling.org, cyrilbur@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/64: Use tick accounting by default
Date: Sat, 20 May 2017 00:41:12 +1000
Message-Id: <20170519144112.15649-1-anton@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Blanchard <anton@samba.org>

ppc64 is the only architecture that turns on VIRT_CPU_ACCOUNTING_NATIVE
by default. The overhead of this option is extremely high - a context
switch microbenchmark using sched_yield() is almost 20% slower.

To get finer grained user/hardirq/softirq statitics, the
IRQ_TIME_ACCOUNTING option can be used instead, which has much lower
overhead.

As such, disable this option by default. If a user really wants it,
they can still enable it manually.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 init/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 1d3475fc9496..a5c30acc1ede 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -342,8 +342,7 @@ config VIRT_CPU_ACCOUNTING
 
 choice
 	prompt "Cputime accounting"
-	default TICK_CPU_ACCOUNTING if !PPC64
-	default VIRT_CPU_ACCOUNTING_NATIVE if PPC64
+	default TICK_CPU_ACCOUNTING
 
 # Kind of a stub config for the pure tick based cputime accounting
 config TICK_CPU_ACCOUNTING
-- 
2.11.0
