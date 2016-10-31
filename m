Return-Path: <geert@linux-m68k.org>
Received: from leibniz.telenet-ops.be (leibniz.telenet-ops.be
 [IPv6:2a02:1800:110:4::f00:d])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t6scq4TsWzDvHh
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2016 22:31:07 +1100 (AEDT)
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be
 [IPv6:2a02:1800:120:4::f00:13])
 by leibniz.telenet-ops.be (Postfix) with ESMTPS id 3t6scj5KBbzMqwsF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2016 12:31:01 +0100 (CET)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Yangbo Lu <yangbo.lu@nxp.com>, Simon Horman <horms@verge.net.au>,
 Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
Cc: Dirk Behme <dirk.behme@de.bosch.com>, linux-renesas-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 2/7] base: soc: Introduce soc_device_match() interface
Date: Mon, 31 Oct 2016 12:30:50 +0100
Message-Id: <1477913455-5314-3-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1477913455-5314-1-git-send-email-geert+renesas@glider.be>
References: <1477913455-5314-1-git-send-email-geert+renesas@glider.be>
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
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2:
  - Add Acked-by.
---
 drivers/base/Kconfig    |  1 +
 drivers/base/soc.c      | 66 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/sys_soc.h |  3 +++
 3 files changed, 70 insertions(+)

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index d02e7c0f5bfdff1c..2abea876c0a0c2c2 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -237,6 +237,7 @@ config GENERIC_CPU_AUTOPROBE
 
 config SOC_BUS
 	bool
+	select GLOB
 
 source "drivers/base/regmap/Kconfig"
 
diff --git a/drivers/base/soc.c b/drivers/base/soc.c
index 028cef377fd49959..04ee597fc3a3fda0 100644
--- a/drivers/base/soc.c
+++ b/drivers/base/soc.c
@@ -13,6 +13,7 @@
 #include <linux/spinlock.h>
 #include <linux/sys_soc.h>
 #include <linux/err.h>
+#include <linux/glob.h>
 
 static DEFINE_IDA(soc_ida);
 
@@ -168,3 +169,68 @@ static int __init soc_bus_register(void)
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
index 2739ccb69571e444..9f5eb06f9fd87565 100644
--- a/include/linux/sys_soc.h
+++ b/include/linux/sys_soc.h
@@ -13,6 +13,7 @@ struct soc_device_attribute {
 	const char *family;
 	const char *revision;
 	const char *soc_id;
+	const void *data;
 };
 
 /**
@@ -34,4 +35,6 @@ struct soc_device *soc_device_register(
  */
 struct device *soc_device_to_device(struct soc_device *soc);
 
+const struct soc_device_attribute *soc_device_match(
+	const struct soc_device_attribute *matches);
 #endif /* __SOC_BUS_H */
-- 
1.9.1
