Return-Path: <linuxppc-dev+bounces-24014-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF17C43458
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Jul 2026 14:10:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gxYcl4gdBz2yS4;
	Sat, 11 Jul 2026 00:09:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783692599;
	cv=none; b=Rnoank7S2tkN/zVbIr6ZuQbOyXP0dUqWkMWpOZJBrTKkeYwzt2vxC2cWzsAIjtSMqMAtXiUxzfkDoVuHdD22nbKPEcUN7wqDC5iC36l9wBNDij4lerjsptEaiWYqWE0w6p4MA/FX8NqeX2/Fh9SG5rNXQtftNVdjZTNa2/2saEOvnrA5u3e5Hcg7atts6LJih91ByPSVYXBusombPfNZyVYiWOMwlqqls4gVc4TDZ4lJCjPm8kdnAMLzlATDlJKTFLgKNEKw4skXss5n/4JGC1rLBfMDXy1Oxsaq6HW6+fMffE5k5ELXhh3vd7QnU9bBvyMwlDWo2lqtnvDYvOSmmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783692599; c=relaxed/relaxed;
	bh=h1xi3IKQjbdJ53JCv2L+jzRlcSu7ApiSTvfpodjcvtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Slyk+HEl94fTlpQYUrSabLEXTfU2gX7zTqf0il9WEJ+QLpImfSId1yt/hLsgSxeA0D/OVxqgding3c9ZQf5ix7F2QRaj+Xw2d0qTwQJpdLJmUYXCMylQ5/BLTgW1npBGr2wdSnGocHU0y35OBpOyUkSbih3V/4gH5MdGtSs4OV8up2omEVKn4jUnWZEQv8ukuLlGp6eUTiyGX4EKTKe/uduEBlZ/zjmfxHGTrZE/uLw6DhLSyDo+DPqBPnfhvvYGJcG3ZxJB6vrl5q0Kz5MPlGx0RxPjOlRjyVEMBArL98lfFTUc/FuKJ6fpPwYdZVt9kh6TWzgJ5Dp40boNXobf3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=kgmiif0J; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=kgmiif0J;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gxYck1662z2xlt
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jul 2026 00:09:57 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D4C2460051;
	Fri, 10 Jul 2026 14:09:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E7411F000E9;
	Fri, 10 Jul 2026 14:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783692593;
	bh=h1xi3IKQjbdJ53JCv2L+jzRlcSu7ApiSTvfpodjcvtk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kgmiif0JKq2HSeSzJ7OofwRSlUD94iS3uEV1tKQ943E0Dw5HJBa/NodJ+UjhAlKNH
	 FGbXFGZ+JEAXY3Dr+tF4ssnWwH8WP2JApHQJxCeAynEVTGBtdWPwSFCDmJ7/fOYkFW
	 Kncg2+p1T/D/wvPa/3glV7KVkw5wq6sn17XSngyM=
Date: Fri, 10 Jul 2026 16:09:16 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
	Vinod Koul <vkoul@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
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
	stable@vger.kernel.org, Manuel Ebner <manuelebner@mailbox.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH v3 00/20] driver core: count references of the platform
 device's fwnode, not OF node
Message-ID: <2026071001-limelight-stoppable-d7cb@gregkh>
References: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
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
In-Reply-To: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>

On Mon, Jul 06, 2026 at 02:44:12PM +0200, Bartosz Golaszewski wrote:
> Platform device core provides helper interfaces for dealing with
> dynamically created platform devices. Most users should use
> platform_device_register_full() which encapsulates most of the
> operations but some modules will want to use the split approach of
> calling platform_device_alloc() + platform_device_add() separately for
> various reasons.
> 
> With many platform devices now using dynamic software nodes as their
> primary firmware nodes and with the platform device interface being
> extended to also better cover the use-cases of secondary software nodes,
> I believe it makes sense to switch to counting the references of all
> kinds of firmware nodes.
> 
> To that end, I identified all users of platform_device_alloc() that also
> assign dev.of_node or dev.fwnode manually. I noticed five cases where
> the references are not increased as they should (patches 1-5 fix these
> users) and provided three new functions in platform_device.h that now
> become the preferred interfaces for assigning firmware nodes to dynamic
> platform devices (in line with platform_device_add_data(),
> platform_device_add_resources(), etc.). The bulk of the patches in this
> series are small driver conversions to port all users to going through
> the new functions that now encapsulate the refcount logic. With that
> done, the final patch seamlessly switches to counting the references of
> all firmware node types.
> 
> This effort is prerequisite of removing platform_device_release_full()
> and unifying the release path for dynamic platform devices using
> unmanaged software nodes.
> 
> Merging strategy: The entire series should go through the driver core
> tree, possibly with an immutable branch provided to solve any potential
> conflicts though these are rather unlikely.

I've added this to the driver-core-testing branch now, thanks!

greg k-h

