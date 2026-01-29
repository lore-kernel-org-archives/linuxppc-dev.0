Return-Path: <linuxppc-dev+bounces-16402-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAEFBD61033
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Jan 2026 17:14:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f25Mx6vy3z2xnh;
	Fri, 30 Jan 2026 04:14:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769706845;
	cv=none; b=VUVFfRsUSL51P/3x7w/kEhAvXcF0/gh4Kqj/l8WqjMvfzWJlwxWwp+KJv0yDMA7RA1A9n20Y0gMkAp0SJeBOTOP9lq2bDJ8w25Bq/qZx3ON4dsbf1a2LFcnq1kFGkjFwghFVihaXfuNWbspJSKiYjeo8KSIxzVKWqUKV/HPNGPOjWz2nyIAMl4rKxMZdIRYBC/qTYBBrpVb8H9fhTvtNVxqlzYdq/xKKzjM0V8OXZWQyqAKh5rdVUzrG0D7SozzQ+oe1C1f9VXCNUWvK9yHL/sceBFQXnUPLGoqoBVAtL83iZPkmsUMqctNQAiUl0JgoJzF7CnisoUJJWzfR/m417A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769706845; c=relaxed/relaxed;
	bh=iHDlefDFBwuxIW8YrPkmorwA2xDfjyztN0fMf0dmC78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lcd5dq//1SwX69sT3FYYPIbAOxfdmHNa4VwWo6v9AbclFrcKQVlB5fF8VUoqAXbmnUM8Q6rt48uNZ8bOPkA2djhsf/9qqpyKVd9G5HTmC2On2vHumMtIm8wYeaZWbEgeI/6Yxjbr0YDd9MZnevLC84lRVk8W0/SVHEnXGzS+IC8v+q0NHb/nvzWXT0ZCteOlfkj1Kw4T3tsGFxupSnplP0/ePtbTQ7gu/fP0ztX+GDVkQ4soDfmjB3b4dilRDrk9Xo4HZ7vvRvUUvO4R+HS9Kr/CHsVxakRuCaSZzOf94PxTBvvimThvFDyzxA62OUwv1vT9kNiynJceHs9o0EN1PA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tN4zAYJX; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tN4zAYJX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f25Mw6RKzz2xQs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jan 2026 04:14:04 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 34FCB60054;
	Thu, 29 Jan 2026 17:14:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B720BC4CEF7;
	Thu, 29 Jan 2026 17:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769706841;
	bh=27kNKSKigZ302oO4twnPMLC0uG5HbWa0Z1KJS0oe/D8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tN4zAYJXAZpEy3d6ProYbKGSY739oMbmdfcn5NU4TuOi72e2duwvu2H4xBEsLEWiC
	 +JfvZeFm2UoEdMRZd47svwmODAxX4pi3zeaF22UV2W/nuE39wNgGsFhdZlmYMie1ta
	 Nx/EhbK+wOMQoo6E+UtPTGBdAU+fTt5ml2q7wY8+UX2f35E1r04rmfWgxcV1rW4H0s
	 q2/gPbIS54mC4uNOSqn1qmQZyZzuBAZEE6VlKzYlw5CsXsJoYKtAcDPJPCQ4gB16cp
	 foi/HCKIAOHR6emQmWYkoPwzBE2XfhY7zv2hG+EzWGi58mMWxeiYd7rERf/JO/Mpv6
	 wDcR4TVpKurRA==
Date: Thu, 29 Jan 2026 11:14:00 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Russell King <linux@armlinux.org.uk>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Vinod Koul <vkoul@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	llvm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-clk@vger.kernel.org, imx@lists.linux.dev,
	dmaengine@vger.kernel.org, linux-media@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v3 00/12] of/treewide: Simplify with
 for_each_compatible_node_scoped()
Message-ID: <20260129171400.GA1287342-robh@kernel.org>
References: <20260109-of-for-each-compatible-scoped-v3-0-c22fa2c0749a@oss.qualcomm.com>
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
In-Reply-To: <20260109-of-for-each-compatible-scoped-v3-0-c22fa2c0749a@oss.qualcomm.com>

On Fri, Jan 09, 2026 at 05:57:44PM +0100, Krzysztof Kozlowski wrote:
> Dependencies/merging
> ====================
> 1. First patch is a prerequisite for entire set, so either everything
>    goes via same tree, the further patches wait a cycle or stable tag is
>    shared from DT tree.
> 
> 2. The last media patch depends on my earlier cleanup.
> 
> Changes in v3:
> - New patch: cdx: Use mutex guard to simplify error handling
> - Collect tags
> - Link to v2: https://patch.msgid.link/20260106-of-for-each-compatible-scoped-v2-0-05eb948d91f2@oss.qualcomm.com
> 
> Changes in v2:
> - Update also scripts/dtc/dt-extract-compatibles (Rob)
> - Collect tags
> - Link to v1: https://patch.msgid.link/20260105-of-for-each-compatible-scoped-v1-0-24e99c177164@oss.qualcomm.com
> 
> Description
> ===========
> Simplify for_each_compatible_node() users with a new helper -
> for_each_compatible_node_scoped().
> 
> Best regards,
> Krzysztof
> 
> ---
> Krzysztof Kozlowski (12):
>       of: Add for_each_compatible_node_scoped() helper
>       ARM: at91: Simplify with scoped for each OF child loop
>       ARM: exynos: Simplify with scoped for each OF child loop
>       powerpc/fsp2: Simplify with scoped for each OF child loop
>       powerpc/wii: Simplify with scoped for each OF child loop
>       cdx: Simplify with scoped for each OF child loop
>       cdx: Use mutex guard to simplify error handling
>       clk: imx: imx27: Simplify with scoped for each OF child loop
>       clk: imx: imx31: Simplify with scoped for each OF child loop
>       dmaengine: fsl_raid: Simplify with scoped for each OF child loop
>       cpufreq: s5pv210: Simplify with scoped for each OF child loop
>       media: samsung: exynos4-is: Simplify with scoped for each OF child loop

I applied all but the last patch which did not apply for me. Send it 
next cycle.

Rob

