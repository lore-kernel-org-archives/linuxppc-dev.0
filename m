Return-Path: <linuxppc-dev+bounces-21924-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B01CD5BD1
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 21:45:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVPWc0vdNz2xRs;
	Wed, 03 Jun 2026 07:45:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780436716;
	cv=none; b=AT2O50XY8CWYWdJDze+PD+EOKMKNOtvraybckQ+Cfxg5W3LBheJtxeok4qsKazRJNZUKhVJrc2JvT4PQSt5dD1/yEhOdZtXRLv7wVGEuWE3wIVO/aYnv39tVMQx+BNl9i/Pb08lQ2m0NFV1rO8XnRh/LxxmSvQ/0BDZy2XGHATVWrHPkvx+TRFC7lqgeVoQn8xvju7H5rwRwkgB0QGm0mCRd7tNnvLhWhVF5DiaqBYQP3eqvK1s7HYIF0pNIflQ0N/dCzrogF3Z0zZenxcW6DJfIWCOLZ6cu4vrBJiBGDFHFPdCktTQLUQzERZAjA6A+TdTeX6xlPxdYuq2/XWZIfw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780436716; c=relaxed/relaxed;
	bh=eV9I1iwlhwyKrcjVSO/F6Rz8pfzPKE5OQeLiKizexAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jb60h+kQDYpfmxCAWJvXf7mF5iAbd+qjgplqUMYnUFCimRJ8pP7eBpOGvmq6whPegH8Z64xu2lAL0XABQX8sG2us/SvA31RZekNAjQzYhYkeCETMAnJ935rkOBjg09MT9EU93QIjIgngBiwAAwCfOcjZGHsVZTXpw8Ro7JbKvBhd/diHK5tWGqhcL+LLIq/fHc/GyW004XcxTo5SageDIl6CW0AFKqIEozzxuLo6/et7nhZ/4dCNJFBpPR/ZMa510KaneecqC1k7PBg42KGSpl8kEuVnyKTAVkAcl/fEHcxvBI+fRoJXE1XFKs854ZFmGeRJx3tCeTN8YoN5SKBwJw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FJgEt5s9; dkim-atps=neutral; spf=pass (client-ip=198.175.65.19; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FJgEt5s9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.19; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVPWZ0q0kz2xLk
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 07:45:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780436715; x=1811972715;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9mAoO9H8Y2BWm5p5K9c3oIGIMMxULY9BhMvq3EtYzfM=;
  b=FJgEt5s9lMKXrsWyyZ9cF4D6kjbiLpG1pQqchVKVKTTXpCCukZUYa/uU
   t4ntMqaSG3kwCZEptaHT7hhIUvra9G32ajnGNmGaLOyNWpOD0vhctTelR
   d3G2KiKIpxFeFpM/PEmgwYJEPMdxjA5XhENLyrHBeKk/vinpwInCeZWra
   47yIb8swrGSwxLZfKFz1inJuY1ZhdDAQkhmMUx7iW2TaJ0PIBcWAi9LHC
   bJP7yLKvxilm8ObYfcmAHPXE3gUWwJ4vKzP4s6LVCG1QupucglPGp5I3N
   Gf9sqBPbpYA5bCKKr6m6lhJlrB/Mnw7vE78mh0EcUAFCOQoz0pNyShXps
   Q==;
X-CSE-ConnectionGUID: Yev5vF2tSV2gOzUeWZAm7w==
X-CSE-MsgGUID: j8sL5fusS3KEyEc12HiC1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81209921"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="81209921"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 14:45:10 -0700
X-CSE-ConnectionGUID: UvnADU78SIC781mCxKiYQg==
X-CSE-MsgGUID: DRVbexEBQcalNu55EQ4gaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="237669752"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.116])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 14:44:57 -0700
Date: Wed, 3 Jun 2026 00:44:55 +0300
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
Subject: Re: [PATCH 08/23] driver core: platform: provide
 platform_device_set_of_node_from_dev()
Message-ID: <ah9O15bMlAYgSlHx@ashevche-desk.local>
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
 <20260521-pdev-fwnode-ref-v1-8-88c324a1b8d2@oss.qualcomm.com>
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
In-Reply-To: <20260521-pdev-fwnode-ref-v1-8-88c324a1b8d2@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, May 21, 2026 at 10:36:31AM +0200, Bartosz Golaszewski wrote:
> Provide a platform-specific variant of device_set_of_node_from_dev(). In
> addition to bumping the reference count of the OF node being assigned,
> it also assigns the fwnode of the platform device.

Can we rather investigate the way how to make that of node reuse thingy
(which is used solely by pin control) differently and then drop this confusing
device_set_of_node_from_dev() call altogether?

-- 
With Best Regards,
Andy Shevchenko



