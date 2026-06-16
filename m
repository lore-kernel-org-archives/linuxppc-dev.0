Return-Path: <linuxppc-dev+bounces-22692-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89933CD98DA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jun 2026 09:41:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfhp150NQz3bqM;
	Tue, 16 Jun 2026 19:41:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781602889;
	cv=none; b=ivJtn+jR3o03t6v1uO1xEwZhsY3HrWZGOlcXBssbFgCC/UGq7ypyBhncC2xA/byHhEvklZyu+JRH9vv1RtIhaseU5Pjr8n1GRMyL2K4R6bRzi1hU/ZJyZVPaL5fcI9oFkxBY6EACTZYQex+QbPwwkvoBLfGosmaDmrXbPWO9KtkjpzIXHVYLqYYDs+RWuFzUkgURJ0DBhszUUh8z3wVmjX8/Mr+c18uTNzZM1KkLAYFyH1e7zXME9DlGxrb5gtUfWT/Pr+iAN+ku/79d2LPxIUj6QZjVq2EEyaRT8qtIiJb4v20kBr/FDetk9jyoGCNpo9lpwSvsXDRNAmme1TzLEA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781602889; c=relaxed/relaxed;
	bh=adEBYRriAxMxmSEScuioF/diefiA3QeGNXQgNrunPoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGByvVBnA3sO2IrECQjP8/Ap/fGCeqtXorWFxOjae7B/MAP/UgLftNgAZC71bL/MdAE6QQ1+IRv9Y1vb/iyxQ/CkGu/92THm0JHFyz4tpJ78DPGYHH8Rf2fib4RfT6/+dzrV308eNBUPLDXU9+46ZFaAl+U7FADtC/AJ3PQuBoY968n+aWluVgY9DyjGgJc5ot4t5HTPtCGBLEXMnub7m4ytEFIEWiNXzHVdqvTrhKpud5UeIE+o3hnkw0b7XtHSG8lmRKqN6swGmcF7FKVR0VWH0AwkiUvZuX7jiYFMtdCpOPTU8fQjBo+QQ2v1/D5PmwebqAs6wTkQc40IIpUUKA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ERkbFad7; dkim-atps=neutral; spf=pass (client-ip=192.198.163.16; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ERkbFad7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.16; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfhny43cvz309S
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 19:41:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781602887; x=1813138887;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6rB2N++QnF7JTGORtVke61SAOuu1kszVTJ+rWarYgM8=;
  b=ERkbFad710uIFQLtROFxG9P/HoSSAPsUfMsIQNCvyU3HMgecxCmNbvZ0
   Ks21xxuyLE711aX0CrxtlqnQSMfi6txijVbpLHkQvZoqKPn2UdTXxL4kz
   MCf+9SivRhmceeWPeLHY3uocr7JXPuv5yOaEvNtRRN9zXVEOcKO8FWuHr
   H7D7I+kVCea/ezEXK/0SWRXH8HiCmJY/km7yqOAPcyevVPV1tzgT8rB4F
   CEKakL9pVrosSu132yW3Usdy9mc5yZExiH5PUXIzT+gx6hmAN88BCdN7C
   Fxs0eGyAjeK00IUGFFjVhOExpzSUKDObAf6eY8M2FFDlu3EAopJDhdBbD
   Q==;
X-CSE-ConnectionGUID: VvN91r0BT3SHPZxBCBeiiA==
X-CSE-MsgGUID: +hfpKFm0RtSm981jXQW+5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="69908029"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="69908029"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 02:41:20 -0700
X-CSE-ConnectionGUID: AnrLxaW9TzuUK3u43KSRLQ==
X-CSE-MsgGUID: M1WMwv/PSYC4Tunnc2YqKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="251644879"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa003.jf.intel.com with ESMTP; 16 Jun 2026 02:41:10 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id AD51695; Tue, 16 Jun 2026 11:41:08 +0200 (CEST)
Date: Tue, 16 Jun 2026 11:41:08 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Johan Hovold <johan@kernel.org>
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
Subject: Re: [PATCH 08/23] driver core: platform: provide
 platform_device_set_of_node_from_dev()
Message-ID: <ajEaNFhntZTS-w3e@black.igk.intel.com>
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
 <20260521-pdev-fwnode-ref-v1-8-88c324a1b8d2@oss.qualcomm.com>
 <ah9O15bMlAYgSlHx@ashevche-desk.local>
 <aiK-EXwp_xhcbty9@hovoldconsulting.com>
 <aiLi0KZskrCyEYO5@ashevche-desk.local>
 <aiZpJkQBXg2pcczy@hovoldconsulting.com>
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
In-Reply-To: <aiZpJkQBXg2pcczy@hovoldconsulting.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Jun 08, 2026 at 09:03:02AM +0200, Johan Hovold wrote:
> On Fri, Jun 05, 2026 at 05:53:04PM +0300, Andy Shevchenko wrote:
> > On Fri, Jun 05, 2026 at 02:16:17PM +0200, Johan Hovold wrote:
> > > On Wed, Jun 03, 2026 at 12:44:55AM +0300, Andy Shevchenko wrote:
> > > > On Thu, May 21, 2026 at 10:36:31AM +0200, Bartosz Golaszewski wrote:
> > > > > Provide a platform-specific variant of device_set_of_node_from_dev(). In
> > > > > addition to bumping the reference count of the OF node being assigned,
> > > > > it also assigns the fwnode of the platform device.
> > > > 
> > > > Can we rather investigate the way how to make that of node reuse thingy
> > > > (which is used solely by pin control) differently and then drop this confusing
> > > > device_set_of_node_from_dev() call altogether?
> > > 
> > > No, that call is needed. See commit 4e75e1d7dac9 ("driver core: add
> > > helper to reuse a device-tree node") for details.
> > 
> > Bart fixes the problem with the platform driver. At the result this will be
> > the only device_set_node() + 'reused = true'.  As for 'reused' flag, the need
> > is only for pinmux/pin control stuff.
> 
> And any other resource which may (eventually) be claimed by driver core
> or bus code.
> 
> > The question here is if there is a better
> > way to make that 'reused' be done automatically without need of setting some
> > flag explicitly.
> 
> That's not really relevant to the series at hand.

It's not, but it's relevant in a long-term for understanding how we can get
this done in a better way.

> If this is something we want to merge then you need to continue setting
> the flag in order not to cause regressions.

Yes, that's how it's now.

-- 
With Best Regards,
Andy Shevchenko



