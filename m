Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id DBAA6B7C2B
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Oct 2009 20:17:28 +1100 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Date: Fri, 30 Oct 2009 10:17:14 +0100
Message-Id: <1256894234-11264-1-git-send-email-w.sang@pengutronix.de>
Subject: mpc512x/clock: fix clk_get logic
Cc: Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The matching logic returns a clock even if only the dev-part matches. This is
wrong as devices may utilize more than one clock, so the wrong clock may be
returned due to dev being not unique (noticed while working on the CAN driver).
The proposed new method will:

- require the id field (as _this_ is the unique identifier)
- dev need not be given; if NULL, it will match any device.
  if given, it has to match the dev of the clock
- using the above rules, both fields need to match in order to claim the clock

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Wolfgang Denk <wd@denx.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
 arch/powerpc/platforms/512x/clock.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

Index: .kernel/arch/powerpc/platforms/512x/clock.c
===================================================================
--- .kernel.orig/arch/powerpc/platforms/512x/clock.c
+++ .kernel/arch/powerpc/platforms/512x/clock.c
@@ -53,19 +53,21 @@ static DEFINE_MUTEX(clocks_mutex);
 static struct clk *mpc5121_clk_get(struct device *dev, const char *id)
 {
 	struct clk *p, *clk = ERR_PTR(-ENOENT);
-	int dev_match = 0;
-	int id_match = 0;
+	bool id_match = false;
+	/* Match any device if no dev given */
+	bool dev_match = !dev;
 
-	if (dev == NULL || id == NULL)
+	/* We need the unique identifier */
+	if (id == NULL)
 		return NULL;
 
 	mutex_lock(&clocks_mutex);
 	list_for_each_entry(p, &clocks, node) {
 		if (dev == p->dev)
-			dev_match++;
+			dev_match = true;
 		if (strcmp(id, p->name) == 0)
-			id_match++;
-		if ((dev_match || id_match) && try_module_get(p->owner)) {
+			id_match = true;
+		if (dev_match && id_match && try_module_get(p->owner)) {
 			clk = p;
 			break;
 		}
