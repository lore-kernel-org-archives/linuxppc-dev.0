Return-Path: <SRS0=xrHL=SE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD90DC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 06:42:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 216F720882
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 06:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJNJmMHl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 216F720882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44YKPh62XszDq9P
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 17:42:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=vilhelm.gray@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="bJNJmMHl"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44YK953m1szDqLW
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Apr 2019 17:31:05 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id r15so5814248pfn.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Apr 2019 23:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=65FoC5R5sHm7UC7zdR+nsyTyoYObd2MXSPZT6ix4JFU=;
 b=bJNJmMHlybVk8PPWSwxTi8BaIHZ2V6iVPioYmMdEfoHwd80x/OciT5/KhynQCoZEo4
 Qk3/gyRO2Jwvt/TLO7BtZPH0D6L9Ea2v9XRGsIUHVZhdbKTnVwLNYZKKX3DmZYPBpyMD
 +ppMdYVy9v8wfF9ko6u88ApzP9oStSYxV70oR4MvONa2ZwWz4L4/VwuyXS2XJOixHmco
 Yg8bfk0Gqpkjs+BFYEXEIPuXnljF41WhGm6ecvRrovnwodJscQcB7pKUpl3t7BbHSgda
 1lwlVYdVwFjWCwIpF3Ni6EHmiMsGRN1uxXjJ3EDTGLFjmTromNBju+wX6HXiDr1dY1PK
 VkCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=65FoC5R5sHm7UC7zdR+nsyTyoYObd2MXSPZT6ix4JFU=;
 b=ZIPnxwSkc4u3qAgljtN+foAhnyaRUqye1e61aotaWpmZ9vpgs4mZOeXQfAVSh8WtET
 qbNn/QJDWobbnDTsGYUFx7X4hAvQkq+UOojIpTs8xJ+zP1DgtuBJLtURFjqEA6Q2w+lF
 gSCnBRMD+XZ2Ic75AuTZkK3dhUpuhwxbiTOZbZwhBSQJgUox3i2bB12Bw72kFOIIuvKD
 4j1Wg8ak7TCwzVOu2j9KXjVZXrXzIJ/fKjVwbaEmKwi9djao5O7lyYtf86+yHg6fSyzY
 Qitg/3NBzlBtQBH+Dp1IFckQ34479eHIgVkVcC1wzkqLgkx/jPOmoFSgiOgSb7iUjh97
 ggNw==
X-Gm-Message-State: APjAAAV+67tm12kV5c0AIP5I2R/ZsyjTL+Gq/wtXMM1RZB29bFTpHRzb
 i8DRu+aQdw6arfldMi7+G3M=
X-Google-Smtp-Source: APXvYqxXmYSNKGV+f3v+Xk6Os5mofrniKjHKZHDB0PAMzQpnFtn+fhwwq5gwB8grCB9C1402juzY0g==
X-Received: by 2002:a63:5a4b:: with SMTP id k11mr64419744pgm.119.1554186662700; 
 Mon, 01 Apr 2019 23:31:02 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a5:4ce0:c70:4af9:86e2:2])
 by smtp.gmail.com with ESMTPSA id a17sm19327289pfj.123.2019.04.01.23.30.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Apr 2019 23:31:01 -0700 (PDT)
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH v10 05/18] counter: 104-quad-8: Add Generic Counter interface
 support
Date: Tue,  2 Apr 2019 15:30:40 +0900
Message-Id: <f00b50d3c30f6a653978c1eddaf330f7e4757805.1554184734.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1554184734.git.vilhelm.gray@gmail.com>
References: <cover.1554184734.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: mark.rutland@arm.com, benjamin.gaignard@st.com, linux-pwm@vger.kernel.org,
 linux-iio@vger.kernel.org, patrick.havelange@essensium.com,
 thierry.reding@gmail.com, pmeerw@pmeerw.net, lars@metafoo.de,
 daniel.lezcano@linaro.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, david@lechnology.com,
 William Breathitt Gray <vilhelm.gray@gmail.com>, robh+dt@kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, tglx@linutronix.de,
 fabrice.gasnier@st.com, esben@haabendal.dk, shawnguo@kernel.org,
 linux-kernel@vger.kernel.org, leoyang.li@nxp.com, knaack.h@gmx.de,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, jic23@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This patch adds support for the Generic Counter interface to the
104-QUAD-8 driver. The existing 104-QUAD-8 device interface should not
be affected by this patch; all changes are intended as supplemental
additions as perceived by the user.

Generic Counter Counts are created for the eight quadrature channel
counts, as well as their respective quadrature A and B Signals (which
are associated via respective Synapse structures) and respective index
Signals.

