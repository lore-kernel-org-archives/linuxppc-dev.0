Return-Path: <arnd@arndb.de>
Message-Id: <20080612092511.569422083@arndb.de>
References: <20080612091433.851620325@arndb.de>
Date: Thu, 12 Jun 2008 11:14:36 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: [patch 3/3] powerpc/cell: disable ptcal in case of crash kdump
Cc: Michael Neuling <mikey@neuling.org>, Jeremy Kerr <jk@ozlabs.org>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We need to disable ptcal before starting a new kernel
after a crash, in order to avoid overwriting data
in the kdump kernel.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/platforms/cell/ras.c |   22 ++++++++++++++++++----
 1 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/cell/ras.c b/arch/powerpc/platforms/cell/ras.c
index 655704a..505f9b9 100644
--- a/arch/powerpc/platforms/cell/ras.c
+++ b/arch/powerpc/platforms/cell/ras.c
@@ -17,6 +17,7 @@
 #include <asm/reg.h>
 #include <asm/io.h>
 #include <asm/prom.h>
+#include <asm/kexec.h>
 #include <asm/machdep.h>
 #include <asm/rtas.h>
 #include <asm/cell-regs.h>
@@ -226,6 +227,11 @@ static int cbe_ptcal_notify_reboot(struct notifier_block *nb,
 	return cbe_ptcal_disable();
 }
 
+static void cbe_ptcal_crash_shutdown(void)
+{
+	cbe_ptcal_disable();
+}
+
 static struct notifier_block cbe_ptcal_reboot_notifier = {
 	.notifier_call = cbe_ptcal_notify_reboot
 };
@@ -241,12 +247,20 @@ int __init cbe_ptcal_init(void)
 		return -ENODEV;
 
 	ret = register_reboot_notifier(&cbe_ptcal_reboot_notifier);
-	if (ret) {
-		printk(KERN_ERR "Can't disable PTCAL, so not enabling\n");
-		return ret;
-	}
+	if (ret)
+		goto out1;
+
+	ret = crash_shutdown_register(&cbe_ptcal_crash_shutdown);
+	if (ret)
+		goto out2;
 
 	return cbe_ptcal_enable();
+
+out2:
+	unregister_reboot_notifier(&cbe_ptcal_reboot_notifier);
+out1:
+	printk(KERN_ERR "Can't disable PTCAL, so not enabling\n");
+	return ret;
 }
 
 arch_initcall(cbe_ptcal_init);
-- 
1.5.4.3

-- 
