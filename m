Return-Path: <sfalco@harris.com>
Received: from mlbe2k1.cs.myharris.net (mlbe2k1.cs.myharris.net
	[137.237.90.88]) by ozlabs.org (Postfix) with ESMTP id A4F02DED13
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Oct 2008 01:04:36 +1100 (EST)
Message-ID: <48EF60F1.1010001@harris.com>
Date: Fri, 10 Oct 2008 10:04:33 -0400
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, david-b@pacbell.net
Subject: [PATCH] Modify sysfs gpio export so that "value" displays as 0 or
 1
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

gpiolib can export GPIOs to userspace via sysfs.  This patch modifies
the gpio_value_show() so that any non-zero value is explicitly printed
as "1", rather than whatever numerical value the lower-level driver returns.

Signed-off-by: Steve Falco <sfalco at harris.com>
---

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 8d29405..36bf72b 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -237,7 +237,7 @@ static ssize_t gpio_value_show(struct device *dev,
 	if (!test_bit(FLAG_EXPORT, &desc->flags))
 		status = -EIO;
 	else
-		status = sprintf(buf, "%d\n", gpio_get_value_cansleep(gpio));
+		status = sprintf(buf, "%d\n", !!gpio_get_value_cansleep(gpio));
 
 	mutex_unlock(&sysfs_lock);
 	return status;
