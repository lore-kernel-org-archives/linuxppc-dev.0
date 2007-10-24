Return-Path: <ossthema@de.ibm.com>
Received: from mtagate6.uk.ibm.com (mtagate6.uk.ibm.com [195.212.29.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 18FDFDDF35
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 19:54:14 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate6.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l9O9s7gm169612
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 09:54:07 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id l9O9s79f3047490
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 10:54:07 +0100
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l9O9rpTu021378
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 10:53:51 +0100
From: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: [PATCH] ehea: fix port_napi_disable/enable
Date: Wed, 24 Oct 2007 11:53:34 +0200
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200710241153.34992.ossthema@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
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

napi_disable / napi_enable must be applied on all ehea queues.

Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>

---
 drivers/net/ehea/ehea.h      |    2 +-
 drivers/net/ehea/ehea_main.c |    7 +++----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ehea/ehea.h b/drivers/net/ehea/ehea.h
index b557bb4..4b4b74e 100644
--- a/drivers/net/ehea/ehea.h
+++ b/drivers/net/ehea/ehea.h
@@ -40,7 +40,7 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"ehea"
-#define DRV_VERSION	"EHEA_0078"
+#define DRV_VERSION	"EHEA_0079"
 
 /* eHEA capability flags */
 #define DLPAR_PORT_ADD_REM 1
diff --git a/drivers/net/ehea/ehea_main.c b/drivers/net/ehea/ehea_main.c
index fe5ffac..a8b05d2 100644
--- a/drivers/net/ehea/ehea_main.c
+++ b/drivers/net/ehea/ehea_main.c
@@ -2329,7 +2329,7 @@ static void port_napi_disable(struct ehea_port *port)
 {
 	int i;
 
-	for (i = 0; i < port->num_def_qps; i++)
+	for (i = 0; i < port->num_def_qps + port->num_add_tx_qps; i++)
 		napi_disable(&port->port_res[i].napi);
 }
 
@@ -2337,7 +2337,7 @@ static void port_napi_enable(struct ehea_port *port)
 {
 	int i;
 
-	for (i = 0; i < port->num_def_qps; i++)
+	for (i = 0; i < port->num_def_qps + port->num_add_tx_qps; i++)
 		napi_enable(&port->port_res[i].napi);
 }
 
@@ -2373,8 +2373,6 @@ static int ehea_down(struct net_device *dev)
 	ehea_drop_multicast_list(dev);
 	ehea_free_interrupts(dev);
 
-	port_napi_disable(port);
-
 	port->state = EHEA_PORT_DOWN;
 
 	ret = ehea_clean_all_portres(port);
@@ -2396,6 +2394,7 @@ static int ehea_stop(struct net_device *dev)
 	flush_scheduled_work();
 	down(&port->port_lock);
 	netif_stop_queue(dev);
+	port_napi_disable(port);
 	ret = ehea_down(dev);
 	up(&port->port_lock);
 	return ret;
-- 
1.5.2
