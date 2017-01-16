Return-Path: <robherring2@gmail.com>
Received: from mail-oi0-f65.google.com (mail-oi0-f65.google.com
 [209.85.218.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v2QBH0CckzDqRN
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2017 07:41:27 +1100 (AEDT)
Received: by mail-oi0-f65.google.com with SMTP id u143so13406430oif.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jan 2017 12:41:26 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Frank Rowand <frowand.list@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] of: Add function for generating a DT modalias with a
 newline
Date: Mon, 16 Jan 2017 14:41:22 -0600
Message-Id: <20170116204122.5858-2-robh@kernel.org>
In-Reply-To: <20170116204122.5858-1-robh@kernel.org>
References: <20170116204122.5858-1-robh@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The modalias sysfs attr is lacking a newline for DT aliases on platform
devices. The macio and ibmebus correctly add the newline, but open code it.
Introduce a new function, of_device_modalias(), that fills the buffer with
the modalias including the newline and update users of the old
of_device_get_modalias function.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/platforms/pseries/ibmebus.c |  5 +----
 drivers/base/platform.c                  |  2 +-
 drivers/macintosh/macio_sysfs.c          |  7 +------
 drivers/of/device.c                      | 16 +++++++++++++++-
 include/linux/of_device.h                |  7 +++----
 5 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/ibmebus.c b/arch/powerpc/platforms/pseries/ibmebus.c
index 614c28537141..18f5a7a2896f 100644
--- a/arch/powerpc/platforms/pseries/ibmebus.c
+++ b/arch/powerpc/platforms/pseries/ibmebus.c
@@ -410,10 +410,7 @@ static ssize_t name_show(struct device *dev,
 static ssize_t modalias_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	ssize_t len = of_device_get_modalias(dev, buf, PAGE_SIZE - 2);
-	buf[len] = '\n';
-	buf[len+1] = 0;
-	return len+1;
+	return of_device_modalias(dev, buf, PAGE_SIZE);
 }
 
 static struct device_attribute ibmebus_bus_device_attrs[] = {
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index c4af00385502..d92f60d7f15d 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -837,7 +837,7 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *a,
 	struct platform_device	*pdev = to_platform_device(dev);
 	int len;
 
-	len = of_device_get_modalias(dev, buf, PAGE_SIZE -1);
+	len = of_device_modalias(dev, buf, PAGE_SIZE);
 	if (len != -ENODEV)
 		return len;
 
diff --git a/drivers/macintosh/macio_sysfs.c b/drivers/macintosh/macio_sysfs.c
index 8eb40afbd0f5..0b1f9c76c68d 100644
--- a/drivers/macintosh/macio_sysfs.c
+++ b/drivers/macintosh/macio_sysfs.c
@@ -41,12 +41,7 @@ compatible_show (struct device *dev, struct device_attribute *attr, char *buf)
 static ssize_t modalias_show (struct device *dev, struct device_attribute *attr,
 			      char *buf)
 {
-	int len = of_device_get_modalias(dev, buf, PAGE_SIZE - 2);
-
-	buf[len] = '\n';
-	buf[len+1] = 0;
-
-	return len+1;
+	return of_device_modalias(dev, buf, PAGE_SIZE);
 }
 
 static ssize_t devspec_show(struct device *dev,
diff --git a/drivers/of/device.c b/drivers/of/device.c
index bd620452f255..f3c3108d5a3a 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -176,7 +176,7 @@ const void *of_device_get_match_data(const struct device *dev)
 }
 EXPORT_SYMBOL(of_device_get_match_data);
 
-ssize_t of_device_get_modalias(struct device *dev, char *str, ssize_t len)
+static ssize_t of_device_get_modalias(struct device *dev, char *str, ssize_t len)
 {
 	const char *compat;
 	int cplen, i;
@@ -227,6 +227,20 @@ ssize_t of_device_get_modalias(struct device *dev, char *str, ssize_t len)
 }
 
 /**
+ * of_device_modalias - Fill buffer with newline terminated modalias string
+ */
+ssize_t of_device_modalias(struct device *dev, char *str, ssize_t len)
+{
+	ssize_t sl = of_device_get_modalias(dev, str, len - 2);
+	if (sl < 0)
+		return sl;
+
+	str[sl++] = '\n';
+	str[sl] = 0;
+	return sl;
+}
+
+/**
  * of_device_uevent - Display OF related uevent information
  */
 void of_device_uevent(struct device *dev, struct kobj_uevent_env *env)
diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index cc7dd687a89d..971d7250a8a4 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -35,8 +35,7 @@ extern void of_device_unregister(struct platform_device *ofdev);
 
 extern const void *of_device_get_match_data(const struct device *dev);
 
-extern ssize_t of_device_get_modalias(struct device *dev,
-					char *str, ssize_t len);
+extern ssize_t of_device_modalias(struct device *dev, char *str, ssize_t len);
 
 extern void of_device_uevent(struct device *dev, struct kobj_uevent_env *env);
 extern int of_device_uevent_modalias(struct device *dev, struct kobj_uevent_env *env);
@@ -72,8 +71,8 @@ static inline const void *of_device_get_match_data(const struct device *dev)
 	return NULL;
 }
 
-static inline int of_device_get_modalias(struct device *dev,
-				   char *str, ssize_t len)
+static inline int of_device_modalias(struct device *dev,
+				     char *str, ssize_t len)
 {
 	return -ENODEV;
 }
-- 
2.10.1
