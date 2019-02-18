Return-Path: <SRS0=Hg4A=QZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F61C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 22:24:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AEB62176F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 22:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="1EEQllAK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AEB62176F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=essensium.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 443JLj3x50zDqJk
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 09:24:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=essensium.com
 (client-ip=2a00:1450:4864:20::544; helo=mail-ed1-x544.google.com;
 envelope-from=patrick.havelange@essensium.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=essensium.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=essensium-com.20150623.gappssmtp.com
 header.i=@essensium-com.20150623.gappssmtp.com header.b="1EEQllAK"; 
 dkim-atps=neutral
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com
 [IPv6:2a00:1450:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4435FR58NJzDqHp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2019 01:03:55 +1100 (AEDT)
Received: by mail-ed1-x544.google.com with SMTP id g19so4930403edp.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2019 06:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=essensium-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=y8ELJQgbv7DeZTb+dT/figIxEA2QKkZyGqslXLAy5pw=;
 b=1EEQllAKYnQmKGyF7FtBV8s+Yo0LgZ+xETEnQoTbs89uCfBgFIQ0qHbAaUYBZBPsKS
 fwFn/5j6UMtojlsPU7N8YLaHy18t/D6CuMvAXYNDRIUtQk/eCiX9LSKmj6GwJCC3WR8l
 mchRPF0/tfIt1ap/CB6BXikspkpVKxs3SSEdLUlDWBBPnYeez50q7QhiUYLNud3XA+Le
 LByS6/3fi9R3gdcpvfOaFHw0k5Ivdg7qqhSklk5ULNmLTmb/AgDfU2BqomRkWEATbXc/
 M15uee4hiqq4EopIi4zU3U84DDY781Duvz2ek9XRndzF0Rj6m6jcRRQcLG84cdIaKg84
 w1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=y8ELJQgbv7DeZTb+dT/figIxEA2QKkZyGqslXLAy5pw=;
 b=OdgSf27Y0iZix0Y3NMS6Bk4rRPkDUN0+EevxBN8p7MaDxxcT7wP+0/BaLgkcAC49Dc
 izeTHo41FZgwOH2rhqH7Dm1/HMrad8U21zjSz9qV2d6dTPcQco5uX8PNGQeu1RCWp8cs
 bAY19A/irtGeGRYlEIJ3WIXZhGM/BSsscb23PmsJLnELq81CTDrb5lt20X8VAU8lRXq1
 lffccDWEJie+tgEFQMjgwHVrW6KD4o4X+O8vWCvIQcPB50wGsEswOSL0x2XYg+ODmhUA
 CuMo6OLZ2a8RX+DeADz73pqOjpEis7TUCst+LU8VHjkqLrOOYVfL8PvgyhKwHA4R4qhZ
 r3+A==
X-Gm-Message-State: AHQUAuanusbl9c9Q3AUjjOhE8lzRTKKvjRBXwCAfvUBKxsRsU6ApLPOw
 SlqwMTuX0OCyUAmjhE/VTMYJJg==
X-Google-Smtp-Source: AHgI3IYrC+euDCA6+19B7LQzEHnG2fbshumRDoikpwE8u2sTiM5Yfqae37ry7AmGJn2cYvKCWgnr7w==
X-Received: by 2002:a50:94d6:: with SMTP id t22mr19337308eda.232.1550498632701; 
 Mon, 18 Feb 2019 06:03:52 -0800 (PST)
Received: from localhost.localdomain (ip-188-118-3-185.reverse.destiny.be.
 [188.118.3.185])
 by smtp.gmail.com with ESMTPSA id w48sm1421606eda.88.2019.02.18.06.03.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 18 Feb 2019 06:03:52 -0800 (PST)
From: Patrick Havelange <patrick.havelange@essensium.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Thierry Reding <thierry.reding@gmail.com>,
 Esben Haabendal <esben@haabendal.dk>,
 William Breathitt Gray <vilhelm.gray@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 5/8] iio/counter: add FlexTimer Module Quadrature decoder
 counter driver
Date: Mon, 18 Feb 2019 15:03:18 +0100
Message-Id: <20190218140321.19166-5-patrick.havelange@essensium.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190218140321.19166-1-patrick.havelange@essensium.com>
References: <20190218140321.19166-1-patrick.havelange@essensium.com>
X-Mailman-Approved-At: Tue, 19 Feb 2019 09:22:41 +1100
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
Reviewed-by: Esben Haabendal <esben@haabendal.dk>
---
 drivers/iio/counter/Kconfig       |  10 +
 drivers/iio/counter/Makefile      |   1 +
 drivers/iio/counter/ftm-quaddec.c | 294 ++++++++++++++++++++++++++++++
 3 files changed, 305 insertions(+)
 create mode 100644 drivers/iio/counter/ftm-quaddec.c

diff --git a/drivers/iio/counter/Kconfig b/drivers/iio/counter/Kconfig
index bf1e559ad7cd..4641cb2e752a 100644
--- a/drivers/iio/counter/Kconfig
+++ b/drivers/iio/counter/Kconfig
@@ -31,4 +31,14 @@ config STM32_LPTIMER_CNT
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called stm32-lptimer-cnt.
+
+config FTM_QUADDEC
+	tristate "Flex Timer Module Quadrature decoder driver"
+	help
+	  Select this option to enable the Flex Timer Quadrature decoder
+	  driver.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ftm-quaddec.
+
 endmenu
diff --git a/drivers/iio/counter/Makefile b/drivers/iio/counter/Makefile
index 1b9a896eb488..757c1f4196af 100644
--- a/drivers/iio/counter/Makefile
+++ b/drivers/iio/counter/Makefile
@@ -6,3 +6,4 @@
 
 obj-$(CONFIG_104_QUAD_8)	+= 104-quad-8.o
 obj-$(CONFIG_STM32_LPTIMER_CNT)	+= stm32-lptimer-cnt.o
+obj-$(CONFIG_FTM_QUADDEC)	+= ftm-quaddec.o
diff --git a/drivers/iio/counter/ftm-quaddec.c b/drivers/iio/counter/ftm-quaddec.c
new file mode 100644
index 000000000000..ca7e55a9ab3f
--- /dev/null
+++ b/drivers/iio/counter/ftm-quaddec.c
@@ -0,0 +1,294 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Flex Timer Module Quadrature decoder
+ *
+ * This module implements a driver for decoding the FTM quadrature
+ * of ex. a LS1021A
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/workqueue.h>
+#include <linux/swait.h>
+#include <linux/sched.h>
+#include <linux/delay.h>
+#include <linux/iio/iio.h>
+#include <linux/mutex.h>
+#include <linux/fsl/ftm.h>
+
+struct ftm_quaddec {
+	struct platform_device *pdev;
+	void __iomem *ftm_base;
+	bool big_endian;
+	struct mutex ftm_quaddec_mutex;
+};
+
+#define HASFLAGS(flag, bits) ((flag & bits) ? 1 : 0)
+
+#define DEFAULT_POLL_INTERVAL    100 /* in msec */
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
+/* take mutex
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
+	/* Do not write in the region from the CNTIN register through the
+	 * PWMLOAD register when FTMEN = 0.
+	 */
+	ftm_write(ftm, FTM_MODE, FTM_MODE_FTMEN); /* enable FTM */
+	ftm_write(ftm, FTM_CNTIN, 0x0000);         /* zero init value */
+	ftm_write(ftm, FTM_MOD, 0xffff);        /* max overflow value */
+	ftm_write(ftm, FTM_CNT, 0x0);           /* reset counter value */
+	ftm_write(ftm, FTM_SC, FTM_SC_PS_1);    /* prescale with x1 */
+	/* Select quad mode */
+	ftm_write(ftm, FTM_QDCTRL, FTM_QDCTRL_QUADEN);
+
+	/* Unused features and reset to default section */
+	ftm_write(ftm, FTM_POL, 0x0);     /* polarity is active high */
+	ftm_write(ftm, FTM_FLTCTRL, 0x0); /* all faults disabled */
+	ftm_write(ftm, FTM_SYNCONF, 0x0); /* disable all sync */
+	ftm_write(ftm, FTM_SYNC, 0xffff);
+
+	/* Lock the FTM */
+	ftm_set_write_protection(ftm);
+}
+
+static int ftm_quaddec_read_raw(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan,
+				int *val, int *val2, long mask)
+{
+	struct ftm_quaddec *ftm = iio_priv(indio_dev);
+	uint32_t counter;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ftm_read(ftm, FTM_CNT, &counter);
+		*val = counter;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static ssize_t ftm_write_reset(struct iio_dev *indio_dev,
+				uintptr_t private,
+				struct iio_chan_spec const *chan,
+				const char *buf, size_t len)
+{
+	struct ftm_quaddec *ftm = iio_priv(indio_dev);
+
+	/* Only "counter reset" is supported for now */
+	if (!sysfs_streq(buf, "0")) {
+		dev_warn(&ftm->pdev->dev, "Reset only accepts '0'\n");
+		return -EINVAL;
+	}
+
+	ftm_reset_counter(ftm);
+
+	return len;
+}
+
+static int ftm_quaddec_get_prescaler(struct iio_dev *indio_dev,
+					const struct iio_chan_spec *chan)
+{
+	struct ftm_quaddec *ftm = iio_priv(indio_dev);
+	uint32_t scflags;
+
+	ftm_read(ftm, FTM_SC, &scflags);
+
+	return scflags & FTM_SC_PS_MASK;
+}
+
+static int ftm_quaddec_set_prescaler(struct iio_dev *indio_dev,
+					const struct iio_chan_spec *chan,
+					unsigned int type)
+{
+	struct ftm_quaddec *ftm = iio_priv(indio_dev);
+
+	uint32_t scflags;
+
+	mutex_lock(&ftm->ftm_quaddec_mutex);
+
+	ftm_read(ftm, FTM_SC, &scflags);
+
+	scflags &= ~FTM_SC_PS_MASK;
+	type &= FTM_SC_PS_MASK; /*just to be 100% sure*/
+
+	scflags |= type;
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
+static const struct iio_enum ftm_quaddec_prescaler_en = {
+	.items = ftm_quaddec_prescaler,
+	.num_items = ARRAY_SIZE(ftm_quaddec_prescaler),
+	.get = ftm_quaddec_get_prescaler,
+	.set = ftm_quaddec_set_prescaler,
+};
+
+static const struct iio_chan_spec_ext_info ftm_quaddec_ext_info[] = {
+	{
+		.name = "reset",
+		.shared = IIO_SEPARATE,
+		.write = ftm_write_reset,
+	},
+	IIO_ENUM("prescaler", IIO_SEPARATE, &ftm_quaddec_prescaler_en),
+	IIO_ENUM_AVAILABLE("prescaler", &ftm_quaddec_prescaler_en),
+	{}
+};
+
+static const struct iio_chan_spec ftm_quaddec_channels = {
+	.type = IIO_COUNT,
+	.channel = 0,
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+	.ext_info = ftm_quaddec_ext_info,
+	.indexed = 1,
+};
+
+static const struct iio_info ftm_quaddec_iio_info = {
+	.read_raw = ftm_quaddec_read_raw,
+};
+
+static int ftm_quaddec_probe(struct platform_device *pdev)
+{
+	struct iio_dev *indio_dev;
+	struct ftm_quaddec *ftm;
+	int ret;
+
+	struct device_node *node = pdev->dev.of_node;
+
+	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*ftm));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	ftm = iio_priv(indio_dev);
+
+	platform_set_drvdata(pdev, ftm);
+
+	ftm->pdev = pdev;
+	ftm->big_endian = of_property_read_bool(node, "big-endian");
+	ftm->ftm_base = of_iomap(node, 0);
+	if (!ftm->ftm_base)
+		return -EINVAL;
+
+	indio_dev->name = dev_name(&pdev->dev);
+	indio_dev->dev.parent = &pdev->dev;
+	indio_dev->info = &ftm_quaddec_iio_info;
+	indio_dev->num_channels = 1;
+	indio_dev->channels = &ftm_quaddec_channels;
+
+	ftm_quaddec_init(ftm);
+
+	mutex_init(&ftm->ftm_quaddec_mutex);
+
+	ret = devm_iio_device_register(&pdev->dev, indio_dev);
+	if (ret) {
+		mutex_destroy(&ftm->ftm_quaddec_mutex);
+		iounmap(ftm->ftm_base);
+	}
+	return ret;
+}
+
+static int ftm_quaddec_remove(struct platform_device *pdev)
+{
+	struct ftm_quaddec *ftm;
+	struct iio_dev *indio_dev;
+
+	ftm = (struct ftm_quaddec *)platform_get_drvdata(pdev);
+	indio_dev = iio_priv_to_dev(ftm);
+	/* This is needed to remove sysfs entries */
+	devm_iio_device_unregister(&pdev->dev, indio_dev);
+
+	ftm_write(ftm, FTM_MODE, 0);
+
+	iounmap(ftm->ftm_base);
+	mutex_destroy(&ftm->ftm_quaddec_mutex);
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
2.17.1

