Return-Path: <ossthema@de.ibm.com>
Received: from mtagate7.de.ibm.com (mtagate7.de.ibm.com [195.212.29.156])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 08F4ADDF09
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Jul 2007 17:51:28 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate7.de.ibm.com (8.13.8/8.13.8) with ESMTP id l657pLx1218312
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Jul 2007 07:51:21 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l657pLr12171102
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Jul 2007 09:51:21 +0200
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l657pL2C018372
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Jul 2007 09:51:21 +0200
From: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: [PATCH 1/2] eHEA: Capability flag for DLPAR support
Date: Thu, 5 Jul 2007 09:26:25 +0200
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200707050926.26087.ossthema@de.ibm.com>
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

This patch introduces a capability flag that is used by the DLPAR userspace
tool to check which DLPAR features are supported by the eHEA driver.

Missing goto has been included.

Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>
---
 drivers/net/ehea/ehea.h      |    8 +++++++-
 drivers/net/ehea/ehea_main.c |   23 ++++++++++++++++++++++-
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ehea/ehea.h b/drivers/net/ehea/ehea.h
index abaf3ac..f03f070 100644
--- a/drivers/net/ehea/ehea.h
+++ b/drivers/net/ehea/ehea.h
@@ -39,7 +39,13 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"ehea"
-#define DRV_VERSION	"EHEA_0065"
+#define DRV_VERSION	"EHEA_0067"
+
+/* EHEA capability flags */
+#define DLPAR_PORT_ADD_REM 1
+#define DLPAR_MEM_ADD 2
+#define DLPAR_MEM_REM 4
+#define EHEA_CAPABILITIES (DLPAR_PORT_ADD_REM)
 
 #define EHEA_MSG_DEFAULT (NETIF_MSG_LINK | NETIF_MSG_TIMER \
 	| NETIF_MSG_RX_ERR | NETIF_MSG_TX_ERR)
diff --git a/drivers/net/ehea/ehea_main.c b/drivers/net/ehea/ehea_main.c
index bdb5241..383144d 100644
--- a/drivers/net/ehea/ehea_main.c
+++ b/drivers/net/ehea/ehea_main.c
@@ -2923,6 +2923,15 @@ static int check_module_parm(void)
 	return ret;
 }
 
+static ssize_t ehea_show_capabilities(struct device_driver *drv,
+				      char *buf)
+{
+	return sprintf(buf, "%d", EHEA_CAPABILITIES);
+}
+
+static DRIVER_ATTR(capabilities, S_IRUSR | S_IRGRP | S_IROTH,
+		   ehea_show_capabilities, NULL);
+
 int __init ehea_module_init(void)
 {
 	int ret;
@@ -2934,8 +2943,19 @@ int __init ehea_module_init(void)
 	if (ret)
 		goto out;
 	ret = ibmebus_register_driver(&ehea_driver);
-	if (ret)
+	if (ret) {
 		ehea_error("failed registering eHEA device driver on ebus");
+		goto out;
+	}
+
+	ret = driver_create_file(&ehea_driver.driver,
+				 &driver_attr_capabilities);
+	if (ret) {
+		ehea_error("failed to register capabilities attribute, ret=%d",
+			   ret);
+		ibmebus_unregister_driver(&ehea_driver);
+		goto out;
+	}
 
 out:
 	return ret;
@@ -2943,6 +2963,7 @@ out:
 
 static void __exit ehea_module_exit(void)
 {
+	driver_remove_file(&ehea_driver.driver, &driver_attr_capabilities);
 	ibmebus_unregister_driver(&ehea_driver);
 }
 
-- 
1.5.2
