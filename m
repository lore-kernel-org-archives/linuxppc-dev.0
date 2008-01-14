Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 82A1EDDE04
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jan 2008 17:46:49 +1100 (EST)
Date: Mon, 14 Jan 2008 17:46:48 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] make ibmebus use of_(un)register_driver
Message-Id: <20080114174648.bca30b55.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Heiko J Schick <schickhj@de.ibm.com>,
	Joachim Fenkes <fenkes@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/ibmebus.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/ibmebus.c b/arch/powerpc/kernel/ibmebus.c
index 1844359..2a6a388 100644
--- a/arch/powerpc/kernel/ibmebus.c
+++ b/arch/powerpc/kernel/ibmebus.c
@@ -197,16 +197,13 @@ int ibmebus_register_driver(struct of_platform_driver *drv)
 	/* If the driver uses devices that ibmebus doesn't know, add them */
 	ibmebus_create_devices(drv->match_table);
 
-	drv->driver.name   = drv->name;
-	drv->driver.bus    = &ibmebus_bus_type;
-
-	return driver_register(&drv->driver);
+	return of_register_driver(drv, &ibmebus_bus_type);
 }
 EXPORT_SYMBOL(ibmebus_register_driver);
 
 void ibmebus_unregister_driver(struct of_platform_driver *drv)
 {
-	driver_unregister(&drv->driver);
+	of_unregister_driver(drv);
 }
 EXPORT_SYMBOL(ibmebus_unregister_driver);
 
-- 
1.5.3.8

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
