Return-Path: <linuxppc-dev+bounces-27172-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AFFBC79FB6
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Sep 2026 09:24:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hhmGC4M0kz2yln;
	Sat, 12 Sep 2026 19:24:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789205091;
	cv=none; b=YAqKrZAT8dRpxpmyrDEG7ha2vSCPImYEdCjnXBx3DMkKm0Gi+sxI3/40TgQ7IrtEcDXAv83QaOSH9gxLlHLeMmB1VR7FPbQR5zkpUjMO7EOWWv01piwiilOiuVIqwtHlsHb6nXsaeTUXpqxDtxpcgANXNDjcFQStuAe3kjc2eCdZ8PWHvUIpuKvVT5I/7s+rl/sBec12vV+cJckQrLDUjYrWSTs7N3IbtLRqjY1mb/tEhwZ7O8cgLxJXrC+rKFS/LioRj4pLOeCFK1T8OKEbS8KNGIOQV1/H8A+O/yT5gnW7jDJVcqi6c+h+ZNVCd1RDSootpcTYMG4WlONuOgMxnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789205091; c=relaxed/relaxed;
	bh=jlDAifSOhcOWqoOnA1uxysXhHTyvwF8FnNiIJAQAd3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SgjKXOTtOpiJBkBKrc8RVjIU1YI8fUuuF2KqLVK8FvBm3a0SoYmXwYQghtmrbScOwP11O+OtYeH6vdg5ZSo9lJs5VG5mx4TYoLq33SEZqhL530m/S8zSGCyqPwNKi/kSQFcO/xbr3fL7EMDCJ90+3jtvOHOi3NweuzvNpyOanLqG83Y7wd1RVtbfCqk7JQQaSXqsb/drbjwJ/1auExEut70H3df321UxfgdK+YVDIlBR3cvox19cQcoXrZ7F+AKS1oBPNkdOVudQGg11Yy8sA0OOF82pwVhEXYDh3QIZnUBNZZf5uw54hZJO07L2h7ceyzPCBvLm8Jsso7a6DnYUhA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dbvUO2Hu; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dbvUO2Hu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hhmGB33Dbz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Sep 2026 19:24:50 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5E20B601F1;
	Sat, 12 Sep 2026 09:24:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F23D1F000FF;
	Sat, 12 Sep 2026 09:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789205087;
	bh=jlDAifSOhcOWqoOnA1uxysXhHTyvwF8FnNiIJAQAd3Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=dbvUO2HunQLYViPkLwkbKS7RsK6z9nBOTHnsekm2y661Eq/t2NOGMorFD2b+Paqct
	 OMqjVgFy3I8EyIJ/wAp8F9IFecXMDjEv3JH1nxjKqxhdl3I3YaXmKYFhiDNg8nCjo4
	 46cOAx27sfB3PtQGBkeAOJ69ItoSrwjVgXFzj5bLdPUpsnXXYtezyk4gFoXIVVP1rH
	 VmchgJ3u3BJay22D3pzIq9lH8lvrGDCpI7ZzowEThm6DntqAG/bwqy4V06sS4ElLg9
	 5chGe/gkqYuPYkIh585XtXjcaVJuu27qcemIO7ciJQvSj3b3NC5c+GF5yGfNmZpibm
	 ZcgRYn99K/3bQ==
Message-ID: <17df0369-0a94-4763-b4c0-ce1f7c99d02d@kernel.org>
Date: Sat, 12 Sep 2026 11:24:42 +0200
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
Subject: Re: [PATCH] dmaengine: bestcomm: make gen_bd init helpers static
To: Rosen Penev <rosenp@gmail.com>, dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:FREESCALE SOC DRIVERS" <linuxppc-dev@lists.ozlabs.org>,
 "moderated list:FREESCALE SOC DRIVERS" <linux-arm-kernel@lists.infradead.org>
References: <20260911215914.175851-1-rosenp@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260911215914.175851-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 11/09/2026 à 23:59, Rosen Penev a écrit :
> bcom_gen_bd_rx_init() and bcom_gen_bd_tx_init() are only called from
> the PSC wrapper functions in gen_bd.c, so make them static, drop
> their now-unneeded exports, and remove the corresponding header
> declarations.  The reset and release variants stay exported because
> sound/soc/fsl/mpc5200_dma.c calls them from a separate module.

What do you mean by "variants" ? For me a variant is something that does 
the same but slightly differently.

Maybe add that last extern user was removed by commit 7d3ee229ea51 
("powerpc: Drop MPC5200 LocalPlus bus FIFO driver")

Christophe

> 
> Assisted-by: LLM
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>   drivers/dma/bestcomm/gen_bd.c       | 6 ++----
>   include/linux/fsl/bestcomm/gen_bd.h | 8 --------
>   2 files changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/dma/bestcomm/gen_bd.c b/drivers/dma/bestcomm/gen_bd.c
> index 61b5746e1a97..b5093f7445cb 100644
> --- a/drivers/dma/bestcomm/gen_bd.c
> +++ b/drivers/dma/bestcomm/gen_bd.c
> @@ -81,7 +81,7 @@ struct bcom_gen_bd_priv {
>   /* Task support code                                                        */
>   /* ======================================================================== */
>   
> -struct bcom_task *
> +static struct bcom_task *
>   bcom_gen_bd_rx_init(int queue_len, phys_addr_t fifo,
>   			int initiator, int ipr, int maxbufsize)
>   {
> @@ -108,7 +108,6 @@ bcom_gen_bd_rx_init(int queue_len, phys_addr_t fifo,
>   
>   	return tsk;
>   }
> -EXPORT_SYMBOL_GPL(bcom_gen_bd_rx_init);
>   
>   int
>   bcom_gen_bd_rx_reset(struct bcom_task *tsk)
> @@ -166,7 +165,7 @@ bcom_gen_bd_rx_release(struct bcom_task *tsk)
>   EXPORT_SYMBOL_GPL(bcom_gen_bd_rx_release);
>   
>   
> -extern struct bcom_task *
> +static struct bcom_task *
>   bcom_gen_bd_tx_init(int queue_len, phys_addr_t fifo,
>   			int initiator, int ipr)
>   {
> @@ -192,7 +191,6 @@ bcom_gen_bd_tx_init(int queue_len, phys_addr_t fifo,
>   
>   	return tsk;
>   }
> -EXPORT_SYMBOL_GPL(bcom_gen_bd_tx_init);
>   
>   int
>   bcom_gen_bd_tx_reset(struct bcom_task *tsk)
> diff --git a/include/linux/fsl/bestcomm/gen_bd.h b/include/linux/fsl/bestcomm/gen_bd.h
> index aeb312a1cd00..7253d308d77a 100644
> --- a/include/linux/fsl/bestcomm/gen_bd.h
> +++ b/include/linux/fsl/bestcomm/gen_bd.h
> @@ -16,10 +16,6 @@ struct bcom_gen_bd {
>   };
>   
>   
> -extern struct bcom_task *
> -bcom_gen_bd_rx_init(int queue_len, phys_addr_t fifo,
> -			int initiator, int ipr, int maxbufsize);
> -
>   extern int
>   bcom_gen_bd_rx_reset(struct bcom_task *tsk);
>   
> @@ -27,10 +23,6 @@ extern void
>   bcom_gen_bd_rx_release(struct bcom_task *tsk);
>   
>   
> -extern struct bcom_task *
> -bcom_gen_bd_tx_init(int queue_len, phys_addr_t fifo,
> -			int initiator, int ipr);
> -
>   extern int
>   bcom_gen_bd_tx_reset(struct bcom_task *tsk);
>   


