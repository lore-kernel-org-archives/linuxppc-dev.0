Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 71DC0DE250
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 01:41:40 +1000 (EST)
Date: Wed, 21 May 2008 19:41:39 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 2/4] [OF] spi_of: add support for dedicated SPI constructors
Message-ID: <20080521154139.GB4566@polina.dev.rtsoft.ru>
References: <20080521154103.GA32577@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080521154103.GA32577@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Gary Jennejohn <garyj@denx.de>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dedicated (usually the ones that need to fill platform data) constructors
will create board info, so SPI core will probe them as normal SPI devices.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/spi/spi_of.c       |   67 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/spi/spi_of.h |    5 +++
 2 files changed, 72 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spi_of.c b/drivers/spi/spi_of.c
index b5ae434..2e1a11f 100644
--- a/drivers/spi/spi_of.c
+++ b/drivers/spi/spi_of.c
@@ -11,6 +11,66 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_of.h>
 
+/*
+ * Caller have no idea who is master, i.e. this function does not
+ * accept pointer to the master, instead we use board infos.
+ */
+int of_spi_device_probe_common(struct device_node *np,
+			       struct spi_board_info *spi_binfo,
+			       const char *modalias)
+{
+	struct device_node *parent;
+	const u32 *bus_num;
+	const u32 *chip_select;
+	const u32 *max_speed;
+	int size;
+
+	parent = of_get_parent(np);
+	if (!parent) {
+		pr_err("%s: no parent\n", np->full_name);
+		return -EINVAL;
+	}
+
+	bus_num = of_get_property(parent, "reg", &size);
+	if (!bus_num || size < sizeof(*bus_num)) {
+		pr_err("%s: no reg specified for parent\n", np->full_name);
+		of_node_put(parent);
+		return -EINVAL;
+	}
+	spi_binfo->bus_num = *bus_num;
+	of_node_put(parent);
+
+	chip_select = of_get_property(np, "reg", &size);
+	if (!chip_select || size < sizeof(*chip_select)) {
+		pr_err("%s: no reg (chip-select) specified\n", np->full_name);
+		return -EINVAL;
+	}
+	spi_binfo->chip_select = *chip_select;
+
+	max_speed = of_get_property(np, "max-speed", &size);
+	if (!max_speed || size < sizeof(*max_speed))
+		spi_binfo->max_speed_hz = 100000;
+	else
+		spi_binfo->max_speed_hz = *max_speed;
+
+	strcpy(spi_binfo->modalias, modalias);
+
+	/*
+	 * spi_of_register_devices() should not probe this device, it will
+	 * be managed by the dedicated driver.
+	 */
+	np->data = spi_binfo;
+
+	return 0;
+}
+EXPORT_SYMBOL(of_spi_device_probe_common);
+
+void of_spi_device_remove_common(struct device_node *np)
+{
+	/* For some reason dedicated driver changed its mind. */
+	np->data = NULL;
+}
+
 /**
  * spi_of_register_devices - Register child devices onto the SPI bus
  * @master:	Pointer to spi_master device
@@ -29,6 +89,13 @@ void spi_of_register_devices(struct spi_master *master, struct device_node *np)
 	int len;
 
 	for_each_child_of_node(np, nc) {
+		if (nc->data) {
+			dev_dbg(&master->dev, "%s: device seem to be not "
+				"a simple one, somebody took care of it "
+				"already\n", np->full_name);
+			continue;
+		}
+
 		/* Alloc an spi_device */
 		spi = spi_alloc_device(master);
 		if (!spi) {
diff --git a/include/linux/spi/spi_of.h b/include/linux/spi/spi_of.h
index c943f98..1ea2d82 100644
--- a/include/linux/spi/spi_of.h
+++ b/include/linux/spi/spi_of.h
@@ -12,6 +12,11 @@
 #include <linux/of.h>
 #include <linux/spi/spi.h>
 
+extern int of_spi_device_probe_common(struct device_node *np,
+				      struct spi_board_info *spi_binfo,
+				      const char *modalias);
+extern void of_spi_device_remove_common(struct device_node *np);
+
 extern void spi_of_register_devices(struct spi_master *master,
 				    struct device_node *np);
 
-- 
1.5.5.1
