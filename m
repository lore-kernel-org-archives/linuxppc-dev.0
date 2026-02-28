Return-Path: <linuxppc-dev+bounces-17442-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E26FEE4CA
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Feb 2026 06:55:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fNGDk35hDz30hg;
	Sat, 28 Feb 2026 17:55:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772261750;
	cv=none; b=EcNyNzB3iigoMoh6TxaELLV/605JY2+3kepZjVv/lukpAiR+iCVRUlBVB2F1NHfWqqZ1IJhpHgWn3esTfZvblAEvL8A/ly0+p8ejmISz7th3xZw2ZkPAUP8NO4+9gC3VL0MC1T9aox2uKtRAQgneFBX2TbOwMavoIAsdaByaXt9XiD8+NFihSwm8snKxy1i/t2qc5Lj0QbQQvepFZ7SakR7BDAsdlD/ywJESoH/XayACKlobpp8nD0j3sZMfE90TmOnzUAszQt3WGxvzNkqNDL9ra/shThQ2t2/5wOoCLF5Vi0Rxf3AUnHpQDfTu1U5crw2cVUFeJEatp/YEV1BmnA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772261750; c=relaxed/relaxed;
	bh=wQMyDOvMSNktzNNveysU2n4Fnu4+Lg8kOQ3nNBMOreA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Regd/40Sg/5BP++mOmjVfMyFzFz77Q/h4dUpqerlst5Jdlv7J6ioisOrwaIl7Jr4nVEfI4CjZtybfj6pp7k4SQLjr3bCR7WGqGIvnkV0/QYXtbvbQvVG3lZb40Vkr9tyjB+Jg/dlHn5CAyHnzz5c+u4f4EtlFevbxi8ouqMbjeehdc9jtvShLP66ndP63V9VzSnhVKaDjq+I+/drFKysmNS7PAvNYUfDtq0cO7o0KkBH2obvY4HTuOmPKtSzrmXzXn8dzKdwqQ3oPdRNie29/IDmxVuXq5AA5e5hD07xUhuhN9WyqumE+8L5erMA2gWM3WEsztGeCI5qUaSknmi+EA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=psiiY+mj; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=psiiY+mj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fNGDj5Zvqz30BR
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Feb 2026 17:55:49 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9C63540830;
	Sat, 28 Feb 2026 06:55:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A1AC116D0;
	Sat, 28 Feb 2026 06:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772261747;
	bh=b4wWycMp/qA51ETIBAMbd3c8O+W0qcQO/Vfxz7HjaAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=psiiY+mjJy9NDUUzgU6LpECxATrYP6E6WdOer+42b5zCn8ow/eyJXB/ug0mExA9cv
	 6ePYSGlmoaHtHOi7qoSg0Q3QsHkOGGPNWPHKY6G4BOjm8G543wF1gbRSWkuG2NNNoX
	 iKjLmRNvDQFISHuKPxgVP1X34FieZC9G4odogCmXjbvadUHK8R5eStFkTiEhfNFMtU
	 4FNEJ616kUSHbRZxM+m3jm1NVk176WszihcTfvBODu+/0eL6+UG2HnIgUPOZLNLSj1
	 WxX5AcZXlMJ9kqMb4ogEhdlpTjXL93m1Gw4Fm2Ba2sZDjbueHKzehZlPdBX5J/XiRb
	 igjWvy5k/xF5A==
Date: Fri, 27 Feb 2026 22:55:43 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Dan Williams <dan.j.williams@intel.com>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, Arnd Bergmann <arnd@arndb.de>,
	Song Liu <song@kernel.org>, Yu Kuai <yukuai@fnnas.com>,
	Li Nan <linan122@huawei.com>, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: [PATCH 22/25] async_xor: use xor_gen
Message-ID: <20260228065543.GI65277@quark>
References: <20260226151106.144735-1-hch@lst.de>
 <20260226151106.144735-23-hch@lst.de>
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
In-Reply-To: <20260226151106.144735-23-hch@lst.de>

On Thu, Feb 26, 2026 at 07:10:34AM -0800, Christoph Hellwig wrote:
> Replace use of the loop around xor_blocks with the easier to use xor_gen
> API.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  crypto/async_tx/async_xor.c | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)

There are still comments in this file that refer to xor_blocks.

- Eric

