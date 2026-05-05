Return-Path: <linuxppc-dev+bounces-20438-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 632D4CD13DA
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2026 05:31:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g8nDr6HhNz2xSF;
	Tue, 05 May 2026 15:31:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777959084;
	cv=none; b=bcuXhhaf9ovsoxRijlnMUSf4F8kGeS+0RG+2e9kJCbKzLhUgyIGdc7KENuDGdZry9Q8utWpeJtZsywk8P82FCMKgKv11pAeimu0xaiX24ZJys2n18fT00VRDDJD5lFzPJlho0bRvGOZrHZUbtD6f/EVi4lI3EtyOHZb5PL2tFqdFwzDD7W9r5D/VRS/rjhjVUmJDqtP6z32WFYtimOxzQGdm6/K4EbEi66+EZquvzbajWDzwkLOhJl+ndd+A4+A7ngwHv4tQTaZZJ0CLg0j9nLtwoajZOVQdq/8FKSqvqMQTml1v7I+tol3lIyZXxzvwQVVSrWjs3JYwsFoO7WSi9A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777959084; c=relaxed/relaxed;
	bh=buasjpBJ/b6pSH29wjrcBl+qDyWvzMzeX4E1HTPwU30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mC11HxRQvgh/HTAaSpyuAblF+TK3Ko3mlIdIwsAgxZ0W0AGh8Aw3aUKbuzJAoMl1b6wCLiYx9/U3tGsxp8sZdoNWcE/MoGs9mB14Y2yXPzklzyqRxfQ7Y73T/K8mliiL2dMjJbug98V05VgBZQxWC7QZHET9vYL3xR/uLQNyVCvsuIhduNDtF2+I29vUbrmqmm0bQCRmnHZXq3X9FhrBpQs30ylSUQz2tNCnAK6r07cQukHZo1UDOVoXt5D3M3BZ/fSRk9qXudAce6h9RWvLScZFiwOJk8oMZQFV6T/kmP77TY8fNc8AFwl0svyZ5OfywMyclw8s8FLSTItnxQsgpw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jNrS4olF; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jNrS4olF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g8nDr25qMz2xMV
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 May 2026 15:31:24 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9E84C43D77;
	Tue,  5 May 2026 05:31:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A8DC2BCB4;
	Tue,  5 May 2026 05:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777959082;
	bh=wka7qFdK59QVtAA0IHLqqYz4ouAxY9bZ6SSysificV0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jNrS4olFsrGBVxl6/yu+H7xf2hOBbcgN7fFqjcGJPhg0SBv1Bj6m3DW76PwD43l2c
	 9AkzF5WwNvHH6oxY2SUpODmX/Hjhrtc4JfHvqb8iEt4UeBhOwVvvQPMNOTfDjF55GK
	 sjq4DFC4ylz1WDZEJ3JppEvFW4uwIgCGHLoxGLH64DEWqX69Q/x80HPNxeRL8p3odI
	 zAcryZQubUkAu3ONtjikYf/UTxCx6iu81HdIrLUz9gK8eTz7f8j4zFjCyxEuVc5OKb
	 pvA0U+Qh3EDZAQgRsQmr3bMyJVcJtNnaRccSxsz1cS9X/XCapgmJvH7iGQ1t0VqsxU
	 AjvSNtUdOF7/g==
Message-ID: <e3abfd12-6537-42b1-b35e-c79a06f87172@kernel.org>
Date: Tue, 5 May 2026 07:31:19 +0200
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
Subject: Re: [PATCH net] net: wan: fsl_ucc_hdlc: fix indentation error
To: Holger Brunck <holger.brunck@hitachienergy.com>, netdev@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, andrew+netdev@lunn.ch, qiang.zhao@nxp.com,
 horms@kernel.org
References: <20260504160734.2217382-1-holger.brunck@hitachienergy.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260504160734.2217382-1-holger.brunck@hitachienergy.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Le 04/05/2026 à 18:07, Holger Brunck a écrit :
> Remove the whitespace to fix the indentation.

Do we really need a patch for that ? What's the added value of doing 
this change compared to the cost of doing it ?

> 
> Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
> Signed-off-by: Holger Brunck <holger.brunck@hitachienergy.com>
> ---
>   drivers/net/wan/fsl_ucc_hdlc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
> index 09081f128a98..adf3863463f5 100644
> --- a/drivers/net/wan/fsl_ucc_hdlc.c
> +++ b/drivers/net/wan/fsl_ucc_hdlc.c
> @@ -764,7 +764,7 @@ static void uhdlc_memclean(struct ucc_hdlc_private *priv)
>   		qe_muram_free(priv->ucc_pram_offset);
>   		priv->ucc_pram = NULL;
>   		priv->ucc_pram_offset = 0;
> -	 }
> +	}
>   
>   	kfree(priv->rx_skbuff);
>   	priv->rx_skbuff = NULL;


