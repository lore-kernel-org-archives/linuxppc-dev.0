Return-Path: <SRS0=+pA4=RK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C76C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Mar 2019 11:33:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6632720851
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Mar 2019 11:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6ihUp0I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6632720851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44FT6W3shZzDqFw
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Mar 2019 22:33:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::142; helo=mail-it1-x142.google.com;
 envelope-from=vilhelm.gray@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="R6ihUp0I"; 
 dkim-atps=neutral
Received: from mail-it1-x142.google.com (mail-it1-x142.google.com
 [IPv6:2607:f8b0:4864:20::142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44FT4N2GhzzDqCT
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Mar 2019 22:32:03 +1100 (AEDT)
Received: by mail-it1-x142.google.com with SMTP id v83so15276378itf.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Mar 2019 03:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=B5Y1ZsbthP1LrzDmKlxtV7+d0Vh/YjjZ0kFynkQuC4o=;
 b=R6ihUp0IXdYfD/5y1x3X85uQNfXGwqAMTQKNxZTSxSdNUnNrQYnKXMRMmgWz5IhiNb
 ZjfB+xCQyAfCkkI5wWrzP02o9xFL01uDM2LmPWlw8rDpaPkr4GCqXaPOnCJ6jKGQJNNF
 +SQput9l52m37u08aRfE/cQ3N5Geoov/3hVROj0be/+AamjOd2cng1QUFVYc0I59agbW
 mzmEqhRKJFMqtdr4291xdJ0vf8KKmZxjEbfSIofLC2KEAoQ0/H0frp3t+k3jFpp279o0
 fwojPHNKSzC937RCMorhrLpHzr99dcZf5jR499sZD1kiYvBZwzqz0Qdqnbvginbtxx3J
 29+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=B5Y1ZsbthP1LrzDmKlxtV7+d0Vh/YjjZ0kFynkQuC4o=;
 b=U+toqyL9sI5NrvWt8DkdNTJOcJPwXqDEABz1kPr6jsvsR1W+aof0WK0m7ybGm3Vymk
 wzysM+iTxkWUxbkACiv3nuyKvnoTTMDisYo82cVIexv0pPVQkjfw9DMRWNMwaLwTU9nd
 Q8SVXOgsNudjMrwoN1DkVRYOSgaer2/yOEsL949kRbFO72Z9+eMhiK/CglRAPMM+12oM
 sRi1BguYOUZrvfLvuJbfpfHDb048h0xvUmopxxirKQl7GRucp3Mid89IM9U6DpXza0JT
 Tdbw+MM6681wJESetXhKdHUsjOCFGkJ1mBqfQw1TiBkiRSd+7oKGxwi0uCdxSAzPbb/t
 RHwQ==
X-Gm-Message-State: APjAAAWb7VUK0JB6hCbasQRttud76wTIrNzVfp5UoV3/iHNFopkb0Mja
 wyYP0L5M/1xTksAmD0NUM/k=
X-Google-Smtp-Source: APXvYqwJ7/ss6aqsUok7WN2cOmEiCRCPhMug4+xV+PFKmpjqlhIquvPpN6mwfmSlxz/wWKx5E5BFZQ==
X-Received: by 2002:a24:7a84:: with SMTP id a126mr4828686itc.21.1551958319908; 
 Thu, 07 Mar 2019 03:31:59 -0800 (PST)
Received: from icarus ([2001:268:c0a4:120d:c70:4af9:86e2:2])
 by smtp.gmail.com with ESMTPSA id r2sm2125115itk.5.2019.03.07.03.31.52
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 07 Mar 2019 03:31:58 -0800 (PST)
Date: Thu, 7 Mar 2019 20:32:25 +0900
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Patrick Havelange <patrick.havelange@essensium.com>
Subject: Re: [PATCH v2 5/7] counter: add FlexTimer Module Quadrature decoder
 counter driver
Message-ID: <20190307113147.GA7851@icarus>
References: <20190306111208.7454-1-patrick.havelange@essensium.com>
 <20190306111208.7454-6-patrick.havelange@essensium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190306111208.7454-6-patrick.havelange@essensium.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
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
 Jonathan Cameron <jic23@kernel.org>, linux-pwm@vger.kernel.org,
 linux-iio@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 linux-arm-kernel@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>,
 Shawn Guo <shawnguo@kernel.org>, Esben Haabendal <esben@haabendal.dk>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Mar 06, 2019 at 12:12:06PM +0100, Patrick Havelange wrote:
> This driver exposes the counter for the quadrature decoder of the
> FlexTimer Module, present in the LS1021A soc.
> 
> Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
> ---
> Changes v2
>  - Rebased on new counter subsystem
>  - Cleaned up included headers
>  - Use devm_ioremap()
>  - Correct order of devm_ and unmanaged resources
> ---
>  drivers/counter/Kconfig       |   9 +
>  drivers/counter/Makefile      |   1 +
>  drivers/counter/ftm-quaddec.c | 356 ++++++++++++++++++++++++++++++++++
>  3 files changed, 366 insertions(+)
>  create mode 100644 drivers/counter/ftm-quaddec.c

Overall, I think you utilized the Generic Counter interface correctly.
So good job on the conversion from your initial patch. :-)

Some minor inline suggestions/comments follow.

> 
> diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
> index 87c491a19c63..233ac305d878 100644
> --- a/drivers/counter/Kconfig
> +++ b/drivers/counter/Kconfig
> @@ -48,4 +48,13 @@ config STM32_LPTIMER_CNT
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called stm32-lptimer-cnt.
>  
> +config FTM_QUADDEC
> +	tristate "Flex Timer Module Quadrature decoder driver"
> +	help
> +	  Select this option to enable the Flex Timer Quadrature decoder
> +	  driver.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called ftm-quaddec.
> +
>  endif # COUNTER
> diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
> index 5589976d37f8..0c9e622a6bea 100644
> --- a/drivers/counter/Makefile
> +++ b/drivers/counter/Makefile
> @@ -7,3 +7,4 @@ obj-$(CONFIG_COUNTER) += counter.o
>  obj-$(CONFIG_104_QUAD_8)	+= 104-quad-8.o
>  obj-$(CONFIG_STM32_TIMER_CNT)	+= stm32-timer-cnt.o
>  obj-$(CONFIG_STM32_LPTIMER_CNT)	+= stm32-lptimer-cnt.o
> +obj-$(CONFIG_FTM_QUADDEC)	+= ftm-quaddec.o
> diff --git a/drivers/counter/ftm-quaddec.c b/drivers/counter/ftm-quaddec.c
> new file mode 100644
> index 000000000000..1bc9e075a386
> --- /dev/null
> +++ b/drivers/counter/ftm-quaddec.c
> @@ -0,0 +1,356 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Flex Timer Module Quadrature decoder
> + *
> + * This module implements a driver for decoding the FTM quadrature
> + * of ex. a LS1021A
> + */
> +
> +#include <linux/fsl/ftm.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/of.h>
> +#include <linux/io.h>
> +#include <linux/mutex.h>
> +#include <linux/counter.h>
> +
> +struct ftm_quaddec {
> +	struct counter_device counter;
> +	struct platform_device *pdev;
> +	void __iomem *ftm_base;
> +	bool big_endian;
> +	struct mutex ftm_quaddec_mutex;
> +};
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
> +/*
> + * take mutex
> + * call ftm_clear_write_protection
> + * update settings
> + * call ftm_set_write_protection
> + * release mutex
> + */

Jonathan mentioned it before in the previous review, and I think I agree
too, that this comment block is superfluous: the context of this code is
simple enough that the function call order is naturally obvious (i.e.
write protection must be cleared before settings are modified).

The only important thing to mention here is that the mutex must be held
before the write protection state is modified so a comment along the
following lines should suffice:

/* hold mutex before modifying write protection state */

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
> +	/*
> +	 * Do not write in the region from the CNTIN register through the
> +	 * PWMLOAD register when FTMEN = 0.
> +	 */
> +	ftm_write(ftm, FTM_MODE, FTM_MODE_FTMEN);
> +	ftm_write(ftm, FTM_CNTIN, 0x0000);
> +	ftm_write(ftm, FTM_MOD, 0xffff);
> +	ftm_write(ftm, FTM_CNT, 0x0);
> +	ftm_write(ftm, FTM_SC, FTM_SC_PS_1);
> +
> +	/* Select quad mode */
> +	ftm_write(ftm, FTM_QDCTRL, FTM_QDCTRL_QUADEN);
> +
> +	/* Unused features and reset to default section */
> +	ftm_write(ftm, FTM_POL, 0x0);
> +	ftm_write(ftm, FTM_FLTCTRL, 0x0);
> +	ftm_write(ftm, FTM_SYNCONF, 0x0);
> +	ftm_write(ftm, FTM_SYNC, 0xffff);
> +
> +	/* Lock the FTM */
> +	ftm_set_write_protection(ftm);
> +}
> +
> +static void ftm_quaddec_disable(struct ftm_quaddec *ftm)
> +{
> +	ftm_write(ftm, FTM_MODE, 0);
> +}

