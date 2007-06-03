Return-Path: <rpjday@mindspring.com>
Received: from rubicon.netdirect.ca (nic.NetDirect.CA [216.16.235.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B9847DDE29
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jun 2007 03:58:39 +1000 (EST)
Date: Sun, 3 Jun 2007 13:52:02 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: bzolnier@gmail.com
Subject: [PATCH] IDE: Remove remnants related to dead BLK_DEV_MAC_MEDIABAY
	CONFIG variable.
Message-ID: <Pine.LNX.4.64.0706031348550.24843@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux PPC Mailing List <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Remove the two snippets of code conditional on the non-existent CONFIG
variable CONFIG_BLK_DEV_MAC_MEDIABAY.

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

---

diff --git a/drivers/ide/legacy/macide.c b/drivers/ide/legacy/macide.c
index c211fc7..b557c45 100644
--- a/drivers/ide/legacy/macide.c
+++ b/drivers/ide/legacy/macide.c
@@ -77,15 +77,6 @@ int macide_ack_intr(ide_hwif_t* hwif)
 	return 0;
 }

-#ifdef CONFIG_BLK_DEV_MAC_MEDIABAY
-static void macide_mediabay_interrupt(int irq, void *dev_id)
-{
-	int state = baboon->mb_status & 0x04;
-
-	printk(KERN_INFO "macide: media bay %s detected\n", state? "removal":"insertion");
-}
-#endif
-
 /*
  * Probe for a Macintosh IDE interface
  */
@@ -128,11 +119,6 @@ void macide_init(void)
 			ide_drive_t *drive = &ide_hwifs[index].drives[0];
 			drive->capacity64 = drive->cyl*drive->head*drive->sect;

-#ifdef CONFIG_BLK_DEV_MAC_MEDIABAY
-			request_irq(IRQ_BABOON_2, macide_mediabay_interrupt,
-					IRQ_FLG_FAST, "mediabay",
-					macide_mediabay_interrupt);
-#endif
 		}
 		break;

-- 
========================================================================
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry
Waterloo, Ontario, CANADA

http://fsdev.net/wiki/index.php?title=Main_Page
========================================================================
