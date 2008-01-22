Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 7C0F2DDE06
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 01:20:46 +1100 (EST)
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id CA52D227B6E
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 15:23:01 +0100 (CET)
Received: from localhost (unknown [192.168.1.157])
	by mail.m-online.net (Postfix) with ESMTP id 5CA699018E
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 15:20:44 +0100 (CET)
Received: from localhost ([192.168.3.149])
	by localhost (scanner1.m-online.net [192.168.1.157]) (amavisd-new,
	port 10024) with ESMTP id Dgrzlbds1ad2 for <linuxppc-dev@ozlabs.org>;
	Tue, 22 Jan 2008 15:20:43 +0100 (CET)
Received: from ibook.aepfle.de (DSL01.83.171.173.38.ip-pool.NEFkom.net
	[83.171.173.38]) by mail.mnet-online.de (Postfix) with ESMTP
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 15:20:43 +0100 (CET)
Date: Tue, 22 Jan 2008 15:21:09 +0100
From: Olaf Hering <olaf@aepfle.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] create modalias file in sysfs for bus of_platform
Message-ID: <20080122142109.GA12967@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Create /sys/bus/of_platform/devices/*/modalias file to allow autoloading
of modules. modalias files are already present for many other bus types.

Signed-off-by: Olaf Hering <olaf@aepfle.de>

---
 drivers/of/device.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -86,7 +86,19 @@ static ssize_t dev_show_devspec(struct d
 	return sprintf(buf, "%s", ofdev->node->full_name);
 }
 
+static ssize_t dev_show_modalias(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct of_device *ofdev = to_of_device(dev);
+	ssize_t len = 0;
+
+	if (ofdev)
+		len = of_device_get_modalias(ofdev, buf, PAGE_SIZE);
+	return len;
+}
+
 static DEVICE_ATTR(devspec, S_IRUGO, dev_show_devspec, NULL);
+static DEVICE_ATTR(modalias, S_IRUGO, dev_show_modalias, NULL);
 
 /**
  * of_release_dev - free an of device structure when all users of it are finished.
@@ -116,6 +128,11 @@ int of_device_register(struct of_device 
 		return rc;
 
 	rc = device_create_file(&ofdev->dev, &dev_attr_devspec);
+	if (rc) {
+		device_unregister(&ofdev->dev);
+		return rc;
+	}
+	rc = device_create_file(&ofdev->dev, &dev_attr_modalias);
 	if (rc)
 		device_unregister(&ofdev->dev);
 
@@ -126,6 +143,7 @@ EXPORT_SYMBOL(of_device_register);
 void of_device_unregister(struct of_device *ofdev)
 {
 	device_remove_file(&ofdev->dev, &dev_attr_devspec);
+	device_remove_file(&ofdev->dev, &dev_attr_modalias);
 	device_unregister(&ofdev->dev);
 }
 EXPORT_SYMBOL(of_device_unregister);
