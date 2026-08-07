Return-Path: <linuxppc-dev+bounces-25604-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C692C5AC7A
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 15:32:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGp7S11Q5z3c78;
	Sat, 08 Aug 2026 01:32:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786116772;
	cv=none; b=oyzTlnZ0I7LftiJzk6jwkV8f78WBb8qMNtUJleq9Pg27EptwmU2VQIBtOtpG6bfEZUPXB0udLH6NZ9fVjamBK/sCS0vmMaMdtpLoOPOh/NFZQ0Zioma66Sg8Ls0K4QprmpkG1UiMxsUvIT31juBTAYe5ei3YtsxNftbIGHEu4WDy5lhsS0WXeUtSTFvEmBWZSAzxmuDDyDwvysJHB8uVYnf0yD5gZDXf41TFhVrR+Q+Rhjlo/DhDdbMCZsnM0yU68dfYQOSsr+o9jMrGH1mfBnUj5pR41iWdC3bpKBCQlCqUMzYsIcFQmj/zGj7cg2lLi41bk0CRiF+hkIcUTbUsCw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786116772; c=relaxed/relaxed;
	bh=ZT7C2HKeSDCTz1i5MS0qtmVe36LfLMZoGrCwyPKq500=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nlaN+RP9mpmIAVeFJ9scutmfmiODFLwiWdmqRXXwRetJYHFWiePuJ7DHQfr8kdBT5XonXLGJqBMet3ufcMkSPu2OCVOZStNF3R5guxhg5qYTrdctJO2kZQZwmYUzNJwRrw4UlmkgBFNMSXSX4ZuFPX5xY65foZYd3DXdY67xV77EuL+VbPkSCVcZke7Wbzio//idUpG5iCSRDolhHbWJCFmZF9ZcxJiH4LHIQlccZYooP7jQgm4HCkvLyKqTtcIyuhITXZd9QtklGMfGhyuazeYxUZlOSucdIcWKTaDFlfDLNn0OlLI0fU1zSpBaW5cnBJukkX2PsmZ0bgWf7+aLgQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mX0EuKR6; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mX0EuKR6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGp7R1MJSz3c75
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 08 Aug 2026 01:32:51 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1BDF660A5C;
	Fri,  7 Aug 2026 15:32:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1893D1F00A3A;
	Fri,  7 Aug 2026 15:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786116767;
	bh=ZT7C2HKeSDCTz1i5MS0qtmVe36LfLMZoGrCwyPKq500=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=mX0EuKR6SA7+WFixfUFKJdqRAHyW3bXS4b/gjZPgc0sZGzWIJ7tPww5zBh30Qx98U
	 Ut2ZUTL4qw7Gwqh99h3EzXG9XFBIqvCjUl9vB6bpv6EHdxAeb6iOE0Taw/ic+99TOr
	 xLmJilpR1/7MY2lNlBSkLx7xD3MhbXLy6/VpenQuqPRMsDaY08nJ+OYeGCgMeePmtX
	 ZqUEPLHxwjCVvQKwM8+GdVe6/o3x5oRejhPcqK0SOoox7TEjOt12zWLGNwNUGukp6G
	 UI1ZLgjJEdjwfQf+R57uEjkIbN/n6++sasQRX83iFortJMu0ifLrgOz6TxfdcwuO7j
	 W5dU6Sajt+LPA==
Message-ID: <41e20610-6bc5-400c-9e44-c214162605e0@kernel.org>
Date: Fri, 7 Aug 2026 17:32:44 +0200
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
Subject: Re: [PATCH] powerpc/boot: Mark exit() and ps3_exit() as __noreturn
To: Thorsten Blum <thorsten.blum@linux.dev>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Geoff Levand <geoff@infradead.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260807152353.306889-2-thorsten.blum@linux.dev>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260807152353.306889-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 07/08/2026 à 17:23, Thorsten Blum a écrit :
> Since neither exit() nor ps3_exit() return, annotate both functions with
> the __noreturn attribute to improve compiler optimizations.

Is it worth spending time optimising a boot sequence that will run only 
once at startup ?

Do you have any figure on the improvement ?

Christophe

> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>   arch/powerpc/boot/ops.h | 2 +-
>   arch/powerpc/boot/ps3.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
> index a40c2162a4e9..df52b14816e2 100644
> --- a/arch/powerpc/boot/ops.h
> +++ b/arch/powerpc/boot/ops.h
> @@ -217,7 +217,7 @@ static inline void free(void *ptr)
>   		platform_ops.free(ptr);
>   }
>   
> -static inline void exit(void)
> +static inline void __noreturn exit(void)
>   {
>   	if (platform_ops.exit)
>   		platform_ops.exit();
> diff --git a/arch/powerpc/boot/ps3.c b/arch/powerpc/boot/ps3.c
> index 89ff46b8b225..22fa35960926 100644
> --- a/arch/powerpc/boot/ps3.c
> +++ b/arch/powerpc/boot/ps3.c
> @@ -45,7 +45,7 @@ static void ps3_console_write(const char *buf, int len)
>   {
>   }
>   
> -static void ps3_exit(void)
> +static void __noreturn ps3_exit(void)
>   {
>   	printf("ps3_exit\n");
>   


