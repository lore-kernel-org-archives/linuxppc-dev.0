Return-Path: <bjorn@mork.no>
Received: from canardo.mork.no (canardo.mork.no [IPv6:2001:4620:9::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "canardo.mork.no", Issuer "Mork CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CF39BB700C
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 May 2012 01:53:13 +1000 (EST)
From: =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
To: David Miller <davem@davemloft.net>
Subject: [PATCH] net: of/phy: fix build error when phylib is built as a module
Date: Fri, 11 May 2012 17:47:01 +0200
Message-Id: <1336751221-19127-1-git-send-email-bjorn@mork.no>
In-Reply-To: <20120510.224352.2149006669429730060.davem@davemloft.net>
References: <20120510.224352.2149006669429730060.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: sfr@canb.auug.org.au, david.daney@cavium.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com,
 rdunlap@xenotime.net, linux-next@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CONFIG_OF_MDIO is tristate and will be m if PHYLIB is m.  Use
IS_ENABLED macro to prevent build error:

 ERROR: "of_mdio_find_bus" [drivers/net/phy/mdio-mux.ko] undefined!

Reported-by: Randy Dunlap <rdunlap@xenotime.net>
Cc: David Daney <david.daney@cavium.com>
Signed-off-by: Bjørn Mork <bjorn@mork.no>
---
I wonder if this could be as banal as this?  Not even build tested...

Should be wrapped into commit 25106022 if it works, to ensure
bisectability.



Bjørn

 drivers/net/phy/mdio_bus.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 83d5c9f..683ef1c 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -88,7 +88,7 @@ static struct class mdio_bus_class = {
 	.dev_release	= mdiobus_release,
 };
 
-#ifdef CONFIG_OF_MDIO
+#if IS_ENABLED(CONFIG_OF_MDIO)
 /* Helper function for of_mdio_find_bus */
 static int of_mdio_bus_match(struct device *dev, void *mdio_bus_np)
 {
-- 
1.7.10
