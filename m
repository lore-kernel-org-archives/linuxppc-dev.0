Return-Path: <afleming@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A521C2C00E5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jul 2013 09:33:17 +1000 (EST)
From: Andy Fleming <afleming@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v2 2/2] powerpc: Convert platforms to smp_generic_cpu_bootable
Date: Mon, 29 Jul 2013 18:33:05 -0500
Message-ID: <1375140785-9782-2-git-send-email-afleming@freescale.com>
In-Reply-To: <1375140785-9782-1-git-send-email-afleming@freescale.com>
References: <1375140785-9782-1-git-send-email-afleming@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

T4, Cell, powernv, and pseries had the same implementation, so switch
them to use a generic version. A2 apparently had a version, but
removed it at some point, so we remove the declaration, too.

Signed-off-by: Andy Fleming <afleming@freescale.com>
---

v2: Removed conflict and Change-Id foo

 arch/powerpc/platforms/85xx/smp.c    |    1 +
 arch/powerpc/platforms/cell/smp.c    |   15 +--------------
 arch/powerpc/platforms/powernv/smp.c |   18 +-----------------
 arch/powerpc/platforms/pseries/smp.c |   18 +-----------------
 arch/powerpc/platforms/wsp/wsp.h     |    1 -
 5 files changed, 4 insertions(+), 49 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index 5ced4f5..ea9c626 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -255,6 +255,7 @@ out:
 
 struct smp_ops_t smp_85xx_ops = {
 	.kick_cpu = smp_85xx_kick_cpu,
+	.cpu_bootable = smp_generic_cpu_bootable,
 #ifdef CONFIG_HOTPLUG_CPU
 	.cpu_disable	= generic_cpu_disable,
 	.cpu_die	= generic_cpu_die,
diff --git a/arch/powerpc/platforms/cell/smp.c b/arch/powerpc/platforms/cell/smp.c
index f75f6fc..90745ea 100644
--- a/arch/powerpc/platforms/cell/smp.c
+++ b/arch/powerpc/platforms/cell/smp.c
@@ -136,25 +136,12 @@ static int smp_cell_kick_cpu(int nr)
 	return 0;
 }
 
-static int smp_cell_cpu_bootable(unsigned int nr)
-{
-	/* Special case - we inhibit secondary thread startup
-	 * during boot if the user requests it.  Odd-numbered
-	 * cpus are assumed to be secondary threads.
-	 */
-	if (system_state == SYSTEM_BOOTING &&
-	    cpu_has_feature(CPU_FTR_SMT) &&
-	    !smt_enabled_at_boot && cpu_thread_in_core(nr) != 0)
-		return 0;
-
-	return 1;
-}
 static struct smp_ops_t bpa_iic_smp_ops = {
 	.message_pass	= iic_message_pass,
 	.probe		= smp_iic_probe,
 	.kick_cpu	= smp_cell_kick_cpu,
 	.setup_cpu	= smp_cell_setup_cpu,
-	.cpu_bootable	= smp_cell_cpu_bootable,
+	.cpu_bootable	= smp_generic_cpu_bootable,
 };
 
 /* This is called very early */
diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index 89e3857..908672b 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -46,22 +46,6 @@ static void pnv_smp_setup_cpu(int cpu)
 		xics_setup_cpu();
 }
 
-static int pnv_smp_cpu_bootable(unsigned int nr)
-{
-	/* Special case - we inhibit secondary thread startup
-	 * during boot if the user requests it.
-	 */
-	if (system_state == SYSTEM_BOOTING && cpu_has_feature(CPU_FTR_SMT)) {
-		if (!smt_enabled_at_boot && cpu_thread_in_core(nr) != 0)
-			return 0;
-		if (smt_enabled_at_boot
-		    && cpu_thread_in_core(nr) >= smt_enabled_at_boot)
-			return 0;
-	}
-
-	return 1;
-}
-
 int pnv_smp_kick_cpu(int nr)
 {
 	unsigned int pcpu = get_hard_smp_processor_id(nr);
@@ -195,7 +179,7 @@ static struct smp_ops_t pnv_smp_ops = {
 	.probe		= xics_smp_probe,
 	.kick_cpu	= pnv_smp_kick_cpu,
 	.setup_cpu	= pnv_smp_setup_cpu,
-	.cpu_bootable	= pnv_smp_cpu_bootable,
+	.cpu_bootable	= smp_generic_cpu_bootable,
 #ifdef CONFIG_HOTPLUG_CPU
 	.cpu_disable	= pnv_smp_cpu_disable,
 	.cpu_die	= generic_cpu_die,
diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
index 306643c..ca2d1f6 100644
--- a/arch/powerpc/platforms/pseries/smp.c
+++ b/arch/powerpc/platforms/pseries/smp.c
@@ -187,22 +187,6 @@ static int smp_pSeries_kick_cpu(int nr)
 	return 0;
 }
 
-static int smp_pSeries_cpu_bootable(unsigned int nr)
-{
-	/* Special case - we inhibit secondary thread startup
-	 * during boot if the user requests it.
-	 */
-	if (system_state == SYSTEM_BOOTING && cpu_has_feature(CPU_FTR_SMT)) {
-		if (!smt_enabled_at_boot && cpu_thread_in_core(nr) != 0)
-			return 0;
-		if (smt_enabled_at_boot
-		    && cpu_thread_in_core(nr) >= smt_enabled_at_boot)
-			return 0;
-	}
-
-	return 1;
-}
-
 /* Only used on systems that support multiple IPI mechanisms */
 static void pSeries_cause_ipi_mux(int cpu, unsigned long data)
 {
@@ -237,7 +221,7 @@ static struct smp_ops_t pSeries_xics_smp_ops = {
 	.probe		= pSeries_smp_probe,
 	.kick_cpu	= smp_pSeries_kick_cpu,
 	.setup_cpu	= smp_xics_setup_cpu,
-	.cpu_bootable	= smp_pSeries_cpu_bootable,
+	.cpu_bootable	= smp_generic_cpu_bootable,
 };
 
 /* This is called very early */
diff --git a/arch/powerpc/platforms/wsp/wsp.h b/arch/powerpc/platforms/wsp/wsp.h
index 62ef21a..a563a8a 100644
--- a/arch/powerpc/platforms/wsp/wsp.h
+++ b/arch/powerpc/platforms/wsp/wsp.h
@@ -17,7 +17,6 @@ extern void scom_init_wsp(void);
 extern void a2_setup_smp(void);
 extern int a2_scom_startup_cpu(unsigned int lcpu, int thr_idx,
 			       struct device_node *np);
-extern int smp_a2_cpu_bootable(unsigned int nr);
 extern int smp_a2_kick_cpu(int nr);
 
 extern void opb_pic_init(void);
-- 
1.7.9.7
