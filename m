Return-Path: <osstklei@de.ibm.com>
Received: from mtagate1.uk.ibm.com (mtagate1.uk.ibm.com [195.212.29.134])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 50538DDE36
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Jan 2007 22:52:27 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate1.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l0MBqMh8082670
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Jan 2007 11:52:22 GMT
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
	[9.149.37.213])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.2) with
	ESMTP id l0MBqLPa1532030
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Jan 2007 11:52:22 GMT
Received: from d06av03.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l0MBqLNQ015148
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Jan 2007 11:52:21 GMT
From: Thomas Klein <osstklei@de.ibm.com>
Subject: [PATCH 2.6.20-rc5 1/7] ehea: Fixed wrong dereferencation
Date: Mon, 22 Jan 2007 12:52:20 +0100
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200701221252.20814.osstklei@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Stefan Roscher <roscher@de.ibm.com>,
	Jan-Bernd Themann <themann@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Raisch <raisch@de.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Marcus Eder <meder@de.ibm.com>, Stefan Roscher <ossrosch@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Not only check the pointer against 0 but also the dereferenced value

Signed-off-by: Thomas Klein <tklein@de.ibm.com>
---


 drivers/net/ehea/ehea.h      |    2 +-
 drivers/net/ehea/ehea_main.c |    6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)


diff -Nurp -X dontdiff linux-2.6.20-rc5/drivers/net/ehea/ehea.h patched_kernel/drivers/net/ehea/ehea.h
--- linux-2.6.20-rc5/drivers/net/ehea/ehea.h	2007-01-12 19:54:26.000000000 +0100
+++ patched_kernel/drivers/net/ehea/ehea.h	2007-01-19 13:56:41.000000000 +0100
@@ -39,7 +39,7 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"ehea"
-#define DRV_VERSION	"EHEA_0043"
+#define DRV_VERSION	"EHEA_0044"
 
 #define EHEA_MSG_DEFAULT (NETIF_MSG_LINK | NETIF_MSG_TIMER \
 	| NETIF_MSG_RX_ERR | NETIF_MSG_TX_ERR)
diff -Nurp -X dontdiff linux-2.6.20-rc5/drivers/net/ehea/ehea_main.c patched_kernel/drivers/net/ehea/ehea_main.c
--- linux-2.6.20-rc5/drivers/net/ehea/ehea_main.c	2007-01-12 19:54:26.000000000 +0100
+++ patched_kernel/drivers/net/ehea/ehea_main.c	2007-01-19 13:58:01.000000000 +0100
@@ -2471,14 +2471,16 @@ static int __devinit ehea_probe(struct i
 
 	adapter_handle = (u64*)get_property(dev->ofdev.node, "ibm,hea-handle",
 					    NULL);
-	if (!adapter_handle) {
+	if (adapter_handle)
+		adapter->handle = *adapter_handle;
+
+	if (!adapter->handle) {
 		dev_err(&dev->ofdev.dev, "failed getting handle for adapter"
 			" '%s'\n", dev->ofdev.node->full_name);
 		ret = -ENODEV;
 		goto out_free_ad;
 	}
 
-	adapter->handle = *adapter_handle;
 	adapter->pd = EHEA_PD_ID;
 
 	dev->ofdev.dev.driver_data = adapter;
