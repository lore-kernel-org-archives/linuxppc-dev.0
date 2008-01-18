Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from mail73-dub-R.bigfish.com (mail-dub.bigfish.com [213.199.154.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 5CD32DDFD0
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jan 2008 07:34:10 +1100 (EST)
Message-ID: <47910C7D.5080802@am.sony.com>
Date: Fri, 18 Jan 2008 12:30:53 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 05/16] PS3: Add repository polling loop to work around timing
	bug
References: <20080118202612.422185192@am.sony.com>
In-Reply-To: <20080118202612.422185192@am.sony.com>
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

PS3: Add repository polling loop to work around timing bug

On some firmware versions (e.g. 1.90), the storage device may not show up
in the repository immediately after receiving the notification message.
Add a small polling loop to make sure we don't miss it.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/platforms/ps3/device-init.c |   46 ++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 13 deletions(-)

--- a/arch/powerpc/platforms/ps3/device-init.c
+++ b/arch/powerpc/platforms/ps3/device-init.c
@@ -489,6 +489,38 @@ static int ps3_register_repository_devic
 	return result;
 }
 
+static void ps3_find_and_add_device(u64 bus_id, u64 dev_id)
+{
+	struct ps3_repository_device repo;
+	int res;
+	unsigned int retries;
+	unsigned long rem;
+
+	/*
+	 * On some firmware versions (e.g. 1.90), the device may not show up
+	 * in the repository immediately
+	 */
+	for (retries = 0; retries < 10; retries++) {
+		res = ps3_repository_find_device_by_id(&repo, bus_id, dev_id);
+		if (!res)
+			goto found;
+
+		rem = msleep_interruptible(100);
+		if (rem)
+			break;
+	}
+	pr_warning("%s:%u: device %lu:%lu not found\n", __func__, __LINE__,
+		   bus_id, dev_id);
+	return;
+
+found:
+	if (retries)
+		pr_debug("%s:%u: device %lu:%lu found after %u retries\n",
+			 __func__, __LINE__, bus_id, dev_id, retries);
+
+	ps3_register_repository_device(&repo);
+	return;
+}
 
 #define PS3_NOTIFICATION_DEV_ID		ULONG_MAX
 #define PS3_NOTIFICATION_INTERRUPT_ID	0
@@ -600,7 +632,6 @@ static struct task_struct *probe_task;
 static int ps3_probe_thread(void *data)
 {
 	struct ps3_notification_device dev;
-	struct ps3_repository_device repo;
 	int res;
 	unsigned int irq;
 	u64 lpar;
@@ -682,18 +713,7 @@ static int ps3_probe_thread(void *data)
 			continue;
 		}
 
-		res = ps3_repository_find_device_by_id(&repo, dev.sbd.bus_id,
-						       notify_event->dev_id);
-		if (res) {
-			pr_warning("%s:%u: device %lu:%lu not found\n",
-				   __func__, __LINE__, dev.sbd.bus_id,
-				   notify_event->dev_id);
-			continue;
-		}
-
-		pr_debug("%s:%u: device %lu:%lu found\n", __func__, __LINE__,
-			 dev.sbd.bus_id, notify_event->dev_id);
-		ps3_register_repository_device(&repo);
+		ps3_find_and_add_device(dev.sbd.bus_id, notify_event->dev_id);
 
 	} while (!kthread_should_stop());
 

-- 
