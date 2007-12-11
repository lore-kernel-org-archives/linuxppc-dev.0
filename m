Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 436E7DDED1
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Dec 2007 10:56:43 +1100 (EST)
Date: Wed, 12 Dec 2007 10:56:33 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: michael@ellerman.id.au
Subject: [PATCH] Introduce driver_create/remove_dir
Message-Id: <20071212105633.725496cb.sfr@canb.auug.org.au>
In-Reply-To: <1196912898.14754.13.camel@concordia>
References: <20071205093054.GA23229@kroah.com>
	<1196853031.6759.7.camel@concordia>
	<20071205214103.GA7074@kroah.com>
	<1196912898.14754.13.camel@concordia>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, David,
	linuxppc-dev@ozlabs.org, "Kyle A. Lucke" <klucke@us.ibm.com>,
	paulus@samba.org, Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/base/driver.c      |   24 ++++++++++++++++++++++++
 drivers/net/iseries_veth.c |   15 +++++++--------
 include/linux/device.h     |    3 +++
 3 files changed, 34 insertions(+), 8 deletions(-)

Greg, does this look like a reasonable solution to iseries_veth accessing
the "private" kobject in struct device_driver?  This version is against
maimline, but the stuff you have in mm would just need to update
driver_create_dir ...

Also something along the lines of device_add_dir() might be good if you
want to hide the kobject in struct device as well.

diff --git a/drivers/base/driver.c b/drivers/base/driver.c
index eb11475..6527a91 100644
--- a/drivers/base/driver.c
+++ b/drivers/base/driver.c
@@ -91,6 +91,30 @@ struct device * driver_find_device(struct device_driver *drv,
 EXPORT_SYMBOL_GPL(driver_find_device);
 
 /**
+ *	driver_create_dir - create a subdirectory for a driver.
+ *	@drv:	driver.
+ *	@kobj:	the kobject we are creating the directory for.
+ */
+int __must_check driver_create_dir(struct device_driver *drv,
+			struct kobject *kobj)
+{
+	kobj->parent = &drv->kobj;
+	return kobject_add(kobj);
+}
+EXPORT_SYMBOL_GPL(driver_create_dir);
+
+/**
+ *	driver_remove_dir - remove a subdirectory for a driver.
+ *	@drv:	driver.
+ *	@attr:	driver attribute descriptor.
+ */
+void driver_remove_dir(struct device_driver *drv, struct kobject *kobj)
+{
+	kobject_del(kobj);
+}
+EXPORT_SYMBOL_GPL(driver_remove_dir);
+
+/**
  *	driver_create_file - create sysfs file for driver.
  *	@drv:	driver.
  *	@attr:	driver attribute descriptor.
diff --git a/drivers/net/iseries_veth.c b/drivers/net/iseries_veth.c
index 97bd9dc..ab46065 100644
--- a/drivers/net/iseries_veth.c
+++ b/drivers/net/iseries_veth.c
@@ -1670,7 +1670,7 @@ static void __exit veth_module_cleanup(void)
 			continue;
 
 		/* Remove the connection from sysfs */
-		kobject_del(&cnx->kobject);
+		driver_remove_dir(&veth_driver.driver, &cnx->kobject);
 		/* Drop the driver's reference to the connection */
 		kobject_put(&cnx->kobject);
 	}
@@ -1705,15 +1705,14 @@ static int __init veth_module_init(void)
 		goto error;
 
 	for (i = 0; i < HVMAXARCHITECTEDLPS; ++i) {
-		struct kobject *kobj;
-
 		if (!veth_cnx[i])
 			continue;
-
-		kobj = &veth_cnx[i]->kobject;
-		kobj->parent = &veth_driver.driver.kobj;
-		/* If the add failes, complain but otherwise continue */
-		if (0 != kobject_add(kobj))
+		/*
+		 * If creating the directory failes, complain
+		 * but otherwise continue
+		 */
+		if (driver_create_dir(&veth_driver.driver,
+				&veth_cnx[i]->kobject))
 			veth_error("cnx %d: Failed adding to sysfs.\n", i);
 	}
 
diff --git a/include/linux/device.h b/include/linux/device.h
index 2e15822..88f2251 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -157,6 +157,9 @@ struct driver_attribute {
 #define DRIVER_ATTR(_name,_mode,_show,_store)	\
 struct driver_attribute driver_attr_##_name = __ATTR(_name,_mode,_show,_store)
 
+extern int __must_check driver_create_dir(struct device_driver *,
+					struct kobject *);
+extern void driver_remove_dir(struct device_driver *, struct kobject *);
 extern int __must_check driver_create_file(struct device_driver *,
 					struct driver_attribute *);
 extern void driver_remove_file(struct device_driver *, struct driver_attribute *);
-- 
1.5.3.7

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
