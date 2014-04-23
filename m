Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-lb0-f176.google.com (mail-lb0-f176.google.com
 [209.85.217.176])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A3194140171
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Apr 2014 23:53:46 +1000 (EST)
Received: by mail-lb0-f176.google.com with SMTP id 10so794301lbg.35
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Apr 2014 06:53:41 -0700 (PDT)
From: Alexander Popov <a13xp0p0v88@gmail.com>
To: Gerhard Sittig <gsi@denx.de>, Dan Williams <dan.j.williams@intel.com>,
 Vinod Koul <vinod.koul@intel.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Arnd Bergmann <arnd@arndb.de>, Anatolij Gustschin <agust@denx.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Alexander Popov <a13xp0p0v88@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 dmaengine@vger.kernel.org
Subject: [PATCH RFC v12 5/7] dma: of: add common xlate function for matching
 by channel id
Date: Wed, 23 Apr 2014 17:53:27 +0400
Message-Id: <1398261209-5578-6-git-send-email-a13xp0p0v88@gmail.com>
In-Reply-To: <1398261209-5578-1-git-send-email-a13xp0p0v88@gmail.com>
References: <1398261209-5578-1-git-send-email-a13xp0p0v88@gmail.com>
Cc: devicetree@vger.kernel.org
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
index e8fe9dc..d5fbeaa 100644
--- a/drivers/dma/of-dma.c
+++ b/drivers/dma/of-dma.c
@@ -218,3 +218,38 @@ struct dma_chan *of_dma_simple_xlate(struct of_phandle_args *dma_spec,
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
