Return-Path: <jk@ozlabs.org>
To: linuxppc-dev@ozlabs.org
From: Jeremy Kerr <jk@ozlabs.org>
Subject: [PATCH 1/20] [powerpc] Remove linux,device properties
Message-ID: 1151993427.2210.02@pokey
Date: Tue,  4 Jul 2006 16:44:46 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The linux,device property isn't used anywhere within the kernel, and
since it's a kernel pointer, it's a little useless for userspace.

This change removes the code to create this property in
of_device_register.

Built for pmac32.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
---

 of_device.c |   24 ------------------------
 1 file changed, 24 deletions(-)

Index: linux-2.6/arch/powerpc/kernel/of_device.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/of_device.c
+++ linux-2.6/arch/powerpc/kernel/of_device.c
@@ -189,27 +189,9 @@ void of_release_dev(struct device *dev)
 int of_device_register(struct of_device *ofdev)
 {
 	int rc;
-	struct of_device **odprop;
 
 	BUG_ON(ofdev->node == NULL);
 
-	odprop = (struct of_device **)get_property(ofdev->node, "linux,device", NULL);
-	if (!odprop) {
-		struct property *new_prop;
-	
-		new_prop = kmalloc(sizeof(struct property) + sizeof(struct of_device *),
-			GFP_KERNEL);
-		if (new_prop == NULL)
-			return -ENOMEM;
-		new_prop->name = "linux,device";
-		new_prop->length = sizeof(sizeof(struct of_device *));
-		new_prop->value = (unsigned char *)&new_prop[1];
-		odprop = (struct of_device **)new_prop->value;
-		*odprop = NULL;
-		prom_add_property(ofdev->node, new_prop);
-	}
-	*odprop = ofdev;
-
 	rc = device_register(&ofdev->dev);
 	if (rc)
 		return rc;
@@ -221,14 +203,8 @@ int of_device_register(struct of_device 
 
 void of_device_unregister(struct of_device *ofdev)
 {
-	struct of_device **odprop;
-
 	device_remove_file(&ofdev->dev, &dev_attr_devspec);
 
-	odprop = (struct of_device **)get_property(ofdev->node, "linux,device", NULL);
-	if (odprop)
-		*odprop = NULL;
-
 	device_unregister(&ofdev->dev);
 }
 
