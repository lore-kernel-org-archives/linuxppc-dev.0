From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Message-Id: <199909211922.VAA10524@simul.biophys.uni-duesseldorf.de>
Subject: Patch for Lombard expansion bay
To: linuxppc-dev@lists.linuxppc.org
Date: Tue, 21 Sep 1999 21:22:59 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

the following patch makes expansion bay device swapping work with stock
2.2.12 (recent rsync from Paul's server) on my Lombard. Stock 2.2.12 claims 
'CD-ROM wasn't properly inserted, retry' ad infinitum. MB_IDE_READY seems to
read the IDE status OK even before the drive initialized properly, and
ide_register seems to read garbage from the drive. The 250 ticks works for
me with both the DVD-ROM and Zip module (the Zip can do with 200, the DVD
only sporadically). What else could be tried to make sure the device is
ready? 

--- drivers/macintosh/mediabay.c.org	Mon Sep 20 21:18:22 1999
+++ drivers/macintosh/mediabay.c	Mon Sep 20 21:08:09 1999
@@ -285,7 +285,7 @@
 #endif
 			}
 #ifdef CONFIG_BLK_DEV_IDE
-		} else if (bay->cd_timer && (--bay->cd_timer == 0 || MB_IDE_READY(i))
+		} else if (bay->cd_timer && (--bay->cd_timer == 0 || (bay->cd_timer < MB_IDE_WAIT-250 && MB_IDE_READY(i)))
 			   && bay->cd_index < 0) {
 			bay->cd_timer = 0;
 			printk(KERN_DEBUG "Registering IDE, base:0x%08lx, irq:%d\n", bay->cd_base, bay->cd_irq);

	Michael

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
