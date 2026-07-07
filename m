Return-Path: <linuxppc-dev+bounces-23718-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 949EFC43458
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 16:06:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvmL869XQz2xnp;
	Wed, 08 Jul 2026 02:06:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783440368;
	cv=none; b=lXVKabseZ1hwEFY1ztxX6dNA/np5GO35zk81TFj8Nhh3w7D35NBr2Lfrgf5mVz1jTHPwAQ+OdReyFL46WFNVEBm1O0LdbPeDTq9phz/vMkAVbRQYJOS6tcw9150h9yO6eB6w4UpWkZqCcUFBJIQFbf3FFq690GRyyn4D+/Wxp9DdLkjjb9m8swNi7lpFAKtAoNYhVGBv457ReWEoR6xQ4jwi8P/CRhQTDuK+V22Vkj2FNQ1TGCMHo69nwKmaZ44FIj0fmEh9Jzc7lYpKB0vCG66DTzdOaCETsu9ygNtbRrt9m7tnDCBBGMOJoOdcqWM2J4RNRqlqE2zDXVCnvOdOlg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783440368; c=relaxed/relaxed;
	bh=aGlDCXQ5MGjg6+AxGfBTr92LJUIYDoCCvNYiR2Nz9DA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b35OZlHboMIFlJn+a6N2gUoZ+Sh5KmWAUg8oGAfOsvkfpRC1SkBzK5XbtHyOgznrdVckdyipTGEF6L0jMKKXS7MD01sG4IhnuGRk0qeZF6jD47tHx0q1cNbPDbNGChsmRCN2EmEW+YG3A7OhLCcXuvn869S948OATtBo+dKIJu9kIjcwBlhzBJFMmT1rwmLBo2ZZ/fE7Zc8SCe97PAQTxIG4Ze+S+2soysM3+UlCa/unt/GU/igkbGNNq7iCDyXMx+n6LIRd5cilKEpuHnCV0WkDvedYmkJOTwf3b6cmoVojbJAmA0rw7OUAMSDWIMhUhBFm93oE5k5SuIiRWn6/FQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Xa26qhgY; dkim-atps=neutral; spf=pass (client-ip=198.175.65.21; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Xa26qhgY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.21; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvmL46Xxcz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 02:06:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783440365; x=1814976365;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WGu1H7KZ2YHXBPQTafzG2nNs51jULw2SwYV9eRAWAxk=;
  b=Xa26qhgY2x3dlOGH2BxcJnaUM1M26XGKA/ipCPvDb8WQCXJL71xVh88A
   NBcybESdVbSHUKD77bzax5pDqsm/G+K/EYIjeJ3IaNPXrGDZBB+Yqciw/
   XaCRNG9O/PcTLjSFFM/Yi8Kxva2HX9D1c7tw0Nr1UG3dXxSSEiHLyHzNN
   Tm7PJILObUp5iktj/lcki5i3/5UeRFGv+FUwbIpTpuRhHVG7NWC6YB1f3
   dVOwAPWfQ//8nAI0Uol57Fnr0Sxb8gZ7Eubg95CpoYqBTuCZwKCbr6X53
   yVTDkk7dGidRVHYyruT84B0I9CxvotqRqWwKisPw1uAUsmnOGHT9UC3/f
   w==;
X-CSE-ConnectionGUID: mHWjQVLzTdqqkBo3UCnEwQ==
X-CSE-MsgGUID: nTBvZYKIS6qHEJ35oMkpqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="83952089"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="83952089"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 09:05:47 -0700
X-CSE-ConnectionGUID: tBOk0B/0SG6kjtraoD2mfg==
X-CSE-MsgGUID: bDNaWP1RQpiCsfz4/eJ9hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="254117548"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.36])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 09:05:33 -0700
Date: Tue, 7 Jul 2026 19:05:29 +0300
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
	platform-driver-x86@vger.kernel.org, mfd@lists.linux.dev,
	Manuel Ebner <manuelebner@mailbox.org>
Subject: Re: [PATCH v3 05/20] driver core: update kerneldoc for
 platform_device_alloc()
Message-ID: <ak0jyUbNonSRiP_g@ashevche-desk.local>
References: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
 <20260706-pdev-fwnode-ref-v3-5-1ff028e33779@oss.qualcomm.com>
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
In-Reply-To: <20260706-pdev-fwnode-ref-v3-5-1ff028e33779@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 06, 2026 at 02:44:17PM +0200, Bartosz Golaszewski wrote:
> Users of platform_device_alloc() + platform_device_add() must not modify
> certain fields of the dynamically created platform device object. Update
> the kernel doc to say which fields are affected and which functions to
> use.

Consider using __private checker attribute for them as well. It will make
sparse scream.

> Suggested-by: Manuel Ebner <manuelebner@mailbox.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

-- 
With Best Regards,
Andy Shevchenko



