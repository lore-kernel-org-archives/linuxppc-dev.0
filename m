Return-Path: <rmk+linuxppc-embedded=ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[212.18.232.186])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 505BB688DC
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  6 Jan 2006 01:36:27 +1100 (EST)
To: LKML <linux-kernel@vger.kernel.org>
Date: Thu, 05 Jan 2006 14:36:16 +0000
Message-ID: <20060105142951.13.13@flint.arm.linux.org.uk>
In-reply-to: <20060105142951.13.01@flint.arm.linux.org.uk>
References: <20060105142951.13.01@flint.arm.linux.org.uk>
From: Russell King <rmk@arm.linux.org.uk>
Cc: Greg K-H <greg@kroah.com>, PowerPC <linuxppc-embedded@ozlabs.org>
Subject: [CFT 13/29] Add of_platform_bus_type probe and remove methods
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

---
 arch/powerpc/kernel/of_device.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej -x .git linus/arch/powerpc/kernel/of_device.c linux/arch/powerpc/kernel/of_device.c
--- linus/arch/powerpc/kernel/of_device.c	Mon Oct 31 07:31:59 2005
+++ linux/arch/powerpc/kernel/of_device.c	Sun Nov 13 16:12:38 2005
@@ -132,6 +132,8 @@ static int of_device_resume(struct devic
 struct bus_type of_platform_bus_type = {
        .name	= "of_platform",
        .match	= of_platform_bus_match,
+       .probe	= of_device_probe,
+       .remove	= of_device_remove,
        .suspend	= of_device_suspend,
        .resume	= of_device_resume,
 };
@@ -150,8 +152,6 @@ int of_register_driver(struct of_platfor
 	/* initialize common driver fields */
 	drv->driver.name = drv->name;
 	drv->driver.bus = &of_platform_bus_type;
-	drv->driver.probe = of_device_probe;
-	drv->driver.remove = of_device_remove;
 
 	/* register with core */
 	count = driver_register(&drv->driver);
