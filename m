Return-Path: <linuxppc-dev+bounces-21441-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD71CD5BAB
	for <linuxppc-dev@archiver.kernel.org>; Sun, 24 May 2026 21:35:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gNskX09vRz2yMl;
	Mon, 25 May 2026 07:35:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779658531;
	cv=none; b=k7ip7DQNpnKFVgnNTLu089pT5pId0IswLLxzAyRI+3mhq5bpEC8YDUK4uGPurCnbhrG3oFOPPGT3UhGUL/2LDEcpFi8I5JOoslTfHbrHentOfsj+DdJGfOoK0/Y7R64d7NzwdLVZN/PKTPnzKFhhOx5KFF4p/Yl+IXwbKU03xkJNRcl2PhDFWSH7ABHV/H/UluWtR9pTBpeJJ8zTnQFUnTmK+BektAFSO9WPPrGol0eKYtwcAR9DhGzneXAR9vhCeGNYDrDdDb40mkHbBWeMYxlqHhb6Z4hq9otI4C2ANakRLV497j4Ypc+Gnmg8yBy6PPsp9pOmwq+XMxg9LixJVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779658531; c=relaxed/relaxed;
	bh=U6GP2HYz504qxqIvc8Ml5fkvXwFc8EWnUWB8skfrUuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9UM2Wtai1MXA0hfP8yRZj205McGEdaM/9TQ6UvvQlxRdqw64t/BHjmlukvITPQB+XZB6W5bMWR29WVHFo4bly9gWxByTHjzNm8rGXCrDZ7vsV5xDO109sKgRG55uDzuIrOe3IOAkPPUG+DLkkUMI7PNtlgpsiopmxkKpag5K5SmkXQlBD88zLHzqN9J/hFdLR5RlBuNQaWIatRryVbwWaq7TP6de00LClV5RE5YOzpCWN6qjacjEEXI9wwEFkvr2FETAgKRQq9pfxWej1pcfhi6iKru2sCgp1alUeCyGB64kqPMMvxJplB0OpFIMYaAdjqjQHSNbXXLmH9TXr5UDQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FfXrugTg; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FfXrugTg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gNskW1MBnz2y8d
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 May 2026 07:35:31 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7250240850;
	Sun, 24 May 2026 21:35:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F79F1F000E9;
	Sun, 24 May 2026 21:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779658528;
	bh=U6GP2HYz504qxqIvc8Ml5fkvXwFc8EWnUWB8skfrUuw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FfXrugTgPzcl9wLXaVk0gF/vp8j1ec6p6Z0M3e0VbZjr7Thm3n+eGj1ZEjYHpOuY+
	 ridfOzbZH65lqYLVh9RZ8FuMXRbQbXQLyRUXQbLvrno/Ks0xz8ux+81boN/UX06Rla
	 A7fZfRlXqChzbPIKGxlVSTi8J7zwvTMU1BmNV/tCBkCM2fkxgEojm8kJKYF4QMsm3r
	 ePshs/URUul2KSAWrwJQJ9AE94hex9+ELFriuGGgcRbX83FAZ8CBSplpxM9HpQ/RV2
	 kWdS0FLNZVb+cQJM1gGghV6hd+ujz/Y0uG9e+6jPjvaJJlIKbxtMZyVLM0bPCPgekW
	 Cx3ur9rFvheSw==
Date: Sun, 24 May 2026 16:35:25 -0500
From: Eric Biggers <ebiggers@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Breno =?iso-8859-1?Q?Leit=E3o?= <leitao@debian.org>,
	Nayna Jain <nayna@linux.ibm.com>,
	Paulo Flabiano Smorigo <pfsmorigo@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>, linux-crypto@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: powerpc: update VMX AES entries
Message-ID: <20260524213525.GA112327@quark>
References: <20260524212943.799757-3-thorsten.blum@linux.dev>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260524212943.799757-3-thorsten.blum@linux.dev>

On Sun, May 24, 2026 at 11:29:45PM +0200, Thorsten Blum wrote:
> Commit 7cf2082e74ce ("lib/crypto: powerpc/aes: Migrate POWER8 optimized
> code into library") removed arch/powerpc/crypto/aes.c and moved
> arch/powerpc/crypto/aesp8-ppc.pl to lib/crypto/powerpc/.
> 
> However, the "IBM Power VMX Cryptographic instructions" entry still
> references the removed file and no longer covers the moved aesp8-ppc.pl.
> 
> Remove the stale entry, add lib/crypto/powerpc/aesp8-ppc.pl, and tighten
> the arch/powerpc/crypto/aesp8-ppc.* pattern to match the remaining
> header only.
> 
> Fixes: 7cf2082e74ce ("lib/crypto: powerpc/aes: Migrate POWER8 optimized code into library")
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Acked-by: Eric Biggers <ebiggers@kernel.org>

If this doesn't get picked up through the powerpc tree, I can take this
through libcrypto-next.

- Eric

