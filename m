Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wmzcD1xMCzDqNy
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 15:59:24 +1000 (AEST)
Subject: patch "powerpc: vio: use dev_groups and not dev_attrs for bus_type"
 added to driver-core-next
To: gregkh@linuxfoundation.org, aik@ozlabs.ru, bart.vanassche@sandisk.com,
 benh@kernel.crashing.org, johan@kernel.org, jroedel@suse.de, krzk@kernel.org,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, paulus@samba.org,
 robin.murphy@arm.com, vgupta@synopsys.com
From: <gregkh@linuxfoundation.org>
Date: Tue, 13 Jun 2017 07:59:03 +0200
Message-ID: <14973335435310@kroah.com>
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

    powerpc: vio: use dev_groups and not dev_attrs for bus_type

to my driver-core git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
in the driver-core-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


>From 451e3f1a740d2b453c7358a07421d427315483e6 Mon Sep 17 00:00:00 2001
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 6 Jun 2017 14:26:12 +0200
Subject: powerpc: vio: use dev_groups and not dev_attrs for bus_type

The dev_attrs field has long been "depreciated" and is finally being
removed, so move the driver to use the "correct" dev_groups field
instead for struct bus_type.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Johan Hovold <johan@kernel.org>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: <linuxppc-dev@lists.ozlabs.org>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/platforms/pseries/vio.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/vio.c b/arch/powerpc/platforms/pseries/vio.c
index 28b09fd797ec..b4f679e3ca3a 100644
--- a/arch/powerpc/platforms/pseries/vio.c
+++ b/arch/powerpc/platforms/pseries/vio.c
@@ -1537,6 +1537,7 @@ static ssize_t name_show(struct device *dev,
 {
 	return sprintf(buf, "%s\n", to_vio_dev(dev)->name);
 }
+static DEVICE_ATTR_RO(name);
 
 static ssize_t devspec_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
@@ -1545,6 +1546,7 @@ static ssize_t devspec_show(struct device *dev,
 
 	return sprintf(buf, "%s\n", of_node_full_name(of_node));
 }
+static DEVICE_ATTR_RO(devspec);
 
 static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
@@ -1566,13 +1568,15 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 
 	return sprintf(buf, "vio:T%sS%s\n", vio_dev->type, cp);
 }
+static DEVICE_ATTR_RO(modalias);
 
-static struct device_attribute vio_dev_attrs[] = {
-	__ATTR_RO(name),
-	__ATTR_RO(devspec),
-	__ATTR_RO(modalias),
-	__ATTR_NULL
+static struct attribute *vio_dev_attrs[] = {
+	&dev_attr_name.attr,
+	&dev_attr_devspec.attr,
+	&dev_attr_modalias.attr,
+	NULL,
 };
+ATTRIBUTE_GROUPS(vio_dev);
 
 void vio_unregister_device(struct vio_dev *viodev)
 {
@@ -1608,7 +1612,7 @@ static int vio_hotplug(struct device *dev, struct kobj_uevent_env *env)
 
 struct bus_type vio_bus_type = {
 	.name = "vio",
-	.dev_attrs = vio_dev_attrs,
+	.dev_groups = vio_dev_groups,
 	.uevent = vio_hotplug,
 	.match = vio_bus_match,
 	.probe = vio_bus_probe,
-- 
2.13.1
