Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 85AD4DDF39
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 16:32:23 +1000 (EST)
Date: Mon, 14 May 2007 16:32:19 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org, benh@kernel.crashing.org
Subject: [PATCH] [POWERPC] remove build warnings in windfarm_core
Message-Id: <20070514163219.9d78cde0.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

drivers/macintosh/windfarm_core.c: In function 'wf_register_control':
drivers/macintosh/windfarm_core.c:219: warning: ignoring return value of 'device_create_file', declared with attribute warn_unused_result
drivers/macintosh/windfarm_core.c: In function 'wf_register_sensor':
drivers/macintosh/windfarm_core.c:329: warning: ignoring return value of 'device_create_file', declared with attribute warn_unused_result

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/macintosh/windfarm_core.c |   32 ++++++++++++++++++++++++--------
 1 files changed, 24 insertions(+), 8 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/drivers/macintosh/windfarm_core.c b/drivers/macintosh/windfarm_core.c
index 192b26e..a306d67 100644
--- a/drivers/macintosh/windfarm_core.c
+++ b/drivers/macintosh/windfarm_core.c
@@ -198,14 +198,15 @@ static ssize_t wf_store_control(struct device *dev,
 int wf_register_control(struct wf_control *new_ct)
 {
 	struct wf_control *ct;
+	int ret = 0;
 
 	mutex_lock(&wf_lock);
 	list_for_each_entry(ct, &wf_controls, link) {
 		if (!strcmp(ct->name, new_ct->name)) {
 			printk(KERN_WARNING "windfarm: trying to register"
 			       " duplicate control %s\n", ct->name);
-			mutex_unlock(&wf_lock);
-			return -EEXIST;
+			ret = -EEXIST;
+			goto out_unlock;
 		}
 	}
 	kref_init(&new_ct->ref);
@@ -216,14 +217,21 @@ int wf_register_control(struct wf_control *new_ct)
 	new_ct->attr.attr.mode = 0644;
 	new_ct->attr.show = wf_show_control;
 	new_ct->attr.store = wf_store_control;
-	device_create_file(&wf_platform_device.dev, &new_ct->attr);
+	ret = device_create_file(&wf_platform_device.dev, &new_ct->attr);
+	if (ret) {
+		list_del(&new_ct->link);
+		printk(KERN_WARNING "windfarm: device_creat_file failed"
+			"for %s\n", new_ct->name);
+		goto out_unlock;
+	}
 
 	DBG("wf: Registered control %s\n", new_ct->name);
 
 	wf_notify(WF_EVENT_NEW_CONTROL, new_ct);
+out_unlock:
 	mutex_unlock(&wf_lock);
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(wf_register_control);
 
@@ -308,14 +316,15 @@ static ssize_t wf_show_sensor(struct device *dev,
 int wf_register_sensor(struct wf_sensor *new_sr)
 {
 	struct wf_sensor *sr;
+	int ret;
 
 	mutex_lock(&wf_lock);
 	list_for_each_entry(sr, &wf_sensors, link) {
 		if (!strcmp(sr->name, new_sr->name)) {
 			printk(KERN_WARNING "windfarm: trying to register"
 			       " duplicate sensor %s\n", sr->name);
-			mutex_unlock(&wf_lock);
-			return -EEXIST;
+			ret = -EEXIST;
+			goto out_unlock;
 		}
 	}
 	kref_init(&new_sr->ref);
@@ -326,14 +335,21 @@ int wf_register_sensor(struct wf_sensor *new_sr)
 	new_sr->attr.attr.mode = 0444;
 	new_sr->attr.show = wf_show_sensor;
 	new_sr->attr.store = NULL;
-	device_create_file(&wf_platform_device.dev, &new_sr->attr);
+	ret = device_create_file(&wf_platform_device.dev, &new_sr->attr);
+	if (ret) {
+		list_del(&new_sr->link);
+		printk(KERN_WARNING "windfarm: device_create_file failed"
+		       " for %s\n", new_sr->name);
+		goto out_unlock;
+	}
 
 	DBG("wf: Registered sensor %s\n", new_sr->name);
 
 	wf_notify(WF_EVENT_NEW_SENSOR, new_sr);
+out_unlock:
 	mutex_unlock(&wf_lock);
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(wf_register_sensor);
 
-- 
1.5.1.4
