Return-Path: <linuxppc-dev+bounces-21925-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E6EDCD5BD1
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 21:49:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVPcw5sTsz2xRs;
	Wed, 03 Jun 2026 07:49:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780436992;
	cv=none; b=NDyBy4M4epSs0M8ZcyTY0YEI0Lr56TcH9N+pXZ+LGU7Uh/DjXGz5ZpZ3rxj5ZJD4ZZTHyFKn2Y+r9E4MCYmjKTzFJSSEqB8thnXkUwQlGgIZwiUOqFXttoK1YwZhFPuHCFUdqFr9L73hzxcvuJulCHxmCFzz9v4urTnEJH04YaYWJazVdE08t+0YGSnMB3PSIiIGJa0qP1k1ljhcie4MpcXgeXsaVPdn+VGzYGpOu5FRkJ3sHUbnvdUr/iN6T9gsllClMcvMYbDyD4xmAIHoaevXKydtNvaCRas8VOMHy6q8em1NEiaRojEguAndCq9iS1x5Dny8gGDUAZwQNuG6Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780436992; c=relaxed/relaxed;
	bh=Q7FEBL+eDvQpraBwVClgrqfZTbTmLUuheVlSQywbcCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zm4SeoeplXnUecm5HB3xkielWcmh+G7r0wTSkT5hoYNvIfq8BYe2cNwKkmskpxmeqwvMNfHSwZc0XtATa328yoihmeaqnsDhTnn+43A2vnPVKgK3oUhhy1OsybY+fAX8CO7IHIuNjZxd5c32bnNp6ZV30tD1GYcwWSbR/rMPyDnOpP9g/KbuB+5H/w7ddC9SpQmCCCjAxUd6P3rS2arpTwK6S1ulQR1XJEp+TgF9asn6rhTiWu+N5oNPyNB15sbk5X4ltFUxo5b4gAkDIuQura/L5dLF6PANXCTh/h9cLR5Gvgxke7TJNdyuuY60akNRHqJnT4rbxT/hb2BG8pLxzw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Gui3vCxW; dkim-atps=neutral; spf=pass (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Gui3vCxW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVPcv29gKz2xLk
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 07:49:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780436991; x=1811972991;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DboyAh7hWgXk9QBiKXaDmMfe0ehQqRfCBx9xSYKHzj0=;
  b=Gui3vCxWLESeG+CiXanUoxRsbi1wxrWrgI3nzOhf5zhqZYZUHxonz2ri
   a/6w64wugSOuyN+Is3edHd37yOlqJjTBo+eTaonYF1nZmc4xqmTP+t2bu
   xbKLh9bkoBtxcNjxUvV4F6+gLbvLkqGET07wnwC9buTUlxKMbEmG1QnZN
   0RiobCBmTt9bgykttIgJNGciUscUWWCShqVduQ3iJQ1q3EGVJ1EmNVj6s
   b7XPe3fiptX26QOBphCd2Xu827Xatx8on/ZtpGPRCl6RD4Q2AtwUL10PQ
   Hf9Uzo9X22XA/kpwzTbdJ5IjDjT/AwXW8Jhp7o7rHSQrVO/YEbwCB4h5V
   A==;
X-CSE-ConnectionGUID: vgfFcCNpRn69hUbe4VWj8Q==
X-CSE-MsgGUID: MJ0O/FCFS1qpVaQjnu/6sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="91920904"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="91920904"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 14:49:47 -0700
X-CSE-ConnectionGUID: Y7ZlRnYdR3W1ACBKWyPdDA==
X-CSE-MsgGUID: FAoy/eX/QYGVu9RU3sO6Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="248950576"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.116])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 14:49:33 -0700
Date: Wed, 3 Jun 2026 00:49:29 +0300
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
Subject: Re: [PATCH 20/23] usb: chipidea: use
 platform_device_set_of_node_from_dev()
Message-ID: <ah9P6Xt9SyKgc2oJ@ashevche-desk.local>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521-pdev-fwnode-ref-v1-20-88c324a1b8d2@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, May 21, 2026 at 10:36:43AM +0200, Bartosz Golaszewski wrote:
> Ahead of reworking the reference counting logic for platform devices,
> encapsulate the assignment of the OF node from another device for
> dynamically allocated platform devices with the provided helper.

...

>  	pdev->dev.parent = dev;
> -	device_set_of_node_from_dev(&pdev->dev, dev);
> +	platform_device_set_of_node_from_dev(pdev, dev);

Why do they even do that? Do they have a USB connected pin control?

-- 
With Best Regards,
Andy Shevchenko



