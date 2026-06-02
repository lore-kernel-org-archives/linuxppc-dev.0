Return-Path: <linuxppc-dev+bounces-21923-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D730CD5BD1
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 21:42:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVPS465kcz2xRs;
	Wed, 03 Jun 2026 07:42:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780436532;
	cv=none; b=b3y1UMlcAep8rw9msHb4cTxoiJtQe5bKukN2I4720TuQ//H/z1eYVmiPlV9f6G+Ew+V9sf0jypo5vz7oY0JZ2Z81dBXxEo5RuUZhgY1B5VZvSCPdDwGhsMvWL+Xia33MB2mMgA1nRA/lMtfenT0ST3nzYxU7fG8X3TglXZnpqrPKhlcO/GHhqiwXPmEk8K7NAO6xOJs+a7GZ476J15GMR4p5WvIxxZijyZFPDSTu/oMb3IZokGqHcq0wNNr5oXJxhsrYpsetVrqVTaBGxBFrSvIQ6B23AlAP6voS8I+eUZ5jZ2V2paO37hYxBF0qlNO2H/F6F1eqDUvOLoApCnxVhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780436532; c=relaxed/relaxed;
	bh=7kHIaPFirgCcxWUis9lkJL1SxkJs++GAiBQ+ZbcFBN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dnXfiBJwl0fRqX1q+2owTj1I9Bb2DyWjWMq7TfI+MG4vsGU0rX9MiA8jPzHV/H1MIVdzg76ftaeun5rZk8VZvETgkGCDyLKLFNqrNnNGH+RAOb7JpUIIA8x51TiBaeAffk8iDt8XiNbcgCZph+2SL+8t3KxAg1srX6y2bHxrp26YAio9qXsDi+uLv5+bMhDLNrIpCP2QUGAbKENxApnBMRDE50D8y2Dpy1E2gSpazTGuH9gat9SqOHsXq4JUiV6tzW3tAfPXwMNLfzbYjL0Q8uemf9fB65dkrfjuvVZKwAF6RDYEFy2D+WpbMJidZMDR2hbODxdcqYB0+Ms1gDdFaw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=c7YoxD4F; dkim-atps=neutral; spf=pass (client-ip=198.175.65.11; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=c7YoxD4F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.11; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVPS34BDnz2xLk
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 07:42:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780436532; x=1811972532;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y1ADfjlXNms8ZBUMtHS+kHppk6E04WG2MGtxZDw5VPQ=;
  b=c7YoxD4Fx6YhLazSuEseJjF2T6jSBEzwIetSV7N92zBvfMNoTWMOfSAG
   n/IY+KkhqE+rQwBbJlcQtmMiFTsbRPW3IA1Or/PTj900t3X01rs9/8V8h
   KZeDLyfR/5SkOSCgFdY6obRA1Yv36IfZdxKEL1y6UHA2RDWNBcazikan6
   06V19fHJRRk9dmF/UhuRO5qllQm9uKhAfCCGbIH0Aad3kGJQFVuTUQNa1
   7h2o0lq/6HWQlKcHoG6sht9jYraTrknYr8k59GEItzZksf8F9lECRFnsL
   9f17RhWi5URsG4iVxjIlSs+j/a4AK14f6tY6f7Ls8VX+t43gvhtZd93Ew
   w==;
X-CSE-ConnectionGUID: bRlskzdQRp6t1ILxXhYJCg==
X-CSE-MsgGUID: OS+zkz63TFicmi0ZXpScrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="91546436"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="91546436"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 14:42:08 -0700
X-CSE-ConnectionGUID: tgIXYpSsR9qp+knkNCaUJg==
X-CSE-MsgGUID: nLO3XIOVTTyZUZFp+zTfGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="241042785"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.116])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 14:41:55 -0700
Date: Wed, 3 Jun 2026 00:41:53 +0300
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
Subject: Re: [PATCH 07/23] driver core: platform: provide
 platform_device_set_fwnode()
Message-ID: <ah9OIVyrHEhcMHzN@ashevche-desk.local>
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
 <20260521-pdev-fwnode-ref-v1-7-88c324a1b8d2@oss.qualcomm.com>
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
In-Reply-To: <20260521-pdev-fwnode-ref-v1-7-88c324a1b8d2@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, May 21, 2026 at 10:36:30AM +0200, Bartosz Golaszewski wrote:
> Provide a helper function encapsulating the logic of assigning firmware
> nodes to platform devices created with platform_device_alloc(). Make the
> kerneldoc state that this is the proper interface for assigning firmware
> nodes to dynamically allocated platform devices. This will allow us to
> switch to counting the references of the device's firmware nodes in the
> future, not only the OF nodes.

But why different for of_node and fwnode to begin with?!

-- 
With Best Regards,
Andy Shevchenko



