Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound9-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 93459DDE16
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 04:01:40 +1000 (EST)
Message-ID: <46BA04F1.3000508@am.sony.com>
Date: Wed, 08 Aug 2007 11:01:21 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 1/3 v2] PS3: Fix storage probe logic
References: <20070808033119.833895506@am.sony.com>
	<20070808033119.960825832@am.sony.com>
In-Reply-To: <20070808033119.960825832@am.sony.com>
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

Subject: PS3: Fix storage probe logic

From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

Fix the PS3 storage probe logic to properly find device regions on cold
startup.

 o Change the storage probe event mask from notify_device_ready
   to notify_region_update.
 o Improve the storage probe error handling.
 o Change ps3_storage_wait_for_device() to use a temporary variable to hold
   the buffer address.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
V2 changes:
  o Correct the value the returned notify_event->event_type is compared to.

 arch/powerpc/platforms/ps3/device-init.c |   37 +++++++++++++++----------------
 1 file changed, 19 insertions(+), 18 deletions(-)

--- a/arch/powerpc/platforms/ps3/device-init.c
+++ b/arch/powerpc/platforms/ps3/device-init.c
@@ -273,55 +273,58 @@ static int ps3stor_wait_for_completion(u
 
 static int ps3_storage_wait_for_device(const struct ps3_repository_device *repo)
 {
+	int error = -ENODEV;
 	int result;
 	const u64 notification_dev_id = (u64)-1LL;
 	const unsigned int timeout = HZ;
 	u64 lpar;
 	u64 tag;
+	void *buf;
+	enum ps3_notify_type {
+		notify_device_ready = 0,
+		notify_region_probe = 1,
+		notify_region_update = 2,
+	};
 	struct {
 		u64 operation_code;	/* must be zero */
-		u64 event_mask;		/* 1 = device ready */
+		u64 event_mask;		/* OR of 1UL << enum ps3_notify_type */
 	} *notify_cmd;
 	struct {
-		u64 event_type;		/* notify_device_ready */
+		u64 event_type;		/* enum ps3_notify_type */
 		u64 bus_id;
 		u64 dev_id;
 		u64 dev_type;
 		u64 dev_port;
 	} *notify_event;
-	enum {
-		notify_device_ready = 1
-	};
 
 	pr_debug(" -> %s:%u: bus_id %u, dev_id %u, dev_type %u\n", __func__,
 		 __LINE__, repo->bus_id, repo->dev_id, repo->dev_type);
 
-	notify_cmd = kzalloc(512, GFP_KERNEL);
-	notify_event = (void *)notify_cmd;
-	if (!notify_cmd)
+	buf = kzalloc(512, GFP_KERNEL);
+	if (!buf)
 		return -ENOMEM;
 
-	lpar = ps3_mm_phys_to_lpar(__pa(notify_cmd));
+	lpar = ps3_mm_phys_to_lpar(__pa(buf));
+	notify_cmd = buf;
+	notify_event = buf;
 
 	result = lv1_open_device(repo->bus_id, notification_dev_id, 0);
 	if (result) {
 		printk(KERN_ERR "%s:%u: lv1_open_device %s\n", __func__,
 		       __LINE__, ps3_result(result));
-		result = -ENODEV;
 		goto fail_free;
 	}
 
 	/* Setup and write the request for device notification. */
 
-	notify_cmd->operation_code = 0;	/* must be zero */
-	notify_cmd->event_mask = 0x01;	/* device ready */
+	notify_cmd->operation_code = 0; /* must be zero */
+	notify_cmd->event_mask = 1UL << notify_region_probe;
 
 	result = lv1_storage_write(notification_dev_id, 0, 0, 1, 0, lpar,
 				   &tag);
 	if (result) {
 		printk(KERN_ERR "%s:%u: write failed %s\n", __func__, __LINE__,
 		       ps3_result(result));
-		result = -ENODEV;
 		goto fail_close;
 	}
 
@@ -332,13 +335,11 @@ static int ps3_storage_wait_for_device(c
 	if (result) {
 		printk(KERN_ERR "%s:%u: write not completed %s\n", __func__,
 		       __LINE__, ps3_result(result));
-		result = -ENODEV;
 		goto fail_close;
 	}
 
 	/* Loop here processing the requested notification events. */
 
-	result = -ENODEV;
 	while (1) {
 		memset(notify_event, 0, sizeof(*notify_event));
 
@@ -358,7 +359,7 @@ static int ps3_storage_wait_for_device(c
 			break;
 		}
 
-		if (notify_event->event_type != notify_device_ready ||
+		if (notify_event->event_type != notify_region_probe ||
 		    notify_event->bus_id != repo->bus_id) {
 			pr_debug("%s:%u: bad notify_event: event %lu, "
 				 "dev_id %lu, dev_type %lu\n",
@@ -386,9 +387,9 @@ static int ps3_storage_wait_for_device(c
 fail_close:
 	lv1_close_device(repo->bus_id, notification_dev_id);
 fail_free:
-	kfree(notify_cmd);
+	kfree(buf);
 	pr_debug(" <- %s:%u\n", __func__, __LINE__);
-	return result;
+	return error;
 }
 
 static int ps3_setup_storage_dev(const struct ps3_repository_device *repo,
