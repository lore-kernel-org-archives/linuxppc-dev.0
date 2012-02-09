Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 914C8B6FA4
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Feb 2012 15:11:06 +1100 (EST)
Message-ID: <1328760661.2903.49.camel@pasglop>
Subject: [PATCH] powerpc/wsp: Fix IRQ affinity setting
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Thu, 09 Feb 2012 15:11:01 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Jimi Xenidis <jimix@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We call the cache_hwirq_map() function with a linux IRQ number
but it expects a HW irq number. This triggers a BUG on multic-chip
setups in addition to not doing the right thing.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/wsp/ics.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/wsp/ics.c b/arch/powerpc/platforms/wsp/ics.c
index 5768743..97fe82e 100644
--- a/arch/powerpc/platforms/wsp/ics.c
+++ b/arch/powerpc/platforms/wsp/ics.c
@@ -346,7 +346,7 @@ static int wsp_chip_set_affinity(struct irq_data *d,
 	 * For the moment only implement delivery to all cpus or one cpu.
 	 * Get current irq_server for the given irq
 	 */
-	ret = cache_hwirq_map(ics, d->irq, cpumask);
+	ret = cache_hwirq_map(ics, hw_irq, cpumask);
 	if (ret == -1) {
 		char cpulist[128];
 		cpumask_scnprintf(cpulist, sizeof(cpulist), cpumask);
-- 
1.7.7.3
