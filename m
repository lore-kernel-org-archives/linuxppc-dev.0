Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD001606A6F3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2026 20:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=kOcxHrVk
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jWRQQ0J2lz2xpt;
	Sat, 21 Nov 2026 07:14:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41b8:202:deb::311:108"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795205693;
	cv=none; b=CFAN4bPkXQxMQGl58S+nwDuT4XNuA/39rxXdRAnMGRS4DqIlLUrPMM9GvFyg6V1uCJTwtmp4w8kuS9aS69NdCj3kisht/9Z4/s6b7IyXVPowvEbdV3siMUWriI8KL3wW6Oo7K8S21nw76//UqaAiupAreOKYhzuLIQeIYaMNqbDt+dxj6Jof+/QkEKLHQ4NgNuAZcIufiQmNm0/2tNqSjdQz5mz4AQCsZCGHOYtj2/oEhMxchP1g2ZeAXvPegkVpcPR3TpoxwACDUaWJpn9eGNz8S0G8XBXjN09qYqjnd/1HLnCDEtC64W1VqkLZxE3KwrjFPnEsOQ+xQG5hR0+fEw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795205693; c=relaxed/relaxed;
	bh=FFTP1NPza1DvwgzCri+N43IcvcyxR0U6bBZgpwRHscQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/06PSjsnU8RXB+QIwrQxAL1B/+wv1IXVFrzhT+/J/gdsyhS8hE7eM/p+Zrxl6GK4F8jMcnGxzvBqEdJFM951s5KlhhScXbMy6TbGP1lQGjtQq9hgowrCAk84kgf1HWIy3Y46+sYOSkmnHpQ3YunhLo8PnRpTniHHBxyBEeCVCV+8IiT5BRp6K0ac1GwYX2wTS6u6Z30m+rMIovbIOAPajPElWIV92IeHbH1j4ezkY0552NSj2DmWu6zrfMZLqjERCmb8ccXnMMaALS0y3Kss7YL8TSg70/wcS3nvjzNL2tDj8CfdwJd5Vzo58iBQ6H2YIgPRQoH/ptCfKDUiKp9pw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=debian.org; dkim=pass (2048-bit key; secure) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=kOcxHrVk; dkim-atps=neutral; spf=pass (client-ip=2001:41b8:202:deb::311:108; helo=stravinsky.debian.org; envelope-from=leitao@debian.org; receiver=lists.ozlabs.org) smtp.mailfrom=debian.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=kOcxHrVk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=debian.org (client-ip=2001:41b8:202:deb::311:108; helo=stravinsky.debian.org; envelope-from=leitao@debian.org; receiver=lists.ozlabs.org)
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jWRQN5q2Mz2xly
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Nov 2026 07:14:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FFTP1NPza1DvwgzCri+N43IcvcyxR0U6bBZgpwRHscQ=; b=kOcxHrVkAyIvrsNI5n9oXxz2Cd
	zSYQ4zJyHNy9cHPfsv8prE2GWzy7pHB1MWM7Dj3TWGiCaruL8l65x0Sm5WFdyFaKLGLAITTLlWQ7m
	rxdUlf8+KA1YJewSlLAbJruWpBcyvE7EfLgg2pzT3Km2AW0r8QF+/MRmMD1Ev0CPNzb4q5GJrjYH7
	OgqwmsrEuxm5iLJ8NKVcuWbVYWz6ijqfbX0c9UZWFUaV2Hf0R/k537BzeIuPLyh7CyTM3hfaT1W20
	iNoObdEBvfnwMcdKMCyDI1KV6UKItF9Ibv9+NKRYzMBPN9rZj4nxTp5mbzBxjSTq+2pve3SNhC4Aj
	jjRH1Nww==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xUV0E-0037jW-20;
	Fri, 20 Nov 2026 20:14:34 +0000
Date: Fri, 20 Nov 2026 12:14:29 -0800
From: Breno Leitao <leitao@debian.org>
To: Danny Tsen <dtsen@linux.ibm.com>
Cc: linux-crypto@vger.kernel.org, stable@vger.kernel.org, 
	herbert@gondor.apana.org.au, nayna@linux.ibm.com, appro@cryptogams.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, 
	ltcgcw@linux.vnet.ibm.com, dtsen@us.ibm.com
Subject: Re: [PATCH v2] crypto: powerpc/p10-aes-gcm - Fix IPsec stall on bond
 failover
Message-ID: <awCpkj5wsxEPt-Vd@gmail.com>
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
X-Debian-User: leitao
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
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

Reviewed-by: Breno Leitao <leitao@debian.org>

> - * Copyright 2022- IBM Inc. All rights reserved
> + * Copyright IBM Corp. 2022, 2023, 2024, 2025, 2026

Do we really want to change this in this "fix" commit?

