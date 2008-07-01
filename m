Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from VA3EHSOBE001.bigfish.com (outbound-va3.frontbridge.com
	[216.32.180.16]) by ozlabs.org (Postfix) with ESMTP id ED5A8DE5EB
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Jul 2008 04:17:12 +1000 (EST)
Message-ID: <486A74A1.1040601@am.sony.com>
Date: Tue, 1 Jul 2008 11:17:05 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [patch] PS3: Quiet system bus match output
Content-Type: text/plain; charset="ISO-8859-1"
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Reduce the output verbosity of ps3_system_bus_match().

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---

Paul,

Please queue for 2.6.27.

-Geoff

 arch/powerpc/platforms/ps3/system-bus.c |   21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

--- a/arch/powerpc/platforms/ps3/system-bus.c
+++ b/arch/powerpc/platforms/ps3/system-bus.c
@@ -349,9 +349,14 @@ static int ps3_system_bus_match(struct d
 
 	result = dev->match_id == drv->match_id;
 
-	pr_info("%s:%d: dev=%u(%s), drv=%u(%s): %s\n", __func__, __LINE__,
-		dev->match_id, dev->core.bus_id, drv->match_id, drv->core.name,
-		(result ? "match" : "miss"));
+	if (result)
+		pr_info("%s:%d: dev=%u(%s), drv=%u(%s): match\n", __func__,
+			__LINE__, dev->match_id, dev->core.bus_id,
+			drv->match_id, drv->core.name);
+	else
+		pr_debug("%s:%d: dev=%u(%s), drv=%u(%s): miss\n", __func__,
+			__LINE__, dev->match_id, dev->core.bus_id,
+			drv->match_id, drv->core.name);
 	return result;
 }
 
@@ -362,7 +367,7 @@ static int ps3_system_bus_probe(struct d
 	struct ps3_system_bus_driver *drv;
 
 	BUG_ON(!dev);
-	pr_info(" -> %s:%d: %s\n", __func__, __LINE__, _dev->bus_id);
+	pr_debug(" -> %s:%d: %s\n", __func__, __LINE__, _dev->bus_id);
 
 	drv = ps3_system_bus_dev_to_system_bus_drv(dev);
 	BUG_ON(!drv);
@@ -370,10 +375,10 @@ static int ps3_system_bus_probe(struct d
 	if (drv->probe)
 		result = drv->probe(dev);
 	else
-		pr_info("%s:%d: %s no probe method\n", __func__, __LINE__,
+		pr_debug("%s:%d: %s no probe method\n", __func__, __LINE__,
 			dev->core.bus_id);
 
-	pr_info(" <- %s:%d: %s\n", __func__, __LINE__, dev->core.bus_id);
+	pr_debug(" <- %s:%d: %s\n", __func__, __LINE__, dev->core.bus_id);
 	return result;
 }
 
@@ -384,7 +389,7 @@ static int ps3_system_bus_remove(struct 
 	struct ps3_system_bus_driver *drv;
 
 	BUG_ON(!dev);
-	pr_info(" -> %s:%d: %s\n", __func__, __LINE__, _dev->bus_id);
+	pr_debug(" -> %s:%d: %s\n", __func__, __LINE__, _dev->bus_id);
 
 	drv = ps3_system_bus_dev_to_system_bus_drv(dev);
 	BUG_ON(!drv);
@@ -395,7 +400,7 @@ static int ps3_system_bus_remove(struct 
 		dev_dbg(&dev->core, "%s:%d %s: no remove method\n",
 			__func__, __LINE__, drv->core.name);
 
-	pr_info(" <- %s:%d: %s\n", __func__, __LINE__, dev->core.bus_id);
+	pr_debug(" <- %s:%d: %s\n", __func__, __LINE__, dev->core.bus_id);
 	return result;
 }
 
