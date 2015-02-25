Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C30641A001E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2015 03:02:33 +1100 (AEDT)
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org
Subject: [RFC V2 01/12] i2c: add quirk structure to describe adapter flaws
Date: Wed, 25 Feb 2015 17:01:52 +0100
Message-Id: <1424880126-15047-2-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1424880126-15047-1-git-send-email-wsa@the-dreams.de>
References: <1424880126-15047-1-git-send-email-wsa@the-dreams.de>
Cc: linux-mips@linux-mips.org, Wolfram Sang <wsa@the-dreams.de>,
 linux-kernel@vger.kernel.org, Ludovic Desroches <ludovic.desroches@atmel.com>,
 Yingjoe Chen <yingjoe.chen@mediatek.com>,
 Eddie Huang <eddie.huang@mediatek.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

The number of I2C adapters which are not fully I2C compatible is rising,
sadly. Drivers usually do handle the flaws, still the user receives only
some errno for a transfer which normally can be expected to work. This
patch introduces a formal description of flaws. One advantage is that
the core can check before the actual transfer if the messages could be
transferred at all. This is done in the next patch. Another advantage is
that we can pass this information to the user so the restrictions are
exactly known and further actions can be based on that. This will be
done later after some stabilization period for this description.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 include/linux/i2c.h | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index f17da50402a4da..243d1a1d78b248 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -449,6 +449,48 @@ int i2c_recover_bus(struct i2c_adapter *adap);
 int i2c_generic_gpio_recovery(struct i2c_adapter *adap);
 int i2c_generic_scl_recovery(struct i2c_adapter *adap);
 
+/**
+ * struct i2c_adapter_quirks - describe flaws of an i2c adapter
+ * @flags: see I2C_AQ_* for possible flags and read below
+ * @max_num_msgs: maximum number of messages per transfer
+ * @max_write_len: maximum length of a write message
+ * @max_read_len: maximum length of a read message
+ * @max_comb_1st_msg_len: maximum length of the first msg in a combined message
+ * @max_comb_2nd_msg_len: maximum length of the second msg in a combined message
+ *
+ * Note about combined messages: Some I2C controllers can only send one message
+ * per transfer, plus something called combined message or write-then-read.
+ * This is (usually) a small write message followed by a read message and
+ * barely enough to access register based devices like EEPROMs. There is a flag
+ * to support this mode. It implies max_num_msg = 2 and does the length checks
+ * with max_comb_*_len because combined message mode usually has its own
+ * limitations. Because of HW implementations, some controllers can actually do
+ * write-then-anything or other variants. To support that, write-then-read has
+ * been broken out into smaller bits like write-first and read-second which can
+ * be combined as needed.
+ */
+
+struct i2c_adapter_quirks {
+	u64 flags;
+	int max_num_msgs;
+	u16 max_write_len;
+	u16 max_read_len;
+	u16 max_comb_1st_msg_len;
+	u16 max_comb_2nd_msg_len;
+};
+
+/* enforce max_num_msgs = 2 and use max_comb_*_len for length checks */
+#define I2C_AQ_COMB			BIT(0)
+/* first combined message must be write */
+#define I2C_AQ_COMB_WRITE_FIRST		BIT(1)
+/* second combined message must be read */
+#define I2C_AQ_COMB_READ_SECOND		BIT(2)
+/* both combined messages must have the same target address */
+#define I2C_AQ_COMB_SAME_ADDR		BIT(3)
+/* convenience macro for typical write-then read case */
+#define I2C_AQ_COMB_WRITE_THEN_READ	(I2C_AQ_COMB | I2C_AQ_COMB_WRITE_FIRST | \
+					 I2C_AQ_COMB_READ_SECOND | I2C_AQ_COMB_SAME_ADDR)
+
 /*
  * i2c_adapter is the structure used to identify a physical i2c bus along
  * with the access algorithms necessary to access it.
@@ -474,6 +516,7 @@ struct i2c_adapter {
 	struct list_head userspace_clients;
 
 	struct i2c_bus_recovery_info *bus_recovery_info;
+	const struct i2c_adapter_quirks *quirks;
 };
 #define to_i2c_adapter(d) container_of(d, struct i2c_adapter, dev)
 
-- 
2.1.4
