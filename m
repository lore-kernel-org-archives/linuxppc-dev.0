Return-Path: <linuxppc-dev+bounces-23437-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78130C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 17:35:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grkYr3zvfz2xLq;
	Fri, 03 Jul 2026 03:35:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783013744;
	cv=none; b=nDHz3ABeIpqh2xI9QAVs/aV8GiPN7N/EMHciUb5FOS8AByU/sh0A4XIIEeuHspHu0KUURzhmc4UhJQINWHCUmi5O8ThXGzXA+JuctnPk+p7KUzDjsnnq4RYq/7kx/bdhTbPz1JUbzb7S4mCHXY1LKE++8GuU1M7GSrWJ5V8TpxB5DPbiQX49eRfXxTerPGY9l9RTwznqHB1rlBTpOenxg90nxAPVgmWx/yNMXbCQmMq2Th/HaCJNEYbjVxF16wDX39nplDJOJdXsYaWrUm3x8l+DAgdnhKQkZcMBZ4l3pWHscIfz9ZQwTXrHroW5u1JzNqtNwHv7hnerV6n/onWU6w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783013744; c=relaxed/relaxed;
	bh=DaEsGQyA9lchO5J2AFHDiPCEx3TudYnthel4tv0857M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O0sg50eKsVAjfwMq2t9pXa/bTmBqFJOK9o01k83p31yy4ijccm7yO7pqJARD2nXRowH89SvDBN7fLPiePUbBl0C1H4bHVaG8lxXhz0zqzfyWoCTfPOJ/D3ly8TWwEpLvlXWn2v190xS24l/ZuGkdwOekCz15lCiQYk+Ke5ZDBzwuxuiv0KgwXoqFRxwvJwqYtgjNZxv/No8pYvyHLMjg40tPbKKadePX7gDAn0b/E7EwEDeoemzIhDYP4Ek679/Dsh2NiWrCw9wIVCo0R+XZxvK7nyAbIRQGJRawxEwbUNAIzi+wgtcYnTLNLiaJgEu3N9YigdwgL/71gpjN8UlI0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=uUye/Yfp; dkim-atps=neutral; spf=pass (client-ip=185.171.202.116; helo=smtpout-04.galae.net; envelope-from=maxime.chevallier@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=uUye/Yfp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=185.171.202.116; helo=smtpout-04.galae.net; envelope-from=maxime.chevallier@bootlin.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 177 seconds by postgrey-1.37 at boromir; Fri, 03 Jul 2026 03:35:42 AEST
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grkYp2nnFz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 03:35:42 +1000 (AEST)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 7C288C4FEE8;
	Thu,  2 Jul 2026 17:35:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DF68B602EE;
	Thu,  2 Jul 2026 17:35:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 032F3104C9590;
	Thu,  2 Jul 2026 19:35:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783013737; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=DaEsGQyA9lchO5J2AFHDiPCEx3TudYnthel4tv0857M=;
	b=uUye/YfpNoN/FMZ4X1Cn5/O4LhI3ptQAjczCfgJX3Bgk4hJuMyoIOcI0vKjJFYSg4hta1o
	NueV4e13bB7rgP9zShZjzGVlRgHXl31jmbYmC490Y5gAkRP2hr+Te8eqPXQrEsPsv0LcOk
	i0wP3lPGzw8jKCoXv99iRmQKTa57dYfQwlxKM5hpRBGwWZe7z+AWr3aE1dxEsB+riUbAOi
	cjEd2M1+miyQmR7++DBBR/jO8ubnNEQVvFGttwGquZNFNlM3CtpTmuCodM/r1++YovdfRz
	kOSQB8asI5ks9XwqQ9/PmKCvMR7wB/YFw4S23LaDauAsQ0sfRIBYg8kIvdWnPw==
Message-ID: <11de0ecc-17af-4f64-884f-e1b146d80aaf@bootlin.com>
Date: Thu, 2 Jul 2026 19:35:33 +0200
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
Subject: Re: [PATCH v2 net-next 08/14] net: enetc: remove invalid code from
 enetc4_pl_mac_link_up()
To: wei.fang@oss.nxp.com, claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
 xiaoning.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, wei.fang@nxp.com, chleroy@kernel.org
Cc: imx@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
References: <20260702025714.456233-1-wei.fang@oss.nxp.com>
 <20260702025714.456233-9-wei.fang@oss.nxp.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260702025714.456233-9-wei.fang@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 7/2/26 04:57, wei.fang@oss.nxp.com wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> When adding phylink MAC operations support to the NETC switch driver,
> Russell King pointed out several pieces of invalid logic in the
> .mac_link_up() implementation (see [1] and [2]):
> 
> 1) Half-duplex backpressure is not supported by the kernel, Ethernet
>    relies on packet dropping for congestion management.
> 
> 2) phylink_autoneg_inband() is unnecessary, as RGMII in-band status is
>    not supported.
> 
> 3) TX and RX pause are disabled in half-duplex mode, so there is no
>    need to override them in .mac_link_up().
> 
> The same invalid logic is also present in enetc4_pl_mac_link_up(), so
> remove the invalid code from it.
> 
> Link: https://lore.kernel.org/imx/acEIQqI-_oyCym8O@shell.armlinux.org.uk/ # 1
> Link: https://lore.kernel.org/imx/acEFwqmAvWls_9Ef@shell.armlinux.org.uk/ # 2
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

