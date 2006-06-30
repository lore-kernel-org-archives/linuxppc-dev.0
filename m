Return-Path: <jk@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Jeremy Kerr <jk@ozlabs.org>
Date: Fri, 30 Jun 2006 13:03:01 +1000
Subject: [PATCH] [powerpc] cleanup of_device_(un)register
Message-Id: <1151636581.762717.409507295266.qpush@pokey>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

of_device_register() and of_device_unregister() modify the contents of
property values, so use of_find_property rather than get_property.

Also, clean up the sizeof(sizeof()) fruitiness.

Booted on pmac32.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
---

 arch/powerpc/kernel/of_device.c |   33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

Index: linux-2.6/arch/powerpc/kernel/of_device.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/of_device.c
+++ linux-2.6/arch/powerpc/kernel/of_device.c
@@ -190,26 +190,21 @@ void of_release_dev(struct device *dev)
 int of_device_register(struct of_device *ofdev)
 {
 	int rc;
-	struct of_device **odprop;
+	struct property *prop;
 
 	BUG_ON(ofdev->node == NULL);
 
-	odprop = (struct of_device **)get_property(ofdev->node, "linux,device", NULL);
-	if (!odprop) {
-		struct property *new_prop;
-	
-		new_prop = kmalloc(sizeof(struct property) + sizeof(struct of_device *),
-			GFP_KERNEL);
-		if (new_prop == NULL)
+	prop = of_find_property(ofdev->node, "linux,device", NULL);
+	if (!prop) {
+		prop = kmalloc(sizeof(*prop) + sizeof(ofdev), GFP_KERNEL);
+		if (prop == NULL)
 			return -ENOMEM;
-		new_prop->name = "linux,device";
-		new_prop->length = sizeof(sizeof(struct of_device *));
-		new_prop->value = (unsigned char *)&new_prop[1];
-		odprop = (struct of_device **)new_prop->value;
-		*odprop = NULL;
-		prom_add_property(ofdev->node, new_prop);
+		prop->name = "linux,device";
+		prop->length = sizeof(ofdev);
+		prop->value = (unsigned char *)&prop[1];
+		prom_add_property(ofdev->node, prop);
 	}
-	*odprop = ofdev;
+	*(struct of_device **)prop->value = ofdev;
 
 	rc = device_register(&ofdev->dev);
 	if (rc)
@@ -222,13 +217,13 @@ int of_device_register(struct of_device 
 
 void of_device_unregister(struct of_device *ofdev)
 {
-	struct of_device **odprop;
+	struct property *prop;
 
 	device_remove_file(&ofdev->dev, &dev_attr_devspec);
 
-	odprop = (struct of_device **)get_property(ofdev->node, "linux,device", NULL);
-	if (odprop)
-		*odprop = NULL;
+	prop = of_find_property(ofdev->node, "linux,device", NULL);
+	if (prop)
+		prop->value = NULL;
 
 	device_unregister(&ofdev->dev);
 }
