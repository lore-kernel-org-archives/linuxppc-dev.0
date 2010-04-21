Return-Path: <tklein@de.ibm.com>
Received: from mtagate1.de.ibm.com (mtagate1.de.ibm.com [195.212.17.161])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 33DB8B7CFA
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Apr 2010 19:11:36 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.1/8.13.1) with ESMTP id o3L9BW9A025098
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Apr 2010 09:11:32 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id o3L9BWcW1618172
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Apr 2010 11:11:32 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id o3L9BVD3028900
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Apr 2010 11:11:31 +0200
From: Thomas Klein <tklein@de.ibm.com>
To: davem@davemloft.net
Subject: [PATCH 2/2][RESEND] ehea: fix possible DLPAR/mem deadlock
Date: Wed, 21 Apr 2010 11:11:31 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201004211111.31298.tklein@de.ibm.com>
Cc: netdev@vger.kernel.org, themann@de.ibm.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Force serialization of userspace-triggered DLPAR/mem operations

Signed-off-by: Thomas Klein <tklein@de.ibm.com>
---

Patch created against net-2.6

diff -Nurp net-2.6.orig/drivers/net/ehea/ehea.h net-2.6/drivers/net/ehea/ehea.h
--- net-2.6.orig/drivers/net/ehea/ehea.h	2010-04-21 10:23:21.000000000 +0200
+++ net-2.6/drivers/net/ehea/ehea.h	2010-04-21 10:42:14.000000000 +0200
@@ -40,7 +40,7 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"ehea"
-#define DRV_VERSION	"EHEA_0102"
+#define DRV_VERSION	"EHEA_0103"
 
 /* eHEA capability flags */
 #define DLPAR_PORT_ADD_REM 1
diff -Nurp net-2.6.orig/drivers/net/ehea/ehea_main.c net-2.6/drivers/net/ehea/ehea_main.c
--- net-2.6.orig/drivers/net/ehea/ehea_main.c	2010-04-21 10:43:14.000000000 +0200
+++ net-2.6/drivers/net/ehea/ehea_main.c	2010-04-21 10:42:14.000000000 +0200
@@ -2889,7 +2889,6 @@ static void ehea_rereg_mrs(struct work_s
 	int ret, i;
 	struct ehea_adapter *adapter;
 
-	mutex_lock(&dlpar_mem_lock);
 	ehea_info("LPAR memory changed - re-initializing driver");
 
 	list_for_each_entry(adapter, &adapter_list, list)
@@ -2959,7 +2958,6 @@ static void ehea_rereg_mrs(struct work_s
 		}
 	ehea_info("re-initializing driver complete");
 out:
-	mutex_unlock(&dlpar_mem_lock);
 	return;
 }
 
@@ -3542,7 +3540,14 @@ void ehea_crash_handler(void)
 static int ehea_mem_notifier(struct notifier_block *nb,
                              unsigned long action, void *data)
 {
+	int ret = NOTIFY_BAD;
 	struct memory_notify *arg = data;
+
+	if (!mutex_trylock(&dlpar_mem_lock)) {
+		ehea_info("ehea_mem_notifier must not be called parallelized");
+		goto out;
+	}
+
 	switch (action) {
 	case MEM_CANCEL_OFFLINE:
 		ehea_info("memory offlining canceled");
@@ -3551,14 +3556,14 @@ static int ehea_mem_notifier(struct noti
 		ehea_info("memory is going online");
 		set_bit(__EHEA_STOP_XFER, &ehea_driver_flags);
 		if (ehea_add_sect_bmap(arg->start_pfn, arg->nr_pages))
-			return NOTIFY_BAD;
+			goto out_unlock;
 		ehea_rereg_mrs(NULL);
 		break;
 	case MEM_GOING_OFFLINE:
 		ehea_info("memory is going offline");
 		set_bit(__EHEA_STOP_XFER, &ehea_driver_flags);
 		if (ehea_rem_sect_bmap(arg->start_pfn, arg->nr_pages))
-			return NOTIFY_BAD;
+			goto out_unlock;
 		ehea_rereg_mrs(NULL);
 		break;
 	default:
@@ -3566,8 +3571,12 @@ static int ehea_mem_notifier(struct noti
 	}
 
 	ehea_update_firmware_handles();
+	ret = NOTIFY_OK;
 
-	return NOTIFY_OK;
+out_unlock:
+	mutex_unlock(&dlpar_mem_lock);
+out:
+	return ret;
 }
 
 static struct notifier_block ehea_mem_nb = {
