Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 74ECB67B90
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Jul 2006 03:00:20 +1000 (EST)
Message-Id: <20060707165528.957896000@sipsolutions.net>
References: <20060707165207.877010000@sipsolutions.net>
Date: Fri, 07 Jul 2006 18:52:08 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 01/12] Use proper irq mapping interface for snd-aoa-i2sbus.
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Andreas Schwab <schwab@suse.de>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

---
 sound/aoa/soundbus/i2sbus/i2sbus-core.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

--- linux-2.6-fetch.orig/sound/aoa/soundbus/i2sbus/i2sbus-core.c	2006-07-07 12:15:45.857697157 +0200
+++ linux-2.6-fetch/sound/aoa/soundbus/i2sbus/i2sbus-core.c	2006-07-07 12:15:48.607697157 +0200
@@ -129,9 +129,6 @@ static int i2sbus_add_dev(struct macio_d
 	if (strncmp(np->name, "i2s-", 4))
 		return 0;
 
-	if (macio_irq_count(macio) != 3)
-		return 0;
-
 	dev = kzalloc(sizeof(struct i2sbus_dev), GFP_KERNEL);
 	if (!dev)
 		return 0;
@@ -183,10 +180,10 @@ static int i2sbus_add_dev(struct macio_d
 		snprintf(dev->rnames[i], sizeof(dev->rnames[i]), rnames[i], np->name);
 	}
 	for (i=0;i<3;i++) {
-		if (request_irq(macio_irq(macio, i), ints[i], 0,
-				dev->rnames[i], dev))
+		int irq = irq_of_parse_and_map(np, i);
+		if (request_irq(irq, ints[i], 0, dev->rnames[i], dev))
 			goto err;
-		dev->interrupts[i] = macio_irq(macio, i);
+		dev->interrupts[i] = irq;
 	}
 
 	for (i=0;i<3;i++) {

--
