Return-Path: <peda@axentia.se>
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Brendan Higgins <brendanhiggins@google.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 Guenter Roeck <linux@roeck-us.net>,
 =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Peter Korsgaard <jacmet@sunsite.dk>, Andy Gross <andy.gross@linaro.org>,
 David Brown <david.brown@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>, linux-i2c@vger.kernel.org,
 openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Subject: [PATCH v2 2/2] i2c: busses: make use of i2c_8bit_addr_from_msg
Date: Wed, 16 May 2018 09:16:47 +0200
Message-Id: <20180516071647.29277-3-peda@axentia.se>
In-Reply-To: <20180516071647.29277-1-peda@axentia.se>
References: <20180516071647.29277-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Because it looks neater.

For diolan, this allows factoring out some code that is now common
between if and else.

For eg20t, pch_i2c_writebytes is always called with a write in
msgs->flags, and pch_i2c_readbytes with a read.

For imx, i2c_imx_dma_write and i2c_imx_write are always called with a
write in msgs->flags, and i2c_imx_read with a read.

For qup, qup_i2c_write_tx_fifo_v1 is always called with a write in
qup->msg->flags.

For stu300, also restructure debug output for resends, since that
code as a result is only handling debug output.

Reviewed-by: Guenter Roeck <linux@roeck-us.net> [diolan]
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de> [emf32 and imx]
Acked-by: Linus Walleij <linus.walleij@linaro.org> [stu300]
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/busses/i2c-aspeed.c     |  3 +--
 drivers/i2c/busses/i2c-axxia.c      |  5 +++--
 drivers/i2c/busses/i2c-diolan-u2c.c | 11 ++++-------
 drivers/i2c/busses/i2c-efm32.c      |  3 +--
 drivers/i2c/busses/i2c-eg20t.c      |  5 ++---
 drivers/i2c/busses/i2c-emev2.c      |  2 +-
 drivers/i2c/busses/i2c-hix5hd2.c    |  9 ++-------
 drivers/i2c/busses/i2c-imx-lpi2c.c  |  4 +---
 drivers/i2c/busses/i2c-imx.c        | 10 +++++-----
 drivers/i2c/busses/i2c-kempld.c     |  7 +++----
 drivers/i2c/busses/i2c-mxs.c        |  9 +++------
 drivers/i2c/busses/i2c-ocores.c     |  5 +----
 drivers/i2c/busses/i2c-pasemi.c     |  2 +-
 drivers/i2c/busses/i2c-qup.c        |  2 +-
 drivers/i2c/busses/i2c-rcar.c       |  2 +-
 drivers/i2c/busses/i2c-riic.c       |  5 ++---
 drivers/i2c/busses/i2c-stu300.c     | 22 +++++++++++++---------
 drivers/i2c/busses/i2c-xiic.c       | 11 ++---------
 18 files changed, 47 insertions(+), 70 deletions(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index 7d4aeb4465b3..60e4d0e939a3 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -335,13 +335,12 @@ static void aspeed_i2c_do_start(struct aspeed_i2c_bus *bus)
 {
 	u32 command = ASPEED_I2CD_M_START_CMD | ASPEED_I2CD_M_TX_CMD;
 	struct i2c_msg *msg = &bus->msgs[bus->msgs_index];
-	u8 slave_addr = msg->addr << 1;
+	u8 slave_addr = i2c_8bit_addr_from_msg(msg);
 
 	bus->master_state = ASPEED_I2C_MASTER_START;
 	bus->buf_index = 0;
 
 	if (msg->flags & I2C_M_RD) {
-		slave_addr |= 1;
 		command |= ASPEED_I2CD_M_RX_CMD;
 		/* Need to let the hardware know to NACK after RX. */
 		if (msg->len == 1 && !(msg->flags & I2C_M_RECV_LEN))
diff --git a/drivers/i2c/busses/i2c-axxia.c b/drivers/i2c/busses/i2c-axxia.c
index 13f07482ec68..f70b097fd567 100644
--- a/drivers/i2c/busses/i2c-axxia.c
+++ b/drivers/i2c/busses/i2c-axxia.c
@@ -351,13 +351,15 @@ static int axxia_i2c_xfer_msg(struct axxia_i2c_dev *idev, struct i2c_msg *msg)
 		 *   addr_2: addr[7:0]
 		 */
 		addr_1 = 0xF0 | ((msg->addr >> 7) & 0x06);
+		if (i2c_m_rd(msg))
+			addr_1 |= 1;	/* Set the R/nW bit of the address */
 		addr_2 = msg->addr & 0xFF;
 	} else {
 		/* 7-bit address
 		 *   addr_1: addr[6:0] | (R/nW)
 		 *   addr_2: dont care
 		 */
-		addr_1 = (msg->addr << 1) & 0xFF;
+		addr_1 = i2c_8bit_addr_from_msg(msg);
 		addr_2 = 0;
 	}
 
@@ -365,7 +367,6 @@ static int axxia_i2c_xfer_msg(struct axxia_i2c_dev *idev, struct i2c_msg *msg)
 		/* I2C read transfer */
 		rx_xfer = i2c_m_recv_len(msg) ? I2C_SMBUS_BLOCK_MAX : msg->len;
 		tx_xfer = 0;
-		addr_1 |= 1;	/* Set the R/nW bit of the address */
 	} else {
 		/* I2C write transfer */
 		rx_xfer = 0;
diff --git a/drivers/i2c/busses/i2c-diolan-u2c.c b/drivers/i2c/busses/i2c-diolan-u2c.c
index f718ee4e3332..3f28317cde39 100644
--- a/drivers/i2c/busses/i2c-diolan-u2c.c
+++ b/drivers/i2c/busses/i2c-diolan-u2c.c
@@ -360,11 +360,11 @@ static int diolan_usb_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs,
 			if (ret < 0)
 				goto abort;
 		}
+		ret = diolan_i2c_put_byte_ack(dev,
+					      i2c_8bit_addr_from_msg(pmsg));
+		if (ret < 0)
+			goto abort;
 		if (pmsg->flags & I2C_M_RD) {
-			ret =
-			    diolan_i2c_put_byte_ack(dev, (pmsg->addr << 1) | 1);
-			if (ret < 0)
-				goto abort;
 			for (j = 0; j < pmsg->len; j++) {
 				u8 byte;
 				bool ack = j < pmsg->len - 1;
@@ -393,9 +393,6 @@ static int diolan_usb_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs,
 				pmsg->buf[j] = byte;
 			}
 		} else {
-			ret = diolan_i2c_put_byte_ack(dev, pmsg->addr << 1);
-			if (ret < 0)
-				goto abort;
 			for (j = 0; j < pmsg->len; j++) {
 				ret = diolan_i2c_put_byte_ack(dev,
 							      pmsg->buf[j]);
diff --git a/drivers/i2c/busses/i2c-efm32.c b/drivers/i2c/busses/i2c-efm32.c
index aa336ba89aa3..5f2bab878b2c 100644
--- a/drivers/i2c/busses/i2c-efm32.c
+++ b/drivers/i2c/busses/i2c-efm32.c
@@ -144,8 +144,7 @@ static void efm32_i2c_send_next_msg(struct efm32_i2c_ddata *ddata)
 	struct i2c_msg *cur_msg = &ddata->msgs[ddata->current_msg];
 
 	efm32_i2c_write32(ddata, REG_CMD, REG_CMD_START);
-	efm32_i2c_write32(ddata, REG_TXDATA, cur_msg->addr << 1 |
-			(cur_msg->flags & I2C_M_RD ? 1 : 0));
+	efm32_i2c_write32(ddata, REG_TXDATA, i2c_8bit_addr_from_msg(cur_msg));
 }
 
 static void efm32_i2c_send_next_byte(struct efm32_i2c_ddata *ddata)
diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
index bdeab0174fec..835d54ac2971 100644
--- a/drivers/i2c/busses/i2c-eg20t.c
+++ b/drivers/i2c/busses/i2c-eg20t.c
@@ -414,7 +414,7 @@ static s32 pch_i2c_writebytes(struct i2c_adapter *i2c_adap,
 		iowrite32(addr_8_lsb, p + PCH_I2CDR);
 	} else {
 		/* set 7 bit slave address and R/W bit as 0 */
-		iowrite32(addr << 1, p + PCH_I2CDR);
+		iowrite32(i2c_8bit_addr_from_msg(msgs), p + PCH_I2CDR);
 		if (first)
 			pch_i2c_start(adap);
 	}
@@ -538,8 +538,7 @@ static s32 pch_i2c_readbytes(struct i2c_adapter *i2c_adap, struct i2c_msg *msgs,
 		iowrite32(addr_2_msb | TEN_BIT_ADDR_MASK, p + PCH_I2CDR);
 	} else {
 		/* 7 address bits + R/W bit */
-		addr = (((addr) << 1) | (I2C_RD));
-		iowrite32(addr, p + PCH_I2CDR);
+		iowrite32(i2c_8bit_addr_from_msg(msgs), p + PCH_I2CDR);
 	}
 
 	/* check if it is the first message */
diff --git a/drivers/i2c/busses/i2c-emev2.c b/drivers/i2c/busses/i2c-emev2.c
index d2e84480fbe9..ba9b6ea48a31 100644
--- a/drivers/i2c/busses/i2c-emev2.c
+++ b/drivers/i2c/busses/i2c-emev2.c
@@ -149,7 +149,7 @@ static int __em_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msg,
 	em_clear_set_bit(priv, 0, I2C_BIT_STT0, I2C_OFS_IICC0);
 
 	/* Send slave address and R/W type */
-	writeb((msg->addr << 1) | read, priv->base + I2C_OFS_IIC0);
+	writeb(i2c_8bit_addr_from_msg(msg), priv->base + I2C_OFS_IIC0);
 
 	/* Wait for transaction */
 	status = em_i2c_wait_for_event(priv);
diff --git a/drivers/i2c/busses/i2c-hix5hd2.c b/drivers/i2c/busses/i2c-hix5hd2.c
index bb68957d3da5..399b64c4c620 100644
--- a/drivers/i2c/busses/i2c-hix5hd2.c
+++ b/drivers/i2c/busses/i2c-hix5hd2.c
@@ -73,7 +73,6 @@
 #define I2C_OVER_INTR		BIT(0)
 
 #define HIX5I2C_MAX_FREQ	400000		/* 400k */
-#define HIX5I2C_READ_OPERATION	0x01
 
 enum hix5hd2_i2c_state {
 	HIX5I2C_STAT_RW_ERR = -1,
@@ -311,12 +310,8 @@ static void hix5hd2_i2c_message_start(struct hix5hd2_i2c_priv *priv, int stop)
 	hix5hd2_i2c_clr_all_irq(priv);
 	hix5hd2_i2c_enable_irq(priv);
 
-	if (priv->msg->flags & I2C_M_RD)
-		writel_relaxed((priv->msg->addr << 1) | HIX5I2C_READ_OPERATION,
-			       priv->regs + HIX5I2C_TXR);
-	else
-		writel_relaxed(priv->msg->addr << 1,
-			       priv->regs + HIX5I2C_TXR);
+	writel_relaxed(i2c_8bit_addr_from_msg(priv->msg),
+		       priv->regs + HIX5I2C_TXR);
 
 	writel_relaxed(I2C_WRITE | I2C_START, priv->regs + HIX5I2C_COM);
 	spin_unlock_irqrestore(&priv->lock, flags);
diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
index e6da2c7a9a3e..159d23211600 100644
--- a/drivers/i2c/busses/i2c-imx-lpi2c.c
+++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
@@ -180,15 +180,13 @@ static int lpi2c_imx_start(struct lpi2c_imx_struct *lpi2c_imx,
 			   struct i2c_msg *msgs)
 {
 	unsigned int temp;
-	u8 read;
 
 	temp = readl(lpi2c_imx->base + LPI2C_MCR);
 	temp |= MCR_RRF | MCR_RTF;
 	writel(temp, lpi2c_imx->base + LPI2C_MCR);
 	writel(0x7f00, lpi2c_imx->base + LPI2C_MSR);
 
-	read = msgs->flags & I2C_M_RD;
-	temp = (msgs->addr << 1 | read) | (GEN_START << 8);
+	temp = i2c_8bit_addr_from_msg(msgs) | (GEN_START << 8);
 	writel(temp, lpi2c_imx->base + LPI2C_MTDR);
 
 	return lpi2c_imx_bus_busy(lpi2c_imx);
diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index d7267dd9c7bf..bcb41fc75043 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -630,7 +630,7 @@ static int i2c_imx_dma_write(struct imx_i2c_struct *i2c_imx,
 	 * Write slave address.
 	 * The first byte must be transmitted by the CPU.
 	 */
-	imx_i2c_write_reg(msgs->addr << 1, i2c_imx, IMX_I2C_I2DR);
+	imx_i2c_write_reg(i2c_8bit_addr_from_msg(msgs), i2c_imx, IMX_I2C_I2DR);
 	reinit_completion(&i2c_imx->dma->cmd_complete);
 	time_left = wait_for_completion_timeout(
 				&i2c_imx->dma->cmd_complete,
@@ -760,10 +760,10 @@ static int i2c_imx_write(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs)
 	int i, result;
 
 	dev_dbg(&i2c_imx->adapter.dev, "<%s> write slave address: addr=0x%x\n",
-		__func__, msgs->addr << 1);
+		__func__, i2c_8bit_addr_from_msg(msgs));
 
 	/* write slave address */
-	imx_i2c_write_reg(msgs->addr << 1, i2c_imx, IMX_I2C_I2DR);
+	imx_i2c_write_reg(i2c_8bit_addr_from_msg(msgs), i2c_imx, IMX_I2C_I2DR);
 	result = i2c_imx_trx_complete(i2c_imx);
 	if (result)
 		return result;
@@ -796,10 +796,10 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs, bo
 
 	dev_dbg(&i2c_imx->adapter.dev,
 		"<%s> write slave address: addr=0x%x\n",
-		__func__, (msgs->addr << 1) | 0x01);
+		__func__, i2c_8bit_addr_from_msg(msgs));
 
 	/* write slave address */
-	imx_i2c_write_reg((msgs->addr << 1) | 0x01, i2c_imx, IMX_I2C_I2DR);
+	imx_i2c_write_reg(i2c_8bit_addr_from_msg(msgs), i2c_imx, IMX_I2C_I2DR);
 	result = i2c_imx_trx_complete(i2c_imx);
 	if (result)
 		return result;
diff --git a/drivers/i2c/busses/i2c-kempld.c b/drivers/i2c/busses/i2c-kempld.c
index e879190b5d1d..1c874aaa0447 100644
--- a/drivers/i2c/busses/i2c-kempld.c
+++ b/drivers/i2c/busses/i2c-kempld.c
@@ -124,15 +124,14 @@ static int kempld_i2c_process(struct kempld_i2c_data *i2c)
 		/* 10 bit address? */
 		if (i2c->msg->flags & I2C_M_TEN) {
 			addr = 0xf0 | ((i2c->msg->addr >> 7) & 0x6);
+			/* Set read bit if necessary */
+			addr |= (i2c->msg->flags & I2C_M_RD) ? 1 : 0;
 			i2c->state = STATE_ADDR10;
 		} else {
-			addr = (i2c->msg->addr << 1);
+			addr = i2c_8bit_addr_from_msg(i2c->msg);
 			i2c->state = STATE_START;
 		}
 
-		/* Set read bit if necessary */
-		addr |= (i2c->msg->flags & I2C_M_RD) ? 1 : 0;
-
 		kempld_write8(pld, KEMPLD_I2C_DATA, addr);
 		kempld_write8(pld, KEMPLD_I2C_CMD, I2C_CMD_START);
 
diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index e617bd600794..f62ae3d42232 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -180,9 +180,10 @@ static int mxs_i2c_dma_setup_xfer(struct i2c_adapter *adap,
 	struct dma_async_tx_descriptor *desc;
 	struct mxs_i2c_dev *i2c = i2c_get_adapdata(adap);
 
+	i2c->addr_data = i2c_8bit_addr_from_msg(msg);
+
 	if (msg->flags & I2C_M_RD) {
 		i2c->dma_read = true;
-		i2c->addr_data = (msg->addr << 1) | I2C_SMBUS_READ;
 
 		/*
 		 * SELECT command.
@@ -240,7 +241,6 @@ static int mxs_i2c_dma_setup_xfer(struct i2c_adapter *adap,
 		}
 	} else {
 		i2c->dma_read = false;
-		i2c->addr_data = (msg->addr << 1) | I2C_SMBUS_WRITE;
 
 		/*
 		 * WRITE command.
@@ -371,7 +371,7 @@ static int mxs_i2c_pio_setup_xfer(struct i2c_adapter *adap,
 			struct i2c_msg *msg, uint32_t flags)
 {
 	struct mxs_i2c_dev *i2c = i2c_get_adapdata(adap);
-	uint32_t addr_data = msg->addr << 1;
+	uint32_t addr_data = i2c_8bit_addr_from_msg(msg);
 	uint32_t data = 0;
 	int i, ret, xlen = 0, xmit = 0;
 	uint32_t start;
@@ -411,8 +411,6 @@ static int mxs_i2c_pio_setup_xfer(struct i2c_adapter *adap,
 		 */
 		BUG_ON(msg->len > 4);
 
-		addr_data |= I2C_SMBUS_READ;
-
 		/* SELECT command. */
 		mxs_i2c_pio_trigger_write_cmd(i2c, MXS_CMD_I2C_SELECT,
 					      addr_data);
@@ -450,7 +448,6 @@ static int mxs_i2c_pio_setup_xfer(struct i2c_adapter *adap,
 		 * fast enough. It is possible to transfer arbitrary amount
 		 * of data using PIO write.
 		 */
-		addr_data |= I2C_SMBUS_WRITE;
 
 		/*
 		 * The LSB of data buffer is the first byte blasted across
diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 8c42ca7107b2..a540916689b2 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -222,10 +222,7 @@ static int ocores_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 	i2c->nmsgs = num;
 	i2c->state = STATE_START;
 
-	oc_setreg(i2c, OCI2C_DATA,
-			(i2c->msg->addr << 1) |
-			((i2c->msg->flags & I2C_M_RD) ? 1:0));
-
+	oc_setreg(i2c, OCI2C_DATA, i2c_8bit_addr_from_msg(i2c->msg));
 	oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_START);
 
 	if (wait_event_timeout(i2c->wait, (i2c->state == STATE_ERROR) ||
diff --git a/drivers/i2c/busses/i2c-pasemi.c b/drivers/i2c/busses/i2c-pasemi.c
index df1dbc92a024..55fd5c6f3cca 100644
--- a/drivers/i2c/busses/i2c-pasemi.c
+++ b/drivers/i2c/busses/i2c-pasemi.c
@@ -121,7 +121,7 @@ static int pasemi_i2c_xfer_msg(struct i2c_adapter *adapter,
 
 	read = msg->flags & I2C_M_RD ? 1 : 0;
 
-	TXFIFO_WR(smbus, MTXFIFO_START | (msg->addr << 1) | read);
+	TXFIFO_WR(smbus, MTXFIFO_START | i2c_8bit_addr_from_msg(msg));
 
 	if (read) {
 		TXFIFO_WR(smbus, msg->len | MTXFIFO_READ |
diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index 904dfec7ab96..025232207aeb 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -453,7 +453,7 @@ static void qup_i2c_write_tx_fifo_v1(struct qup_i2c_dev *qup)
 {
 	struct qup_i2c_block *blk = &qup->blk;
 	struct i2c_msg *msg = qup->msg;
-	u32 addr = msg->addr << 1;
+	u32 addr = i2c_8bit_addr_from_msg(msg);
 	u32 qup_tag;
 	int idx;
 	u32 val;
diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index c6915b835396..17b91ddbe013 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -329,7 +329,7 @@ static void rcar_i2c_prepare_msg(struct rcar_i2c_priv *priv)
 	if (priv->msgs_left == 1)
 		priv->flags |= ID_LAST_MSG;
 
-	rcar_i2c_write(priv, ICMAR, (priv->msg->addr << 1) | read);
+	rcar_i2c_write(priv, ICMAR, i2c_8bit_addr_from_msg(priv->msg));
 	/*
 	 * We don't have a test case but the HW engineers say that the write order
 	 * of ICMSR and ICMCR depends on whether we issue START or REP_START. Since
diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index 95c2f1ce3cad..5f1fca7880b1 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -167,15 +167,14 @@ static irqreturn_t riic_tdre_isr(int irq, void *data)
 		return IRQ_NONE;
 
 	if (riic->bytes_left == RIIC_INIT_MSG) {
-		val = !!(riic->msg->flags & I2C_M_RD);
-		if (val)
+		if (riic->msg->flags & I2C_M_RD)
 			/* On read, switch over to receive interrupt */
 			riic_clear_set_bit(riic, ICIER_TIE, ICIER_RIE, RIIC_ICIER);
 		else
 			/* On write, initialize length */
 			riic->bytes_left = riic->msg->len;
 
-		val |= (riic->msg->addr << 1);
+		val = i2c_8bit_addr_from_msg(riic->msg);
 	} else {
 		val = *riic->buf;
 		riic->buf++;
diff --git a/drivers/i2c/busses/i2c-stu300.c b/drivers/i2c/busses/i2c-stu300.c
index dc63236b45b2..e866c481bfc3 100644
--- a/drivers/i2c/busses/i2c-stu300.c
+++ b/drivers/i2c/busses/i2c-stu300.c
@@ -602,20 +602,24 @@ static int stu300_send_address(struct stu300_dev *dev,
 	u32 val;
 	int ret;
 
-	if (msg->flags & I2C_M_TEN)
+	if (msg->flags & I2C_M_TEN) {
 		/* This is probably how 10 bit addresses look */
 		val = (0xf0 | (((u32) msg->addr & 0x300) >> 7)) &
 			I2C_DR_D_MASK;
-	else
-		val = ((msg->addr << 1) & I2C_DR_D_MASK);
+		if (msg->flags & I2C_M_RD)
+			/* This is the direction bit */
+			val |= 0x01;
+	} else {
+		val = i2c_8bit_addr_from_msg(msg);
+	}
 
-	if (msg->flags & I2C_M_RD) {
-		/* This is the direction bit */
-		val |= 0x01;
-		if (resend)
+	if (resend) {
+		if (msg->flags & I2C_M_RD)
 			dev_dbg(&dev->pdev->dev, "read resend\n");
-	} else if (resend)
-		dev_dbg(&dev->pdev->dev, "write resend\n");
+		else
+			dev_dbg(&dev->pdev->dev, "write resend\n");
+	}
+
 	stu300_wr8(val, dev->virtbase + I2C_DR);
 
 	/* For 10bit addressing, await 10bit request (EVENT 9) */
diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index c80527816ad0..1818c3b5c8d7 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -143,12 +143,6 @@ struct xiic_i2c {
 
 #define XIIC_TX_RX_INTERRUPTS (XIIC_INTR_RX_FULL_MASK | XIIC_TX_INTERRUPTS)
 
-/* The following constants are used with the following macros to specify the
- * operation, a read or write operation.
- */
-#define XIIC_READ_OPERATION  1
-#define XIIC_WRITE_OPERATION 0
-
 /*
  * Tx Fifo upper bit masks.
  */
@@ -556,8 +550,7 @@ static void xiic_start_recv(struct xiic_i2c *i2c)
 	if (!(msg->flags & I2C_M_NOSTART))
 		/* write the address */
 		xiic_setreg16(i2c, XIIC_DTR_REG_OFFSET,
-			(msg->addr << 1) | XIIC_READ_OPERATION |
-			XIIC_TX_DYN_START_MASK);
+			i2c_8bit_addr_from_msg(msg) | XIIC_TX_DYN_START_MASK);
 
 	xiic_irq_clr_en(i2c, XIIC_INTR_BNB_MASK);
 
@@ -585,7 +578,7 @@ static void xiic_start_send(struct xiic_i2c *i2c)
 
 	if (!(msg->flags & I2C_M_NOSTART)) {
 		/* write the address */
-		u16 data = ((msg->addr << 1) & 0xfe) | XIIC_WRITE_OPERATION |
+		u16 data = i2c_8bit_addr_from_msg(msg) |
 			XIIC_TX_DYN_START_MASK;
 		if ((i2c->nmsgs == 1) && msg->len == 0)
 			/* no data and last message -> add STOP */
-- 
2.11.0
