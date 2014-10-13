Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4869E1A06FF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Oct 2014 01:01:43 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 19/20] powerpc/pseries: Use pm_power_off rather than
 ppc_md.power_off
Date: Mon, 13 Oct 2014 16:01:27 +0200
Message-Id: <1413208888-49211-20-git-send-email-agraf@suse.de>
In-Reply-To: <1413208888-49211-1-git-send-email-agraf@suse.de>
References: <1413208888-49211-1-git-send-email-agraf@suse.de>
Cc: arnd@arndb.de, geoff@infradead.org, alistair@popple.id.au,
 scottwood@freescale.com, agust@denx.de, linux@roeck-us.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The generic power off callback is pm_power_off. Use that one rather than
the powerpc specific ppc_md.power_off.

Signed-off-by: Alexander Graf <agraf@suse.de>

---

v1 -> v2:

  - write pm_power_off in probe function
---
 arch/powerpc/platforms/pseries/setup.c | 59 +++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 125c589..9ce1cf0 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -659,6 +659,34 @@ static void __init pSeries_init_early(void)
 	pr_debug(" <- pSeries_init_early()\n");
 }
 
+/**
+ * pSeries_power_off - tell firmware about how to power off the system.
+ *
+ * This function calls either the power-off rtas token in normal cases
+ * or the ibm,power-off-ups token (if present & requested) in case of
+ * a power failure. If power-off token is used, power on will only be
+ * possible with power button press. If ibm,power-off-ups token is used
+ * it will allow auto poweron after power is restored.
+ */
+static void pSeries_power_off(void)
+{
+	int rc;
+	int rtas_poweroff_ups_token = rtas_token("ibm,power-off-ups");
+
+	if (rtas_flash_term_hook)
+		rtas_flash_term_hook(SYS_POWER_OFF);
+
+	if (rtas_poweron_auto == 0 ||
+		rtas_poweroff_ups_token == RTAS_UNKNOWN_SERVICE) {
+		rc = rtas_call(rtas_token("power-off"), 2, 1, NULL, -1, -1);
+		printk(KERN_INFO "RTAS power-off returned %d\n", rc);
+	} else {
+		rc = rtas_call(rtas_poweroff_ups_token, 0, 1, NULL);
+		printk(KERN_INFO "RTAS ibm,power-off-ups returned %d\n", rc);
+	}
+	for (;;);
+}
+
 /*
  * Called very early, MMU is off, device-tree isn't unflattened
  */
@@ -741,6 +769,8 @@ static int __init pSeries_probe(void)
 	else
 		hpte_init_native();
 
+	pm_power_off = pSeries_power_off;
+
 	pr_debug("Machine is%s LPAR !\n",
 	         (powerpc_firmware_features & FW_FEATURE_LPAR) ? "" : " not");
 
@@ -754,34 +784,6 @@ static int pSeries_pci_probe_mode(struct pci_bus *bus)
 	return PCI_PROBE_NORMAL;
 }
 
-/**
- * pSeries_power_off - tell firmware about how to power off the system.
- *
- * This function calls either the power-off rtas token in normal cases
- * or the ibm,power-off-ups token (if present & requested) in case of
- * a power failure. If power-off token is used, power on will only be
- * possible with power button press. If ibm,power-off-ups token is used
- * it will allow auto poweron after power is restored.
- */
-static void pSeries_power_off(void)
-{
-	int rc;
-	int rtas_poweroff_ups_token = rtas_token("ibm,power-off-ups");
-
-	if (rtas_flash_term_hook)
-		rtas_flash_term_hook(SYS_POWER_OFF);
-
-	if (rtas_poweron_auto == 0 ||
-		rtas_poweroff_ups_token == RTAS_UNKNOWN_SERVICE) {
-		rc = rtas_call(rtas_token("power-off"), 2, 1, NULL, -1, -1);
-		printk(KERN_INFO "RTAS power-off returned %d\n", rc);
-	} else {
-		rc = rtas_call(rtas_poweroff_ups_token, 0, 1, NULL);
-		printk(KERN_INFO "RTAS ibm,power-off-ups returned %d\n", rc);
-	}
-	for (;;);
-}
-
 #ifndef CONFIG_PCI
 void pSeries_final_fixup(void) { }
 #endif
@@ -796,7 +798,6 @@ define_machine(pseries) {
 	.pcibios_fixup		= pSeries_final_fixup,
 	.pci_probe_mode		= pSeries_pci_probe_mode,
 	.restart		= rtas_restart,
-	.power_off		= pSeries_power_off,
 	.halt			= rtas_halt,
 	.panic			= rtas_os_term,
 	.get_boot_time		= rtas_get_boot_time,
-- 
1.8.1.4
