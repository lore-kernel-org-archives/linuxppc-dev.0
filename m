Return-Path: <linuxppc-dev+bounces-1735-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D31CF31BA
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Oct 2024 20:43:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XJmxQ5f3Lz2yV3;
	Thu,  3 Oct 2024 06:43:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=93.17.235.10
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727901833;
	cv=none; b=Xfb2cYZhhdNKgEjrBan+NTa3kIA1hDqqcF+VmMoxVPXhf/c/vl7V6sCMxjtCG3TfLOswIBXn4sIeJZDiAJEXr1l2Ahs8PQH9NjL3k9uP2NJf80VrwJ3v7Nbj0g4KLfALu8CLQWREtGOtZcuypkW3i+xv7yJyGDkurXXEyIDjo5l68Qm4bqC52vtdq+AhA3USMT2ERF696Lh2heapmBphBorbJz+qlXaqhkStch3yqBS4yhu0HhAYC9yRccjYDDBLtrcUUeMtu2atrnMWnPxtqIPTzdF42YmpHqcxwYuHjE5CAhbqsP330T3TG1cchC3SEhDwmOXwjj1nFrZeCaiK5A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727901833; c=relaxed/relaxed;
	bh=rwXjQXsxMdu+PllcSnLzpPJbMaJyuB0YuocpHbUq83A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fieNGJuLhvUvtqZS/pl0+KyjkuBpe0g+iyqU8vH8uGv54Eid9LdvG3rWSo/4C14IRchSlNLk9KWZlKOtAyXhCsybsWICyz6wAgTGYcGIOfXQc82RiU6m2VA1XCAgVhG094lWGVgEtmC4jhsgz/1+ainsRV5I/+B8TTUiIOT3cADR6ezXjpMLFwOia6fLUBOtyrOC0+b3OiUGMe3s80WiGBxyx1pOvVf9l3sTBm3wcXHJrTGpf6ug653uCr5Z0FH0OZChKPgIrQWOjYEhK+piwkTewzCHJfh8xGWhYAZG4N4IvOYKYPfex+tha7K3YVXmdv2+Uqf4DnwEklAG/0FAfg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass (client-ip=93.17.235.10; helo=pegase2.c-s.fr; envelope-from=christophe.leroy@csgroup.eu; receiver=lists.ozlabs.org) smtp.mailfrom=csgroup.eu
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr; envelope-from=christophe.leroy@csgroup.eu; receiver=lists.ozlabs.org)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XJmxP3NVQz2yS0
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Oct 2024 06:43:52 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4XJmxH1JjTz9sPd;
	Wed,  2 Oct 2024 22:43:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qISjOr7O0dDK; Wed,  2 Oct 2024 22:43:47 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4XJmxH07Ckz9rvV;
	Wed,  2 Oct 2024 22:43:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id DDF428B766;
	Wed,  2 Oct 2024 22:43:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id SWDakdAXHTTF; Wed,  2 Oct 2024 22:43:46 +0200 (CEST)
Received: from [192.168.233.87] (PO16952.IDSI0.si.c-s.fr [192.168.233.87])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 6D9C18B763;
	Wed,  2 Oct 2024 22:43:46 +0200 (CEST)
Message-ID: <d9bdc1b6-ea7e-47aa-80aa-02ae649abf72@csgroup.eu>
Date: Wed, 2 Oct 2024 22:43:46 +0200
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powermac: Call of_node_put(bk_node) only once in
 pmac_has_backlight_type()
To: Markus Elfring <Markus.Elfring@web.de>, linuxppc-dev@lists.ozlabs.org,
 Jani Nikula <jani.nikula@intel.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Naveen N Rao <naveen@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <b7e69e04-e15c-41ec-b62b-37253debc654@web.de>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <b7e69e04-e15c-41ec-b62b-37253debc654@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 02/10/2024 à 22:02, Markus Elfring a écrit :
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 2 Oct 2024 21:50:27 +0200
> 
> An of_node_put(bk_node) call was immediately used after a pointer check
> for an of_get_property() call in this function implementation.
> Thus call such a function only once instead directly before the check.

It seems pointless to perform a put immediately after a get. Shouldn't 
of_find_property() be used instead ? And then of_property_read_string() 
would probably be better.

Maybe you can even use of_property_match_string().

> 
> This issue was transformed by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>   arch/powerpc/platforms/powermac/backlight.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powermac/backlight.c b/arch/powerpc/platforms/powermac/backlight.c
> index 12bc01353bd3..d3666595a62e 100644
> --- a/arch/powerpc/platforms/powermac/backlight.c
> +++ b/arch/powerpc/platforms/powermac/backlight.c
> @@ -61,11 +61,9 @@ int pmac_has_backlight_type(const char *type)
>   	if (bk_node) {
>   		const char *prop = of_get_property(bk_node,
>   				"backlight-control", NULL);
> -		if (prop && strncmp(prop, type, strlen(type)) == 0) {
> -			of_node_put(bk_node);
> -			return 1;
> -		}
>   		of_node_put(bk_node);
> +		if (prop && strncmp(prop, type, strlen(type)) == 0)
> +			return 1;
>   	}
> 
>   	return 0;
> --
> 2.46.1
> 

