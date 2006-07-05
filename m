Return-Path: <schwab@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 191D867A3E
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Jul 2006 06:11:18 +1000 (EST)
From: Andreas Schwab <schwab@suse.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Fix snd-aoa irq conversion
Date: Wed, 05 Jul 2006 22:11:04 +0200
Message-ID: <jeirmbn76v.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Use proper irq mapping interface for snd-aoa-i2sbus.

Signed-off-by: Andreas Schwab <schwab@suse.de>

---
 sound/aoa/soundbus/i2sbus/i2sbus-core.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

Index: linux-2.6.17-git24/sound/aoa/soundbus/i2sbus/i2sbus-core.c
===================================================================
--- linux-2.6.17-git24.orig/sound/aoa/soundbus/i2sbus/i2sbus-core.c	2006-07-05 20:50:07.000000000 +0200
+++ linux-2.6.17-git24/sound/aoa/soundbus/i2sbus/i2sbus-core.c	2006-07-05 22:02:47.000000000 +0200
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


Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
