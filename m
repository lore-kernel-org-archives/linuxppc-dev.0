Return-Path: <hnguyen@linux.vnet.ibm.com>
Received: from mtagate7.de.ibm.com (mtagate7.de.ibm.com [195.212.29.156])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 89B5DDDDE6
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 14:55:01 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate7.de.ibm.com (8.13.8/8.13.8) with ESMTP id l1K3suID192706
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 03:54:56 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.2) with
	ESMTP id l1K3su0s1728540
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 04:54:56 +0100
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l1K3stlq018227
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 04:54:55 +0100
From: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
To: paulus@samba.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	johnrose@us.ibm.com
Subject: [PATCH 2.6.21-rc1] ibmebus: make root device not of_device-based
MIME-Version: 1.0
Date: Tue, 20 Feb 2007 04:58:39 +0100
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702200458.39304.hnguyen@linux.vnet.ibm.com>
Cc: fenkes@de.ibm.com, pmac@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The fake root device doesn't have an associated device tree node,
so it should not be an of_device. This patch makes it a normal,
bus-less device and thus saves a lot of checks later on.


Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
---


 ibmebus.c |   33 ++++++++++++++-------------------
 1 files changed, 14 insertions(+), 19 deletions(-)


diff -urp a/arch/powerpc/kernel/ibmebus.c b/arch/powerpc/kernel/ibmebus.c
--- a/arch/powerpc/kernel/ibmebus.c	2007-02-20 01:35:54.000000000 +0100
+++ b/arch/powerpc/kernel/ibmebus.c	2007-02-20 01:39:24.000000000 +0100
@@ -44,9 +44,8 @@
 #include <asm/ibmebus.h>
 #include <asm/abs_addr.h>
 
-static struct ibmebus_dev ibmebus_bus_device = { /* fake "parent" device */
-	.ofdev.dev.bus_id = "ibmebus",
-	.ofdev.dev.bus    = &ibmebus_bus_type,
+static struct device ibmebus_bus_device = { /* fake "parent" device */
+	.bus_id = "ibmebus",
 };
 
 static void *ibmebus_alloc_coherent(struct device *dev,
@@ -173,7 +172,7 @@ static struct ibmebus_dev* __devinit ibm
 {
 	int err = 0;
 
-	dev->ofdev.dev.parent  = &ibmebus_bus_device.ofdev.dev;
+	dev->ofdev.dev.parent  = &ibmebus_bus_device;
 	dev->ofdev.dev.bus     = &ibmebus_bus_type;
 	dev->ofdev.dev.release = ibmebus_dev_release;
 
@@ -268,14 +267,12 @@ static int ibmebus_match_helper_name(str
 	const struct ibmebus_dev *ebus_dev = to_ibmebus_dev(dev);
 	char *name;
 
-	/* parent device has no of_device node, so skip it */
-	if (ebus_dev != &ibmebus_bus_device) {
-		name = (char*)get_property(
-			ebus_dev->ofdev.node, "name", NULL);
+	name = (char*)get_property(
+		ebus_dev->ofdev.node, "name", NULL);
+
+	if (name && (strcmp((char*)data, name) == 0))
+		return 1;
 
-		if (name && (strcmp((char*)data, name) == 0))
-			return 1;
-	}
 	return 0;
 }
 
@@ -384,14 +381,12 @@ static int ibmebus_match_helper_loc_code
 	const struct ibmebus_dev *ebus_dev = to_ibmebus_dev(dev);
 	char *loc_code;
 
-	/* parent device has no of_device node, so skip it */
-	if (ebus_dev != &ibmebus_bus_device) {
-		loc_code = (char*)get_property(
-			ebus_dev->ofdev.node, "ibm,loc-code", NULL);
+	loc_code = (char*)get_property(
+		ebus_dev->ofdev.node, "ibm,loc-code", NULL);
+
+	if (loc_code && (strcmp((char*)data, loc_code) == 0))
+		return 1;
 
-		if (loc_code && (strcmp((char*)data, loc_code) == 0))
-			return 1;
-	}
 	return 0;
 }
 
@@ -449,7 +444,7 @@ static int __init ibmebus_bus_init(void)
 		return err;
 	}
 
-	err = device_register(&ibmebus_bus_device.ofdev.dev);
+	err = device_register(&ibmebus_bus_device);
 	if (err) {
 		printk(KERN_WARNING "%s: device_register returned %i\n",
 		       __FUNCTION__, err);
