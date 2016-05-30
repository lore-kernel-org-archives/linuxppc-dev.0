Return-Path: <rashmicy@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJ5zL07F1zDqBs
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 16:18:38 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id x1so4002491pav.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 May 2016 23:18:37 -0700 (PDT)
From: Rashmica Gupta <rashmicy@gmail.com>
To: mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
 nfont@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/5] powerpc/pseries: Drop support for MPIC in pseries
Date: Mon, 30 May 2016 16:18:11 +1000
Message-Id: <1464589095-442-1-git-send-email-rashmicy@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

MPIC was only used by Power3 which is now unsupported, so drop support
for MPIC. XICS is now the only supported interrupt controller for
pSeries so make the XICS functions generic.

Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>
---
 arch/powerpc/platforms/pseries/setup.c | 77 +++-------------------------------
 1 file changed, 5 insertions(+), 72 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 9883bc7ea007..f83ac9be7f34 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -57,7 +57,6 @@
 #include <asm/time.h>
 #include <asm/nvram.h>
 #include <asm/pmc.h>
-#include <asm/mpic.h>
 #include <asm/xics.h>
 #include <asm/ppc-pci.h>
 #include <asm/i8259.h>
@@ -77,8 +76,6 @@ EXPORT_SYMBOL(CMO_PageSize);
 
 int fwnmi_active;  /* TRUE if an FWNMI handler is present */
 
-static struct device_node *pSeries_mpic_node;
-
 static void pSeries_show_cpuinfo(struct seq_file *m)
 {
 	struct device_node *root;
@@ -172,48 +169,7 @@ static void __init pseries_setup_i8259_cascade(void)
 	irq_set_chained_handler(cascade, pseries_8259_cascade);
 }
 
-static void __init pseries_mpic_init_IRQ(void)
-{
-	struct device_node *np;
-	const unsigned int *opprop;
-	unsigned long openpic_addr = 0;
-	int naddr, n, i, opplen;
-	struct mpic *mpic;
-
-	np = of_find_node_by_path("/");
-	naddr = of_n_addr_cells(np);
-	opprop = of_get_property(np, "platform-open-pic", &opplen);
-	if (opprop != NULL) {
-		openpic_addr = of_read_number(opprop, naddr);
-		printk(KERN_DEBUG "OpenPIC addr: %lx\n", openpic_addr);
-	}
-	of_node_put(np);
-
-	BUG_ON(openpic_addr == 0);
-
-	/* Setup the openpic driver */
-	mpic = mpic_alloc(pSeries_mpic_node, openpic_addr,
-			MPIC_NO_RESET, 16, 0, " MPIC     ");
-	BUG_ON(mpic == NULL);
-
-	/* Add ISUs */
-	opplen /= sizeof(u32);
-	for (n = 0, i = naddr; i < opplen; i += naddr, n++) {
-		unsigned long isuaddr = of_read_number(opprop + i, naddr);
-		mpic_assign_isu(mpic, n, isuaddr);
-	}
-
-	/* Setup top-level get_irq */
-	ppc_md.get_irq = mpic_get_irq;
-
-	/* All ISUs are setup, complete initialization */
-	mpic_init(mpic);
-
-	/* Look for cascade */
-	pseries_setup_i8259_cascade();
-}
-
-static void __init pseries_xics_init_IRQ(void)
+static void __init pSeries_init_IRQ(void)
 {
 	xics_init();
 	pseries_setup_i8259_cascade();
@@ -228,32 +184,6 @@ static void pseries_lpar_enable_pmcs(void)
 	plpar_hcall_norets(H_PERFMON, set, reset);
 }
 
-static void __init pseries_discover_pic(void)
-{
-	struct device_node *np;
-	const char *typep;
-
-	for_each_node_by_name(np, "interrupt-controller") {
-		typep = of_get_property(np, "compatible", NULL);
-		if (!typep)
-			continue;
-		if (strstr(typep, "open-pic")) {
-			pSeries_mpic_node = of_node_get(np);
-			ppc_md.init_IRQ       = pseries_mpic_init_IRQ;
-			setup_kexec_cpu_down_mpic();
-			smp_init_pseries_mpic();
-			return;
-		} else if (strstr(typep, "ppc-xicp")) {
-			ppc_md.init_IRQ       = pseries_xics_init_IRQ;
-			setup_kexec_cpu_down_xics();
-			smp_init_pseries_xics();
-			return;
-		}
-	}
-	printk(KERN_ERR "pSeries_discover_pic: failed to recognize"
-	       " interrupt-controller\n");
-}
-
 static int pci_dn_reconfig_notifier(struct notifier_block *nb, unsigned long action, void *data)
 {
 	struct of_reconfig_data *rd = data;
@@ -506,7 +436,9 @@ static void __init pSeries_setup_arch(void)
 	set_arch_panic_timeout(10, ARCH_PANIC_TIMEOUT);
 
 	/* Discover PIC type and setup ppc_md accordingly */
-	pseries_discover_pic();
+	setup_kexec_cpu_down_xics();
+	smp_init_pseries_xics();
+
 
 	/* openpic global configuration register (64-bit format). */
 	/* openpic Interrupt Source Unit pointer (64-bit format). */
@@ -838,6 +770,7 @@ define_machine(pseries) {
 	.probe			= pSeries_probe,
 	.setup_arch		= pSeries_setup_arch,
 	.init_early		= pSeries_init_early,
+	.init_IRQ		= pSeries_init_IRQ,
 	.show_cpuinfo		= pSeries_show_cpuinfo,
 	.log_error		= pSeries_log_error,
 	.pcibios_fixup		= pSeries_final_fixup,
-- 
2.5.0
