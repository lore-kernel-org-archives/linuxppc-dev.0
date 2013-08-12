Return-Path: <libo.chen@huawei.com>
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [119.145.14.65])
 (using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
 (Client CN "myname.my.domain", Issuer "www.mirapoint.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4A8C02C0148
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Aug 2013 23:31:23 +1000 (EST)
Message-ID: <5208E222.60300@huawei.com>
Date: Mon, 12 Aug 2013 21:24:50 +0800
From: Libo Chen <clbchenlibo.chen@huawei.com>
MIME-Version: 1.0
To: <pantelis.antoniou@gmail.com>, <vbordug@ru.mvista.com>, David Miller
 <davem@davemloft.net>
Subject: [PATCH 4/8] net: fs_enet: use platform_{get,set}_drvdata()
Content-Type: text/plain; charset="ISO-8859-1"
Cc: netdev@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
 linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use the wrapper functions for getting and setting the driver data using
platform_device instead of using dev_{get,set}_drvdata() with &pdev->dev,
so we can directly pass a struct platform_device.

Signed-off-by: Libo Chen <libo.chen@huawei.com>
---
 .../net/ethernet/freescale/fs_enet/fs_enet-main.c  |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
index 8de53a1..7e3de10 100644
--- a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
+++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
@@ -1122,7 +1122,6 @@ static int fs_enet_remove(struct platform_device *ofdev)

 	fep->ops->free_bd(ndev);
 	fep->ops->cleanup_data(ndev);
-	dev_set_drvdata(fep->dev, NULL);
 	of_node_put(fep->fpi->phy_node);
 	free_netdev(ndev);
 	return 0;
-- 
1.7.1
