Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-we0-x22e.google.com (mail-we0-x22e.google.com
 [IPv6:2a00:1450:400c:c03::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 58A4C2C00C8
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Oct 2013 00:05:16 +1000 (EST)
MIME-Version: 1.0
In-Reply-To: <1373803321-11628-4-git-send-email-gsi@denx.de>
References: <1373642781-32631-1-git-send-email-gsi@denx.de>
 <1373803321-11628-1-git-send-email-gsi@denx.de>
 <1373803321-11628-4-git-send-email-gsi@denx.de>
Date: Thu, 3 Oct 2013 18:05:12 +0400
Message-ID: <CAF0T0X6BFNat8iccsXpgm0qu9zRhQCFiras5Yena6F8yBwAX6w@mail.gmail.com>
Subject: Re: [PATCH RFC v2 3/5] dma: of: Add common xlate function for
 matching by channel id
From: Alexander Popov <a13xp0p0v88@gmail.com>
To: Gerhard Sittig <gsi@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Lars-Peter Clausen <lars@metafoo.de>, Arnd Bergmann <arnd@arndb.de>,
 Vinod Koul <vinod.koul@intel.com>, devicetree-discuss@lists.ozlabs.org,
 Alexander Popov <a13xp0p0v88@gmail.com>,
 Dan Williams <dan.j.williams@intel.com>, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Lars-Peter Clausen <lars@metafoo.de>

This patch adds a new common OF dma xlate callback function which will match a
channel by it's id. The binding expects one integer argument which it
will use to
lookup the channel by the id.

Unlike of_dma_simple_xlate this function is able to handle a system with
multiple DMA controllers. When registering the of dma provider with
of_dma_controller_register a pointer to the dma_device struct which is
associated with the dt node needs to passed as the data parameter. The filter
function will use this pointer to match only channels which belong to the
specified DMA controller.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 drivers/dma/of-dma.c   |   47 ++++++++++++++++++++++++++++++
+++++++++++++++++
 include/linux/of_dma.h |    4 ++++
 2 files changed, 51 insertions(+)

diff --git a/drivers/dma/of-dma.c b/drivers/dma/of-dma.c
index 7aa0864..d5d528e 100644
--- a/drivers/dma/of-dma.c
+++ b/drivers/dma/of-dma.c
@@ -229,3 +229,50 @@ struct dma_chan *of_dma_simple_xlate(struct
of_phandle_args *dma_spec,
                        &dma_spec->args[0]);
 }
 EXPORT_SYMBOL_GPL(of_dma_simple_xlate);
+
+struct of_dma_filter_by_chan_id_args {
+       struct dma_device *dev;
+       unsigned int chan_id;
+};
+
+static bool of_dma_filter_by_chan_id(struct dma_chan *chan, void *params)
+{
+       struct of_dma_filter_by_chan_id_args *args = params;
+
+       return chan->device == args->dev && chan->chan_id == args->chan_id;
+}
+
+/**
+ * of_dma_xlate_by_chan_id - Translate dt property to DMA channel by channel id
+ * @dma_spec:  pointer to DMA specifier as found in the device tree
+ * @of_dma:    pointer to DMA controller data
+ *
+ * This function can be used as the of xlate callback for DMA driver
which wants
+ * to match the channel based on the channel id. When using this xlate function
+ * the #dma-cells propety of the DMA controller dt node needs to be set to 1.
+ * The data parameter of of_dma_controller_register must be a pointer to the
+ * dma_device struct the function should match upon.
+ *
+ * Returns pointer to appropriate dma channel on success or NULL on error.
+ */
+struct dma_chan *of_dma_xlate_by_chan_id(struct of_phandle_args *dma_spec,
+                                        struct of_dma *ofdma)
+{
+       struct of_dma_filter_by_chan_id_args args;
+       dma_cap_mask_t cap;
+
+       args.dev = ofdma->of_dma_data;
+       if (!args.dev)
+               return NULL;
+
+       if (dma_spec->args_count != 1)
+               return NULL;
+
+       dma_cap_zero(cap);
+       dma_cap_set(DMA_SLAVE, cap);
+
+       args.chan_id = dma_spec->args[0];
+
+       return dma_request_channel(cap, of_dma_filter_by_chan_id, &args);
+}
+EXPORT_SYMBOL_GPL(of_dma_xlate_by_chan_id);
diff --git a/include/linux/of_dma.h b/include/linux/of_dma.h
index 364dda7..b7cf614 100644
--- a/include/linux/of_dma.h
+++ b/include/linux/of_dma.h
@@ -42,6 +42,8 @@ extern struct dma_chan
*of_dma_request_slave_channel(struct device_node *np,
                                                     const char *name);
 extern struct dma_chan *of_dma_simple_xlate(struct of_phandle_args *dma_spec,
                struct of_dma *ofdma);
+extern struct dma_chan *of_dma_xlate_by_chan_id(struct
of_phandle_args *dma_spec,
+               struct of_dma *ofdma);
 #else
 static inline int of_dma_controller_register(struct device_node *np,
                struct dma_chan *(*of_dma_xlate)
@@ -67,6 +69,8 @@ static inline struct dma_chan
*of_dma_simple_xlate(struct of_phandle_args *dma_s
        return NULL;
 }

+#define of_dma_xlate_by_chan_id NULL
+
 #endif

 #endif /* __LINUX_OF_DMA_H */

--
1.7.10.4
