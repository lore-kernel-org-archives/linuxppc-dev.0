Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 00309DDFF1
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 18:41:50 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n4C8fTF6017484
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 01:41:39 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n4C8fMVB006912
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 03:41:28 -0500 (CDT)
From: Li Yang <leoli@freescale.com>
To: akpm@linux-foundation.org, galak@kernel.crashing.org, davem@davemloft.net,
	mporter@kernel.crashing.org
Subject: [PATCH 5/6] rio: warn_unused_result warnings fix
Date: Tue, 12 May 2009 16:36:02 +0800
Message-Id: <1242117363-14949-5-git-send-email-leoli@freescale.com>
In-Reply-To: <1242117363-14949-4-git-send-email-leoli@freescale.com>
References: <1242117363-14949-1-git-send-email-leoli@freescale.com>
	<1242117363-14949-2-git-send-email-leoli@freescale.com>
	<1242117363-14949-3-git-send-email-leoli@freescale.com>
	<1242117363-14949-4-git-send-email-leoli@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Adding failure path for the following two cases.

warning: ignoring return value of 'device_add', declared with attribute warn_unused_result
warning: ignoring return value of 'sysfs_create_bin_file', declared with attribute warn_unused_result

Signed-off-by: Li Yang <leoli@freescale.com>
---
 drivers/rapidio/rio-scan.c  |   44 ++++++++++++++++++++++++++----------------
 drivers/rapidio/rio-sysfs.c |    6 +++-
 2 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/drivers/rapidio/rio-scan.c b/drivers/rapidio/rio-scan.c
index 74d0bfa..0838fb2 100644
--- a/drivers/rapidio/rio-scan.c
+++ b/drivers/rapidio/rio-scan.c
@@ -263,15 +263,21 @@ static void rio_route_set_ops(struct rio_dev *rdev)
  * device to the RIO device list.  Creates the generic sysfs nodes
  * for an RIO device.
  */
-static void __devinit rio_add_device(struct rio_dev *rdev)
+static int __devinit rio_add_device(struct rio_dev *rdev)
 {
-	device_add(&rdev->dev);
+	int err;
+
+	err = device_add(&rdev->dev);
+	if (err)
+		return err;
 
 	spin_lock(&rio_global_list_lock);
 	list_add_tail(&rdev->global_list, &rio_devices);
 	spin_unlock(&rio_global_list_lock);
 
 	rio_create_sysfs_dev_files(rdev);
+
+	return 0;
 }
 
 /**
@@ -294,13 +300,14 @@ static struct rio_dev *rio_setup_device(struct rio_net *net,
 					struct rio_mport *port, u16 destid,
 					u8 hopcount, int do_enum)
 {
+	int ret = 0;
 	struct rio_dev *rdev;
-	struct rio_switch *rswitch;
+	struct rio_switch *rswitch = NULL;
 	int result, rdid;
 
 	rdev = kzalloc(sizeof(struct rio_dev), GFP_KERNEL);
 	if (!rdev)
-		goto out;
+		return NULL;
 
 	rdev->net = net;
 	rio_mport_read_config_32(port, destid, hopcount, RIO_DEV_ID_CAR,
@@ -343,23 +350,16 @@ static struct rio_dev *rio_setup_device(struct rio_net *net,
 		rio_mport_read_config_32(port, destid, hopcount,
 					 RIO_SWP_INFO_CAR, &rdev->swpinfo);
 		rswitch = kmalloc(sizeof(struct rio_switch), GFP_KERNEL);
-		if (!rswitch) {
-			kfree(rdev);
-			rdev = NULL;
-			goto out;
-		}
+		if (!rswitch)
+			goto cleanup;
 		rswitch->switchid = next_switchid;
 		rswitch->hopcount = hopcount;
 		rswitch->destid = destid;
 		rswitch->route_table = kzalloc(sizeof(u8)*
 					RIO_MAX_ROUTE_ENTRIES(port->sys_size),
 					GFP_KERNEL);
-		if (!rswitch->route_table) {
-			kfree(rdev);
-			rdev = NULL;
-			kfree(rswitch);
-			goto out;
-		}
+		if (!rswitch->route_table)
+			goto cleanup;
 		/* Initialize switch route table */
 		for (rdid = 0; rdid < RIO_MAX_ROUTE_ENTRIES(port->sys_size);
 				rdid++)
@@ -390,10 +390,20 @@ static struct rio_dev *rio_setup_device(struct rio_net *net,
 		rio_init_dbell_res(&rdev->riores[RIO_DOORBELL_RESOURCE],
 				   0, 0xffff);
 
-	rio_add_device(rdev);
+	ret = rio_add_device(rdev);
+	if (ret)
+		goto cleanup;
 
-      out:
 	return rdev;
+
+cleanup:
+	if (rswitch) {
+		if (rswitch->route_table)
+			kfree(rswitch->route_table);
+		kfree(rswitch);
+	}
+	kfree(rdev);
+	return NULL;
 }
 
 /**
diff --git a/drivers/rapidio/rio-sysfs.c b/drivers/rapidio/rio-sysfs.c
index 97a147f..ba742e8 100644
--- a/drivers/rapidio/rio-sysfs.c
+++ b/drivers/rapidio/rio-sysfs.c
@@ -214,9 +214,11 @@ static struct bin_attribute rio_config_attr = {
  */
 int rio_create_sysfs_dev_files(struct rio_dev *rdev)
 {
-	sysfs_create_bin_file(&rdev->dev.kobj, &rio_config_attr);
+	int err = 0;
 
-	return 0;
+	err = sysfs_create_bin_file(&rdev->dev.kobj, &rio_config_attr);
+
+	return err;
 }
 
 /**
-- 
1.5.4
