Return-Path: <roel.kluin@gmail.com>
Received: from mail-ew0-f20.google.com (mail-ew0-f20.google.com
	[209.85.219.20]) by ozlabs.org (Postfix) with ESMTP id 643A9DE198
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Jan 2009 04:18:12 +1100 (EST)
Received: by ewy13 with SMTP id 13so9030567ewy.9
	for <linuxppc-dev@ozlabs.org>; Sun, 04 Jan 2009 09:18:09 -0800 (PST)
Message-ID: <4960EF54.1090907@gmail.com>
Date: Sun, 04 Jan 2009 18:18:12 +0100
From: Roel Kluin <roel.kluin@gmail.com>
MIME-Version: 1.0
To: jrigby@freescale.com, grant.likely@secretlab.ca
Subject: [PATCH] powerpc/mpc5121: fix NULL test
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

strcmp on NULL results in a segmentation fault, also, remove the second,
redundant test on dev

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
Please verify whether this patch correct.

diff --git a/arch/powerpc/platforms/512x/clock.c b/arch/powerpc/platforms/512x/clock.c
index f416014..1bcff94 100644
--- a/arch/powerpc/platforms/512x/clock.c
+++ b/arch/powerpc/platforms/512x/clock.c
@@ -56,12 +56,12 @@ static struct clk *mpc5121_clk_get(struct device *dev, const char *id)
 	int dev_match = 0;
 	int id_match = 0;
 
-	if (dev == NULL && id == NULL)
+	if (dev == NULL || id == NULL)
 		return NULL;
 
 	mutex_lock(&clocks_mutex);
 	list_for_each_entry(p, &clocks, node) {
-		if (dev && dev == p->dev)
+		if (dev == p->dev)
 			dev_match++;
 		if (strcmp(id, p->name) == 0)
 			id_match++;
