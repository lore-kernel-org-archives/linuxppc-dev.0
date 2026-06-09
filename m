Return-Path: <linuxppc-dev+bounces-22307-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11486CD8C85
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2026 04:52:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZGjb6NDPz2xR4;
	Tue, 09 Jun 2026 14:52:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780980739;
	cv=none; b=aWJ5do1TZwmHIf/hsZbbugjJY9JsfjCRexJb+WwRfNJvPJSacvUDqEs2//yJ9R8QcvCVtwu10dpmeDTEClwAtAKoutK9CcFL1Kbn0gHEH/Xoy6h2lcJpn4dXrI82Xu9PMv4b3kZkH3OTXI+5kmRv5TEP/kvGMaF1TgnjfaIwgUKLnW3lCKkACcosum6lOaOsQ8h9Cx3ons0cHEpGx8dQEdt63xfScyXXqUYDfMLZHHJcRGQdkgs/O+shMrWkz74WQETnRGNeK/rmvjEN9iX0RL6alPjMjMOykpMfTmteAsf9ZzzR0rlP6ZsZ3brACLjgj827CGSq7D5QfNbIC5D2XA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780980739; c=relaxed/relaxed;
	bh=AM4HP9aFANNRY7F981Mb8s4GwwvUAYw+GseftHT/r2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=djkWrzlh5wZS9F+RichAEYavhssGvfW2ToLXfwcB1gz4sBcvJalMZg+4qkt/WApmW9bodC9fHRZACKur+c6WNqP1L2gr+wTCUDwUXIolX1jCmss5wyYnyTPgjmsj9KcupiqLQgjrb1XfSZ65SbDw6ioS0si8QnxJy3qsS0VNP7C/rJcw+w8WkRuICOtMGgsHiKUa2bUN+5wJqGVBnVu/ogsACnfPVnlwculgz64rtCCYpMR9adg99W9YbNZb3Ac2Vx+VKVIuTQChBhvWHtcN92ikzZbuluIv3psRsMFSqjALkqZsr0DYdXQR2droKw8qsLeysPReCYROpfVKXniTNQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GlsVQjbx; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GlsVQjbx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZGjZ6LVRz2xM7
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 14:52:18 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7CBFD43AD6;
	Tue,  9 Jun 2026 04:52:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7BEA1F00893;
	Tue,  9 Jun 2026 04:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780980736;
	bh=AM4HP9aFANNRY7F981Mb8s4GwwvUAYw+GseftHT/r2U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GlsVQjbxDJ6cu5d9TO6afwLdL9IBaSdsCAr4lqTjRiDjKpVc3vf2HjFHqUPj+EDbe
	 c5FjlxeQcOr6mC86y6Rzr7c94qqO+yW5hohgljI/8FEcT9DxEiNaJgL9E0W2Pjgjyq
	 wSZjiFeznDtKAOpGQ+tco1OZ4egdJ9X9QLSI2nb4GYAIgHK8Ek7aRl5+LI7PAVpPi0
	 4SL3A3Zy1kwdsPnHSzvsiU4BrzBPOQtFNQOX9NRg3z9MWLGwzdAIMMDVbvHlmrHquh
	 WI78EeZ89QFnxCptUM07qi+o2WnPUll9bIVT/f1CXaSpr0M+S0fXM4DS4cok9umlgW
	 8c7ytDebdRNHQ==
Message-ID: <8b3dcd60-e4dd-40ac-80e0-c2561e3b89e6@kernel.org>
Date: Tue, 9 Jun 2026 06:52:11 +0200
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
Subject: Re: [PATCH] powerpc: replace strlcat to simplify
 ppc_kallsyms_lookup_name
To: Thorsten Blum <thorsten.blum@linux.dev>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260608193203.163266-2-thorsten.blum@linux.dev>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260608193203.163266-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 08/06/2026 à 21:32, Thorsten Blum a écrit :
> strlcat() should not be used anymore (see fortify-string.h), and since
> name is guaranteed to be NUL-terminated within KSYM_NAME_LEN bytes, use
> memcpy() instead.
> 
> Rename dot_appended to the semantically clearer prepend_dot while at it.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Please take 
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20260506021143.13797-1-xieyuanbin1@huawei.com/ 
instead

Christophe


> ---
>   arch/powerpc/include/asm/text-patching.h | 17 ++++++++---------
>   1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/text-patching.h b/arch/powerpc/include/asm/text-patching.h
> index e7f14720f630..c47b813bd067 100644
> --- a/arch/powerpc/include/asm/text-patching.h
> +++ b/arch/powerpc/include/asm/text-patching.h
> @@ -227,22 +227,21 @@ static inline unsigned long ppc_kallsyms_lookup_name(const char *name)
>   #ifdef CONFIG_PPC64_ELF_ABI_V1
>   	/* check for dot variant */
>   	char dot_name[1 + KSYM_NAME_LEN];
> -	bool dot_appended = false;
> +	bool prepend_dot = name[0] != '.';
> +	size_t len = strnlen(name, KSYM_NAME_LEN);
>   
> -	if (strnlen(name, KSYM_NAME_LEN) >= KSYM_NAME_LEN)
> +	if (len == KSYM_NAME_LEN)
>   		return 0;
>   
> -	if (name[0] != '.') {
> +	if (prepend_dot) {
>   		dot_name[0] = '.';
> -		dot_name[1] = '\0';
> -		strlcat(dot_name, name, sizeof(dot_name));
> -		dot_appended = true;
> +		memcpy(dot_name + 1, name, len + 1);
>   	} else {
> -		dot_name[0] = '\0';
> -		strlcat(dot_name, name, sizeof(dot_name));
> +		memcpy(dot_name, name, len + 1);
>   	}
> +
>   	addr = kallsyms_lookup_name(dot_name);
> -	if (!addr && dot_appended)
> +	if (!addr && prepend_dot)
>   		/* Let's try the original non-dot symbol lookup	*/
>   		addr = kallsyms_lookup_name(name);
>   #elif defined(CONFIG_PPC64_ELF_ABI_V2)