The new Generic Counter interface sysfs attributes are intended to
expose the same functionality and data available via the existing
104-QUAD-8 IIO device interface; the Generic Counter interface serves
to provide the respective functionality and data in a standard way
expected of counter devices.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 MAINTAINERS                            |   4 +-
 drivers/{iio => }/counter/104-quad-8.c | 772 ++++++++++++++++++++++++-
 drivers/counter/Kconfig                |  21 +
 drivers/counter/Makefile               |   2 +
 drivers/iio/counter/Kconfig            |  17 -
 drivers/iio/counter/Makefile           |   1 -
 6 files changed, 783 insertions(+), 34 deletions(-)
 rename drivers/{iio => }/counter/104-quad-8.c (44%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 208c92ff4801..663e7a62752a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -268,12 +268,12 @@ L:	linux-gpio@vger.kernel.org
 S:	Maintained
 F:	drivers/gpio/gpio-104-idio-16.c
 
-ACCES 104-QUAD-8 IIO DRIVER
+ACCES 104-QUAD-8 DRIVER
 M:	William Breathitt Gray <vilhelm.gray@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8
-F:	drivers/iio/counter/104-quad-8.c
+F:	drivers/counter/104-quad-8.c
 
 ACCES PCI-IDIO-16 GPIO DRIVER
 M:	William Breathitt Gray <vilhelm.gray@gmail.com>
diff --git a/drivers/iio/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
similarity index 44%
rename from drivers/iio/counter/104-quad-8.c
rename to drivers/counter/104-quad-8.c
index 72b6352e09f0..4fa2931dcb7b 100644
--- a/drivers/iio/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -1,11 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * IIO driver for the ACCES 104-QUAD-8
+ * Counter driver for the ACCES 104-QUAD-8
  * Copyright (C) 2016 William Breathitt Gray
  *
  * This driver supports the ACCES 104-QUAD-8 and ACCES 104-QUAD-4.
  */
 #include <linux/bitops.h>
+#include <linux/counter.h>
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/iio/iio.h>
@@ -29,6 +30,7 @@ MODULE_PARM_DESC(base, "ACCES 104-QUAD-8 base addresses");
 
 /**
  * struct quad8_iio - IIO device private data structure
+ * @counter:		instance of the counter_device
  * @preset:		array of preset values
  * @count_mode:		array of count mode configurations
  * @quadrature_mode:	array of quadrature mode configurations
@@ -40,6 +42,7 @@ MODULE_PARM_DESC(base, "ACCES 104-QUAD-8 base addresses");
  * @base:		base port address of the IIO device
  */
 struct quad8_iio {
+	struct counter_device counter;
 	unsigned int preset[QUAD8_NUM_COUNTERS];
 	unsigned int count_mode[QUAD8_NUM_COUNTERS];
 	unsigned int quadrature_mode[QUAD8_NUM_COUNTERS];
@@ -83,6 +86,10 @@ struct quad8_iio {
 #define QUAD8_RLD_CNTR_OUT 0x10
 #define QUAD8_CHAN_OP_ENABLE_COUNTERS 0x00
 #define QUAD8_CHAN_OP_RESET_COUNTERS 0x01
+#define QUAD8_CMR_QUADRATURE_X1 0x08
+#define QUAD8_CMR_QUADRATURE_X2 0x10
+#define QUAD8_CMR_QUADRATURE_X4 0x18
+
 
 static int quad8_read_raw(struct iio_dev *indio_dev,
 	struct iio_chan_spec const *chan, int *val, int *val2, long mask)
@@ -338,13 +345,13 @@ static const char *const quad8_count_modes[] = {
 };
 
 static int quad8_set_count_mode(struct iio_dev *indio_dev,
-	const struct iio_chan_spec *chan, unsigned int count_mode)
+	const struct iio_chan_spec *chan, unsigned int cnt_mode)
 {
 	struct quad8_iio *const priv = iio_priv(indio_dev);
-	unsigned int mode_cfg = count_mode << 1;
+	unsigned int mode_cfg = cnt_mode << 1;
 	const int base_offset = priv->base + 2 * chan->channel + 1;
 
-	priv->count_mode[chan->channel] = count_mode;
+	priv->count_mode[chan->channel] = cnt_mode;
 
 	/* Add quadrature mode configuration */
 	if (priv->quadrature_mode[chan->channel])
@@ -554,24 +561,746 @@ static const struct iio_chan_spec quad8_channels[] = {
 	QUAD8_COUNT_CHAN(7), QUAD8_INDEX_CHAN(7)
 };
 
+static int quad8_signal_read(struct counter_device *counter,
+	struct counter_signal *signal, struct counter_signal_read_value *val)
+{
+	const struct quad8_iio *const priv = counter->priv;
+	unsigned int state;
+	enum counter_signal_level level;
+
+	/* Only Index signal levels can be read */
+	if (signal->id < 16)
+		return -EINVAL;
+
+	state = inb(priv->base + QUAD8_REG_INDEX_INPUT_LEVELS)
+		& BIT(signal->id - 16);
+
+	level = (state) ? COUNTER_SIGNAL_LEVEL_HIGH : COUNTER_SIGNAL_LEVEL_LOW;
+
+	counter_signal_read_value_set(val, COUNTER_SIGNAL_LEVEL, &level);
+
+	return 0;
+}
+
+static int quad8_count_read(struct counter_device *counter,
+	struct counter_count *count, struct counter_count_read_value *val)
+{
+	const struct quad8_iio *const priv = counter->priv;
+	const int base_offset = priv->base + 2 * count->id;
+	unsigned int flags;
+	unsigned int borrow;
+	unsigned int carry;
+	unsigned long position;
+	int i;
+
+	flags = inb(base_offset + 1);
+	borrow = flags & QUAD8_FLAG_BT;
+	carry = !!(flags & QUAD8_FLAG_CT);
+
+	/* Borrow XOR Carry effectively doubles count range */
+	position = (unsigned long)(borrow ^ carry) << 24;
+
+	/* Reset Byte Pointer; transfer Counter to Output Latch */
+	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP | QUAD8_RLD_CNTR_OUT,
+	     base_offset + 1);
+
+	for (i = 0; i < 3; i++)
+		position |= (unsigned long)inb(base_offset) << (8 * i);
+
+	counter_count_read_value_set(val, COUNTER_COUNT_POSITION, &position);
+
+	return 0;
+}
+
+static int quad8_count_write(struct counter_device *counter,
+	struct counter_count *count, struct counter_count_write_value *val)
+{
+	const struct quad8_iio *const priv = counter->priv;
+	const int base_offset = priv->base + 2 * count->id;
+	int err;
+	unsigned long position;
+	int i;
+
+	err = counter_count_write_value_get(&position, COUNTER_COUNT_POSITION,
+					    val);
+	if (err)
+		return err;
+
+	/* Only 24-bit values are supported */
+	if (position > 0xFFFFFF)
+		return -EINVAL;
+
+	/* Reset Byte Pointer */
+	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP, base_offset + 1);
+
+	/* Counter can only be set via Preset Register */
+	for (i = 0; i < 3; i++)
+		outb(position >> (8 * i), base_offset);
+
+	/* Transfer Preset Register to Counter */
+	outb(QUAD8_CTR_RLD | QUAD8_RLD_PRESET_CNTR, base_offset + 1);
+
+	/* Reset Byte Pointer */
+	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP, base_offset + 1);
+
+	/* Set Preset Register back to original value */
+	position = priv->preset[count->id];
+	for (i = 0; i < 3; i++)
+		outb(position >> (8 * i), base_offset);
+
+	/* Reset Borrow, Carry, Compare, and Sign flags */
+	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_FLAGS, base_offset + 1);
+	/* Reset Error flag */
+	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_E, base_offset + 1);
+
+	return 0;
+}
+
+enum quad8_count_function {
+	QUAD8_COUNT_FUNCTION_PULSE_DIRECTION = 0,
+	QUAD8_COUNT_FUNCTION_QUADRATURE_X1,
+	QUAD8_COUNT_FUNCTION_QUADRATURE_X2,
+	QUAD8_COUNT_FUNCTION_QUADRATURE_X4
+};
+
+static enum counter_count_function quad8_count_functions_list[] = {
+	[QUAD8_COUNT_FUNCTION_PULSE_DIRECTION] = COUNTER_COUNT_FUNCTION_PULSE_DIRECTION,
+	[QUAD8_COUNT_FUNCTION_QUADRATURE_X1] = COUNTER_COUNT_FUNCTION_QUADRATURE_X1_A,
+	[QUAD8_COUNT_FUNCTION_QUADRATURE_X2] = COUNTER_COUNT_FUNCTION_QUADRATURE_X2_A,
+	[QUAD8_COUNT_FUNCTION_QUADRATURE_X4] = COUNTER_COUNT_FUNCTION_QUADRATURE_X4
+};
+
+static int quad8_function_get(struct counter_device *counter,
+	struct counter_count *count, size_t *function)
+{
+	const struct quad8_iio *const priv = counter->priv;
+	const int id = count->id;
+	const unsigned int quadrature_mode = priv->quadrature_mode[id];
+	const unsigned int scale = priv->quadrature_scale[id];
+
+	if (quadrature_mode)
+		switch (scale) {
+		case 0:
+			*function = QUAD8_COUNT_FUNCTION_QUADRATURE_X1;
+			break;
+		case 1:
+			*function = QUAD8_COUNT_FUNCTION_QUADRATURE_X2;
+			break;
+		case 2:
+			*function = QUAD8_COUNT_FUNCTION_QUADRATURE_X4;
+			break;
+		}
+	else
+		*function = QUAD8_COUNT_FUNCTION_PULSE_DIRECTION;
+
+	return 0;
+}
+
+static int quad8_function_set(struct counter_device *counter,
+	struct counter_count *count, size_t function)
+{
+	struct quad8_iio *const priv = counter->priv;
+	const int id = count->id;
+	unsigned int *const quadrature_mode = priv->quadrature_mode + id;
+	unsigned int *const scale = priv->quadrature_scale + id;
+	unsigned int mode_cfg = priv->count_mode[id] << 1;
+	unsigned int *const synchronous_mode = priv->synchronous_mode + id;
+	const unsigned int idr_cfg = priv->index_polarity[id] << 1;
+	const int base_offset = priv->base + 2 * id + 1;
+
+	if (function == QUAD8_COUNT_FUNCTION_PULSE_DIRECTION) {
+		*quadrature_mode = 0;
+
+		/* Quadrature scaling only available in quadrature mode */
+		*scale = 0;
+
+		/* Synchronous function not supported in non-quadrature mode */
+		if (*synchronous_mode) {
+			*synchronous_mode = 0;
+			/* Disable synchronous function mode */
+			outb(QUAD8_CTR_IDR | idr_cfg, base_offset);
+		}
+	} else {
+		*quadrature_mode = 1;
+
+		switch (function) {
+		case QUAD8_COUNT_FUNCTION_QUADRATURE_X1:
+			*scale = 0;
+			mode_cfg |= QUAD8_CMR_QUADRATURE_X1;
+			break;
+		case QUAD8_COUNT_FUNCTION_QUADRATURE_X2:
+			*scale = 1;
+			mode_cfg |= QUAD8_CMR_QUADRATURE_X2;
+			break;
+		case QUAD8_COUNT_FUNCTION_QUADRATURE_X4:
+			*scale = 2;
+			mode_cfg |= QUAD8_CMR_QUADRATURE_X4;
+			break;
+		}
+	}
+
+	/* Load mode configuration to Counter Mode Register */
+	outb(QUAD8_CTR_CMR | mode_cfg, base_offset);
+
+	return 0;
+}
+
+static void quad8_direction_get(struct counter_device *counter,
+	struct counter_count *count, enum counter_count_direction *direction)
+{
+	const struct quad8_iio *const priv = counter->priv;
+	unsigned int ud_flag;
+	const unsigned int flag_addr = priv->base + 2 * count->id + 1;
+
+	/* U/D flag: nonzero = up, zero = down */
+	ud_flag = inb(flag_addr) & QUAD8_FLAG_UD;
+
+	*direction = (ud_flag) ? COUNTER_COUNT_DIRECTION_FORWARD :
+		COUNTER_COUNT_DIRECTION_BACKWARD;
+}
+
+enum quad8_synapse_action {
+	QUAD8_SYNAPSE_ACTION_NONE = 0,
+	QUAD8_SYNAPSE_ACTION_RISING_EDGE,
+	QUAD8_SYNAPSE_ACTION_FALLING_EDGE,
+	QUAD8_SYNAPSE_ACTION_BOTH_EDGES
+};
+
+static enum counter_synapse_action quad8_index_actions_list[] = {
+	[QUAD8_SYNAPSE_ACTION_NONE] = COUNTER_SYNAPSE_ACTION_NONE,
+	[QUAD8_SYNAPSE_ACTION_RISING_EDGE] = COUNTER_SYNAPSE_ACTION_RISING_EDGE
+};
+
+static enum counter_synapse_action quad8_synapse_actions_list[] = {
+	[QUAD8_SYNAPSE_ACTION_NONE] = COUNTER_SYNAPSE_ACTION_NONE,
+	[QUAD8_SYNAPSE_ACTION_RISING_EDGE] = COUNTER_SYNAPSE_ACTION_RISING_EDGE,
+	[QUAD8_SYNAPSE_ACTION_FALLING_EDGE] = COUNTER_SYNAPSE_ACTION_FALLING_EDGE,
+	[QUAD8_SYNAPSE_ACTION_BOTH_EDGES] = COUNTER_SYNAPSE_ACTION_BOTH_EDGES
+};
+
+static int quad8_action_get(struct counter_device *counter,
+	struct counter_count *count, struct counter_synapse *synapse,
+	size_t *action)
+{
+	struct quad8_iio *const priv = counter->priv;
+	int err;
+	size_t function = 0;
+	const size_t signal_a_id = count->synapses[0].signal->id;
+	enum counter_count_direction direction;
+
+	/* Handle Index signals */
+	if (synapse->signal->id >= 16) {
+		if (priv->preset_enable[count->id])
+			*action = QUAD8_SYNAPSE_ACTION_RISING_EDGE;
+		else
+			*action = QUAD8_SYNAPSE_ACTION_NONE;
+
+		return 0;
+	}
+
+	err = quad8_function_get(counter, count, &function);
+	if (err)
+		return err;
+
+	/* Default action mode */
+	*action = QUAD8_SYNAPSE_ACTION_NONE;
+
+	/* Determine action mode based on current count function mode */
+	switch (function) {
+	case QUAD8_COUNT_FUNCTION_PULSE_DIRECTION:
+		if (synapse->signal->id == signal_a_id)
+			*action = QUAD8_SYNAPSE_ACTION_RISING_EDGE;
+		break;
+	case QUAD8_COUNT_FUNCTION_QUADRATURE_X1:
+		if (synapse->signal->id == signal_a_id) {
+			quad8_direction_get(counter, count, &direction);
+
+			if (direction == COUNTER_COUNT_DIRECTION_FORWARD)
+				*action = QUAD8_SYNAPSE_ACTION_RISING_EDGE;
+			else
+				*action = QUAD8_SYNAPSE_ACTION_FALLING_EDGE;
+		}
+		break;
+	case QUAD8_COUNT_FUNCTION_QUADRATURE_X2:
+		if (synapse->signal->id == signal_a_id)
+			*action = QUAD8_SYNAPSE_ACTION_BOTH_EDGES;
+		break;
+	case QUAD8_COUNT_FUNCTION_QUADRATURE_X4:
+		*action = QUAD8_SYNAPSE_ACTION_BOTH_EDGES;
+		break;
+	}
+
+	return 0;
+}
+
+const struct counter_ops quad8_ops = {
+	.signal_read = quad8_signal_read,
+	.count_read = quad8_count_read,
+	.count_write = quad8_count_write,
+	.function_get = quad8_function_get,
+	.function_set = quad8_function_set,
+	.action_get = quad8_action_get
+};
+
+static int quad8_index_polarity_get(struct counter_device *counter,
+	struct counter_signal *signal, size_t *index_polarity)
+{
+	const struct quad8_iio *const priv = counter->priv;
+	const size_t channel_id = signal->id - 16;
+
+	*index_polarity = priv->index_polarity[channel_id];
+
+	return 0;
+}
+
+static int quad8_index_polarity_set(struct counter_device *counter,
+	struct counter_signal *signal, size_t index_polarity)
+{
+	struct quad8_iio *const priv = counter->priv;
+	const size_t channel_id = signal->id - 16;
+	const unsigned int idr_cfg = priv->synchronous_mode[channel_id] |
+		index_polarity << 1;
+	const int base_offset = priv->base + 2 * channel_id + 1;
+
+	priv->index_polarity[channel_id] = index_polarity;
+
+	/* Load Index Control configuration to Index Control Register */
+	outb(QUAD8_CTR_IDR | idr_cfg, base_offset);
+
+	return 0;
+}
+
+static struct counter_signal_enum_ext quad8_index_pol_enum = {
+	.items = quad8_index_polarity_modes,
+	.num_items = ARRAY_SIZE(quad8_index_polarity_modes),
+	.get = quad8_index_polarity_get,
+	.set = quad8_index_polarity_set
+};
+
+static int quad8_synchronous_mode_get(struct counter_device *counter,
+	struct counter_signal *signal, size_t *synchronous_mode)
+{
+	const struct quad8_iio *const priv = counter->priv;
+	const size_t channel_id = signal->id - 16;
+
+	*synchronous_mode = priv->synchronous_mode[channel_id];
+
+	return 0;
+}
+
+static int quad8_synchronous_mode_set(struct counter_device *counter,
+	struct counter_signal *signal, size_t synchronous_mode)
+{
+	struct quad8_iio *const priv = counter->priv;
+	const size_t channel_id = signal->id - 16;
+	const unsigned int idr_cfg = synchronous_mode |
+		priv->index_polarity[channel_id] << 1;
+	const int base_offset = priv->base + 2 * channel_id + 1;
+
+	/* Index function must be non-synchronous in non-quadrature mode */
+	if (synchronous_mode && !priv->quadrature_mode[channel_id])
+		return -EINVAL;
+
+	priv->synchronous_mode[channel_id] = synchronous_mode;
+
+	/* Load Index Control configuration to Index Control Register */
+	outb(QUAD8_CTR_IDR | idr_cfg, base_offset);
+
+	return 0;
+}
+
+static struct counter_signal_enum_ext quad8_syn_mode_enum = {
+	.items = quad8_synchronous_modes,
+	.num_items = ARRAY_SIZE(quad8_synchronous_modes),
+	.get = quad8_synchronous_mode_get,
+	.set = quad8_synchronous_mode_set
+};
+
+static ssize_t quad8_count_floor_read(struct counter_device *counter,
+	struct counter_count *count, void *private, char *buf)
+{
+	/* Only a floor of 0 is supported */
+	return sprintf(buf, "0\n");
+}
+
+static int quad8_count_mode_get(struct counter_device *counter,
+	struct counter_count *count, size_t *cnt_mode)
+{
+	const struct quad8_iio *const priv = counter->priv;
+
+	/* Map 104-QUAD-8 count mode to Generic Counter count mode */
+	switch (priv->count_mode[count->id]) {
+	case 0:
+		*cnt_mode = COUNTER_COUNT_MODE_NORMAL;
+		break;
+	case 1:
+		*cnt_mode = COUNTER_COUNT_MODE_RANGE_LIMIT;
+		break;
+	case 2:
+		*cnt_mode = COUNTER_COUNT_MODE_NON_RECYCLE;
+		break;
+	case 3:
+		*cnt_mode = COUNTER_COUNT_MODE_MODULO_N;
+		break;
+	}
+
+	return 0;
+}
+
+static int quad8_count_mode_set(struct counter_device *counter,
+	struct counter_count *count, size_t cnt_mode)
+{
+	struct quad8_iio *const priv = counter->priv;
+	unsigned int mode_cfg;
+	const int base_offset = priv->base + 2 * count->id + 1;
+
+	/* Map Generic Counter count mode to 104-QUAD-8 count mode */
+	switch (cnt_mode) {
+	case COUNTER_COUNT_MODE_NORMAL:
+		cnt_mode = 0;
+		break;
+	case COUNTER_COUNT_MODE_RANGE_LIMIT:
+		cnt_mode = 1;
+		break;
+	case COUNTER_COUNT_MODE_NON_RECYCLE:
+		cnt_mode = 2;
+		break;
+	case COUNTER_COUNT_MODE_MODULO_N:
+		cnt_mode = 3;
+		break;
+	}
+
+	priv->count_mode[count->id] = cnt_mode;
+
+	/* Set count mode configuration value */
+	mode_cfg = cnt_mode << 1;
+
+	/* Add quadrature mode configuration */
+	if (priv->quadrature_mode[count->id])
+		mode_cfg |= (priv->quadrature_scale[count->id] + 1) << 3;
+
+	/* Load mode configuration to Counter Mode Register */
+	outb(QUAD8_CTR_CMR | mode_cfg, base_offset);
+
+	return 0;
+}
+
+static struct counter_count_enum_ext quad8_cnt_mode_enum = {
+	.items = counter_count_mode_str,
+	.num_items = ARRAY_SIZE(counter_count_mode_str),
+	.get = quad8_count_mode_get,
+	.set = quad8_count_mode_set
+};
+
+static ssize_t quad8_count_direction_read(struct counter_device *counter,
+	struct counter_count *count, void *priv, char *buf)
+{
+	enum counter_count_direction dir;
+
+	quad8_direction_get(counter, count, &dir);
+
+	return sprintf(buf, "%s\n", counter_count_direction_str[dir]);
+}
+
+static ssize_t quad8_count_enable_read(struct counter_device *counter,
+	struct counter_count *count, void *private, char *buf)
+{
+	const struct quad8_iio *const priv = counter->priv;
+
+	return sprintf(buf, "%u\n", priv->ab_enable[count->id]);
+}
+
+static ssize_t quad8_count_enable_write(struct counter_device *counter,
+	struct counter_count *count, void *private, const char *buf, size_t len)
+{
+	struct quad8_iio *const priv = counter->priv;
+	const int base_offset = priv->base + 2 * count->id;
+	int err;
+	bool ab_enable;
+	unsigned int ior_cfg;
+
+	err = kstrtobool(buf, &ab_enable);
+	if (err)
+		return err;
+
+	priv->ab_enable[count->id] = ab_enable;
+
+	ior_cfg = ab_enable | priv->preset_enable[count->id] << 1;
+
+	/* Load I/O control configuration */
+	outb(QUAD8_CTR_IOR | ior_cfg, base_offset + 1);
+
+	return len;
+}
+
+static int quad8_error_noise_get(struct counter_device *counter,
+	struct counter_count *count, size_t *noise_error)
+{
+	const struct quad8_iio *const priv = counter->priv;
+	const int base_offset = priv->base + 2 * count->id + 1;
+
+	*noise_error = !!(inb(base_offset) & QUAD8_FLAG_E);
+
+	return 0;
+}
+
+static struct counter_count_enum_ext quad8_error_noise_enum = {
+	.items = quad8_noise_error_states,
+	.num_items = ARRAY_SIZE(quad8_noise_error_states),
+	.get = quad8_error_noise_get
+};
+
+static ssize_t quad8_count_preset_read(struct counter_device *counter,
+	struct counter_count *count, void *private, char *buf)
+{
+	const struct quad8_iio *const priv = counter->priv;
+
+	return sprintf(buf, "%u\n", priv->preset[count->id]);
+}
+
+static ssize_t quad8_count_preset_write(struct counter_device *counter,
+	struct counter_count *count, void *private, const char *buf, size_t len)
+{
+	struct quad8_iio *const priv = counter->priv;
+	const int base_offset = priv->base + 2 * count->id;
+	unsigned int preset;
+	int ret;
+	int i;
+
+	ret = kstrtouint(buf, 0, &preset);
+	if (ret)
+		return ret;
+
+	/* Only 24-bit values are supported */
+	if (preset > 0xFFFFFF)
+		return -EINVAL;
+
+	priv->preset[count->id] = preset;
+
+	/* Reset Byte Pointer */
+	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP, base_offset + 1);
+
+	/* Set Preset Register */
+	for (i = 0; i < 3; i++)
+		outb(preset >> (8 * i), base_offset);
+
+	return len;
+}
+
+static ssize_t quad8_count_ceiling_read(struct counter_device *counter,
+	struct counter_count *count, void *private, char *buf)
+{
+	const struct quad8_iio *const priv = counter->priv;
+
+	/* Range Limit and Modulo-N count modes use preset value as ceiling */
+	switch (priv->count_mode[count->id]) {
+	case 1:
+	case 3:
+		return quad8_count_preset_read(counter, count, private, buf);
+	}
+
+	/* By default 0x1FFFFFF (25 bits unsigned) is maximum count */
+	return sprintf(buf, "33554431\n");
+}
+
+static ssize_t quad8_count_ceiling_write(struct counter_device *counter,
+	struct counter_count *count, void *private, const char *buf, size_t len)
+{
+	struct quad8_iio *const priv = counter->priv;
+
+	/* Range Limit and Modulo-N count modes use preset value as ceiling */
+	switch (priv->count_mode[count->id]) {
+	case 1:
+	case 3:
+		return quad8_count_preset_write(counter, count, private, buf,
+						len);
+	}
+
+	return len;
+}
+
+static ssize_t quad8_count_preset_enable_read(struct counter_device *counter,
+	struct counter_count *count, void *private, char *buf)
+{
+	const struct quad8_iio *const priv = counter->priv;
+
+	return sprintf(buf, "%u\n", !priv->preset_enable[count->id]);
+}
+
+static ssize_t quad8_count_preset_enable_write(struct counter_device *counter,
+	struct counter_count *count, void *private, const char *buf, size_t len)
+{
+	struct quad8_iio *const priv = counter->priv;
+	const int base_offset = priv->base + 2 * count->id + 1;
+	bool preset_enable;
+	int ret;
+	unsigned int ior_cfg;
+
+	ret = kstrtobool(buf, &preset_enable);
+	if (ret)
+		return ret;
+
+	/* Preset enable is active low in Input/Output Control register */
+	preset_enable = !preset_enable;
+
+	priv->preset_enable[count->id] = preset_enable;
+
+	ior_cfg = priv->ab_enable[count->id] | (unsigned int)preset_enable << 1;
+
+	/* Load I/O control configuration to Input / Output Control Register */
+	outb(QUAD8_CTR_IOR | ior_cfg, base_offset);
+
+	return len;
+}
+
+static const struct counter_signal_ext quad8_index_ext[] = {
+	COUNTER_SIGNAL_ENUM("index_polarity", &quad8_index_pol_enum),
+	COUNTER_SIGNAL_ENUM_AVAILABLE("index_polarity",	&quad8_index_pol_enum),
+	COUNTER_SIGNAL_ENUM("synchronous_mode", &quad8_syn_mode_enum),
+	COUNTER_SIGNAL_ENUM_AVAILABLE("synchronous_mode", &quad8_syn_mode_enum)
+};
+
+#define	QUAD8_QUAD_SIGNAL(_id, _name) {	\
+	.id = (_id),			\
+	.name = (_name)			\
+}
+
+#define	QUAD8_INDEX_SIGNAL(_id, _name) {	\
+	.id = (_id),				\
+	.name = (_name),			\
+	.ext = quad8_index_ext,			\
+	.num_ext = ARRAY_SIZE(quad8_index_ext)	\
+}
+
+static struct counter_signal quad8_signals[] = {
+	QUAD8_QUAD_SIGNAL(0, "Channel 1 Quadrature A"),
+	QUAD8_QUAD_SIGNAL(1, "Channel 1 Quadrature B"),
+	QUAD8_QUAD_SIGNAL(2, "Channel 2 Quadrature A"),
+	QUAD8_QUAD_SIGNAL(3, "Channel 2 Quadrature B"),
+	QUAD8_QUAD_SIGNAL(4, "Channel 3 Quadrature A"),
+	QUAD8_QUAD_SIGNAL(5, "Channel 3 Quadrature B"),
+	QUAD8_QUAD_SIGNAL(6, "Channel 4 Quadrature A"),
+	QUAD8_QUAD_SIGNAL(7, "Channel 4 Quadrature B"),
+	QUAD8_QUAD_SIGNAL(8, "Channel 5 Quadrature A"),
+	QUAD8_QUAD_SIGNAL(9, "Channel 5 Quadrature B"),
+	QUAD8_QUAD_SIGNAL(10, "Channel 6 Quadrature A"),
+	QUAD8_QUAD_SIGNAL(11, "Channel 6 Quadrature B"),
+	QUAD8_QUAD_SIGNAL(12, "Channel 7 Quadrature A"),
+	QUAD8_QUAD_SIGNAL(13, "Channel 7 Quadrature B"),
+	QUAD8_QUAD_SIGNAL(14, "Channel 8 Quadrature A"),
+	QUAD8_QUAD_SIGNAL(15, "Channel 8 Quadrature B"),
+	QUAD8_INDEX_SIGNAL(16, "Channel 1 Index"),
+	QUAD8_INDEX_SIGNAL(17, "Channel 2 Index"),
+	QUAD8_INDEX_SIGNAL(18, "Channel 3 Index"),
+	QUAD8_INDEX_SIGNAL(19, "Channel 4 Index"),
+	QUAD8_INDEX_SIGNAL(20, "Channel 5 Index"),
+	QUAD8_INDEX_SIGNAL(21, "Channel 6 Index"),
+	QUAD8_INDEX_SIGNAL(22, "Channel 7 Index"),
+	QUAD8_INDEX_SIGNAL(23, "Channel 8 Index")
+};
+
+#define QUAD8_COUNT_SYNAPSES(_id) {					\
+	{								\
+		.actions_list = quad8_synapse_actions_list,		\
+		.num_actions = ARRAY_SIZE(quad8_synapse_actions_list),	\
+		.signal = quad8_signals + 2 * (_id)			\
+	},								\
+	{								\
+		.actions_list = quad8_synapse_actions_list,		\
+		.num_actions = ARRAY_SIZE(quad8_synapse_actions_list),	\
+		.signal = quad8_signals + 2 * (_id) + 1			\
+	},								\
+	{								\
+		.actions_list = quad8_index_actions_list,		\
+		.num_actions = ARRAY_SIZE(quad8_index_actions_list),	\
+		.signal = quad8_signals + 2 * (_id) + 16		\
+	}								\
+}
+
+static struct counter_synapse quad8_count_synapses[][3] = {
+	QUAD8_COUNT_SYNAPSES(0), QUAD8_COUNT_SYNAPSES(1),
+	QUAD8_COUNT_SYNAPSES(2), QUAD8_COUNT_SYNAPSES(3),
+	QUAD8_COUNT_SYNAPSES(4), QUAD8_COUNT_SYNAPSES(5),
+	QUAD8_COUNT_SYNAPSES(6), QUAD8_COUNT_SYNAPSES(7)
+};
+
+static const struct counter_count_ext quad8_count_ext[] = {
+	{
+		.name = "ceiling",
+		.read = quad8_count_ceiling_read,
+		.write = quad8_count_ceiling_write
+	},
+	{
+		.name = "floor",
+		.read = quad8_count_floor_read
+	},
+	COUNTER_COUNT_ENUM("count_mode", &quad8_cnt_mode_enum),
+	COUNTER_COUNT_ENUM_AVAILABLE("count_mode", &quad8_cnt_mode_enum),
+	{
+		.name = "direction",
+		.read = quad8_count_direction_read
+	},
+	{
+		.name = "enable",
+		.read = quad8_count_enable_read,
+		.write = quad8_count_enable_write
+	},
+	COUNTER_COUNT_ENUM("error_noise", &quad8_error_noise_enum),
+	COUNTER_COUNT_ENUM_AVAILABLE("error_noise", &quad8_error_noise_enum),
+	{
+		.name = "preset",
+		.read = quad8_count_preset_read,
+		.write = quad8_count_preset_write
+	},
+	{
+		.name = "preset_enable",
+		.read = quad8_count_preset_enable_read,
+		.write = quad8_count_preset_enable_write
+	}
+};
+
+#define QUAD8_COUNT(_id, _cntname) {					\
+	.id = (_id),							\
+	.name = (_cntname),						\
+	.functions_list = quad8_count_functions_list,			\
+	.num_functions = ARRAY_SIZE(quad8_count_functions_list),	\
+	.synapses = quad8_count_synapses[(_id)],			\
+	.num_synapses =	2,						\
+	.ext = quad8_count_ext,						\
+	.num_ext = ARRAY_SIZE(quad8_count_ext)				\
+}
+
+static struct counter_count quad8_counts[] = {
+	QUAD8_COUNT(0, "Channel 1 Count"),
+	QUAD8_COUNT(1, "Channel 2 Count"),
+	QUAD8_COUNT(2, "Channel 3 Count"),
+	QUAD8_COUNT(3, "Channel 4 Count"),
+	QUAD8_COUNT(4, "Channel 5 Count"),
+	QUAD8_COUNT(5, "Channel 6 Count"),
+	QUAD8_COUNT(6, "Channel 7 Count"),
+	QUAD8_COUNT(7, "Channel 8 Count")
+};
+
 static int quad8_probe(struct device *dev, unsigned int id)
 {
 	struct iio_dev *indio_dev;
-	struct quad8_iio *priv;
+	struct quad8_iio *quad8iio;
 	int i, j;
 	unsigned int base_offset;
+	int err;
 
-	indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
-	if (!indio_dev)
-		return -ENOMEM;
-
-	if (!devm_request_region(dev, base[id], QUAD8_EXTENT,
-		dev_name(dev))) {
+	if (!devm_request_region(dev, base[id], QUAD8_EXTENT, dev_name(dev))) {
 		dev_err(dev, "Unable to lock port addresses (0x%X-0x%X)\n",
 			base[id], base[id] + QUAD8_EXTENT);
 		return -EBUSY;
 	}
 
+	/* Allocate IIO device; this also allocates driver data structure */
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*quad8iio));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	/* Initialize IIO device */
 	indio_dev->info = &quad8_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->num_channels = ARRAY_SIZE(quad8_channels);
