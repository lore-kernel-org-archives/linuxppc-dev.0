Return-Path: <linuxppc-dev+bounces-25084-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 358E4C54FDF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 08:14:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9hnS43NPz2yks;
	Thu, 30 Jul 2026 18:14:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785399276;
	cv=none; b=I2A0oqg3GwlZCCpwpSSE8Lo8ZWeJIHhzvk1mhNEzvs/oz2DWuLIaO6Vg0sPQ2YMD/ix6P6nQtQpPaZm2aCqe3ElW5ZDYh+rMpmXL1T6GpfZVXXaBmTzvtDp7plwSMdYkt3Ww9gKQQtvSz0TKhuH7sIY0+6oVIIGTxsokiP/jIJ9TMXW7uTXj4iFhrvoxX1g03RDENDbGlQXk0cnHfLBsJ7eK2mxXaqk9V3E7/q8NVh+ewA8Xqbcxr13EoBtJhtYSKV6ZkaQ1eKU0xjSiGJanDfNT52Uxx5vSAWXnm1XOYOeeweMqwrzmm1G4RLpDssJSmMAZRbZIKMnxUrgxyFLPKg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785399276; c=relaxed/relaxed;
	bh=SwkH9XaoCa13wc4+S4EGR+0lca2+/4IaQb96VBK1TQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bQ4g5CvNlVseDJJ+HeXrvuAi/i5f10J7U0fw1FlyJzSjsM55eCB3i16SOsYDXE6KA7BNZLb+du2fIH9RbBa+jUf5ev4bO6JxOjQYWwro8iqkHj3XvghkhFM0pFTsfy0L7HSb2tvg/ZjssFMiilDTYaGLbqBo5JcNnKh9dylanO+UpNWPHyrKzGso0luE3v63SDvMWMiNa1LloATv9+r3+RHZHocS6VaKCC3Ub5zqC/2tydaZtkZ/q4OtlTcfsKba0I5+87CWAouV2/9NwtuZfPvFnn3UjtY4foUFV82prLQdJd4lVqsDddzfdsZm6m/LeOv9j129daRXaqfHIp9Jcg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DDjRuhBN; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DDjRuhBN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9hnR3xMrz2yhb
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 18:14:35 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id AAFA643672;
	Thu, 30 Jul 2026 08:14:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E5E01F000E9;
	Thu, 30 Jul 2026 08:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785399272;
	bh=SwkH9XaoCa13wc4+S4EGR+0lca2+/4IaQb96VBK1TQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DDjRuhBNK1vDBHwwDcwRemcaBGxrBHsfylBpk9kDXZvEtRahMvanJmpvZWgBVv84J
	 yVfbP/gRptzDKqH0dnM6NfYddKHZ3TXzoFyODtDtZCWC9qVaZ+zGFhQ3vGu2h50neb
	 t+z8+tyj6g5l8Q5i05KsGbclo4uzY+ABO16Cz6CMKSBQ+hrJ8jdok1M1VHUMGznZGp
	 o5lj16rc1kbbZkokh5l7VBZj7/LoVWSxAixYzCvFG2O+FyUAMyIWtMour4YAEVWmaR
	 Y+h1M76EZ6ZF77Ylmp1rVjtRgVA3hTJvcIJMcGzQonKC7l1GaFNEbVmxwut8OiRiYR
	 6PXg2kUAH9J3A==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: linux-phy@lists.infradead.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Christophe Leroy <chleroy@kernel.org>,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Tanjeff Moos <tanjeff.moos@westermo.com>,
	Michael Walle <mwalle@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 phy-next 0/9] RCW override for 10G Lynx dynamic protocol reconfiguration
Date: Thu, 30 Jul 2026 10:14:07 +0200
Message-ID: <178539922189.574381.6258263697994334139.b4-ty@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260721231603.67865-1-vladimir.oltean@nxp.com>
References: <20260721231603.67865-1-vladimir.oltean@nxp.com>
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
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1716; i=chleroy@kernel.org; h=from:subject:message-id; bh=Qt+vOFxP9nNU5Yu1070glj6/XYtWpjM8nIz+zpYRJJ4=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWRls18UjW8ryxGu0F176CvH16WSOYzJUtvUowOq1hyLy DNI9FPsKGVhEONikBVTZDn+n3vXjK4vqflTd+nDzGFlAhnCwMUpABNRuM7IMNVulcS7qB/uh298 +bfu/OcU5kNBX1YsuCRyJqH3exHfljUMfyXsXdvfG+bZPippu3/8aK3YA5fapKtLlVtkr3TsyPc UYQYA
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit


On Wed, 22 Jul 2026 02:15:54 +0300, Vladimir Oltean wrote:
> Previous set "New Generic PHY driver for Lynx 10G SerDes":
> https://lore.kernel.org/linux-phy/20260610151952.2141019-1-vladimir.oltean@nxp.com/
> introduced the 10G Lynx SerDes driver with a reduced functionality set.
> Namely, only minor protocol changes are supported (1GbE <-> 2.5GbE).
> The major protocol changes need a procedure named RCW override,
> explained in more detail in commits 6/8 and 7/8.
> 
> [...]

Applied, thanks!

[1/9] soc: fsl: guts: perform fsl_guts_init() error teardown in reverse order of setup
      commit: c200e79a5e3a9af0ed368f2f60ecbe37c3077d48
[2/9] soc: fsl: guts: use a macro to encode the DCFG CCSR space
      commit: 77a46f8fa169b1c01940c4c12851dd4a07f8de4a
[3/9] soc: fsl: guts: add a global structure to hold state
      commit: 2c498f7254acf7ec0c0c589c0e42024ffdd6e81b
[4/9] soc: fsl: guts: add a central fsl_guts_read() function
      commit: 51749b225c21889e4c59c5850ec14c392b8d17b0
[5/9] soc: fsl: guts: make it easier to determine on which SoC we are running
      commit: 9ee864e5c28b30b97db03b9e94c1624484a46e30
[6/9] soc: fsl: guts: make fsl_soc_data available after fsl_guts_init()
      commit: 989c49a752850789eec8a79a68613210b11bc765
[7/9] dt-bindings: fsl: layerscape-dcfg: define DCFG_DCSR region
      commit: 086923eb1fef29995ffdf75cb7574dc947caf5e8
[8/9] soc: fsl: guts: implement the RCW override procedure
      commit: f1ab3e661b457937cc1cb975e9f2090f6b6de6d7
[9/9] phy: lynx-10g: use RCW override procedure for dynamic protocol change
      commit: 2e233235fd463c65188626b9cc5e272c5ee96c07

Best regards,
-- 
Christophe Leroy (CS GROUP) <chleroy@kernel.org>

