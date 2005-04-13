Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C250567B56
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Apr 2005 14:40:57 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 13 Apr 2005 14:40:38 +1000
Message-Id: <1113367238.5515.5.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: [PATCH] ppc32: Fix IDE related crash on wakeup
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi !

I noticed an occasional crash on wakeup from sleep on my powerbook
(strangly never happened before, probably timing related) that appears
to be due to a dangling interrupt while the chip is put to sleep and
beeing reset on wakeup.

This patch fixes is by disabling the irq in the ide pmac driver while
asleep and only re-enable it after the chip has been fully reset. This
is safe to do so as the interrupt of these apple IDE cells is never
shared.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/drivers/ide/ppc/pmac.c
===================================================================
--- linux-work.orig/drivers/ide/ppc/pmac.c	2005-04-13 10:53:39.000000000 +1000
+++ linux-work/drivers/ide/ppc/pmac.c	2005-04-13 14:17:41.000000000 +1000
@@ -1204,6 +1204,8 @@
 	}
 #endif /* CONFIG_BLK_DEV_IDE_PMAC_BLINK */
 
+	disable_irq(pmif->irq);
+
 	/* The media bay will handle itself just fine */
 	if (pmif->mediabay)
 		return 0;
@@ -1236,7 +1238,6 @@
 		ppc_md.feature_call(PMAC_FTR_IDE_ENABLE, pmif->node, pmif->aapl_bus_id, 1);
 		msleep(10);
 		ppc_md.feature_call(PMAC_FTR_IDE_RESET, pmif->node, pmif->aapl_bus_id, 0);
-		msleep(jiffies_to_msecs(IDE_WAKEUP_DELAY));
 
 		/* Kauai has it different */
 		if (pmif->kauai_fcr) {
@@ -1244,11 +1245,15 @@
 			fcr |= KAUAI_FCR_UATA_RESET_N | KAUAI_FCR_UATA_ENABLE;
 			writel(fcr, pmif->kauai_fcr);
 		}
+
+		msleep(jiffies_to_msecs(IDE_WAKEUP_DELAY));
 	}
 
 	/* Sanitize drive timings */
 	sanitize_timings(pmif);
 
+	enable_irq(pmif->irq);
+
 	return 0;
 }
 
