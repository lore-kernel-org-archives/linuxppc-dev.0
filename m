Return-Path: <linuxppc-dev+bounces-20439-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 505B6CD13DA
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2026 05:37:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g8nMW6ZZ1z2xSF;
	Tue, 05 May 2026 15:37:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777959431;
	cv=none; b=YikM2NlRkwEaLsH1bARMF7o/iLdN0TGjA+8r1Vv/BofUD+hAwbZGgOTAAno83sqlzI/Kecv3fOs5v3hL9tW2niuSxRF8Gjo2HAm3gAtbB5Q7HFbEU3/FW7tQMVL4QVE6ftoa/BLrZSSmBn3p665It9fib4uOSQoMXPfg4dCo97viO6q6XZMp/w0L3C76wGKoUQ99SKWz+JmJpan3/7EB++muuLfGRWV56JVu1aHz5zoQ6t1i1mI9XBOUaIz7L93Oxmh97TWLKfpWlgD2gXs5ATe7/utA7aVauAYrKaow5a1NU8snO8TSSiCLugjo3yjXHvvg1btkm6qB/JeJYr2XCg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777959431; c=relaxed/relaxed;
	bh=j7tnTrh+pj6vQz8i6B38njsfVGgBXG6wpBp9OTw2xKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jwnCNBAgazLErcT4qQfzwszNAhAHv6muj8n2AovagLz3rqnAabSc9MakArJZBDr6c9XJI7tVmEABXCb0aNB5gbsrd0Mnm35muZJ5FMMPOcjLLa1hw2xfae18phM9ZvKQJiqDBODc50CnZ4BXhQ9+4q5w9HngraIpghHKdJSck32wvaWPKvfTy+vhcg+474Gli1PaNQCYqsNA/KfsdAhNDHxD7diHJ09888JowYmTr9ZvxesrxXBq9HVmIK8wPqp7lkAin7lQSyEB0jGWzG7aM16WD2hP2BFSRiEvqRalQQDO/+6NLfsb4HvLxY+rjB+oTzBi3gk8APhzDv/JRNn3Xw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TMKGNkLX; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TMKGNkLX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g8nMV6n6dz2xMV
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 May 2026 15:37:10 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4F3A243FD6;
	Tue,  5 May 2026 05:37:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00FD9C2BCB4;
	Tue,  5 May 2026 05:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777959428;
	bh=w7dQK57+pO4cmDbX9FAl4uLfSMH4ddaq1KgiB3tb0+k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TMKGNkLXRidii1NpLdfVStwvVqd/ZEqEf3zEbyy9/gCaeZpf82yg5OHn/QSY29kHs
	 xr+NHdYVwj0ta4m77b5TxFMz+oTW64lkR9nMbWOCDfjBCgXBIDRxI+jnR0PmawokC7
	 bOvvd67+J8RL/9l6paZBow5hb0dRGk8BEMP7fBSG+gf7aRTWdGztYSHJJSPya7OTtb
	 OofBCWpkhWsCa/MjGufIYmme2DMcD3nRV/Yq9OBEltGzRik7aKHaxvBRQuKneg2ikY
	 +A8NURQHyKqYHx+bAg1NIU5EVEmBrF+Bw51trnz1XE0ZQdCvfVJcLPKgO9yHV+c8st
	 270lBMnEIu4vQ==
Message-ID: <3e1a653b-81bc-4008-8f84-77c823aeef49@kernel.org>
Date: Tue, 5 May 2026 07:37:05 +0200
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
Subject: Re: [PATCH net] net: wan: fsl_ucc_hdlc: free tx_skbuff in
 uhdlc_memclean
To: Holger Brunck <holger.brunck@hitachienergy.com>, netdev@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, andrew+netdev@lunn.ch, qiang.zhao@nxp.com,
 horms@kernel.org
References: <20260504161145.2217950-1-holger.brunck@hitachienergy.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260504161145.2217950-1-holger.brunck@hitachienergy.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 04/05/2026 à 18:11, Holger Brunck a écrit :
> When cleaning up the resources we need to iterate over the
> tx_skbuf array to free pending TX messages.
> 
> Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
> Signed-off-by: Holger Brunck <holger.brunck@hitachienergy.com>
> ---
>   drivers/net/wan/fsl_ucc_hdlc.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
> index adf3863463f5..68f78aeabdc3 100644
> --- a/drivers/net/wan/fsl_ucc_hdlc.c
> +++ b/drivers/net/wan/fsl_ucc_hdlc.c
> @@ -739,6 +739,8 @@ static int uhdlc_open(struct net_device *dev)
>   
>   static void uhdlc_memclean(struct ucc_hdlc_private *priv)
>   {
> +	int i;
> +
>   	qe_muram_free(ioread16be(&priv->ucc_pram->riptr));
>   	qe_muram_free(ioread16be(&priv->ucc_pram->tiptr));
>   
> @@ -769,6 +771,11 @@ static void uhdlc_memclean(struct ucc_hdlc_private *priv)
>   	kfree(priv->rx_skbuff);
>   	priv->rx_skbuff = NULL;
>   
> +	for (i = 0; i < TX_BD_RING_LEN) {
> +		kfree(priv->tx_skbuff[i]);

I don't think you can just kfree() an skb like this.

I think you have to call dev_kfree_skb_any() instead.

Christophe


> +		priv->tx_skbuff[i] = NULL;
> +	}
> +
>   	kfree(priv->tx_skbuff);
>   	priv->tx_skbuff = NULL;
>   


