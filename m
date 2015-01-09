Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C5ABF1A0F7F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Jan 2015 04:22:27 +1100 (AEDT)
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org
Subject: [RFC 06/11] i2c: cpm: make use of the new infrastructure for quirks
Date: Fri,  9 Jan 2015 18:21:36 +0100
Message-Id: <1420824103-24169-7-git-send-email-wsa@the-dreams.de>
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

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/i2c-cpm.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cpm.c b/drivers/i2c/busses/i2c-cpm.c
index 2d466538b2e2..714bdc837769 100644
--- a/drivers/i2c/busses/i2c-cpm.c
+++ b/drivers/i2c/busses/i2c-cpm.c
@@ -308,22 +308,12 @@ static int cpm_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 	struct i2c_reg __iomem *i2c_reg = cpm->i2c_reg;
 	struct i2c_ram __iomem *i2c_ram = cpm->i2c_ram;
 	struct i2c_msg *pmsg;
-	int ret, i;
+	int ret;
 	int tptr;
 	int rptr;
 	cbd_t __iomem *tbdf;
 	cbd_t __iomem *rbdf;
 
-	if (num > CPM_MAXBD)
-		return -EINVAL;
-
-	/* Check if we have any oversized READ requests */
-	for (i = 0; i < num; i++) {
-		pmsg = &msgs[i];
-		if (pmsg->len >= CPM_MAX_READ)
-			return -EINVAL;
-	}
-
 	/* Reset to use first buffer */
 	out_be16(&i2c_ram->rbptr, in_be16(&i2c_ram->rbase));
 	out_be16(&i2c_ram->tbptr, in_be16(&i2c_ram->tbase));
@@ -424,10 +414,18 @@ static const struct i2c_algorithm cpm_i2c_algo = {
 	.functionality = cpm_i2c_func,
 };
 
+/* CPM_MAX_READ is also limiting writes according to the code! */
+static struct i2c_adapter_quirks cpm_i2c_quirks = {
+	.max_num_msgs = CPM_MAXBD,
+	.max_read_len = CPM_MAX_READ,
+	.max_write_len = CPM_MAX_READ,
+};
+
 static const struct i2c_adapter cpm_ops = {
 	.owner		= THIS_MODULE,
 	.name		= "i2c-cpm",
 	.algo		= &cpm_i2c_algo,
+	.quirks		= &cpm_i2c_quirks,
 };
 
 static int cpm_i2c_setup(struct cpm_i2c *cpm)
-- 
2.1.3
