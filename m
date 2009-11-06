Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9A58CB7B7D
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Nov 2009 09:42:10 +1100 (EST)
Message-Id: <20091106223806.762624109@linutronix.de>
Date: Fri, 06 Nov 2009 22:41:46 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch 09/16] powerpc: Replace old style lock initializer
References: <20091106223547.784916750@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

SPIN_LOCK_UNLOCKED is deprecated. Init the lock array at runtime
instead.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
---
 arch/powerpc/platforms/iseries/htab.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

Index: linux-2.6/arch/powerpc/platforms/iseries/htab.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/iseries/htab.c
+++ linux-2.6/arch/powerpc/platforms/iseries/htab.c
@@ -19,8 +19,7 @@
 
 #include "call_hpt.h"
 
-static spinlock_t iSeries_hlocks[64] __cacheline_aligned_in_smp =
-	{ [0 ... 63] = SPIN_LOCK_UNLOCKED};
+static spinlock_t iSeries_hlocks[64] __cacheline_aligned_in_smp;
 
 /*
  * Very primitive algorithm for picking up a lock
@@ -245,6 +244,11 @@ static void iSeries_hpte_invalidate(unsi
 
 void __init hpte_init_iSeries(void)
 {
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(iSeries_hlocks); i++)
+		spin_lock_init(&iSeries_hlocks[i]);
+
 	ppc_md.hpte_invalidate	= iSeries_hpte_invalidate;
 	ppc_md.hpte_updatepp	= iSeries_hpte_updatepp;
 	ppc_md.hpte_updateboltedpp = iSeries_hpte_updateboltedpp;
