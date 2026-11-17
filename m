Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9B9606A338
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 16:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=oM6f103S
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTVv33fc1z2xl0;
	Wed, 18 Nov 2026 03:44:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.27.42.6
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794933871;
	cv=none; b=ocAOF7cOI64lxwuJkrDDR7Sjc04og3xkbiKwM1HoJ3S4zQMeUaJNM4yaPExslmsDI9MPJMZR1hriSZcppQCur6MfGrrAvnshONAFcLLraO62YXIsmQ1CxZotq6pBIvTvJlsIZITgRx+jvgy0C4uyvTWK0f4ERAOnqk4yfokRjKHgju/GF3Hjdh9gtL+C+FKL3UOoxKYyMxUewkhQjKt0dF3HNqhNDITe02kzivi4UGq1xyZ/nyfPeqgs2qehaPtgoPF/2Yh0KUEx6Eok+uxctmdTY6ODh6cqG4QDTnbgXkyl2Wm1yN/EnIJAKHyTvzi97Y5v35HygTn8F1i562DroA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794933871; c=relaxed/relaxed;
	bh=mmhsYfo4oARdZWXfsQFEQDsYzn+5x9KB/AI2fdJWlJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dK4tqkrFXBerwe8GEz7Q4opN3MdEjJWKSKPmqvh1NdXTokif6cfzLOIGY8FW7ffHjBcjNizVpeCCBKddnchJvqK7O4rQB4+v+oTPrtEkb0twvsfYH+glQgj8AWsYkDmNrtXqb+qP9fOAuTNM7+6b0he7ZiqoLC73tbpGdQO3Th6A4BBvWhhE0vcOTIXiP6byWvJYXqF3Mdoh/GhOUcQtFOIxpn/yBaFjfMVbZppb9op3PpNn4fyUDbRSqbNB1g/dSeD5JOcb27H1TZ5jNyAXwibtXP/9TtHV2CqQsWy/xCWiqlAlKadcIgx3C3+ncXGqno2OEp7dRTj0zvhYwVWilg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=oM6f103S; dkim-atps=neutral; spf=pass (client-ip=212.27.42.6; helo=smtp6-g21.free.fr; envelope-from=vjardin@free.fr; receiver=lists.ozlabs.org) smtp.mailfrom=free.fr
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=oM6f103S;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=free.fr (client-ip=212.27.42.6; helo=smtp6-g21.free.fr; envelope-from=vjardin@free.fr; receiver=lists.ozlabs.org)
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTVv23z8pz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 03:44:30 +1100 (AEDT)
Received: from L23803.iliad.fr (unknown [213.36.7.12])
	(Authenticated sender: vjardin@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 505A978050F;
	Tue, 17 Nov 2026 17:44:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1794933866;
	bh=8l2fTCrBkpqaY8HCGM4+a4lOBeNcGWo5zClpf/ajZ4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oM6f103Ss/FYzVeyiPMkUl88MqlTQDs0RMWOZ/YH3RrGQ9jocwoPKT4ozk682LsEL
	 edaTT5pXBvxGo6YRUjs2zEEKVzeoguISXqseXFnycNDnsnf9DNBYoi4FWlTMweSBDn
	 o1VOEeATe1ZhFbc8EBpEmVf5nfXKBx7QajVgGRpq+32vod1+9bjRErp9cGfmCK2L0c
	 Bzj7pTLCGTrVyOO325anFqd6AqlCtO0b9e/X0FFSqAiOK2TRSXb9JQ3Cie/rYT0e0p
	 lc0C1MF+QDCdHJfXwNmlkI/XPfXNTvon8HzJCOFSgxDLTAfEISvhSdUo7sX2bUT0Z/
	 nMmm42FPMwU2A==
Date: Tue, 17 Nov 2026 17:44:00 +0100
From: Vincent Jardin <vjardin@free.fr>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>,
	Frank Li <Frank.Li@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP S32 Linux Team <s32@nxp.com>, Linus Walleij <linusw@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: Re: [PATCH v6 4/5] pinctrl: freescale: add the Layerscape RCW
 pad-mux driver
Message-ID: <avyEUKJBiDwxpLt7@L23803.iliad.fr>
References: <20261115-for-upstream-lx2160a-rcw-pinmux-v1-v6-0-fbdce4565a5c@free.fr>
 <20261115-for-upstream-lx2160a-rcw-pinmux-v1-v6-4-fbdce4565a5c@free.fr>
 <avtsY-7-I7_pdyD0@lxl00025.wbi.nxp.com>
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
In-Reply-To: <avtsY-7-I7_pdyD0@lxl00025.wbi.nxp.com>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Vladimir,

> The "i2c" and "gpio" functions of lx2160a_sdhc2_data74_funcs[] here
> hides some real unpleasantness. These 4 pins either get all assigned to
> I2C7_SCL, I2C7_SDA, I2C8_SCL, I2C8_SDA, or they get all assigned to GPIO.
> But they cannot be assigned in pairs of two (or individually, i.o.w. not
> in the granularity we need), which makes independent I2C bus recovery
> practically impossible (i2c6 as I2C while i2c7 is as GPIO).

yep, the doc is clear about it: SDHC2_DAT74_PMUX is a single field for
the 4 pads, 0b001 gives GPIO_2[18:15] and 0b010 gives IIC7 and IIC8
together (RM rev 1, 4.9.8.9). IIC7 and IIC8 are not available on any
other pad.

Checking from other angles, the A-010650 workaround uses one write for both
buses: 0x700100130 = RegA OR 0x031. That mask looks wrong to me though: bits 5:4
belong to SDHC2_BASE_PMUX, and OR-ing 0x001 onto 0b010 gives the reserved
0b011. Could someone at NXP have a look ?

> The way the code is currently written, the pin_request() call will fail here:

Yes, in fact, it is not new with this series: both nodes have shared the
same setting since
  8a1365c7bbc1 ("arm64: dts: lx2160a: add pinmux and i2c gpio to support bus recovery")
from Carlos Song (NXP) where the two pinctrl-single states covered the same
bits, so the second controller would have failed the same way. Wihtin the
kernel, there is no board that enables i2c6 or i2c7, so nobody did hit it!

> Due to the fundamental issue of this limitation, I don't think it makes
> sense to have the pinctrl states described in fsl-lx216x.dtsi for i2c6
> and i2c7. Perhaps you could remove them in another change (either as a
> follow-up, or another patch in v7 if you need to resend).

Done for v7 as an additional patch: the DTS drops pinctrl-names, pinctrl-0/1
and scl/sda-gpios from i2c6 and i2c7, and the two states nothing else uses.
A board that needs one of these buses can add its own states, or set the
field once with a hog on the pad-mux node.

I tested on my board for regressions, since there those 4 pads carry
the eMMC DAT[7:4]: the other I2C buses still set up their GPIO recovery,
and the eMMC still runs in 8-bit HS400.

I also went through the other fields. 7 more settings mix two
controllers the same way:
 - flextimer on iic2, irq3-0, irq7-4, evt4-3 and evt2-0 (FTM1 and FTM2 channels)
 - sdhc-spi on sdhc1-base (SDHC1 with SPI3_PCS0) and usb on usb-ext (USB1 and USB2)
No dts claims any of them.

About your previous comment on clk-out: v7 names encoding 0 "clk-out".
On my board, with debugfs, it shows now:

  pin 20 (evt2-0) 0:? evt
  pin 21 (clk-out) 0:? clk-out
  pin 22 (asleep) 0:? asleep

and the U-Boot port of this driver shows "clk-out : clk-out" in
"pinmux status".
My take: the reserved marking comes from RM rev 1: its revision history
says "Updated 0b000 as reserved" and the CLK_OUT configuration section was
removed, while table 19 still lists 000 (CLK_OUT).

There is a similar gap on EC1: the signal tables list CLK_OUT2 on
EC1_TXD0/GPIO4_DAT03, but EC1_PMUX only has 0b00 RGMII and 0b01 GPIO,
0b10 and 0b11 being reserved. Would you know which value selects CLK_OUT2 ?

thank you,
  Vincent

