Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id CC0D61007F8
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Oct 2009 04:54:18 +1100 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Date: Fri, 30 Oct 2009 18:53:51 +0100
Message-Id: <1256925231-21917-1-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <20091030105414.GD717@sirena.org.uk>
References: <20091030105414.GD717@sirena.org.uk>
Subject: [PATCH V2] mpc512x/clock: fix clk_get logic
Cc: Roel Kluin <roel.kluin@gmail.com>, Wolfgang Denk <wd@denx.de>,
	Mark Brown <broonie@sirena.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The current matching logic returns a clock even if only one out of two
arguments matches. This is wrong as devices may utilize more than one clock, so
only the first clock out of those is returned if the dev-match alone is
considered sufficent (noticed while working on the CAN driver). The proposed
new method will:

- return -EINVAL if both arguments are NULL
- skip the relevant check if one argument is NULL (first match wins)
- otherwise both arguments need to match

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Mark Brown <broonie@sirena.org.uk>
Cc: Roel Kluin <roel.kluin@gmail.com>
Cc: Wolfgang Denk <wd@denx.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
---

After Mark's valid comment, I'll try harder ;)

 arch/powerpc/platforms/512x/clock.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/512x/clock.c b/arch/powerpc/platforms/512x/clock.c
index 84544d0..4168457 100644
--- a/arch/powerpc/platforms/512x/clock.c
+++ b/arch/powerpc/platforms/512x/clock.c
@@ -53,19 +53,21 @@ static DEFINE_MUTEX(clocks_mutex);
 static struct clk *mpc5121_clk_get(struct device *dev, const char *id)
 {
 	struct clk *p, *clk = ERR_PTR(-ENOENT);
-	int dev_match = 0;
-	int id_match = 0;
+	/* If one argument is not given, skip its match */
+	bool id_matched = !id;
+	bool dev_matched = !dev;
 
-	if (dev == NULL || id == NULL)
-		return NULL;
+	/* We need at least one argument */
+	if (!dev && !id)
+		return ERR_PTR(-EINVAL);
 
 	mutex_lock(&clocks_mutex);
 	list_for_each_entry(p, &clocks, node) {
 		if (dev == p->dev)
-			dev_match++;
-		if (strcmp(id, p->name) == 0)
-			id_match++;
-		if ((dev_match || id_match) && try_module_get(p->owner)) {
+			dev_matched = true;
+		if (id && strcmp(id, p->name) == 0)
+			id_matched = true;
+		if (dev_matched && id_matched && try_module_get(p->owner)) {
 			clk = p;
 			break;
 		}
-- 
1.6.3.3
