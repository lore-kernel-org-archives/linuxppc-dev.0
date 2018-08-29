Return-Path: <robherring2@gmail.com>
Received: from mail-oi0-f66.google.com (mail-oi0-f66.google.com
 [209.85.218.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 420xNx541LzF33P
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Aug 2018 06:02:24 +1000 (AEST)
Received: by mail-oi0-f66.google.com with SMTP id k12-v6so11376910oiw.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Aug 2018 13:02:24 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linux-hwmon@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] hwmon: drop unnecessary OF name NULL checks
Date: Wed, 29 Aug 2018 15:02:21 -0500
Message-Id: <20180829200221.13492-1-robh@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Checking the child node names is pointless as the DT node name can
never be NULL, so remove it.

Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-hwmon@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/hwmon/ibmpowernv.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
index 4935897f1527..0ccca87f5271 100644
--- a/drivers/hwmon/ibmpowernv.c
+++ b/drivers/hwmon/ibmpowernv.c
@@ -458,9 +458,6 @@ static int populate_attr_groups(struct platform_device *pdev)
 	for_each_child_of_node(opal, np) {
 		const char *label;
 
-		if (np->name == NULL)
-			continue;
-
 		type = get_sensor_type(np);
 		if (type == MAX_SENSOR_TYPE)
 			continue;
@@ -589,9 +586,6 @@ static int create_device_attrs(struct platform_device *pdev)
 		const char *label;
 		enum sensors type;
 
-		if (np->name == NULL)
-			continue;
-
 		type = get_sensor_type(np);
 		if (type == MAX_SENSOR_TYPE)
 			continue;
-- 
2.17.1
