Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 86355DDF17
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Dec 2008 05:23:37 +1100 (EST)
Date: Thu, 18 Dec 2008 21:23:33 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH 5/6] ucc_geth: Fix IO memory (un)mapping code
Message-ID: <20081218182333.GE30682@oksana.dev.rtsoft.ru>
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

The driver doesn't check ioremap() return value, and doesn't free the
remapped memory.

This patch fixes it.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/net/ucc_geth.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
index 70208c6..20c065c 100644
--- a/drivers/net/ucc_geth.c
+++ b/drivers/net/ucc_geth.c
@@ -2218,7 +2218,10 @@ static void ucc_geth_memclean(struct ucc_geth_private *ugeth)
 	while (!list_empty(&ugeth->ind_hash_q))
 		put_enet_addr_container(ENET_ADDR_CONT_ENTRY
 					(dequeue(&ugeth->ind_hash_q)));
-
+	if (ugeth->ug_regs) {
+		iounmap(ugeth->ug_regs);
+		ugeth->ug_regs = NULL;
+	}
 }
 
 static void ucc_geth_set_multi(struct net_device *dev)
@@ -2423,7 +2426,12 @@ static int ucc_struct_init(struct ucc_geth_private *ugeth)
 		return -ENOMEM;
 	}
 
-	ugeth->ug_regs = (struct ucc_geth __iomem *) ioremap(uf_info->regs, sizeof(struct ucc_geth));
+	ugeth->ug_regs = ioremap(uf_info->regs, sizeof(*ugeth->ug_regs));
+	if (!ugeth->ug_regs) {
+		if (netif_msg_probe(ugeth))
+			ugeth_err("%s: Failed to ioremap regs.", __func__);
+		return -ENOMEM;
+	}
 
 	return 0;
 }
@@ -3691,7 +3699,7 @@ static int ucc_geth_open(struct net_device *dev)
 	if (err) {
 		if (netif_msg_ifup(ugeth))
 			ugeth_err("%s: Cannot configure internal struct, aborting.", dev->name);
-		return err;
+		goto out_err_stop;
 	}
 
 	napi_enable(&ugeth->napi);
@@ -3754,6 +3762,7 @@ static int ucc_geth_open(struct net_device *dev)
 
 out_err:
 	napi_disable(&ugeth->napi);
+out_err_stop:
 	ucc_geth_stop(ugeth);
 	return err;
 }
-- 
1.5.6.5
