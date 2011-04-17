Return-Path: <rjw@sisk.pl>
Received: from ogre.sisk.pl (ogre.sisk.pl [217.79.144.158])
	by ozlabs.org (Postfix) with ESMTP id 3C77A100851
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 18 Apr 2011 07:43:24 +1000 (EST)
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/14] PM: Add missing syscore_suspend() and syscore_resume()
	calls
Date: Sun, 17 Apr 2011 23:06:49 +0200
References: <201103280125.11750.rjw@sisk.pl> <201104172301.54115.rjw@sisk.pl>
In-Reply-To: <201104172301.54115.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201104172306.49462.rjw@sisk.pl>
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

Device suspend/resume infrastructure is used not only by the suspend
and hibernate code in kernel/power, but also by , APM, Xen and the
kexec jump feature.  However, commit 40dc166cb5dddbd36aa4ad11c03915ea
(PM / Core: Introduce struct syscore_ops for core subsystems PM)
failed to add syscore_suspend() and syscore_resume() calls to that
code, which generally leads to breakage when the features in question
are used.

To fix this problem, add the missing syscore_suspend() and
syscore_resume() calls to arch/x86/kernel/apm_32.c, kernel/kexec.c
and drivers/xen/manage.c.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/x86/kernel/apm_32.c |    5 +++++
 drivers/xen/manage.c     |    9 ++++++++-
 kernel/kexec.c           |    7 +++++++
 3 files changed, 20 insertions(+), 1 deletion(-)

Index: linux-2.6/kernel/kexec.c
===================================================================
--- linux-2.6.orig/kernel/kexec.c
+++ linux-2.6/kernel/kexec.c
@@ -33,6 +33,7 @@
 #include <linux/vmalloc.h>
 #include <linux/swap.h>
 #include <linux/kmsg_dump.h>
+#include <linux/syscore_ops.h>
 
 #include <asm/page.h>
 #include <asm/uaccess.h>
@@ -1532,6 +1533,11 @@ int kernel_kexec(void)
 		local_irq_disable();
 		/* Suspend system devices */
 		error = sysdev_suspend(PMSG_FREEZE);
+		if (!error) {
+			error = syscore_suspend();
+			if (error)
+				sysdev_resume();
+		}
 		if (error)
 			goto Enable_irqs;
 	} else
@@ -1546,6 +1552,7 @@ int kernel_kexec(void)
 
 #ifdef CONFIG_KEXEC_JUMP
 	if (kexec_image->preserve_context) {
+		syscore_resume();
 		sysdev_resume();
  Enable_irqs:
 		local_irq_enable();
Index: linux-2.6/drivers/xen/manage.c
===================================================================
--- linux-2.6.orig/drivers/xen/manage.c
+++ linux-2.6/drivers/xen/manage.c
@@ -8,6 +8,7 @@
 #include <linux/sysrq.h>
 #include <linux/stop_machine.h>
 #include <linux/freezer.h>
+#include <linux/syscore_ops.h>
 
 #include <xen/xen.h>
 #include <xen/xenbus.h>
@@ -70,8 +71,13 @@ static int xen_suspend(void *data)
 	BUG_ON(!irqs_disabled());
 
 	err = sysdev_suspend(PMSG_FREEZE);
+	if (!err) {
+		err = syscore_suspend();
+		if (err)
+			sysdev_resume();
+	}
 	if (err) {
-		printk(KERN_ERR "xen_suspend: sysdev_suspend failed: %d\n",
+		printk(KERN_ERR "xen_suspend: system core suspend failed: %d\n",
 			err);
 		return err;
 	}
@@ -95,6 +101,7 @@ static int xen_suspend(void *data)
 		xen_timer_resume();
 	}
 
+	syscore_resume();
 	sysdev_resume();
 
 	return 0;
Index: linux-2.6/arch/x86/kernel/apm_32.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/apm_32.c
+++ linux-2.6/arch/x86/kernel/apm_32.c
@@ -228,6 +228,7 @@
 #include <linux/kthread.h>
 #include <linux/jiffies.h>
 #include <linux/acpi.h>
+#include <linux/syscore_ops.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -1238,6 +1239,7 @@ static int suspend(int vetoable)
 
 	local_irq_disable();
 	sysdev_suspend(PMSG_SUSPEND);
+	syscore_suspend();
 
 	local_irq_enable();
 
@@ -1255,6 +1257,7 @@ static int suspend(int vetoable)
 		apm_error("suspend", err);
 	err = (err == APM_SUCCESS) ? 0 : -EIO;
 
+	syscore_resume();
 	sysdev_resume();
 	local_irq_enable();
 
@@ -1280,6 +1283,7 @@ static void standby(void)
 
 	local_irq_disable();
 	sysdev_suspend(PMSG_SUSPEND);
+	syscore_suspend();
 	local_irq_enable();
 
 	err = set_system_power_state(APM_STATE_STANDBY);
@@ -1287,6 +1291,7 @@ static void standby(void)
 		apm_error("standby", err);
 
 	local_irq_disable();
+	syscore_resume();
 	sysdev_resume();
 	local_irq_enable();
 
