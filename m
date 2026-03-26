Return-Path: <linuxppc-dev+bounces-18824-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C5B10A3D7F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Mar 2026 12:17:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhN7q3LsSz2yd7;
	Thu, 26 Mar 2026 23:17:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774527447;
	cv=none; b=WG0Qn7C4iPLFMS7tv0AgHl0lKz1ZUsZoMQ4vpS6cATdRC+6SOB4K1gKtoT07UIjSumKR34XCNM40woZ17OMD5OV2FKUD+FmQ7I5xIWHYMX5WRHjmVAjqyNnxDX3pTr1zGLPxi0aI8B7Xkpaz4co9B+MFgOeNxithBG+UgDwRD4gfD16EHDkOxi09ZW1oDe2Mm8pzXptPrMXBeH1Irnz8ww7xx0anJDoFNlLYFC6yGJJqEk30bDRU6nfFU3moHcfCwqSKJilF8Qz2EdIgPgR+Xuk8gj/EGnxXNk8gjx/c5lRh7scJjND6GzsuDwsuEh9kSG9JFnxjFcI2ihDcbTTiYw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774527447; c=relaxed/relaxed;
	bh=lnb7dvkabW4QlFwXJLExSvLlOdTa6CwsYSFnyygKytw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oA6gNaw3rWnoEYeVgvS65JmTe+ef5LawxqxiKOvRdjsuoVnXyQMvWjDMh6Mo1h76TsRESGaSOIXMpjph/FpPojNZefTw4PRFYPldHPQcBAX5tGDyfsRisbuKq/Z+LUG7iO2h8tbt4Fh1PkODhGQkEVr0oXK3F+KQtrtwmmn/yYF7eG2ZgutsFQxR1rO0zsrjxwocmcW+FwoQ7cf1OfLH2ogpREb+6n5UZsWzxjAnaOTR4NY3ZjnTyflKNr+H7+KHHknKAFcg35vwjx6zcxY1VOb4jYx/fe+6siKqrA3hfFt7cP3DtkEw+p6t6gYvtLNNIQQ1Pz6Ps+OWhC/8pisoJg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=du4SbXau; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=du4SbXau;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhN7p2Kyhz2yS4
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2026 23:17:26 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A25AD441D9;
	Thu, 26 Mar 2026 12:17:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8040C19423;
	Thu, 26 Mar 2026 12:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774527443;
	bh=3VbtHsOVRFRjZnMXO5LgMUckZdMMBskrErAVbmlVWSw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=du4SbXauELOkRIZ4Mr6eNzSeKmc4VZmQFpauQEYxqPa7pbDa3O/vCUUbIs3T3iXDA
	 04xMnalgNvzLD2ZXgA/WnqCFVOHjuKt3BrT99131wZJr+6bEFQv7oRqYIlEl9tS3S0
	 AC/QWhpx7U6FVYV7g43M9qmhzOzeZkxIGLuYnJi56tlzM9YxKJ0bS8k5qDAPluxAER
	 TiGK+Ek5N09nRLi1kfvjAh34KdqQNRxkvDVV41MBCzKgaOxtvptgxYfqzhrSEihfwW
	 CKF0E7jfidziBvrrhBVnyvqeabr+kebAa6CPgwdcWnGmPGvZBkIwtVjydiasaIzMH3
	 iEuXBYRGIXfJw==
Message-ID: <fea7935a-ddd7-4ac2-a2f4-622133b91281@kernel.org>
Date: Thu, 26 Mar 2026 13:17:18 +0100
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
Subject: Re: [PATCH] net: wan/fsl_ucc_hdlc: cleanup ucc_hdlc_poll
To: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: qiang.zhao@nxp.com, andrew+netdev@lunn.ch
References: <20260326100232.904289-1-tomas.alvarez-vanoli@hitachienergy.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260326100232.904289-1-tomas.alvarez-vanoli@hitachienergy.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 26/03/2026 à 11:02, Tomas Alvarez Vanoli a écrit :
> Immediately after setting to 0 we are adding to it, and subtracting 0
> from budget. Replace with just assignment and no subtraction.
> 
> Signed-off-by: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
>   drivers/net/wan/fsl_ucc_hdlc.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
> index b72ab9951875e..3bd57527b1be6 100644
> --- a/drivers/net/wan/fsl_ucc_hdlc.c
> +++ b/drivers/net/wan/fsl_ucc_hdlc.c
> @@ -628,8 +628,7 @@ static int ucc_hdlc_poll(struct napi_struct *napi, int budget)
>          hdlc_tx_done(priv);
>          spin_unlock(&priv->lock);
> 
> -       howmany = 0;
> -       howmany += hdlc_rx_done(priv, budget - howmany);
> +       howmany = hdlc_rx_done(priv, budget);
> 
>          if (howmany < budget) {
>                  napi_complete_done(napi, howmany);
> --
> 2.47.3
> 
> 


