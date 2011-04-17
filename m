Return-Path: <rjw@sisk.pl>
Received: from ogre.sisk.pl (ogre.sisk.pl [217.79.144.158])
	by ozlabs.org (Postfix) with ESMTP id A4AC6B6F65
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 18 Apr 2011 07:43:20 +1000 (EST)
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 12/14] PM / UNICORE32: Use struct syscore_ops instead of
	sysdevs for PM
Date: Sun, 17 Apr 2011 23:13:45 +0200
References: <201103280125.11750.rjw@sisk.pl> <201104172301.54115.rjw@sisk.pl>
In-Reply-To: <201104172301.54115.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201104172313.45854.rjw@sisk.pl>
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

Make some UNICORE32 architecture's code use struct syscore_ops
objects for power management instead of sysdev classes and sysdevs.

This simplifies the code and reduces the kernel's memory footprint.
It also is necessary for removing sysdevs from the kernel entirely in
the future.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/unicore32/kernel/irq.c |   23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

Index: linux-2.6/arch/unicore32/kernel/irq.c
===================================================================
--- linux-2.6.orig/arch/unicore32/kernel/irq.c
+++ linux-2.6/arch/unicore32/kernel/irq.c
@@ -23,7 +23,7 @@
 #include <linux/list.h>
 #include <linux/kallsyms.h>
 #include <linux/proc_fs.h>
-#include <linux/sysdev.h>
+#include <linux/syscore_ops.h>
 #include <linux/gpio.h>
 
 #include <asm/system.h>
@@ -237,7 +237,7 @@ static struct puv3_irq_state {
 	unsigned int	iccr;
 } puv3_irq_state;
 
-static int puv3_irq_suspend(struct sys_device *dev, pm_message_t state)
+static int puv3_irq_suspend(void)
 {
 	struct puv3_irq_state *st = &puv3_irq_state;
 
@@ -265,7 +265,7 @@ static int puv3_irq_suspend(struct sys_d
 	return 0;
 }
 
-static int puv3_irq_resume(struct sys_device *dev)
+static void puv3_irq_resume(void)
 {
 	struct puv3_irq_state *st = &puv3_irq_state;
 
@@ -278,27 +278,20 @@ static int puv3_irq_resume(struct sys_de
 
 		writel(st->icmr, INTC_ICMR);
 	}
-	return 0;
 }
 
-static struct sysdev_class puv3_irq_sysclass = {
-	.name		= "pkunity-irq",
+static struct syscore_ops puv3_irq_syscore_ops = {
 	.suspend	= puv3_irq_suspend,
 	.resume		= puv3_irq_resume,
 };
 
-static struct sys_device puv3_irq_device = {
-	.id		= 0,
-	.cls		= &puv3_irq_sysclass,
-};
-
-static int __init puv3_irq_init_devicefs(void)
+static int __init puv3_irq_init_syscore(void)
 {
-	sysdev_class_register(&puv3_irq_sysclass);
-	return sysdev_register(&puv3_irq_device);
+	register_syscore_ops(&puv3_irq_syscore_ops);
+	return 0;
 }
 
-device_initcall(puv3_irq_init_devicefs);
+device_initcall(puv3_irq_init_syscore);
 
 void __init init_IRQ(void)
 {
