Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DC62A1A0F8A
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Jan 2015 04:22:25 +1100 (AEDT)
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org
Subject: [RFC 02/11] i2c: add quirk checks to core
Date: Fri,  9 Jan 2015 18:21:32 +0100
Message-Id: <1420824103-24169-3-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1420824103-24169-1-git-send-email-wsa@the-dreams.de>
References: <1420824103-24169-1-git-send-email-wsa@the-dreams.de>
Cc: linux-mips@linux-mips.org, Wolfram Sang <wsa@the-dreams.de>,
 linux-kernel@vger.kernel.org, Ludovic Desroches <ludovic.desroches@atmel.com>,
 Yingjoe Chen <yingjoe.chen@mediatek.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Let the core do the checks if HW quirks prevent a transfer. Saves code
from drivers and adds consistency.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/i2c-core.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 39d25a8cb1ad..7b10a19abf5b 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -2063,6 +2063,56 @@ module_exit(i2c_exit);
  * ----------------------------------------------------
  */
 
+/* Check if val is exceeding the quirk IFF quirk is non 0 */
+#define i2c_quirk_exceeded(val, quirk) ((quirk) && ((val) > (quirk)))
+
+static int i2c_quirk_error(struct i2c_adapter *adap, struct i2c_msg *msg, char *err_msg)
+{
+	dev_err(&adap->dev, "quirk: %s (addr 0x%04x, size %u)\n", err_msg, msg->addr, msg->len);
+	return -EOPNOTSUPP;
+}
+
+static int i2c_check_for_quirks(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
+{
+	struct i2c_adapter_quirks *q = adap->quirks;
+	u16 max_read = q->max_read_len, max_write = q->max_write_len;
+	int max_num = q->max_num_msgs, i;
+
+	if (q->flags & I2C_ADAPTER_QUIRK_COMB_WRITE_THEN_READ)
+		max_num = 2;
+
+	if (i2c_quirk_exceeded(num, max_num))
+		return i2c_quirk_error(adap, &msgs[0], "too many messages");
+
+	if (num == 2 && q->flags & I2C_ADAPTER_QUIRK_COMB_WRITE_FIRST) {
+		if (msgs[0].flags & I2C_M_RD)
+			return i2c_quirk_error(adap, &msgs[0], "invalid first write msg");
+
+		max_write = q->max_comb_write_len;
+	}
+
+	if (num == 2 && q->flags & I2C_ADAPTER_QUIRK_COMB_READ_SECOND) {
+		if (!(msgs[1].flags & I2C_M_RD) || msgs[0].addr != msgs[1].addr)
+			return i2c_quirk_error(adap, &msgs[1], "invalid second read msg");
+
+		max_read = q->max_comb_read_len;
+	}
+
+	for (i = 0; i < num; i++) {
+		u16 len = msgs[i].len;
+
+		if (msgs[i].flags & I2C_M_RD) {
+			if (i2c_quirk_exceeded(len, max_read))
+				return i2c_quirk_error(adap, &msgs[i], "msg too long");
+		} else {
+			if (i2c_quirk_exceeded(len, max_write))
+				return i2c_quirk_error(adap, &msgs[i], "msg too long");
+		}
+	}
+
+	return 0;
+}
+
 /**
  * __i2c_transfer - unlocked flavor of i2c_transfer
  * @adap: Handle to I2C bus
@@ -2080,6 +2130,9 @@ int __i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 	unsigned long orig_jiffies;
 	int ret, try;
 
+	if (adap->quirks && i2c_check_for_quirks(adap, msgs, num))
+		return -EOPNOTSUPP;
+
 	/* i2c_trace_msg gets enabled when tracepoint i2c_transfer gets
 	 * enabled.  This is an efficient way of keeping the for-loop from
 	 * being executed when not needed.
-- 
2.1.3
