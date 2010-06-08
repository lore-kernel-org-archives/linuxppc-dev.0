Return-Path: <grant.likely@secretlab.ca>
Sender: Grant Likely <glikely@secretlab.ca>
Subject: [PATCH 3/6] of: Modify of_device_get_modalias to be passed struct
	device
To: ben@kernel.crashing.org, sfr@canb.auug.org.au, monstr@monstr.eu,
	microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org, jeremy.kerr@canonical.com,
	linuxppc-dev@lists.ozlabs.org
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 08 Jun 2010 08:26:28 -0600
Message-ID: <20100608142628.26088.82089.stgit@angua>
In-Reply-To: <20100608142152.26088.1108.stgit@angua>
References: <20100608142152.26088.1108.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that the of_node pointer is part of struct device,
of_device_get_modalias could be used on any struct device
that has the device node pointer set.  This patch changes
of_device_get_modalias to accept a struct device instead
of a struct of_device.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
CC: Michal Simek <monstr@monstr.eu>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Wolfram Sang <w.sang@pengutronix.de>
CC: Stephen Rothwell <sfr@canb.auug.org.au>
CC: microblaze-uclinux@itee.uq.edu.au
CC: linuxppc-dev@ozlabs.org
---
 arch/microblaze/include/asm/of_device.h |    3 ---
 drivers/macintosh/macio_sysfs.c         |    5 +----
 drivers/of/device.c                     |   16 ++++++----------
 include/linux/of_device.h               |    2 +-
 4 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/arch/microblaze/include/asm/of_device.h b/arch/microblaze/include/asm/of_device.h
index 58e627d..c9be534 100644
--- a/arch/microblaze/include/asm/of_device.h
+++ b/arch/microblaze/include/asm/of_device.h
@@ -15,9 +15,6 @@
 #include <linux/device.h>
 #include <linux/of.h>
 
-extern ssize_t of_device_get_modalias(struct of_device *ofdev,
-					char *str, ssize_t len);
-
 extern struct of_device *of_device_alloc(struct device_node *np,
 					 const char *bus_id,
 					 struct device *parent);
diff --git a/drivers/macintosh/macio_sysfs.c b/drivers/macintosh/macio_sysfs.c
index 6999ce5..6024038 100644
--- a/drivers/macintosh/macio_sysfs.c
+++ b/drivers/macintosh/macio_sysfs.c
@@ -41,10 +41,7 @@ compatible_show (struct device *dev, struct device_attribute *attr, char *buf)
 static ssize_t modalias_show (struct device *dev, struct device_attribute *attr,
 			      char *buf)
 {
-	struct of_device *ofdev = to_of_device(dev);
-	int len;
-
-	len = of_device_get_modalias(ofdev, buf, PAGE_SIZE - 2);
+	int len = of_device_get_modalias(dev, buf, PAGE_SIZE - 2);
 
 	buf[len] = '\n';
 	buf[len+1] = 0;
diff --git a/drivers/of/device.c b/drivers/of/device.c
index 275cc9c..c2a98f5 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -68,10 +68,7 @@ static ssize_t name_show(struct device *dev,
 static ssize_t modalias_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	struct of_device *ofdev = to_of_device(dev);
-	ssize_t len = 0;
-
-	len = of_device_get_modalias(ofdev, buf, PAGE_SIZE - 2);
+	ssize_t len = of_device_get_modalias(dev, buf, PAGE_SIZE - 2);
 	buf[len] = '\n';
 	buf[len+1] = 0;
 	return len+1;
@@ -123,19 +120,18 @@ void of_device_unregister(struct of_device *ofdev)
 }
 EXPORT_SYMBOL(of_device_unregister);
 
-ssize_t of_device_get_modalias(struct of_device *ofdev,
-				char *str, ssize_t len)
+ssize_t of_device_get_modalias(struct device *dev, char *str, ssize_t len)
 {
 	const char *compat;
 	int cplen, i;
 	ssize_t tsize, csize, repend;
 
 	/* Name & Type */
-	csize = snprintf(str, len, "of:N%sT%s", ofdev->dev.of_node->name,
-			 ofdev->dev.of_node->type);
+	csize = snprintf(str, len, "of:N%sT%s", dev->of_node->name,
+			 dev->of_node->type);
 
 	/* Get compatible property if any */
-	compat = of_get_property(ofdev->dev.of_node, "compatible", &cplen);
+	compat = of_get_property(dev->of_node, "compatible", &cplen);
 	if (!compat)
 		return csize;
 
@@ -210,7 +206,7 @@ int of_device_uevent(struct device *dev, struct kobj_uevent_env *env)
 	if (add_uevent_var(env, "MODALIAS="))
 		return -ENOMEM;
 
-	sl = of_device_get_modalias(to_of_device(dev), &env->buf[env->buflen-1],
+	sl = of_device_get_modalias(dev, &env->buf[env->buflen-1],
 				    sizeof(env->buf) - env->buflen);
 	if (sl >= (sizeof(env->buf) - env->buflen))
 		return -ENOMEM;
diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index da83e73..238e92e 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -42,7 +42,7 @@ static inline void of_device_free(struct of_device *dev)
 	of_release_dev(&dev->dev);
 }
 
-extern ssize_t of_device_get_modalias(struct of_device *ofdev,
+extern ssize_t of_device_get_modalias(struct device *dev,
 					char *str, ssize_t len);
 
 extern int of_device_uevent(struct device *dev, struct kobj_uevent_env *env);
