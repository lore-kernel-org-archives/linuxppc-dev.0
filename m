Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 8AF8DB7D06
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Nov 2009 11:11:06 +1100 (EST)
Date: Wed, 11 Nov 2009 03:11:05 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: David Miller <davem@davemloft.net>
Subject: [PATCH 3/6] gianfar: Fix build with CONFIG_PM=y
Message-ID: <20091111001105.GC8817@oksana.dev.rtsoft.ru>
References: <20091111001036.GA28576@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20091111001036.GA28576@oksana.dev.rtsoft.ru>
Cc: Jon Loeliger <jdl@jdl.com>, Kumar Gopalpet-B05799 <B05799@freescale.com>,
	netdev@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Andy Fleming <afleming@freescale.com>,
	Stephen Hemminger <shemminger@vyatta.com>,
	Lennert Buytenhek <buytenh@wantstofly.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

commit fba4ed030cfae7efdb6b79a57b0c5a9d72c9 ("gianfar: Add Multiple
Queue Support") introduced the following build failure:

  CC      gianfar.o
gianfar.c: In function 'gfar_restore':
gianfar.c:1249: error: request for member 'napi' in something not a structure or union

This patch fixes the issue.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/net/gianfar.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/gianfar.c b/drivers/net/gianfar.c
index 79c28f5..a5b0038 100644
--- a/drivers/net/gianfar.c
+++ b/drivers/net/gianfar.c
@@ -1246,7 +1246,7 @@ static int gfar_restore(struct device *dev)
 		phy_start(priv->phydev);
 
 	netif_device_attach(ndev);
-	napi_enable(&priv->gfargrp.napi);
+	enable_napi(priv);
 
 	return 0;
 }
-- 
1.6.3.3
