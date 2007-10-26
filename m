Return-Path: <ossthema@de.ibm.com>
Received: from mtagate7.de.ibm.com (mtagate7.de.ibm.com [195.212.29.156])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 715FEDDD0D
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Oct 2007 22:37:36 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate7.de.ibm.com (8.13.8/8.13.8) with ESMTP id l9QCbUZR442632
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Oct 2007 12:37:30 GMT
Received: from d12av01.megacenter.de.ibm.com (d12av01.megacenter.de.ibm.com
	[9.149.165.212])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id l9QCbTfj2339066
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Oct 2007 14:37:29 +0200
Received: from d12av01.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av01.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l9QCbTit009652
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Oct 2007 14:37:29 +0200
From: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: [PATCH] ehea: add kexec support
Date: Fri, 26 Oct 2007 14:37:28 +0200
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200710261437.29117.ossthema@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>, Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

eHEA resources that are allocated via H_CALLs have a unique identifier each.
These identifiers are necessary to free the resources. A reboot notifier
is used to free all eHEA resources before the indentifiers get lost, i.e
before kexec starts a new kernel.

Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>

---
 drivers/net/ehea/ehea.h      |    2 +-
 drivers/net/ehea/ehea_main.c |   21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/drivers/net/ehea/ehea.h b/drivers/net/ehea/ehea.h
index 4b4b74e..f78e5bf 100644
--- a/drivers/net/ehea/ehea.h
+++ b/drivers/net/ehea/ehea.h
@@ -40,7 +40,7 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"ehea"
-#define DRV_VERSION	"EHEA_0079"
+#define DRV_VERSION	"EHEA_0080"
 
 /* eHEA capability flags */
 #define DLPAR_PORT_ADD_REM 1
diff --git a/drivers/net/ehea/ehea_main.c b/drivers/net/ehea/ehea_main.c
index 0a7e789..f0319f1 100644
--- a/drivers/net/ehea/ehea_main.c
+++ b/drivers/net/ehea/ehea_main.c
@@ -33,6 +33,9 @@
 #include <linux/if.h>
 #include <linux/list.h>
 #include <linux/if_ether.h>
+#include <linux/notifier.h>
+#include <linux/reboot.h>
+
 #include <net/ip.h>
 
 #include "ehea.h"
@@ -3295,6 +3298,20 @@ static int __devexit ehea_remove(struct of_device *dev)
 	return 0;
 }
 
+static int ehea_reboot_notifier(struct notifier_block *nb,
+				unsigned long action, void *unused)
+{
+	if (action == SYS_RESTART) {
+		ehea_info("Reboot: freeing all eHEA resources");
+		ibmebus_unregister_driver(&ehea_driver);
+	}
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block ehea_reboot_nb = {
+        .notifier_call = ehea_reboot_notifier,
+};
+
 static int check_module_parm(void)
 {
 	int ret = 0;
@@ -3351,6 +3368,8 @@ int __init ehea_module_init(void)
 	if (ret)
 		goto out;
 
+	register_reboot_notifier(&ehea_reboot_nb);
+
 	ret = ibmebus_register_driver(&ehea_driver);
 	if (ret) {
 		ehea_error("failed registering eHEA device driver on ebus");
@@ -3362,6 +3381,7 @@ int __init ehea_module_init(void)
 	if (ret) {
 		ehea_error("failed to register capabilities attribute, ret=%d",
 			   ret);
+		unregister_reboot_notifier(&ehea_reboot_nb);
 		ibmebus_unregister_driver(&ehea_driver);
 		goto out;
 	}
@@ -3375,6 +3395,7 @@ static void __exit ehea_module_exit(void)
 	flush_scheduled_work();
 	driver_remove_file(&ehea_driver.driver, &driver_attr_capabilities);
 	ibmebus_unregister_driver(&ehea_driver);
+	unregister_reboot_notifier(&ehea_reboot_nb);
 	ehea_destroy_busmap();
 }
 
-- 
1.5.2
