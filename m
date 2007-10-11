Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id EAA46DDFBB
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 22:48:05 +1000 (EST)
Date: Thu, 11 Oct 2007 16:48:21 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: netdev@vger.kernel.org
Subject: [PATCH respin] ucc_geth: fix module removal
Message-ID: <20071011124821.GA13963@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: linuxppc-dev@ozlabs.org, leoli@freescale.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

- uccf should be set to NULL to not double-free memory on
  subsequent calls;
- ind_hash_q and group_hash_q lists should be initialized in the
  probe() function, instead of struct_init() (called by open()),
  otherwise there will be an oops if ucc_geth_driver removed
  prior 'ifconfig ethX up';
- add unregister_netdev();
- reorder geth_remove() steps.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/net/ucc_geth.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
index 7dedc96..18a6f48 100644
--- a/drivers/net/ucc_geth.c
+++ b/drivers/net/ucc_geth.c
@@ -2080,8 +2080,10 @@ static void ucc_geth_memclean(struct ucc_geth_private *ugeth)
 	if (!ugeth)
 		return;
 
-	if (ugeth->uccf)
+	if (ugeth->uccf) {
 		ucc_fast_free(ugeth->uccf);
+		ugeth->uccf = NULL;
+	}
 
 	if (ugeth->p_thread_data_tx) {
 		qe_muram_free(ugeth->thread_dat_tx_offset);
@@ -2312,10 +2314,6 @@ static int ucc_struct_init(struct ucc_geth_private *ugeth)
 	ug_info = ugeth->ug_info;
 	uf_info = &ug_info->uf_info;
 
-	/* Create CQs for hash tables */
-	INIT_LIST_HEAD(&ugeth->group_hash_q);
-	INIT_LIST_HEAD(&ugeth->ind_hash_q);
-
 	if (!((uf_info->bd_mem_part == MEM_PART_SYSTEM) ||
 	      (uf_info->bd_mem_part == MEM_PART_MURAM))) {
 		if (netif_msg_probe(ugeth))
@@ -3949,6 +3947,10 @@ static int ucc_geth_probe(struct of_device* ofdev, const struct of_device_id *ma
 	ugeth = netdev_priv(dev);
 	spin_lock_init(&ugeth->lock);
 
+	/* Create CQs for hash tables */
+	INIT_LIST_HEAD(&ugeth->group_hash_q);
+	INIT_LIST_HEAD(&ugeth->ind_hash_q);
+
 	dev_set_drvdata(device, dev);
 
 	/* Set the dev->base_addr to the gfar reg region */
@@ -4002,9 +4004,10 @@ static int ucc_geth_remove(struct of_device* ofdev)
 	struct net_device *dev = dev_get_drvdata(device);
 	struct ucc_geth_private *ugeth = netdev_priv(dev);
 
-	dev_set_drvdata(device, NULL);
-	ucc_geth_memclean(ugeth);
+	unregister_netdev(dev);
 	free_netdev(dev);
+	ucc_geth_memclean(ugeth);
+	dev_set_drvdata(device, NULL);
 
 	return 0;
 }
-- 
1.5.0.6
