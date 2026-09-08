Return-Path: <linuxppc-dev+bounces-26788-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD66C79FA1
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 11:58:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfMsH6C2pz2y2b;
	Tue, 08 Sep 2026 21:58:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788868707;
	cv=none; b=OsmHfZfvnvxWvVIyowZwqxz/UJhFr4xQH0ldNTe5eX0sJZn1J+KCVXf+o3Vg9kdqy1OCtRoLOEJuvBWQ8hkVIX1v4g6uhwW7km2B6H2jHK6qxvU8VIHSGDl4v3kgkrjTmcTTEHiG/0vaht5UMp6IszSApoy0iffkaaeOGKJGoWCWwYGOaxilyTvlhz5H7FC6RKh0ZVc1nsTJdT3QCakV5hlhM0ULHm/7lebVJyGjxFtRouH/j4JAQcXARs1pEzy4kHgGEnY/0d7oIpID+ZGoaMaOPwTzHiFHim+bV/YTKmqlu+MQK+sLCf/ELMWnyY8PnwGloESByzkdBEDsADpD3A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788868707; c=relaxed/relaxed;
	bh=a9ldav0mNmhl29cjdGzHHjkJJsG0TOXcYMScLmyKn3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QSb5PgInzYwihfQtxc/ws8y22c8HJPMmx207clm/8OPGhLVcpYDgUU+6DckhlikpGajYBjx77mGhLAkWJhbikwOYm0ZO1F15zRaVRBN2uokgjIkvvYv4+kbn5A7lhnsu3IQNkRhwFBgImgp36gC0yqIw+JgZvPzPydHoP/y1spwtNtMjKhiP4Km6Xgw3V3gIA3elSU34Dhvwm/8NdlgeKHhAfNAAmzp9I2sZLnD6a94+aln5fbsiAtEVZhvht7OQFpE7OuJiaFuwrCnL3b3Ehj0z5Jj2/ke8m5Kqh+PAf5t9sKMEBqa8zrBm52tlK3DeCWuaIWTXhgi8RENjGvi1Ig==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bg3Jzwm+; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bg3Jzwm+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfMsG68SBz2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 21:58:26 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C45CB41072;
	Tue,  8 Sep 2026 11:58:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A9F1F00A3A;
	Tue,  8 Sep 2026 11:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788868703;
	bh=a9ldav0mNmhl29cjdGzHHjkJJsG0TOXcYMScLmyKn3Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Bg3Jzwm+WwX80LbfYYNnzePcfW3SqAOF3bqfIR/XU64eAqMbfO3v3zTBfrmrEEZRv
	 0z781IgyJBmmjQUNs4nNW55whr57tMRWqdhNduTsxaedqm+MVF5YgIoivyCsqHmtwD
	 14zhm0hMr70SaWlbX0B9C02QOWjZu2dSjRkxKo77ybjV9A/+LXRRBkxoi0u55I+JqN
	 qqMQylifwCl+akjGyxyQYTjut8sifEY+pPISW4zdfKH5iEVQ46DBebQjvxcDqWU6wl
	 H9VmFBjtajmSxuJAZ+CqHafHfF3p4UDSm+GsV8Avrq64wmUZu2mvAVPIthKL8B7xCs
	 a7Y7Hjn9xpFDQ==
Message-ID: <40845ad0-e321-4e1b-860d-ff798f430c42@kernel.org>
Date: Tue, 8 Sep 2026 13:58:18 +0200
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: fsl: qe: drop GPIOD_FLAGS_BIT_NONEXCLUSIVE
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bartosz Golaszewski <brgl@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Qiang Zhao <qiang.zhao@nxp.com>, Linus Walleij <linusw@kernel.org>,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-gpio@vger.kernel.org
References: <20260908-usb-fhci-drop-gpio-nonexclusive-v1-1-8e405dc67874@oss.qualcomm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260908-usb-fhci-drop-gpio-nonexclusive-v1-1-8e405dc67874@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Le 08/09/2026 à 11:27, Bartosz Golaszewski a écrit :
> The GPIOD_FLAGS_BIT_NONEXCLUSIVE flag for gpiod_get() is deprecated. For
> actually shared GPIOs, it should be replaced by using the functionality
> provided by gpio-shared-proxy. The Freescale QUICC Engine GPIO driver
> uses it as a workaround to access the GPIO descriptor already requested
> by the caller of qe_pin_request() in order to access the private GPIO
> chip data.
> 
> As the existing comment itself states, the user already requested this
> GPIO and the only user in tree is the FHCI USB driver which does in fact
> request it, we can safely modify the function to take the *exclusive*
> GPIO descriptor as argument and stop using the deprecated flag.

This change seems sensible. I will take it via soc/fsl tree unless you 
have other plans.

Greg, can you ack the change to drivers/usb/host/fhci-hcd.c ?

Thanks
Christophe


> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
>   drivers/soc/fsl/qe/gpio.c   | 29 +++++++----------------------
>   drivers/usb/host/fhci-hcd.c |  2 +-
>   include/soc/fsl/qe/qe.h     |  6 ++++--
>   3 files changed, 12 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/soc/fsl/qe/gpio.c b/drivers/soc/fsl/qe/gpio.c
> index 5cd59cfbf22fa68d39ad00b8f73ad389ac8860a3..5a3a1d5df669b1e0a084a0ebfd2aef91e15f126e 100644
> --- a/drivers/soc/fsl/qe/gpio.c
> +++ b/drivers/soc/fsl/qe/gpio.c
> @@ -196,18 +196,17 @@ struct qe_pin {
>   /**
>    * qe_pin_request - Request a QE pin
>    * @dev:	device to get the pin from
> - * @index:	index of the pin in the device tree
> + * @gpiod:	GPIO descriptor associated with this pin
>    * Context:	non-atomic
>    *
>    * This function return qe_pin so that you could use it with the rest of
>    * the QE Pin Multiplexing API.
>    */
> -struct qe_pin *qe_pin_request(struct device *dev, int index)
> +struct qe_pin *qe_pin_request(struct device *dev, struct gpio_desc *gpiod)
>   {
> +	struct gpio_device *gdev;
>   	struct qe_pin *qe_pin;
>   	struct gpio_chip *gc;
> -	struct gpio_desc *gpiod;
> -	int gpio_num;
>   	int err;
>   
>   	qe_pin = kzalloc_obj(*qe_pin);
> @@ -216,34 +215,20 @@ struct qe_pin *qe_pin_request(struct device *dev, int index)
>   		return ERR_PTR(-ENOMEM);
>   	}
>   
> -	/*
> -	 * Request gpio as nonexclusive as it was likely reserved by the
> -	 * caller, and we are not planning on controlling it, we only need
> -	 * the descriptor to the to the gpio chip structure.
> -	 */
> -	gpiod = gpiod_get_index(dev, NULL, index,
> -			        GPIOD_ASIS | GPIOD_FLAGS_BIT_NONEXCLUSIVE);
> -	err = PTR_ERR_OR_ZERO(gpiod);
> -	if (err)
> -		goto err0;
> -
> -	gc = gpiod_to_chip(gpiod);
> -	gpio_num = desc_to_gpio(gpiod);
> -	/* We no longer need this descriptor */
> -	gpiod_put(gpiod);
> -
> -	if (WARN_ON(!gc)) {
> +	gdev = gpiod_to_gpio_device(gpiod);
> +	if (WARN_ON(!gdev)) {
>   		err = -ENODEV;
>   		goto err0;
>   	}
>   
> +	gc = gpio_device_get_chip(gdev);
>   	qe_pin->controller = gpiochip_get_data(gc);
>   	/*
>   	 * FIXME: this gets the local offset on the gpio_chip so that the driver
>   	 * can manipulate pin control settings through its custom API. The real
>   	 * solution is to create a real pin control driver for this.
>   	 */
> -	qe_pin->num = gpio_num - gc->base;
> +	qe_pin->num = desc_to_gpio(gpiod) - gc->base;
>   
>   	if (!fwnode_device_is_compatible(gc->fwnode, "fsl,mpc8323-qe-pario-bank")) {
>   		dev_dbg(dev, "%s: tried to get a non-qe pin\n", __func__);
> diff --git a/drivers/usb/host/fhci-hcd.c b/drivers/usb/host/fhci-hcd.c
> index 71e785f445a30e116a9cb421d417deaf24389174..d572f0c1dffaf3a40b2fe4326ba8ab021fefb986 100644
> --- a/drivers/usb/host/fhci-hcd.c
> +++ b/drivers/usb/host/fhci-hcd.c
> @@ -643,7 +643,7 @@ static int of_fhci_probe(struct platform_device *ofdev)
>   	}
>   
>   	for (j = 0; j < NUM_PINS; j++) {
> -		fhci->pins[j] = qe_pin_request(dev, j);
> +		fhci->pins[j] = qe_pin_request(dev, fhci->gpiods[j]);
>   		if (IS_ERR(fhci->pins[j])) {
>   			ret = PTR_ERR(fhci->pins[j]);
>   			dev_err(dev, "can't get pin %d: %d\n", j, ret);
> diff --git a/include/soc/fsl/qe/qe.h b/include/soc/fsl/qe/qe.h
> index 8f967d15e479792219333264c2a463d26e5edae9..7f0e4165c3b0cafdf401be20862aa1bf28047102 100644
> --- a/include/soc/fsl/qe/qe.h
> +++ b/include/soc/fsl/qe/qe.h
> @@ -24,6 +24,7 @@
>   #include <linux/types.h>
>   
>   struct device;
> +struct gpio_desc;
>   
>   #define QE_NUM_OF_SNUM	256	/* There are 256 serial number in QE */
>   #define QE_NUM_OF_BRGS	16
> @@ -193,12 +194,13 @@ static inline int par_io_data_set(u8 port, u8 pin, u8 val) { return -ENOSYS; }
>    */
>   struct qe_pin;
>   #ifdef CONFIG_QE_GPIO
> -extern struct qe_pin *qe_pin_request(struct device *dev, int index);
> +extern struct qe_pin *qe_pin_request(struct device *dev, struct gpio_desc *gpiod);
>   extern void qe_pin_free(struct qe_pin *qe_pin);
>   extern void qe_pin_set_gpio(struct qe_pin *qe_pin);
>   extern void qe_pin_set_dedicated(struct qe_pin *pin);
>   #else
> -static inline struct qe_pin *qe_pin_request(struct device *dev, int index)
> +static inline struct qe_pin *
> +qe_pin_request(struct device *dev, struct gpio_desc *gpiod)
>   {
>   	return ERR_PTR(-ENOSYS);
>   }
> 
> ---
> base-commit: af5f12805e5cefa4fe68d6127c7e1fb78cd5535c
> change-id: 20260907-usb-fhci-drop-gpio-nonexclusive-584c5c808a30
> 
> Best regards,


