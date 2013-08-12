Return-Path: <libo.chen@huawei.com>
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [119.145.14.64])
 (using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
 (Client CN "myname.my.domain", Issuer "www.mirapoint.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 07C392C0103
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Aug 2013 23:31:17 +1000 (EST)
Message-ID: <5208E21A.3020805@huawei.com>
Date: Mon, 12 Aug 2013 21:24:42 +0800
From: Libo Chen <clbchenlibo.chen@huawei.com>
MIME-Version: 1.0
To: <leoli@freescale.com>, David Miller <davem@davemloft.net>
Subject: [PATCH 2/8] net: ucc_geth: use platform_{get,set}_drvdata()
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
 drivers/net/ethernet/freescale/ucc_geth.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
index 3c43dac..5930c39 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.c
+++ b/drivers/net/ethernet/freescale/ucc_geth.c
@@ -3911,14 +3911,12 @@ static int ucc_geth_probe(struct platform_device* ofdev)

 static int ucc_geth_remove(struct platform_device* ofdev)
 {
-	struct device *device = &ofdev->dev;
-	struct net_device *dev = dev_get_drvdata(device);
+	struct net_device *dev = platform_get_drvdata(ofdev);
 	struct ucc_geth_private *ugeth = netdev_priv(dev);

 	unregister_netdev(dev);
 	free_netdev(dev);
 	ucc_geth_memclean(ugeth);
-	dev_set_drvdata(device, NULL);

 	return 0;
 }
-- 
1.7.1
