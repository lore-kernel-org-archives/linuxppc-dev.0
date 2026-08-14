Return-Path: <linuxppc-dev+bounces-25862-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A357BC5CFC1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Aug 2026 12:26:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hM1gD0vyYz2ykT;
	Fri, 14 Aug 2026 22:26:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786710392;
	cv=none; b=TDJDWzpgRIlCFITmlch4Mpp8g7GAmO5DY8Tw4mVAdgy6cGLtlzIymJZ44EQfwzQpEuzpcXcREGmkrB1IZMDNXtPLf3fE3Ez48nK9+F4H2dyyZOmc9I+iMlzuuWG8e4Ox1NrhaOcYsiUG00uuM7F6A0FTOWul0SSML00OJnb8dNFs2oH31y1K3GlMqmrERv3ChFOJzijnAH/WPyhn0EDg4GIc/70KwW2NrTQs/KyJb4rWLiEKUtk0m3z1/BIGOCls+3ADml1pt0ktFa7fw62XgaONbOuEM0FRSNs6zUBzvWkBSPCsHEtOpMlb3R4NlMnp+EYmJLxBZFUrkpKfnoZKBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786710392; c=relaxed/relaxed;
	bh=WsuzZNbDDD5GlpZTXjbJXIZcsLrcg0Qg6ozbSmysyEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VKd93icOTW6e+KoPpkwWoOP8Rt5PYBYK3Lvng9iQmiJUYf5LWWh/8DykLo3Uz8KmmQctKcBfC3ClU49Zs4oFq634oZoBgT9jStTP7MrkDvm4nlPvpZ6wVIH+5dsCPm8vbOUlFZ/5Am1DSvLG7Nia5x0j5ce9VdjLxwVticvfjAb4QNTtBVBbmQJtIxz9gD3EqtCh7kNd39OxosITZYi7HoNFzIDak6LqcU3c36z1mJ4vLi5byzpgqde5ILcp3auqeW78K4KaLnYFjX5wpvUbsgD6xTDROjuNI+UZhQBAXvlONp7m61uB3QLpqyIMAUOr6GiN4e5xgmNgMkYzpAODRw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SHeaLYoJ; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SHeaLYoJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hM1gC2dmYz2yD8
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2026 22:26:31 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2D23E43A9D;
	Fri, 14 Aug 2026 12:26:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F8281F000E9;
	Fri, 14 Aug 2026 12:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786710389;
	bh=WsuzZNbDDD5GlpZTXjbJXIZcsLrcg0Qg6ozbSmysyEY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=SHeaLYoJmKpjt0OmPYZNTHbZuMRCaE+WtPi+PYrmT3EF/VlwgEDPxbGkDa7TaKK9e
	 Zxkwede1YyuzDDDU2YEt7FnO66W7uk+5QsENO/x4GvmQhSMrMDD8A2iTYiH+DPi7kf
	 FYt738KqfRAxmPR9SMyC8FJ+GcWYZfVvXz8W0AxLizXbsidZSekAzI6bJ73BnMP2UY
	 Gzs3mlXI7OKn4fyciWsZ/9xnOIOBaKanB1dMFqGuD79ryNHrBOJBfeb3fwFC8a+0Kw
	 oHFi15Jo87O2b0ZJn7o4xTz8ys8YA2056J0kgptkf2Z8dl0IevmKWLGC2SZaejtUOT
	 Me2is6eqZYogw==
Message-ID: <44f93c64-55e9-4240-bc2c-be49280219f9@kernel.org>
Date: Fri, 14 Aug 2026 14:26:24 +0200
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
Subject: Re: [PATCH] powerpc: fsl_rio: Use snprintf() in fsl_rio_setup()
To: Thorsten Blum <thorsten.blum@linux.dev>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Kees Cook <kees@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260630144951.692473-2-thorsten.blum@linux.dev>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260630144951.692473-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 30/06/2026 à 16:49, Thorsten Blum a écrit :
> While the current code works correctly, replace the unbounded sprintf()
> with the safer snprintf() in fsl_rio_setup() to follow secure coding
> best practices.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>   arch/powerpc/sysdev/fsl_rio.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/sysdev/fsl_rio.c b/arch/powerpc/sysdev/fsl_rio.c
> index eb55dabb4748..077c03cd93e4 100644
> --- a/arch/powerpc/sysdev/fsl_rio.c
> +++ b/arch/powerpc/sysdev/fsl_rio.c
> @@ -612,7 +612,7 @@ static int fsl_rio_setup(struct platform_device *dev)
>   				kfree(port);
>   				continue;
>   		}
> -		sprintf(port->name, "RIO mport %d", i);
> +		snprintf(port->name, sizeof(port->name), "RIO mport %d", i);

Are you sure it is correct ?

Shouldn't it be sizeof(port->name) - 1 ?

>   
>   		priv->dev = &dev->dev;
>   		port->dev.parent = &dev->dev;


