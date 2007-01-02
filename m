Return-Path: <tnt@246tNt.com>
Received: from outmx020.isp.belgacom.be (outmx020.isp.belgacom.be
	[195.238.4.201])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E1D95DDF5B
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Jan 2007 09:32:08 +1100 (EST)
Received: from outmx020.isp.belgacom.be (localhost [127.0.0.1])
	by outmx020.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l02MVuGx002695
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Jan 2007 23:31:57 +0100
	(envelope-from <tnt@246tNt.com>)
From: Sylvain Munaut <tnt@246tNt.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 3/4] powerpc: Use common 52xx of_platform probe code for EFIKA
Date: Tue,  2 Jan 2007 23:29:54 +0100
Message-Id: <11677769981995-git-send-email-tnt@246tNt.com>
In-Reply-To: <11677769982640-git-send-email-tnt@246tNt.com>
References: <1167776995690-git-send-email-tnt@246tNt.com>
	<116777699771-git-send-email-tnt@246tNt.com>
	<11677769982640-git-send-email-tnt@246tNt.com>
Cc: Linux PPC DEV <linuxppc-dev@ozlabs.org>, Sylvain Munaut <tnt@246tNt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Now that the device tree has the good properties, we can
remove all the efika_init code by a single call to common code.

While we're modifying that file, a few whitespaces/alignement/typo
fixes are made (nothing significant).

Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
---
 arch/powerpc/platforms/52xx/efika-setup.c |   64 ++++++++---------------------
 1 files changed, 18 insertions(+), 46 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/efika-setup.c b/arch/powerpc/platforms/52xx/efika-setup.c
index 110c980..d61ce84 100644
--- a/arch/powerpc/platforms/52xx/efika-setup.c
+++ b/arch/powerpc/platforms/52xx/efika-setup.c
@@ -2,7 +2,7 @@
  *
  * Efika 5K2 platform setup
  * Some code really inspired from the lite5200b platform.
- * 
+ *
  * Copyright (C) 2006 bplan GmbH
  *
  * This file is licensed under the terms of the GNU General Public License
@@ -81,35 +81,7 @@ #endif
 	efika_pcisetup();
 
 	if (ppc_md.progress)
-		ppc_md.progress("Linux/PPC " UTS_RELEASE " runnung on Efika ;-)\n", 0x0);
-}
-
-static void __init efika_init(void)
-{
-	struct device_node *np;
-	struct device_node *cnp = NULL;
-	const u32 *base;
-
-	/* Find every child of the SOC node and add it to of_platform */
-	np = of_find_node_by_name(NULL, "builtin");
-	if (np) {
-		char name[BUS_ID_SIZE];
-		while ((cnp = of_get_next_child(np, cnp))) {
-			strcpy(name, cnp->name);
-
-			base = get_property(cnp, "reg", NULL);
-			if (base == NULL)
-				continue;
-
-			snprintf(name+strlen(name), BUS_ID_SIZE, "@%x", *base);
-			of_platform_device_create(cnp, name, NULL);
-
-			printk(KERN_INFO EFIKA_PLATFORM_NAME" : Added %s (type '%s' at '%s') to the known devices\n", name, cnp->type, cnp->full_name);
-		}
-	}
-
-	if (ppc_md.progress)
-		ppc_md.progress("  Have fun with your Efika!    ", 0x7777);
+		ppc_md.progress("Linux/PPC " UTS_RELEASE " running on Efika ;-)\n", 0x0);
 }
 
 static int __init efika_probe(void)
@@ -131,20 +103,20 @@ static int __init efika_probe(void)
 
 define_machine(efika)
 {
-	.name = EFIKA_PLATFORM_NAME,
-	.probe = efika_probe,
-	.setup_arch = efika_setup_arch,
-	.init = efika_init,
-	.show_cpuinfo = efika_show_cpuinfo,
-	.init_IRQ = mpc52xx_init_irq,
-	.get_irq = mpc52xx_get_irq,
-	.restart = rtas_restart,
-	.power_off = rtas_power_off,
-	.halt = rtas_halt,
-	.set_rtc_time = rtas_set_rtc_time,
-	.get_rtc_time = rtas_get_rtc_time,
-	.progress = rtas_progress,
-	.get_boot_time = rtas_get_boot_time,
-	.calibrate_decr = generic_calibrate_decr,
-	.phys_mem_access_prot = pci_phys_mem_access_prot,
+	.name			= EFIKA_PLATFORM_NAME,
+	.probe			= efika_probe,
+	.setup_arch		= efika_setup_arch,
+	.init			= mpc52xx_declare_of_platform_devices,
+	.show_cpuinfo		= efika_show_cpuinfo,
+	.init_IRQ		= mpc52xx_init_irq,
+	.get_irq		= mpc52xx_get_irq,
+	.restart		= rtas_restart,
+	.power_off		= rtas_power_off,
+	.halt			= rtas_halt,
+	.set_rtc_time		= rtas_set_rtc_time,
+	.get_rtc_time		= rtas_get_rtc_time,
+	.progress		= rtas_progress,
+	.get_boot_time		= rtas_get_boot_time,
+	.calibrate_decr		= generic_calibrate_decr,
+	.phys_mem_access_prot	= pci_phys_mem_access_prot,
 };
-- 
1.4.2
