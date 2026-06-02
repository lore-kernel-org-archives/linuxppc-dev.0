Return-Path: <linuxppc-dev+bounces-21927-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD06CD5BD1
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 21:53:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVPhp32p9z2xRs;
	Wed, 03 Jun 2026 07:53:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780437194;
	cv=none; b=VkNQCZjAF+y3EOb+ujjJPZpI1CTBqMORILJz6pJGqzZkrkCVDiBNF5iXsiCgr4m2AHNImLqS+5HrewClp3wanTAIrCA+SyjqQS/aS0eEFKuL/6VO+nwSiLaIpIPq1wmsUStpiVX2bsxG8m2sje15Up6D43IiUGr2dGAGiFj1pnQstmm4GHxifhCDLdblBHUaxmxYejPES9XGoyYB/EZy9C1KzpObZLVrTN1iLfKYp9PLC/PhIIUSllJWi3YpQg/wFRtspfV3t2I3+ZQjZBYKvCgiiwoyBw+f2qK3ifzYBnRww+8sgXAB5SfUluESxm7YdKYvpxZy2YBQ+t410yQmnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780437194; c=relaxed/relaxed;
	bh=rAcnmSoQfQEIHH4dt0wFm47EyDqd8YMJ5BxWBIR0S+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SA7pYNZ0Oazu0aGldtW++JRf3KOdkI/BBktSJJgZHsRSd6uhJFkYQ67+AxG6gtJpHtWacMz0mM4/wP82q5H17HiYWmS9CLYNozYevPnNW98iZt6KISynceQKJi2oDGCphj22VlfNppM9TN3Pio7U71Sl95Bjqn/b2x7xrxwzEFXKmvZ+xqjq8cmNtFa6ntlSyY3OPkfEk015doB0ijbhlNS3zazRlVxMpxFCqSAzkbUI8IVlHDCp7/QQ5CFBwo0RvL1HsP1i32hmAXXhWymyqA97WI8kZdpNyhJXSI0FBVToe58LV9x5A/AVfKk3tCQZo1UL1vlTdAmTXm7iO97OdQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KtNHrXSH; dkim-atps=neutral; spf=pass (client-ip=198.175.65.21; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KtNHrXSH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.21; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVPhn12YBz2xLk
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 07:53:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780437194; x=1811973194;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U2Ci0y5zstQSqkf04hmNdjkbNsyqDpkboO1KnVKRMOs=;
  b=KtNHrXSHFKxx47fLEHjhiCw53eZ91R+EqlGHLL2qvytQoqmEjqo715oV
   N/Ks8YpNRITeIZyRgnRxd32xnSDbpMvkBhDJmckjnkTrMoz5RW5tEcuVC
   8vizP/sxBmlk8btCcjUjCn5NBMJ5TNVxpOeXyq9CslVRA9ZLGQamIVFwP
   4Myf4NU84aH3SyH4IRk6mdcyJA7ogHzAJTX3qdvc+qIkjp4ZtG8DPfe/J
   w2jdum/ZwH74hmecYoqVJPrtAkYJOyIuQGYGp3aliiQGEtZMHoimGPskX
   HEk0iZ1u4IWlXlix5KkOhIK4QGJqh4cT7Rh0o0HSIEQ+V6/yPa3YKJ5jo
   A==;
X-CSE-ConnectionGUID: Z0ECVimMQn21O8Dz17Am4A==
X-CSE-MsgGUID: VcGT4Hk2Qee56WIghy/VgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81139233"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="81139233"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 14:53:09 -0700
X-CSE-ConnectionGUID: YYc13f2oRhu39dVGUvMdoA==
X-CSE-MsgGUID: IznHTBKXQ4W8nlCW1v1K1g==
X-ExtLoop1: 1
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.116])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 14:52:54 -0700
Date: Wed, 3 Jun 2026 00:52:52 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Lee Jones <lee@kernel.org>,
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
Subject: Re: [PATCH 22/23] reset: rzg2l: use
 platform_device_set_of_node_from_dev()
Message-ID: <ah9QtExF2rUUTMNo@ashevche-desk.local>
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
 <20260521-pdev-fwnode-ref-v1-22-88c324a1b8d2@oss.qualcomm.com>
 <6af284545729f03a60d06479339862a2f08c6b7e.camel@pengutronix.de>
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
In-Reply-To: <6af284545729f03a60d06479339862a2f08c6b7e.camel@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 02, 2026 at 10:24:41AM +0200, Philipp Zabel wrote:
> On Do, 2026-05-21 at 10:36 +0200, Bartosz Golaszewski wrote:
> > Ahead of reworking the reference counting logic for platform devices,
> > encapsulate the assignment of the OF node from another device for
> > dynamically allocated platform devices with the provided helper.

...

> > -	device_set_of_node_from_dev(&vdev->dev, dev);
> > +	platform_device_set_of_node_from_dev(vdev, dev);

Same Q here, why it uses inherited call? Cargo cult?

'reused' flag is solely pin control (provider!) thingy as far as I remember.

-- 
With Best Regards,
Andy Shevchenko



