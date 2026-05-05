Return-Path: <linuxppc-dev+bounces-20437-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F43ACD13DA
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2026 05:29:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g8nBp4Grmz2xSF;
	Tue, 05 May 2026 15:29:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777958978;
	cv=none; b=htpylrsrfZJB/vEGSRPpEScRS8eQsJ5Bx8ljlAN/us3craAPYg4gkA3VDxcr0CpfyTlpOfuyB18qVt5g2B4nBuBX499gL8ai3c6aCJ3fdNdeqL1MAn4M+9WRkFQRHOoKw7GeoDGmY8+dezYu4GeU+CLYpswExOpK5qw0nuhzGJr5kpq7Rt7op4tgyUsqMeffmg4ZclBw9Yog0tYBcew9a/89XCvv5AZicBfuaSo7a7eYHPhewBzukZb7Ja53dFBKWqtawVbr2NRpDkYuSszyDiSGe+7V2VpBQBjzkg06Xy6R587TexmH1GAs0HG/hEqiDGrUDSyXKjCgVuHf79Xisw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777958978; c=relaxed/relaxed;
	bh=CUqTdyw/9MDsz822GDLgEfvwtq7um/5il5KpWBnrMKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V4i6kGLzWsUX4QVcj29VQCF3T9vs4dtJpFtFkdBP+fKnysqjuLSnB5QhWSP9qn5Ym/mBhtKthLtVqy1gDMDlvFr2ZFY8vDWj6ZUE61UHBNR2LefvpHVGZ16ovcfN3qQjdMDXWtHs84MtuXE62fjbor9U1ZXOYGcl5vWylW+IigTCHOrRhDerkVNFXR4I0I2uWaJtP789e51tZ4tCOXicZmb3m+jnLytWgFPEaMxxyuVaExL9yM2wxkx6UnHhFxSvMpM32uxfzgOZ0Dp/sjV5kN0zjCoFa6eG8D6/4d5JzH7z6f9+3COzOm7ml4oSA23QU5dKmkkx657NV2BiHWcPng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hpzC+qsQ; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hpzC+qsQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g8nBn4w0Mz2xMV
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 May 2026 15:29:37 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6792B41725;
	Tue,  5 May 2026 05:29:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F720C2BCB4;
	Tue,  5 May 2026 05:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777958974;
	bh=4fHxp8Q3woesOCXXrtJkOcW34n60i9kmwv85rTk8Mm8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hpzC+qsQ/qpsgVzgGx6hDiGsj/wjF5kCtTo22kPAr8nH+vEXKi7AX4ScKH6rB5/sV
	 wzsqtRrtaJKC7cEmm7dOajyTY0kRcixWmUI9s/UWADXdG3IZVjZQI43rwUPU45Q9Ns
	 uv/bA7I3mj1wIT5drWOmqU+9RSJRa1fuaSHCENdOgfq6qp5eILS5HX40n+LacV1B57
	 DQcd/GMjr9IMk5dnmHSwW5753uXFsu2jdPOCSuhDf/sPdn/NmLkXpgxPP/Z12u7Zt2
	 ypNvbNtleQxHs/d0gMPI4ky3YEKKPmKD5SnxjQ2/bmCIQ9CX6oZ393QuySthSJGG2W
	 ucPMbBe7heS2g==
Message-ID: <d6957853-9d24-4f35-8ea7-ef4376de991e@kernel.org>
Date: Tue, 5 May 2026 07:29:29 +0200
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
Subject: Re: [PATCH net] net: wan: fsl_uhdlc_hdlc: fix dma_rmb usage in
 hdlc_rx_done
To: Holger Brunck <holger.brunck@hitachienergy.com>, netdev@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, andrew+netdev@lunn.ch, qiang.zhao@nxp.com,
 horms@kernel.org
References: <20260504155642.2216040-1-holger.brunck@hitachienergy.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260504155642.2216040-1-holger.brunck@hitachienergy.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Le 04/05/2026 à 17:56, Holger Brunck a écrit :
> If dma_rmb is used it has to be done after reading bd_status and checking
> if R_E_S is zero. Therefore we need to move it into the while loop.

Can you give more details ? Why does dma_rmb() has to be done after 
reading bd_status and checking if R_E_S is zero ?

> 
> Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
> Signed-off-by: Holger Brunck <holger.brunck@hitachienergy.com>
> ---
>   drivers/net/wan/fsl_ucc_hdlc.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
> index 15bfb78381d4..09081f128a98 100644
> --- a/drivers/net/wan/fsl_ucc_hdlc.c
> +++ b/drivers/net/wan/fsl_ucc_hdlc.c
> @@ -523,12 +523,12 @@ static int hdlc_rx_done(struct ucc_hdlc_private *priv, int rx_work_limit)
>   	u16 length, howmany = 0;
>   	u8 *bdbuffer;
>   
> -	dma_rmb();
>   	bd = priv->currx_bd;
>   	bd_status = be16_to_cpu(bd->status);
>   
>   	/* while there are received buffers and BD is full (~R_E) */
>   	while (!((bd_status & (R_E_S)) || (--rx_work_limit < 0))) {
> +		dma_rmb();
>   		if (bd_status & (RX_BD_ERRORS)) {
>   			dev->stats.rx_errors++;
>   
> @@ -610,7 +610,6 @@ static int hdlc_rx_done(struct ucc_hdlc_private *priv, int rx_work_limit)
>   
>   		bd_status = be16_to_cpu(bd->status);
>   	}
> -	dma_rmb();
>   
>   	priv->currx_bd = bd;
>   	return howmany;


