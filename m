Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wj1pc4q1PzDqLL
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jun 2017 05:24:40 +1000 (AEST)
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Bart Van Assche <bart.vanassche@sandisk.com>,
 Johan Hovold <johan@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Rob Herring <robh@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 09/16] powerpc: ibmebus: use dev_groups and not dev_attrs for
 bus_type
Date: Tue,  6 Jun 2017 21:22:14 +0200
Message-Id: <20170606192221.1617-10-gregkh@linuxfoundation.org>
In-Reply-To: <20170606192221.1617-1-gregkh@linuxfoundation.org>
References: <20170606192221.1617-1-gregkh@linuxfoundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

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
2.13.0
