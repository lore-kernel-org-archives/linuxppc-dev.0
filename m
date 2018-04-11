Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40LXQP09MmzF1Rc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Apr 2018 15:19:08 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/3] powerpc/xive: Remove xive_kexec_teardown_cpu()
Date: Wed, 11 Apr 2018 15:18:01 +1000
Message-Id: <20180411051801.30194-3-benh@kernel.crashing.org>
In-Reply-To: <20180411051801.30194-1-benh@kernel.crashing.org>
References: <20180411051801.30194-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It's identical to xive_teardown_cpu() so just use the latter

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/xive.h        |  1 -
 arch/powerpc/platforms/powernv/setup.c |  2 +-
 arch/powerpc/platforms/pseries/kexec.c |  2 +-
 arch/powerpc/sysdev/xive/common.c      | 22 ----------------------
 4 files changed, 2 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/include/asm/xive.h b/arch/powerpc/include/asm/xive.h
index 8d1a2792484f..3c704f5dd3ae 100644
--- a/arch/powerpc/include/asm/xive.h
+++ b/arch/powerpc/include/asm/xive.h
@@ -87,7 +87,6 @@ extern int  xive_smp_prepare_cpu(unsigned int cpu);
 extern void xive_smp_setup_cpu(void);
 extern void xive_smp_disable_cpu(void);
 extern void xive_teardown_cpu(void);
-extern void xive_kexec_teardown_cpu(int secondary);
 extern void xive_shutdown(void);
 extern void xive_flush_interrupt(void);
 
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index 092715b9674b..5b4b09816791 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -282,7 +282,7 @@ static void pnv_kexec_cpu_down(int crash_shutdown, int secondary)
 	u64 reinit_flags;
 
 	if (xive_enabled())
-		xive_kexec_teardown_cpu(secondary);
+		xive_teardown_cpu();
 	else
 		xics_kexec_teardown_cpu(secondary);
 
diff --git a/arch/powerpc/platforms/pseries/kexec.c b/arch/powerpc/platforms/pseries/kexec.c
index eeb13429d685..9dabf019556b 100644
--- a/arch/powerpc/platforms/pseries/kexec.c
+++ b/arch/powerpc/platforms/pseries/kexec.c
@@ -53,7 +53,7 @@ void pseries_kexec_cpu_down(int crash_shutdown, int secondary)
 	}
 
 	if (xive_enabled())
-		xive_kexec_teardown_cpu(secondary);
+		xive_teardown_cpu();
 	else
 		xics_kexec_teardown_cpu(secondary);
 }
diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index 40c06110821c..c8db51b60b4b 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -1408,28 +1408,6 @@ void xive_teardown_cpu(void)
 	xive_cleanup_cpu_queues(cpu, xc);
 }
 
-void xive_kexec_teardown_cpu(int secondary)
-{
-	struct xive_cpu *xc = __this_cpu_read(xive_cpu);
-	unsigned int cpu = smp_processor_id();
-
-	/* Set CPPR to 0 to disable flow of interrupts */
-	xc->cppr = 0;
-	out_8(xive_tima + xive_tima_offset + TM_CPPR, 0);
-
-	/* Backend cleanup if any */
-	if (xive_ops->teardown_cpu)
-		xive_ops->teardown_cpu(cpu, xc);
-
-#ifdef CONFIG_SMP
-	/* Get rid of IPI */
-	xive_cleanup_cpu_ipi(cpu, xc);
-#endif
-
-	/* Disable and free the queues */
-	xive_cleanup_cpu_queues(cpu, xc);
-}
-
 void xive_shutdown(void)
 {
 	xive_ops->shutdown();
-- 
2.14.3
