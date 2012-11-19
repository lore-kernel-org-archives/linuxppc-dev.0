Return-Path: <wfp5p@viridian.itc.virginia.edu>
Received: from viridian.itc.virginia.edu (viridian.itc.Virginia.EDU
 [128.143.12.139]) by ozlabs.org (Postfix) with ESMTP id E2C0F2C00A6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2012 05:37:59 +1100 (EST)
From: Bill Pemberton <wfp5p@virginia.edu>
To: gregkh@linuxfoundation.org
Subject: [PATCH 443/493] drivers/macintosh: remove use of __devexit
Date: Mon, 19 Nov 2012 13:26:32 -0500
Message-Id: <1353349642-3677-443-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CONFIG_HOTPLUG is going away as an option so __devexit is no
longer needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org> 
Cc: linuxppc-dev@lists.ozlabs.org 
---
 drivers/macintosh/macio_asic.c             | 2 +-
 drivers/macintosh/rack-meter.c             | 2 +-
 drivers/macintosh/windfarm_ad7417_sensor.c | 4 ++--
 drivers/macintosh/windfarm_fcu_controls.c  | 2 +-
 drivers/macintosh/windfarm_pm112.c         | 2 +-
 drivers/macintosh/windfarm_pm121.c         | 2 +-
 drivers/macintosh/windfarm_pm72.c          | 2 +-
 drivers/macintosh/windfarm_pm81.c          | 2 +-
 drivers/macintosh/windfarm_pm91.c          | 2 +-
 drivers/macintosh/windfarm_rm31.c          | 2 +-
 10 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/macintosh/macio_asic.c b/drivers/macintosh/macio_asic.c
index 31617fd..ac5c879 100644
--- a/drivers/macintosh/macio_asic.c
+++ b/drivers/macintosh/macio_asic.c
@@ -739,7 +739,7 @@ static int macio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent
 	return 0;
 }
 
-static void __devexit macio_pci_remove(struct pci_dev* pdev)
+static void macio_pci_remove(struct pci_dev* pdev)
 {
 	panic("removing of macio-asic not supported !\n");
 }
diff --git a/drivers/macintosh/rack-meter.c b/drivers/macintosh/rack-meter.c
index 3b4453f..19c689c 100644
--- a/drivers/macintosh/rack-meter.c
+++ b/drivers/macintosh/rack-meter.c
@@ -521,7 +521,7 @@ static int rackmeter_probe(struct macio_dev* mdev,
 	return rc;
 }
 
