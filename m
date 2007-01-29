Return-Path: <osstklei@de.ibm.com>
Received: from mtagate2.uk.ibm.com (mtagate2.uk.ibm.com [195.212.29.135])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F2023DE0D0
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 04:44:07 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate2.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l0THi3jW086868
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 17:44:03 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.2) with
	ESMTP id l0THi2lR1171544
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 17:44:02 GMT
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l0THi2CI014880
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 17:44:02 GMT
From: Thomas Klein <osstklei@de.ibm.com>
Subject: [PATCH 2.6.20-rc6 1/2] ehea: Fixed wrong jumbo frames status query
Date: Mon, 29 Jan 2007 18:44:01 +0100
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200701291844.01887.osstklei@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Raisch <raisch@de.ibm.com>,
	Stefan Roscher <ossrosch@linux.vnet.ibm.com>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch fixes the wrong query and logging of the per interface jumbo frames
enabled/disabled status.


Signed-off-by: Thomas Klein <tklein@de.ibm.com>
---


 drivers/net/ehea/ehea.h      |    2 +-
 drivers/net/ehea/ehea_main.c |   30 +++++++++++++++++++++++-------
 2 files changed, 24 insertions(+), 8 deletions(-)


diff -Nurp -X dontdiff linux-2.6.20-rc6/drivers/net/ehea/ehea.h patched_kernel/drivers/net/ehea/ehea.h
--- linux-2.6.20-rc6/drivers/net/ehea/ehea.h	2007-01-25 03:19:28.000000000 +0100
+++ patched_kernel/drivers/net/ehea/ehea.h	2007-01-29 18:32:02.000000000 +0100
@@ -39,7 +39,7 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"ehea"
-#define DRV_VERSION	"EHEA_0044"
+#define DRV_VERSION	"EHEA_0045"
 
 #define EHEA_MSG_DEFAULT (NETIF_MSG_LINK | NETIF_MSG_TIMER \
 	| NETIF_MSG_RX_ERR | NETIF_MSG_TX_ERR)
diff -Nurp -X dontdiff linux-2.6.20-rc6/drivers/net/ehea/ehea_main.c patched_kernel/drivers/net/ehea/ehea_main.c
--- linux-2.6.20-rc6/drivers/net/ehea/ehea_main.c	2007-01-25 03:19:28.000000000 +0100
+++ patched_kernel/drivers/net/ehea/ehea_main.c	2007-01-29 18:32:02.000000000 +0100
@@ -2316,6 +2316,7 @@ static int ehea_setup_single_port(struct
 	struct ehea_adapter *adapter = port->adapter;
 	struct hcp_ehea_port_cb4 *cb4;
 	u32 *dn_log_port_id;
+	int jumbo = 0;
 
 	sema_init(&port->port_lock, 1);
 	port->state = EHEA_PORT_DOWN;
@@ -2357,13 +2358,25 @@ static int ehea_setup_single_port(struct
 	if (!cb4) {
 		ehea_error("no mem for cb4");
 	} else {
-		cb4->jumbo_frame = 1;
-		hret = ehea_h_modify_ehea_port(adapter->handle,
-					       port->logical_port_id,
-					       H_PORT_CB4, H_PORT_CB4_JUMBO,
-					       cb4);
-		if (hret != H_SUCCESS) {
-			ehea_info("Jumbo frames not activated");
+		hret = ehea_h_query_ehea_port(adapter->handle,
+					      port->logical_port_id,
+					      H_PORT_CB4,
+					      H_PORT_CB4_JUMBO, cb4);
+
+		if (hret == H_SUCCESS) {
+			if (cb4->jumbo_frame)
+				jumbo = 1;
+			else {
+				cb4->jumbo_frame = 1;
+				hret = ehea_h_modify_ehea_port(adapter->handle,
+							       port->
+							        logical_port_id,
+							       H_PORT_CB4,
+							       H_PORT_CB4_JUMBO,
+							       cb4);
+				if (hret == H_SUCCESS)
+					jumbo = 1;
+			}
 		}
 		kfree(cb4);
 	}
@@ -2402,6 +2415,9 @@ static int ehea_setup_single_port(struct
 		goto out_free;
 	}
 
+	ehea_info("%s: Jumbo frames are %sabled", dev->name,
+		  jumbo == 1 ? "en" : "dis");
+
 	port->netdev = dev;
 	ret = 0;
 	goto out;
