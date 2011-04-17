Return-Path: <rjw@sisk.pl>
Received: from ogre.sisk.pl (ogre.sisk.pl [217.79.144.158])
	by ozlabs.org (Postfix) with ESMTP id 200C2100820
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 18 Apr 2011 07:43:23 +1000 (EST)
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 9/14] PM / Blackfin: Use struct syscore_ops instead of sysdevs
	for PM
Date: Sun, 17 Apr 2011 23:11:58 +0200
References: <201103280125.11750.rjw@sisk.pl> <201104172301.54115.rjw@sisk.pl>
In-Reply-To: <201104172301.54115.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201104172311.59289.rjw@sisk.pl>
Cc: Kevin Hilman <khilman@ti.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
	Russell King <linux@arm.linux.org.uk>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Greg KH <gregkh@suse.de>, Ralf Baechle <ralf@linux-mips.org>,
	Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>,
	Ben Dooks <ben-linux@fluff.org>, Jiri Kosina <jkosina@suse.cz>,
	Kay Sievers <kay.sievers@suse.de>, Mike Frysinger <vapier@gentoo.org>,
	Linux PM mailing list <linux-pm@lists.linux-foundation.org>,
	linux-omap@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Rafael J. Wysocki <rjw@sisk.pl>

Convert some Blackfin architecture's code to using struct syscore_ops
objects for power management instead of sysdev classes and sysdevs.

This simplifies the code and reduces the kernel's memory footprint.
It also is necessary for removing sysdevs from the kernel entirely in
the future.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/blackfin/kernel/nmi.c |   30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

Index: linux-2.6/arch/blackfin/kernel/nmi.c
===================================================================
--- linux-2.6.orig/arch/blackfin/kernel/nmi.c
+++ linux-2.6/arch/blackfin/kernel/nmi.c
@@ -12,7 +12,7 @@
 
 #include <linux/bitops.h>
 #include <linux/hardirq.h>
-#include <linux/sysdev.h>
+#include <linux/syscore_ops.h>
 #include <linux/pm.h>
 #include <linux/nmi.h>
 #include <linux/smp.h>
@@ -196,43 +196,31 @@ void touch_nmi_watchdog(void)
 
 /* Suspend/resume support */
 #ifdef CONFIG_PM
-static int nmi_wdt_suspend(struct sys_device *dev, pm_message_t state)
+static int nmi_wdt_suspend(void)
 {
 	nmi_wdt_stop();
 	return 0;
 }
 
-static int nmi_wdt_resume(struct sys_device *dev)
+static void nmi_wdt_resume(void)
 {
 	if (nmi_active)
 		nmi_wdt_start();
-	return 0;
 }
 
-static struct sysdev_class nmi_sysclass = {
-	.name		= DRV_NAME,
+static struct syscore_ops nmi_syscore_ops = {
 	.resume		= nmi_wdt_resume,
 	.suspend	= nmi_wdt_suspend,
 };
 
-static struct sys_device device_nmi_wdt = {
-	.id	= 0,
-	.cls	= &nmi_sysclass,
-};
-
-static int __init init_nmi_wdt_sysfs(void)
+static int __init init_nmi_wdt_syscore(void)
 {
-	int error;
-
-	if (!nmi_active)
-		return 0;
+	if (nmi_active)
+		register_syscore_ops(&nmi_syscore_ops);
 
-	error = sysdev_class_register(&nmi_sysclass);
-	if (!error)
-		error = sysdev_register(&device_nmi_wdt);
-	return error;
+	return 0;
 }
-late_initcall(init_nmi_wdt_sysfs);
+late_initcall(init_nmi_wdt_syscore);
 
 #endif	/* CONFIG_PM */
 
