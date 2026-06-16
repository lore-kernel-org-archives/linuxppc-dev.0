Return-Path: <linuxppc-dev+bounces-22693-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D84CD98DA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jun 2026 09:49:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfhz53rpZz3bqh;
	Tue, 16 Jun 2026 19:49:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781603361;
	cv=none; b=A/uuM9+ATFKTsmN2Ues3bU25qaK66wjVBv+iv6hLRJWU1z1Cr812yntv/uQxomZp+ICBSIDdQ/CFyjnxSF4Q+hXD6ryWd04T12IU5KzoiaWTH1a/UpAaen+xCEGk4kUrhn6GVZWb4PAD00PFL3IbLobjum+jK/xSBrAEjZPG+LkhztO3tCzlSeb6wZq4TCCmaPAgxTaaOhRYmaPOdVwm3tR1lH8Vpj9vIlaEg5HlDerM1Ujoxi0cUAP5/0nAK84GxKTV4a6n//fUs1LyRLdTU5lA5qdHrf4334yXmC/3abDzX2Zln6KHofHP27rq8d6jONMtLFSKIKJ7PPckcyqMow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781603361; c=relaxed/relaxed;
	bh=qFgnt5hEhiI6G5SVbcGDDm4oPhoyUq/2yEk3yh0kWso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3ADJ8TITms48NB4FYtC28WO3+k+K4l/+jq9No0XFfAfAAmZ92TSRZOz3Z4/tVUytHstpDh1GSyqBJp70IWszR6Sbbz47G/k/2lColazGzobwX90qGZD40iWXRdcCEJkYccogikjUEx5sBQmmcZb943Kfw/k0mEi/6dJp8wPSARaYqchmgdfWShk5t9rQX3lUeg4NXsfrNRTX8yeObx7u5ZEGM6BJB0j8uVJJY1/USVrT3p4zqYR05ZSZSoXCIsCTmO8qz6n14OYmmTUlQAStlXIdCNtJVJw1MFXMRjrWLrlaNSqnFVJuAfzR5PxEVj88gjStmiOar3BHsr/jzdpdg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SOECGxVP; dkim-atps=neutral; spf=pass (client-ip=198.175.65.14; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SOECGxVP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.14; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfhz34gKVz3bqM
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 19:49:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781603360; x=1813139360;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jiLEocxNQBK6GjMpzXPf7ZOCUOSYAPAZ38ELX1lscIw=;
  b=SOECGxVP7B4VAwVHx6A3KeoOLIUf3la28qX5+8nUa6e1oDqyq8TcHQCa
   Aj/yR/KuYhP+xVEEUZBi7HX3hcOHAS3zGISll9QZnj6thXSlZqv217w/C
   bcAcFTA/etNEU6h3lrcOCtM6zw9uC+4yrIYujUqK6t47pMktYD1uOBinW
   Jb2iZRr+HW85gXP2AGohaKhZJFYogkOjA2ur3nv6tpy7JAs5PCcGFUaa7
   Kg1X4iuG/9e7KXCwQdGAyQ76rmxoX+5X6qjPJx+OySAwmjHypJXthSbVp
   rGGWj6CW4YOw3fauD8MsnpPXpidEnG7gkVrQN92SX/+oT4nxjbv1YZ7cS
   w==;
X-CSE-ConnectionGUID: 5922VTe9SWGyBzcy1+Gc0A==
X-CSE-MsgGUID: QAkQspgsRsqdpsU+fcn75A==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="86265579"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="86265579"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 02:49:15 -0700
X-CSE-ConnectionGUID: PsDbiwgJQOK0qFPdNMiIBg==
X-CSE-MsgGUID: FmU0ORA5TbecfDzPUgOXRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="246844027"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa010.jf.intel.com with ESMTP; 16 Jun 2026 02:49:03 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 6626895; Tue, 16 Jun 2026 11:49:02 +0200 (CEST)
Date: Tue, 16 Jun 2026 11:49:02 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@kernel.org>
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
Subject: Re: [PATCH 07/23] driver core: platform: provide
 platform_device_set_fwnode()
Message-ID: <ajEcDq0S067wMFaK@black.igk.intel.com>
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
 <20260521-pdev-fwnode-ref-v1-7-88c324a1b8d2@oss.qualcomm.com>
 <ah9OIVyrHEhcMHzN@ashevche-desk.local>
 <CAMRc=McLN9Ovoqo3om-3uC=q+=rcKCoiWMctC=yvwiaHacU0PQ@mail.gmail.com>
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
In-Reply-To: <CAMRc=McLN9Ovoqo3om-3uC=q+=rcKCoiWMctC=yvwiaHacU0PQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Jun 04, 2026 at 05:32:27AM -0700, Bartosz Golaszewski wrote:
> On Tue, 2 Jun 2026 23:41:53 +0200, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> said:
> > On Thu, May 21, 2026 at 10:36:30AM +0200, Bartosz Golaszewski wrote:
> >> Provide a helper function encapsulating the logic of assigning firmware
> >> nodes to platform devices created with platform_device_alloc(). Make the
> >> kerneldoc state that this is the proper interface for assigning firmware
> >> nodes to dynamically allocated platform devices. This will allow us to
> >> switch to counting the references of the device's firmware nodes in the
> >> future, not only the OF nodes.
> >
> > But why different for of_node and fwnode to begin with?!
> 
> I'm not following. What are you suggesting?

After re-reading of this thread, I think I'm suggesting the same what you have
in plans to do in the future as you put it as "This will allow us to switch to
counting the references of the device's firmware nodes in the future, not only
the OF nodes."

// Offtopic
I haven't heard from you for more than a month on this:
https://lore.kernel.org/r/af18zdP5HF3_P9Vo@black.igk.intel.com
Anything should I do? Please, answer to that thread.

-- 
With Best Regards,
Andy Shevchenko



