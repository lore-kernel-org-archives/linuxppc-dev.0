Return-Path: <SRS0=+mMX=Q3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A65C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 16:56:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49C3D2146E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 16:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+FOaVGS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49C3D2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444P0520QtzDqLS
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 03:56:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=jic23@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="S+FOaVGS"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444Nxb0ChNzDqJs
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 03:54:42 +1100 (AEDT)
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net
 [81.96.234.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0F6C121841;
 Wed, 20 Feb 2019 16:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550681681;
 bh=XJLxIoLyKdGaSW3pIVrH0HtLNpF/mN2UfFqH+cyMEHE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=S+FOaVGSB3cdQuss4KT1kYtWT/cZFEOJNEaYl5BawmdMU+V8tLzOEMcLnuw6z54OA
 3A4hcTkLrIQj+fMZyPY9CadJH78n9SWdRGSgxujPMOKupsWQl4PSyG86lyoBSs1zpW
 b7MoZZjkppOImywIdriYVuf35I/akfDXgiZNysZ4=
Date: Wed, 20 Feb 2019 16:54:33 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Patrick Havelange <patrick.havelange@essensium.com>
Subject: Re: [PATCH 8/8] iio/counter/ftm-quaddec: add handling of
 under/overflow of the counter.
Message-ID: <20190220165433.22f5d58c@archlinux>
In-Reply-To: <20190218140321.19166-8-patrick.havelange@essensium.com>
References: <20190218140321.19166-1-patrick.havelange@essensium.com>
 <20190218140321.19166-8-patrick.havelange@essensium.com>
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

On Mon, 18 Feb 2019 15:03:21 +0100
Patrick Havelange <patrick.havelange@essensium.com> wrote:

> This is implemented by polling the counter value. A new parameter
> "poll-interval" can be set in the device tree, or can be changed
> at runtime. The reason for the polling is to avoid interrupts flooding.
> If the quadrature input is going up and down around the overflow value
> (or around 0), the interrupt will be triggering all the time. Thus,
> polling is an easy way to handle overflow in a consistent way.
> Polling can still be disabled by setting poll-interval to 0.
> 
> Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
> Reviewed-by: Esben Haabendal <esben@haabendal.dk>
Comments inline.

Jonathan

> ---
>  drivers/iio/counter/ftm-quaddec.c | 199 +++++++++++++++++++++++++++++-
>  1 file changed, 193 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/counter/ftm-quaddec.c b/drivers/iio/counter/ftm-quaddec.c
> index ca7e55a9ab3f..3a0395c3ef33 100644
> --- a/drivers/iio/counter/ftm-quaddec.c
> +++ b/drivers/iio/counter/ftm-quaddec.c
> @@ -25,11 +25,33 @@
>  
>  struct ftm_quaddec {
>  	struct platform_device *pdev;
> +	struct delayed_work delayedcounterwork;
>  	void __iomem *ftm_base;
>  	bool big_endian;
> +
> +	/* Offset added to the counter to adjust for overflows of the
> +	 * 16 bit HW counter. Only the 16 MSB are set.
Comment syntax.
> +	 */
> +	uint32_t counteroffset;
> +
> +	/* Store the counter on each read, this is used to detect
> +	 * if the counter readout if we over or underflow
> +	 */
> +	uint8_t lastregion;
> +
> +	/* Poll-interval, in ms before delayed work must poll counter */
> +	uint16_t poll_interval;
> +
>  	struct mutex ftm_quaddec_mutex;
>  };
>  
> +struct counter_result {
> +	/* 16 MSB are from the counteroffset
> +	 * 16 LSB are from the hardware counter
> +	 */
> +	uint32_t value;
Why the structure?

> +};
> +
>  #define HASFLAGS(flag, bits) ((flag & bits) ? 1 : 0)
>  
>  #define DEFAULT_POLL_INTERVAL    100 /* in msec */
> @@ -74,8 +96,75 @@ static void ftm_set_write_protection(struct ftm_quaddec *ftm)
>  	ftm_write(ftm, FTM_FMS, FTM_FMS_WPEN);
>  }
>  
> +/* must be called with mutex locked */
> +static void ftm_work_reschedule(struct ftm_quaddec *ftm)
> +{
> +	cancel_delayed_work(&ftm->delayedcounterwork);
> +	if (ftm->poll_interval > 0)
> +		schedule_delayed_work(&ftm->delayedcounterwork,
> +				   msecs_to_jiffies(ftm->poll_interval));
> +}
> +
> +/* Reports the hardware counter added the offset counter.
> + *
> + * The quadrature decodes does not use interrupts, because it cannot be
> + * guaranteed that the counter won't flip between 0xFFFF and 0x0000 at a high
> + * rate, causing Real Time performance degration. Instead the counter must be
> + * read frequently enough - the assumption is 150 KHz input can be handled with
> + * 100 ms read cycles.
> + */
> +static void ftm_work_counter(struct ftm_quaddec *ftm,
> +			     struct counter_result *returndata)
> +{
> +	/* only 16bits filled in*/
> +	uint32_t hwcounter;
> +	uint8_t currentregion;
> +
> +	mutex_lock(&ftm->ftm_quaddec_mutex);
> +
> +	ftm_read(ftm, FTM_CNT, &hwcounter);
> +
> +	/* Divide the counter in four regions:
> +	 *   0x0000-0x4000-0x8000-0xC000-0xFFFF
> +	 * When the hwcounter changes between region 0 and 3 there is an
> +	 * over/underflow
> +	 */
> +	currentregion = hwcounter / 0x4000;
> +
> +	if (ftm->lastregion == 3 && currentregion == 0)
> +		ftm->counteroffset += 0x10000;
> +
> +	if (ftm->lastregion == 0 && currentregion == 3)
> +		ftm->counteroffset -= 0x10000;
> +
> +	ftm->lastregion = currentregion;
> +
> +	if (returndata)
> +		returndata->value = ftm->counteroffset + hwcounter;
> +
> +	ftm_work_reschedule(ftm);
> +
> +	mutex_unlock(&ftm->ftm_quaddec_mutex);
> +}
> +
> +/* wrapper around the real function */
> +static void ftm_work_counter_delay(struct work_struct *workptr)
> +{
> +	struct delayed_work *work;
> +	struct ftm_quaddec *ftm;
> +
> +	work = container_of(workptr, struct delayed_work, work);
> +	ftm = container_of(work, struct ftm_quaddec, delayedcounterwork);
> +
> +	ftm_work_counter(ftm, NULL);
> +}
> +
> +/* must be called with mutex locked */
>  static void ftm_reset_counter(struct ftm_quaddec *ftm)
>  {
> +	ftm->counteroffset = 0;
> +	ftm->lastregion = 0;
> +
>  	/* Reset hardware counter to CNTIN */
>  	ftm_write(ftm, FTM_CNT, 0x0);
>  }
> @@ -110,18 +199,91 @@ static int ftm_quaddec_read_raw(struct iio_dev *indio_dev,
>  				int *val, int *val2, long mask)
>  {
>  	struct ftm_quaddec *ftm = iio_priv(indio_dev);
> -	uint32_t counter;
> +	struct counter_result counter;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		ftm_read(ftm, FTM_CNT, &counter);
> -		*val = counter;
> +	case IIO_CHAN_INFO_PROCESSED:

> +		ftm_work_counter(ftm, &counter);
> +		if (mask == IIO_CHAN_INFO_RAW)
> +			counter.value &= 0xffff;
> +
> +		*val = counter.value;
> +
>  		return IIO_VAL_INT;
>  	default:
>  		return -EINVAL;
>  	}
>  }
>  
> +static uint32_t ftm_get_default_poll_interval(const struct ftm_quaddec *ftm)
> +{
> +	/* Read values from device tree */
> +	uint32_t val;
> +	const struct device_node *node = ftm->pdev->dev.of_node;
> +
> +	if (of_property_read_u32(node, "poll-interval", &val))
> +		val = DEFAULT_POLL_INTERVAL;
> +
> +	return val;
> +}
> +
> +static ssize_t ftm_read_default_poll_interval(struct iio_dev *indio_dev,
> +					uintptr_t private,
> +					struct iio_chan_spec const *chan,
> +					char *buf)
> +{
> +	const struct ftm_quaddec *ftm = iio_priv(indio_dev);
> +	uint32_t val = ftm_get_default_poll_interval(ftm);
> +
> +	return snprintf(buf, PAGE_SIZE, "%u\n", val);
> +}
> +
> +static ssize_t ftm_read_poll_interval(struct iio_dev *indio_dev,
> +				uintptr_t private,
> +				struct iio_chan_spec const *chan,
> +				char *buf)
> +{
> +	struct ftm_quaddec *ftm = iio_priv(indio_dev);
> +
> +	uint32_t poll_interval = READ_ONCE(ftm->poll_interval);
Why bother with the local variable? I'm not awake enough to see
why the READ_ONCE is necessary here.
If worried about it, just take the lock, we are far from high
performance in this path.

> +
> +	return snprintf(buf, PAGE_SIZE, "%u\n", poll_interval);
> +}
> +
> +static ssize_t ftm_write_poll_interval(struct iio_dev *indio_dev,
> +				uintptr_t private,
> +				struct iio_chan_spec const *chan,
> +				const char *buf, size_t len)
> +{
> +	struct ftm_quaddec *ftm = iio_priv(indio_dev);
> +	uint32_t newpoll_interval;
> +	uint32_t default_interval;
> +
> +	if (kstrtouint(buf, 10, &newpoll_interval) != 0) {
> +		dev_err(&ftm->pdev->dev, "poll_interval not a number: '%s'\n",
> +			buf);
> +		return -EINVAL;
> +	}
> +
> +	/* Don't accept polling times below the default value to protect the
> +	 * system.
> +	 */
> +	default_interval = ftm_get_default_poll_interval(ftm);
> +
> +	if (newpoll_interval < default_interval && newpoll_interval != 0)
> +		newpoll_interval = default_interval;
> +
> +	mutex_lock(&ftm->ftm_quaddec_mutex);
> +
> +	WRITE_ONCE(ftm->poll_interval, newpoll_interval);
> +	ftm_work_reschedule(ftm);
> +
> +	mutex_unlock(&ftm->ftm_quaddec_mutex);
> +
> +	return len;
> +}
> +
>  static ssize_t ftm_write_reset(struct iio_dev *indio_dev,
>  				uintptr_t private,
>  				struct iio_chan_spec const *chan,
> @@ -135,8 +297,11 @@ static ssize_t ftm_write_reset(struct iio_dev *indio_dev,
>  		return -EINVAL;
>  	}
>  
> +	mutex_lock(&ftm->ftm_quaddec_mutex);
> +
>  	ftm_reset_counter(ftm);
>  
> +	mutex_unlock(&ftm->ftm_quaddec_mutex);
>  	return len;
>  }
>  
> @@ -192,6 +357,17 @@ static const struct iio_enum ftm_quaddec_prescaler_en = {
>  };
>  
>  static const struct iio_chan_spec_ext_info ftm_quaddec_ext_info[] = {
> +	{
> +		.name = "default_poll_interval",
> +		.shared = IIO_SHARED_BY_TYPE,
> +		.read = ftm_read_default_poll_interval,
Why is this relevant if the value is set to something else?
> +	},
> +	{
> +		.name = "poll_interval",
> +		.shared = IIO_SHARED_BY_TYPE,
> +		.read = ftm_read_poll_interval,
> +		.write = ftm_write_poll_interval,
Hmm.  New ABI that needs documenting. I'm not sure how we should
handle this.  Perhaps William has a good suggestion for how to do it.
> +	},
>  	{
>  		.name = "reset",
>  		.shared = IIO_SEPARATE,
> @@ -205,7 +381,8 @@ static const struct iio_chan_spec_ext_info ftm_quaddec_ext_info[] = {
>  static const struct iio_chan_spec ftm_quaddec_channels = {
>  	.type = IIO_COUNT,
>  	.channel = 0,
> -	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +			      BIT(IIO_CHAN_INFO_PROCESSED),
Why?  As a general rule, we don't allow bother RAW and processed for
a particular channel.  Note the raw value doesn't actually 'have'
to be the value off a sensor - it is just expected to not have
linear scaling and offset applied (which are encode dependent
here so can't be applied).  So just use raw for your non overflowing
version.

>  	.ext_info = ftm_quaddec_ext_info,
>  	.indexed = 1,
>  };
> @@ -232,10 +409,14 @@ static int ftm_quaddec_probe(struct platform_device *pdev)
>  
>  	ftm->pdev = pdev;
>  	ftm->big_endian = of_property_read_bool(node, "big-endian");
> +	ftm->counteroffset = 0;
> +	ftm->lastregion = 0;
>  	ftm->ftm_base = of_iomap(node, 0);
>  	if (!ftm->ftm_base)
>  		return -EINVAL;
>  
> +	ftm->poll_interval = ftm_get_default_poll_interval(ftm);
> +
>  	indio_dev->name = dev_name(&pdev->dev);
>  	indio_dev->dev.parent = &pdev->dev;
>  	indio_dev->info = &ftm_quaddec_iio_info;
> @@ -245,9 +426,13 @@ static int ftm_quaddec_probe(struct platform_device *pdev)
>  	ftm_quaddec_init(ftm);
>  
>  	mutex_init(&ftm->ftm_quaddec_mutex);
> +	INIT_DELAYED_WORK(&ftm->delayedcounterwork, ftm_work_counter_delay);
> +
> +	ftm_work_reschedule(ftm);
>  
>  	ret = devm_iio_device_register(&pdev->dev, indio_dev);
>  	if (ret) {
> +		cancel_delayed_work_sync(&ftm->delayedcounterwork);
>  		mutex_destroy(&ftm->ftm_quaddec_mutex);
>  		iounmap(ftm->ftm_base);
>  	}
> @@ -261,13 +446,15 @@ static int ftm_quaddec_remove(struct platform_device *pdev)
>  
>  	ftm = (struct ftm_quaddec *)platform_get_drvdata(pdev);
>  	indio_dev = iio_priv_to_dev(ftm);
> -	/* This is needed to remove sysfs entries */
> +	/* Make sure no concurrent attribute reads happen*/
>  	devm_iio_device_unregister(&pdev->dev, indio_dev);
>  
> +	cancel_delayed_work_sync(&ftm->delayedcounterwork);
> +
>  	ftm_write(ftm, FTM_MODE, 0);
>  
> -	iounmap(ftm->ftm_base);
>  	mutex_destroy(&ftm->ftm_quaddec_mutex);
> +	iounmap(ftm->ftm_base);
Why the reorder?  If it was wrong in the first place, fix the
earlier patch not this one.
>  
>  	return 0;
>  }

