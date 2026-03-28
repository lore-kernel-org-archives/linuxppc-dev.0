Return-Path: <linuxppc-dev+bounces-18963-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5CB810F3DE2
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Mar 2026 12:44:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fjcdw44CBz2yfK;
	Sat, 28 Mar 2026 23:44:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774701860;
	cv=none; b=e6M0Oz/D+2k+mhS0rB0k8kRasValrtHHFjpNaHcRYra+TVyEJkcKguPsiQxvN9erVyty5KLvxDqXFo9o7Qtzk8i9J6sMw3YXzcpVkz44aXm2jnhA1NseyB8fGaXwuD3hE7yEXcB/qcdzUyzciY8IvAVzpq3zf1L3lZRnaboEJTBageBmosWf1bygVqBZCgjDdLyiiDYzHEstT5Nwm9+AZ5YxpBIbw9KzaLzS61iHbaalgKJErQ2DsKAEiQbgnAgJkuqBoWioldBSgUc3DvuMcKxp9Qob3MTfoGs0QVw6sLNrbAFGPbWktvVWNZKtR8St0ZyydMuX/zWjXBuV+U8B8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774701860; c=relaxed/relaxed;
	bh=95zaNxNWfOjjGIPROCR7R2FAN16Jvi3ZaPMI1gG1deM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AV9Eu5FJIZ1hZcQ4ZEWRau6uIPvRKl9dYrCKuzpatQfOC1HoP2nq4Y1QWufdlpAZtt/cwTKaMKmGbsYzpNNM7lve+hTsMFYVbw7q3G/FUtUrH3CdhTFeit5ZNBSFyAir1WK0rX9hbYnoX2hQfaQNAxfGypBblXM/TwfigSAQ2oMoE223X9NjaQQVx+qgO0Inei2ejMRJYDuQzY1J0eJFGPDFKRRWAQ5yb8yk06DWK/aBHY/D2aORPlpU4Vx5OuqBeWnD141xgYkZ/ErJE86OoMeAMgoKBGf9qQ2eL+acA24Tj/inN3IHAFBALsxZIfH3PO+FratpWqQ7blB7w9dQ4A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dl1uAITd; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dl1uAITd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fjcdv42nVz2xN8
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2026 23:44:19 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 59C2660008;
	Sat, 28 Mar 2026 12:44:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A71C4CEF7;
	Sat, 28 Mar 2026 12:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774701857;
	bh=79/1UCAkXJ1fRlik+68IZw07RZgWagd69fiPAJ12N9A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dl1uAITdiByJc+r1+hUxJVh+hRdNG4RTjBoSTWp3vx0qwAar2zle63hTvqjpqkqmq
	 TKmvid4fmzCREO4y2CJTWjoMX3tvvvK5pZ9eo6EFv/G2YwMn2cMTLoAm7Fy+MQt+lK
	 YZPGr/Hwx8dmpOLdpY/Nl/Dh07scwVTxWvOO0JNl8AUJ+PyK0/kdsco58BzXlmcUwt
	 mbIr/ejLI/yEIB4OL+bFwPLdI4PnA4KGKgiBTV7fIZgwAdcdY1xXRSzCCakoOB1wcK
	 +oICL10lWhXTNurMEa7YLuUTiR6U2c0Fe2vtSJRLgCM1yS5I12jkwYnL1NgfGbS55O
	 i1vuPREYTpj/Q==
Message-ID: <abe56c71-06f6-4686-b861-02090f89e39d@kernel.org>
Date: Sat, 28 Mar 2026 13:44:13 +0100
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
Subject: Re: [PATCH] soc: fsl: qe_ports_ic: Add missing cleanup on device
 removal
To: Felix Gu <ustc.gu@gmail.com>, Qiang Zhao <qiang.zhao@nxp.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260310-qe_ports_ic-v1-1-608293026561@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260310-qe_ports_ic-v1-1-608293026561@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 09/03/2026 à 17:25, Felix Gu a écrit :
> [Vous ne recevez pas souvent de courriers de ustc.gu@gmail.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> Add a devm action handler to properly clean up the irq_domain and
> chained handler when the device is removed.
> 
> Fixes: f0bcd784e1b7 ("soc: fsl: qe: Add an interrupt controller for QUICC Engine Ports")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> ---
>   drivers/soc/fsl/qe/qe_ports_ic.c | 21 +++++++++++++++------
>   1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/soc/fsl/qe/qe_ports_ic.c b/drivers/soc/fsl/qe/qe_ports_ic.c
> index 8e2107e2cde5..5e3fae19f314 100644
> --- a/drivers/soc/fsl/qe/qe_ports_ic.c
> +++ b/drivers/soc/fsl/qe/qe_ports_ic.c
> @@ -17,6 +17,7 @@
>   struct qepic_data {
>          void __iomem *reg;
>          struct irq_domain *host;
> +       int irq;
>   };
> 
>   static void qepic_mask(struct irq_data *d)
> @@ -92,11 +93,18 @@ static const struct irq_domain_ops qepic_host_ops = {
>          .map = qepic_host_map,
>   };
> 
> +static void qepic_remove(void *res)
> +{
> +       struct qepic_data *data = res;
> +
> +       irq_set_chained_handler_and_data(data->irq, NULL, NULL);
> +       irq_domain_remove(data->host);
> +}
> +
>   static int qepic_probe(struct platform_device *pdev)
>   {
>          struct device *dev = &pdev->dev;
>          struct qepic_data *data;
> -       int irq;
> 
>          data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>          if (!data)
> @@ -106,17 +114,18 @@ static int qepic_probe(struct platform_device *pdev)
>          if (IS_ERR(data->reg))
>                  return PTR_ERR(data->reg);
> 
> -       irq = platform_get_irq(pdev, 0);
> -       if (irq < 0)
> -               return irq;
> +       data->irq = platform_get_irq(pdev, 0);
> +       if (data->irq < 0)
> +               return data->irq;
> 
>          data->host = irq_domain_add_linear(dev->of_node, 32, &qepic_host_ops, data);
>          if (!data->host)
>                  return -ENODEV;
> 
> -       irq_set_chained_handler_and_data(irq, qepic_cascade, data);
> +       irq_set_chained_handler_and_data(data->irq, qepic_cascade, data);
> +
> +       return devm_add_action_or_reset(dev, qepic_remove, data);
> 
> -       return 0;
>   }
> 
>   static const struct of_device_id qepic_match[] = {
> 
> ---
> base-commit: a0ae2a256046c0c5d3778d1a194ff2e171f16e5f
> change-id: 20260310-qe_ports_ic-ca4c98bd1c4f
> 
> Best regards,
> --
> Felix Gu <ustc.gu@gmail.com>
> 

Applied, thanks.

