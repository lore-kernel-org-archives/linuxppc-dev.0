Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 91926DE2BD
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 03:54:40 +1000 (EST)
Date: Mon, 14 Jul 2008 21:54:37 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] of: i2c: improve last resort compatible entry selection
Message-ID: <20080714175437.GA5230@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently of_i2c will select first compatible property as a last resort
option. This isn't best choice though, because generic compatible entries
are listed last, not first. For example, two compatible entries given for
the MCU node:

"fsl,mc9s08qg8-mpc837xrdb", "fsl,mcu-mpc8349emitx";

Since no sane driver will ever match specific devices, what we want is
to select most generic option (last). Then driver may call
of_device_is_compatible() if it is really interested in details.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

Other options are: start filling the exceptions list, or add  "linux,..."
compatible entry to the device tree.

 drivers/of/of_i2c.c |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/of/of_i2c.c b/drivers/of/of_i2c.c
index b2ccdcb..0d35a0a 100644
--- a/drivers/of/of_i2c.c
+++ b/drivers/of/of_i2c.c
@@ -29,6 +29,7 @@ static int of_find_i2c_driver(struct device_node *node,
 	int i, cplen;
 	const char *compatible;
 	const char *p;
+	const char *last_wcomma = NULL;
 
 	/* 1. search for exception list entry */
 	for (i = 0; i < ARRAY_SIZE(i2c_devices); i++) {
@@ -45,7 +46,7 @@ static int of_find_i2c_driver(struct device_node *node,
 	if (!compatible)
 		return -ENODEV;
 
-	/* 2. search for linux,<i2c-type> entry */
+	/* 2. search for linux,<i2c-type> entry, or remember last w/ comma */
 	p = compatible;
 	while (cplen > 0) {
 		if (!strncmp(p, "linux,", 6)) {
@@ -54,6 +55,12 @@ static int of_find_i2c_driver(struct device_node *node,
 				    I2C_NAME_SIZE) >= I2C_NAME_SIZE)
 				return -ENOMEM;
 			return 0;
+		} else {
+			const char *comma;
+
+			comma = strchr(p, ',');
+			if (comma)
+				last_wcomma = comma + 1;
 		}
 
 		i = strlen(p) + 1;
@@ -61,12 +68,10 @@ static int of_find_i2c_driver(struct device_node *node,
 		cplen -= i;
 	}
 
-	/* 3. take fist compatible entry and strip manufacturer */
-	p = strchr(compatible, ',');
-	if (!p)
+	/* 3. take last compatible entry w/ comma, manufacturer stripped */
+	if (!last_wcomma)
 		return -ENODEV;
-	p++;
-	if (strlcpy(info->type, p, I2C_NAME_SIZE) >= I2C_NAME_SIZE)
+	if (strlcpy(info->type, last_wcomma, I2C_NAME_SIZE) >= I2C_NAME_SIZE)
 		return -ENOMEM;
 	return 0;
 }
-- 
1.5.5.4
