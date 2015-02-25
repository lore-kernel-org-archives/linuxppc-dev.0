Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 78D041A0013
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2015 03:02:37 +1100 (AEDT)
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org
Subject: [RFC V2 05/12] i2c: qup: make use of the new infrastructure for quirks
Date: Wed, 25 Feb 2015 17:01:56 +0100
Message-Id: <1424880126-15047-6-git-send-email-wsa@the-dreams.de>
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

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-qup.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index 4dad23bdffbe90..fdcbdab808e9fc 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -412,17 +412,6 @@ static int qup_i2c_read_one(struct qup_i2c_dev *qup, struct i2c_msg *msg)
 	unsigned long left;
 	int ret;
 
-	/*
-	 * The QUP block will issue a NACK and STOP on the bus when reaching
-	 * the end of the read, the length of the read is specified as one byte
-	 * which limits the possible read to 256 (QUP_READ_LIMIT) bytes.
-	 */
-	if (msg->len > QUP_READ_LIMIT) {
-		dev_err(qup->dev, "HW not capable of reads over %d bytes\n",
-			QUP_READ_LIMIT);
-		return -EINVAL;
-	}
-
 	qup->msg = msg;
 	qup->pos  = 0;
 
@@ -534,6 +523,15 @@ static const struct i2c_algorithm qup_i2c_algo = {
 	.functionality	= qup_i2c_func,
 };
 
+/*
+ * The QUP block will issue a NACK and STOP on the bus when reaching
+ * the end of the read, the length of the read is specified as one byte
+ * which limits the possible read to 256 (QUP_READ_LIMIT) bytes.
+ */
+static struct i2c_adapter_quirks qup_i2c_quirks = {
+	.max_read_len = QUP_READ_LIMIT,
+};
+
 static void qup_i2c_enable_clocks(struct qup_i2c_dev *qup)
 {
 	clk_prepare_enable(qup->clk);
@@ -670,6 +668,7 @@ static int qup_i2c_probe(struct platform_device *pdev)
 
 	i2c_set_adapdata(&qup->adap, qup);
 	qup->adap.algo = &qup_i2c_algo;
+	qup->adap.quirks = &qup_i2c_quirks;
 	qup->adap.dev.parent = qup->dev;
 	qup->adap.dev.of_node = pdev->dev.of_node;
 	strlcpy(qup->adap.name, "QUP I2C adapter", sizeof(qup->adap.name));
-- 
2.1.4
