Return-Path: <grant.likely@secretlab.ca>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) by ozlabs.org (Postfix) with ESMTP id 77294B7550
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 25 Sep 2010 08:15:24 +1000 (EST)
Received: by mail-pz0-f51.google.com with SMTP id 5so1023172pzk.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Sep 2010 15:15:24 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
Subject: [PATCH (Option 2)] of/i2c: fix module load order issue caused by
	of_i2c.c
To: khali@linux-fr.org, mikpe@it.uu.se
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 24 Sep 2010 16:15:18 -0600
Message-ID: <20100924221458.28357.58921.stgit@angua>
In-Reply-To: <20100924221313.28357.61419.stgit@angua>
References: <20100924221313.28357.61419.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: rdunlap@xenotime.net, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 959e85f7, "i2c: add OF-style registration and binding" caused a
module dependency loop where of_i2c.c calls functions in i2c-core, and
i2c-core calls of_i2c_register_devices() in of_i2c.  This means that
when i2c support is built as a module when CONFIG_OF is set, then
neither i2c_core nor of_i2c are able to be loaded.

This patch fixes the problem by moving the of_i2c_register_devices()
calls back into the device drivers.  Device drivers already
specifically request the core code to parse the device tree for
devices anyway by setting the of_node pointer, so it isn't a big
deal to also call the registration function.  The drivers just become
slightly more verbose.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 drivers/i2c/busses/i2c-cpm.c     |    5 +++++
 drivers/i2c/busses/i2c-ibm_iic.c |    3 +++
 drivers/i2c/busses/i2c-mpc.c     |    1 +
 drivers/i2c/i2c-core.c           |    4 ----
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cpm.c b/drivers/i2c/busses/i2c-cpm.c
index f7bd261..f2de3be 100644
--- a/drivers/i2c/busses/i2c-cpm.c
+++ b/drivers/i2c/busses/i2c-cpm.c
@@ -677,6 +677,11 @@ static int __devinit cpm_i2c_probe(struct platform_device *ofdev,
 	dev_dbg(&ofdev->dev, "hw routines for %s registered.\n",
 		cpm->adap.name);
 
+	/*
+	 * register OF I2C devices
+	 */
+	of_i2c_register_devices(&cpm->adap);
+
 	return 0;
 out_shut:
 	cpm_i2c_shutdown(cpm);
diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
index 43ca32f..89eedf4 100644
--- a/drivers/i2c/busses/i2c-ibm_iic.c
+++ b/drivers/i2c/busses/i2c-ibm_iic.c
@@ -761,6 +761,9 @@ static int __devinit iic_probe(struct platform_device *ofdev,
 	dev_info(&ofdev->dev, "using %s mode\n",
 		 dev->fast_mode ? "fast (400 kHz)" : "standard (100 kHz)");
 
+	/* Now register all the child nodes */
+	of_i2c_register_devices(adap);
+
 	return 0;
 
 error_cleanup:
diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index a1c419a..b74e6dc 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -632,6 +632,7 @@ static int __devinit fsl_i2c_probe(struct platform_device *op,
 		dev_err(i2c->dev, "failed to add adapter\n");
 		goto fail_add;
 	}
+	of_i2c_register_devices(&i2c->adap);
 
 	return result;
 
diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 6649176..a9589f5 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -32,7 +32,6 @@
 #include <linux/init.h>
 #include <linux/idr.h>
 #include <linux/mutex.h>
-#include <linux/of_i2c.h>
 #include <linux/of_device.h>
 #include <linux/completion.h>
 #include <linux/hardirq.h>
@@ -876,9 +875,6 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	if (adap->nr < __i2c_first_dynamic_bus_num)
 		i2c_scan_static_board_info(adap);
 
-	/* Register devices from the device tree */
-	of_i2c_register_devices(adap);
-
 	/* Notify drivers */
 	mutex_lock(&core_lock);
 	bus_for_each_drv(&i2c_bus_type, NULL, adap, __process_new_adapter);
