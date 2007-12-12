Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C2D1ADDFB3
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 03:45:46 +1100 (EST)
Message-ID: <47601027.2080104@scram.de>
Date: Wed, 12 Dec 2007 17:45:27 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: [PATCH/RFC] [POWERPC] Add fixed-phy support for fs_enet
Content-Type: text/plain; charset=ISO-8859-15
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds support to use the fixed-link property
of an ethernet node to fs_enet for the
CONFIG_PPC_CPM_NEW_BINDING case.

Signed-off-by: Jochen Friedrich <jochen@scram.de>
---
 drivers/net/fs_enet/fs_enet-main.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/net/fs_enet/fs_enet-main.c b/drivers/net/fs_enet/fs_enet-main.c
index f2a4d39..8220c70 100644
--- a/drivers/net/fs_enet/fs_enet-main.c
+++ b/drivers/net/fs_enet/fs_enet-main.c
@@ -1174,8 +1174,15 @@ static int __devinit find_phy(struct device_node *np,
 	struct device_node *phynode, *mdionode;
 	struct resource res;
 	int ret = 0, len;
+	const u32 *data;
+
+	data  = of_get_property(np, "fixed-link", NULL);
+	if (data) {
+		snprintf(fpi->bus_id, 16, PHY_ID_FMT, 0, *data);
+		return 0;
+	}

-	const u32 *data = of_get_property(np, "phy-handle", &len);
+	data = of_get_property(np, "phy-handle", &len);
 	if (!data || len != 4)
 		return -EINVAL;

-- 
1.5.3.7