The ftm_quaddec_disable function is only used for cleanup when the
driver is being removed. Is disabling the FTM counter on removal
actually something we need to do?

While it's true that the register will keep updating, since the driver
is no longer loaded, we don't care about that register value. Once we
take control of the hardware again (by reloading our driver or via a new
one), we reinitialize the counter and set the count value back to 0
anyway -- so whatever value the register had no longer matters.

> +
> +static int ftm_quaddec_get_prescaler(struct counter_device *counter,
> +				     struct counter_count *count,
> +				     size_t *cnt_mode)
> +{
> +	struct ftm_quaddec *ftm = counter->priv;
> +	uint32_t scflags;
> +
> +	ftm_read(ftm, FTM_SC, &scflags);
> +
> +	*cnt_mode = scflags & FTM_SC_PS_MASK;
> +
> +	return 0;
> +}
> +
> +static int ftm_quaddec_set_prescaler(struct counter_device *counter,
> +				     struct counter_count *count,
> +				     size_t cnt_mode)
> +{
> +	struct ftm_quaddec *ftm = counter->priv;
> +
> +	uint32_t scflags;
> +
> +	mutex_lock(&ftm->ftm_quaddec_mutex);
> +
> +	ftm_read(ftm, FTM_SC, &scflags);
> +
> +	scflags &= ~FTM_SC_PS_MASK;
> +	cnt_mode &= FTM_SC_PS_MASK; /*just to be 100% sure*/
> +
> +	scflags |= cnt_mode;
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
> +static struct counter_count_enum_ext ftm_quaddec_prescaler_enum = {
> +	.items = ftm_quaddec_prescaler,
> +	.num_items = ARRAY_SIZE(ftm_quaddec_prescaler),
> +	.get = ftm_quaddec_get_prescaler,
> +	.set = ftm_quaddec_set_prescaler
> +};
> +
> +enum ftm_quaddec_synapse_action {
> +	FTM_QUADDEC_SYNAPSE_ACTION_BOTH_EDGES,
> +};
> +
> +static enum counter_synapse_action ftm_quaddec_synapse_actions[] = {
> +	[FTM_QUADDEC_SYNAPSE_ACTION_BOTH_EDGES] =
> +	COUNTER_SYNAPSE_ACTION_BOTH_EDGES
> +};
> +
> +enum ftm_quaddec_count_function {
> +	FTM_QUADDEC_COUNT_ENCODER_MODE_1,
> +};

The FlexTimer Module supports more than just a quadrature counter mode
doesn't it?

We should keep this initial patch simple since we are still introducing
the Counter subsystem, but it'll be nice to add support in the future
for the other counter modes such as single-edge capture.

> +
> +static const enum counter_count_function ftm_quaddec_count_functions[] = {
> +	[FTM_QUADDEC_COUNT_ENCODER_MODE_1] =
> +	COUNTER_COUNT_FUNCTION_QUADRATURE_X4
> +};
> +
> +static int ftm_quaddec_count_read(struct counter_device *counter,
> +				  struct counter_count *count,
> +				  struct counter_count_read_value *val)
> +{
> +	struct ftm_quaddec *const ftm = counter->priv;
> +	uint32_t cntval;
> +
> +	ftm_read(ftm, FTM_CNT, &cntval);
> +
> +	counter_count_read_value_set(val, COUNTER_COUNT_POSITION, &cntval);
> +
> +	return 0;
> +}
> +
> +static int ftm_quaddec_count_write(struct counter_device *counter,
> +				   struct counter_count *count,
> +				   struct counter_count_write_value *val)
> +{
> +	struct ftm_quaddec *const ftm = counter->priv;
> +	u32 cnt;
> +	int err;
> +
> +	err = counter_count_write_value_get(&cnt, COUNTER_COUNT_POSITION, val);
> +	if (err)
> +		return err;
> +
> +	if (cnt != 0) {
> +		dev_warn(&ftm->pdev->dev, "Can only accept '0' as new counter value\n");
> +		return -EINVAL;
> +	}
> +
> +	ftm_reset_counter(ftm);
> +
> +	return 0;
> +}
> +
> +static int ftm_quaddec_count_function_get(struct counter_device *counter,
> +					  struct counter_count *count,
> +					  size_t *function)
> +{
> +	*function = FTM_QUADDEC_COUNT_ENCODER_MODE_1;
> +
> +	return 0;
> +}
> +
> +static int ftm_quaddec_action_get(struct counter_device *counter,
> +				  struct counter_count *count,
> +				  struct counter_synapse *synapse,
> +				  size_t *action)
> +{
> +	*action = FTM_QUADDEC_SYNAPSE_ACTION_BOTH_EDGES;
> +
> +	return 0;
> +}
> +
> +static const struct counter_ops ftm_quaddec_cnt_ops = {
> +	.count_read = ftm_quaddec_count_read,
> +	.count_write = ftm_quaddec_count_write,
> +	.function_get = ftm_quaddec_count_function_get,
> +	.action_get = ftm_quaddec_action_get,
> +};
> +
> +static struct counter_signal ftm_quaddec_signals[] = {
> +	{
> +		.id = 0,
> +		.name = "Channel 1 Quadrature A"
> +	},
> +	{
> +		.id = 1,
> +		.name = "Channel 1 Quadrature B"
> +	}
> +};

If possible, these names should match the FTM datasheet naming
convention. The reason is to make it easier for users to match the
input signals described in the datasheet with the Signal data provided
by the Generic Counter interface.

I think the FTM datasheet describes these signals as "Phase A" and
"Phase B", so perhaps "Channel 1 Phase A" and "Channel 1 Phase B" may be
more appropriate names in this case.

> +
> +static struct counter_synapse ftm_quaddec_count_synapses[] = {
> +	{
> +		.actions_list = ftm_quaddec_synapse_actions,
> +		.num_actions = ARRAY_SIZE(ftm_quaddec_synapse_actions),
> +		.signal = &ftm_quaddec_signals[0]
> +	},
> +	{
> +		.actions_list = ftm_quaddec_synapse_actions,
> +		.num_actions = ARRAY_SIZE(ftm_quaddec_synapse_actions),
> +		.signal = &ftm_quaddec_signals[1]
> +	}
> +};
> +
> +static const struct counter_count_ext ftm_quaddec_count_ext[] = {
> +	COUNTER_COUNT_ENUM("prescaler", &ftm_quaddec_prescaler_enum),
> +	COUNTER_COUNT_ENUM_AVAILABLE("prescaler", &ftm_quaddec_prescaler_enum),
> +};
> +
> +static struct counter_count ftm_quaddec_counts = {
> +	.id = 0,
> +	.name = "Channel 1 Count",
> +	.functions_list = ftm_quaddec_count_functions,
> +	.num_functions = ARRAY_SIZE(ftm_quaddec_count_functions),
> +	.synapses = ftm_quaddec_count_synapses,
> +	.num_synapses = ARRAY_SIZE(ftm_quaddec_count_synapses),
> +	.ext = ftm_quaddec_count_ext,
> +	.num_ext = ARRAY_SIZE(ftm_quaddec_count_ext)
> +};
> +
> +static int ftm_quaddec_probe(struct platform_device *pdev)
> +{
> +	struct ftm_quaddec *ftm;
> +
> +	struct device_node *node = pdev->dev.of_node;
> +	struct resource *io;
> +	int ret;
> +
> +	ftm = devm_kzalloc(&pdev->dev, sizeof(*ftm), GFP_KERNEL);
> +	if (!ftm)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, ftm);
> +
> +	io = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!io) {
> +		dev_err(&pdev->dev, "Failed to get memory region\n");
> +		return -ENODEV;
> +	}
> +
> +	ftm->pdev = pdev;
> +	ftm->big_endian = of_property_read_bool(node, "big-endian");
> +	ftm->ftm_base = devm_ioremap(&pdev->dev, io->start, resource_size(io));
> +
> +	if (!ftm->ftm_base) {
> +		dev_err(&pdev->dev, "Failed to map memory region\n");
> +		return -EINVAL;
> +	}
> +	ftm->counter.name = dev_name(&pdev->dev);
> +	ftm->counter.parent = &pdev->dev;
> +	ftm->counter.ops = &ftm_quaddec_cnt_ops;
> +	ftm->counter.counts = &ftm_quaddec_counts;
> +	ftm->counter.num_counts = 1;
> +	ftm->counter.signals = ftm_quaddec_signals;
> +	ftm->counter.num_signals = ARRAY_SIZE(ftm_quaddec_signals);
> +	ftm->counter.priv = ftm;
> +
> +	mutex_init(&ftm->ftm_quaddec_mutex);
> +
> +	ftm_quaddec_init(ftm);
> +
> +	ret = counter_register(&ftm->counter);
> +	if (ret)
> +		ftm_quaddec_disable(ftm);
> +
> +	return ret;
> +}
> +
> +static int ftm_quaddec_remove(struct platform_device *pdev)
> +{
> +	struct ftm_quaddec *ftm = platform_get_drvdata(pdev);
> +
> +	counter_unregister(&ftm->counter);
> +
> +	ftm_quaddec_disable(ftm);
> +
> +	return 0;
> +}

If the ftm_quaddec_disable is not necessary, then we can eliminate the
ftm_quaddec_remove function as well by replacing the counter_register
call with a devm_counter_register call.

William Breathitt Gray

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
> -- 
> 2.19.1
> 
