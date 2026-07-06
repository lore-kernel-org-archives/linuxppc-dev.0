Return-Path: <linuxppc-dev+bounces-23636-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D225C43602
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2026 14:49:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gv6gy30v6z3bp7;
	Tue, 07 Jul 2026 00:49:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=80.241.56.152
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783349358;
	cv=none; b=S0pbdKo66aNiglu/vU/dHL7OKgCOqItafwK2+Sha88XYfYEoa/1FffRTKHJRYZACsQ2adhINvY0UOH9BXcos11Ncx6p/5Iu8kCndMHXRnOjaiVDzgDBR6ktCrYxosvjJot3271RvhIj4lze8EkQ9xiZzvXP5fgS6Kw9Xm4IaGecCPosB6hjZ8a1MJG2QYNcYh4vfR5MkNMUUhrBCEahC3wBS0/p2gmFXDRjHDNt1V6mWy4NiQZ8pUCXFH3dY1KbMtXI45+y3UAWfwXxNA+wVn1eY1E6weed33459aInFfDvemk/uoWsMKnWAEXlTuiBFWQwxE7BzoeZrHgFc3au9uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783349358; c=relaxed/relaxed;
	bh=eulpyiUh0aznOlxmeBeXXDKWTgTsYGSGxJkchSqiGrM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RUnU0Fr/XNpqAWubDtUPPLGbZyjgLjWh2dkIhhhi/+rZVvtqofZioyGBanb87tsg+tDakVV2R44W7baiKCRp/D5vj2aA5axWhDrioG9yy9TysPJFdBadoaslamdJYBvbijvs7xsgscgEiogST2ysT871CNLja92mKczEFc3jSOyJjNwWG+pJlnJSZ/42ZcyCeOGYKGRFUe5XZvZQcAD+aTpeBBy5Y7BHFmVjs+kmp/cylB8YZHC+t6YJLTntySTtIEto8KXinitY4YT/edhfpM4/HOG3dW+ZP1D9cjss9foEEtXzYFNM8H3u/f2QLIhhl7HWOoNlZUeZXWtJa9c2aA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=uADD0ghB; dkim-atps=neutral; spf=pass (client-ip=80.241.56.152; helo=mout-p-102.mailbox.org; envelope-from=manuelebner@mailbox.org; receiver=lists.ozlabs.org) smtp.mailfrom=mailbox.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=uADD0ghB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=mailbox.org (client-ip=80.241.56.152; helo=mout-p-102.mailbox.org; envelope-from=manuelebner@mailbox.org; receiver=lists.ozlabs.org)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bit raw public key) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gv6gx0kRtz2yfS
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 00:49:16 +1000 (AEST)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gv6gr5jXVzKrrB;
	Mon, 06 Jul 2026 16:49:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783349352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eulpyiUh0aznOlxmeBeXXDKWTgTsYGSGxJkchSqiGrM=;
	b=uADD0ghBygQ7hl7LTqSuQzNrT4pfxd3Nkk3nWvmf6IB3D+bbZ8Po9+rlsavnkGLJ4uZdnA
	E6oxE7wja5lrQWqtmpkzyprJHhQUbkUKADwiXdWDyRW509f88ZfjFbVdsc2ylpT40fOOU1
	WzrrRp/KWvzTBBzYRWZJPYm3J3L0aVGbHLts233EFpwatX6mIqHFWSxS8OKrpUaHqJgDM6
	8q8JwEt/ImdukYWwmuJxsFdKcpthuzyLtn4uBC7Nb6yxlqQ9FZ9gTB4t5yU9FTpas5wHRe
	7YWXY3JENVL6v02qurgwVxEoXonNX6ionzTbrhMb+kZ8bmbK2CqpjuhuTskBOw==
Message-ID: <88ee8e5f9b87c202a563accccc224280800a8a64.camel@mailbox.org>
Subject: Re: [PATCH v3 02/20] driver core: platform: provide
 platform_device_set_of_node()
From: Manuel Ebner <manuelebner@mailbox.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Lee Jones	
 <lee@kernel.org>, Thierry Reding <thierry.reding@avionic-design.de>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller"	 <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski	 <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Srinivas Kandagatla	 <srini@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul	 <vkoul@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich	
 <dakr@kernel.org>, Rob Herring <robh@kernel.org>, Saravana Kannan	
 <saravanak@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael
 Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)"	 <chleroy@kernel.org>, Andi Shyti
 <andi.shyti@kernel.org>, Andy Shevchenko	
 <andriy.shevchenko@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will
 Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Doug Berger
 <opendmb@gmail.com>,  Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list	
 <bcm-kernel-feedback-list@broadcom.com>, Ulf Hansson <ulfh@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team	 <kernel@pengutronix.de>, Fabio Estevam
 <festevam@gmail.com>, Matthew Brost	 <matthew.brost@intel.com>, Thomas
 =?ISO-8859-1?Q?Hellstr=F6m?=	 <thomas.hellstrom@linux.intel.com>, Rodrigo
 Vivi <rodrigo.vivi@intel.com>,  David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, Peter Chen <peter.chen@kernel.org>,  Paul
 Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>, Philipp Zabel
 <p.zabel@pengutronix.de>,  Maximilian Luz <luzmaximilian@gmail.com>, Hans
 de Goede <hansg@kernel.org>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=	
 <ilpo.jarvinen@linux.intel.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: brgl@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
	driver-core@lists.linux.dev, devicetree@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
 iommu@lists.linux.dev, 	linux-pm@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, intel-xe@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org, 
	linux-mips@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	mfd@lists.linux.dev
Date: Mon, 06 Jul 2026 16:48:48 +0200
In-Reply-To: <fbc50f89e0c3bb148656a3b8d96974f591576dec.camel@mailbox.org>
References: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
		 <20260706-pdev-fwnode-ref-v3-2-1ff028e33779@oss.qualcomm.com>
	 <fbc50f89e0c3bb148656a3b8d96974f591576dec.camel@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-MBO-RS-META: yfo5gat8zopp9bgmyshyyaocgtadhjyy
X-MBO-RS-ID: b5b23e49645ac2d82f8

On Mon, 2026-07-06 at 16:39 +0200, Manuel Ebner wrote:
> Hi Bartosz,
>=20
> On Mon, 2026-07-06 at 14:44 +0200, Bartosz Golaszewski wrote:
> >=20
> > @@ -693,6 +693,24 @@ int platform_device_add_data(struct platform_devic=
e *pdev, const

Nevermind, I got confused because of @@ int platform_device_add_data() and

> @@ -619,6 +619,13 @@ static void platform_device_release_full(struct devi=
ce *dev)
in [PATCH v3 05/20] driver core: update kerneldoc for platform_device_alloc=
()

Sorry for the noise
 Manuel

