Return-Path: <linuxppc-dev+bounces-27194-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18FDFC88E50
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:51:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hjvRZ0tbYz2yLg;
	Mon, 14 Sep 2026 15:51:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789365114;
	cv=none; b=A2nUMhNzq3iPPh0cVe/dO6epRrruiXcgoXUjhYc2LZ+9gTckhFUjLAR4KNe113Ru0nnx17vccjNoT/2WLjmKN8EVdUAqBk6uCsI/j17GevkElgEfr2MBNp2Cycrc4y+J55KqynAFv9VzVM5LYfSA6/r0f2n27LEByqdMvPqFnWQ7FAj4JeER19X7A1eRtIugnTDsGeYUc6PBIt1T1qW95qqp/QEQIzQ5JQYwrlUQqd6sYkE9/IYiUq6Fw6zONKZAPlrnlOMGagBu8uBCO0yTmQ4ZAuvLWLVQ5+AkKKDozsgopJI6F7WxmcyK3rn5kMpmF09ZXg5aVeo/djiaBba2aA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789365114; c=relaxed/relaxed;
	bh=D5zceg5+91niGlqEFk3evIy/yGdGxOsNYfbIU+4Af3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fkV7hwXIu5laYpbcwmXweqTjBD0qAbjVcWZc7atmZVYShadc2X1FAW76qwnKSbXChUIA464mFfK9n7K+/oBptESE0oeTJjLEmvN25lo3MR3J+LqQYBcbYOW9kD/e78Prg2ux4bNnQhPXd95aBvyLi7Yc9S4VhP/YroLhjls3PhBBQ2yZgSPfTCEhzlVNJS6TvdcfT7hJslcNtbd7qi73Hba/sZTUcqDGejvHGHAy9ncsPUarqXfw4JKYS93MmlpgSnP/eFk1rOaJKplZo2QQKFzY3fKpgC1LYLKeYrMLwZ9uAoxs0ZqTCpBiVXX0oHtdp67/cmR95QTZybFYQEfbRg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bHijlw1B; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bHijlw1B;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hjvRY0sWqz2xlt
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2026 15:51:52 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A356341FBD;
	Mon, 14 Sep 2026 05:51:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E2301F000FF;
	Mon, 14 Sep 2026 05:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789365110;
	bh=D5zceg5+91niGlqEFk3evIy/yGdGxOsNYfbIU+4Af3E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=bHijlw1Ba4A0JsT8Exy/3SI8wndx4Mz2t8D0LNiJi9SU4doe8jMU/To+hPurAelIc
	 o6+eUt0r8wd40nRA4M9mE2RZiZ+G1PEOZXxnIy6KRj6QtrShPLvgD/BAl4m2WY9dhy
	 q+wzIN54NGdSTlmGrYzP2B8DOZLqXM0ug/mZIe65rVBp8J0kxjsT/FxT/ABGw6jP0l
	 tsTo5nIVBNKCpfmWl9ST5zeBjvAoyAUwhTSIzdzyMihW74QA8pxwDIfg3Y9ulW8Xwm
	 tyJ6cMuDScidAl/W+E1DCPygxfZIPadgHLA2hUfTkeVwZJGyOXKkbTed/7EpgM8nbw
	 p7A+LPC6HmxLw==
Message-ID: <cb482593-e729-4e93-b529-6e84c83e19b2@kernel.org>
Date: Mon, 14 Sep 2026 07:51:45 +0200
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
Subject: Re: [PATCHv2] dmaengine: bestcomm: make gen_bd init helpers static
To: Rosen Penev <rosenp@gmail.com>, dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:FREESCALE SOC DRIVERS" <linuxppc-dev@lists.ozlabs.org>,
 "moderated list:FREESCALE SOC DRIVERS" <linux-arm-kernel@lists.infradead.org>
References: <20260913194804.39939-1-rosenp@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260913194804.39939-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 13/09/2026 à 21:48, Rosen Penev a écrit :
> bcom_gen_bd_rx_init() and bcom_gen_bd_tx_init() are only called from
> the PSC wrapper functions in gen_bd.c, so make them static, drop
> their now-unneeded exports, and remove the corresponding header
> declarations.
> 
> These had use before commit 7d3ee229ea51
> ("powerpc: Drop MPC5200 LocalPlus bus FIFO driver")
> 
> Assisted-by: LLM
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
>   v2: mention driver removal that made them unused.
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


