Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wj1pk4CqJzDqL3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jun 2017 05:24:46 +1000 (AEST)
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Vineet Gupta <vgupta@synopsys.com>,
 Bart Van Assche <bart.vanassche@sandisk.com>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>,
 Johan Hovold <johan@kernel.org>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Krzysztof Kozlowski <krzk@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 11/16] powerpc: vio_cmo: use dev_groups and not dev_attrs for
 bus_type
Date: Tue,  6 Jun 2017 21:22:16 +0200
Message-Id: <20170606192221.1617-12-gregkh@linuxfoundation.org>
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
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Johan Hovold <johan@kernel.org>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: <linuxppc-dev@lists.ozlabs.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/platforms/pseries/vio.c | 37 +++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/vio.c b/arch/powerpc/platforms/pseries/vio.c
index fd6595598662..176edf422867 100644
--- a/arch/powerpc/platforms/pseries/vio.c
+++ b/arch/powerpc/platforms/pseries/vio.c
@@ -948,7 +948,7 @@ static void vio_cmo_bus_init(void)
 /* sysfs device functions and data structures for CMO */
 
 #define viodev_cmo_rd_attr(name)                                        \
-static ssize_t viodev_cmo_##name##_show(struct device *dev,             \
+static ssize_t cmo_##name##_show(struct device *dev,                    \
                                         struct device_attribute *attr,  \
                                          char *buf)                     \
 {                                                                       \
@@ -962,7 +962,7 @@ static ssize_t viodev_cmo_allocs_failed_show(struct device *dev,
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
@@ -993,18 +993,25 @@ static ssize_t name_show(struct device *, struct device_attribute *, char *);
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
+static DEVICE_ATTR_RO(name);
+static DEVICE_ATTR_RO(devspec);
+static DEVICE_ATTR_RO(modalias);
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
 
@@ -1066,7 +1073,7 @@ ATTRIBUTE_GROUPS(vio_bus);
 
 static void vio_cmo_sysfs_init(void)
 {
-	vio_bus_type.dev_attrs = vio_cmo_dev_attrs;
+	vio_bus_type.dev_groups = vio_cmo_dev_groups;
 	vio_bus_type.bus_groups = vio_bus_groups;
 }
 #else /* CONFIG_PPC_SMLPAR */
-- 
2.13.0
