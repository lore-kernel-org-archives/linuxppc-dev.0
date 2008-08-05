Return-Path: <fenkes@de.ibm.com>
Received: from mtagate6.de.ibm.com (mtagate6.de.ibm.com [195.212.29.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 347B8DE02F
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 00:31:21 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate6.de.ibm.com (8.13.8/8.13.8) with ESMTP id m75EULIe266032
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Aug 2008 14:30:21 GMT
Received: from d12av01.megacenter.de.ibm.com (d12av01.megacenter.de.ibm.com
	[9.149.165.212])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.0) with
	ESMTP id m75EULF03018882
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Aug 2008 16:30:21 +0200
Received: from d12av01.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av01.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m75EUKGH015673
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Aug 2008 16:30:20 +0200
From: Joachim Fenkes <fenkes@de.ibm.com>
To: Paul Mackerras <paulus@samba.org>,
	"LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH] ibmebus/of_platform: Move "name" sysfs attribute into generic
	OF devices
MIME-Version: 1.0
Date: Tue, 5 Aug 2008 16:30:18 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808051630.19619.fenkes@de.ibm.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Olaf Hering <olaf@aepfle.de>,
	Paul Mackerras <pmac@au1.ibm.com>, Christoph Raisch <raisch@de.ibm.com>,
	Alexander Schmidt <alexschm@de.ibm.com>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Recent of_platform changes made of_bus_type_init() overwrite the bus type's
.dev_attrs list, so move ibmebus' "name" attribute (which is needed by eHCA
userspace support) into generic OF device code. Tested on POWER.

Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
---
 arch/powerpc/kernel/ibmebus.c |   12 ------------
 drivers/of/device.c           |   10 ++++++++++
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/ibmebus.c b/arch/powerpc/kernel/ibmebus.c
index 9d42eb5..a063622 100644
--- a/arch/powerpc/kernel/ibmebus.c
+++ b/arch/powerpc/kernel/ibmebus.c
@@ -233,17 +233,6 @@ void ibmebus_free_irq(u32 ist, void *dev_id)
 }
 EXPORT_SYMBOL(ibmebus_free_irq);
 
-static ssize_t name_show(struct device *dev,
-			 struct device_attribute *attr, char *buf)
-{
-	return sprintf(buf, "%s\n", to_of_device(dev)->node->name);
-}
-
-static struct device_attribute ibmebus_dev_attrs[] = {
-	__ATTR_RO(name),
-	__ATTR_NULL
-};
-
 static char *ibmebus_chomp(const char *in, size_t count)
 {
 	char *out = kmalloc(count + 1, GFP_KERNEL);
@@ -327,7 +316,6 @@ static struct bus_attribute ibmebus_bus_attrs[] = {
 
 struct bus_type ibmebus_bus_type = {
 	.uevent    = of_device_uevent,
-	.dev_attrs = ibmebus_dev_attrs,
 	.bus_attrs = ibmebus_bus_attrs
 };
 EXPORT_SYMBOL(ibmebus_bus_type);
diff --git a/drivers/of/device.c b/drivers/of/device.c
index 8a1d93a..51e5214 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -57,6 +57,15 @@ static ssize_t devspec_show(struct device *dev,
 	return sprintf(buf, "%s\n", ofdev->node->full_name);
 }
 
+static ssize_t name_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct of_device *ofdev;
+
+	ofdev = to_of_device(dev);
+	return sprintf(buf, "%s\n", ofdev->node->name);
+}
+
 static ssize_t modalias_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
@@ -71,6 +80,7 @@ static ssize_t modalias_show(struct device *dev,
 
 struct device_attribute of_platform_device_attrs[] = {
 	__ATTR_RO(devspec),
+	__ATTR_RO(name),
 	__ATTR_RO(modalias),
 	__ATTR_NULL
 };
-- 
1.5.5
