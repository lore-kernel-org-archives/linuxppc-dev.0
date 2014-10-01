Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5021D1A17F5
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 23:28:22 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 19/20] powerpc/pseries: Use pm_power_off rather than
 ppc_md.power_off
Date: Wed,  1 Oct 2014 15:28:05 +0200
Message-Id: <1412170086-57971-20-git-send-email-agraf@suse.de>
In-Reply-To: <1412170086-57971-1-git-send-email-agraf@suse.de>
References: <1412170086-57971-1-git-send-email-agraf@suse.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Geoff Levand <geoff@infradead.org>,
 Alistair Popple <alistair@popple.id.au>, Scott Wood <scottwood@freescale.com>,
 Anatolij Gustschin <agust@denx.de>
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
 arch/powerpc/platforms/pseries/setup.c | 59 +++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index e724d31..981e9ee 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -460,6 +460,34 @@ static long pseries_little_endian_exceptions(void)
 }
 #endif
 
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
 static void __init pSeries_setup_arch(void)
 {
 	set_arch_panic_timeout(10, ARCH_PANIC_TIMEOUT);
@@ -504,6 +532,8 @@ static void __init pSeries_setup_arch(void)
 				"%ld\n", rc);
 		}
 	}
+
+	pm_power_off = pSeries_power_off;
 }
 
 static int __init pSeries_init_panel(void)
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
