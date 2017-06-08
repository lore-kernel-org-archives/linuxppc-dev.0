Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wk5Rw4shmzDqLZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jun 2017 23:12:12 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Vineet Gupta <vgupta@synopsys.com>,
 Bart Van Assche <bart.vanassche@sandisk.com>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>,
 Johan Hovold <johan@kernel.org>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Krzysztof Kozlowski <krzk@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 11/16] powerpc: vio_cmo: use dev_groups and not dev_attrs
 for bus_type
In-Reply-To: <20170606192221.1617-12-gregkh@linuxfoundation.org>
References: <20170606192221.1617-1-gregkh@linuxfoundation.org>
 <20170606192221.1617-12-gregkh@linuxfoundation.org>
Date: Thu, 08 Jun 2017 23:12:10 +1000
Message-ID: <87y3t2d3o5.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> The dev_attrs field has long been "depreciated" and is finally being
> removed, so move the driver to use the "correct" dev_groups field
> instead for struct bus_type.
>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Vineet Gupta <vgupta@synopsys.com>
> Cc: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Joerg Roedel <jroedel@suse.de>
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: <linuxppc-dev@lists.ozlabs.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  arch/powerpc/platforms/pseries/vio.c | 37 +++++++++++++++++++++---------------
>  1 file changed, 22 insertions(+), 15 deletions(-)

This one needed a bit more work to get building, the incremental diff is
below. We need a forward declaration of name, devspec and modalias,
which is a bit weird, but that's how the code is currently structured.
And there's dev and bus attributes with the same name, so that needed an
added "bus".

I booted v2 of patch 10 and this one and everything looks identical to
upstream.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers


diff --git a/arch/powerpc/platforms/pseries/vio.c b/arch/powerpc/platforms/pseries/vio.c
index 738196fd7e57..9d5bdb0594ed 100644
--- a/arch/powerpc/platforms/pseries/vio.c
+++ b/arch/powerpc/platforms/pseries/vio.c
@@ -955,7 +955,7 @@ static ssize_t cmo_##name##_show(struct device *dev,                    \
 	return sprintf(buf, "%lu\n", to_vio_dev(dev)->cmo.name);        \
 }
 
-static ssize_t viodev_cmo_allocs_failed_show(struct device *dev,
+static ssize_t cmo_allocs_failed_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct vio_dev *viodev = to_vio_dev(dev);
@@ -993,9 +993,11 @@ static ssize_t name_show(struct device *, struct device_attribute *, char *);
 static ssize_t devspec_show(struct device *, struct device_attribute *, char *);
 static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 			     char *buf);
-static DEVICE_ATTR_RO(name);
-static DEVICE_ATTR_RO(devspec);
-static DEVICE_ATTR_RO(modalias);
+
+static struct device_attribute dev_attr_name;
+static struct device_attribute dev_attr_devspec;
+static struct device_attribute dev_attr_modalias;
+
 static DEVICE_ATTR_RO(cmo_entitled);
 static DEVICE_ATTR_RO(cmo_allocated);
 static DEVICE_ATTR_RW(cmo_desired);
@@ -1016,19 +1018,19 @@ ATTRIBUTE_GROUPS(vio_cmo_dev);
 /* sysfs bus functions and data structures for CMO */
 
 #define viobus_cmo_rd_attr(name)                                        \
-static ssize_t cmo_##name##_show(struct bus_type *bt, char *buf)        \
+static ssize_t cmo_bus_##name##_show(struct bus_type *bt, char *buf)    \
 {                                                                       \
 	return sprintf(buf, "%lu\n", vio_cmo.name);                     \
 }                                                                       \
-static BUS_ATTR_RO(cmo_##name)
+static BUS_ATTR_RO(cmo_bus_##name)
 
 #define viobus_cmo_pool_rd_attr(name, var)                              \
 static ssize_t                                                          \
-cmo_##name##_##var##_show(struct bus_type *bt, char *buf)               \
+cmo_bus_##name##_##var##_show(struct bus_type *bt, char *buf)           \
 {                                                                       \
 	return sprintf(buf, "%lu\n", vio_cmo.name.var);                 \
 }                                                                       \
-static BUS_ATTR_RO(cmo_##name##_##var)
+static BUS_ATTR_RO(cmo_bus_##name##_##var)
 
 viobus_cmo_rd_attr(entitled);
 viobus_cmo_rd_attr(spare);
@@ -1039,12 +1041,12 @@ viobus_cmo_pool_rd_attr(reserve, size);
 viobus_cmo_pool_rd_attr(excess, size);
 viobus_cmo_pool_rd_attr(excess, free);
 
-static ssize_t cmo_high_show(struct bus_type *bt, char *buf)
+static ssize_t cmo_bus_high_show(struct bus_type *bt, char *buf)
 {
 	return sprintf(buf, "%lu\n", vio_cmo.high);
 }
 
-static ssize_t cmo_high_store(struct bus_type *bt, const char *buf,
+static ssize_t cmo_bus_high_store(struct bus_type *bt, const char *buf,
 			      size_t count)
 {
 	unsigned long flags;
@@ -1055,18 +1057,18 @@ static ssize_t cmo_high_store(struct bus_type *bt, const char *buf,
 
 	return count;
 }
-static BUS_ATTR_RW(cmo_high);
+static BUS_ATTR_RW(cmo_bus_high);
 
 static struct attribute *vio_bus_attrs[] = {
-	&bus_attr_cmo_entitled.attr,
-	&bus_attr_cmo_spare.attr,
-	&bus_attr_cmo_min.attr,
-	&bus_attr_cmo_desired.attr,
-	&bus_attr_cmo_curr.attr,
-	&bus_attr_cmo_high.attr,
-	&bus_attr_cmo_reserve_size.attr,
-	&bus_attr_cmo_excess_size.attr,
-	&bus_attr_cmo_excess_free.attr,
+	&bus_attr_cmo_bus_entitled.attr,
+	&bus_attr_cmo_bus_spare.attr,
+	&bus_attr_cmo_bus_min.attr,
+	&bus_attr_cmo_bus_desired.attr,
+	&bus_attr_cmo_bus_curr.attr,
+	&bus_attr_cmo_bus_high.attr,
+	&bus_attr_cmo_bus_reserve_size.attr,
+	&bus_attr_cmo_bus_excess_size.attr,
+	&bus_attr_cmo_bus_excess_free.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(vio_bus);
