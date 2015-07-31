Return-Path: <pebolle@tiscali.nl>
Received: from lb1-smtp-cloud3.xs4all.net (lb1-smtp-cloud3.xs4all.net
 [194.109.24.22])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 36E741A0023
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2015 22:14:25 +1000 (AEST)
Message-ID: <1438344860.13223.14.camel@tiscali.nl>
Subject: [PATCH] windfarm: remove three exported but unused functions
From: Paul Bolle <pebolle@tiscali.nl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Fri, 31 Jul 2015 14:14:20 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

wf_find_control(), wf_find_sensor(), and wf_is_overtemp() are exported
but unused. Remove these three functions.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Cross compile tested only.

 drivers/macintosh/windfarm.h      |  4 ----
 drivers/macintosh/windfarm_core.c | 42 ---------------------------------------
 2 files changed, 46 deletions(-)

diff --git a/drivers/macintosh/windfarm.h b/drivers/macintosh/windfarm.h
index 028cdac2d33d..901c42f71b5a 100644
--- a/drivers/macintosh/windfarm.h
+++ b/drivers/macintosh/windfarm.h
@@ -53,11 +53,9 @@ struct wf_control {
  * the kref and wf_unregister_control will decrement it, thus the
  * object creating/disposing a given control shouldn't assume it
  * still exists after wf_unregister_control has been called.
- * wf_find_control will inc the refcount for you
  */
 extern int wf_register_control(struct wf_control *ct);
 extern void wf_unregister_control(struct wf_control *ct);
-extern struct wf_control * wf_find_control(const char *name);
 extern int wf_get_control(struct wf_control *ct);
 extern void wf_put_control(struct wf_control *ct);
 
@@ -117,7 +115,6 @@ struct wf_sensor {
 /* Same lifetime rules as controls */
 extern int wf_register_sensor(struct wf_sensor *sr);
 extern void wf_unregister_sensor(struct wf_sensor *sr);
-extern struct wf_sensor * wf_find_sensor(const char *name);
 extern int wf_get_sensor(struct wf_sensor *sr);
 extern void wf_put_sensor(struct wf_sensor *sr);
 
@@ -144,7 +141,6 @@ extern int wf_unregister_client(struct notifier_block *nb);
 /* Overtemp conditions. Those are refcounted */
 extern void wf_set_overtemp(void);
 extern void wf_clear_overtemp(void);
-extern int wf_is_overtemp(void);
 
 #define WF_EVENT_NEW_CONTROL	0 /* param is wf_control * */
 #define WF_EVENT_NEW_SENSOR	1 /* param is wf_sensor * */
diff --git a/drivers/macintosh/windfarm_core.c b/drivers/macintosh/windfarm_core.c
index 681e5b4d4b6a..465d770ab0bb 100644
--- a/drivers/macintosh/windfarm_core.c
+++ b/drivers/macintosh/windfarm_core.c
@@ -254,24 +254,6 @@ void wf_unregister_control(struct wf_control *ct)
 }
 EXPORT_SYMBOL_GPL(wf_unregister_control);
 
-struct wf_control * wf_find_control(const char *name)
-{
-	struct wf_control *ct;
-
-	mutex_lock(&wf_lock);
-	list_for_each_entry(ct, &wf_controls, link) {
-		if (!strcmp(ct->name, name)) {
-			if (wf_get_control(ct))
-				ct = NULL;
-			mutex_unlock(&wf_lock);
-			return ct;
-		}
-	}
-	mutex_unlock(&wf_lock);
-	return NULL;
-}
-EXPORT_SYMBOL_GPL(wf_find_control);
-
 int wf_get_control(struct wf_control *ct)
 {
 	if (!try_module_get(ct->ops->owner))
@@ -367,24 +349,6 @@ void wf_unregister_sensor(struct wf_sensor *sr)
 }
 EXPORT_SYMBOL_GPL(wf_unregister_sensor);
 
-struct wf_sensor * wf_find_sensor(const char *name)
-{
-	struct wf_sensor *sr;
-
-	mutex_lock(&wf_lock);
-	list_for_each_entry(sr, &wf_sensors, link) {
-		if (!strcmp(sr->name, name)) {
-			if (wf_get_sensor(sr))
-				sr = NULL;
-			mutex_unlock(&wf_lock);
-			return sr;
-		}
-	}
-	mutex_unlock(&wf_lock);
-	return NULL;
-}
-EXPORT_SYMBOL_GPL(wf_find_sensor);
-
 int wf_get_sensor(struct wf_sensor *sr)
 {
 	if (!try_module_get(sr->ops->owner))
@@ -473,12 +437,6 @@ void wf_clear_overtemp(void)
 }
 EXPORT_SYMBOL_GPL(wf_clear_overtemp);
 
-int wf_is_overtemp(void)
-{
-	return (wf_overtemp != 0);
-}
-EXPORT_SYMBOL_GPL(wf_is_overtemp);
-
 static int __init windfarm_core_init(void)
 {
 	DBG("wf: core loaded\n");
-- 
2.4.3
