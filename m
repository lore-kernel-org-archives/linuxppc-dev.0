Return-Path: <linuxppc-dev+bounces-22109-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9114ECD6E74
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 07:32:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWtRy28Ztz2yR5;
	Fri, 05 Jun 2026 17:32:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780644734;
	cv=none; b=YUNWK7XdOzAVEORlBhGE1w2uS/34kYtoah1IhUKezsq7in4TuSxtel56Uto73AtZRj+ksr8THeqOEhPN/pS0NAp2CKw+r86iI6lWS7Bl8FoHjSqQDOHTe5C98eqI/Q7AaDjGb+xmPzdqN3jQZX51EXpzr2bSOq4ldx2mRAsQbXHFpzvkxrTc4eyoBcmQw/QBQpZMjG4REXYAmy59PKCUHH4gxtmB4ReiMMWA39x/pk0CDrxnJ2VuYItl/YU+sdgBmjOvEbVBx1wUHAQlR+Rlti5QTHAj5RIiVija5Kixv8+EJpC2AIosbZ9cgoG7oM2FL0alsMgQyOCGhp2gE8wcMg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780644734; c=relaxed/relaxed;
	bh=sIiuR/e1ev9wCB772nA3Hxgw0IeY90JsT8siiqW4vek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWIS0+5jYzb2vXbr0Ei+qP+aSc85iyBxIAb2iJ2iMZBbcLKghC1OegNWULxY2MNfUV2Ug6Un+OEr9cQ7qJXK59h3OfbWqZHnYKrue3rWGHuc6exPjT+ZZoitIfaiSjkfTOReLjZ7XAe0hf/xBpmjcmN0+WP7YyXG1PV/8V0RTaibPmGQTRD+dQAWBvBQSBhBJvt20nR3MgRBKUVUXcj1j48GDcgUW2Zl5kyr1Up8VpArvVb2ovtEKCAhPznwhLf2MlCKAGaxcP5lYIAG9DG0z8RssAY3HQhhCX6kLcJGbg7M5dBJlIC6vk3hQaHRZdmtNKz9f5he+qLSnayDgxoqPw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Sj1vcjY8; dkim-atps=neutral; spf=pass (client-ip=192.198.163.16; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Sj1vcjY8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.16; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWtRv1dngz2xnK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 17:32:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780644732; x=1812180732;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c30wbulhkBn1BOKZ95h66WcDcHsR2Lig8B6kzzR9otg=;
  b=Sj1vcjY8npSaOzB0Qj1LtGh7dKfUjh+t3ntcmaEZon8gDQWPWTovzv3j
   r2QQMWNnYCKIbL50v/r2ple0152nsUsYci/CnU7BziLxEsQphGbmNeTC2
   d9edvq7TolvF0lKFM4PK9FiRLwGKwnfKfD+Z4CKNXypCEWDQzgiv/gh9O
   eEtwcUzAC5IXEiDOni6FZO/KEDk141IbDtaucuvWKqAX0SWxwkPPCeD7M
   HzjGU7u2FuiFOinRwxm6PvvPA9MVsRnv/gCqNiAjzSCLjeGNeCc5tAdCG
   pXBT2NiLypXtFpJ2pNO+JTDWLNLYfqnbvSmr4h0TRgQx/QpiPImFmE1iV
   A==;
X-CSE-ConnectionGUID: JTkawUETSfyDUA/QqodXNQ==
X-CSE-MsgGUID: pgz3eUWJTgGOKwrv53rHLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="69012004"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="69012004"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 00:32:05 -0700
X-CSE-ConnectionGUID: dgmCPLzkTKmMjNLLI2/dBg==
X-CSE-MsgGUID: q1Bd7HPvQi+WKekTT+SBKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="249704712"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.178])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 00:31:50 -0700
Date: Fri, 5 Jun 2026 10:31:48 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Peter Chen (CIX)" <peter.chen@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Lee Jones <lee@kernel.org>,
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
	Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
	driver-core@lists.linux.dev, devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
	iommu@lists.linux.dev, linux-pm@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-usb@vger.kernel.org, linux-mips@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH 20/23] usb: chipidea: use
 platform_device_set_of_node_from_dev()
Message-ID: <aiJ7ZB-J-TyJEwBb@ashevche-desk.local>
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
 <20260521-pdev-fwnode-ref-v1-20-88c324a1b8d2@oss.qualcomm.com>
 <ah9P6Xt9SyKgc2oJ@ashevche-desk.local>
 <CAMRc=MdhjZhGL9tEx9WEjn2f95d=ObNM0AtBNpcevm6aHgpj+Q@mail.gmail.com>
 <aiJz6Ys4gE998ULp@nchen-desktop>
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
In-Reply-To: <aiJz6Ys4gE998ULp@nchen-desktop>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jun 05, 2026 at 02:59:53PM +0800, Peter Chen (CIX) wrote:
> On 26-06-04 08:34:16, Bartosz Golaszewski wrote:
> > On Tue, 2 Jun 2026 23:49:29 +0200, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> said:
> > > On Thu, May 21, 2026 at 10:36:43AM +0200, Bartosz Golaszewski wrote:

...

> > >>  	pdev->dev.parent = dev;
> > >> -	device_set_of_node_from_dev(&pdev->dev, dev);
> > >> +	platform_device_set_of_node_from_dev(pdev, dev);
> > >
> > > Why do they even do that? Do they have a USB connected pin control?
> > 
> > I don't know. I can't test it so I don't want to break it. If they don't need
> > it, the person who can test it, can remove it later.
> 
> It was introduced by below commits:
> 
> commit 0f153a1b8193ce768be4df0400aeb2c8f2a3b3da
> Author: Rob Herring <robh@kernel.org>
> Date:   Wed Dec 15 16:56:46 2021 -0600
> 
>     usb: chipidea: Set the DT node on the child device
> 
>     The ChipIdea glue drivers just copy the glue resources to the "ci_hdrc"
>     child device. Instead, set the child device's DT node pointer to the
>     parent device's node so that platform_get_irq() can find the IRQ
>     resources in the DT. This removes the need for statically populating the
>     IRQ resources from the DT which has been deprecated for some time.

This doesn't explain why the node marked as reused. device_set_node() fits
the above description. Rob?

-- 
With Best Regards,
Andy Shevchenko



