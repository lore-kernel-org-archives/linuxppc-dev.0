Return-Path: <linuxppc-dev+bounces-22129-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E9E7CD6E7D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 14:54:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gX4GJ2QNFz2yRM;
	Sat, 06 Jun 2026 00:54:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780671272;
	cv=none; b=U+/rijc/eaxuOgQZEtmjZKNValCdjmsZe0/jE5DSq+7AGuTEgx6AU564ORY9ECIfV+/rSP/qvEWD1jAO6tlG96K13GHylgHA8Vfh1HCaVIfHeBivZ4hONBRD1sTyQh05d/zT81D9eJo79aQPNAvo8SvesW+UW0hchERj0tVjLRjZuIuwGoxIxSTfqsmTOTP3h/EoOslqGOPBjIumt0ZKbsB2pJsN2+rbFUrZIz/XfgMLk8ZK2cPjbGmCbbkJvIlxSiM1EqQPYwdEi57F5zlHboz0gti5FJhPRMBlv1cG2mUri8KzgHAJsyHpVWA8OFYb7O6pWqBDN3YIdmRD4v6fxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780671272; c=relaxed/relaxed;
	bh=k8V9Y6TopkjHZ//OwuNmxrz19+++RtC/b+uhO4hbI6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGAm5v5WWfRLDhDBSuAfvI9O+knnWFp6Y7pRMKprc3ibd7f6wDnfAw7X0e/1WcHRUQFDTKkBEKb8iKxlZETMjJsbr+HgHalgEqYLzjprKzGGb4dt2uSX31au14JYqOK/qXy6QLvhMoZxpLwraYDbzm5fgvNj9n+X+M1xEDsTT6VEvhnS/SEA/tAzAy4HVPWiXIm9/4RGA23HBAuLEAR7aZoVzYoZjKtQ2J1aDWTzfNmzsxaugL3SmMgdrB9OLZVRkSmbso9WwOWjIrJ0zEOmhKOQFvbK/nfkFaJPUmbmyM+NNM7DHRv7lm3XM8Bp714u4SFwpQwuWd5UqpHPEJAwNg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=F/DqkLmt; dkim-atps=neutral; spf=pass (client-ip=198.175.65.18; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=F/DqkLmt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.18; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gX4GH0jylz2xnK
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 06 Jun 2026 00:54:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780671272; x=1812207272;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4tMeiKXzH2reWHQd2Do3LiCn4ypOHk0Io4ayzbOXR2A=;
  b=F/DqkLmtUSwqLt1/kb7+HaO28xgKhiukCHohgm0OgzxyHI23neZk8s6I
   1FTXrqesorgjA1U/FgyTlCMUiImDvyKPQf3DUOcLqNQgGpyYou1AtihWl
   16eEauFaEcqhPMsQILalC94EtZv9fU4qS+GpsBHQdVV/+cFhZqqyAvGuZ
   RoR1HQXQcl1vnZ7rAFYP/eug4kWap4nVuvZwfzRokNdtZsZT83iyalm/2
   /RBLZREHz14nj4pqlenWPwSMWy5RfymGSwbqJgF4oVH0+OsjNWrvIyNGe
   79tJh+6B5wKBEcloDOTKbp9z5NMzO9ehzCn4J5Am9APVjAOhJ9xZ2rlga
   Q==;
X-CSE-ConnectionGUID: HkBHu/8hTLGWTU4xYaZ2Fw==
X-CSE-MsgGUID: p1lhuYPEQkKp/Haanbimxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="81565452"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="81565452"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 07:54:28 -0700
X-CSE-ConnectionGUID: h9Rk7ixqSzO/yh1S6oBceQ==
X-CSE-MsgGUID: mgvGmj4gSWyogJmBey9GTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="243768683"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.178])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 07:54:14 -0700
Date: Fri, 5 Jun 2026 17:54:11 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Johan Hovold <johan@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
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
Message-ID: <aiLjE0SLwrDytyw0@ashevche-desk.local>
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
 <20260521-pdev-fwnode-ref-v1-22-88c324a1b8d2@oss.qualcomm.com>
 <6af284545729f03a60d06479339862a2f08c6b7e.camel@pengutronix.de>
 <ah9QtExF2rUUTMNo@ashevche-desk.local>
 <aiK-qZqpuC-OEigf@hovoldconsulting.com>
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
In-Reply-To: <aiK-qZqpuC-OEigf@hovoldconsulting.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jun 05, 2026 at 02:18:49PM +0200, Johan Hovold wrote:
> On Wed, Jun 03, 2026 at 12:52:52AM +0300, Andy Shevchenko wrote:
> > On Tue, Jun 02, 2026 at 10:24:41AM +0200, Philipp Zabel wrote:
> > > On Do, 2026-05-21 at 10:36 +0200, Bartosz Golaszewski wrote:

...

> > > > -	device_set_of_node_from_dev(&vdev->dev, dev);
> > > > +	platform_device_set_of_node_from_dev(vdev, dev);
> > 
> > Same Q here, why it uses inherited call? Cargo cult?
> > 
> > 'reused' flag is solely pin control (provider!) thingy as far as I remember.
> 
> No, it's needed for pin control *consumers*, which can be any device,
> and potentially any other resource managed by driver core or bus code.

Why don't we set it for every pin control consumer automatically?

-- 
With Best Regards,
Andy Shevchenko



