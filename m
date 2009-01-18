Return-Path: <roel.kluin@gmail.com>
Received: from ey-out-2122.google.com (ey-out-2122.google.com [74.125.78.24])
	by ozlabs.org (Postfix) with ESMTP id EBD32DE08E
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Jan 2009 23:03:50 +1100 (EST)
Received: by ey-out-2122.google.com with SMTP id d26so278760eyd.15
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Jan 2009 04:03:48 -0800 (PST)
Message-ID: <49731AA3.5020603@gmail.com>
Date: Sun, 18 Jan 2009 13:03:47 +0100
From: Roel Kluin <roel.kluin@gmail.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: [PATCH] therm_adt746x: signed/unsigned confusion
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

As suggested, this is used for signed rather than unsigned

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/drivers/macintosh/therm_adt746x.c b/drivers/macintosh/therm_adt746x.c
index 82607ad..c0621d5 100644
--- a/drivers/macintosh/therm_adt746x.c
+++ b/drivers/macintosh/therm_adt746x.c
@@ -498,8 +498,8 @@ static ssize_t store_##name(struct device *dev, struct device_attribute *attr, c
 #define BUILD_STORE_FUNC_INT(name, data)			\
 static ssize_t store_##name(struct device *dev, struct device_attribute *attr, const char *buf, size_t n) \
 {								\
-	u32 val;						\
-	val = simple_strtoul(buf, NULL, 10);			\
+	int val;						\
+	val = simple_strtol(buf, NULL, 10);			\
 	if (val < 0 || val > 255)				\
 		return -EINVAL;					\
 	printk(KERN_INFO "Setting specified fan speed to %d\n", val);	\
