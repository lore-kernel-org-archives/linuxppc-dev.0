Return-Path: <linuxppc-dev+bounces-21112-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C05ADCD4F52
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 11:58:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJxCn1kbpz2xpn;
	Mon, 18 May 2026 21:58:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779105525;
	cv=none; b=Pnyol519AmhURtkAx9N/E0jsu/tma2bJ3FZmpNUzFNqD+bqtlA918UFxIbWxydg8Bv1HeYLQLk2Lz9/NOuA5u0lVOUpMnSbAwDo3yLFmSha2QEsTqaY0slvB78HlvdoKBQvM0IHZhUB8e+74TG/zRAJLkhkyTrXmsSOya6G87kLLrguu/5beJ7zwaVsVhC+8ZLkuGJpSufmrN3hIRVuzEXIHtXiPlxsi4FJg74ukW2ARZ9MvgoxNRpU3/40aaiIj/Kp1kfjrpxFNserB4zlZMhIXbLwG3C/GCkb0hNxcz2asFZnHn8CaejRPeTyf3e6LSXdWx5fHfyCU+95dIjJQoA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779105525; c=relaxed/relaxed;
	bh=40onnUh26XzQs6PyRkXhU0UstAsHe5dywDdzeFwCfWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XeUjjb4eqnLVAjeMcQen67aLKESqPVBskao0kCd13yY96hbk45pPPPyEYzps7fyKbbU4r9DjPA2p+tLOCDZ6qy43DthPXJn/3Q+RYZbrjKUkijDGkl/5kyBLIzNBNKMrH6cGIf8TTs1dUi6vsF52YZCToZXDSEe6HTlx+c6Mny2gi+vxEOeb0K/Yp8H/I5WTzTVWzRj2NYYsUT0njqg6MYtWdmK1l4+/MvVYm+ifeX19ulIIYrD91ZPDDsY+i+if3bC5xNGiku1CCi+llvM3RzxXaYYnwaoBOGN/BTJ7pvxqGga13TX0faXrCaBvvsc8Lmw6ceobup0VUKR/pOOHVQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qm7A5aj6; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=mpe@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qm7A5aj6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=mpe@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJxCl53qfz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 21:58:43 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E0AC7445A6;
	Mon, 18 May 2026 11:58:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33FD2C2BCF7;
	Mon, 18 May 2026 11:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779105520;
	bh=K24SxM5Jk6poQKxfEN9YLBDqAliKjqeNVG9128MZS2Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qm7A5aj6/ykzEYe83pUe7lO4wvN6SdbDJQ/pWYMeYXI6qCNAXtHE00PNjaTaKTAp0
	 69cIf9hnUHt28wH4iDQdy2sxV5QhlzdIhMNKgw8hsHWDlyXfJArx7CL9V5lnrAfwPQ
	 yQXwybF8uRI8LKXYtWSsX2rd0MD05Y+gohs27jBtoXOKwowezrACyFChvbuQno+I96
	 DYT4S93LKr6TMyZ+rS8QjH4GTJl+TCpoceEcMVld28RkZJj692hST/2ceRi5J+NSBb
	 JJAL+9P3a3Rq2rY73aW4Sktdy7bEV+YIC0axUy1qHb/3Xqzo9SDoDZou9ce/71vFKh
	 At/zkJ8ZP03rA==
Message-ID: <fc776993-1ad7-49fd-834e-c1945da28ad9@kernel.org>
Date: Mon, 18 May 2026 21:58:36 +1000
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
Subject: Re: [PATCH v2 0/2] LKDTM powerpc enhancements - Part2
To: Sayali Patil <sayalip@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 maddy@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
 Mahesh Salgaonkar <mahesh@linux.ibm.com>, kees@kernel.org
References: <cover.1778975974.git.sayalip@linux.ibm.com>
Content-Language: en-US
From: Michael Ellerman <mpe@kernel.org>
In-Reply-To: <cover.1778975974.git.sayalip@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/5/2026 16:56, Sayali Patil wrote:
> Hi all,
> 
> This series adds a new LKDTM trigger PPC_RADIX_TLBIEL, to validate
> machine check handling on radix MMU systems and improves reliability of
> the PPC_SLB_MULTIHIT test by adding isync instructions after slbmte
> operations.
> 
> Please review the patches and provide any feedback or suggestions
> for improvement.
> 
> Thanks,
> Sayali
> 
> ---
> 
> v1->v2
>   - Split the patch series into two parts.
>   - Updated "lkdtm/powerpc: add PPC_RADIX_TLBIEL test for radix MCE
>     validation" as per review comments:
>     Wrapped Hash-MMU specific functions with #ifdef CONFIG_PPC_64S_HASH_MMU.
>     Guarded powerpc_crashtypes registration with #ifdef CONFIG_PPC_BOOK3S_64
>     Updated comment explaining the MCE trigger condition for radix MMU.
> 
> v1: https://lore.kernel.org/all/cover.1778057685.git.sayalip@linux.ibm.com/
> ---
> 
> Sayali Patil (2):
>    lkdtm/powerpc: add isync after slbmte to enforce SLB update ordering
>    lkdtm/powerpc: add PPC_RADIX_TLBIEL test for radix MCE validation
> 
>   drivers/misc/lkdtm/Makefile             |  2 +-
>   drivers/misc/lkdtm/core.c               |  2 +-
>   drivers/misc/lkdtm/powerpc.c            | 49 +++++++++++++++++++++++++
>   tools/testing/selftests/lkdtm/tests.txt |  1 +
>   4 files changed, 52 insertions(+), 2 deletions(-)

Both changes look good to me.

You should send them to Kees, who maintains lkdtm. I've added him to Cc, 
but that may not be sufficient to get his attention.

Reviewed-by: Michael Ellerman <mpe@kernel.org>

cheers

