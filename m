Return-Path: <SRS0=vgOh=RJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A9AC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Mar 2019 11:24:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7568320661
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Mar 2019 11:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="Csbse4hB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7568320661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=essensium.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Dry74SRhzDqDP
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Mar 2019 22:24:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=essensium.com
 (client-ip=2a00:1450:4864:20::542; helo=mail-ed1-x542.google.com;
 envelope-from=patrick.havelange@essensium.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=essensium.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=essensium-com.20150623.gappssmtp.com
 header.i=@essensium-com.20150623.gappssmtp.com header.b="Csbse4hB"; 
 dkim-atps=neutral
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44DrhN1ytKzDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Mar 2019 22:12:36 +1100 (AEDT)
Received: by mail-ed1-x542.google.com with SMTP id 10so9990902eds.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Mar 2019 03:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=essensium-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yyoTm4Hf7hPGCM6SW9SVNk8GcYqCSFpUaAnswGpqQik=;
 b=Csbse4hB1J87+XDRKRaj17XpVhghuiKfLc/LqDe9og6h/3IeuvtFgaOh/5laHnPKLY
 LKV+hCvmbmjjp7fOVqw6Pw2XK45hT1k8Q3AK/e/CjXIWeZQl/dv2axzKOtQCJnr9iluw
 txmTrcC51r3HjQLqONqczH9eRQ/QuMqehyxOAOvM2HZ61IUacqYR98oFcXaMRMO0M+W5
 sx9rC3gn8wd3wuMlcYDfj5pcIeJqNN5t/xAe2Wr2Ugfn4FPFWOajXmWYH+AuQW6tJc8d
 EU9CRTnDOshU41Mae7PEUWguRBYOFVRanNi2N7jjxufHHlNvZfgjbUkjL0a868rw6G0V
 D3Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yyoTm4Hf7hPGCM6SW9SVNk8GcYqCSFpUaAnswGpqQik=;
 b=FMWM0F3e45BEosqHMi5a/wox6em1NaLyZK8jYZ0Na5+vk7hGrhaeNzg2XAZfATBrey
 SYffFynEG2flG577Dr3sqDUZR3A/wMo15T4vIlMCHrrLmofmgmYdT+HWiIDyKO0mQDVd
 m5sqqZodGa/416axO6ZiHxAECGPjzUfWqYfx+8tG1qZAAOn1KfAVbRC4GW16xdmaRfOc
 +IIPJwmnPtPXhZ/+1jeRdKeGuXVr3vl8SHJ27/ZnEAU8SqUq9irQJydcUVZiDDWsgV7C
 Ub2To6HQnlygLDTDfXDHFEUCiziL/MNNspRkSWYRQmeifJfnhE75c/k7GlSgg7aqa7C5
 bs3w==
X-Gm-Message-State: APjAAAV4Y+X+YPSwKMYAmie2yT/gDelWkrQec2PAv56i/AZXvKgZXI3D
 Xp1QGBoEEr/+3LihE+M4yl7eWg==
X-Google-Smtp-Source: APXvYqyKy8/8K6LTNKUlFi3ySmfhKFYCBTiNRNxqzwxGllF/4FWs4bWqM920kBHl7dV8+82Q6W/4rg==
X-Received: by 2002:a50:ea87:: with SMTP id d7mr23802042edo.21.1551870753607; 
 Wed, 06 Mar 2019 03:12:33 -0800 (PST)
Received: from ph-ThinkPad-E560.local.ess-mail.com
 (ip-188-118-3-185.reverse.destiny.be. [188.118.3.185])
 by smtp.gmail.com with ESMTPSA id t25sm277879ejr.30.2019.03.06.03.12.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 06 Mar 2019 03:12:33 -0800 (PST)
From: Patrick Havelange <patrick.havelange@essensium.com>
To: William Breathitt Gray <vilhelm.gray@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Thierry Reding <thierry.reding@gmail.com>,
 Esben Haabendal <esben@haabendal.dk>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v2 5/7] counter: add FlexTimer Module Quadrature decoder
 counter driver
Date: Wed,  6 Mar 2019 12:12:06 +0100
Message-Id: <20190306111208.7454-6-patrick.havelange@essensium.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190306111208.7454-1-patrick.havelange@essensium.com>
References: <20190306111208.7454-1-patrick.havelange@essensium.com>
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
Cc: Patrick Havelange <patrick.havelange@essensium.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This driver exposes the counter for the quadrature decoder of the
FlexTimer Module, present in the LS1021A soc.

Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
---
Changes v2
 - Rebased on new counter subsystem
 - Cleaned up included headers
 - Use devm_ioremap()
 - Correct order of devm_ and unmanaged resources
