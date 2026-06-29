Return-Path: <linuxppc-dev+bounces-23117-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 763EEC43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2026 16:23:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gps5V5VLFz2yH4;
	Tue, 30 Jun 2026 02:23:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782750190;
	cv=none; b=LznZQy0oi6iH0SZqYcpw36YYqBG7trm7Zkw9Oz5eq/CRGrRUeaLGvZHDYpSleQDAloOWaGh4rEaAacRqwre8/Bn0VMcWP8c5cDZWpHn1BtOWFzJTImuzB9Xmgf2T32DXQYjF4zgRK2p7Hr8HXVOkDRRb9f/yV9IBvTfFfXKBQfjWQ6k7ZG5XZf3Oqxi+/2Kmvr7VvIBncho4UuJ5Qr8pPGpzNlhbHFGfN/PMc9ia9gJVAfRQMOTcdhQipe8TikA2Giw0I3q7pO8n8xPK4lzljxiEoJx3w3mOfAKF8uQDlXgnQoqYXRKQA41JjcJ8mPUH2PFotxzg/htI65TugfLVQg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782750190; c=relaxed/relaxed;
	bh=XnZAvQRuMx/J3aC4trm8bs2DmSDhWyZ5UqHCdLG4R4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bx4TVbQRf5hNo19X2OER/+/Ixx+orcxGQtFdGqZ9dzro3yTJRKH+tsuD9S2LTKnXOUlJzNcQjd0J994c/JmJfZ8KjPkBiO0yUoMpvjtRNS0ekUGK2X8kCpmG4Tywa4YLdCGWrh/sIxbEscYFKAD6z+nLaPb4O3AANSBzNZ0aAPcmLeS9qN2+GqCe1O5JuaxAf7aMyJzOySaayQfaNOU8OBoP/qem32i8e0O3PWnL2lI7imlkjffSV3GlRVul1j7yWqwP3sSfRw5AbM7uE5GTXVwJCO9M/YR78Go/JCHn/fpg9sBMXdcixpcBMt3fQiZfsTtUbussIi2O9X6Zpgf3Hw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=I45Dh1pY; dkim-atps=neutral; spf=pass (client-ip=198.175.65.16; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=I45Dh1pY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.16; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 65 seconds by postgrey-1.37 at boromir; Tue, 30 Jun 2026 02:23:06 AEST
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gps5Q4Zscz2xd2
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2026 02:23:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782750187; x=1814286187;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NFSMtVuoxLsda44tJKXSv/IYfieoOuyAy+SzWiTGH00=;
  b=I45Dh1pYsP0IfhhlXpddZtbzBsutnCH0+Xnk2OG7mENQpAqhZfbOAKD5
   e/qJwjlFi/5vqt/vxns6Ori3ZMet879yvyZGdqv2F/5onpgd5hTL7ujUQ
   J9JX7f3P4cft8shRAY6XkTe6ERDDS60FAgnl7KlE8utEQcb3kU0NbPGT2
   vofSREphfwHSx0UCJ2qL2LUe07tGGjs1Dp/zgnd/lk5zMrBmgUgYfwjug
   6PRczXD7tvWOo/UznEuMouiq0vUryXssTJwbNNjcnzd/hBon4s3/PAAKR
   WgJl7MS7WOguGo9JHei+6jNeMZKoDiLNYgzdeB86k+RQsnQXRqUjeeUI5
   Q==;
X-CSE-ConnectionGUID: qGxm3BVfQWKwkNB9NP45uQ==
X-CSE-MsgGUID: wBBEplfMTJuwNsxT4KVrSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="83644942"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="83644942"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 09:21:46 -0700
X-CSE-ConnectionGUID: FxugsHAHT4+THTJwauLSzw==
X-CSE-MsgGUID: nJKI5ILbSS+sjP319WFTsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="290124520"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.207])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 09:21:33 -0700
Date: Mon, 29 Jun 2026 19:21:10 +0300
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
Subject: Re: [PATCH v2 19/19] driver core: platform: count references to all
 kinds of firmware nodes
Message-ID: <akKbdrwQSGAakDcq@ashevche-desk.local>
References: <20260629-pdev-fwnode-ref-v2-0-8abe2513f96e@oss.qualcomm.com>
 <20260629-pdev-fwnode-ref-v2-19-8abe2513f96e@oss.qualcomm.com>
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
In-Reply-To: <20260629-pdev-fwnode-ref-v2-19-8abe2513f96e@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 29, 2026 at 11:12:42AM +0200, Bartosz Golaszewski wrote:
> When using platform_device_register_full(), we currently only increase
> the reference count of the OF node associated with a platform device. We
> symmetrically decrease it in platform_device_release(). With all users in
> tree now converted to using provided platform device helpers for
> assigning OF and firmware nodes, we can now switch to counting references
> of all kinds of firmware nodes.

Yep, that's the expected result, thanks!

...

>  void platform_device_set_fwnode(struct platform_device *pdev,
>  				struct fwnode_handle *fwnode)
>  {
> -	if (is_of_node(fwnode))
> -		platform_device_set_of_node(pdev, to_of_node(fwnode));
> -	else
> -		pdev->dev.fwnode = fwnode;
> +	fwnode_handle_put(pdev->dev.fwnode);

> +	pdev->dev.fwnode = fwnode_handle_get(fwnode);
> +	pdev->dev.of_node = to_of_node(fwnode);

	device_set_node(&pdev->dev, fwnode_handle_get(fwnode));

>  }

...

>  	pdev->dev.parent = pdevinfo->parent;
> -	pdev->dev.fwnode = pdevinfo->fwnode;
> -	pdev->dev.of_node = of_node_get(to_of_node(pdev->dev.fwnode));

> +	pdev->dev.fwnode = fwnode_handle_get(pdevinfo->fwnode);
> +	pdev->dev.of_node = to_of_node(pdev->dev.fwnode);

See above.

...

With them being addressed,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



