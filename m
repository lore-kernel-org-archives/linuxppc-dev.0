Return-Path: <linuxppc-dev+bounces-24459-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D515C44527
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 09:48:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3bLN6Q85z2xm3;
	Mon, 20 Jul 2026 19:48:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784540908;
	cv=none; b=SfhuTuK8vFwoU+xZ8aubQVd/t2JDUn1pcn2SrwAgFi3fgMT2i8Q8sD9/aJMYez4fVmpG/59XuV4KKT1fkUDcilo23qGcAoazbfYSx+d5Pk8bC4UsclxkxxT9u0LWFl1lvyhacQw1XhDAoV6KgKZ08V8ymPRe8s13nhIvVSTWJL+b7pRjWCvNDPla/G9g6TtrXgGin0tbQXlQyOi4IfYAappCHo7kJ8CvWu9MwrMjTExvcHxPVUc6l4WOl2oVNVsLXOmKIPho/E4FChLeTClUwptEQu8nPWdxfAn01XH8e2h3aQ3K69YTM2GRJy1Ccgig5c8pYHHnU+BQuE/xmVEapA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784540908; c=relaxed/relaxed;
	bh=PVbzoDnpVKgVDd4gX36wEhQdxOoPAfSCiS1SYLlMuPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dKwT8Dsaev2GgFWfLCai6FTwpSvfLezwwLbNw011QRsXOh74PFCKVURg1DPSdFwWS5+J0q62O82A0euZjz09ytZViqAc3292G5nCfHPPDdaGYpBhjB/fCiliA9vmKTN+EOAt6QwIXOjcSdVj/LBqZ8l4THQEspYjr1/jhKnnDKgz8045e2ItqEkVx/nnEsya+Req9Vl/zH4qZ4AYH37+k3WUpt/PXXb3fW/kYeHoaYLv+F61Ux103H9ttu2cimAAuUyqGnj8krm54mkGqAzLNanzPgtj5qjCSBZkFzCFep2Mn7K6/oH221k3n9oBIxrX7g12CExTYChkZjeDBMokqg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; dkim=pass (2048-bit key; secure) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=dKgt1tBV; dkim-atps=neutral; spf=pass (client-ip=194.117.254.33; helo=mail.zeus03.de; envelope-from=wsa+renesas@sang-engineering.com; receiver=lists.ozlabs.org) smtp.mailfrom=sang-engineering.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=dKgt1tBV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sang-engineering.com (client-ip=194.117.254.33; helo=mail.zeus03.de; envelope-from=wsa+renesas@sang-engineering.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 396 seconds by postgrey-1.37 at boromir; Mon, 20 Jul 2026 19:48:24 AEST
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4h3bLJ1QJFz2xlZ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 19:48:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=PVbz
	oDnpVKgVDd4gX36wEhQdxOoPAfSCiS1SYLlMuPY=; b=dKgt1tBVRUujW/Or9cUu
	Njja0ewW303cV+XaqwFoCQhB4c92qFLo6R2X6sOWdGkc8aBgR5JQFhIWaEWcAIhT
	ELaWXGkWF4TQf045bOVNttofBiEbrSDZ3+Yqm8D9+bax3qCI5R5C+MS0DeCcijN9
	Fss16LtdQO5O0f9FhrRmDaKyVHMHZp98odmgKivqaj71XmC1opc0ba/4i74Ct9Gi
	DuyHeZ0ZR3DyqPF5BXuurNzEbn5sfPu0hp8WuGPLN9FFs7vr0LkZCnFCvUaW6fvD
	CQK/udY2wPkxN7LbOq1oXh8N0ro3KVlKbavEV+FZHj5TiDVYGPc1jiUWwDFBFFzV
	pQ==
Received: (qmail 2419193 invoked from network); 20 Jul 2026 11:41:39 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Jul 2026 11:41:39 +0200
X-UD-Smtp-Session: l3s3148p1@XpiKtgdXCtIujntM
Date: Mon, 20 Jul 2026 11:41:39 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Lee Jones <lee@kernel.org>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Srinivas Kandagatla <srini@kernel.org>, brgl@kernel.org,
	driver-core@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
	iommu@lists.linux.dev, netdev@vger.kernel.org,
	linux-pm@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, mfd@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 2/8] i2c: pxa-pci: use platform_device_set_fwnode()
Message-ID: <al3tU6t0LQdWYoNX@ninjato>
References: <20260720-pdev-set-fwnode-instead-of-of-node-v1-0-2dee93f42c54@oss.qualcomm.com>
 <20260720-pdev-set-fwnode-instead-of-of-node-v1-2-2dee93f42c54@oss.qualcomm.com>
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
In-Reply-To: <20260720-pdev-set-fwnode-instead-of-of-node-v1-2-2dee93f42c54@oss.qualcomm.com>

On Mon, Jul 20, 2026 at 11:24:49AM +0200, Bartosz Golaszewski wrote:
> Prefer the higher-level platform_device_set_fwnode() over the
> OF-specific platform_device_set_of_node() for dynamically allocated
> platform devices.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Fine with me.

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Note that we still need Andi's ack.


