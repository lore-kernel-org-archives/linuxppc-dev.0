Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id B38B0DE02B
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 09:29:28 +1000 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/5] gianfar: assign mii_bus value in dev->priv
Date: Thu, 10 Apr 2008 13:51:59 -0400
Message-Id: <d0000263c8e632d0bc29242782cdb2e3158e7e41.1207846542.git.paul.gortmaker@windriver.com>
In-Reply-To: <4764055962e0a42ce083783bbb897a62090ad90b.1207846542.git.paul.gortmaker@windriver.com>
References: <1207849922-2436-1-git-send-email-paul.gortmaker@windriver.com>
	<4764055962e0a42ce083783bbb897a62090ad90b.1207846542.git.paul.gortmaker@windriver.com>
In-Reply-To: <4764055962e0a42ce083783bbb897a62090ad90b.1207846542.git.paul.gortmaker@windriver.com>
References: <4764055962e0a42ce083783bbb897a62090ad90b.1207846542.git.paul.gortmaker@windriver.com>
Cc: scottwood@freescale.com, linux-net@vger.kernel.org,
	Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The gianfar priv struct has an entry for the mii_bus, but it
isn't being populated.  Assign a value for it at the same time
as we assign the phydev, so that it can be used in calls like
gianfar_mdio_read/write.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/net/gianfar.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/net/gianfar.c b/drivers/net/gianfar.c
index 718cf77..0ad74c1 100644
--- a/drivers/net/gianfar.c
+++ b/drivers/net/gianfar.c
@@ -471,6 +471,7 @@ static int init_phy(struct net_device *dev)
 	phydev->supported &= (GFAR_SUPPORTED | gigabit_support);
 	phydev->advertising = phydev->supported;
 
+	priv->mii_bus = phydev->bus;
 	priv->phydev = phydev;
 
 	return 0;
-- 
1.5.4.3
