Return-Path: <linuxppc-dev+bounces-21922-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2938CD5BD1
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 21:40:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVPQD1QB3z2xRs;
	Wed, 03 Jun 2026 07:40:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780436436;
	cv=none; b=UYZ8DbTHkUJMVRQ5Yzt2f9gMu97P8ZMDpP7hTXpWUs87MedNUhGBRCqmUOWE2OKvPNCzLmiJFnf5eTakOTe7dbt/UYT0St3HbVvABCPOiaq65KxubvkwzyGGLUfNwK7Q1aWBAwmBmMFY4PSlDEaiVgvp8S17dSACSJhRwHx2KGULGF6jwoQ6csut9ruDYrcGc44P0Eusmbui2lSn08vlJHRFmJbCYwq1scdUSnNmauihnnmS7gs0D3SdU5rmv98nO4Gn92zQOcpCK7cMkMHbXt1Q8CUoa67vIsCNmp8US8Gbtd4WeNvAOqhHRGf+KvUdGfLePwmBljd51+WtBtMEMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780436436; c=relaxed/relaxed;
	bh=LRZJ6jjfC9VZo6BqoEDVxdoH2wj+fGDNo+6ujgGEipM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NILuKwknJiWNsAY5crcHXJkQkBmIwRapbA7Hrl2S54avNVkZGsFKmnGLf9kKjKSTxklZclaqfRrOUB5vVQ4Zp40D2obKGI9EOyPqjLsos5R8FhPGhPCGnZQfMibQy1+ELneDn08ZzIAtOGZkRekeBpcN8XP4Xoam85I4guzrMKDk6RmaJI7semy5u015J30EA6Q5nApRTuTK1bidtY60lCnjH4VY7q3uy6xgu74oWW4IJoHteC6W32l0lvcPbbtSixy6kqzPSpfvXrFuh+IEVrJ9mZKU8Fw+p8qOdvQbj1gW2OGBT5UrYLkqLdesPL8+gTqTJGSK8tnIvMC22lZjgA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TtM2EgJT; dkim-atps=neutral; spf=pass (client-ip=198.175.65.20; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TtM2EgJT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.20; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVPQ81NjJz2xLk
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 07:40:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780436433; x=1811972433;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4eyZw4UOnHhwv4cFQ/JjHG+RrOIvOOmydNLwutjD+3M=;
  b=TtM2EgJTjFXCRWk7mEgzpGGLE3wojqbw3eRbCR7kJFAHMjkG5JBa7sSt
   yJzRI3MZM9ogC5nUbrafNMWGV8NAQeKrpmv3XPRWamvIPsIqVnOJjZVz3
   p5r2SoSoxFtbwVslWSms/vOtgVEZntHP85vRCSVC9/2CFUZHBJMaAPp1I
   8yknWFJLBa2gLlRYjicQn8+d8A9ab8LY2GX26Ctvb1kZZgSgydmqYBenL
   xVWixLRd+0c+BpUlM1dbet3Tgs9xV/lybT+e6moMebf+XIEWbLOCLvH1T
   8I5Yuvn+DBdLmlM9fm4kZFH4Q4t4scYE5NDIn1GRcKfd9nObJBC7WRuJL
   w==;
X-CSE-ConnectionGUID: 5U553GEfQz+C7GzW/3CJUg==
X-CSE-MsgGUID: TNlQiBYrR6y+CobQ0rN9iA==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="80972414"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="80972414"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 14:40:24 -0700
X-CSE-ConnectionGUID: PcIQbEzqTbKa1yc0yhfIOQ==
X-CSE-MsgGUID: nO91ZzCfR2qu25nrSJCLRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="239575909"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.116])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 14:40:11 -0700
Date: Wed, 3 Jun 2026 00:40:08 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
	Andi Shyti <andi.shyti@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Peter Chen <peter.chen@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
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
Subject: Re: [PATCH 06/23] driver core: platform: provide
 platform_device_set_of_node()
Message-ID: <ah9NXwJFrkK_yuw8@ashevche-desk.local>
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
 <20260521-pdev-fwnode-ref-v1-6-88c324a1b8d2@oss.qualcomm.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521-pdev-fwnode-ref-v1-6-88c324a1b8d2@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, May 21, 2026 at 10:36:29AM +0200, Bartosz Golaszewski wrote:
> Encapsulate the reference counting logic for OF nodes assigned to
> platform devices created with platform_device_alloc() in a helper
> function. Make the kerneldoc state that this is the proper interface for
> assigning OF nodes to dynamically allocated platform devices. This will
> allow us to switch to counting the references of the device's firmware
> nodes, not only the OF nodes.

...

> +/**
> + * platform_device_set_of_node - assign an OF node to device
> + * @pdev: platform device to add the node for
> + * @np: new device node
> + *
> + * Assign an OF node to this platform device. Internally keep track of the
> + * reference count. Devices created with platform_device_alloc() must use this
> + * function instead of assigning the node manually.
> + */
> +void platform_device_set_of_node(struct platform_device *pdev,
> +				 struct device_node *np)

Why not fwnode to begin with?

> +{
> +	of_node_put(pdev->dev.of_node);

And if it has an fwnode?

> +	pdev->dev.of_node = of_node_get(np);
> +	pdev->dev.fwnode = of_fwnode_handle(np);

This looks like

	device_set_node(&pdev->dev, fwnode_handle_get(...));

> +}

-- 
With Best Regards,
Andy Shevchenko