---
 drivers/counter/Kconfig       |   9 +
 drivers/counter/Makefile      |   1 +
 drivers/counter/ftm-quaddec.c | 356 ++++++++++++++++++++++++++++++++++
 3 files changed, 366 insertions(+)
 create mode 100644 drivers/counter/ftm-quaddec.c

diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
index 87c491a19c63..233ac305d878 100644
--- a/drivers/counter/Kconfig
+++ b/drivers/counter/Kconfig
@@ -48,4 +48,13 @@ config STM32_LPTIMER_CNT
 	  To compile this driver as a module, choose M here: the
 	  module will be called stm32-lptimer-cnt.
 
+config FTM_QUADDEC
+	tristate "Flex Timer Module Quadrature decoder driver"
+	help
+	  Select this option to enable the Flex Timer Quadrature decoder
+	  driver.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ftm-quaddec.
+
 endif # COUNTER
diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
index 5589976d37f8..0c9e622a6bea 100644
--- a/drivers/counter/Makefile
+++ b/drivers/counter/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_COUNTER) += counter.o
 obj-$(CONFIG_104_QUAD_8)	+= 104-quad-8.o
 obj-$(CONFIG_STM32_TIMER_CNT)	+= stm32-timer-cnt.o
 obj-$(CONFIG_STM32_LPTIMER_CNT)	+= stm32-lptimer-cnt.o
