Return-Path: <mostrows@watson.ibm.com>
Received: from igw2.watson.ibm.com (igw2.watson.ibm.com [129.34.20.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5F7B067B18
	for <linuxppc-dev@ozlabs.org>; Tue, 30 May 2006 06:42:13 +1000 (EST)
Received: from sp1n293en1.watson.ibm.com (sp1n293en1.watson.ibm.com
	[129.34.20.41])
	by igw2.watson.ibm.com (8.12.11.20060308/8.13.1/8.13.1-2005-04-25 igw)
	with ESMTP id k4TKggud014928
	for <linuxppc-dev@ozlabs.org>; Mon, 29 May 2006 16:42:42 -0400
Received: from sp1n293en1.watson.ibm.com (localhost [127.0.0.1])
	by sp1n293en1.watson.ibm.com (8.11.7-20030924/8.11.7/01-14-2004_2) with
	ESMTP id k4TKg8D254666
	for <linuxppc-dev@ozlabs.org>; Mon, 29 May 2006 16:42:09 -0400
Received: from mgsmtp00.watson.ibm.com (mgsmtp00.watson.ibm.com [9.2.40.58])
	by sp1n293en1.watson.ibm.com (8.11.7-20030924/8.11.7/01-14-2004_1) with
	ESMTP id k4TKg8k389780
	for <linuxppc-dev@ozlabs.org>; Mon, 29 May 2006 16:42:08 -0400
Received: from kitch0.watson.ibm.com (kitch0.watson.ibm.com [9.2.224.107])
	by mgsmtp00.watson.ibm.com (8.12.11/8.12.11/2005/09/01) with ESMTP id
	k4TLZrd4002616
	for <linuxppc-dev@ozlabs.org>; Mon, 29 May 2006 17:35:53 -0400
Subject: [PATCH 8/8] Kill the ppc64_interrupt_controller global symbol.
In-Reply-To: <1148935262.25048.31.camel@brick>
Date: Mon, 29 May 2006 16:42:06 -0400
Message-Id: <1148935326179-git-send-email-mostrows@watson.ibm.com>
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

--
Signed-off-by: Michal Ostrowski <mostrows@watson.ibm.com>

---

 arch/powerpc/kernel/irq.c               |    1 -
 arch/powerpc/kernel/setup_64.c          |    2 --
 arch/powerpc/platforms/cell/setup.c     |    2 --
 arch/powerpc/platforms/iseries/setup.c  |    2 --
 arch/powerpc/platforms/maple/setup.c    |    3 ---
 arch/powerpc/platforms/powermac/setup.c |    3 ---
 arch/powerpc/platforms/pseries/setup.c  |   15 +++++++++++----
 include/asm-powerpc/irq.h               |   11 -----------
 8 files changed, 11 insertions(+), 28 deletions(-)

5a0403834813838657ce9a3b762203f6479f36fa
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index efcb859..bee60d5 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -89,7 +89,6 @@ extern atomic_t ipi_sent;
 EXPORT_SYMBOL(irq_desc);
 
 int distribute_irqs = 1;
-u64 ppc64_interrupt_controller;
 #endif /* CONFIG_PPC64 */
 
 int show_interrupts(struct seq_file *p, void *v)
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 4669179..f791bcc 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -445,8 +445,6 @@ void __init setup_system(void)
 
 	printk("-----------------------------------------------------\n");
 	printk("ppc64_pft_size                = 0x%lx\n", ppc64_pft_size);
-	printk("ppc64_interrupt_controller    = 0x%ld\n",
-	       ppc64_interrupt_controller);
 	printk("physicalMemorySize            = 0x%lx\n", lmb_phys_mem_size());
 	printk("ppc64_caches.dcache_line_size = 0x%x\n",
 	       ppc64_caches.dline_size);
diff --git a/arch/powerpc/platforms/cell/setup.c b/arch/powerpc/platforms/cell/setup.c
index 6574b22..e1cf54e 100644
--- a/arch/powerpc/platforms/cell/setup.c
+++ b/arch/powerpc/platforms/cell/setup.c
@@ -117,8 +117,6 @@ static void __init cell_init_early(void)
 
 	cell_init_iommu();
 
-	ppc64_interrupt_controller = IC_CELL_PIC;
-
 	DBG(" <- cell_init_early()\n");
 }
 
diff --git a/arch/powerpc/platforms/iseries/setup.c b/arch/powerpc/platforms/iseries/setup.c
index 6a7d04b..ca623c5 100644
--- a/arch/powerpc/platforms/iseries/setup.c
+++ b/arch/powerpc/platforms/iseries/setup.c
@@ -303,8 +303,6 @@ static void __init iSeries_init_early(vo
 {
 	DBG(" -> iSeries_init_early()\n");
 
-	ppc64_interrupt_controller = IC_ISERIES;
-
 #if defined(CONFIG_BLK_DEV_INITRD)
 	/*
 	 * If the init RAM disk has been configured and there is
diff --git a/arch/powerpc/platforms/maple/setup.c b/arch/powerpc/platforms/maple/setup.c
index 24c0aef..592972c 100644
--- a/arch/powerpc/platforms/maple/setup.c
+++ b/arch/powerpc/platforms/maple/setup.c
@@ -204,9 +204,6 @@ static void __init maple_init_early(void
 	 */
 	hpte_init_native();
 
-	/* Setup interrupt mapping options */
-	ppc64_interrupt_controller = IC_OPEN_PIC;
-
 	iommu_init_early_dart();
 
 	DBG(" <- maple_init_early\n");
diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index 4d15e39..2b2dc75 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -609,9 +609,6 @@ static void __init pmac_init_early(void)
 	udbg_adb_init(!!strstr(cmd_line, "btextdbg"));
 
 #ifdef CONFIG_PPC64
-	/* Setup interrupt mapping options */
-	ppc64_interrupt_controller = IC_OPEN_PIC;
-
 	iommu_init_early_dart();
 #endif
 }
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 551da6a..a85b810 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -83,7 +83,15 @@ int fwnmi_active;  /* TRUE if an FWNMI h
 
 static void pseries_shared_idle_sleep(void);
 static void pseries_dedicated_idle_sleep(void);
-static  int pSeries_discover_pic(void);
+
+/*
+ * List of interrupt controller identifiers; possible return values from
+ * pSeries_discover_pic().
+ */
+#define IC_INVALID    0
+#define IC_OPEN_PIC   1
+#define IC_PPC_XIC    2
+static int pSeries_discover_pic(void);
 
 struct mpic *pSeries_mpic;
 
@@ -200,9 +208,7 @@ static void pseries_lpar_enable_pmcs(voi
 static void __init pSeries_setup_arch(void)
 {
 	int int_ctrl = pSeries_discover_pic();
-	ppc64_interrupt_controller = int_ctrl;
 
-	
 	/* Fixup ppc_md depending on the type of interrupt controller */
 	switch (int_ctrl) {
 	case IC_OPEN_PIC:
@@ -279,7 +285,8 @@ static int __init pSeries_init_panel(voi
 }
 arch_initcall(pSeries_init_panel);
 
-static  int __init pSeries_discover_pic(void)
+
+static int __init pSeries_discover_pic(void)
 {
 	struct device_node *np;
 	char *typep;
diff --git a/include/asm-powerpc/irq.h b/include/asm-powerpc/irq.h
index f2adbc0..66cfeab 100644
--- a/include/asm-powerpc/irq.h
+++ b/include/asm-powerpc/irq.h
@@ -88,17 +88,6 @@ static inline unsigned int virt_irq_to_r
 
 extern unsigned int real_irq_to_virt_slowpath(unsigned int real_irq);
 
-/*
- * List of interrupt controllers.
- */
-#define IC_INVALID    0
-#define IC_OPEN_PIC   1
-#define IC_PPC_XIC    2
-#define IC_CELL_PIC   3
-#define IC_ISERIES    4
-
-extern u64 ppc64_interrupt_controller;
-
 #else /* 32-bit */
 
 #if defined(CONFIG_40x)
-- 
1.1.4.g0b63-dirty
