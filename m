Return-Path: <linuxppc-dev+bounces-23815-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C4DC43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 11:12:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwFml54tDz2xll;
	Wed, 08 Jul 2026 21:12:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783509143;
	cv=none; b=Yl9xi+7w0f80t5RRF17y9RDqbyrLdoEAkNZO5yud05IpDCzjUIXNDZie3jiZU2jQ3lB8UVwkZm59AtJNZ7klzyFXMXb/CXa5cfeddSxSomUynsZFWN72QyseIIv9DHAZZUbME3Xo3D4ThabQnGC2YlvZlShi0q1pFRnRQd+H7ZfwnlGdyTo/s9VnjnjfllxbD9GbQtlTM5jD9U2x0qkJIO7FInUzLDTfq9IcTCCu/LQEN+T0wBYZ87QGrw494BBJrr7LU80VdHmCl7NXKdDky3R4zpWPbKTI4GnCnEO+W69EIl/vYu7amdXJ4+5oLhWc9Kcdcj8W/JsHncKoHtvBiw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783509143; c=relaxed/relaxed;
	bh=vAhl7o4J3vODU2LRR+hV2bo/t7qA1v3c3Vzoku+2FPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhzCF2Wh40mdQTan4wVi8krSegVcX9SAhzxETtx4kqMuUYBI2l09F4+Ix/Lq7gwKQYNm9fYP8dW7TyfEutXo9/J3gbs7LVH5f28gzjWCaX4y4Yw+IG2A+TaPHmVoCkwuXAvwCiUKFPBesGALsvNymzkCXwLoi87T9zQl5b81lvw+jm1+fpQLDdpuud2Gb//gB0gKdi+0KBFuIElj3yTCjegVVROiTZYTd35M4U9jubvLTPoQktoA+q7S3aZd5hSMef77BLSOXNHVsYO3aGa0dprXtZUyPfo3E3H+vdNJgickFr7fHdRoDWFIu3ivcAJH4avi0nZoK9lqtvPQIMRsNA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Lsm8heHq; dkim-atps=neutral; spf=pass (client-ip=198.175.65.21; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Lsm8heHq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.21; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwFmh2SnLz2xWY
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 21:12:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783509141; x=1815045141;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dXbZA1E6z2cbPpn5lXVwUbC3y8RJZe9PuV/6K4qA1zI=;
  b=Lsm8heHqlqGJ7nxHKpprYWjJHhPc08ubhvmn/xc4XwiPgXIABwQFNgAf
   bo6VqbF5MnEUSfy3kf3/NDGmWabAzmh6nV57dpZ14aiarpPeW5im0Shhe
   rTNANGPjMW1k50L6U10Mr4v+8EWirLdwiyCZ7539iYFO+IZ1PMWxhiGm5
   6nIimK7AoB5lZf1XjuG8aPDUF+AKCNTJMWHo71cAf5d6tZAJhNJJNJKvS
   TAXfm0Hl9+oMIKYAw2lKy0d3YFiyMBEwxtQavUOhOlGZ3k3nKK8yDFGXi
   QIHUWyziQMfDpYKG44zplt3aH8nqNvZVCTVQlxkEClG21HqvMQd0cu+io
   w==;
X-CSE-ConnectionGUID: +crmqg03T1iulikk07MpHQ==
X-CSE-MsgGUID: 9OD28uYJSEOagVk7ZK8u9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84025178"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="84025178"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 04:12:14 -0700
X-CSE-ConnectionGUID: xnTXU7N2RFKFpJyFUzPznA==
X-CSE-MsgGUID: WXa6o+4tR/u+kKLX2b+3mA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="252523743"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.100])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 04:12:00 -0700
Date: Wed, 8 Jul 2026 14:11:58 +0300
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
	platform-driver-x86@vger.kernel.org, mfd@lists.linux.dev,
	Manuel Ebner <manuelebner@mailbox.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v3 05/20] driver core: update kerneldoc for
 platform_device_alloc()
Message-ID: <ak4wfuYxO2serrQt@ashevche-desk.local>
References: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
 <20260706-pdev-fwnode-ref-v3-5-1ff028e33779@oss.qualcomm.com>
 <ak0jyUbNonSRiP_g@ashevche-desk.local>
 <CAMRc=Md7-XMBKpdPuZ4=epfTn6F-PXKJBZNPGuz5xbVy58BHsg@mail.gmail.com>
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
In-Reply-To: <CAMRc=Md7-XMBKpdPuZ4=epfTn6F-PXKJBZNPGuz5xbVy58BHsg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 08, 2026 at 12:42:58AM -0700, Bartosz Golaszewski wrote:
> On Tue, 7 Jul 2026 18:05:29 +0200, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> said:
> > On Mon, Jul 06, 2026 at 02:44:17PM +0200, Bartosz Golaszewski wrote:
> >> Users of platform_device_alloc() + platform_device_add() must not modify
> >> certain fields of the dynamically created platform device object. Update
> >> the kernel doc to say which fields are affected and which functions to
> >> use.
> >
> > Consider using __private checker attribute for them as well. It will make
> > sparse scream.
> 
> Sure but let's leave it for another series.

Sure, just a side note comment that you know that we have some facilities for
that type of problems.

-- 
With Best Regards,
Andy Shevchenko



