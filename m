Return-Path: <olaf@ibook.aepfle.de>
Received: from natlemon.rzone.de (natlemon.rzone.de [81.169.145.170])
	by ozlabs.org (Postfix) with ESMTP id 0AA3867B5B
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Oct 2006 06:57:30 +1000 (EST)
Date: Mon, 2 Oct 2006 22:57:23 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Paul Mackeras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] update swim3 printk after blkdev.h change
Message-ID: <20061002205723.GA19251@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


drivers/block/swim3.c: In function 'swim3_interrupt':
drivers/block/swim3.c:640: warning: format '%lx' expects type 'long unsigned int', but argument 3 has type 'unsigned int'
drivers/block/swim3.c:746: warning: format '%lx' expects type 'long unsigned int', but argument 3 has type 'unsigned int'

Update printk format string after blkdev.h change:
 Split struct request ->flags into two parts

Signed-off-by: Olaf Hering <olaf@aepfle.de>

---
 drivers/block/swim3.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/block/swim3.c
===================================================================
--- linux-2.6.orig/drivers/block/swim3.c
+++ linux-2.6/drivers/block/swim3.c
@@ -636,7 +636,7 @@ static irqreturn_t swim3_interrupt(int i
 	intr = in_8(&sw->intr);
 	err = (intr & ERROR_INTR)? in_8(&sw->error): 0;
 	if ((intr & ERROR_INTR) && fs->state != do_transfer)
-		printk(KERN_ERR "swim3_interrupt, state=%d, dir=%lx, intr=%x, err=%x\n",
+		printk(KERN_ERR "swim3_interrupt, state=%d, dir=%x, intr=%x, err=%x\n",
 		       fs->state, rq_data_dir(fd_req), intr, err);
 	switch (fs->state) {
 	case locating:
@@ -742,7 +742,7 @@ static irqreturn_t swim3_interrupt(int i
 			if ((stat & ACTIVE) == 0 || resid != 0) {
 				/* musta been an error */
 				printk(KERN_ERR "swim3: fd dma: stat=%x resid=%d\n", stat, resid);
-				printk(KERN_ERR "  state=%d, dir=%lx, intr=%x, err=%x\n",
+				printk(KERN_ERR "  state=%d, dir=%x, intr=%x, err=%x\n",
 				       fs->state, rq_data_dir(fd_req), intr, err);
 				end_request(fd_req, 0);
 				fs->state = idle;
