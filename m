Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ySmSW1v0SzDr6C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Nov 2017 13:42:01 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vA32cspV079849
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Nov 2017 22:41:58 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2e0akgnrvw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Nov 2017 22:41:58 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Fri, 3 Nov 2017 02:41:56 -0000
From: Cyril Bur <cyrilbur@gmail.com>
To: linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 stewart@linux.vnet.ibm.com
Cc: dwmw2@infradead.org, computersforpeace@gmail.com,
 boris.brezillon@free-electrons.com, sjitindarsingh@gmail.com
Subject: [PATCH v5 03/10] mtd: powernv_flash: Remove pointless goto in driver
 init
Date: Fri,  3 Nov 2017 13:41:39 +1100
In-Reply-To: <20171103024146.17086-1-cyrilbur@gmail.com>
References: <20171103024146.17086-1-cyrilbur@gmail.com>
Message-Id: <20171103024146.17086-4-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

powernv_flash_probe() has pointless goto statements which jump to the
end of the function to simply return a variable. Rather than checking
for error and going to the label, just return the error as soon as it is
detected.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/devices/powernv_flash.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/mtd/devices/powernv_flash.c b/drivers/mtd/devices/powernv_flash.c
index ca3ca6adf71e..4dd3b5d2feb2 100644
--- a/drivers/mtd/devices/powernv_flash.c
+++ b/drivers/mtd/devices/powernv_flash.c
@@ -227,21 +227,20 @@ static int powernv_flash_probe(struct platform_device *pdev)
 	int ret;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
-	if (!data) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!data)
+		return -ENOMEM;
+
 	data->mtd.priv = data;
 
 	ret = of_property_read_u32(dev->of_node, "ibm,opal-id", &(data->id));
 	if (ret) {
 		dev_err(dev, "no device property 'ibm,opal-id'\n");
-		goto out;
+		return ret;
 	}
 
 	ret = powernv_flash_set_driver_info(dev, &data->mtd);
 	if (ret)
-		goto out;
+		return ret;
 
 	dev_set_drvdata(dev, data);
 
@@ -250,10 +249,7 @@ static int powernv_flash_probe(struct platform_device *pdev)
 	 * with an ffs partition at the start, it should prove easier for users
 	 * to deal with partitions or not as they see fit
 	 */
-	ret = mtd_device_register(&data->mtd, NULL, 0);
-
-out:
-	return ret;
+	return mtd_device_register(&data->mtd, NULL, 0);
 }
 
 /**
-- 
2.15.0
