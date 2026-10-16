Return-Path: <linuxppc-dev+bounces-29591-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B161ECC6B38
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Oct 2026 07:28:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5c3y6R9Yz2xNC;
	Fri, 16 Oct 2026 18:28:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792135694;
	cv=none; b=ik5wnGwGViis+Sw/EOfz+I0UeNB4MQtjemzRVsgZaZEfQE+OB5hNtbillEQcwL0059KmlvKSYnPIlAV3IPxus9mJI38XTvXBdS4MiEoQNxHjJ42Ysym9wxqivhKMLZZIid3Zrw6RIWwNAZPio9hH6CiY8xbbfjYi0W4TgRtAp79sU/V/vBvRQhEYf0sROsJ3e80PgoW88dH64cXtZYL+oRaz0+6rjT3SUU/dnFmf/lQkqk6VJwh81ucsJnG+L6EPWDYWpQnqv46ywGXXyBZBw7NOdVvxvytV9TF1a66Yv/oDw7t4ykTmTsJCaBXKoq67KKjqElCxqH/m4AB89D+5PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792135694; c=relaxed/relaxed;
	bh=cxKxHO2MCyzxbgYAzs8LlnDp9zqcep7qEmycS6UkohI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SzLzsBpvGMd+7K3Nj4307GEFdLoDt9SsFZaomU7ckRi2Tvq0w04JV7u9H6+ik9ITsLm+fW7OjqLhliFcHE5ANSZTnzs/eTR7yC9cALgdwfIHv37FcPXl/S1kWW9JrwF0nxfCI5S/ctQfGLLwCMH3hoShI4tRynL5RJML3L5H3ITnHMQksoOainHJo8XBnP6Kh+ezLBefInAAXwfL6zVPvsvUVRbDrrM65mW+40BaJngvLDl8ci7CBwDKisuAx8WBRqhjkEK5mAHEEpYs7ZjLIq14N3nfBjp+CTnHYkA84S+Z/Ind6WlZuS+TNpdxnqWENSH/yHoZ0G+SzwQiGsQKaA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZTt0AcQ3; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZTt0AcQ3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j5c3x6YKsz2xN4
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2026 18:28:13 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 42DB141A8F;
	Fri, 16 Oct 2026 07:28:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D49991F000C4;
	Fri, 16 Oct 2026 07:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792135691;
	bh=cxKxHO2MCyzxbgYAzs8LlnDp9zqcep7qEmycS6UkohI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZTt0AcQ3YuGFOHgTRdduzRZUPs4E63uas086PQN5dE8SweHEvqrG7JMSyn73Q3HJ5
	 sckJ1vYU/xT32subvoCoj8Tgfh2q3PbjOY1uNh4pV9yLcHBPT7iwQGZQC/KZIrrmro
	 u0EQPoVySrIJIAmzAArWed6ou5ZuqJb2ht7Dqs/JVL/9o3ijTYg6toTYYmV6sRrO7X
	 iNs7B5pPp8pFIzEtX0aW7OszmysgSP4RyGnC2FGHgpESD9Er4YmvCniA3yROyUvXJQ
	 bbIGcy7riKMy7zVpuaNJgsYvVsGF48XkHfL2HlmDW6eJBd00PEW3lMK5JwTEIjyHmI
	 wECA8NMDh+qfw==
Date: Fri, 16 Oct 2026 00:28:09 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-arm-kernel@lists.infradead.org, x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Vladimir Kukharenko <vladimir@genproof.com>
Subject: Re: [PATCH 0/2] lib/crypto: Use size_t lengths for Poly1305 and
 ChaCha
Message-ID: <20261016072809.GA3049@sol>
References: <20261014152604.323310-1-ebiggers@kernel.org>
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
In-Reply-To: <20261014152604.323310-1-ebiggers@kernel.org>

On Wed, Oct 14, 2026 at 05:26:02PM +0200, Eric Biggers wrote:
> This series upgrades the Poly1305 and ChaCha functions to use size_t
> lengths, matching the rest of the crypto library.
> 
> It also fixes the (not currently reached) handling of lengths above
> S32_MAX bytes, and (not currently known to matter in practice) the
> assembly functions depending on unspecified high register bits.
> 
> This more comprehensively addresses the issues identified in
> https://lore.kernel.org/r/20261012-libcrypto-4gib-lengths-v1-0-ea566c129a2e@genproof.com
> 
> This series is targeting libcrypto-next.
> 
> Eric Biggers (2):
>   lib/crypto: poly1305: Use size_t length
>   lib/crypto: chacha: Use size_t length

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/log/?h=libcrypto-next

- Eric

