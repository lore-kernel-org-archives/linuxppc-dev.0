Return-Path: <yangbo.lu@nxp.com>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on0054.outbound.protection.outlook.com [104.47.36.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t4vqy6bNyzDvS3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2016 18:03:58 +1100 (AEDT)
From: Yangbo Lu <yangbo.lu@nxp.com>
To: <linux-mmc@vger.kernel.org>, <ulf.hansson@linaro.org>, Scott Wood
 <oss@buserror.net>, Arnd Bergmann <arnd@arndb.de>
CC: <linuxppc-dev@lists.ozlabs.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <linux-clk@vger.kernel.org>, <linux-i2c@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>, <netdev@vger.kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland
 <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Russell King
 <linux@arm.linux.org.uk>, Jochen Friedrich <jochen@scram.de>, Joerg Roedel
 <joro@8bytes.org>, Claudiu Manoil <claudiu.manoil@freescale.com>, Bhupesh
 Sharma <bhupesh.sharma@freescale.com>, Qiang Zhao <qiang.zhao@nxp.com>, Kumar
 Gala <galak@codeaurora.org>, Santosh Shilimkar <ssantosh@kernel.org>, Leo Li
 <leoyang.li@nxp.com>, Xiaobo Xie <xiaobo.xie@nxp.com>, Minghuan Lian
 <minghuan.lian@nxp.com>, Yangbo Lu <yangbo.lu@nxp.com>
Subject: [v15, 6/7] base: soc: introduce soc_device_match() interface
Date: Fri, 28 Oct 2016 14:50:17 +0800
Message-ID: <1477637418-38938-7-git-send-email-yangbo.lu@nxp.com>
In-Reply-To: <1477637418-38938-1-git-send-email-yangbo.lu@nxp.com>
References: <1477637418-38938-1-git-send-email-yangbo.lu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Arnd Bergmann <arnd@arndb.de>

We keep running into cases where device drivers want to know the exact
version of the a SoC they are currently running on. In the past, this has
usually been done through a vendor specific API that can be called by a
driver, or by directly accessing some kind of version register that is
not part of the device itself but that belongs to a global register area
of the chip.

Common reasons for doing this include:

- A machine is not using devicetree or similar for passing data about
  on-chip devices, but just announces their presence using boot-time
  platform devices, and the machine code itself does not care about the
  revision.

- There is existing firmware or boot loaders with existing DT binaries
  with generic compatible strings that do not identify the particular
  revision of each device, but the driver knows which SoC revisions
  include which part.

- A prerelease version of a chip has some quirks and we are using the same
  version of the bootloader and the DT blob on both the prerelease and the
  final version. An update of the DT binding seems inappropriate because
  that would involve maintaining multiple copies of the dts and/or
  bootloader.

This patch introduces the soc_device_match() interface that is meant to
work like of_match_node() but instead of identifying the version of a
device, it identifies the SoC itself using a vendor-agnostic interface.

Unlike of_match_node(), we do not do an exact string compare but instead
use glob_match() to allow wildcards in strings.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Changes for v11:
	- Added this patch for soc match
Changes for v12:
	- Corrected the author
	- Rewrited soc_device_match with while loop
Changes for v13:
	- Added ack from Greg
Changes for v14:
	- None
Changes for v15:
	- None
---
 drivers/base/Kconfig    |  1 +
 drivers/base/soc.c      | 66 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/sys_soc.h |  3 +++
 3 files changed, 70 insertions(+)

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index fdf44ca..991b21e 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -235,6 +235,7 @@ config GENERIC_CPU_AUTOPROBE
 
 config SOC_BUS
 	bool
+	select GLOB
 
 source "drivers/base/regmap/Kconfig"
 
diff --git a/drivers/base/soc.c b/drivers/base/soc.c
index b63f23e..0c5cf87 100644
--- a/drivers/base/soc.c
+++ b/drivers/base/soc.c
@@ -13,6 +13,7 @@
 #include <linux/spinlock.h>
 #include <linux/sys_soc.h>
 #include <linux/err.h>
+#include <linux/glob.h>
 
 static DEFINE_IDA(soc_ida);
 
@@ -159,3 +160,68 @@ static int __init soc_bus_register(void)
 	return bus_register(&soc_bus_type);
 }
 core_initcall(soc_bus_register);
+
+static int soc_device_match_one(struct device *dev, void *arg)
+{
+	struct soc_device *soc_dev = container_of(dev, struct soc_device, dev);
+	const struct soc_device_attribute *match = arg;
+
+	if (match->machine &&
+	    !glob_match(match->machine, soc_dev->attr->machine))
+		return 0;
+
+	if (match->family &&
+	    !glob_match(match->family, soc_dev->attr->family))
+		return 0;
+
+	if (match->revision &&
+	    !glob_match(match->revision, soc_dev->attr->revision))
+		return 0;
+
+	if (match->soc_id &&
+	    !glob_match(match->soc_id, soc_dev->attr->soc_id))
+		return 0;
+
+	return 1;
+}
+
+/*
+ * soc_device_match - identify the SoC in the machine
+ * @matches: zero-terminated array of possible matches
+ *
+ * returns the first matching entry of the argument array, or NULL
+ * if none of them match.
+ *
+ * This function is meant as a helper in place of of_match_node()
+ * in cases where either no device tree is available or the information
+ * in a device node is insufficient to identify a particular variant
+ * by its compatible strings or other properties. For new devices,
+ * the DT binding should always provide unique compatible strings
+ * that allow the use of of_match_node() instead.
+ *
+ * The calling function can use the .data entry of the
+ * soc_device_attribute to pass a structure or function pointer for
+ * each entry.
+ */
+const struct soc_device_attribute *soc_device_match(
+	const struct soc_device_attribute *matches)
+{
+	int ret = 0;
+
+	if (!matches)
+		return NULL;
+
+	while (!ret) {
+		if (!(matches->machine || matches->family ||
+		      matches->revision || matches->soc_id))
+			break;
+		ret = bus_for_each_dev(&soc_bus_type, NULL, (void *)matches,
+				       soc_device_match_one);
+		if (!ret)
+			matches++;
+		else
+			return matches;
+	}
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(soc_device_match);
diff --git a/include/linux/sys_soc.h b/include/linux/sys_soc.h
index 2739ccb..9f5eb06 100644
--- a/include/linux/sys_soc.h
+++ b/include/linux/sys_soc.h
@@ -13,6 +13,7 @@ struct soc_device_attribute {
 	const char *family;
 	const char *revision;
 	const char *soc_id;
+	const void *data;
 };
 
 /**
@@ -34,4 +35,6 @@ void soc_device_unregister(struct soc_device *soc_dev);
  */
 struct device *soc_device_to_device(struct soc_device *soc);
 
+const struct soc_device_attribute *soc_device_match(
+	const struct soc_device_attribute *matches);
 #endif /* __SOC_BUS_H */
-- 
2.1.0.27.g96db324
