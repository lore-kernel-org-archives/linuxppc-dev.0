Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 72D0ADDF61
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 11:30:05 +1000 (EST)
Subject: ide pmac breakage
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Content-Type: text/plain
Date: Mon, 28 Jul 2008 11:29:56 +1000
Message-Id: <1217208596.11188.144.camel@pasglop>
Mime-Version: 1.0
Cc: list linux-ide <linux-ide@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The current ide-pmac upstream is broken. It calls
media_bay_set_ide_infos() with an uninitialized "hwif" argument.

It's not a trivial mistake, there's a chicken-and-egg problem in the
init code in there.

I've locally fixed it with this patch that i'll merge via the powerpc
tree unless you have an objection.

However, the machine crashes when removing the media-bay CD-ROM drive.

Crash appears to be a NULL deref, possibly in elv_may_queue() though
I don't have a clean backtrace yet, working on it...

Cheers,
Ben.

diff --git a/drivers/ide/ppc/pmac.c b/drivers/ide/ppc/pmac.c
index c521bf6..fa2be26 100644
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -1086,6 +1086,11 @@ static int __devinit pmac_ide_setup_device(pmac_ide_hwif_t *pmif, hw_regs_t *hw)
 	/* Make sure we have sane timings */
 	sanitize_timings(pmif);
 
+	host = ide_host_alloc(&d, hws);
+	if (host == NULL)
+		return -ENOMEM;
+	hwif = host->ports[0];
+
 #ifndef CONFIG_PPC64
 	/* XXX FIXME: Media bay stuff need re-organizing */
 	if (np->parent && np->parent->name
@@ -1119,11 +1124,11 @@ static int __devinit pmac_ide_setup_device(pmac_ide_hwif_t *pmif, hw_regs_t *hw)
 			 pmif->mdev ? "macio" : "PCI", pmif->aapl_bus_id,
 			 pmif->mediabay ? " (mediabay)" : "", hw->irq);
 
-	rc = ide_host_add(&d, hws, &host);
-	if (rc)
+	rc = ide_host_register(host, &d, hws);
+	if (rc) {
+		ide_host_free(host);
 		return rc;
-
-	hwif = host->ports[0];
+	}
 
 	return 0;
 }
