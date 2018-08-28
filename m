Return-Path: <robherring2@gmail.com>
Received: from mail-oi0-f67.google.com (mail-oi0-f67.google.com
 [209.85.218.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41zsJZ6jrYzDrTP
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Aug 2018 11:54:54 +1000 (AEST)
Received: by mail-oi0-f67.google.com with SMTP id l202-v6so7573oig.7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Aug 2018 18:54:54 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] macintosh: Convert to using %pOFn instead of device_node.name
Date: Mon, 27 Aug 2018 20:52:27 -0500
Message-Id: <20180828015252.28511-26-robh@kernel.org>
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
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
 drivers/macintosh/macio_sysfs.c           | 8 +++++++-
 drivers/macintosh/windfarm_smu_controls.c | 4 ++--
 2 files changed, 9 insertions(+), 3 deletions(-)

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
