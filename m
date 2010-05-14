Return-Path: <avorontsov@mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 6C9D8B7DE9
	for <linuxppc-dev@ozlabs.org>; Sat, 15 May 2010 00:27:44 +1000 (EST)
Date: Fri, 14 May 2010 18:27:30 +0400
From: Anton Vorontsov <avorontsov@mvista.com>
To: David Miller <davem@davemloft.net>
Subject: [PATCH] fsl_pq_mdio: Fix mdiobus allocation handling
Message-ID: <20100514142730.GA13137@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The driver could return success code even if mdiobus_alloc() failed.
This patch fixes the issue.

Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
---
 drivers/net/fsl_pq_mdio.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/fsl_pq_mdio.c b/drivers/net/fsl_pq_mdio.c
index 3acac5f..ff028f5 100644
--- a/drivers/net/fsl_pq_mdio.c
+++ b/drivers/net/fsl_pq_mdio.c
@@ -277,15 +277,17 @@ static int fsl_pq_mdio_probe(struct of_device *ofdev,
 	int tbiaddr = -1;
 	const u32 *addrp;
 	u64 addr = 0, size = 0;
-	int err = 0;
+	int err;
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
 	new_bus = mdiobus_alloc();
-	if (NULL == new_bus)
+	if (!new_bus) {
+		err = -ENOMEM;
 		goto err_free_priv;
+	}
 
 	new_bus->name = "Freescale PowerQUICC MII Bus",
 	new_bus->read = &fsl_pq_mdio_read,
-- 
1.7.0.5
