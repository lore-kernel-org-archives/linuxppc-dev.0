Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EABE606A32E
	for <linuxppc-dev@archiver.kernel.org>; Sat, 14 Nov 2026 10:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=AQuAO0+L
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jRVCj5ZQZz30DY;
	Sat, 14 Nov 2026 21:06:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.27.42.4
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794650817;
	cv=none; b=EfhZpkRjuFyOcJz8fnZzio9i2ldeM/uV8AJ9FjgjnQihhTzEPeCZqSm/+V60XHsc6DO/53fg9INAxZh3F9Wdv8hrluvmcUtArxnENklG6PLn29/ci56LRC6vCdAnWY5Gcw2o0YW4tNPg1LH3fMan4xhKoxeaPXvjtS/r3KN+M9jbeQ+LCm+bbE+ogguciGSAYVehV6JN5fPySss2g0q6HJLl9E+In6O6nBmz4admV1fYyAxdrvDzcKqVLXy3acFHbLvtR2z5rTBccV6LU6+tpEB3W+GlmxOL6hI9IiO6lkPhwdf9iKPeVt+fxqhy/nz7Bg61479fA0NI6gcptl5sRw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794650817; c=relaxed/relaxed;
	bh=nA9uVd9Z0U/OOJAJirWA9SKPkRY0C9MO6GKy6l0PlO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISKU9GYMEYzUO2YlnMlWN+l8/a/18Vy3U+2BSxmuKGBemKNITigROVkXtMVhxZC8TzVK+JcHZg4sMKMRgMIBCNFQy9e08Fys91rDdhanSUeUXY2DdqHlP30O/Ak3HjrzxvTUfKSSdfCDvxS042EBCCqJT2ybyXWSvyheH6yunyKr6Sa84LHnNBowJK34NZoGOkZ1leQ2nxhjKZGQ4BNES3nKOScc7dy/QJ6O6j9Lp1kir4B5K0VIMM7fDgSZo+Azvd4/+9FZpjlZFw0DTReCNsKsIR3US7ytnRM8C3hb2hpO1rMkaa4uXFXRvXGBLfIe17ulhiRDJlDu+MQlH3Sr4g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=AQuAO0+L; dkim-atps=neutral; spf=pass (client-ip=212.27.42.4; helo=smtp4-g21.free.fr; envelope-from=vjardin@free.fr; receiver=lists.ozlabs.org) smtp.mailfrom=free.fr
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=AQuAO0+L;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=free.fr (client-ip=212.27.42.4; helo=smtp4-g21.free.fr; envelope-from=vjardin@free.fr; receiver=lists.ozlabs.org)
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jRVCg3l8fz2yqw
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Nov 2026 21:06:54 +1100 (AEDT)
Received: from L30177.local (unknown [78.241.242.250])
	(Authenticated sender: vjardin@free.fr)
	by smtp4-g21.free.fr (Postfix) with ESMTPSA id BBAB619F57E;
	Sat, 14 Nov 2026 11:06:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1794650809;
	bh=g0Aj3QD5cJIwmcGFVWYqEOdOoEhMM0NOddv6KOjkgb8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AQuAO0+LZLEF/gQfONel9daJSQ5G+M95vDYtU9EaA81yx0jCh7xMnXqRLFgMJBU9K
	 jeOuqebH4GbanWCKhqhNViberAirFwC36UCWL77DI4wzGunWvC5L7kd1A0VyS2kvzv
	 q1ANqthOBT7i5HnPa6QJVVK1pWT8laUcldqzv5BvOYFdmwEkhliKxq6HWuLnNMJnJc
	 J8eEOBvLyLi+Grsj+LX16XZw2uVEhzq42HFUCJbHMBREzYGMMPbyL5n5bG1NIAiQIT
	 vS8liQaaogXWcElLIw2rjPZBVMty3c9qR5g6YqYGv9+CHx13rwb+N4Vuk3Kbvb3lis
	 Dt0bnTZBHj5YA==
Date: Sat, 14 Nov 2026 11:06:22 +0100
From: Vincent Jardin <vjardin@free.fr>
To: Linus Walleij <linusw@kernel.org>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>,
	Frank Li <Frank.Li@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP S32 Linux Team <s32@nxp.com>, Linus Walleij <linusw@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Subject: Re: [PATCH v4 3/5] soc: fsl: guts: add the RCW override of any RCWSR
Message-ID: <avgynp6NS1u2-2Qv@L30177.local>
References: <20261114-for-upstream-lx2160a-rcw-pinmux-v1-v4-0-eefcea066a55@free.fr>
 <20261114-for-upstream-lx2160a-rcw-pinmux-v1-v4-3-eefcea066a55@free.fr>
 <d0f781bf-a325-4eee-9431-7eb387279934@kernel.org>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d0f781bf-a325-4eee-9431-7eb387279934@kernel.org>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Linus,

> Acked-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

With this ack and the reviews from Rob and Frank, my understanding it
that the patches 1 to 4 can go into the pinctrl tree, while the
patch 5 can go into Frank's tree once the driver is in.

Am I correct ?

Thank you,
  Vincent