@@ -579,8 +1308,17 @@ static int quad8_probe(struct device *dev, unsigned int id)
 	indio_dev->name = dev_name(dev);
 	indio_dev->dev.parent = dev;
 
-	priv = iio_priv(indio_dev);
-	priv->base = base[id];
+	/* Initialize Counter device and driver data */
+	quad8iio = iio_priv(indio_dev);
+	quad8iio->counter.name = dev_name(dev);
+	quad8iio->counter.parent = dev;
+	quad8iio->counter.ops = &quad8_ops;
+	quad8iio->counter.counts = quad8_counts;
+	quad8iio->counter.num_counts = ARRAY_SIZE(quad8_counts);
+	quad8iio->counter.signals = quad8_signals;
+	quad8iio->counter.num_signals = ARRAY_SIZE(quad8_signals);
+	quad8iio->counter.priv = quad8iio;
+	quad8iio->base = base[id];
 
 	/* Reset all counters and disable interrupt function */
 	outb(QUAD8_CHAN_OP_RESET_COUNTERS, base[id] + QUAD8_REG_CHAN_OP);
@@ -606,7 +1344,13 @@ static int quad8_probe(struct device *dev, unsigned int id)
 	/* Enable all counters */
 	outb(QUAD8_CHAN_OP_ENABLE_COUNTERS, base[id] + QUAD8_REG_CHAN_OP);
 
