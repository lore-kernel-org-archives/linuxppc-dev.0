Return-Path: <linuxppc-dev+bounces-18328-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23AADFED9E8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Mar 2026 16:29:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZy8p5jjQz2yhV;
	Wed, 18 Mar 2026 03:29:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773764970;
	cv=none; b=QPD7dyODcNxy1ePnYR+81R3h3phZoB6S9J71tcn+UowFKq5mm8JFj+I5YMnzexxQs4yFBU/paZHGvgn17bKG6QmWt4e4BSGvSSU50cafumGrFIuf+Mvr+xUu/h35D7e50ys/m+7X3BaPD7fTcwBARrwxDandJPteXvY492ByV0NzU1iuxUxO13elXaFziWxqk7qJT6Zv0W7n6f9LEXqd79qYFjZlKpbq/nbiJf2xvxuBba54DDoAUSsZ3SwNal4QacA3cAFbKs8TyG2GgYnNN6LPle3vcwXZe2QKjsu3Ffbk2Yfi4WLQb6zeq2b1G95kMp7rRgoZErALv4awgzqeXg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773764970; c=relaxed/relaxed;
	bh=iEeWKAN2wB1UCKurm6jeTavrQobP4p4Vb8w8sAkmqZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DcryVbTAt3aSLIV2jgpGerSb24f4ecgaD8V8QPxya2+WkT5zq2awY6KLdVoM/YYtLZhs2h6AHHwrzG5NYfhUew386sTfla9WgilXvrgp8RTRPnZ+CC69KW0yruArv1a69e8ckq/Ol2qiPb3o7kHydHAvMLiRhRqyH9/i3+QjzKzevbNNsVinde75BaLWYAxUm1BqplgUaHcjKO7lW3mZkuchKeHrXC3XFTSKK6GAJu5Gf51mbpqIQ3vF2ZfUzvMltextpPdreFjcfVAiSBLosVLmH/uIBKzOXiyf90IFIz5AW/N93IFFrzfUb5PtX5/A9q+o+SJFbli5WfcvwD8w9Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=abFBVl0p; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=abFBVl0p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZy8n5MKfz2yFd
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2026 03:29:29 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 989584433E;
	Tue, 17 Mar 2026 16:29:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46312C4CEF7;
	Tue, 17 Mar 2026 16:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773764966;
	bh=IhHFU2XjpSVShyKbiRl4NfYWjArEyXN0qLILNP0KZHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=abFBVl0ptWtdbUyTpoO0VxFTxIRzTg5qX/2ODVHJIiXWyjLWfD0SlJ3EgXKhypcNo
	 g4ZiN3Ljw7n4OKh5HPrL1xcm42Y2PCsGXTbGTeY1mQCa3pz4Xf7Z7HD6IWETYvILjc
	 YnZ+PVKdim8atbyiulwIrIDfG5tHiOtzgSBmFW4P9XIlCq0RD1w5+0TVuPoaWJSYv1
	 UrO4DA7YmiWt/prOAzwU61NWL1fYiwji9m04S3SdgcRqk1mfRWvavCTaS6JTsy39ZZ
	 0cIdK12Jv+QYpCl4EGrUWBz/Z1zgAvUcPd+5roM248kGV+vyqFa2o02iejQ1NvEUt7
	 op0M8RZWpSAcA==
Date: Tue, 17 Mar 2026 09:28:26 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] lib/crypto: powerpc: Add powerpc/aesp8-ppc.S to
 clean-files
Message-ID: <20260317162826.GA2931@sol>
References: <20260317044925.104184-1-ebiggers@kernel.org>
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
In-Reply-To: <20260317044925.104184-1-ebiggers@kernel.org>

On Mon, Mar 16, 2026 at 09:49:25PM -0700, Eric Biggers wrote:
> Make the generated file powerpc/aesp8-ppc.S be removed by 'make clean'.
> 
> Fixes: 7cf2082e74ce ("lib/crypto: powerpc/aes: Migrate POWER8 optimized code into library")
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>  lib/crypto/Makefile | 3 +++
>  1 file changed, 3 insertions(+)

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/log/?h=libcrypto-fixes

- Eric

