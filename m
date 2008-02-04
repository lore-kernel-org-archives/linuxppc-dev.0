Return-Path: <ossthema@de.ibm.com>
Received: from mtagate6.de.ibm.com (mtagate6.de.ibm.com [195.212.29.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4F74DDDF3A
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Feb 2008 00:04:54 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate6.de.ibm.com (8.13.8/8.13.8) with ESMTP id m14D4ow0237418
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Feb 2008 13:04:50 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.7) with
	ESMTP id m14D4ohE2326668
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Feb 2008 14:04:50 +0100
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m14D4oTn015205
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Feb 2008 14:04:50 +0100
From: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: [PATCH 2/2] ehea: add memory remove hotplug support
Date: Mon, 4 Feb 2008 14:04:49 +0100
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200802041404.49960.ossthema@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add memory remove hotplug support

Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>

---
 Comment: This patch depends on the following patch that
 exports the symbols
  register_memory_notifier()
  unregister_memory_notifier()

 http://lkml.org/lkml/2008/2/1/293


 drivers/net/ehea/ehea_main.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/drivers/net/ehea/ehea_main.c b/drivers/net/ehea/ehea_main.c
index 21af674..b75afcc 100644
--- a/drivers/net/ehea/ehea_main.c
+++ b/drivers/net/ehea/ehea_main.c
@@ -35,6 +35,7 @@
 #include <linux/if_ether.h>
 #include <linux/notifier.h>
 #include <linux/reboot.h>
+#include <linux/memory.h>
 #include <asm/kexec.h>
 
 #include <net/ip.h>
@@ -3480,6 +3481,24 @@ void ehea_crash_handler(void)
 					      0, H_DEREG_BCMC);
 }
 
+static int ehea_mem_notifier(struct notifier_block *nb,
+                             unsigned long action, void *data)
+{
+	switch (action) {
+	case MEM_OFFLINE:
+		ehea_info("memory has been removed");
+		ehea_rereg_mrs(NULL);
+		break;
+	default:
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block ehea_mem_nb = {
+	.notifier_call = ehea_mem_notifier,
+};
+
 static int ehea_reboot_notifier(struct notifier_block *nb,
 				unsigned long action, void *unused)
 {
@@ -3559,6 +3578,10 @@ int __init ehea_module_init(void)
 	if (ret)
 		ehea_info("failed registering reboot notifier");
 
+	ret = register_memory_notifier(&ehea_mem_nb);
+	if (ret)
+		ehea_info("failed registering memory remove notifier");
+
 	ret = crash_shutdown_register(&ehea_crash_handler);
 	if (ret)
 		ehea_info("failed registering crash handler");
@@ -3582,6 +3605,7 @@ int __init ehea_module_init(void)
 out3:
 	ibmebus_unregister_driver(&ehea_driver);
 out2:
+	unregister_memory_notifier(&ehea_mem_nb);
 	unregister_reboot_notifier(&ehea_reboot_nb);
 	crash_shutdown_unregister(&ehea_crash_handler);
 out:
@@ -3599,6 +3623,7 @@ static void __exit ehea_module_exit(void)
 	ret = crash_shutdown_unregister(&ehea_crash_handler);
 	if (ret)
 		ehea_info("failed unregistering crash handler");
+	unregister_memory_notifier(&ehea_mem_nb);
 	kfree(ehea_fw_handles.arr);
 	kfree(ehea_bcmc_regs.arr);
 	ehea_destroy_busmap();
-- 
1.5.2
