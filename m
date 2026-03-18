Return-Path: <linuxppc-dev+bounces-18392-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADCF010775E1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Mar 2026 16:22:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbYyH1vdjz2ykX;
	Thu, 19 Mar 2026 03:22:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773850951;
	cv=none; b=La/Vxf4w0BKZcP9ttoXYDw9QovKRZVOD9sKQMVpIbwQzm78c1Mfhb8q9yVKg/uyVtsbz49jD71Fh/XscMhhzJovJP1fxF4rb2AnkrnzNwZWNGSQcOrGTiXXXMKHteTJdMYpA/T/hMRj0pOrGqHxUML54Ggq9tDFQERJg8NCAVVSlmI1gElqLDNbFxd1GjFEl2klmx4e9v46Hrb0OjEhkyj8Wo/WPvbd0G52xPKvoTqqbdjCukNs34yG4NctRbVTvAEhlrbVXaaFD/NK7JDG8nUpGtg1owS0MMvUD5NOvUu+hny10dkarH1CVNbRdCcqN0B5d1Cv1qEw4WEi+FYBGLA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773850951; c=relaxed/relaxed;
	bh=qpUij/boElpxZS1JyC/IIVmLkerZuIkDbeCw+AaRVqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=macd875+AQQ91ve2BsRJ3hkkn9m8PurN/wbxk1qi4WfwVXOOAF9lHmXKoYnYq/pEcjd0lQDqmV97Nz+jmSy0V2sl/Mqu3rkpLaaRL0Lw7xac4CC7PgBrB6vEuj5mkZkLMJ8lWiQs0rgH1F5EdFzzwjSd5LFF/HYjd9+xNg1PZHr98M/BCa/gJWicWHkzrxV6Df6TBsfJeW+/4eisrVn9aM0ita+qGGHsEtxsY1CHf07D4K+UJI9vtzioulu7mTWYsvHJT6LdPhfcOhG/22cFnartqA62M2EOVdg98Pd7nCR+GSoTmh3vcz4qxHBDwkxehcmq7s14A1bj9IIghM5VPQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XpeluXyx; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XpeluXyx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbYyG1lQzz2yjp
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2026 03:22:30 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8A99260097;
	Wed, 18 Mar 2026 16:22:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC48C19421;
	Wed, 18 Mar 2026 16:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773850947;
	bh=FGNSu4DlIfiUMZa5ZkmaJp/QIn2lggE4u2Ndygv6FBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XpeluXyxDsZzF3NAmckdqJwpVkaAqttUopjBMOigcEjrW9PG4hOk9bFNjIu2+1hu1
	 IcsDTmGhCVATBRixcmNQQhBpayz2AxBxUoh+MbYsjRcLuorNTLiwBf6/k0JgHJn6Wz
	 raA3nLiznqIL8OBq0mPUTLKCPd5eb3Bv2V64KLPcxM+MrRFRw5yx4UwmNfiJttbMZO
	 J7HUEZM+SLsx9D5/aRBj0upZmqFXxEgFHzFGt2zHtfm6J4HCe4vfApVE0dgUg61GmQ
	 0lp53wfP1tgknNDPDCf1MumSabgXnKYpdnqZftaDNWH4frl/QojAulg09IVXxCoww0
	 l5WkFd3jbD+kg==
Date: Wed, 18 Mar 2026 09:22:26 -0700
From: Kees Cook <kees@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, loongarch@lists.linux.dev,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-mips@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-alpha@vger.kernel.org
Subject: Re: [PATCH 00/15] exec: Remove AT_VECTOR_SIZE_ARCH from UAPI
Message-ID: <202603180921.1B52D626@keescook>
References: <20260302-at-vector-size-arch-v1-0-a11f03ba2ca8@linutronix.de>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260302-at-vector-size-arch-v1-0-a11f03ba2ca8@linutronix.de>

