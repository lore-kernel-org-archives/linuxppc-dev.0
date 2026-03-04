Return-Path: <linuxppc-dev+bounces-17730-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B89DCEF8FF4
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Mar 2026 15:54:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQy0n06QJz3c1J;
	Thu, 05 Mar 2026 02:54:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772639688;
	cv=none; b=jDjD1KMse5xetFoICn9K76U1DOFzM2P3m8jr3og3lTq5Mh3ugS0lHCha8xGkcy91WcjVKV4FDsiF7ufj4HGXhCdME5AcJeoMNxWTHCWfuYo+k9LBPtsv+dIZ4TDsWKH9+Ir//bbN/lxjaz5bhiRBuNi1y/nBHS8lqGRtlPYeVqFYz/ssQ8xHhyrIkgRkSrZhJgBmHytIz5lf6zSj2UlQU3niBfHV211qCnvkzbkW39yyg7ocAEEg6ce+Vp+9k20fVk+Qv8ocJ/O1E1qLmDmrxg9U/RoxNjBbahdkocwuhhWnICaHfq8cs+glgXdnRM6cVt1lD6OgKcDzkIMXpmxRnw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772639688; c=relaxed/relaxed;
	bh=aUNflHReyWfqUmyqtFNeM+CX6i4EK0uM1NVCuDgg5Gs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gjXlk9BDldmuTQTM2yJrqGVek+a24IgD4eBH+Fjv7wYRKkHA7AxH5nPRfxfRGY5ro651OG7HHm7kfhRQqceUi7qtkvF4J1+xo9yMNW3tBSj9Cf0Y+uiJspcm74PF6ri0I/9Dhj7p1m83yY4CPo5By9zRKSQvDUB5deMqq7ROHR3jn141M32EpgHip6GerJhlDYlTVIz9UnIS5GopOQ5YLfyD9tpfVYFCOwbBodD/h6Y+IJijYElA3KCOLuaXSnZIZe7lJE3w7V3Dg8CK2JqAnkYrDtqbPJ6KucdO7m4Vp4zuO2Pice9/Z5tiaPbHBZBSx4Mz3LeuaAYGsOqefLZ0Dw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MuLV5zDH; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MuLV5zDH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQy0l6x0Nz3btw
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Mar 2026 02:54:47 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2DCE343503;
	Wed,  4 Mar 2026 15:54:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D8A3C4CEF7;
	Wed,  4 Mar 2026 15:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772639685;
	bh=QlsJuLHckh6Mhy8Ly+9BkzszlQ9anHptIAU1Q9z4D6Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MuLV5zDHB7PppDbRrIgiA6DqLtvPrce7Q/kz2ceveoK6H8VNlqrQSnVWx4PUY6x7G
	 lF8PWqNnLHxmrtCGMH21sU1hTyWTcK1zQEH5n5mbASRAx/bxp+ybDJ28Aggyaql1fk
	 frx5ib6PuHJ2XXJi+zlH5K7hS5Qcj3Z/DUdYsH2ugYb22BEtUIckOzLLVxvspqhPe5
	 O0zIaXH4kNcewaC9ZZo+g+IekD3SXC32jFGTi3Rv+iMUZKMGS885FKF/WowxfN4+7k
	 p0FLMAdibE34WhcmFFwxYrZ5UJvwQppkSNV7DyytsEJkVSGu/KE0PfNw/w95AZRQrr
	 UDsFgJyGvAKgg==
Message-ID: <e7f0c171-d5f1-4b3f-9155-a774511451c1@kernel.org>
Date: Wed, 4 Mar 2026 16:54:31 +0100
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
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 08/18] PCI: fu740: Allow asynchronous probing for
 background link training
To: Frank Li <Frank.Li@nxp.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
 Alim Akhtar <alim.akhtar@samsung.com>, Minghuan Lian
 <minghuan.Lian@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
 Roy Zang <roy.zang@nxp.com>, Yue Wang <yue.wang@Amlogic.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jonathan Chocron <jonnyc@amazon.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Jesper Nilsson <jesper.nilsson@axis.com>, Paul Walmsley <pjw@kernel.org>,
 Greentime Hu <greentime.hu@sifive.com>,
 Samuel Holland <samuel.holland@sifive.com>,
 Chuanhua Lei <lchuanhua@maxlinear.com>,
 Srikanth Thokala <srikanth.thokala@intel.com>,
 Xiaowei Song <songxiaowei@hisilicon.com>,
 Binghui Wang <wangbinghui@hisilicon.com>,
 Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
 Niklas Cassel <cassel@kernel.org>, Hans Zhang <18255117159@163.com>,
 "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, Thomas Gleixner
 <tglx@kernel.org>, Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
 Sai Krishna Musham <sai.krishna.musham@amd.com>,
 Nagarjuna Kristam <nkristam@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>,
 "open list:PCI DRIVER FOR TI DRA7XX/J721E" <linux-omap@vger.kernel.org>,
 "open list:PCI DRIVER FOR TI DRA7XX/J721E" <linux-pci@vger.kernel.org>,
 "moderated list:PCI DRIVER FOR TI DRA7XX/J721E"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:PCI DRIVER FOR SAMSUNG EXYNOS"
 <linux-samsung-soc@vger.kernel.org>,
 "open list:PCI DRIVER FOR FREESCALE LAYERSCAPE"
 <linuxppc-dev@lists.ozlabs.org>,
 "open list:PCI DRIVER FOR FREESCALE LAYERSCAPE" <imx@lists.linux.dev>,
 "open list:PCIE DRIVER FOR AMLOGIC MESON"
 <linux-amlogic@lists.infradead.org>,
 "open list:PCIE DRIVER FOR AXIS ARTPEC" <linux-arm-kernel@axis.com>,
 "open list:SOPHGO DEVICETREES and DRIVERS" <sophgo@lists.linux.dev>,
 "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
 "open list:SIFIVE DRIVERS:Keyword:fu [57] 40"
 <linux-riscv@lists.infradead.org>
Cc: Anand Moon <linux.amoon@gmail.com>
References: <20260304140329.7089-9-linux.amoon@gmail.com>
 <20260304145540.3331304-3-Frank.Li@nxp.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20260304145540.3331304-3-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/03/2026 15:55, Frank Li wrote:
> From: Frank Li (AI-BOT) <frank.li@nxp.com>
> 
> Commit message has a typo:
> 
>> Fix the identation of the callback functions.
> 
> Should be "indentation" (two 'n's).
> 
> The code changes look good otherwise. The indentation fix aligns with kernel
> style (8-char tabs), and adding PROBE_PREFER_ASYNCHRONOUS is a straightforward
> addition that matches the stated intent.
> 
> AI bot review and may be useless.

So don't send us useless reviews. Trim your reply list, so only you see
them.

Best regards,
Krzysztof

