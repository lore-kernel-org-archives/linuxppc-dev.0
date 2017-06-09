Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wkbrT3xyNzDqPQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Jun 2017 19:01:45 +1000 (AEST)
Subject: patch "powerpc: ibmebus: use dev_groups and not dev_attrs for
 bus_type" added to driver-core-testing
To: gregkh@linuxfoundation.org, bart.vanassche@sandisk.com,
 benh@kernel.crashing.org, johan@kernel.org, lars@metafoo.de,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, paulus@samba.org,
 robh@kernel.org, robin.murphy@arm.com
From: <gregkh@linuxfoundation.org>
Date: Fri, 09 Jun 2017 11:01:04 +0200
Message-ID: <149699886415320@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


This is a note to let you know that I've just added the patch titled

    powerpc: ibmebus: use dev_groups and not dev_attrs for bus_type

to my driver-core git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
in the driver-core-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the driver-core-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


>From 823a44ac23d107b8450f413e32d83c9ed82410ff Mon Sep 17 00:00:00 2001
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 6 Jun 2017 14:17:22 +0200
Subject: powerpc: ibmebus: use dev_groups and not dev_attrs for bus_type

The dev_attrs field has long been "depreciated" and is finally being
removed, so move the driver to use the "correct" dev_groups field
instead for struct bus_type.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Johan Hovold <johan@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: <linuxppc-dev@lists.ozlabs.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/platforms/pseries/ibmebus.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/ibmebus.c b/arch/powerpc/platforms/pseries/ibmebus.c
index b363e439ddb9..52146b1356d2 100644
--- a/arch/powerpc/platforms/pseries/ibmebus.c
+++ b/arch/powerpc/platforms/pseries/ibmebus.c
@@ -397,6 +397,7 @@ static ssize_t devspec_show(struct device *dev,
 	ofdev = to_platform_device(dev);
 	return sprintf(buf, "%s\n", ofdev->dev.of_node->full_name);
 }
+static DEVICE_ATTR_RO(devspec);
 
 static ssize_t name_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
@@ -406,19 +407,22 @@ static ssize_t name_show(struct device *dev,
 	ofdev = to_platform_device(dev);
 	return sprintf(buf, "%s\n", ofdev->dev.of_node->name);
 }
+static DEVICE_ATTR_RO(name);
 
 static ssize_t modalias_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	return of_device_modalias(dev, buf, PAGE_SIZE);
 }
+static DEVICE_ATTR_RO(modalias);
 
-static struct device_attribute ibmebus_bus_device_attrs[] = {
-	__ATTR_RO(devspec),
-	__ATTR_RO(name),
-	__ATTR_RO(modalias),
-	__ATTR_NULL
+static struct attribute *ibmebus_bus_device_attrs[] = {
+	&dev_attr_devspec.attr,
+	&dev_attr_name.attr,
+	&dev_attr_modalias.attr,
+	NULL,
 };
+ATTRIBUTE_GROUPS(ibmebus_bus_device);
 
 struct bus_type ibmebus_bus_type = {
 	.name      = "ibmebus",
@@ -428,7 +432,7 @@ struct bus_type ibmebus_bus_type = {
 	.probe     = ibmebus_bus_device_probe,
 	.remove    = ibmebus_bus_device_remove,
 	.shutdown  = ibmebus_bus_device_shutdown,
-	.dev_attrs = ibmebus_bus_device_attrs,
+	.dev_groups = ibmebus_bus_device_groups,
 };
 EXPORT_SYMBOL(ibmebus_bus_type);
 
-- 
2.13.1
