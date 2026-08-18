Return-Path: <linuxppc-dev+bounces-25943-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F706C5DF74
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Aug 2026 04:39:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hPH704DLVz2xrL;
	Tue, 18 Aug 2026 14:39:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787027996;
	cv=none; b=oxpk5vZUs2G7hxdrgwakIlDx8eyZ6boqVVR5r/09K1ltMVsvCBI5EiGKSpG4PNZyds5e4tTfyad4eW2tWfNqoTJEj4fIb7mZKc0C8t6+zjTOgIV/8/FgO0ttw68ndhnbn6m2GBU3qnwNt4mvOwO4jlTi2Md9zwQwNb7Fowd4TVzvu977o8aG4XHnh59Fh3bWyeks8vp+MyaU8/+wc5zn5t0JLn4abCNssW4C8gzT4JXkuZTGSWytw2J2wIpwBARZxxzoqMM+D2nJBfXp5cBBu4j0TJFPjxSMG6xdqZJiGJWcvfMqDO3Jde0q4ZfSlsPdL/1Tlq8/XCSDhGTZ1BwVvg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787027996; c=relaxed/relaxed;
	bh=1mCK1bc1te5TEpagpLJvUyCDXU4MnoiOnVWdWfGPwYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F+TcZlv6Zfq2VCkvukNN1SYuD4slTCUrKuv4XUkKUst0AotJM0+zAizBQX0RLX7Jc5gk+pxCAfeHIaUp3w2ymvIxyO/aE8JvEGk6LVZ5ZQnJCCFZaJL0H+FKaSPKmFJCeTgZ9CC/WppGd6ORiC/Ye9ZG4rGSMjM3dYF6sRNIBUKwqZkgjindLiDSy+VW9wzRGFIL8n+EqsvbjX+NUT14pxEHl8NTJ5SLlm0TSwcFp7YXFCEA7thiz6nXpYZt0z8yjSZfvfrE+svRZEbABeO+F+OqGjL3/HB6jMgZyeVtoPYsQSeNVaJumOEsPe8w2ClAGA2YjjXA5czJ1q8Ko1PjTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L+adqrUl; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L+adqrUl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hPH6z3vysz2xpv
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2026 14:39:55 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D4B47600AB;
	Tue, 18 Aug 2026 04:39:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77ACF1F000E9;
	Tue, 18 Aug 2026 04:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787027992;
	bh=1mCK1bc1te5TEpagpLJvUyCDXU4MnoiOnVWdWfGPwYw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=L+adqrUlOrGotN1VvrwOYJSiNTamJodvx/smLA51EneLx+sZucV4sca9hAvjYRUhM
	 FhyYJA0MGMprq5tOQMp5LNRHqcWHPekcUNqEJX81JsLz4tc6nL+AEusWuT5+G7YJNM
	 ru2NaIe1CRl4ALTkbYhny+CUi5tMZW0dgA9rPw9b5d0OAOVzTb7/kcrM4zY6X6BADI
	 +DL15cTlX2XrnHw9yJhRW4+4FMEGEN8q72ZlDuLUXM7S3IEzOo8/LfNBUu3YeEnAV2
	 vhNit3t0M840eDQDSUm/41rFmJI9LxYM/lOq0HH3+6oxMVEWoO/+cb2qTnuxHp1Ai5
	 9eZTZd2u+iynw==
Message-ID: <fc06ea42-9510-4bdc-9673-da64eb822e53@kernel.org>
Date: Tue, 18 Aug 2026 06:39:48 +0200
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
Subject: Re: [PATCH] MAINTAINERS: powerpc: Add Ritesh and Shrikanth
To: Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, npiggin@gmail.com
References: <20260818035037.613186-1-maddy@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260818035037.613186-1-maddy@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 18/08/2026 à 05:50, Madhavan Srinivasan a écrit :
> Ritesh and Shrikanth has been helping in the powerpc mailing list
> patch reviews, adding them as reviewers.
> 
> Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>

Acked-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
>   MAINTAINERS | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b7094a616afd..e1c5e6ed5ed0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14876,6 +14876,8 @@ M:	Madhavan Srinivasan <maddy@linux.ibm.com>
>   R:	Michael Ellerman <mpe@ellerman.id.au>
>   R:	Nicholas Piggin <npiggin@gmail.com>
>   R:	Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> +R:	Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> +R:	Shrikanth Hegde <sshegde@linux.ibm.com>
>   L:	linuxppc-dev@lists.ozlabs.org
>   S:	Supported
>   W:	https://github.com/linuxppc/wiki/wiki


