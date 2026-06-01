Return-Path: <linuxppc-dev+bounces-21826-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26837CD5BD1
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Jun 2026 23:35:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gTr1j3WlCz2ydQ;
	Tue, 02 Jun 2026 09:35:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780356953;
	cv=none; b=aDZjIM4FecaOmkwkf2RbZnBr+fls+aqZfk+7D6WNVMf8ie/T9TvTPjQqu/vvdrtKZ8DPXDIVNU0c16ylCRpTMAb5Ghg3e8SlZqaEvh+UQNoL2VclRMypkl6dPk1NsETk+jwkQcYsfy/yD/kPeHj9dx6uR55V1TP0zvYfolsuUU4T4aBtwxV6CXfbL1st2UfDOhkmsFMJn2e6EDBJ5t2td4Nx6Jyr1OoT4k5BH5rBgo5P+ozrFsgc8fkvGA0PSo0WrkgMPfcVlBGQC8/SW1mQnFY8jnU7QqC416Cj487hVYi4wYAijkdt8fmpZOV4HO3jEiBr9wGAFbwsSUbQwAT2cw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780356953; c=relaxed/relaxed;
	bh=BsNyXchE0cQ+WrTEzbPCgdBZhaTxYz8ZYh6ODfO6Thc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RnXJxBAYkjn0TotNWizwx89oxvSPvoYBOvoWogCExEGi1BS0DpSSJKYHlot5J7mKoss2pmjANRh5lJKgHh+ugrczfMaJASqOd/1KzTze0KFSaNgKdz/Dmu1EUZsa+87L+AKiVFPY0hpLFQ1d0ckq+PicszRH7ZZE9wYD0lDIvZ4SdYXR8O+Txj9S46oXVbDWxyJVuhYCcU+EXMbJgAUHERTOdOAtUS4cV5DCIojz6+SVnTM3ZCEkWlupeDSKoTY4it9JeWeGO++a1E0ntf1us6OpnQ/RTAPpMHZUFcjxyWNqUrkXPLOapk6RlUJSDzVzePLFqxNEOFvchjjmDEySIw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bwFeM+dK; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bwFeM+dK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gTr1h3kw1z2yN8
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 09:35:52 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B2AA7419E3;
	Mon,  1 Jun 2026 23:35:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5639F1F00893;
	Mon,  1 Jun 2026 23:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780356949;
	bh=BsNyXchE0cQ+WrTEzbPCgdBZhaTxYz8ZYh6ODfO6Thc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bwFeM+dKJids5MGHkWeT2lqLmOE+Z22fpYZVG8IarCaPIkYd1ClJLTF0P+KK4TZC1
	 t1HfBIbIgLm2lF9d6SD2H1GRY5GUIy6SJwL9v8EZ3L20jIK/NaVXSt1XPTueO0oIGy
	 y19iXABriAlFUODdDTo2f2+FK6UaosZlP/s7kW+eWFj9kPjNXvxZUpQLix9fiYAVMs
	 qutOmIhrfL9fMTHLsw3ErfIZs150qZpCJg1stHoIzdshVCQp8iYW9sI4ko81gCNtbL
	 eRcz3oBpBUe09WQM6FxiPQKCgb0o3dANEdBD5y5Egf4yKaQOgk8QwaFZYGWRDLloCl
	 38TEpySFeTuzg==
Date: Mon, 1 Jun 2026 18:35:48 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Lee Jones <lee@kernel.org>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Doug Berger <opendmb@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>, Bin Liu <b-liu@ti.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Nicholas Piggin <npiggin@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, brgl@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	David Airlie <airlied@gmail.com>, linux-arm-msm@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	Ulf Hansson <ulfh@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	"David S. Miller" <davem@davemloft.net>,
	intel-xe@lists.freedesktop.org, Andi Shyti <andi.shyti@kernel.org>,
	linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>, netdev@vger.kernel.org,
	linux-sound@vger.kernel.org, Srinivas Kandagatla <srini@kernel.org>,
	linux-mips@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	driver-core@lists.linux.dev,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	imx@lists.linux.dev, Vinod Koul <vkoul@kernel.org>,
	Peter Chen <peter.chen@kernel.org>, linux-usb@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Paul Cercueil <paul@crapouillou.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Joerg Roedel <joro@8bytes.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Robin Murphy <robin.murphy@arm.com>, Frank Li <Frank.Li@nxp.com>,
	devicetree@vger.kernel.org, linux-i2c@vger.kernel.org,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	linuxppc-dev@lists.ozlabs.org,
	Saravana Kannan <saravanak@kernel.org>,
	Maximilian Luz <luzmaximilian@gmail.com>, linux-pm@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>, dri-devel@lists.freedesktop.org,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 09/23] of: platform: use platform_device_set_of_node()
Message-ID: <178035694685.195552.1114165096275774254.robh@kernel.org>
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
 <20260521-pdev-fwnode-ref-v1-9-88c324a1b8d2@oss.qualcomm.com>
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
In-Reply-To: <20260521-pdev-fwnode-ref-v1-9-88c324a1b8d2@oss.qualcomm.com>


On Thu, 21 May 2026 10:36:32 +0200, Bartosz Golaszewski wrote:
> Ahead of reworking the reference counting logic for platform devices,
> encapsulate the assignment of the OF node for dynamically allocated
> platform devices with the provided helper.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
>  drivers/of/platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


