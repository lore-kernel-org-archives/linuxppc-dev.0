Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C1CB11A0015
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2015 03:02:33 +1100 (AEDT)
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org
Subject: [RFC V2 02/12] i2c: add quirk checks to core
Date: Wed, 25 Feb 2015 17:01:53 +0100
Message-Id: <1424880126-15047-3-git-send-email-wsa@the-dreams.de>
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

Let the core do the checks if HW quirks prevent a transfer. Saves code
from drivers and adds consistency.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/i2c-core.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 210cf4874cb7ea..c5ca0e4006edb7 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1929,6 +1929,65 @@ module_exit(i2c_exit);
  * ----------------------------------------------------
  */
 
+/* Check if val is exceeding the quirk IFF quirk is non 0 */
+#define i2c_quirk_exceeded(val, quirk) ((quirk) && ((val) > (quirk)))
+
+static int i2c_quirk_error(struct i2c_adapter *adap, struct i2c_msg *msg, char *err_msg)
+{
+	dev_err_ratelimited(&adap->dev, "quirk: %s (addr 0x%04x, size %u, %s)\n",
+			    err_msg, msg->addr, msg->len,
+			    msg->flags & I2C_M_RD ? "read" : "write");
+	return -EOPNOTSUPP;
+}
+
+static int i2c_check_for_quirks(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
+{
+	const struct i2c_adapter_quirks *q = adap->quirks;
+	int max_num = q->max_num_msgs, i;
+	bool do_len_check = true;
+
+	if (q->flags & I2C_AQ_COMB) {
+		max_num = 2;
+
+		/* special checks for combined messages */
+		if (num == 2) {
+			if (q->flags & I2C_AQ_COMB_WRITE_FIRST && msgs[0].flags & I2C_M_RD)
+				return i2c_quirk_error(adap, &msgs[0], "1st comb msg not write");
+
+			if (q->flags & I2C_AQ_COMB_READ_SECOND && !(msgs[1].flags & I2C_M_RD))
+				return i2c_quirk_error(adap, &msgs[1], "2nd comb msg not read");
+
+			if (q->flags & I2C_AQ_COMB_SAME_ADDR && msgs[0].addr != msgs[1].addr)
+				return i2c_quirk_error(adap, &msgs[0], "addresses do not match");
+
+			if (i2c_quirk_exceeded(msgs[0].len, q->max_comb_1st_msg_len))
+				return i2c_quirk_error(adap, &msgs[0], "msg too long");
+
+			if (i2c_quirk_exceeded(msgs[1].len, q->max_comb_2nd_msg_len))
+				return i2c_quirk_error(adap, &msgs[1], "msg too long");
+
+			do_len_check = false;
+		}
+	}
+
+	if (i2c_quirk_exceeded(num, max_num))
+		return i2c_quirk_error(adap, &msgs[0], "too many messages");
+
+	for (i = 0; i < num; i++) {
+		u16 len = msgs[i].len;
+
+		if (msgs[i].flags & I2C_M_RD) {
+			if (do_len_check && i2c_quirk_exceeded(len, q->max_read_len))
+				return i2c_quirk_error(adap, &msgs[i], "msg too long");
+		} else {
+			if (do_len_check && i2c_quirk_exceeded(len, q->max_write_len))
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
@@ -1946,6 +2005,9 @@ int __i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 	unsigned long orig_jiffies;
 	int ret, try;
 
+	if (adap->quirks && i2c_check_for_quirks(adap, msgs, num))
+		return -EOPNOTSUPP;
+
 	/* i2c_trace_msg gets enabled when tracepoint i2c_transfer gets
 	 * enabled.  This is an efficient way of keeping the for-loop from
 	 * being executed when not needed.
-- 
2.1.4
