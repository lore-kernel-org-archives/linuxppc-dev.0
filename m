Return-Path: <linuxppc-dev+bounces-22126-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08612CD6E7D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 12:18:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gX0pl4xvHz2yN8;
	Fri, 05 Jun 2026 22:18:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780661935;
	cv=none; b=BO1SImpf27vZ1nXKxE4X3etOLEYzc29tCO0vijsdUvN1A7BbJUYNnH1kUv6N7kBPAYGLEj6wKnRnVPDjldvvqyz+8dssYRtvBFE4H3euawDBRHLqpTTdyLBbyVXsJn1Sq2D4I0C3b5AGLLDT3omvnGwfuo2Bxs61Hb4H+m3ZHI9vxwyfw7Ilqq3oocjMsBHPzjVpKXweWrRS55d+Y5XHlFv0X01SjmRDQSLHkb8JodkQZB4o4Roaoo4Ohu9v7zA2GZ2+Vx4sxDS/XFTJCJpoEqJj9LOddUam6eGRsx07DxPY4DcCX7VckGsoJimymITbMWA7GfqIHhgUEOSYng/cJw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780661935; c=relaxed/relaxed;
	bh=/HjuMOk3WVgtMcDzTwNBYPhsQV9U+DIpa82b0vn61Cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDowcgf49tg8QJmo8AeZyD8b1Dq5+gnr2gRa2Yo0cx/H+csHygeamQPrdL5Dr9WmWK3jenuk5BItIcHY8lZroLkLmUeXeMK8qQ0ei24rWwJtwzhuYNGl5Yasyp5GQSGXmdTu/to/DwYKLuQ282crSF4tEGoTPbBM9o1+OEvZOZeyrqU9ndCe21Eakn7y4n7CtC73B1O4J/4G8G7XGyYRHbGi8Wy9bhhnirjmQaERaoPR5tI8S7efqbGplyLRJ+CjKtNtM54AhnCEXAf6Y7ho4wCt5gQhoguzT6mRFSUell8vRrLLJC2o5wTyY8hcjxc1mV3SYV++Yy2DDNADQpgEaA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B6ZbiSx0; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=johan@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B6ZbiSx0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=johan@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gX0pk5pvxz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 22:18:54 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9320E601E3;
	Fri,  5 Jun 2026 12:18:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3680B1F00893;
	Fri,  5 Jun 2026 12:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780661932;
	bh=/HjuMOk3WVgtMcDzTwNBYPhsQV9U+DIpa82b0vn61Cw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=B6ZbiSx05oBJ7chQvQ/ntllvANNBFEMa9EcOIiJSVjAP/OKFNkFGomFVwuLIbEh+S
	 20kIDl7Ha3LYle9T/0PSzWzaCdc5fZcxNiJ+ZJmhkm8/XR0hsoDMz0IvlyzEPadr35
	 B2APB6kQVq6vujpiHLQ9XGq4k/2xwAVP0hGJlMMDE7JgpUoN8S88GU32fCFiZ7KPhJ
	 5aHdZm6VNXpv0qJRoypblDiKXMIeOyKzQoPRJIPp5ZLuwnSs6kmXI7+nhiCVs/dUo5
	 dzZdsgrBxQRdtTMmm690hmi5h0XAzX6HCHrWvz8VYLGFbLK2G/Ky5ioKkoR2keR14J
	 lAcFAh/v+L/ZA==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wVTVh-00000000DXZ-0P54;
	Fri, 05 Jun 2026 14:18:49 +0200
Date: Fri, 5 Jun 2026 14:18:49 +0200
From: Johan Hovold <johan@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Peter Chen <peter.chen@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
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
Message-ID: <aiK-qZqpuC-OEigf@hovoldconsulting.com>
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
 <20260521-pdev-fwnode-ref-v1-22-88c324a1b8d2@oss.qualcomm.com>
 <6af284545729f03a60d06479339862a2f08c6b7e.camel@pengutronix.de>
 <ah9QtExF2rUUTMNo@ashevche-desk.local>
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
In-Reply-To: <ah9QtExF2rUUTMNo@ashevche-desk.local>

On Wed, Jun 03, 2026 at 12:52:52AM +0300, Andy Shevchenko wrote:
> On Tue, Jun 02, 2026 at 10:24:41AM +0200, Philipp Zabel wrote:
> > On Do, 2026-05-21 at 10:36 +0200, Bartosz Golaszewski wrote:
> > > Ahead of reworking the reference counting logic for platform devices,
> > > encapsulate the assignment of the OF node from another device for
> > > dynamically allocated platform devices with the provided helper.
> 
> ...
> 
> > > -	device_set_of_node_from_dev(&vdev->dev, dev);
> > > +	platform_device_set_of_node_from_dev(vdev, dev);
> 
> Same Q here, why it uses inherited call? Cargo cult?
> 
> 'reused' flag is solely pin control (provider!) thingy as far as I remember.

No, it's needed for pin control *consumers*, which can be any device,
and potentially any other resource managed by driver core or bus code.

Johan

