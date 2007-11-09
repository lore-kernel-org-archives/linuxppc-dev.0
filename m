Return-Path: <osstklei@de.ibm.com>
Received: from mtagate4.uk.ibm.com (mtagate4.uk.ibm.com [195.212.29.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B9514DDECF
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Nov 2007 00:35:10 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate4.uk.ibm.com (8.13.8/8.13.8) with ESMTP id lA9DZ58m087832
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Nov 2007 13:35:05 GMT
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
	[9.149.37.213])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.6) with
	ESMTP id lA9DZ4lM2515166
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Nov 2007 13:35:04 GMT
Received: from d06av03.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id lA9DYv3Z013540
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Nov 2007 13:34:57 GMT
From: Thomas Klein <osstklei@de.ibm.com>
To: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH] ehea: Add kdump support
Date: Fri, 9 Nov 2007 14:33:50 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200711091433.51259.osstklei@de.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Paul Mackerras <paulus@samba.org>, Marcus Eder <meder@de.ibm.com>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

To support ehea driver reloading in a kdump kernel the driver has to perform
firmware handle deregistrations when the original kernel crashes. As there's
currently no notifier chain for machine crashes this patch enables kdump support
in the ehea driver by bending the ppc_md.machine_crash_shutdown hook to its own
machine crash handler. The original machine_crash_shutdown() fn is called
afterwards. This works fine as long as the ehea driver is the only one which
does so. Problems may occur if other drivers do the same and unload regularly.
This patch enables 2.6.24-rc2 to use kdump with ehea and only puts a very
low risk on base kernel. In 2.6.24 we know ehea is the only user of this
mechanism. The next step for 2.6.25 would be to add a proper notifier chain.
The full solution might be that register_reboot_notifier() provides sth
like a SYS_CRASH action. Please apply.

Signed-off-by: Thomas Klein <tklein@de.ibm.com>

---
 drivers/net/ehea/ehea.h      |    2 +-
 drivers/net/ehea/ehea_main.c |   28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletions(-)

diff --git a/drivers/net/ehea/ehea.h b/drivers/net/ehea/ehea.h
index f78e5bf..5935899 100644
--- a/drivers/net/ehea/ehea.h
+++ b/drivers/net/ehea/ehea.h
@@ -40,7 +40,7 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"ehea"
-#define DRV_VERSION	"EHEA_0080"
+#define DRV_VERSION	"EHEA_0081"
 
 /* eHEA capability flags */
 #define DLPAR_PORT_ADD_REM 1
diff --git a/drivers/net/ehea/ehea_main.c b/drivers/net/ehea/ehea_main.c
index f0319f1..40a732e 100644
--- a/drivers/net/ehea/ehea_main.c
+++ b/drivers/net/ehea/ehea_main.c
@@ -37,6 +37,7 @@
 #include <linux/reboot.h>
 
 #include <net/ip.h>
+#include <asm-powerpc/machdep.h>
 
 #include "ehea.h"
 #include "ehea_qmr.h"
@@ -98,6 +99,7 @@ static int port_name_cnt = 0;
 static LIST_HEAD(adapter_list);
 u64 ehea_driver_flags = 0;
 struct work_struct ehea_rereg_mr_task;
+static void (*orig_machine_crash_shutdown)(struct pt_regs *regs);
 
 struct semaphore dlpar_mem_lock;
 
@@ -3312,6 +3314,29 @@ static struct notifier_block ehea_reboot_nb = {
         .notifier_call = ehea_reboot_notifier,
 };
 
+void ehea_crash_notifier(struct pt_regs *regs)
+{
+	ehea_info("Machine crash: freeing all eHEA resources");
+	ibmebus_unregister_driver(&ehea_driver);
+	orig_machine_crash_shutdown(regs);
+}
+
+void ehea_register_crash_notifier(void)
+{
+#ifdef CONFIG_KEXEC
+	orig_machine_crash_shutdown =
+               (void*)__xchg_u64((unsigned long*)&ppc_md.machine_crash_shutdown,
+				 (unsigned long)ehea_crash_notifier);
+#endif
+}
+
+void ehea_unregister_crash_notifier(void)
+{
+#ifdef CONFIG_KEXEC
+	ppc_md.machine_crash_shutdown = orig_machine_crash_shutdown;
+#endif
+}
+
 static int check_module_parm(void)
 {
 	int ret = 0;
@@ -3369,6 +3394,7 @@ int __init ehea_module_init(void)
 		goto out;
 
 	register_reboot_notifier(&ehea_reboot_nb);
+	ehea_register_crash_notifier();
 
 	ret = ibmebus_register_driver(&ehea_driver);
 	if (ret) {
@@ -3382,6 +3408,7 @@ int __init ehea_module_init(void)
 		ehea_error("failed to register capabilities attribute, ret=%d",
 			   ret);
 		unregister_reboot_notifier(&ehea_reboot_nb);
+		ehea_unregister_crash_notifier();
 		ibmebus_unregister_driver(&ehea_driver);
 		goto out;
 	}
@@ -3396,6 +3423,7 @@ static void __exit ehea_module_exit(void)
 	driver_remove_file(&ehea_driver.driver, &driver_attr_capabilities);
 	ibmebus_unregister_driver(&ehea_driver);
 	unregister_reboot_notifier(&ehea_reboot_nb);
+	ehea_unregister_crash_notifier();
 	ehea_destroy_busmap();
 }
 
-- 
1.5.2
