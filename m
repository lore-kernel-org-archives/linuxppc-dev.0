Return-Path: <mostrows@watson.ibm.com>
Received: from igw2.watson.ibm.com (igw2.watson.ibm.com [129.34.20.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6B08C67B1B
	for <linuxppc-dev@ozlabs.org>; Tue, 30 May 2006 06:42:13 +1000 (EST)
Received: from sp1n293en1.watson.ibm.com (sp1n293en1.watson.ibm.com
	[129.34.20.41])
	by igw2.watson.ibm.com (8.12.11.20060308/8.13.1/8.13.1-2005-04-25 igw)
	with ESMTP id k4TKggfN014930
	for <linuxppc-dev@ozlabs.org>; Mon, 29 May 2006 16:42:42 -0400
Received: from sp1n293en1.watson.ibm.com (localhost [127.0.0.1])
	by sp1n293en1.watson.ibm.com (8.11.7-20030924/8.11.7/01-14-2004_2) with
	ESMTP id k4TKg8D383854
	for <linuxppc-dev@ozlabs.org>; Mon, 29 May 2006 16:42:09 -0400
Received: from mgsmtp00.watson.ibm.com (mgsmtp00.watson.ibm.com [9.2.40.58])
	by sp1n293en1.watson.ibm.com (8.11.7-20030924/8.11.7/01-14-2004_1) with
	ESMTP id k4TKg8k429496
	for <linuxppc-dev@ozlabs.org>; Mon, 29 May 2006 16:42:08 -0400
Received: from kitch0.watson.ibm.com (kitch0.watson.ibm.com [9.2.224.107])
	by mgsmtp00.watson.ibm.com (8.12.11/8.12.11/2005/09/01) with ESMTP id
	k4TLZrkA002608
	for <linuxppc-dev@ozlabs.org>; Mon, 29 May 2006 17:35:53 -0400
Subject: [PATCH 5/8] Avoid use of ppc64_interrupt_controller.
In-Reply-To: <1148935262.25048.31.camel@brick>
Date: Mon, 29 May 2006 16:42:06 -0400
Message-Id: <1148935326201-git-send-email-mostrows@watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
To: linuxppc-dev@ozlabs.org
From: mostrows@watson.ibm.com
Reply-To: mostrows@watson.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

smp_init_pSeries() will use an XICS, unless it is told to explicitly
use an MPIC.

Checking for built-in support of the detect PIC is now consolidated in
pSeries_setup_arch.  (Eventually it should be possible to avoid building
code for a PIC if support for it has not been enabled.)

--
Signed-off-by: Michal Ostrowski <mostrows@watson.ibm.com>

---

 arch/powerpc/platforms/pseries/setup.c |   28 +++++++++++++++++++++-------
 arch/powerpc/platforms/pseries/smp.c   |   15 +++------------
 include/asm-powerpc/smp.h              |    6 +++++-
 3 files changed, 29 insertions(+), 20 deletions(-)

c294c06d77fbe3be12a705595ecd95f93054943e
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 33ae521..38bf976 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -153,6 +153,9 @@ static void __init pSeries_setup_mpic(vo
         struct device_node *root;
 	int irq_count;
 
+	ppc_md.init_IRQ       = pSeries_init_mpic;
+	ppc_md.get_irq        = mpic_get_irq;
+
 	/* Find the Open PIC if present */
 	root = of_find_node_by_path("/");
 	opprop = (unsigned int *) get_property(root, "platform-open-pic", NULL);
@@ -199,21 +202,32 @@ static void __init pSeries_setup_arch(vo
 	int int_ctrl = pSeries_discover_pic();
 	ppc64_interrupt_controller = int_ctrl;
 
+	
 	/* Fixup ppc_md depending on the type of interrupt controller */
-	if (int_ctrl == IC_OPEN_PIC) {
-		ppc_md.init_IRQ       = pSeries_init_mpic;
-		ppc_md.get_irq        = mpic_get_irq;
+	switch (int_ctrl) {
+	case IC_OPEN_PIC:
+#ifndef CONFIG_MPIC
+		panic("Kernel not configured for MPIC interrupt controller.");
+#else
 		/* Allocate the mpic now, so that find_and_init_phbs() can
 		 * fill the ISUs */
 		pSeries_setup_mpic();
-	} else {
+		smp_init_pSeries(1);
+#endif
+		break;
+	case IC_PPC_XIC:
+#ifndef CONFIG_XICS
+		panic("Kernel not configured for XICS interrupt controller.");
+#else
 		ppc_md.init_IRQ       = xics_init_IRQ;
 		ppc_md.get_irq        = xics_get_irq;
+		smp_init_pSeries(0);
+#endif
+		break;
+	default:
+		panic("Invalid interrupt controller");
 	}
 
-#ifdef CONFIG_SMP
-	smp_init_pSeries();
-#endif
 	/* openpic global configuration register (64-bit format). */
 	/* openpic Interrupt Source Unit pointer (64-bit format). */
 	/* python0 facility area (mmio) (64-bit format) REAL address. */
diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
index 3cf78a6..ef8676f 100644
--- a/arch/powerpc/platforms/pseries/smp.c
+++ b/arch/powerpc/platforms/pseries/smp.c
@@ -417,25 +417,16 @@ static struct smp_ops_t pSeries_xics_smp
 #endif
 
 /* This is called very early */
-void __init smp_init_pSeries(void)
+void __init smp_init_pSeries(int uses_mpic)
 {
 	int i;
 
 	DBG(" -> smp_init_pSeries()\n");
 
-	switch (ppc64_interrupt_controller) {
-#ifdef CONFIG_MPIC
-	case IC_OPEN_PIC:
+	if (uses_mpic) {
 		smp_ops = &pSeries_mpic_smp_ops;
-		break;
-#endif
-#ifdef CONFIG_XICS
-	case IC_PPC_XIC:
+	} else {
 		smp_ops = &pSeries_xics_smp_ops;
-		break;
-#endif
-	default:
-		panic("Invalid interrupt controller");
 	}
 
 #ifdef CONFIG_HOTPLUG_CPU
diff --git a/include/asm-powerpc/smp.h b/include/asm-powerpc/smp.h
index 4a716f7..11f1830 100644
--- a/include/asm-powerpc/smp.h
+++ b/include/asm-powerpc/smp.h
@@ -75,7 +75,7 @@ extern cpumask_t cpu_sibling_map[NR_CPUS
 #define PPC_MSG_DEBUGGER_BREAK  3
 
 void smp_init_iSeries(void);
-void smp_init_pSeries(void);
+void smp_init_pSeries(int uses_mpic);
 void smp_init_cell(void);
 void smp_setup_cpu_maps(void);
 
@@ -86,6 +86,10 @@ extern void __cpu_die(unsigned int cpu);
 /* for UP */
 #define smp_setup_cpu_maps()
 
+#define  smp_init_pSeries(uses_mpic) do {} while(0)
+#define  smp_init_iSeries() do {} while(0)
+#define  smp_init_cell() do {} while(0)
+
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_PPC64
-- 
1.1.4.g0b63-dirty
