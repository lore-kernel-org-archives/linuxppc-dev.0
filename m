Return-Path: <richardcochran@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.152])
	by ozlabs.org (Postfix) with ESMTP id 2E704B7D8B
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 12 Jun 2010 22:38:59 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id e12so808299fga.14
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 12 Jun 2010 05:38:57 -0700 (PDT)
Date: Sat, 12 Jun 2010 14:39:43 +0200
From: Richard Cochran <richardcochran@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: fix obsolete device tree code for the UPM NAND
	driver.
Message-ID: <20100612123943.GA1982@riccoc20.at.omicron.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 58f9b0b02414062eaff46716bc04b47d7e79add5 removed of_device->node.
This driver was apparently overlooked in the processes.

Signed-off-by: Richard Cochran <richard.cochran@omicron.at>
---
 drivers/mtd/nand/fsl_upm.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/fsl_upm.c b/drivers/mtd/nand/fsl_upm.c
index 00aea6f..81ec87a 100644
--- a/drivers/mtd/nand/fsl_upm.c
+++ b/drivers/mtd/nand/fsl_upm.c
@@ -232,7 +232,7 @@ static int __devinit fun_probe(struct of_device *ofdev,
 	if (!fun)
 		return -ENOMEM;
 
-	ret = of_address_to_resource(ofdev->node, 0, &io_res);
+	ret = of_address_to_resource(ofdev->dev.of_node, 0, &io_res);
 	if (ret) {
 		dev_err(&ofdev->dev, "can't get IO base\n");
 		goto err1;
@@ -244,7 +244,8 @@ static int __devinit fun_probe(struct of_device *ofdev,
 		goto err1;
 	}
 
-	prop = of_get_property(ofdev->node, "fsl,upm-addr-offset", &size);
+	prop = of_get_property(ofdev->dev.of_node,
+			       "fsl,upm-addr-offset", &size);
 	if (!prop || size != sizeof(uint32_t)) {
 		dev_err(&ofdev->dev, "can't get UPM address offset\n");
 		ret = -EINVAL;
@@ -252,7 +253,8 @@ static int __devinit fun_probe(struct of_device *ofdev,
 	}
 	fun->upm_addr_offset = *prop;
 
-	prop = of_get_property(ofdev->node, "fsl,upm-cmd-offset", &size);
+	prop = of_get_property(ofdev->dev.of_node,
+			       "fsl,upm-cmd-offset", &size);
 	if (!prop || size != sizeof(uint32_t)) {
 		dev_err(&ofdev->dev, "can't get UPM command offset\n");
 		ret = -EINVAL;
@@ -260,7 +262,7 @@ static int __devinit fun_probe(struct of_device *ofdev,
 	}
 	fun->upm_cmd_offset = *prop;
 
-	prop = of_get_property(ofdev->node,
+	prop = of_get_property(ofdev->dev.of_node,
 			       "fsl,upm-addr-line-cs-offsets", &size);
 	if (prop && (size / sizeof(uint32_t)) > 0) {
 		fun->mchip_count = size / sizeof(uint32_t);
@@ -276,7 +278,7 @@ static int __devinit fun_probe(struct of_device *ofdev,
 
 	for (i = 0; i < fun->mchip_count; i++) {
 		fun->rnb_gpio[i] = -1;
-		rnb_gpio = of_get_gpio(ofdev->node, i);
+		rnb_gpio = of_get_gpio(ofdev->dev.of_node, i);
 		if (rnb_gpio >= 0) {
 			ret = gpio_request(rnb_gpio, dev_name(&ofdev->dev));
 			if (ret) {
@@ -292,13 +294,13 @@ static int __devinit fun_probe(struct of_device *ofdev,
 		}
 	}
 
-	prop = of_get_property(ofdev->node, "chip-delay", NULL);
+	prop = of_get_property(ofdev->dev.of_node, "chip-delay", NULL);
 	if (prop)
 		fun->chip_delay = *prop;
 	else
 		fun->chip_delay = 50;
 
-	prop = of_get_property(ofdev->node, "fsl,upm-wait-flags", &size);
+	prop = of_get_property(ofdev->dev.of_node, "fsl,upm-wait-flags", &size);
 	if (prop && size == sizeof(uint32_t))
 		fun->wait_flags = *prop;
 	else
@@ -315,7 +317,7 @@ static int __devinit fun_probe(struct of_device *ofdev,
 	fun->dev = &ofdev->dev;
 	fun->last_ctrl = NAND_CLE;
 
-	ret = fun_chip_init(fun, ofdev->node, &io_res);
+	ret = fun_chip_init(fun, ofdev->dev.of_node, &io_res);
 	if (ret)
 		goto err2;
 
-- 
1.6.3.3
