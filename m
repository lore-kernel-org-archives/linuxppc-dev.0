Return-Path: <mostrows@watson.ibm.com>
Received: from igw2.watson.ibm.com (igw2.watson.ibm.com [129.34.20.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 99DE367A3F
	for <linuxppc-dev@ozlabs.org>; Tue, 30 May 2006 06:42:11 +1000 (EST)
Received: from sp1n293en1.watson.ibm.com (sp1n293en1.watson.ibm.com
	[129.34.20.41])
	by igw2.watson.ibm.com (8.12.11.20060308/8.13.1/8.13.1-2005-04-25 igw)
	with ESMTP id k4TKgeYM014925
	for <linuxppc-dev@ozlabs.org>; Mon, 29 May 2006 16:42:40 -0400
Received: from sp1n293en1.watson.ibm.com (localhost [127.0.0.1])
	by sp1n293en1.watson.ibm.com (8.11.7-20030924/8.11.7/01-14-2004_2) with
	ESMTP id k4TKg8D254664
	for <linuxppc-dev@ozlabs.org>; Mon, 29 May 2006 16:42:08 -0400
Received: from mgsmtp00.watson.ibm.com (mgsmtp00.watson.ibm.com [9.2.40.58])
	by sp1n293en1.watson.ibm.com (8.11.7-20030924/8.11.7/01-14-2004_1) with
	ESMTP id k4TKg7k14688
	for <linuxppc-dev@ozlabs.org>; Mon, 29 May 2006 16:42:07 -0400
Received: from kitch0.watson.ibm.com (kitch0.watson.ibm.com [9.2.224.107])
	by mgsmtp00.watson.ibm.com (8.12.11/8.12.11/2005/09/01) with ESMTP id
	k4TLZqLH002569
	for <linuxppc-dev@ozlabs.org>; Mon, 29 May 2006 17:35:52 -0400
Subject: [PATCH 2/8] PIC discovery re-organization.
In-Reply-To: <1148935262.25048.31.camel@brick>
Date: Mon, 29 May 2006 16:42:05 -0400
Message-Id: <1148935325129-git-send-email-mostrows@watson.ibm.com>
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

Change pSeries_discover_pic() to simply return the PIC type, rather
than setting the global "ppc64_interrupt_controller" value.  They type of
controller present will be passed down as an argument to functions
that need it.

--
Signed-off-by: Michal Ostrowski <mostrows@watson.ibm.com>

---

 arch/powerpc/platforms/pseries/setup.c |   36 +++++++++++++++++---------------
 1 files changed, 19 insertions(+), 17 deletions(-)

3675f032e1b03d6f000ffb08b2487ee9aa44fa2d
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 9d22265..33ae521 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -83,6 +83,7 @@ int fwnmi_active;  /* TRUE if an FWNMI h
 
 static void pseries_shared_idle_sleep(void);
 static void pseries_dedicated_idle_sleep(void);
+static  int pSeries_discover_pic(void);
 
 struct mpic *pSeries_mpic;
 
@@ -195,8 +196,11 @@ static void pseries_lpar_enable_pmcs(voi
 
 static void __init pSeries_setup_arch(void)
 {
+	int int_ctrl = pSeries_discover_pic();
+	ppc64_interrupt_controller = int_ctrl;
+
 	/* Fixup ppc_md depending on the type of interrupt controller */
-	if (ppc64_interrupt_controller == IC_OPEN_PIC) {
+	if (int_ctrl == IC_OPEN_PIC) {
 		ppc_md.init_IRQ       = pSeries_init_mpic;
 		ppc_md.get_irq        = mpic_get_irq;
 		/* Allocate the mpic now, so that find_and_init_phbs() can
@@ -261,39 +265,30 @@ static int __init pSeries_init_panel(voi
 }
 arch_initcall(pSeries_init_panel);
 
-static  void __init pSeries_discover_pic(void)
+static  int __init pSeries_discover_pic(void)
 {
 	struct device_node *np;
 	char *typep;
-
 	/*
 	 * Setup interrupt mapping options that are needed for finish_device_tree
 	 * to properly parse the OF interrupt tree & do the virtual irq mapping
 	 */
-	ppc64_interrupt_controller = IC_INVALID;
+	int int_ctrl = IC_INVALID;
 	for (np = NULL; (np = of_find_node_by_name(np, "interrupt-controller"));) {
 		typep = (char *)get_property(np, "compatible", NULL);
 		if (strstr(typep, "open-pic")) {
-			ppc64_interrupt_controller = IC_OPEN_PIC;
+			int_ctrl = IC_OPEN_PIC;
 			break;
 		} else if (strstr(typep, "ppc-xicp")) {
-			ppc64_interrupt_controller = IC_PPC_XIC;
+			int_ctrl = IC_PPC_XIC;
 			break;
 		}
 	}
-	if (ppc64_interrupt_controller == IC_INVALID)
+	if (int_ctrl == IC_INVALID)
 		printk("pSeries_discover_pic: failed to recognize"
 			" interrupt-controller\n");
 
-	/*
-	 * Don't use virtual irqs 0, 1, 2 for devices.
-	 * The pcnet32 driver considers interrupt numbers < 2 to be invalid,
-	 * and 2 is the XICS IPI interrupt.
-	 */
-	
-	virt_irq_config(NUM_ISA_INTERRUPTS, 3,  
-			NR_IRQS - (3 + NUM_ISA_INTERRUPTS));
-
+	return int_ctrl;
 }
 
 static void pSeries_mach_cpu_die(void)
@@ -346,7 +341,14 @@ static void __init pSeries_init_early(vo
 
 	iommu_init_early_pSeries();
 
-	pSeries_discover_pic();
+	/*
+	 * Don't use virtual irqs 0, 1, 2 for devices.
+	 * The pcnet32 driver considers interrupt numbers < 2 to be invalid,
+	 * and 2 is the XICS IPI interrupt.
+	 */
+	
+	virt_irq_config(NUM_ISA_INTERRUPTS, 3,  
+			NR_IRQS - (3 + NUM_ISA_INTERRUPTS));
 
 	DBG(" <- pSeries_init_early()\n");
 }
-- 
1.1.4.g0b63-dirty