-static int __devexit rackmeter_remove(struct macio_dev* mdev)
+static int rackmeter_remove(struct macio_dev* mdev)
 {
 	struct rackmeter *rm = dev_get_drvdata(&mdev->ofdev.dev);
 
diff --git a/drivers/macintosh/windfarm_ad7417_sensor.c b/drivers/macintosh/windfarm_ad7417_sensor.c
index d0aa631..0835217 100644
--- a/drivers/macintosh/windfarm_ad7417_sensor.c
+++ b/drivers/macintosh/windfarm_ad7417_sensor.c
@@ -290,7 +290,7 @@ static int wf_ad7417_probe(struct i2c_client *client,
 	return 0;
 }
 
-static int __devexit wf_ad7417_remove(struct i2c_client *client)
+static int wf_ad7417_remove(struct i2c_client *client)
 {
 	struct wf_ad7417_priv *pv = dev_get_drvdata(&client->dev);
 	int i;
@@ -333,7 +333,7 @@ static int wf_ad7417_init(void)
 	return i2c_add_driver(&wf_ad7417_driver);
 }
 
-static void __devexit wf_ad7417_exit(void)
+static void wf_ad7417_exit(void)
 {
 	i2c_del_driver(&wf_ad7417_driver);
 }
diff --git a/drivers/macintosh/windfarm_fcu_controls.c b/drivers/macintosh/windfarm_fcu_controls.c
index 84354d5..ec41083 100644
--- a/drivers/macintosh/windfarm_fcu_controls.c
+++ b/drivers/macintosh/windfarm_fcu_controls.c
@@ -564,7 +564,7 @@ static int wf_fcu_probe(struct i2c_client *client,
 	return 0;
 }
 
-static int __devexit wf_fcu_remove(struct i2c_client *client)
+static int wf_fcu_remove(struct i2c_client *client)
 {
 	struct wf_fcu_priv *pv = dev_get_drvdata(&client->dev);
 	struct wf_fcu_fan *fan;
diff --git a/drivers/macintosh/windfarm_pm112.c b/drivers/macintosh/windfarm_pm112.c
index 54ac434..35ef6e2 100644
--- a/drivers/macintosh/windfarm_pm112.c
+++ b/drivers/macintosh/windfarm_pm112.c
@@ -656,7 +656,7 @@ static int wf_pm112_probe(struct platform_device *dev)
 	return 0;
 }
 
-static int __devexit wf_pm112_remove(struct platform_device *dev)
+static int wf_pm112_remove(struct platform_device *dev)
 {
 	wf_unregister_client(&pm112_events);
 	/* should release all sensors and controls */
diff --git a/drivers/macintosh/windfarm_pm121.c b/drivers/macintosh/windfarm_pm121.c
index ec0ec67..af605e9 100644
--- a/drivers/macintosh/windfarm_pm121.c
+++ b/drivers/macintosh/windfarm_pm121.c
@@ -987,7 +987,7 @@ static int pm121_probe(struct platform_device *ddev)
 	return 0;
 }
 
-static int __devexit pm121_remove(struct platform_device *ddev)
+static int pm121_remove(struct platform_device *ddev)
 {
 	wf_unregister_client(&pm121_events);
 	return 0;
diff --git a/drivers/macintosh/windfarm_pm72.c b/drivers/macintosh/windfarm_pm72.c
index 84ac913..6e55853 100644
--- a/drivers/macintosh/windfarm_pm72.c
+++ b/drivers/macintosh/windfarm_pm72.c
@@ -776,7 +776,7 @@ static int wf_pm72_probe(struct platform_device *dev)
 	return 0;
 }
 
-static int __devexit wf_pm72_remove(struct platform_device *dev)
+static int wf_pm72_remove(struct platform_device *dev)
 {
 	wf_unregister_client(&pm72_events);
 
diff --git a/drivers/macintosh/windfarm_pm81.c b/drivers/macintosh/windfarm_pm81.c
index 92ba8f5..a67d5dd 100644
--- a/drivers/macintosh/windfarm_pm81.c
+++ b/drivers/macintosh/windfarm_pm81.c
@@ -720,7 +720,7 @@ static int wf_smu_probe(struct platform_device *ddev)
 	return 0;
 }
 
-static int __devexit wf_smu_remove(struct platform_device *ddev)
+static int wf_smu_remove(struct platform_device *ddev)
 {
 	wf_unregister_client(&wf_smu_events);
 
diff --git a/drivers/macintosh/windfarm_pm91.c b/drivers/macintosh/windfarm_pm91.c
index 5be25b9..0b4b0bf 100644
--- a/drivers/macintosh/windfarm_pm91.c
+++ b/drivers/macintosh/windfarm_pm91.c
@@ -642,7 +642,7 @@ static int wf_smu_probe(struct platform_device *ddev)
 	return 0;
 }
 
-static int __devexit wf_smu_remove(struct platform_device *ddev)
+static int wf_smu_remove(struct platform_device *ddev)
 {
 	wf_unregister_client(&wf_smu_events);
 
diff --git a/drivers/macintosh/windfarm_rm31.c b/drivers/macintosh/windfarm_rm31.c
index 3eca6d4..844003f 100644
--- a/drivers/macintosh/windfarm_rm31.c
+++ b/drivers/macintosh/windfarm_rm31.c
@@ -669,7 +669,7 @@ static int wf_rm31_probe(struct platform_device *dev)
 	return 0;
 }
 
-static int __devexit wf_rm31_remove(struct platform_device *dev)
+static int wf_rm31_remove(struct platform_device *dev)
 {
 	wf_unregister_client(&rm31_events);
 
-- 
1.8.0
