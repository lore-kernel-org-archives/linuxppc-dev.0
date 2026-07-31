Return-Path: <linuxppc-dev+bounces-25167-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7494C55167
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jul 2026 07:14:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hBHPD2j19z2ygh;
	Fri, 31 Jul 2026 17:14:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785482048;
	cv=none; b=myTrXCPyWurY9uX7DlREcRi/1nDmIJkFxzmAmATJ+8yxEw1p8OBetkX1Lzd+FYa41CJ+690O0/BhFmGIBr9GAF4E81BHtw+dwkIMv8fGVjyHfsx3Ve+tJjbIafdZjMtEfokC/TTG6P0eL/zdqH+Fgai+dIPGBCbdUIaiSb4WaYjflAok3sdi8H8zJuoLf8jgSOXBFp49RD2+ktePxIVcoRFwtuH6IisplHcXq+KSbMrh0niBXi20Gcw5k8rJtVDsmNJ74EE3TiGsMYXbvkhlnfOXeoKHSddANaD2vNXD8SWRaJfSBlyvahs8IerDsGaLunNZZ9yg7R1OeNnUufQNIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785482048; c=relaxed/relaxed;
	bh=bE2YKvVX+zCYpjyOTaeVPiDRBdBtvdo/N1hEJw6cSQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KRfHO2i0YBmORCqn9nqtR3xyKUTErN6HDwo+yYbznAQEgF6/be+n5KHm9hr/v94dy/GElJ/wGWUYbdfs2yda9Lu8YGaCA5QIaNaJq9GK4Mbzj7krHCpgWsVrjKvcgVQVDfRK3jUfeZnLkjY8SVjZ27i7J+UWqx8xGiZ6Ku/u2CqDYI739KCO7s9wPBD/9i7SfHkNKYugGKU1/fvFQKKLhLslHNDZg6reswlKaYOdLIPCE9Gmg3iNzyLwIM3tzKnTYNyw0gfTD0eVAd85XkVJcnaMINDKbq3uAQ1Oc9g4mk4zRctmP/95VLrDzrWi7kLKaa3Dp28uGz5JD+RiZCP8Kw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K/e18wrj; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K/e18wrj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hBHPC5C3Qz2yYq
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 17:14:07 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 93D08600AD;
	Fri, 31 Jul 2026 07:14:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 660961F00A3A;
	Fri, 31 Jul 2026 07:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785482045;
	bh=bE2YKvVX+zCYpjyOTaeVPiDRBdBtvdo/N1hEJw6cSQs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=K/e18wrjfzgNsB7CWurkDCE6CZOfcZFC7vJ9RLDO8rj8u5Nb5aCJ5rhTmJcin0ex/
	 bZolPa1VHE9sbMXL144UpNB+K62ecjEXL/7hy65IbtLGn9NmRY+m2nsPU6uzKmN/oX
	 z4KkApSrlVMKcgcGsnl7d6+4P7/yOdHFKivD/2tikLvkzhIrwbO/RkV5xxntd4xTWa
	 cABhXXh8gvookV6IrD6mch0NC9s+a8nc4uGSTxw97M8M35ImfmfrQ2e14QThczgR14
	 70lcYIgrxfbPjQlxAmouIuCf2oBL4z7lwIjr42yJ37G6n71iC3i5+snASiIADc7L3l
	 Wq8y8oIZog81w==
Message-ID: <2c505334-a744-499f-88f5-d2c779f69f0f@kernel.org>
Date: Fri, 31 Jul 2026 09:14:01 +0200
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
Subject: Re: [PATCH 1/2] powerpc/powernv: Avoid strlen() in pnv_restart()
To: Thorsten Blum <thorsten.blum@linux.dev>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260721155346.121975-3-thorsten.blum@linux.dev>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260721155346.121975-3-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 21/07/2026 à 17:53, Thorsten Blum a écrit :
> Check only the first byte instead of scanning the entire string with
> strlen().

Well, strlen() is not going to scan the entire string, it will break at 
first 0. But I agreed calling strlen() is not worth it.

> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
>   arch/powerpc/platforms/powernv/setup.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
> index 06ed5e2aa265..2af92e7ba4ee 100644
> --- a/arch/powerpc/platforms/powernv/setup.c
> +++ b/arch/powerpc/platforms/powernv/setup.c
> @@ -312,7 +312,7 @@ static void  __noreturn pnv_restart(char *cmd)
>   	pnv_prepare_going_down();
>   
>   	do {
> -		if (!cmd || !strlen(cmd))
> +		if (!cmd || *cmd == '\0')

Maybe !*cmd instead ?

>   			rc = opal_cec_reboot();
>   		else if (strcmp(cmd, "full") == 0)
>   			rc = opal_cec_reboot2(OPAL_REBOOT_FULL_IPL, NULL);