-	return devm_iio_device_register(dev, indio_dev);
+	/* Register IIO device */
+	err = devm_iio_device_register(dev, indio_dev);
+	if (err)
+		return err;
+
+	/* Register Counter device */
+	return devm_counter_register(dev, &quad8iio->counter);
 }
 
 static struct isa_driver quad8_driver = {
diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
index a74998400282..dd3add729529 100644
--- a/drivers/counter/Kconfig
+++ b/drivers/counter/Kconfig
@@ -8,3 +8,24 @@ menuconfig COUNTER
 	  This enables counter device support through the Generic Counter
 	  interface. You only need to enable this, if you also want to enable
 	  one or more of the counter device drivers below.
+
+if COUNTER
+
+config 104_QUAD_8
+	tristate "ACCES 104-QUAD-8 driver"
+	depends on PC104 && X86 && IIO
+	select ISA_BUS_API
+	help
+	  Say yes here to build support for the ACCES 104-QUAD-8 quadrature
+	  encoder counter/interface device family (104-QUAD-8, 104-QUAD-4).
+
+	  A counter's respective error flag may be cleared by performing a write
+	  operation on the respective count value attribute. Although the
+	  104-QUAD-8 counters have a 25-bit range, only the lower 24 bits may be
+	  set, either directly or via the counter's preset attribute. Interrupts
+	  are not supported by this driver.
+
+	  The base port addresses for the devices may be configured via the base
+	  array module parameter.
+
+endif # COUNTER
diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
index b1464604bdbe..aee0d2ddcf2c 100644
--- a/drivers/counter/Makefile
+++ b/drivers/counter/Makefile
@@ -3,3 +3,5 @@
 #
 
 obj-$(CONFIG_COUNTER) += counter.o
+
+obj-$(CONFIG_104_QUAD_8)	+= 104-quad-8.o
diff --git a/drivers/iio/counter/Kconfig b/drivers/iio/counter/Kconfig
index bf1e559ad7cd..eeb358122cbe 100644
--- a/drivers/iio/counter/Kconfig
+++ b/drivers/iio/counter/Kconfig
@@ -5,23 +5,6 @@
 
 menu "Counters"
 
-config 104_QUAD_8
-	tristate "ACCES 104-QUAD-8 driver"
-	depends on PC104 && X86
-	select ISA_BUS_API
-	help
-	  Say yes here to build support for the ACCES 104-QUAD-8 quadrature
-	  encoder counter/interface device family (104-QUAD-8, 104-QUAD-4).
-
-	  Performing a write to a counter's IIO_CHAN_INFO_RAW sets the counter and
-	  also clears the counter's respective error flag. Although the counters
-	  have a 25-bit range, only the lower 24 bits may be set, either directly
-	  or via a counter's preset attribute. Interrupts are not supported by
-	  this driver.
-
-	  The base port addresses for the devices may be configured via the base
-	  array module parameter.
-
 config STM32_LPTIMER_CNT
 	tristate "STM32 LP Timer encoder counter driver"
 	depends on MFD_STM32_LPTIMER || COMPILE_TEST
diff --git a/drivers/iio/counter/Makefile b/drivers/iio/counter/Makefile
index 1b9a896eb488..93933ba49280 100644
--- a/drivers/iio/counter/Makefile
+++ b/drivers/iio/counter/Makefile
@@ -4,5 +4,4 @@
 
 # When adding new entries keep the list in alphabetical order
 
-obj-$(CONFIG_104_QUAD_8)	+= 104-quad-8.o
 obj-$(CONFIG_STM32_LPTIMER_CNT)	+= stm32-lptimer-cnt.o
-- 
2.21.0

