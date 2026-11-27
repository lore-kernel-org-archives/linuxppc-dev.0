Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99765606A31E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Nov 2026 05:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.a=rsa-sha256 header.s=h01 header.b=L2V1k9QN
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jbMgp280Hz2xqh;
	Fri, 27 Nov 2026 16:40:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=180.181.231.80
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795758006;
	cv=none; b=Hi7WhA7ljiA8B1+Wn7BBlsfg8na6Va3k0X7eS5TulI5Xf3qErIBIRzEhn+K4zeZ9CrJ51BZF3q0v0MLD7TOgMN1bT3XSWQBaclrK/7lPPztH5AuMWYAOqaIuWNT7AO4x/Q+nGg/S30zBdEOdWlek39XQFYk+mt3KFfajVq4s2sEaOZUL3Vi+UG/0RmXdeyCb4CAQhQivBC35H9g7Duvl/JKc2LFQws/gR3XGxIHU65x0q3tMvePBQeXaO8idGrky4V86MmumOlMZmuSqxBEH3mvZoUKCX1QlPfwL6iVrfUIN2UqZUNWJDJa/Wk2SwrfxuH9lmlkwvMWuLupVz7ctjg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795758006; c=relaxed/relaxed;
	bh=rCTUltGYUfDut+dLHTTZSo7XsdacsDATELtjavFo3IY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QbJHvVjgCbkECF/jlXXPFpDgavC4rZ4j6YBcjTmUzEFKoe4XKQrcqAxS6B09dsg13O72P0HOrFcAGXcM4WTcmGcdMNQsKngfYaICEQ33M0qdHCBqHClIMxP0dOyiug72wjvym8i8RxMW9R0snZU3IPOZ9R9UK7IYUQJ4cqllRK7IXez00IXaRx/cL+rCwJjKloLnK3D40nHz7g85WoB0o2ItGmQAm52LEXSmiDUjJnvajMglFZl3GiGJhY1FIcv/N9xfe1hqiZ9l2vQN2T8lxcbqGPe7Evgxpn6wC++rWxRgcy4fbni9p9J7iVAUaLjpGUkLujZCVvk50v13GSNJyw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; dkim=pass (2048-bit key; unprotected) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.a=rsa-sha256 header.s=h01 header.b=L2V1k9QN; dkim-atps=neutral; spf=pass (client-ip=180.181.231.80; helo=abb.hmeau.com; envelope-from=herbert@gondor.apana.org.au; receiver=lists.ozlabs.org) smtp.mailfrom=gondor.apana.org.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.a=rsa-sha256 header.s=h01 header.b=L2V1k9QN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gondor.apana.org.au (client-ip=180.181.231.80; helo=abb.hmeau.com; envelope-from=herbert@gondor.apana.org.au; receiver=lists.ozlabs.org)
X-Greylist: delayed 1374 seconds by postgrey-1.37 at boromir; Fri, 27 Nov 2026 16:40:03 AEDT
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jbMgl2464z2xLs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2026 16:40:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=rCTUltGYUfDut+dLHTTZSo7XsdacsDATELtjavFo3IY=; 
	b=L2V1k9QNg4eYR47tRV9RnqQJhebMOUAchoZW2gCg5Qk/UbIAVtPiZbzZVynaN4p3zuDATHRd1Im
	45rml4kD5ANXn3tKFdxAJFIJGfgtiIQpz8lMq6oMOVQuL+g9zrNneK0auXhpKAwoNfIuB01MqYgNg
	z+BrEBcardV6HyFBml3maS6jvjAn6IsAXxw6fQ+GcJKOxkUMef5LUoB9ePrgijxorb9AI0vIY6Whc
	iDbyhMY7rARHTVMmuhSmgOU6T/A+nbKLGPkzHnsA+0fZSGFSv+nihSQhnTWO4b6yQ8QtQSmv0YMgE
	BQh4gZujTuDWlHSwalg7SJAxugBIOgYBBwaA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1xWoKS-00000002Vad-0cZS;
	Fri, 27 Nov 2026 13:17:01 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 27 Nov 2026 13:17:00 +0800
Date: Fri, 27 Nov 2026 13:17:00 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Danny Tsen <dtsen@linux.ibm.com>
Cc: linux-crypto@vger.kernel.org, stable@vger.kernel.org, leitao@debian.org,
	nayna@linux.ibm.com, appro@cryptogams.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	mpe@ellerman.id.au, ltcgcw@linux.vnet.ibm.com, dtsen@us.ibm.com
Subject: Re: [PATCH v2] crypto: powerpc/p10-aes-gcm - Fix IPsec stall on bond
 failover
Message-ID: <awkSTCnlXZ5gmsVs@gondor.apana.org.au>
References: <20261120181657.6396-1-dtsen@linux.ibm.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120181657.6396-1-dtsen@linux.ibm.com>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 20, 2026 at 01:16:57PM -0500, Danny Tsen wrote:
> The Power10 AES-GCM driver registers its gcm(aes) and
> rfc4106(gcm(aes)) algorithms through the crypto SIMD helper. When
> crypto_simd_usable() is false, for example in softirq context, the
> helper defers requests to cryptd and completes them asynchronously
> with -EINPROGRESS.
> 
> This breaks IPsec traffic during a bond failover. With the crypto
> offload device active, traffic is switched to a passive device that
> has only software encryption, and the ESP requests then go through
> aes_gcm_p10_crypto. Under heavy load, some or all of the TCP streams
> drop to zero throughput and do not recover. The stack is seen to drop
> the ACKs as invalid, which points to the cryptd queueing delaying or
> reordering the packets.
> 
> Fix this by registering the algorithms directly as aead_alg with
> CRYPTO_ALG_NEED_FALLBACK, and allocating a "gcm(aes)" or
> "rfc4106(gcm(aes))" fallback tfm in ->init(). When VSX cannot be used
> (!crypto_simd_usable()), the key was not set up for SIMD, or
> cryptlen < 64, the request is handed to the fallback and completed
> synchronously in the caller's context. The driver no longer defers
> work to cryptd.
> 
> Remove Kconfig option CRYPTO_SIMD and add CRYPTO_AES and CRYPTO_GCM.
> 
> Fixes: c954b252dee9 ("crypto: powerpc/p10-aes-gcm - Register modules as SIMD")
> 
> Signed-off-by: Danny Tsen <dtsen@linux.ibm.com>
> ---
> Tested with tcrypt.ko (including the self-tests) and with IPsec traffic
> across a bond failover. TCP throughput no longer drops to zero.
> 
>  arch/powerpc/crypto/Kconfig            |   3 +-
>  arch/powerpc/crypto/aes-gcm-p10-glue.c | 155 +++++++++++++++++++------
>  2 files changed, 119 insertions(+), 39 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

