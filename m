Return-Path: <linuxppc-dev+bounces-2975-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 429E5D43341
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Nov 2024 11:07:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XkfSC65HQz3blK;
	Thu,  7 Nov 2024 22:07:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730977675;
	cv=none; b=BLZ126RDGkndcVhlNj7T1xmORoVhTE6BIWbbBxu9jCHZ9wPbmU5VfEW5lyTPdTVe4xnO33h2PuiYSbJh/jy3nJV5jzZjwA5YTbMs/FZPDSwMn7UAWkYJq1UHU4u4bzu0jA0DJSeyIevxCz69IZR/5gOkHWTY2roLPP65dTTcHGQgR50kmdAI3TImIVJ3eHdKam6csDkvalZfvPVql2kyjfWUeDFNDI2VKKjR4CQJspARI6p4HDFbtwFfl+twR+8JhW0Kkdbsi4CGjU326QLWvCATg1qdt9YXoAja4FpYFpRtunTtYFCoaxkRX+Y89jaVFpp55OBHiTPR78qBDzsf/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730977675; c=relaxed/relaxed;
	bh=crOUcDlEzUR3DZ0n6a2QmAqKobcrOvKf5Agt2Wh69jA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MB0LN9tY0aUrh4QQugTsv4WZhKDUpZMvqfFEIX8McKHZyf9pcDhYngZwzcxEvfe/ZaLXBjQChwSasKVmT5wRETZrJG79x64xgNHTwAmHC6rQfUqPqRolVcq2FwVGfUOE1qn/yD+4NxXAllv190DNKkFJ+bpN9W81Yig1gpDYohGsvMup09jmVmGOGcSUJO7uC97t7JE/U2MvywU6P/QdAEOppR0caNUiqQmhZFCCtWtcwp/Zp1e8u8XffvgNv8AE2bEzNOBWSb4KPXy0l2sMt0EH5lFNqSo/qSI5odHN0QRDQmrCXm5y1oSrcj1MutnIVBh9hV4o4ECTyCKj2r76dA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CEkUUHT2; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CEkUUHT2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XkfSB6dLpz3blC
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Nov 2024 22:07:54 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 951715C0496;
	Thu,  7 Nov 2024 11:07:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504A7C4CECC;
	Thu,  7 Nov 2024 11:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730977672;
	bh=3RDsctzj+jKcHyPmCDmgDEvkYRZVjj3F2h2JnfN6XYg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CEkUUHT2AyhLlnl5b5Kr1aHQP+HLUSQogHUG19q1+lqDySaWJ0NwDuaoCr01ID9vp
	 ErMXgC7nML7+V9kF1Mp0H2Dz1RPL/xYpcwwUr1eyHZWAw+R8FB8t7L2730xLblaMnp
	 W4H5RJYM2bn2TSm1bIAOHaonkfGI/TxTIj6+fxZZ69fnVmt5EFUWD0jBE1DVkzottY
	 LW91NKPMxk3T3e2WcVXGU0x7L64WnT80R2SpOoNMeAgUln7KQEKgcDTpKOOBRkHtxa
	 xaOyhJt+VrQA7oR8749NarQRcwH42e7ilCnd6UWg8cdc2/eWVMHqtvQvuMsaqadkam
	 dECzA0PDtrbSg==
Date: Thu, 7 Nov 2024 12:07:46 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Abhinav Saxena <xandfury@gmail.com>
Cc: linux-kernel-mentees@lists.linuxfoundation.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 2/2] Documentation: dt-bindings: Remove trailing
 whitespace
Message-ID: <gjxevyovxhymwm2ps37hfq3vmpmmr4pqmohq67llxrb2plb5zz@pvsmkqmhemx7>
References: <20241107061124.105930-1-xandfury@gmail.com>
 <20241107061124.105930-3-xandfury@gmail.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241107061124.105930-3-xandfury@gmail.com>

On Wed, Nov 06, 2024 at 11:11:24PM -0700, Abhinav Saxena wrote:
> Remove trailing whitespace from devicetree binding documentation files:
> - regulator/regulator-max77620.txt
> - interrupt-controller/nvidia,tegra20-ictlr.txt
> - interrupt-controller/msi.txt
> 
> No functional changes. Issues detected using checkpatch.pl script.

Instead I would prefer these files to be converted to DT schema which
would result in their full removal.

Best regards,
Krzysztof


