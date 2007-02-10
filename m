Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id CD2E6DDF0F
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Feb 2007 07:34:53 +1100 (EST)
Date: Sat, 10 Feb 2007 21:36:14 +0100
From: Olaf Hering <olaf@aepfle.de>
To: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] add delay around sl82c105_reset_engine calls
Message-ID: <20070210203614.GA25602@aepfle.de>
References: <20070210203512.GA25586@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20070210203512.GA25586@aepfle.de>
Cc: linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


The hald media changed polling does really confuse things.
Noone knows why the delays are needed, but they give us access to the CD.

An udelay(50) will give reliable access to the drive, but there is still
one (or more) EH reset. The drive works without EH resets with udelay(100).

Signed-off-by: Olaf Hering <olaf@aepfle.de>

---
 drivers/ata/pata_sl82c105.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-2.6/drivers/ata/pata_sl82c105.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_sl82c105.c
+++ linux-2.6/drivers/ata/pata_sl82c105.c
@@ -187,7 +187,9 @@ static void sl82c105_bmdma_start(struct 
 {
 	struct ata_port *ap = qc->ap;
 
+	udelay(100);
 	sl82c105_reset_engine(ap);
+	udelay(100);
 
 	/* Set the clocks for DMA */
 	sl82c105_configure_dmamode(ap, qc->dev);
@@ -216,6 +218,7 @@ static void sl82c105_bmdma_stop(struct a
 
 	ata_bmdma_stop(qc);
 	sl82c105_reset_engine(ap);
+	udelay(100);
 
 	/* This will redo the initial setup of the DMA device to matching
 	   PIO timings */
