Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-lb0-x22f.google.com (mail-lb0-x22f.google.com
 [IPv6:2a00:1450:4010:c04::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 613542C00B9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Dec 2013 23:02:54 +1100 (EST)
Received: by mail-lb0-f175.google.com with SMTP id w6so2794266lbh.20
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Dec 2013 04:02:49 -0800 (PST)
From: Alexander Popov <a13xp0p0v88@gmail.com>
To: Gerhard Sittig <gsi@denx.de>, Dan Williams <dan.j.williams@intel.com>,
 Vinod Koul <vinod.koul@intel.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Arnd Bergmann <arnd@arndb.de>, Anatolij Gustschin <agust@denx.de>,
 Alexander Popov <a13xp0p0v88@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH RFC v6 3/5] dma: of: Add common xlate function for matching by
 channel id
Date: Tue, 24 Dec 2013 16:06:27 +0400
Message-Id: <1387886789-20249-4-git-send-email-a13xp0p0v88@gmail.com>
In-Reply-To: <1387886789-20249-1-git-send-email-a13xp0p0v88@gmail.com>
References: <1387886789-20249-1-git-send-email-a13xp0p0v88@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds a new common OF dma xlate callback function which will match a
channel by it's id. The binding expects one integer argument which it will use to
lookup the channel by the id.

Unlike of_dma_simple_xlate this function is able to handle a system with
multiple DMA controllers. When registering the of dma provider with
of_dma_controller_register a pointer to the dma_device struct which is
associated with the dt node needs to passed as the data parameter.
New function will use this pointer to match only channels which belong to the
specified DMA controller.

Signed-off-by: Alexander Popov <a13xp0p0v88@gmail.com>
---
 drivers/dma/of-dma.c   | 35 +++++++++++++++++++++++++++++++++++
 include/linux/of_dma.h |  4 ++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/dma/of-dma.c b/drivers/dma/of-dma.c
index 0b88dd3..03a375e 100644
--- a/drivers/dma/of-dma.c
+++ b/drivers/dma/of-dma.c
@@ -215,3 +215,38 @@ struct dma_chan *of_dma_simple_xlate(struct of_phandle_args *dma_spec,
 			&dma_spec->args[0]);
 }
 EXPORT_SYMBOL_GPL(of_dma_simple_xlate);
+
+/**
+ * of_dma_xlate_by_chan_id - Translate dt property to DMA channel by channel id
+ * @dma_spec:	pointer to DMA specifier as found in the device tree
+ * @of_dma:	pointer to DMA controller data
+ *
+ * This function can be used as the of xlate callback for DMA driver which wants
+ * to match the channel based on the channel id. When using this xlate function
+ * the #dma-cells propety of the DMA controller dt node needs to be set to 1.
+ * The data parameter of of_dma_controller_register must be a pointer to the
+ * dma_device struct the function should match upon.
+ *
+ * Returns pointer to appropriate dma channel on success or NULL on error.
+ */
+struct dma_chan *of_dma_xlate_by_chan_id(struct of_phandle_args *dma_spec,
+					 struct of_dma *ofdma)
+{
+	struct dma_device *dev = ofdma->of_dma_data;
+	struct dma_chan *chan, *candidate = NULL;
+
+	if (!dev || dma_spec->args_count != 1)
+		return NULL;
+
+	list_for_each_entry(chan, &dev->channels, device_node)
+		if (chan->chan_id == dma_spec->args[0]) {
+			candidate = chan;
+			break;
+		}
+
+	if (!candidate)
+		return NULL;
+
+	return dma_get_slave_channel(candidate);
+}
+EXPORT_SYMBOL_GPL(of_dma_xlate_by_chan_id);
diff --git a/include/linux/of_dma.h b/include/linux/of_dma.h
index ae36298..56bc026 100644
--- a/include/linux/of_dma.h
+++ b/include/linux/of_dma.h
@@ -41,6 +41,8 @@ extern struct dma_chan *of_dma_request_slave_channel(struct device_node *np,
 						     const char *name);
 extern struct dma_chan *of_dma_simple_xlate(struct of_phandle_args *dma_spec,
 		struct of_dma *ofdma);
+extern struct dma_chan *of_dma_xlate_by_chan_id(struct of_phandle_args *dma_spec,
+		struct of_dma *ofdma);
 #else
 static inline int of_dma_controller_register(struct device_node *np,
 		struct dma_chan *(*of_dma_xlate)
@@ -66,6 +68,8 @@ static inline struct dma_chan *of_dma_simple_xlate(struct of_phandle_args *dma_s
 	return NULL;
 }
 
+#define of_dma_xlate_by_chan_id NULL
+
 #endif
 
 #endif /* __LINUX_OF_DMA_H */
-- 
1.8.4.2
