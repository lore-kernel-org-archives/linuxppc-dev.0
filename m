Return-Path: <rmk+linuxppc-dev=ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[212.18.232.186])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D96A1689BA
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jan 2006 01:39:34 +1100 (EST)
To: LKML <linux-kernel@vger.kernel.org>
Date: Thu, 05 Jan 2006 14:39:24 +0000
Message-ID: <20060105142951.13.19@flint.arm.linux.org.uk>
In-reply-to: <20060105142951.13.01@flint.arm.linux.org.uk>
References: <20060105142951.13.01@flint.arm.linux.org.uk>
From: Russell King <rmk@arm.linux.org.uk>
Cc: Greg K-H <greg@kroah.com>, MAC <linuxppc-dev@ozlabs.org>
Subject: [CFT 19/29] Add macio_bus_type probe and remove methods
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

---
 drivers/macintosh/macio_asic.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej -x .git linus/drivers/macintosh/macio_asic.c linux/drivers/macintosh/macio_asic.c
--- linus/drivers/macintosh/macio_asic.c	Sun Nov  6 22:16:28 2005
+++ linux/drivers/macintosh/macio_asic.c	Sun Nov 13 16:28:39 2005
@@ -204,6 +204,9 @@ struct bus_type macio_bus_type = {
        .name	= "macio",
        .match	= macio_bus_match,
        .hotplug = macio_hotplug,
+       .probe	= macio_device_probe,
+       .remove	= macio_device_remove,
+       .shutdown = macio_device_shutdown,
        .suspend	= macio_device_suspend,
        .resume	= macio_device_resume,
        .dev_attrs = macio_dev_attrs,
@@ -487,9 +490,6 @@ int macio_register_driver(struct macio_d
 	/* initialize common driver fields */
 	drv->driver.name = drv->name;
 	drv->driver.bus = &macio_bus_type;
-	drv->driver.probe = macio_device_probe;
-	drv->driver.remove = macio_device_remove;
-	drv->driver.shutdown = macio_device_shutdown;
 
 	/* register with core */
 	count = driver_register(&drv->driver);
