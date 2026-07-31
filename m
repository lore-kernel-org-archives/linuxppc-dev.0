Return-Path: <linuxppc-dev+bounces-25166-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA549C55167
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jul 2026 07:11:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hBHL91t8lz2ygh;
	Fri, 31 Jul 2026 17:11:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785481889;
	cv=none; b=bYsa5n0oxggli9FBVxlzThVR1cUi3SC/M2MCeYHtpLxU1fnJBGfoUbeUoVnx3un3pNRNsSIusI725NiKX/rDknA02oZ+KQaM3On3fLa3sT8IYx9uzwAPPRzHTdhp9m01t5SIRPvmkpt+BbYbTEG/YQNB0Ybr1VC3MEQX4h2JL8nYEI9pJPVv4aJbqSf2RuInsd6BgksT1RfLa7IrZJ71ERNPR6EaBJb8VIZZ8SPbe31sdYrMVvOEnQwdMWOaXgNx8QAF9iEzQSKei4y7hstIig/8+y+3RxZ+7xt1EtUtyFkwWgNpGmkmCMCOMXFrq8i6zQMn0bl3tBeDxEF3nhcFqA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785481889; c=relaxed/relaxed;
	bh=CWMEFKxEBjtPexxljun5XVOIgKx0us+3UHa4wux2fjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IZpQCeLB/sbXNLjSVX4Uvi7IFWDFzP03IWHqn/RblJrIpABjEDfZtaKb9H+HQffNvAdRop9bEBqDSVUf4giMk5iMQ5XEniIBJ4sk0kO3t694g44l/CB0+4Y1Tsc2eKnaZIXy8aer0VnlZ2QanJmOAmxkNEduYu3A24CUmc5f+HIQU321/8W0T8O08S1kVw9KsitB0LYe6qJBjwmVF/M8gFvF0UsU4M15yiGJ0khyEQ66nvoTuwDvuCOsgX9LjvNPOZ2fcx2xZHaZwnBjBVWUF4J8bMPpElba8TUHvM4/lj380I8t1fwnPzo3bTz0rydFU07CBFP1qW2vVglsFJjPgA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CsMXRtJG; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CsMXRtJG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hBHL76BBNz2yYq
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 17:11:27 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A727543CC5;
	Fri, 31 Jul 2026 07:11:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E071F1F000E9;
	Fri, 31 Jul 2026 07:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785481885;
	bh=CWMEFKxEBjtPexxljun5XVOIgKx0us+3UHa4wux2fjM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=CsMXRtJG4F+CvAtfiZlLOdBtJp3OuGJeYa1VxovTnRGzy9dbleCF+KaD1o70shxrq
	 dJHfQ6JkZ4NX20MnYyC/5LAPSciNZUN1CRGAyCraAGn4UliJ1OZ5BG17ShGgI3TqaZ
	 0TANC6PusKCFxZ9PJJvJS7eWC7FLp7IS+fQ+SDOhhBZLlzuJ0JWR7Vjhgo8ZKKhP9d
	 n8thGYEu7sx9cUh+tMB2YVCYdXOGgFnq1q8hgGjrbe8kazVMLzq9RmZ678362B9Y2f
	 ELyb9QGJ8w7BcLw/zT7N2FfwVV18b2Io/bQRrLIhw/FYJtVZiojEGr3B5JxUmCRFA0
	 0/dlupQLbVgTQ==
Message-ID: <ef09380b-feff-4891-83d7-19366681e8fb@kernel.org>
Date: Fri, 31 Jul 2026 09:11:21 +0200
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
Subject: Re: [PATCH] powerpc/powermac: Simplify bootx_scan_dt_build_struct()
To: Thorsten Blum <thorsten.blum@linux.dev>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260720231453.117271-2-thorsten.blum@linux.dev>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260720231453.117271-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 21/07/2026 à 01:14, Thorsten Blum a écrit :
> Assign the empty string directly instead of NULL checking namep again.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
>   arch/powerpc/platforms/powermac/bootx_init.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powermac/bootx_init.c b/arch/powerpc/platforms/powermac/bootx_init.c
> index 72eb99aba40f..abceae91dfde 100644
> --- a/arch/powerpc/platforms/powermac/bootx_init.c
> +++ b/arch/powerpc/platforms/powermac/bootx_init.c
> @@ -284,9 +284,7 @@ static void __init bootx_scan_dt_build_struct(unsigned long base,
>   	dt_push_token(OF_DT_BEGIN_NODE, mem_end);
>   
>   	/* get the node's full name */
> -	namep = np->full_name ? (char *)(base + np->full_name) : NULL;
> -	if (namep == NULL)
> -		namep = "";
> +	namep = np->full_name ? (char *)(base + np->full_name) : "";
>   	l = strlen(namep);
>   
>   	DBG("* struct: %s\n", namep);


