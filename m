Return-Path: <ossthema@de.ibm.com>
Received: from mtagate3.de.ibm.com (mtagate3.de.ibm.com [195.212.17.163])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 57EF11009A0
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jun 2010 01:35:53 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.1/8.13.1) with ESMTP id o5FFZmHA015863
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jun 2010 15:35:48 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id o5FFZm8d1331368
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jun 2010 17:35:48 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id o5FFZmU4002385
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jun 2010 17:35:48 +0200
From: "Jan-Bernd Themann" <ossthema@de.ibm.com>
Subject: [PATCH 2/2] ehea: Fix kernel deadlock in DLPAR-mem processing
Date: Tue, 15 Jun 2010 17:35:42 +0200
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201006151735.43144.ossthema@de.ibm.com>
Cc: themann@de.ibm.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, tklein@linux.ibm.com,
	Andre Detsch <adetsch@br.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Port reset operations and memory add/remove operations need to 
be serialized to avoid a kernel deadlock. The deadlock is caused
by calling the napi_disable() function twice.
Therefore we have to employ the dlpar_mem_lock in the ehea_reset_port
function as well


Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>

---
created against kernel-2.6.35-rc3

 drivers/net/ehea/ehea.h      |    2 +-
 drivers/net/ehea/ehea_main.c |    8 +++-----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ehea/ehea.h b/drivers/net/ehea/ehea.h
index 0630980..0060e42 100644
--- a/drivers/net/ehea/ehea.h
+++ b/drivers/net/ehea/ehea.h
@@ -40,7 +40,7 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"ehea"
-#define DRV_VERSION	"EHEA_0103"
+#define DRV_VERSION	"EHEA_0105"
 
 /* eHEA capability flags */
 #define DLPAR_PORT_ADD_REM 1
diff --git a/drivers/net/ehea/ehea_main.c b/drivers/net/ehea/ehea_main.c
index fd890fa..8b92acb 100644
--- a/drivers/net/ehea/ehea_main.c
+++ b/drivers/net/ehea/ehea_main.c
@@ -2860,6 +2860,7 @@ static void ehea_reset_port(struct work_struct *work)
 		container_of(work, struct ehea_port, reset_task);
 	struct net_device *dev = port->netdev;
 
+	mutex_lock(&dlpar_mem_lock);
 	port->resets++;
 	mutex_lock(&port->port_lock);
 	netif_stop_queue(dev);
@@ -2882,6 +2883,7 @@ static void ehea_reset_port(struct work_struct *work)
 	netif_wake_queue(dev);
 out:
 	mutex_unlock(&port->port_lock);
+	mutex_unlock(&dlpar_mem_lock);
 }
 
 static void ehea_rereg_mrs(struct work_struct *work)
@@ -3543,10 +3545,7 @@ static int ehea_mem_notifier(struct notifier_block *nb,
 	int ret = NOTIFY_BAD;
 	struct memory_notify *arg = data;
 
-	if (!mutex_trylock(&dlpar_mem_lock)) {
-		ehea_info("ehea_mem_notifier must not be called parallelized");
-		goto out;
-	}
+	mutex_lock(&dlpar_mem_lock);
 
 	switch (action) {
 	case MEM_CANCEL_OFFLINE:
@@ -3575,7 +3574,6 @@ static int ehea_mem_notifier(struct notifier_block *nb,
 
 out_unlock:
 	mutex_unlock(&dlpar_mem_lock);
-out:
 	return ret;
 }
 
-- 
1.7.0
