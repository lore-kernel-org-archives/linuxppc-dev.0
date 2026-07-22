Return-Path: <linuxppc-dev+bounces-24632-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE5FBC4451C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2026 07:28:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4m7s32y0z2xnK;
	Wed, 22 Jul 2026 17:28:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:4f8:c0c:9d57::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784705305;
	cv=none; b=f7WUzSV+3/AtP6MrzQlEgHdpqdV2rWtPYRCCMVT594P08NnxbQRQ+2FQnGfqEvHORXvCBbatSsJDcQedCo3lRMs10KX0egfVLpZ4oQaBkpZ94dl+qlfptp9t/AgFBhq6k3z/LJQNl67HmReC1TI59DnkI1TrN+XcWwthyUpQ55MgWYZ6VnrU1KpAj2Rdh/B9xROmWkBslTE18PnSl6PAG9fRHhAFhyUYdemYN9kVj/p5AcOdz20F8Hc61fqGaO63JyTXEOxj1BtRCbuFHdcCdgaNI09mAFg+xry1slzWIz7quvPF/LEWoGafmKmAEDWnA4ox86CCnwmLY/XngzIQEw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784705305; c=relaxed/relaxed;
	bh=c67ixvgOobnsD9YZ1g1D2/zxbHV0RHVU8Y3paFRKUfE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=hZR6xPpesUk3so1E4C411cTBaiHvj5V7qMlhnEwfMSrVrBSj5r2hC8DIOAGppUFtfS5KQPbh52jrIC+ss0xtbm+f6pB/zMTBQNuHvUYAeRrH08IcBDk8WnvFmJddDmxZbNegsQ2882X6FqKv9S9oqqAv8HHmFjBKZDfrv84nyhqAvgMQtwB8J0YjJn1VAu3QrLKHJYyki1J/fzzlYlFxf69elb0yDFAUj1emW5peb/dhMpro/LHfg+VA8MAoVmKM5jxijm2mn9jJ43ErQWlnRPplXhRLz0R9+L65lTeFk0ZLKtOIldodAdycJmIrDNfkB/ihDXyUenTOlgln5ecb/g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass (client-ip=2a01:4f8:c0c:9d57::1; helo=mail.3ffe.de; envelope-from=michael@walle.cc; receiver=lists.ozlabs.org) smtp.mailfrom=walle.cc
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=walle.cc (client-ip=2a01:4f8:c0c:9d57::1; helo=mail.3ffe.de; envelope-from=michael@walle.cc; receiver=lists.ozlabs.org)
X-Greylist: delayed 569 seconds by postgrey-1.37 at boromir; Wed, 22 Jul 2026 17:28:24 AEST
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4m7r2Rx4z2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2026 17:28:24 +1000 (AEST)
Received: from localhost (unknown [IPv6:2a02:810b:4320:1000:4685:ff:fe12:5967])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 60D3312F;
	Wed, 22 Jul 2026 09:18:49 +0200 (CEST)
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
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Jul 2026 09:18:48 +0200
Message-Id: <DK4X0XV6ZM1E.2L9G007WXO2J6@kernel.org>
Subject: Re: [PATCH v4 phy-next 1/9] soc: fsl: guts: perform fsl_guts_init()
 error teardown in reverse order of setup
Cc: <devicetree@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@lists.infradead.org>, "Ioana Ciornei"
 <ioana.ciornei@nxp.com>, "Vinod Koul" <vkoul@kernel.org>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Tanjeff Moos" <tanjeff.moos@westermo.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Shawn Guo"
 <shawnguo@kernel.org>, "Frank Li" <Frank.Li@nxp.com>,
 <linux-kernel@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Vladimir Oltean" <vladimir.oltean@nxp.com>,
 <linux-phy@lists.infradead.org>
X-Mailer: aerc 0.20.0
References: <20260721231603.67865-1-vladimir.oltean@nxp.com>
 <20260721231603.67865-2-vladimir.oltean@nxp.com>
In-Reply-To: <20260721231603.67865-2-vladimir.oltean@nxp.com>

Hi,

On Wed Jul 22, 2026 at 1:15 AM CEST, Vladimir Oltean wrote:
> Michael Walle has confirmed that ignoring the error was intentional,
> and we preserve that:
> https://lore.kernel.org/linux-phy/DK44809N7Y8I.J2Z3U4N32H0Q@kernel.org/

I thought you wanted to check if kasprintf() fails and return an
error? Just to be clear, I'm fine with either way.

-michael

