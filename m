Return-Path: <robherring2@gmail.com>
Received: from mail-pf0-f193.google.com (mail-pf0-f193.google.com
 [209.85.192.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xBtwj62K3zDrJx
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 07:44:37 +1000 (AEST)
Received: by mail-pf0-f193.google.com with SMTP id o88so4065056pfk.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jul 2017 14:44:37 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] macintosh: Convert to using %pOF instead of full_name
Date: Tue, 18 Jul 2017 16:43:12 -0500
Message-Id: <20170718214339.7774-32-robh@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that we have a custom printf format specifier, convert users of
full_name to use %pOF instead. This is preparation to remove storing
of the full path string for each node.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
 drivers/macintosh/macio_sysfs.c           | 2 +-
 drivers/macintosh/rack-meter.c            | 4 ++--
 drivers/macintosh/smu.c                   | 8 ++++----
 drivers/macintosh/via-cuda.c              | 4 ++--
 drivers/macintosh/windfarm_fcu_controls.c | 4 ++--
 drivers/macintosh/windfarm_lm87_sensor.c  | 4 ++--
 drivers/macintosh/windfarm_smu_sat.c      | 2 +-
 7 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/macintosh/macio_sysfs.c b/drivers/macintosh/macio_sysfs.c
index 2445274f7e4b..281f5345661e 100644
--- a/drivers/macintosh/macio_sysfs.c
+++ b/drivers/macintosh/macio_sysfs.c
@@ -52,7 +52,7 @@ static ssize_t devspec_show(struct device *dev,
 	struct platform_device *ofdev;

 	ofdev = to_platform_device(dev);
-	return sprintf(buf, "%s\n", ofdev->dev.of_node->full_name);
+	return sprintf(buf, "%pOF\n", ofdev->dev.of_node);
 }
 static DEVICE_ATTR_RO(modalias);
 static DEVICE_ATTR_RO(devspec);
diff --git a/drivers/macintosh/rack-meter.c b/drivers/macintosh/rack-meter.c
index e199fd6c71ce..e9da80ceb7c8 100644
--- a/drivers/macintosh/rack-meter.c
+++ b/drivers/macintosh/rack-meter.c
@@ -431,8 +431,8 @@ static int rackmeter_probe(struct macio_dev* mdev,
 	    of_address_to_resource(i2s, 0, &ri2s) ||
 	    of_address_to_resource(i2s, 1, &rdma)) {
 		printk(KERN_ERR
-		       "rackmeter: found match but lacks resources: %s",
-		       mdev->ofdev.dev.of_node->full_name);
+		       "rackmeter: found match but lacks resources: %pOF",
+		       mdev->ofdev.dev.of_node);
 		rc = -ENXIO;
 		goto bail_free;
 	}
diff --git a/drivers/macintosh/smu.c b/drivers/macintosh/smu.c
index 1ac66421877a..ea9bdc85a21d 100644
--- a/drivers/macintosh/smu.c
+++ b/drivers/macintosh/smu.c
@@ -589,14 +589,14 @@ static int smu_late_init(void)
 	if (smu->db_node) {
 		smu->db_irq = irq_of_parse_and_map(smu->db_node, 0);
 		if (!smu->db_irq)
-			printk(KERN_ERR "smu: failed to map irq for node %s\n",
-			       smu->db_node->full_name);
+			printk(KERN_ERR "smu: failed to map irq for node %pOF\n",
+			       smu->db_node);
 	}
 	if (smu->msg_node) {
 		smu->msg_irq = irq_of_parse_and_map(smu->msg_node, 0);
 		if (!smu->msg_irq)
-			printk(KERN_ERR "smu: failed to map irq for node %s\n",
-			       smu->msg_node->full_name);
+			printk(KERN_ERR "smu: failed to map irq for node %pOF\n",
+			       smu->msg_node);
 	}

 	/*
diff --git a/drivers/macintosh/via-cuda.c b/drivers/macintosh/via-cuda.c
index c60415958dfe..147da4edd021 100644
--- a/drivers/macintosh/via-cuda.c
+++ b/drivers/macintosh/via-cuda.c
@@ -297,8 +297,8 @@ static int __init via_cuda_start(void)
 #else
     cuda_irq = irq_of_parse_and_map(vias, 0);
     if (!cuda_irq) {
-	printk(KERN_ERR "via-cuda: can't map interrupts for %s\n",
-	       vias->full_name);
+	printk(KERN_ERR "via-cuda: can't map interrupts for %pOF\n",
+	       vias);
 	return -ENODEV;
     }
 #endif
diff --git a/drivers/macintosh/windfarm_fcu_controls.c b/drivers/macintosh/windfarm_fcu_controls.c
index 0226b796a21c..fab7a21e9577 100644
--- a/drivers/macintosh/windfarm_fcu_controls.c
+++ b/drivers/macintosh/windfarm_fcu_controls.c
@@ -470,8 +470,8 @@ static void wf_fcu_lookup_fans(struct wf_fcu_priv *pv)
 				id = ((*reg) - 0x30) / 2;
 			if (id > 7) {
 				pr_warning("wf_fcu: Can't parse "
-				       "fan ID in device-tree for %s\n",
-					   np->full_name);
+				       "fan ID in device-tree for %pOF\n",
+					   np);
 				break;
 			}
 			wf_fcu_add_fan(pv, name, type, id);
diff --git a/drivers/macintosh/windfarm_lm87_sensor.c b/drivers/macintosh/windfarm_lm87_sensor.c
index c071aab79dd1..913c4bfeef94 100644
--- a/drivers/macintosh/windfarm_lm87_sensor.c
+++ b/drivers/macintosh/windfarm_lm87_sensor.c
@@ -126,8 +126,8 @@ static int wf_lm87_probe(struct i2c_client *client,
 		}
 	}
 	if (!name) {
-		pr_warning("wf_lm87: Unsupported sensor %s\n",
-			   client->dev.of_node->full_name);
+		pr_warning("wf_lm87: Unsupported sensor %pOF\n",
+			   client->dev.of_node);
 		return -ENODEV;
 	}

diff --git a/drivers/macintosh/windfarm_smu_sat.c b/drivers/macintosh/windfarm_smu_sat.c
index ad6223e88340..e9c828bf171b 100644
--- a/drivers/macintosh/windfarm_smu_sat.c
+++ b/drivers/macintosh/windfarm_smu_sat.c
@@ -248,7 +248,7 @@ static int wf_sat_probe(struct i2c_client *client,
 		core = loc[5] - '0';
 		if (chip > 1 || core > 1) {
 			printk(KERN_ERR "wf_sat_create: don't understand "
-			       "location %s for %s\n", loc, child->full_name);
+			       "location %s for %pOF\n", loc, child);
 			continue;
 		}
 		cpu = 2 * chip + core;
--
2.11.0
