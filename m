Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D8081A0013
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2015 03:03:04 +1100 (AEDT)
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org
Subject: [RFC V2 12/12] i2c: bcm-iproc: make use of the new infrastructure for
 quirks
Date: Wed, 25 Feb 2015 17:02:03 +0100
Message-Id: <1424880126-15047-13-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1424880126-15047-1-git-send-email-wsa@the-dreams.de>
References: <1424880126-15047-1-git-send-email-wsa@the-dreams.de>
Cc: linux-mips@linux-mips.org, Scott Branden <sbranden@broadcom.com>,
 Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org,
 Ludovic Desroches <ludovic.desroches@atmel.com>,
 bcm-kernel-feedback-list@broadcom.com, Ray Jui <rjui@broadcom.com>,
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
 drivers/i2c/busses/i2c-bcm-iproc.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
index d3c89157b33774..f9f2c2082151e2 100644
--- a/drivers/i2c/busses/i2c-bcm-iproc.c
+++ b/drivers/i2c/busses/i2c-bcm-iproc.c
@@ -160,14 +160,6 @@ static int bcm_iproc_i2c_xfer_single_msg(struct bcm_iproc_i2c_dev *iproc_i2c,
 	u32 val;
 	unsigned long time_left = msecs_to_jiffies(I2C_TIMEOUT_MESC);
 
-	/* need to reserve one byte in the FIFO for the slave address */
-	if (msg->len > M_TX_RX_FIFO_SIZE - 1) {
-		dev_err(iproc_i2c->device,
-			"only support data length up to %u bytes\n",
-			M_TX_RX_FIFO_SIZE - 1);
-		return -EOPNOTSUPP;
-	}
-
 	/* check if bus is busy */
 	if (!!(readl(iproc_i2c->base + M_CMD_OFFSET) &
 	       BIT(M_CMD_START_BUSY_SHIFT))) {
@@ -287,6 +279,12 @@ static const struct i2c_algorithm bcm_iproc_algo = {
 	.functionality = bcm_iproc_i2c_functionality,
 };
 
+static struct i2c_adapter_quirks bcm_iproc_i2c_quirks = {
+	/* need to reserve one byte in the FIFO for the slave address */
+	.max_read_len = M_TX_RX_FIFO_SIZE - 1,
+	.max_write_len = M_TX_RX_FIFO_SIZE - 1,
+};
+
 static int bcm_iproc_i2c_cfg_speed(struct bcm_iproc_i2c_dev *iproc_i2c)
 {
 	unsigned int bus_speed;
@@ -413,6 +411,7 @@ static int bcm_iproc_i2c_probe(struct platform_device *pdev)
 	i2c_set_adapdata(adap, iproc_i2c);
 	strlcpy(adap->name, "Broadcom iProc I2C adapter", sizeof(adap->name));
 	adap->algo = &bcm_iproc_algo;
+	adap->quirks = &bcm_iproc_i2c_quirks;
 	adap->dev.parent = &pdev->dev;
 	adap->dev.of_node = pdev->dev.of_node;
 
-- 
2.1.4
