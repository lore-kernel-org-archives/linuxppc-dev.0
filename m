Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <bb8d7cc1a060af291ef6efb0f4222f81fa91f417.1200999872.git.michael@ellerman.id.au>
In-Reply-To: <3ce7be4c77581ce103a8da9f33a734270c9dc6e8.1200999872.git.michael@ellerman.id.au>
References: <3ce7be4c77581ce103a8da9f33a734270c9dc6e8.1200999872.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 2/4] Create and hook up of_platform_device_shutdown
Date: Tue, 22 Jan 2008 22:04:40 +1100 (EST)
Cc: cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Although of_platform_device's can have a shutdown routine, at the moment
the bus code doesn't actually call it. So add the required glue to
hook the shutdown routine.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 drivers/of/platform.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index b47bb2d..9152479 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -85,6 +85,15 @@ static int of_platform_device_resume(struct device * dev)
 	return error;
 }
 
+static void of_platform_device_shutdown(struct device * dev)
+{
+	struct of_device *of_dev = to_of_device(dev);
+	struct of_platform_driver *drv = to_of_platform_driver(dev->driver);
+
+	if (dev->driver && drv->shutdown)
+		drv->shutdown(of_dev);
+}
+
 int of_bus_type_init(struct bus_type *bus, const char *name)
 {
 	bus->name = name;
@@ -93,6 +102,7 @@ int of_bus_type_init(struct bus_type *bus, const char *name)
 	bus->remove = of_platform_device_remove;
 	bus->suspend = of_platform_device_suspend;
 	bus->resume = of_platform_device_resume;
+	bus->shutdown = of_platform_device_shutdown;
 	return bus_register(bus);
 }
 
-- 
1.5.2.rc1.1884.g59b20