+obj-$(CONFIG_FTM_QUADDEC)	+= ftm-quaddec.o
diff --git a/drivers/counter/ftm-quaddec.c b/drivers/counter/ftm-quaddec.c
new file mode 100644
index 000000000000..1bc9e075a386
--- /dev/null
+++ b/drivers/counter/ftm-quaddec.c
@@ -0,0 +1,356 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Flex Timer Module Quadrature decoder
+ *
+ * This module implements a driver for decoding the FTM quadrature
+ * of ex. a LS1021A
+ */
+
+#include <linux/fsl/ftm.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/io.h>
+#include <linux/mutex.h>
+#include <linux/counter.h>
+
+struct ftm_quaddec {
+	struct counter_device counter;
+	struct platform_device *pdev;
+	void __iomem *ftm_base;
+	bool big_endian;
+	struct mutex ftm_quaddec_mutex;
+};
+
+static void ftm_read(struct ftm_quaddec *ftm, uint32_t offset, uint32_t *data)
+{
+	if (ftm->big_endian)
+		*data = ioread32be(ftm->ftm_base + offset);
+	else
+		*data = ioread32(ftm->ftm_base + offset);
+}
+
+static void ftm_write(struct ftm_quaddec *ftm, uint32_t offset, uint32_t data)
+{
+	if (ftm->big_endian)
+		iowrite32be(data, ftm->ftm_base + offset);
+	else
+		iowrite32(data, ftm->ftm_base + offset);
+}
+
+/*
+ * take mutex
+ * call ftm_clear_write_protection
+ * update settings
+ * call ftm_set_write_protection
+ * release mutex
+ */
+static void ftm_clear_write_protection(struct ftm_quaddec *ftm)
+{
+	uint32_t flag;
+
+	/* First see if it is enabled */
+	ftm_read(ftm, FTM_FMS, &flag);
+
+	if (flag & FTM_FMS_WPEN) {
+		ftm_read(ftm, FTM_MODE, &flag);
+		ftm_write(ftm, FTM_MODE, flag | FTM_MODE_WPDIS);
+	}
+}
+
+static void ftm_set_write_protection(struct ftm_quaddec *ftm)
+{
+	ftm_write(ftm, FTM_FMS, FTM_FMS_WPEN);
+}
+
+static void ftm_reset_counter(struct ftm_quaddec *ftm)
+{
+	/* Reset hardware counter to CNTIN */
+	ftm_write(ftm, FTM_CNT, 0x0);
+}
+
+static void ftm_quaddec_init(struct ftm_quaddec *ftm)
+{
+	ftm_clear_write_protection(ftm);
+
+	/*
+	 * Do not write in the region from the CNTIN register through the
+	 * PWMLOAD register when FTMEN = 0.
+	 */
+	ftm_write(ftm, FTM_MODE, FTM_MODE_FTMEN);
+	ftm_write(ftm, FTM_CNTIN, 0x0000);
+	ftm_write(ftm, FTM_MOD, 0xffff);
+	ftm_write(ftm, FTM_CNT, 0x0);
+	ftm_write(ftm, FTM_SC, FTM_SC_PS_1);
+
+	/* Select quad mode */
+	ftm_write(ftm, FTM_QDCTRL, FTM_QDCTRL_QUADEN);
+
+	/* Unused features and reset to default section */
+	ftm_write(ftm, FTM_POL, 0x0);
+	ftm_write(ftm, FTM_FLTCTRL, 0x0);
+	ftm_write(ftm, FTM_SYNCONF, 0x0);
+	ftm_write(ftm, FTM_SYNC, 0xffff);
+
+	/* Lock the FTM */
+	ftm_set_write_protection(ftm);
+}
+
+static void ftm_quaddec_disable(struct ftm_quaddec *ftm)
+{
+	ftm_write(ftm, FTM_MODE, 0);
+}
+
+static int ftm_quaddec_get_prescaler(struct counter_device *counter,
+				     struct counter_count *count,
+				     size_t *cnt_mode)
+{
+	struct ftm_quaddec *ftm = counter->priv;
+	uint32_t scflags;
+
+	ftm_read(ftm, FTM_SC, &scflags);
+
+	*cnt_mode = scflags & FTM_SC_PS_MASK;
+
+	return 0;
+}
+
+static int ftm_quaddec_set_prescaler(struct counter_device *counter,
+				     struct counter_count *count,
+				     size_t cnt_mode)
+{
+	struct ftm_quaddec *ftm = counter->priv;
+
+	uint32_t scflags;
+
+	mutex_lock(&ftm->ftm_quaddec_mutex);
+
+	ftm_read(ftm, FTM_SC, &scflags);
+
+	scflags &= ~FTM_SC_PS_MASK;
+	cnt_mode &= FTM_SC_PS_MASK; /*just to be 100% sure*/
+
+	scflags |= cnt_mode;
+
+	/* Write */
+	ftm_clear_write_protection(ftm);
+	ftm_write(ftm, FTM_SC, scflags);
+	ftm_set_write_protection(ftm);
+
+	/* Also resets the counter as it is undefined anyway now */
+	ftm_reset_counter(ftm);
+
+	mutex_unlock(&ftm->ftm_quaddec_mutex);
+	return 0;
+}
+
+static const char * const ftm_quaddec_prescaler[] = {
+	"1", "2", "4", "8", "16", "32", "64", "128"
+};
+
+static struct counter_count_enum_ext ftm_quaddec_prescaler_enum = {
+	.items = ftm_quaddec_prescaler,
+	.num_items = ARRAY_SIZE(ftm_quaddec_prescaler),
+	.get = ftm_quaddec_get_prescaler,
+	.set = ftm_quaddec_set_prescaler
+};
+
+enum ftm_quaddec_synapse_action {
+	FTM_QUADDEC_SYNAPSE_ACTION_BOTH_EDGES,
+};
+
+static enum counter_synapse_action ftm_quaddec_synapse_actions[] = {
+	[FTM_QUADDEC_SYNAPSE_ACTION_BOTH_EDGES] =
+	COUNTER_SYNAPSE_ACTION_BOTH_EDGES
+};
+
+enum ftm_quaddec_count_function {
+	FTM_QUADDEC_COUNT_ENCODER_MODE_1,
+};
+
+static const enum counter_count_function ftm_quaddec_count_functions[] = {
+	[FTM_QUADDEC_COUNT_ENCODER_MODE_1] =
+	COUNTER_COUNT_FUNCTION_QUADRATURE_X4
+};
+
+static int ftm_quaddec_count_read(struct counter_device *counter,
+				  struct counter_count *count,
+				  struct counter_count_read_value *val)
+{
+	struct ftm_quaddec *const ftm = counter->priv;
+	uint32_t cntval;
+
+	ftm_read(ftm, FTM_CNT, &cntval);
+
+	counter_count_read_value_set(val, COUNTER_COUNT_POSITION, &cntval);
+
+	return 0;
+}
+
+static int ftm_quaddec_count_write(struct counter_device *counter,
+				   struct counter_count *count,
+				   struct counter_count_write_value *val)
+{
+	struct ftm_quaddec *const ftm = counter->priv;
+	u32 cnt;
+	int err;
+
+	err = counter_count_write_value_get(&cnt, COUNTER_COUNT_POSITION, val);
+	if (err)
+		return err;
+
+	if (cnt != 0) {
+		dev_warn(&ftm->pdev->dev, "Can only accept '0' as new counter value\n");
+		return -EINVAL;
+	}
+
+	ftm_reset_counter(ftm);
+
+	return 0;
+}
+
+static int ftm_quaddec_count_function_get(struct counter_device *counter,
+					  struct counter_count *count,
+					  size_t *function)
+{
+	*function = FTM_QUADDEC_COUNT_ENCODER_MODE_1;
+
+	return 0;
+}
+
+static int ftm_quaddec_action_get(struct counter_device *counter,
+				  struct counter_count *count,
+				  struct counter_synapse *synapse,
+				  size_t *action)
+{
+	*action = FTM_QUADDEC_SYNAPSE_ACTION_BOTH_EDGES;
+
+	return 0;
+}
+
+static const struct counter_ops ftm_quaddec_cnt_ops = {
+	.count_read = ftm_quaddec_count_read,
+	.count_write = ftm_quaddec_count_write,
+	.function_get = ftm_quaddec_count_function_get,
+	.action_get = ftm_quaddec_action_get,
+};
+
+static struct counter_signal ftm_quaddec_signals[] = {
+	{
+		.id = 0,
+		.name = "Channel 1 Quadrature A"
+	},
+	{
+		.id = 1,
+		.name = "Channel 1 Quadrature B"
+	}
+};
+
+static struct counter_synapse ftm_quaddec_count_synapses[] = {
+	{
+		.actions_list = ftm_quaddec_synapse_actions,
+		.num_actions = ARRAY_SIZE(ftm_quaddec_synapse_actions),
+		.signal = &ftm_quaddec_signals[0]
+	},
+	{
+		.actions_list = ftm_quaddec_synapse_actions,
+		.num_actions = ARRAY_SIZE(ftm_quaddec_synapse_actions),
+		.signal = &ftm_quaddec_signals[1]
+	}
+};
+
+static const struct counter_count_ext ftm_quaddec_count_ext[] = {
+	COUNTER_COUNT_ENUM("prescaler", &ftm_quaddec_prescaler_enum),
+	COUNTER_COUNT_ENUM_AVAILABLE("prescaler", &ftm_quaddec_prescaler_enum),
+};
+
+static struct counter_count ftm_quaddec_counts = {
+	.id = 0,
+	.name = "Channel 1 Count",
+	.functions_list = ftm_quaddec_count_functions,
+	.num_functions = ARRAY_SIZE(ftm_quaddec_count_functions),
+	.synapses = ftm_quaddec_count_synapses,
+	.num_synapses = ARRAY_SIZE(ftm_quaddec_count_synapses),
+	.ext = ftm_quaddec_count_ext,
+	.num_ext = ARRAY_SIZE(ftm_quaddec_count_ext)
+};
+
+static int ftm_quaddec_probe(struct platform_device *pdev)
+{
+	struct ftm_quaddec *ftm;
+
+	struct device_node *node = pdev->dev.of_node;
+	struct resource *io;
+	int ret;
+
+	ftm = devm_kzalloc(&pdev->dev, sizeof(*ftm), GFP_KERNEL);
+	if (!ftm)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, ftm);
+
+	io = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!io) {
+		dev_err(&pdev->dev, "Failed to get memory region\n");
+		return -ENODEV;
+	}
+
+	ftm->pdev = pdev;
+	ftm->big_endian = of_property_read_bool(node, "big-endian");
+	ftm->ftm_base = devm_ioremap(&pdev->dev, io->start, resource_size(io));
+
+	if (!ftm->ftm_base) {
+		dev_err(&pdev->dev, "Failed to map memory region\n");
+		return -EINVAL;
+	}
+	ftm->counter.name = dev_name(&pdev->dev);
+	ftm->counter.parent = &pdev->dev;
+	ftm->counter.ops = &ftm_quaddec_cnt_ops;
+	ftm->counter.counts = &ftm_quaddec_counts;
+	ftm->counter.num_counts = 1;
+	ftm->counter.signals = ftm_quaddec_signals;
+	ftm->counter.num_signals = ARRAY_SIZE(ftm_quaddec_signals);
+	ftm->counter.priv = ftm;
+
+	mutex_init(&ftm->ftm_quaddec_mutex);
+
+	ftm_quaddec_init(ftm);
+
+	ret = counter_register(&ftm->counter);
+	if (ret)
+		ftm_quaddec_disable(ftm);
+
+	return ret;
+}
+
+static int ftm_quaddec_remove(struct platform_device *pdev)
+{
+	struct ftm_quaddec *ftm = platform_get_drvdata(pdev);
+
+	counter_unregister(&ftm->counter);
+
+	ftm_quaddec_disable(ftm);
+
+	return 0;
+}
+
+static const struct of_device_id ftm_quaddec_match[] = {
+	{ .compatible = "fsl,ftm-quaddec" },
+	{},
+};
+
+static struct platform_driver ftm_quaddec_driver = {
+	.driver = {
+		.name = "ftm-quaddec",
+		.owner = THIS_MODULE,
+		.of_match_table = ftm_quaddec_match,
+	},
+	.probe = ftm_quaddec_probe,
+	.remove = ftm_quaddec_remove,
+};
+
+module_platform_driver(ftm_quaddec_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Kjeld Flarup <kfa@deif.com");
+MODULE_AUTHOR("Patrick Havelange <patrick.havelange@essensium.com");
-- 
2.19.1