On Mon, Mar 02, 2026 at 01:25:24PM +0100, Thomas Weiﬂschuh wrote:
> There is nothing userspace can do with this value. In the kernel is
> always combined with AT_VECTOR_SIZE_BASE, which is not exposed to
> userspace and also changes from time to time.
> 
> Move the symbol to kernel-internal headers.
> 
> Meant to be applied through the asm-generic tree.
> The default recipient list was huge. I trimmed it to only the
> architecture lists.

I don't see anything in Debian Code Search that actually uses this
symbol, so that seems fine. Userspace already parses auxvec looking for
AT_NULL, so length isn't useful.

Reviewed-by: Kees Cook <kees@kernel.org>

> 
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> ---
> Thomas Weiﬂschuh (15):
>       MAINTAINERS: exec: Add more auxvec.h variants
>       auxvec.h: Move AT_VECTOR_SIZE definitions to linux/auxvec.h
>       asm-generic: add an in-kernel auxvec.h header
>       ARM: drop custom asm/auxvec.h
>       x86: Remove AT_VECTOR_SIZE_ARCH from UAPI
>       arm64: Remove AT_VECTOR_SIZE_ARCH from UAPI
>       RISC-V: Remove AT_VECTOR_SIZE_ARCH from UAPI
>       LoongArch: Remove AT_VECTOR_SIZE_ARCH from UAPI
>       s390: Remove AT_VECTOR_SIZE_ARCH from UAPI
>       powerpc: Remove AT_VECTOR_SIZE_ARCH from UAPI
>       MIPS: Remove AT_VECTOR_SIZE_ARCH from UAPI
>       sparc: Remove AT_VECTOR_SIZE_ARCH from UAPI
>       sh: Remove AT_VECTOR_SIZE_ARCH from UAPI
>       alpha: remove AT_VECTOR_SIZE_ARCH from UAPI
>       auxvec.h: Drop fallback AT_VECTOR_SIZE_ARCH
> 
>  MAINTAINERS                              |  5 +++++
>  arch/alpha/include/asm/auxvec.h          |  7 +++++++
>  arch/alpha/include/uapi/asm/auxvec.h     |  8 +++-----
>  arch/arm/include/asm/auxvec.h            |  1 -
>  arch/arm64/include/asm/auxvec.h          |  7 +++++++
>  arch/arm64/include/uapi/asm/auxvec.h     |  6 ++----
>  arch/loongarch/include/asm/auxvec.h      | 14 ++++++++++++++
>  arch/loongarch/include/uapi/asm/auxvec.h |  8 +++-----
>  arch/mips/include/asm/auxvec.h           | 17 +++++++++++++++++
>  arch/mips/include/uapi/asm/auxvec.h      |  8 +++-----
>  arch/powerpc/include/asm/auxvec.h        |  7 +++++++
>  arch/powerpc/include/uapi/asm/auxvec.h   |  6 ++----
>  arch/riscv/include/asm/auxvec.h          | 13 +++++++++++++
>  arch/riscv/include/uapi/asm/auxvec.h     |  2 --
>  arch/s390/include/asm/auxvec.h           |  7 +++++++
>  arch/s390/include/uapi/asm/auxvec.h      |  6 ++----
>  arch/sh/include/asm/auxvec.h             |  7 +++++++
>  arch/sh/include/uapi/asm/auxvec.h        |  8 +++-----
>  arch/sparc/include/asm/auxvec.h          |  6 ++++++
>  arch/sparc/include/uapi/asm/auxvec.h     |  8 +++-----
>  arch/x86/include/asm/auxvec.h            | 12 ++++++++++++
>  arch/x86/include/uapi/asm/auxvec.h       | 13 +++----------
>  include/asm-generic/Kbuild               |  1 +
>  include/asm-generic/auxvec.h             |  7 +++++++
>  include/linux/auxvec.h                   |  5 +++++
>  include/linux/mm_types.h                 |  6 ------
>  26 files changed, 139 insertions(+), 56 deletions(-)
> ---
> base-commit: f6b3b0a4c85882ad75bce3b093173203e3f39f28
> change-id: 20260109-at-vector-size-arch-6e0f2e9ff8b6
> 
> Best regards,
> -- 
> Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> 

-- 
Kees Cook

