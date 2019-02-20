Return-Path: <SRS0=+mMX=Q3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0DEC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 16:43:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80FA12084D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 16:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1PVIg3cO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80FA12084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444Nhy3k5VzDqLK
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 03:43:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=jic23@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="1PVIg3cO"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444Ng02nwlzDqHw
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 03:42:04 +1100 (AEDT)
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net
 [81.96.234.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2BAC82147C;
 Wed, 20 Feb 2019 16:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550680922;
 bh=LjrCiXhIRDdj3buwI7JxKjklU+7gD4+5KLfsnc4pbRc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=1PVIg3cO+TY5Uv6XGFT6WIdpBZWssMZGJc2qLiZNhfKFPLtJj7T2s5911TV/k/vTK
 fyiQHRNQ/5wSeK9O/+s8MRUfD4cT4wJikdO8/L9q2dk6YASEmALRJ9+aMJEu+F8Z/O
 O0b/QGygjvV2Ua3FDSlMF7YedBem+9mGBIUAnKjQ=
Date: Wed, 20 Feb 2019 16:41:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Patrick Havelange <patrick.havelange@essensium.com>
Subject: Re: [PATCH 5/8] iio/counter: add FlexTimer Module Quadrature
 decoder counter driver
Message-ID: <20190220164154.00547a77@archlinux>
In-Reply-To: <20190218140321.19166-5-patrick.havelange@essensium.com>
References: <20190218140321.19166-1-patrick.havelange@essensium.com>
 <20190218140321.19166-5-patrick.havelange@essensium.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Lars-Peter Clausen <lars@metafoo.de>, linux-pwm@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linus Walleij <linus.walleij@linaro.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 William Breathitt Gray <vilhelm.gray@gmail.com>, Li Yang <leoyang.li@nxp.com>,
 linuxppc-dev@lists.ozlabs.org, Rob Herring <robh+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 linux-arm-kernel@lists.infradead.org,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>,
 Thomas Gleixner <tglx@linutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Esben Haabendal <esben@haabendal.dk>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 18 Feb 2019 15:03:18 +0100
Patrick Havelange <patrick.havelange@essensium.com> wrote:

> This driver exposes the counter for the quadrature decoder of the
> FlexTimer Module, present in the LS1021A soc.
> 
> Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
> Reviewed-by: Esben Haabendal <esben@haabendal.dk>
Given you cc'd William, I'm guessing you know about the counter
subsystem effort.  I would really rather not take any drivers
into IIO if we have any hope of getting that upstreamed soon
(which I personally think we do and should!).  The reason is
we end up having to maintain old ABI just because someone might be using
it and it makes the drivers very messy.

I'll review as is though as may be there are some elements that will
cross over.

Comments inline.  William: Looks like a straight forward conversion if
it makes sense to get this lined up as part of your initial submission?
You have quite a few drivers so I wouldn't have said it needs to be there
at the start, but good to have it soon after.

Jonathan

> ---
>  drivers/iio/counter/Kconfig       |  10 +
>  drivers/iio/counter/Makefile      |   1 +
>  drivers/iio/counter/ftm-quaddec.c | 294 ++++++++++++++++++++++++++++++
>  3 files changed, 305 insertions(+)
>  create mode 100644 drivers/iio/counter/ftm-quaddec.c
> 
> diff --git a/drivers/iio/counter/Kconfig b/drivers/iio/counter/Kconfig
> index bf1e559ad7cd..4641cb2e752a 100644
> --- a/drivers/iio/counter/Kconfig
> +++ b/drivers/iio/counter/Kconfig
> @@ -31,4 +31,14 @@ config STM32_LPTIMER_CNT
>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called stm32-lptimer-cnt.
> +
> +config FTM_QUADDEC
> +	tristate "Flex Timer Module Quadrature decoder driver"
> +	help
> +	  Select this option to enable the Flex Timer Quadrature decoder
> +	  driver.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called ftm-quaddec.
> +
>  endmenu
> diff --git a/drivers/iio/counter/Makefile b/drivers/iio/counter/Makefile
> index 1b9a896eb488..757c1f4196af 100644
> --- a/drivers/iio/counter/Makefile
> +++ b/drivers/iio/counter/Makefile
> @@ -6,3 +6,4 @@
>  
>  obj-$(CONFIG_104_QUAD_8)	+= 104-quad-8.o
>  obj-$(CONFIG_STM32_LPTIMER_CNT)	+= stm32-lptimer-cnt.o
> +obj-$(CONFIG_FTM_QUADDEC)	+= ftm-quaddec.o
> diff --git a/drivers/iio/counter/ftm-quaddec.c b/drivers/iio/counter/ftm-quaddec.c
> new file mode 100644
> index 000000000000..ca7e55a9ab3f
> --- /dev/null
> +++ b/drivers/iio/counter/ftm-quaddec.c
> @@ -0,0 +1,294 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Flex Timer Module Quadrature decoder
> + *
> + * This module implements a driver for decoding the FTM quadrature
> + * of ex. a LS1021A
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/err.h>
> +#include <linux/device.h>
> +#include <linux/platform_device.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/workqueue.h>
Tidy these up. Not all are used.
> +#include <linux/swait.h>
> +#include <linux/sched.h>
> +#include <linux/delay.h>
> +#include <linux/iio/iio.h>
> +#include <linux/mutex.h>
> +#include <linux/fsl/ftm.h>
> +
> +struct ftm_quaddec {
> +	struct platform_device *pdev;
> +	void __iomem *ftm_base;
> +	bool big_endian;

I'm curious. What is the benefit of running in big endian mode?

> +	struct mutex ftm_quaddec_mutex;
> +};
> +
> +#define HASFLAGS(flag, bits) ((flag & bits) ? 1 : 0)
Not used.


> +
> +#define DEFAULT_POLL_INTERVAL    100 /* in msec */
> +
> +static void ftm_read(struct ftm_quaddec *ftm, uint32_t offset, uint32_t *data)
> +{
> +	if (ftm->big_endian)
> +		*data = ioread32be(ftm->ftm_base + offset);
> +	else
> +		*data = ioread32(ftm->ftm_base + offset);
> +}
> +
> +static void ftm_write(struct ftm_quaddec *ftm, uint32_t offset, uint32_t data)
> +{
> +	if (ftm->big_endian)
> +		iowrite32be(data, ftm->ftm_base + offset);
> +	else
> +		iowrite32(data, ftm->ftm_base + offset);
> +}
> +
> +/* take mutex

Tidy this comment up.  I  would have said the flow as fairly
obvious and the only thing needed here is to document that
the mutex must be held?

> + * call ftm_clear_write_protection
> + * update settings
> + * call ftm_set_write_protection
> + * release mutex
> + */
> +static void ftm_clear_write_protection(struct ftm_quaddec *ftm)
> +{
> +	uint32_t flag;
> +
> +	/* First see if it is enabled */
> +	ftm_read(ftm, FTM_FMS, &flag);
> +
> +	if (flag & FTM_FMS_WPEN) {
> +		ftm_read(ftm, FTM_MODE, &flag);
> +		ftm_write(ftm, FTM_MODE, flag | FTM_MODE_WPDIS);
> +	}
> +}
> +
> +static void ftm_set_write_protection(struct ftm_quaddec *ftm)
> +{
> +	ftm_write(ftm, FTM_FMS, FTM_FMS_WPEN);
> +}
> +
> +static void ftm_reset_counter(struct ftm_quaddec *ftm)
> +{
> +	/* Reset hardware counter to CNTIN */
> +	ftm_write(ftm, FTM_CNT, 0x0);
> +}
> +
> +static void ftm_quaddec_init(struct ftm_quaddec *ftm)
> +{
> +	ftm_clear_write_protection(ftm);
> +
> +	/* Do not write in the region from the CNTIN register through the
IIO multiline syntax is
/*
 * Do not write
 * PWM..
 */
> +	 * PWMLOAD register when FTMEN = 0.
> +	 */
> +	ftm_write(ftm, FTM_MODE, FTM_MODE_FTMEN); /* enable FTM */

Drop any comments that are self explanatory.

> +	ftm_write(ftm, FTM_CNTIN, 0x0000);         /* zero init value */
> +	ftm_write(ftm, FTM_MOD, 0xffff);        /* max overflow value */
> +	ftm_write(ftm, FTM_CNT, 0x0);           /* reset counter value */
> +	ftm_write(ftm, FTM_SC, FTM_SC_PS_1);    /* prescale with x1 */
> +	/* Select quad mode */
> +	ftm_write(ftm, FTM_QDCTRL, FTM_QDCTRL_QUADEN);
> +
> +	/* Unused features and reset to default section */
> +	ftm_write(ftm, FTM_POL, 0x0);     /* polarity is active high */
> +	ftm_write(ftm, FTM_FLTCTRL, 0x0); /* all faults disabled */
> +	ftm_write(ftm, FTM_SYNCONF, 0x0); /* disable all sync */
> +	ftm_write(ftm, FTM_SYNC, 0xffff);
> +
> +	/* Lock the FTM */
> +	ftm_set_write_protection(ftm);
> +}
> +
> +static int ftm_quaddec_read_raw(struct iio_dev *indio_dev,
> +				struct iio_chan_spec const *chan,
> +				int *val, int *val2, long mask)
> +{
> +	struct ftm_quaddec *ftm = iio_priv(indio_dev);
> +	uint32_t counter;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ftm_read(ftm, FTM_CNT, &counter);
> +		*val = counter;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static ssize_t ftm_write_reset(struct iio_dev *indio_dev,
> +				uintptr_t private,
> +				struct iio_chan_spec const *chan,
> +				const char *buf, size_t len)
> +{
> +	struct ftm_quaddec *ftm = iio_priv(indio_dev);
> +
> +	/* Only "counter reset" is supported for now */
> +	if (!sysfs_streq(buf, "0")) {
> +		dev_warn(&ftm->pdev->dev, "Reset only accepts '0'\n");
> +		return -EINVAL;

Why not just make the channel attribute itself writeable given we are
setting it to 0?

> +	}
> +
> +	ftm_reset_counter(ftm);
> +
> +	return len;
> +}
> +
> +static int ftm_quaddec_get_prescaler(struct iio_dev *indio_dev,
> +					const struct iio_chan_spec *chan)
> +{
> +	struct ftm_quaddec *ftm = iio_priv(indio_dev);
> +	uint32_t scflags;
> +
> +	ftm_read(ftm, FTM_SC, &scflags);
> +
> +	return scflags & FTM_SC_PS_MASK;
> +}
> +
> +static int ftm_quaddec_set_prescaler(struct iio_dev *indio_dev,
> +					const struct iio_chan_spec *chan,
> +					unsigned int type)
> +{
> +	struct ftm_quaddec *ftm = iio_priv(indio_dev);
> +
> +	uint32_t scflags;
> +
> +	mutex_lock(&ftm->ftm_quaddec_mutex);
> +
> +	ftm_read(ftm, FTM_SC, &scflags);
> +
> +	scflags &= ~FTM_SC_PS_MASK;
> +	type &= FTM_SC_PS_MASK; /*just to be 100% sure*/
> +
> +	scflags |= type;
> +
> +	/* Write */
> +	ftm_clear_write_protection(ftm);
> +	ftm_write(ftm, FTM_SC, scflags);
> +	ftm_set_write_protection(ftm);
> +
> +	/* Also resets the counter as it is undefined anyway now */
> +	ftm_reset_counter(ftm);
> +
> +	mutex_unlock(&ftm->ftm_quaddec_mutex);
> +	return 0;
> +}
> +
> +static const char * const ftm_quaddec_prescaler[] = {
> +	"1", "2", "4", "8", "16", "32", "64", "128"
> +};
> +
> +static const struct iio_enum ftm_quaddec_prescaler_en = {
> +	.items = ftm_quaddec_prescaler,
> +	.num_items = ARRAY_SIZE(ftm_quaddec_prescaler),
> +	.get = ftm_quaddec_get_prescaler,
> +	.set = ftm_quaddec_set_prescaler,
> +};
> +
> +static const struct iio_chan_spec_ext_info ftm_quaddec_ext_info[] = {
> +	{
> +		.name = "reset",
> +		.shared = IIO_SEPARATE,
> +		.write = ftm_write_reset,
> +	},
> +	IIO_ENUM("prescaler", IIO_SEPARATE, &ftm_quaddec_prescaler_en),

This looks like non standard ABI.  Needs documentation in
Documentation/ABI/testing/sysfs-bus-iio-*

> +	IIO_ENUM_AVAILABLE("prescaler", &ftm_quaddec_prescaler_en),
> +	{}
> +};
> +
> +static const struct iio_chan_spec ftm_quaddec_channels = {
> +	.type = IIO_COUNT,
> +	.channel = 0,
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +	.ext_info = ftm_quaddec_ext_info,
> +	.indexed = 1,
> +};
> +
> +static const struct iio_info ftm_quaddec_iio_info = {
> +	.read_raw = ftm_quaddec_read_raw,
> +};
> +
> +static int ftm_quaddec_probe(struct platform_device *pdev)
> +{
> +	struct iio_dev *indio_dev;
> +	struct ftm_quaddec *ftm;
> +	int ret;
> +
> +	struct device_node *node = pdev->dev.of_node;
> +
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*ftm));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	ftm = iio_priv(indio_dev);
> +
> +	platform_set_drvdata(pdev, ftm);
> +
> +	ftm->pdev = pdev;
> +	ftm->big_endian = of_property_read_bool(node, "big-endian");
> +	ftm->ftm_base = of_iomap(node, 0);
> +	if (!ftm->ftm_base)
> +		return -EINVAL;
> +
> +	indio_dev->name = dev_name(&pdev->dev);

This should be a nice part number like string.  What does
it evaluate to here?

> +	indio_dev->dev.parent = &pdev->dev;
> +	indio_dev->info = &ftm_quaddec_iio_info;
> +	indio_dev->num_channels = 1;
> +	indio_dev->channels = &ftm_quaddec_channels;
> +
> +	ftm_quaddec_init(ftm);
> +
> +	mutex_init(&ftm->ftm_quaddec_mutex);
> +
> +	ret = devm_iio_device_register(&pdev->dev, indio_dev);
> +	if (ret) {
> +		mutex_destroy(&ftm->ftm_quaddec_mutex);

Don't have managed devm_ calls after anything unmanaged.
I opens you up to races and is hard to review.

> +		iounmap(ftm->ftm_base);
I would suggest not using of_iomap, then you can
use the devm_ioremap form handle this for you.

> +	}
> +	return ret;
> +}
> +
> +static int ftm_quaddec_remove(struct platform_device *pdev)
> +{
> +	struct ftm_quaddec *ftm;
> +	struct iio_dev *indio_dev;
> +
> +	ftm = (struct ftm_quaddec *)platform_get_drvdata(pdev);

platform_get_drvdata returns a void *.

C spec says you can always cast implicitly from a void * to any
other point type.  Hence you don't need the cast.
(I'm too lazy to find the reference now as it's been a long
day of reviewing but google will find it for you if interested)

> +	indio_dev = iio_priv_to_dev(ftm);
> +	/* This is needed to remove sysfs entries */

It does a lot more than that, so please remove the comment.
Actually this worries me.  You should not need to manually
call devm_iio_device_register, but you do because of the ordering
and the fact you want to remove the interfaces before turning the
device off.  In that case, do not use the devm_ form but
instead iio_device_register and do the error handling paths
manually.  An alternative is to use
devm_add_action_or_reset to call unwind functions automatically
for the few device specific calls you have.


> +	devm_iio_device_unregister(&pdev->dev, indio_dev);
> +
> +	ftm_write(ftm, FTM_MODE, 0);
> +
> +	iounmap(ftm->ftm_base);
> +	mutex_destroy(&ftm->ftm_quaddec_mutex);

mutex destroy is only really used in debug paths and is often
skipped in remove functions to simplify things.
(particularly when managed cleanup is going on).

> +
> +	return 0;
> +}
> +
> +static const struct of_device_id ftm_quaddec_match[] = {
> +	{ .compatible = "fsl,ftm-quaddec" },
> +	{},
> +};
> +
> +static struct platform_driver ftm_quaddec_driver = {
> +	.driver = {
> +		.name = "ftm-quaddec",
> +		.owner = THIS_MODULE,
> +		.of_match_table = ftm_quaddec_match,
> +	},
> +	.probe = ftm_quaddec_probe,
> +	.remove = ftm_quaddec_remove,
> +};
> +
> +module_platform_driver(ftm_quaddec_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Kjeld Flarup <kfa@deif.com");
> +MODULE_AUTHOR("Patrick Havelange <patrick.havelange@essensium.com");

