Return-Path: <robherring2@gmail.com>
Received: from mail-oi0-f65.google.com (mail-oi0-f65.google.com
 [209.85.218.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 424g0j0kCqzF35y
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2018 07:27:48 +1000 (AEST)
Received: by mail-oi0-f65.google.com with SMTP id m11-v6so9668210oic.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Sep 2018 14:27:48 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3] macintosh: Convert to using %pOFn instead of
 device_node.name
Date: Tue,  4 Sep 2018 16:27:44 -0500
Message-Id: <20180904212744.16747-1-robh@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
v3:
- Fix dev_name handling. Using "%.*p" syntax throws a warning (and 
probably doesn't work).

 drivers/macintosh/macio_asic.c            | 8 +++++---
 drivers/macintosh/macio_sysfs.c           | 8 +++++++-
 drivers/macintosh/windfarm_smu_controls.c | 4 ++--
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/macintosh/macio_asic.c b/drivers/macintosh/macio_asic.c
index 07074820a167..58e676ca9622 100644
--- a/drivers/macintosh/macio_asic.c
+++ b/drivers/macintosh/macio_asic.c
@@ -362,7 +362,8 @@ static struct macio_dev * macio_add_one_device(struct macio_chip *chip,
 {
 	struct macio_dev *dev;
 	const u32 *reg;
-	
+	char name[MAX_NODE_NAME_SIZE + 1];
+
 	if (np == NULL)
 		return NULL;
 
@@ -402,6 +403,7 @@ static struct macio_dev * macio_add_one_device(struct macio_chip *chip,
 #endif
 
 	/* MacIO itself has a different reg, we use it's PCI base */
+        snprintf(name, sizeof(name), "%pOFn", np);
 	if (np == chip->of_node) {
 		dev_set_name(&dev->ofdev.dev, "%1d.%08x:%.*s",
 			     chip->lbus.index,
@@ -410,12 +412,12 @@ static struct macio_dev * macio_add_one_device(struct macio_chip *chip,
 #else
 			0, /* NuBus may want to do something better here */
 #endif
-			MAX_NODE_NAME_SIZE, np->name);
+			MAX_NODE_NAME_SIZE, name);
 	} else {
 		reg = of_get_property(np, "reg", NULL);
 		dev_set_name(&dev->ofdev.dev, "%1d.%08x:%.*s",
 			     chip->lbus.index,
-			     reg ? *reg : 0, MAX_NODE_NAME_SIZE, np->name);
+			     reg ? *reg : 0, MAX_NODE_NAME_SIZE, name);
 	}
 
 	/* Setup interrupts & resources */
diff --git a/drivers/macintosh/macio_sysfs.c b/drivers/macintosh/macio_sysfs.c
index ca4fcffe454b..d2451e58acb9 100644
--- a/drivers/macintosh/macio_sysfs.c
+++ b/drivers/macintosh/macio_sysfs.c
@@ -58,7 +58,13 @@ static ssize_t devspec_show(struct device *dev,
 static DEVICE_ATTR_RO(modalias);
 static DEVICE_ATTR_RO(devspec);
 
-macio_config_of_attr (name, "%s\n");
+static ssize_t name_show(struct device *dev,
+			 struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%pOFn\n", dev->of_node);
+}
+static DEVICE_ATTR_RO(name);
+
 macio_config_of_attr (type, "%s\n");
 
 static struct attribute *macio_dev_attrs[] = {
diff --git a/drivers/macintosh/windfarm_smu_controls.c b/drivers/macintosh/windfarm_smu_controls.c
index d174c7437337..86d65462a61c 100644
--- a/drivers/macintosh/windfarm_smu_controls.c
+++ b/drivers/macintosh/windfarm_smu_controls.c
@@ -277,7 +277,7 @@ static int __init smu_controls_init(void)
 		fct = smu_fan_create(fan, 0);
 		if (fct == NULL) {
 			printk(KERN_WARNING "windfarm: Failed to create SMU "
-			       "RPM fan %s\n", fan->name);
+			       "RPM fan %pOFn\n", fan);
 			continue;
 		}
 		list_add(&fct->link, &smu_fans);
@@ -296,7 +296,7 @@ static int __init smu_controls_init(void)
 		fct = smu_fan_create(fan, 1);
 		if (fct == NULL) {
 			printk(KERN_WARNING "windfarm: Failed to create SMU "
-			       "PWM fan %s\n", fan->name);
+			       "PWM fan %pOFn\n", fan);
 			continue;
 		}
 		list_add(&fct->link, &smu_fans);
-- 
2.17.1
