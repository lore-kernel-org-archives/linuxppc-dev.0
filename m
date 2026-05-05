Return-Path: <linuxppc-dev+bounces-20483-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD079FF8855
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2026 16:34:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g93xf1s26z30DR;
	Wed, 06 May 2026 02:34:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777998854;
	cv=none; b=BjHEkZykdZzfXbBR/pYbC2dQ+JOpSNRZMxs9B76/OuJ6OEKYtjAHUr46inCexE/2bbPa2reabu/7+IsEdIc2jGF5ow00X4+n9mIPo7fwrkGOCWS5Jh0no/y2+NbjLxxrOs9KyqEaH9UGD0Bmv7ludoRYF1kxuvFt2nWKca8h289H5KzadegWNbvN5O8Q1N6jTIfGY1SktgOD9QoDjH5G0XxvtU81JxBFa4JrBUqKC30oDkt///B+htrIM2V8KFUDgTw5NAtPguVhebE7eyIhmJkcSvOh9ACAHpU8BgkLy2DfAr6HJgFfJWq8SqA9Z3HhrXVVzn2I3IvkT/Ufmhje6w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777998854; c=relaxed/relaxed;
	bh=ZZnWOGfkHpJ4gSLwOU65/vbywBHazKwyVwSBc58KETI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F/04BjZG4dwfPRluhhqP71DqgK0Cj39GDD+yB2gqOEby4BPPilIhx8CRIaZiYfposGr+fSsHDq/brRmWNyI81pEZDa/7sKvF0gAKJwSaNDVpdqoefyXNHWBUkELKCay3uHNFVlTThagxkZFsLklifjxW8uKTr67wcYdVrCO8yVtw49rgUExVP38ECx4VCEk0Rvpez0yQDvo4vrrnSpxCxTlNrLgwNIhatgxZyXCR4ftaxK5G8sSMSevD5dR7tacTWN4lp4KBkOzf4uF/uMUHV8HA3d+GeaeouWxY0/KihxQH3BBMFCVqykiyudpyjXysOjqCcZmpEgvX6zh4+O6Mpg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aGqHCpme; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aGqHCpme;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g93xd1XGNz2xfB
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 May 2026 02:34:13 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 81AA1441AA;
	Tue,  5 May 2026 16:34:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E6EC2BCC7;
	Tue,  5 May 2026 16:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777998851;
	bh=cVcfbLM3oOOyr4PSilEGrrxmebjeKHe6vnGyG+zyCQM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aGqHCpmenkupNMpAB65SsLcKFlhftkIXCwWsFuzzDqD4zTibLd05hRq1MVZox0ocM
	 GkQg2p/bqZrn4jy/LrVSfM0akpHTEwlT5hCv/maC4mRu7jrKRlHYX+IKxfVfKjERTx
	 QLboXgb/baZ7yjJN9Qfh72uRDRGaQ7/HjbMy3gj5N1XcBZmYye6jZ26HCtwgLVrlw7
	 cOLXLqksxDy63Sb+um8KusGV3gSzZI0PjdBopMOlr0Cuy3ifiAOiHEXtRbzThVYRrG
	 GMKwrvzQent7tw1q85yWUL0558FlpQNqmc+TeXmtAezDK+0EnxMNVFX/C/vZMFHoiv
	 jupzwXuY9XrHQ==
Message-ID: <56abbf15-2a2a-4f65-81ae-fcfb5e1d9601@kernel.org>
Date: Tue, 5 May 2026 18:34:08 +0200
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
Subject: Re: [PATCH] lib/crypto: powerpc/md5: Drop powerpc optimized MD5 code
To: Ard Biesheuvel <ardb@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
 linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, linuxppc-dev@lists.ozlabs.org,
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Madhavan Srinivasan <maddy@linux.ibm.com>
References: <20260504041448.15820-1-ebiggers@kernel.org>
 <111ea924-fef5-441e-9849-83f938c913a7@kernel.org>
 <112bf0af-1551-4d3e-ab15-e5dea3fc2435@app.fastmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <112bf0af-1551-4d3e-ab15-e5dea3fc2435@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 04/05/2026 à 15:56, Ard Biesheuvel a écrit :
> Hello Christophe,
> 
> On Mon, 4 May 2026, at 15:28, Christophe Leroy (CS GROUP) wrote:
> ...
>> I'm really concerned with the optimised MD5 going away now, and I'm also
>> wondering what will be the way to splice a file into the kernel and get
>> it's MD-5 hash from the TALITOS if AF_ALG goes away in medium-term.
>>
>> What is the way forward ? I'm open to any suggestion as I really can't
>> see where to go for now.
>>
> 
> AF_ALG was created to give user space access to crypto accelerators that
> require privileged execution, for sharing between clients, and for managing
> DMA etc.
> 
> The fact that kernel crypto code that does not have this requirement was
> exposed via AF_ALG too is a historical accident, and this is causing the
> pain that Eric describes wrt attack surface etc.
> 
> It sounds like you have constructed a vertically integrated system where
> the kernel provides the fallback when the Talitos engine is not available
> via AF_ALG.
> 
> This fallback does not need to live in the kernel, and it would be much
> better (as well as more efficient) if user space would implemented MD5
> itself if the Talitos cannot be accessed via AF_ALG. In user space, you
> can use any implementation you like, generic or asm accelerated. This is
> what all other architectures already implement, in OpenSSL etc.
> 
> Claiming that your user space software must only implement one code path,
> and that punting this to the kernel is therefore required is not a
> technical argument: this is just policy on your part that the community
> is not bound to.
> 
> However, deprecating AF_ALG does not mean that we will ever be able to
> remove it entirely. Especially the crypto accelerators that cannot be
> accessed by user space in any other way will remain supported as long
> as needed for legacy use cases.
> 
> But I think we should consider libkcapi as a general purpose crypto
> library deprecated too, as well as any other use of AF_ALG in lieu of
> user space libraries. It is not the kernel's job to execute user space
> code that can easily execute non-privileged as well.
> 
> I suppose there will be more discussion soon about AF_ALG deprecation
> for software crypto. It is likely that we will need to come up with
> an allowlist of algorithms, in order to limit the attack surface to those
> algorithms (such as your MD5) that are known to be relied upon by user space,
> rather than any random combination of all the buggy template code and
> null_ciphers etc.
> 
> Do you have any use cases where MD5 is a bottle neck, and the generic
> implementation is too slow?

Well, our boards are used in air trafic control voice communication 
systems, every millisecond is worth it and every performance degradation 
must be explained, justified, etc ....

Christophe

