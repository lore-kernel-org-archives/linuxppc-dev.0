Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A2014DDE00
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 20:19:19 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n3SAJFbd014040
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 03:19:16 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n3SAJ3GY018921
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 05:19:14 -0500 (CDT)
From: Li Yang <leoli@freescale.com>
To: akpm@linux-foundation.org, galak@kernel.crashing.org, davem@davemloft.net,
	mporter@kernel.crashing.org
Subject: [PATCH] rio: warn_unused_result warnings fix
Date: Tue, 28 Apr 2009 18:15:37 +0800
Message-Id: <1240913737-23773-5-git-send-email-leoli@freescale.com>
In-Reply-To: <1240913737-23773-4-git-send-email-leoli@freescale.com>
References: <2a27d3730904280316l7049bddbie914907b16ccfff6@mail.gmail.com>
	<1240913737-23773-1-git-send-email-leoli@freescale.com>
	<1240913737-23773-2-git-send-email-leoli@freescale.com>
	<1240913737-23773-3-git-send-email-leoli@freescale.com>
	<1240913737-23773-4-git-send-email-leoli@freescale.com>
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

warning: ignoring return value of 'device_add', declared with attribute warn_unused_result
warning: ignoring return value of 'sysfs_create_bin_file', declared with attribute warn_unused_result

Signed-off-by: Li Yang <leoli@freescale.com>
---
 drivers/rapidio/rio-scan.c  |    5 ++++-
 drivers/rapidio/rio-sysfs.c |    6 ++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/rapidio/rio-scan.c b/drivers/rapidio/rio-scan.c
index 74d0bfa..9309e24 100644
--- a/drivers/rapidio/rio-scan.c
+++ b/drivers/rapidio/rio-scan.c
@@ -265,7 +265,10 @@ static void rio_route_set_ops(struct rio_dev *rdev)
  */
 static void __devinit rio_add_device(struct rio_dev *rdev)
 {
-	device_add(&rdev->dev);
+	int err;
+
+	err = device_add(&rdev->dev);
+	WARN_ON(err);
 
 	spin_lock(&rio_global_list_lock);
 	list_add_tail(&rdev->global_list, &rio_devices);
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
