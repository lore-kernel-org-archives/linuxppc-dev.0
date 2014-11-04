Return-Path: <glikely@secretlab.ca>
Received: from mail-wg0-f42.google.com (mail-wg0-f42.google.com [74.125.82.42])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A37621A001E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Nov 2014 21:45:53 +1100 (AEDT)
Received: by mail-wg0-f42.google.com with SMTP id k14so13225839wgh.15
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Nov 2014 02:45:50 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@linaro.org>
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] of/platform: Move platform devices under /sys/devices/platform
Date: Tue,  4 Nov 2014 10:45:20 +0000
Message-Id: <1415097920-30014-1-git-send-email-grant.likely@linaro.org>
Cc: Grant Likely <grant.likely@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently the devices created by drivers/of/platform.c get created at
the root of /sys/devices. This goes against the typical pattern for
sysfs where the top level /sys/devices structure contains categories of
devices, and the structure of devices is placed below that. To fix this,
make the code in drivers/of/platform.c follow the drivers/base/platform.c
behaviour, and use &platform_bus as the default parent for all new
platform_devices and amba_devices.

This change has been discussed for a long time, but nobody has actually
acted on it. Userspace code that expects to find devices under a fixed
/sys/devices/... path will be affected. It isn't /supposed/ to do that,
but if anyone complains then I'll add a default-off workaround option to
put them back into the root.

Signed-off-by: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/of/platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 3b64d0bf5bba..7c6771986c06 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -138,7 +138,7 @@ struct platform_device *of_device_alloc(struct device_node *np,
 	}
 
 	dev->dev.of_node = of_node_get(np);
-	dev->dev.parent = parent;
+	dev->dev.parent = parent ? : &platform_bus;
 
 	if (bus_id)
 		dev_set_name(&dev->dev, "%s", bus_id);
@@ -291,7 +291,7 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
 
 	/* setup generic device info */
 	dev->dev.of_node = of_node_get(node);
-	dev->dev.parent = parent;
+	dev->dev.parent = parent ? : &platform_bus;
 	dev->dev.platform_data = platform_data;
 	if (bus_id)
 		dev_set_name(&dev->dev, "%s", bus_id);
-- 
1.9.1
