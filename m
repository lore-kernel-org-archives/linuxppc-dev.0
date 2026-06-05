Return-Path: <linuxppc-dev+bounces-22125-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12861CD6E79
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 12:16:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gX0ls3VLdz2yN8;
	Fri, 05 Jun 2026 22:16:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780661785;
	cv=none; b=NKMWfrf8+iIvY2Cx1gNCOP/ucGVlpd0iT/ilCMnv8xO2vyubqpc89/ZEndHRhcz9tk4x/NCz9/RU3KQ9kRF+z5LjdUVi5VdVTydPzwgyLD813pR/39dHZaFvvuhQ8t9lTS/iNRD84pOa+uNYfxWpVYuIguzqWWa1rAG93fmU4pP3g6E4u97x7ST+PW3wzB61HjwfFQgPdJERm3CnknBDJJdr9aLZ8gXJCN2XHTTd1NsGi/QwZJoddLmpGiBNToFIDc/PUfmBNfgw93szJDnHFVduVbyiElt06kILvrXEFVSPtOHlcL2gqG4vOy8eIpB84+PglsK0haP5xJ4gPk0HOg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780661785; c=relaxed/relaxed;
	bh=N6eF1GWUd29h7zy7BTjjZPmBC+K5GJ6gDgFk0aS492o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IuEKN9/iAgF2Y+TrvBtpUDFxPbv/VWNEFf6FS+BFCRujlj/yLkTuSO7H0ZlM8emdSslidcM4Kp17sNgPPhz9SozwQQ9AIWPXZ5Tf7KGlGU4gfUvibaqQcs41uxxr7BH8toZKes0RVWxIutGI7x4IKRPInH3UcTiohKi7HaC98mRcllGhRVYPZdsHzVe/KLr5NR+7I2iv6IhJh5b9/vHWEFEMx/5ZqbklDPNs9yYYIwRGrrZ7jkJhx7oTs1D0z5kNJ6p/LsHi+NrRO9GcNcc4RIfySwSW0cW0j7pFt5ZqMkL2UfDU8/jzj2CMLUEPLagIo4+eimZaLdqhXNV1OHhYvw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VOFT+2Ov; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=johan@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VOFT+2Ov;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=johan@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gX0lr1J7cz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 22:16:24 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CC3F2601F5;
	Fri,  5 Jun 2026 12:16:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70CFA1F00893;
	Fri,  5 Jun 2026 12:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780661780;
	bh=N6eF1GWUd29h7zy7BTjjZPmBC+K5GJ6gDgFk0aS492o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VOFT+2OvlBtpNuDhZERoNGbVhpyXK6pZJaP6rLVUG6qpUcQs6j+Omao1sssQRncQY
	 1m9NFiMYSj7IQbmefSmJytF0dsrP5YNKZatB6uNwDtchw3h+govcw9EbPZmh3kcHF6
	 0oPamZY3TdW+5YHiyKa9spHJ423FECL3kGkLDkWSGouMiQgdlI0n6DLVv4mRJtjmth
	 lo5m/tghSaeN6MiAweXSHu5BOAT0zLd9n+spOEroR9P+r/gYh4RPjWwNlfvbQ/+cga
	 JCtQ7c+84t3He6vUTed8SdwPpe+dWk28+7O7g4XOlwkdOG88pDfVyTVdJtZr12BUg+
	 Ff43G7q8d2huw==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wVTTF-00000000DVf-0HM4;
	Fri, 05 Jun 2026 14:16:17 +0200
Date: Fri, 5 Jun 2026 14:16:17 +0200
From: Johan Hovold <johan@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Peter Chen <peter.chen@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
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
Subject: Re: [PATCH 08/23] driver core: platform: provide
 platform_device_set_of_node_from_dev()
Message-ID: <aiK-EXwp_xhcbty9@hovoldconsulting.com>
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
 <20260521-pdev-fwnode-ref-v1-8-88c324a1b8d2@oss.qualcomm.com>
 <ah9O15bMlAYgSlHx@ashevche-desk.local>
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
In-Reply-To: <ah9O15bMlAYgSlHx@ashevche-desk.local>

On Wed, Jun 03, 2026 at 12:44:55AM +0300, Andy Shevchenko wrote:
> On Thu, May 21, 2026 at 10:36:31AM +0200, Bartosz Golaszewski wrote:
> > Provide a platform-specific variant of device_set_of_node_from_dev(). In
> > addition to bumping the reference count of the OF node being assigned,
> > it also assigns the fwnode of the platform device.
> 
> Can we rather investigate the way how to make that of node reuse thingy
> (which is used solely by pin control) differently and then drop this confusing
> device_set_of_node_from_dev() call altogether?

No, that call is needed. See commit 4e75e1d7dac9 ("driver core: add
helper to reuse a device-tree node") for details.

Johan

