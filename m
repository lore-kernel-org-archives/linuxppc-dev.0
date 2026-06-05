Return-Path: <linuxppc-dev+bounces-22128-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E48CD6E7D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 14:53:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gX4F64nHDz2yRM;
	Sat, 06 Jun 2026 00:53:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780671210;
	cv=none; b=d6LUP4ZG9Gcat7a9eWR90z86OQaNo/e70a/kC3md6M+aJ1Lfm4B+a7X3SnLgmnMg15Dryl3kbCoslmoUOdgxrF9vTV0P+8E829iNwSjI4K/zKtVNDa/2lbrq7tqErD9t9Y4Fs1k4NGbiMdlzMFrV9WFo2cxhMnYnJWSh7/edtnf1EiBtpnDHZgaqC7vhjw0Z58YqYPdAXoi5UcMrCm906vDzH6GJeWK+HJCT6Sypep2kdPyGEtUFsiMCfcaTOFPhU+BMxiKHJO02aDbGxboPm6PLxDBMOZ+1pH2YCiEzpPvULLFfSBV+IzCa8A+dWHeWd4i1prKWZsrY2gDfbVAuLw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780671210; c=relaxed/relaxed;
	bh=nPFAkV/hrV9jVH6ZUR7U9rgQ68zdQJy1Cp01YdTZO/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GnWeFTUsMpcKXMh9QbuTmBDu049KUyab0dHXtL2LQIEmzM+CIJNR6VUx0FAHBEGnWVDquKS6sy9pK9GwMfTLGjq38N01QGX1uHo8X1cqr74L4K/kfQwhDwVZUQJAmB1jQMGfOGOVIkZEEeu+d1gFPEHqRlcdZ1a6laTh4EQsCO71ipCg5sB5jLG1HBshhjZyz0kuNV5PtF/lufrYplg1UQUeOY9EWo26gASkU9qC+HO4OlCPAmu+tkBNs/M99ES0IkloUrqYDAvWsoDt8YrOLMO6SC9EIxNB9iKB4zQfWvOyVsOh8c6IlCJt+elYZJzcNvjAX1HrShzVzJddIPNQ3A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LsR5HCf2; dkim-atps=neutral; spf=pass (client-ip=198.175.65.18; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LsR5HCf2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.18; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gX4F33t9Jz2xnK
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 06 Jun 2026 00:53:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780671208; x=1812207208;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S9VN2IMCqnREp7EhcUK1NJoNhMFd+IfW7xD2w5Raim8=;
  b=LsR5HCf2fyKd2FRHd9Ume9Od6HIJzxDYDQOHGnkyiV5qBKKKVWVrZm6Y
   FP3BLZypR4mVZJn0gs+M5JiWo1cXzhSC6sm4jFpkWmXlVhx1t95m0B147
   74Sjur32WqRo0oa+9+bQLYW2zahttvZyjzhOSWlJJJwMaGR+iTKvLVul7
   UovLmeyLm63sXrfgqS8RgXe8Pa0OcOlkMA6eOE42hZn8A3+mh46iSFeJt
   5wq4YuVIXrFyH+Ml1Iss3lmO6R+B+XVs+nClHD9iL66urQv3LnG4c3pms
   5ewJpx69hZua7BDk47BXGlhQPQCSyA6jbXi2CKsBQxyz8JN0GRtpXS27I
   w==;
X-CSE-ConnectionGUID: Yvbs+4KTSqmNdxSX80r2zg==
X-CSE-MsgGUID: sljONKm3Rvq5U8Q8V5P0BQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="81565352"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="81565352"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 07:53:21 -0700
X-CSE-ConnectionGUID: p3R1KLajSt+9nt2FGUPoiA==
X-CSE-MsgGUID: dy03ihVLR16TJHMTwX8Gig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="282943735"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.178])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 07:53:07 -0700
Date: Fri, 5 Jun 2026 17:53:04 +0300
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
Message-ID: <aiLi0KZskrCyEYO5@ashevche-desk.local>
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
 <20260521-pdev-fwnode-ref-v1-8-88c324a1b8d2@oss.qualcomm.com>
 <ah9O15bMlAYgSlHx@ashevche-desk.local>
 <aiK-EXwp_xhcbty9@hovoldconsulting.com>
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
In-Reply-To: <aiK-EXwp_xhcbty9@hovoldconsulting.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jun 05, 2026 at 02:16:17PM +0200, Johan Hovold wrote:
> On Wed, Jun 03, 2026 at 12:44:55AM +0300, Andy Shevchenko wrote:
> > On Thu, May 21, 2026 at 10:36:31AM +0200, Bartosz Golaszewski wrote:
> > > Provide a platform-specific variant of device_set_of_node_from_dev(). In
> > > addition to bumping the reference count of the OF node being assigned,
> > > it also assigns the fwnode of the platform device.
> > 
> > Can we rather investigate the way how to make that of node reuse thingy
> > (which is used solely by pin control) differently and then drop this confusing
> > device_set_of_node_from_dev() call altogether?
> 
> No, that call is needed. See commit 4e75e1d7dac9 ("driver core: add
> helper to reuse a device-tree node") for details.

Bart fixes the problem with the platform driver. At the result this will be
the only device_set_node() + 'reused = true'.  As for 'reused' flag, the need
is only for pinmux/pin control stuff. The question here is if there is a better
way to make that 'reused' be done automatically without need of setting some
flag explicitly.

-- 
With Best Regards,
Andy Shevchenko



