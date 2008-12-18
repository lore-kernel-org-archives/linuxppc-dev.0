Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 0C913DDF08
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Dec 2008 05:23:30 +1100 (EST)
Date: Thu, 18 Dec 2008 21:23:29 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH 3/6] ucc_geth: Fix IRQ freeing code in ucc_geth_open()
Message-ID: <20081218182329.GC30682@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: netdev@vger.kernel.org, Timur Tabi <timur@freescale.com>,
	linuxppc-dev@ozlabs.org, Andy Fleming <afleming@freescale.com>,
	Li Yang <leoli@freescale.com>, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

open() routine calls stop() in case of errors, the function will try
to free the requested IRQ. But we don't know if it was actually
requested, so the code might issue bogus free_irq(0, dev) call.

Fix this by rearranging the code so that now request_irq() is the last
call in the open() routine, and move free_irq() into the close().

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/net/ucc_geth.c |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
index 98a7bd4..1ba2855 100644
--- a/drivers/net/ucc_geth.c
+++ b/drivers/net/ucc_geth.c
@@ -2300,8 +2300,6 @@ static void ucc_geth_stop(struct ucc_geth_private *ugeth)
 	tempval &= ~(MACCFG1_ENABLE_RX | MACCFG1_ENABLE_TX);
 	out_be32(&ug_regs->maccfg1, tempval);
 
-	free_irq(ugeth->ug_info->uf_info.irq, ugeth->dev);
-
 	ucc_geth_memclean(ugeth);
 }
 
@@ -3761,21 +3759,20 @@ static int ucc_geth_open(struct net_device *dev)
 
 	phy_start(ugeth->phydev);
 
-	err =
-	    request_irq(ugeth->ug_info->uf_info.irq, ucc_geth_irq_handler, 0,
-			"UCC Geth", dev);
+	err = ugeth_enable(ugeth, COMM_DIR_RX_AND_TX);
 	if (err) {
 		if (netif_msg_ifup(ugeth))
-			ugeth_err("%s: Cannot get IRQ for net device, aborting.",
-				  dev->name);
+			ugeth_err("%s: Cannot enable net device, aborting.", dev->name);
 		ucc_geth_stop(ugeth);
 		goto out_err;
 	}
 
-	err = ugeth_enable(ugeth, COMM_DIR_RX_AND_TX);
+	err = request_irq(ugeth->ug_info->uf_info.irq, ucc_geth_irq_handler,
+			  0, "UCC Geth", dev);
 	if (err) {
 		if (netif_msg_ifup(ugeth))
-			ugeth_err("%s: Cannot enable net device, aborting.", dev->name);
+			ugeth_err("%s: Cannot get IRQ for net device, aborting.",
+				  dev->name);
 		ucc_geth_stop(ugeth);
 		goto out_err;
 	}
@@ -3801,6 +3798,8 @@ static int ucc_geth_close(struct net_device *dev)
 
 	ucc_geth_stop(ugeth);
 
+	free_irq(ugeth->ug_info->uf_info.irq, ugeth->dev);
+
 	phy_disconnect(ugeth->phydev);
 	ugeth->phydev = NULL;
 
-- 
1.5.6.5
