Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A0491DDE1A
	for <linuxppc-dev@ozlabs.org>; Sat,  3 May 2008 06:42:55 +1000 (EST)
Message-Id: <200805022034.m42KY3gD013264@imap1.linux-foundation.org>
Subject: [patch 3/5] machintosh: ADB driver: adb_handler_sem semaphore to mutex
To: paulus@samba.org
From: akpm@linux-foundation.org
Date: Fri, 02 May 2008 13:34:03 -0700
Cc: akpm@linux-foundation.org, dwalker@mvista.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Daniel Walker <dwalker@mvista.com>

Signed-off-by: Daniel Walker <dwalker@mvista.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/macintosh/adb.c |   30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff -puN drivers/macintosh/adb.c~machintosh-adb-driver-adb_handler_sem-semaphore-to-mutex drivers/macintosh/adb.c
--- a/drivers/macintosh/adb.c~machintosh-adb-driver-adb_handler_sem-semaphore-to-mutex
+++ a/drivers/macintosh/adb.c
@@ -37,7 +37,7 @@
 #include <linux/device.h>
 #include <linux/kthread.h>
 #include <linux/platform_device.h>
-#include <linux/semaphore.h>
+#include <linux/mutex.h>
 
 #include <asm/uaccess.h>
 #ifdef CONFIG_PPC
@@ -102,7 +102,7 @@ static struct adb_handler {
 } adb_handler[16];
 
 /*
- * The adb_handler_sem mutex protects all accesses to the original_address
+ * The adb_handler_mutex mutex protects all accesses to the original_address
  * and handler_id fields of adb_handler[i] for all i, and changes to the
  * handler field.
  * Accesses to the handler field are protected by the adb_handler_lock
@@ -110,7 +110,7 @@ static struct adb_handler {
  * time adb_unregister returns, we know that the old handler isn't being
  * called.
  */
-static DECLARE_MUTEX(adb_handler_sem);
+static DEFINE_MUTEX(adb_handler_mutex);
 static DEFINE_RWLOCK(adb_handler_lock);
 
 #if 0
@@ -355,7 +355,7 @@ do_adb_reset_bus(void)
 		msleep(500);
 	}
 
-	down(&adb_handler_sem);
+	mutex_lock(&adb_handler_mutex);
 	write_lock_irq(&adb_handler_lock);
 	memset(adb_handler, 0, sizeof(adb_handler));
 	write_unlock_irq(&adb_handler_lock);
@@ -376,7 +376,7 @@ do_adb_reset_bus(void)
 		if (adb_controller->autopoll)
 			adb_controller->autopoll(autopoll_devs);
 	}
-	up(&adb_handler_sem);
+	mutex_unlock(&adb_handler_mutex);
 
 	blocking_notifier_call_chain(&adb_client_list,
 		ADB_MSG_POST_RESET, NULL);
@@ -454,7 +454,7 @@ adb_register(int default_id, int handler
 {
 	int i;
 
-	down(&adb_handler_sem);
+	mutex_lock(&adb_handler_mutex);
 	ids->nids = 0;
 	for (i = 1; i < 16; i++) {
 		if ((adb_handler[i].original_address == default_id) &&
@@ -472,7 +472,7 @@ adb_register(int default_id, int handler
 			ids->id[ids->nids++] = i;
 		}
 	}
-	up(&adb_handler_sem);
+	mutex_unlock(&adb_handler_mutex);
 	return ids->nids;
 }
 
@@ -481,7 +481,7 @@ adb_unregister(int index)
 {
 	int ret = -ENODEV;
 
-	down(&adb_handler_sem);
+	mutex_lock(&adb_handler_mutex);
 	write_lock_irq(&adb_handler_lock);
 	if (adb_handler[index].handler) {
 		while(adb_handler[index].busy) {
@@ -493,7 +493,7 @@ adb_unregister(int index)
 		adb_handler[index].handler = NULL;
 	}
 	write_unlock_irq(&adb_handler_lock);
-	up(&adb_handler_sem);
+	mutex_unlock(&adb_handler_mutex);
 	return ret;
 }
 
@@ -557,19 +557,19 @@ adb_try_handler_change(int address, int 
 {
 	int ret;
 
-	down(&adb_handler_sem);
+	mutex_lock(&adb_handler_mutex);
 	ret = try_handler_change(address, new_id);
-	up(&adb_handler_sem);
+	mutex_unlock(&adb_handler_mutex);
 	return ret;
 }
 
 int
 adb_get_infos(int address, int *original_address, int *handler_id)
 {
-	down(&adb_handler_sem);
+	mutex_lock(&adb_handler_mutex);
 	*original_address = adb_handler[address].original_address;
 	*handler_id = adb_handler[address].handler_id;
-	up(&adb_handler_sem);
+	mutex_unlock(&adb_handler_mutex);
 
 	return (*original_address != 0);
 }
@@ -628,10 +628,10 @@ do_adb_query(struct adb_request *req)
 	case ADB_QUERY_GETDEVINFO:
 		if (req->nbytes < 3)
 			break;
-		down(&adb_handler_sem);
+		mutex_lock(&adb_handler_mutex);
 		req->reply[0] = adb_handler[req->data[2]].original_address;
 		req->reply[1] = adb_handler[req->data[2]].handler_id;
-		up(&adb_handler_sem);
+		mutex_unlock(&adb_handler_mutex);
 		req->complete = 1;
 		req->reply_len = 2;
 		adb_write_done(req);
_
