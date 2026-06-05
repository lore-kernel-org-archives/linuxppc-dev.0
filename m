Return-Path: <linuxppc-dev+bounces-22116-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6A13CD6E74
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 08:00:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWv4p4DgKz2xdb;
	Fri, 05 Jun 2026 18:00:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780642677;
	cv=none; b=W2zuLfT1E8vJjTiqaAIz8bsJoeppKWR9BKifA/4FYVBjcKQ7qL7YRRN6btXUZG9ie3ZzJp9f5fW7rNXEc4Yr/AbismWFR7jBiQQO0NScsy5cm3MVmXppEsJ9emR48ebIfwHCLoaY5A6oXfBi6NUOXHUNIS7S+JG7W3wv2+m1BNw7KBgOZAXH0XpjrtYiHPNKt15acJ5/9UNp//ifPogOIGxGlONcxV+HTBjIk2vryYGDvcO6SgexbXVwmRaoMh8ld2QuQwDsghyEy3iU3ZEzepQZbVL/JQIYAvpmdzpyfDukHRO0a63CP0uRtCqH0TQ8C3vxjdwVeZ0RxZ+9JfNXHg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780642677; c=relaxed/relaxed;
	bh=BJCqjGZjxCRgfxUH2j/CppVrqM78Z0uQcR61FLvFq08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3d4ERxyQmNZRnP/FsPydVWNLWERrhdDyeQgUGAzX5h15wKULi+CvIWPnVQ8a/ohrMAcaXDnTOFH7wHhspmhb8741ga0ddSPJhL7sFufo0fIIpiCVKVAE11mok5WkHdJWWCbc7d9OptumLo2X1gINmYnkcSogi4lXXp0gw4TPSFk/uA/LlJJO3Sp3vSnBjXsbhTxQ8MFKADLZAqed/JyzL5wnTO/USBJMB03v5ekjBTXn08LJFyJS5NdM/PkMWVXCsMmSLMBBtRIY1ygyYpcYxiwqo/X0BYgTU5XbLf/67U7h1mtTgR/SUH+hLo4qrRok7asARxZGdSiLB7/lGISow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hZ60LSkV; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=peter.chen@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hZ60LSkV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=peter.chen@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWshM6nNCz2xMW
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 16:57:55 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A964643FBA;
	Fri,  5 Jun 2026 06:57:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9111F00893;
	Fri,  5 Jun 2026 06:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780642671;
	bh=BJCqjGZjxCRgfxUH2j/CppVrqM78Z0uQcR61FLvFq08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hZ60LSkVDV8X+4SLpgVyE09RWCnA2kxYN3wc50iNP0KU1YmCADiZqHDz5UD/xC3PL
	 zmmx5OU2VeEkVn4dssnmg1iC2vCjT1FTHe5IUPRgCs1R4dOVaKgCVXeK00grRbf0Jb
	 JlnsJZkD8TFQNRFgShMoIRkVPUQbPRhdXmqdd/np2n2e8RQKRIrnIw4u0L2j7V/4YH
	 RdPWfwWrgxiwoHLP2d+wWS7ttIUiMqDS8EPPtT9w4/rY7Eu8DPXo+0qdCAru7e6ihV
	 U119rcBv1FSw+NPtZb1v92zS2tdDraiE2NeoTcuJUK/eE4EbMvWaY1c0OTVTtYkgcc
	 vXTlMfvMqdYXQ==
Date: Fri, 5 Jun 2026 14:57:39 +0800
From: "Peter Chen (CIX)" <peter.chen@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Lee Jones <lee@kernel.org>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vinod Koul <vkoul@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, brgl@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
	driver-core@lists.linux.dev, devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
	iommu@lists.linux.dev, linux-pm@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-usb@vger.kernel.org, linux-mips@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 20/23] usb: chipidea: use
 platform_device_set_of_node_from_dev()
Message-ID: <aiJzY52n2rQ84ppZ@nchen-desktop>
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
 <20260521-pdev-fwnode-ref-v1-20-88c324a1b8d2@oss.qualcomm.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260521-pdev-fwnode-ref-v1-20-88c324a1b8d2@oss.qualcomm.com>

On 26-05-21 10:36:43, Bartosz Golaszewski wrote:
> Ahead of reworking the reference counting logic for platform devices,
> encapsulate the assignment of the OF node from another device for
> dynamically allocated platform devices with the provided helper.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Acked-by: Peter Chen <peter.chen@kernel.org>

Peter
> ---
>  drivers/usb/chipidea/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
> index 7cfabb04a4fb80c6db56ccb430d290dbac61b716..5dd415f42fe0dd026e8a1cc162357e42ba8ceaec 100644
> --- a/drivers/usb/chipidea/core.c
> +++ b/drivers/usb/chipidea/core.c
> @@ -888,7 +888,7 @@ struct platform_device *ci_hdrc_add_device(struct device *dev,
>  	}
>  
>  	pdev->dev.parent = dev;
> -	device_set_of_node_from_dev(&pdev->dev, dev);
> +	platform_device_set_of_node_from_dev(pdev, dev);
>  
>  	ret = platform_device_add_resources(pdev, res, nres);
>  	if (ret)
> 
> -- 
> 2.47.3
> 

-- 

Best regards,
Peter

