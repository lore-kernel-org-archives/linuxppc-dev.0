Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F2B292C00D2
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Mar 2014 18:35:41 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 4 Mar 2014 02:35:38 -0500
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 730476E8041
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Mar 2014 02:35:31 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23033.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s247ZamR29491248
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Mar 2014 07:35:36 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s247Za2U004118
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Mar 2014 02:35:36 -0500
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] net/mlx4: Support shutdown() interface
Date: Tue,  4 Mar 2014 15:35:20 +0800
Message-Id: <1393918520-3268-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: weiyang@linux.vnet.ibm.com, amirv@mellanox.com, davem@davemloft.net,
 Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In kexec scenario, we failed to load the mlx4 driver in the
second kernel because the ownership bit was hold by the first
kernel without release correctly.

The patch adds shutdown() interface so that the ownership can
be released correctly in the first kernel. It also helps avoiding
EEH error happened during boot stage of the second kernel because
of undesired traffic, which can't be handled by hardware during
that stage on Power platform.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
Tested-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 drivers/net/ethernet/mellanox/mlx4/main.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx4/main.c b/drivers/net/ethernet/mellanox/mlx4/main.c
index d711158..5a6105f 100644
--- a/drivers/net/ethernet/mellanox/mlx4/main.c
+++ b/drivers/net/ethernet/mellanox/mlx4/main.c
@@ -2684,6 +2684,7 @@ static struct pci_driver mlx4_driver = {
 	.name		= DRV_NAME,
 	.id_table	= mlx4_pci_table,
 	.probe		= mlx4_init_one,
+	.shutdown	= mlx4_remove_one,
 	.remove		= mlx4_remove_one,
 	.err_handler    = &mlx4_err_handler,
 };
-- 
1.7.10.4
