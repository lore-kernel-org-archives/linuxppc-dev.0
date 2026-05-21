Return-Path: <linuxppc-dev+bounces-21315-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B0A7CD5BA4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2026 09:52:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLkH66T7pz2xS2;
	Thu, 21 May 2026 19:52:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779357170;
	cv=none; b=BNqwxHUaenE2JoiOKyawuXhvJBMwwiAlFzqrjMnUBpi68MKrxTH4TXrxJRZHPNOFCCS46D7sySc0uB0NDEof/AU+U5fSnq0o05Uv6GVQu5dOfYH4k616T+eas5NTUYnEoz6EO3SK9e5FBwaQBwYKAIijUZCsBwpQwWFg2OJfkyuz5haTuVrbdSaVVCZCGJiE/wK14yB7Ywk+y8dtj0p45IX0XbP0qFkutSWJpCTKQvl/zQ6u/7Ls2RcSlggoovjEa5/z5IHFlZcj1s9VsM1valTXMwls19PaYtrD1oo49txTJM5JMxz82Zd4kq87mB2cWPEPLMqB3Hv0/yuSGV3I8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779357170; c=relaxed/relaxed;
	bh=B5IOccikIlTvo4+Zuq7g+PZgMZsk+LjCF5D/PC5PItI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DmI5KibDJfS3YVPriNfu5LzBvXHNgWo1viUyc6m4WC9+DRsTh2yJZNUxnSfHbKls5qga3AupEiXT0diJvfBUKZ7EVAwYUEMwqQdG3axzmL4hlmDXrpBplsXIIYbogjbtzZNd4L7sTmWdVvJ43uxjqf0AKQy1UdV0MuT05fC6jUj0YYWTBejRH9AVyrVawd/zGfFf+/6foVq+4t96zAq2eI+JnFpO4BPh+y0vJTbmBXapJSzfXUfGnFKpY+Q3mt3X6k5EzG56j5OwSKOoLb79I8wNeFICErVfnwLBH43pgvFo1APvgPWCR5r2t8XeJ/vlwokctGGOS2yTPVwaHkjsVA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=V8bj1nfh; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=robin.murphy@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=V8bj1nfh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=robin.murphy@arm.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 444 seconds by postgrey-1.37 at boromir; Thu, 21 May 2026 19:52:48 AEST
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLkH43FxLz2xGY
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 19:52:47 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EB8E35FA;
	Thu, 21 May 2026 02:44:44 -0700 (PDT)
Received: from [10.57.36.52] (unknown [10.57.36.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 339163F7B4;
	Thu, 21 May 2026 02:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779356689; bh=2rSja1deBM1iWbRkxcvTnfwNvq3KSkNDXw0R+RFBDSE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=V8bj1nfhEwDhWcowxYHmM7Xnhl5rgFZyeqahTQ0ZRV9mLcDf3Ozjm5MGzpI+c1910
	 XJnMbe6wjO4t7P/70yn6macR20HahHT1WyAarLF6Wb7rYAgJ6Mt3h0WXN9SXMbK7F5
	 uXAKXzo6njxuRMgh1oQmzIpBuzaBPmmeqI3TXRP8=
Message-ID: <ddc7098e-5674-4f40-a46b-776c5334bda0@arm.com>
Date: Thu, 21 May 2026 10:44:24 +0100
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
Subject: Re: [PATCH 12/23] iommu/fsl: use platform_device_set_of_node()
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Lee Jones <lee@kernel.org>, Mark Brown
 <broonie@opensource.wolfsonmicro.com>,
 Thierry Reding <thierry.reding@avionic-design.de>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Srinivas Kandagatla <srini@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Vinod Koul <vkoul@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Andi Shyti <andi.shyti@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Doug Berger <opendmb@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ulf Hansson <ulfh@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Peter Chen <peter.chen@kernel.org>,
 Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: brgl@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
 driver-core@lists.linux.dev, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org,
 linux-mips@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
 <20260521-pdev-fwnode-ref-v1-12-88c324a1b8d2@oss.qualcomm.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260521-pdev-fwnode-ref-v1-12-88c324a1b8d2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-05-21 9:36 am, Bartosz Golaszewski wrote:
> Ahead of reworking the reference counting logic for platform devices,
> encapsulate the assignment of the OF node for dynamically allocated
> platform devices with the provided helper.

FWIW,

Acked-by: Robin Murphy <robin.murphy@arm.com>

Although I'm not sure the whole lot couldn't just be replaced with 
of_platform_device_create(), but then frankly this driver is on life 
support anyway as it only serves one very niche VFIO use-case and it's 
not clear whether it has any real mainline users left.

> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
>   drivers/iommu/fsl_pamu.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
> index 25aa477a95a95cb4fa4e132727cde0a936750ee2..012839fa0d8a27cafc6a441373f4f6da794388c1 100644
> --- a/drivers/iommu/fsl_pamu.c
> +++ b/drivers/iommu/fsl_pamu.c
> @@ -973,7 +973,8 @@ static __init int fsl_pamu_init(void)
>   		ret = -ENOMEM;
>   		goto error_device_alloc;
>   	}
> -	pdev->dev.of_node = of_node_get(np);
> +
> +	platform_device_set_of_node(pdev, np);
>   
>   	ret = pamu_domain_init();
>   	if (ret)
> @@ -985,12 +986,10 @@ static __init int fsl_pamu_init(void)
>   		goto error_device_add;
>   	}
>   
> +	of_node_put(np);
>   	return 0;
>   
>   error_device_add:
> -	of_node_put(pdev->dev.of_node);
> -	pdev->dev.of_node = NULL;
> -
>   	platform_device_put(pdev);
>   
>   error_device_alloc:
> 


