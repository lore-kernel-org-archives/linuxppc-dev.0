Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wmzcG3xl2zDqLp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 15:59:26 +1000 (AEST)
Subject: patch "powerpc: vio_cmo: use dev_groups and not dev_attrs for
 bus_type" added to driver-core-next
To: gregkh@linuxfoundation.org, aik@ozlabs.ru, bart.vanassche@sandisk.com,
 benh@kernel.crashing.org, johan@kernel.org, jroedel@suse.de, krzk@kernel.org,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, paulus@samba.org,
 robin.murphy@arm.com, vgupta@synopsys.com
From: <gregkh@linuxfoundation.org>
Date: Tue, 13 Jun 2017 07:59:04 +0200
Message-ID: <149733354414586@kroah.com>
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

    powerpc: vio_cmo: use dev_groups and not dev_attrs for bus_type

to my driver-core git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
in the driver-core-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


>From 205a1ee15d924df412cb8bdefafafc5b53b21153 Mon Sep 17 00:00:00 2001
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 6 Jun 2017 14:17:27 +0200
Subject: powerpc: vio_cmo: use dev_groups and not dev_attrs for bus_type

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
 arch/powerpc/platforms/pseries/vio.c | 56 +++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/vio.c b/arch/powerpc/platforms/pseries/vio.c
index b4f679e3ca3a..117beb9e8786 100644
--- a/arch/powerpc/platforms/pseries/vio.c
+++ b/arch/powerpc/platforms/pseries/vio.c
@@ -948,21 +948,21 @@ static void vio_cmo_bus_init(void)
 /* sysfs device functions and data structures for CMO */
 
 #define viodev_cmo_rd_attr(name)                                        \
-static ssize_t viodev_cmo_##name##_show(struct device *dev,             \
+static ssize_t cmo_##name##_show(struct device *dev,                    \
                                         struct device_attribute *attr,  \
                                          char *buf)                     \
 {                                                                       \
 	return sprintf(buf, "%lu\n", to_vio_dev(dev)->cmo.name);        \
 }
 
-static ssize_t viodev_cmo_allocs_failed_show(struct device *dev,
+static ssize_t cmo_allocs_failed_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct vio_dev *viodev = to_vio_dev(dev);
 	return sprintf(buf, "%d\n", atomic_read(&viodev->cmo.allocs_failed));
 }
 
-static ssize_t viodev_cmo_allocs_failed_reset(struct device *dev,
+static ssize_t cmo_allocs_failed_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct vio_dev *viodev = to_vio_dev(dev);
@@ -970,7 +970,7 @@ static ssize_t viodev_cmo_allocs_failed_reset(struct device *dev,
 	return count;
 }
 
-static ssize_t viodev_cmo_desired_set(struct device *dev,
+static ssize_t cmo_desired_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct vio_dev *viodev = to_vio_dev(dev);
@@ -993,27 +993,37 @@ static ssize_t name_show(struct device *, struct device_attribute *, char *);
 static ssize_t devspec_show(struct device *, struct device_attribute *, char *);
 static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 			     char *buf);
-static struct device_attribute vio_cmo_dev_attrs[] = {
-	__ATTR_RO(name),
-	__ATTR_RO(devspec),
-	__ATTR_RO(modalias),
-	__ATTR(cmo_desired,       S_IWUSR|S_IRUSR|S_IWGRP|S_IRGRP|S_IROTH,
-	       viodev_cmo_desired_show, viodev_cmo_desired_set),
-	__ATTR(cmo_entitled,      S_IRUGO, viodev_cmo_entitled_show,      NULL),
-	__ATTR(cmo_allocated,     S_IRUGO, viodev_cmo_allocated_show,     NULL),
-	__ATTR(cmo_allocs_failed, S_IWUSR|S_IRUSR|S_IWGRP|S_IRGRP|S_IROTH,
-	       viodev_cmo_allocs_failed_show, viodev_cmo_allocs_failed_reset),
-	__ATTR_NULL
+
+static struct device_attribute dev_attr_name;
+static struct device_attribute dev_attr_devspec;
+static struct device_attribute dev_attr_modalias;
+
+static DEVICE_ATTR_RO(cmo_entitled);
+static DEVICE_ATTR_RO(cmo_allocated);
+static DEVICE_ATTR_RW(cmo_desired);
+static DEVICE_ATTR_RW(cmo_allocs_failed);
+
+static struct attribute *vio_cmo_dev_attrs[] = {
+	&dev_attr_name.attr,
+	&dev_attr_devspec.attr,
+	&dev_attr_modalias.attr,
+	&dev_attr_cmo_entitled.attr,
+	&dev_attr_cmo_allocated.attr,
+	&dev_attr_cmo_desired.attr,
+	&dev_attr_cmo_allocs_failed.attr,
+	NULL,
 };
+ATTRIBUTE_GROUPS(vio_cmo_dev);
 
 /* sysfs bus functions and data structures for CMO */
 
 #define viobus_cmo_rd_attr(name)                                        \
-static ssize_t cmo_##name##_show(struct bus_type *bt, char *buf)        \
+static ssize_t cmo_bus_##name##_show(struct bus_type *bt, char *buf)    \
 {                                                                       \
 	return sprintf(buf, "%lu\n", vio_cmo.name);                     \
 }                                                                       \
-static BUS_ATTR_RO(cmo_##name)
+static struct bus_attribute bus_attr_cmo_bus_##name =			\
+	__ATTR(cmo_##name, S_IRUGO, cmo_bus_##name##_show, NULL)
 
 #define viobus_cmo_pool_rd_attr(name, var)                              \
 static ssize_t                                                          \
@@ -1051,11 +1061,11 @@ static ssize_t cmo_high_store(struct bus_type *bt, const char *buf,
 static BUS_ATTR_RW(cmo_high);
 
 static struct attribute *vio_bus_attrs[] = {
-	&bus_attr_cmo_entitled.attr,
-	&bus_attr_cmo_spare.attr,
-	&bus_attr_cmo_min.attr,
-	&bus_attr_cmo_desired.attr,
-	&bus_attr_cmo_curr.attr,
+	&bus_attr_cmo_bus_entitled.attr,
+	&bus_attr_cmo_bus_spare.attr,
+	&bus_attr_cmo_bus_min.attr,
+	&bus_attr_cmo_bus_desired.attr,
+	&bus_attr_cmo_bus_curr.attr,
 	&bus_attr_cmo_high.attr,
 	&bus_attr_cmo_reserve_size.attr,
 	&bus_attr_cmo_excess_size.attr,
@@ -1066,7 +1076,7 @@ ATTRIBUTE_GROUPS(vio_bus);
 
 static void vio_cmo_sysfs_init(void)
 {
-	vio_bus_type.dev_attrs = vio_cmo_dev_attrs;
+	vio_bus_type.dev_groups = vio_cmo_dev_groups;
 	vio_bus_type.bus_groups = vio_bus_groups;
 }
 #else /* CONFIG_PPC_SMLPAR */
-- 
2.13.1
