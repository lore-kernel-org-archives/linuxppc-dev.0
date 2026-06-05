Return-Path: <linuxppc-dev+bounces-22115-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45BE5CD6E74
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 08:00:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWv4Z5WmFz2xdb;
	Fri, 05 Jun 2026 18:00:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780642809;
	cv=none; b=C9DP+3A98FgmVnsTyQ1295apYS4Lrl7lyvP1jM9F0zXylK79w4mmeJ2RBfsynUoayZlJBvPbXa2BdiET4jtPl0w3FrC971a2Mz+nrE+jVP+vkBBV7lZWSWptyX3Lj0VIz7YtbLDPF7jvmCUyF8Lf6qyAa1dzM8T8YPvtMg8GHvvDPCEyBPkqRvRfxwl4BnKbXJyXmvYWEjLpyI0qpq1iCxJu1BqFt1b/WDugQX3y3AXS+/3W41IBDwAMiDkkwhlnxoaQawlb0ZC5TFB1TA6pjLYBZ9zuljFX5XfhMDFSgK0/FBAcTzPQ/ICk26j460/RKiQhbiMYErDqJ+TZ5FUasg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780642809; c=relaxed/relaxed;
	bh=mLaeht+14OltYjlKRnSLpPtYOk2E9Ea1Lx7tk/hcws8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kA6qUinZSz7FSqUpCU+QOYEO25cTCwvuWWTvSymLsHpsw5NwmoUJYyhiwzdnams18b1/QNyXFr+BO/oPfqJ/xxPAj8dUp74sQovOAR48iZaCZ2lUHI5tZ8SraVv8Su27OMVsfXlGF6FuY9QMy3R8X+1pEkweTHC+kbhHS2GDZcF0+O+P6vlOrtYIjDa2uJh8nwz/FGcmr6ciYvHnoGDd68UFsZyUFhdrO+/wNBVo0oXb9iQDag9UYCOnnoQRoWec4LboLdpVkoHqHPI22aIHU48OEVhKrnZQIaG55FkQLniobbGX+ghJjfoRl+L6cRJtCrYDEF1pOHQW6YrYqB8afA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YsZyfuH0; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=peter.chen@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YsZyfuH0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=peter.chen@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWskw6GMPz2xMW
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 17:00:08 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2195743A71;
	Fri,  5 Jun 2026 07:00:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF3B51F00893;
	Fri,  5 Jun 2026 06:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780642807;
	bh=mLaeht+14OltYjlKRnSLpPtYOk2E9Ea1Lx7tk/hcws8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YsZyfuH0DNQ7mv7u3TjtJz2xyIwZsrK8oVaqlPhk64DT+j0rV42P72G1+i/iwKkjR
	 NRcuOWYnbQoyKyo3l2FM69tbt1G6e/HuNgC0tjlGYq95rMPDSYtqVOPYzvnqYUPxmO
	 AWjPhYcJZ6wydfSYXF/XBNDK3f5d8IIgdI55O1W1HwIefukk8kexEUl8N5fsDeXx2z
	 4BExZj5mf+2VTADoOZFYWQlBUHvbteLd4O8xGa6QVu9YQUtYookUrNQ3mqvO9CAt4H
	 08LnpIh0I2Rne5hZA1mQuw5b6DWAlajftwY4jPb1w8G4b6cEGfnkYFO9vhRvcAILg8
	 LyUNuKdCiw8wA==
Date: Fri, 5 Jun 2026 14:59:53 +0800
From: "Peter Chen (CIX)" <peter.chen@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
	Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
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
	platform-driver-x86@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH 20/23] usb: chipidea: use
 platform_device_set_of_node_from_dev()
Message-ID: <aiJz6Ys4gE998ULp@nchen-desktop>
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
 <20260521-pdev-fwnode-ref-v1-20-88c324a1b8d2@oss.qualcomm.com>
 <ah9P6Xt9SyKgc2oJ@ashevche-desk.local>
 <CAMRc=MdhjZhGL9tEx9WEjn2f95d=ObNM0AtBNpcevm6aHgpj+Q@mail.gmail.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMRc=MdhjZhGL9tEx9WEjn2f95d=ObNM0AtBNpcevm6aHgpj+Q@mail.gmail.com>

On 26-06-04 08:34:16, Bartosz Golaszewski wrote:
> On Tue, 2 Jun 2026 23:49:29 +0200, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> said:
> > On Thu, May 21, 2026 at 10:36:43AM +0200, Bartosz Golaszewski wrote:
> >> Ahead of reworking the reference counting logic for platform devices,
> >> encapsulate the assignment of the OF node from another device for
> >> dynamically allocated platform devices with the provided helper.
> >
> > ...
> >
> >>  	pdev->dev.parent = dev;
> >> -	device_set_of_node_from_dev(&pdev->dev, dev);
> >> +	platform_device_set_of_node_from_dev(pdev, dev);
> >
> > Why do they even do that? Do they have a USB connected pin control?
> >
> 
> I don't know. I can't test it so I don't want to break it. If they don't need
> it, the person who can test it, can remove it later.
> 

It was introduced by below commits:

commit 0f153a1b8193ce768be4df0400aeb2c8f2a3b3da
Author: Rob Herring <robh@kernel.org>
Date:   Wed Dec 15 16:56:46 2021 -0600

    usb: chipidea: Set the DT node on the child device

    The ChipIdea glue drivers just copy the glue resources to the "ci_hdrc"
    child device. Instead, set the child device's DT node pointer to the
    parent device's node so that platform_get_irq() can find the IRQ
    resources in the DT. This removes the need for statically populating the
    IRQ resources from the DT which has been deprecated for some time.

    Acked-by: Peter Chen <peter.chen@kernel.org>
    Signed-off-by: Rob Herring <robh@kernel.org>
    Link: https://lore.kernel.org/r/20211215225646.1997946-1-robh@kernel.org
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


-- 

Best regards,
Peter

