Return-Path: <linuxppc-dev+bounces-25165-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA8BC55167
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jul 2026 07:09:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hBHJ22WtLz2yYq;
	Fri, 31 Jul 2026 17:09:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785481778;
	cv=none; b=djgu1D5yu9q5x5FWNmlQ7A4DJ8I4I1naFWRL/6rNpQMA6zqdSxMgKp4Xrp9z5+g67/ElA9zW6QYczHl2SVTMSQdy/0EmYndQUbYgxgB5UebLS1t4gfNEUlPHSrc3N7vOsdI2WP27sJfHqjdR3rtvQmjt/mdPq8WuFRt/vwnp4W/eSUFYS/UDJix/gO9Sxx7YwsOu/qhPBDXtqYQidGNpB7COlICZXgl/ENFMfJJs3iwjdOW07KnzLRMgcT2iEPpPp74jUNRJTUM0J3EoEs3sr71OhOx54SuBGxYcl8y4YjRB0lwplwsXBGDWnvNmUp15wRlBUvcCVzhySAhvJvZ+uw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785481778; c=relaxed/relaxed;
	bh=rhw+Tc7eilLPGsXJEbmsKbbF/WcLk9AsnAtacOY+EQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TjFDkbYjFEdbMjyRD+a6CYAswq0NuA4t+HxqPw9bSy5VnSXy5mDjdJG09mOtrQix2Mko8oDCp8Bs1nFCpt/Kkw5Lx0rAMcrwFAkMdhjLA5oGdAJzwC2uDjwJU+oto2h39NphBOaH1vUGcZHpmAcy4sMNxIRoHt87oAJbFtwCqG09WLxCgnLl7nInjs0SAYJadCOc3c+sm1M8L3OEF8hX+HZPHU8khB+7QnYVDGKNhocQQtMPVQCl/SrgvVOhgnzspwAchNIFxtD1pgK/LvBl5z5WGdVLU6WzcXdlOiX/RoXpztf8FTszZ1tyccazusMJkM0B9JLWVBfgKtqXKqw3NQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QHHBG5S6; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QHHBG5S6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hBHJ12l7lz2yY1
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 17:09:37 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0AC3A40AB7;
	Fri, 31 Jul 2026 07:09:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E55D01F000E9;
	Fri, 31 Jul 2026 07:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785481772;
	bh=rhw+Tc7eilLPGsXJEbmsKbbF/WcLk9AsnAtacOY+EQo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=QHHBG5S6rLHEYM7zRgqzwdR7pkmHK/54agx4Bx43Wj0kmy8cAZmDrxho4pGu13FdB
	 cYVNqaUJ3B+FUCMS/dD880/EYiR9l1BxYOJcAFjeEgQbxQGYGhWSO4oMCgATxvWwfq
	 hd+x3mjDgfL6SF2JK8quTLJseMTYbpVgKptcaFGZ84vBrF6Z5pEK/1xJKCSErB4WA1
	 lZPiJEyT+lOB1ic5Sf/cTNL2KG8+X5wV0TQaQLDi9hZ6rYRCtSZl+axAe0Q8G+BWyF
	 eY2N5sC4Ri8JeVpDe11DbU8miOidFSr93lOCcoNHNmZwLTKtK9aaOpxBTorwu2TxZA
	 Ki7VPuj0Ic6EA==
Message-ID: <1024f0e7-b9b5-4f5d-b0f5-5e7f08c51cbe@kernel.org>
Date: Fri, 31 Jul 2026 09:09:29 +0200
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
Subject: Re: [PATCH] powerpc/ps3: Use cpu_relax() in ps3_create_spu()
To: Thorsten Blum <thorsten.blum@linux.dev>,
 Geoff Levand <geoff@infradead.org>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260720231153.116827-2-thorsten.blum@linux.dev>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260720231153.116827-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 21/07/2026 à 01:11, Thorsten Blum a écrit :
> Use cpu_relax() to wait for the execution status SPE_EX_STATE_EXECUTED.
> Drop the comments while at it.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
>   arch/powerpc/platforms/ps3/spu.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/ps3/spu.c b/arch/powerpc/platforms/ps3/spu.c
> index e4e0b45e1b9d..8545c72385de 100644
> --- a/arch/powerpc/platforms/ps3/spu.c
> +++ b/arch/powerpc/platforms/ps3/spu.c
> @@ -13,6 +13,7 @@
>   #include <linux/export.h>
>   #include <linux/io.h>
>   #include <linux/mm.h>
> +#include <linux/processor.h>
>   
>   #include <asm/spu.h>
>   #include <asm/spu_priv1.h>
> @@ -363,12 +364,9 @@ static int __init ps3_create_spu(struct spu *spu, void *data)
>   	if (result)
>   		goto fail_enable;
>   
> -	/* Make sure the spu is in SPE_EX_STATE_EXECUTED. */
> -
> -	/* need something better here!!! */
> -	while (in_be64(&spu_pdata(spu)->shadow->spe_execution_status)
> -		!= SPE_EX_STATE_EXECUTED)
> -		(void)0;
> +	while (in_be64(&spu_pdata(spu)->shadow->spe_execution_status) !=
> +	       SPE_EX_STATE_EXECUTED)
> +		cpu_relax();
>   
>   	return result;
>   


