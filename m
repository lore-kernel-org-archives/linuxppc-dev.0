Return-Path: <linuxppc-dev+bounces-25169-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF62FC54F54
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jul 2026 07:17:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hBHSw3T4dz2yjR;
	Fri, 31 Jul 2026 17:17:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785482240;
	cv=none; b=YFhvWTF+2fXnYOwcKcT0cuh3MGwoBETBMgRAjxxle6os91dMv0ysCoRSz67Gt4Y5OD9DbPl8yuQuDq6iBZZ3ubPxRD1UNw/nFODsTiEgBQWT3+T4sKp1fsrGrlV/USZNG/FRxCMQCcMm/iM3tXb6Q8jipTNjk6gK8arignA0y8NRUbWs3ZNNFp9Viy7BwE0hDVu+qk2ABdCotPZ7dyK79gQse579GRJJ8qCScuZt9wuH8uHKp3b8L3abjsYXqdT4k523xUCwOOx+pPIk3ZJQajiK0ICe1rqV6iTYmFVKCmSLn4fevSyVQDZTc9xepuPLf6khUle8j9ebzWj1SaPGzA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785482240; c=relaxed/relaxed;
	bh=TvqLQZZy3YaPJ22gRjBlXpOVn/OsX3M3hujOjGskfPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JmrYYnAzpM2gzeEJhjghIrB9od+2fSNEMCS+VL5Gz2ayUAqCJJykHIUCAViSyQV7KEpYOnQHfdEAVOmNEkVCk0DlF/nEl9TqW171EMPJQsZoA7KcZvCg7NVuLef6qw9iEXDfo5d18B+SUQ3F0uFqiLnzgUlRlEwEYOf9OC7Z1LUoQr6KqdkF5UguPLkVE0Oqg++iDVnW3et3v7Gxe8oiQ9GRToa/vih1pkAdxV0puI200aYxFmDCX5Usf+Tshhd0pIs8kt5AymvWWQx6r8RfysLQtsNpxl07uMh6Bc8AOJQdvu2fS3YeO9UJHGUMaEzDjXZ/vKyAP7p23XnXp/rIVQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KXqIImk+; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KXqIImk+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hBHSv5rntz2yhv
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 17:17:19 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1C0686004E;
	Fri, 31 Jul 2026 07:17:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A04B1F000E9;
	Fri, 31 Jul 2026 07:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785482236;
	bh=TvqLQZZy3YaPJ22gRjBlXpOVn/OsX3M3hujOjGskfPk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=KXqIImk+7VbFZEszErleX4fwkYjxPcWHe7orzS7OVILlovuqjit/akRDASO7AhLpz
	 OVqAlBUFh2FFZOe4nGA4YBRx1LZjirnhBFGI2Q4q34LlI4w0E4n/SnwGShNtR+ED/m
	 NQGFn8T/Id/Ead8rpfQegTbx5ubAh1E8Xlnv9h0zEKsHbLUvpfqoawvYY43miqBG8I
	 yfbOMH/tnwDwCexP0QB/ZlYKfvwb6hwdy0VwtcFLoqyRx1hxR3oIgkw52kNYGtQG+9
	 2KB/RrShg+dS8oe9KBUIbTpDJxepTP4+3Y/xOXJo8Rg5U33f01G+sjJtSXfrdyhwW+
	 yOBHXPO7dZesg==
Message-ID: <e85f28fb-47e2-424d-a527-786d4626e7fa@kernel.org>
Date: Fri, 31 Jul 2026 09:17:13 +0200
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
Subject: Re: [PATCH] powerpc/boot: Remove unused sprintf()
To: Thorsten Blum <thorsten.blum@linux.dev>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260724172200.208722-2-thorsten.blum@linux.dev>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260724172200.208722-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 24/07/2026 à 19:21, Thorsten Blum a écrit :
> There have been no sprintf() callers in the boot wrapper since commit
> e275e023aa69 ("powerpc/44x: Warp patches for the new NDFC driver").
> 
> Remove the function definition and declaration.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
>   arch/powerpc/boot/stdio.c | 11 -----------
>   arch/powerpc/boot/stdio.h |  3 ---
>   2 files changed, 14 deletions(-)
> 
> diff --git a/arch/powerpc/boot/stdio.c b/arch/powerpc/boot/stdio.c
> index 31eece29f56d..b12aa2c0b8e7 100644
> --- a/arch/powerpc/boot/stdio.c
> +++ b/arch/powerpc/boot/stdio.c
> @@ -326,17 +326,6 @@ int vsprintf(char *buf, const char *fmt, va_list args)
>   	return str-buf;
>   }
>   
> -int sprintf(char * buf, const char *fmt, ...)
> -{
> -	va_list args;
> -	int i;
> -
> -	va_start(args, fmt);
> -	i=vsprintf(buf,fmt,args);
> -	va_end(args);
> -	return i;
> -}
> -
>   static char sprint_buf[1024];
>   
>   int
> diff --git a/arch/powerpc/boot/stdio.h b/arch/powerpc/boot/stdio.h
> index 884d5959a9ae..d5a7a0f54453 100644
> --- a/arch/powerpc/boot/stdio.h
> +++ b/arch/powerpc/boot/stdio.h
> @@ -12,9 +12,6 @@ extern int printf(const char *fmt, ...) __attribute__((format(printf, 1, 2)));
>   
>   #define fprintf(fmt, args...)	printf(args)
>   
> -extern int sprintf(char *buf, const char *fmt, ...)
> -	__attribute__((format(printf, 2, 3)));
> -
>   extern int vsprintf(char *buf, const char *fmt, va_list args);
>   
>   #endif				/* _PPC_BOOT_STDIO_H_ */


