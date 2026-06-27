Return-Path: <linuxppc-dev+bounces-23038-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FBCEC43458
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Jun 2026 02:22:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gnGXs6dBXz2xWP;
	Sat, 27 Jun 2026 12:22:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.137.202.136
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782526973;
	cv=none; b=CIUySBHJyQL/8U4uH4MjtrrpoeyS61W87rpsm9RF3vU6QprCC7KB19QWjEH0pSYpii2pbGvcZhkiKlabv9pkbhv1uo2mnne7xmzFL1OFc2+o2oL4CNPilbiykkEd0GEaj1Q+8f+OIAp9YXNNoL4J+40rfkiAM/HcEXs2HYzyFBp1fPl1cnd09TP5peXOJ+We94aoQyDzcsLhD5FYRE9nbR3GZLXsSbXakRndRByB71dGsArXtNQirHnfjEY6ZXI3r2WVAiUcLuTH4VPbfimir+OpE3OL/l/p0LOdEK6DODMstoLsqTceAKEBb9zP0bZWJgREauQENiVNzFEktAokWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782526973; c=relaxed/relaxed;
	bh=CoKSivJMaQDV2sSkRTRw7olGkcZfQ72Xwmih/Aa0td0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i6xZzfxPRReZiDEEnXN4QKHwjsqmI1aG5JM6ytKGO7UphoYGZWej3gfmkvvrUCrXnusBRpveXwNYcgJEIlMyGyQoq4uL2FHidYhP34D9oSmk15T65hZJQX7coTxibCHZnn4pHOd3M4z0twqSAm5v4BVsm/yH7j12aN0TvTgSYNvHhEgOGIwYMDra7OrsWvNF20+XigAhQfMwpY/6WxJECKW4/3n9QOCTsQetPQhlcwfLBLRWo+iF2/t1RdsRtVYC7UjgokZ2YdLrviijeIn2qcejXqEwEKjReZrHgoQXHjjxHwgxk4EMVuCTfmuR3urGXQOtYm50j7QXZhegRjGWmA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zytor.com; dkim=pass (2048-bit key; unprotected) header.d=zytor.com header.i=@zytor.com header.a=rsa-sha256 header.s=2026052701 header.b=qMyBFc1g; dkim-atps=neutral; spf=pass (client-ip=198.137.202.136; helo=terminus.zytor.com; envelope-from=hpa@zytor.com; receiver=lists.ozlabs.org) smtp.mailfrom=zytor.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=zytor.com header.i=@zytor.com header.a=rsa-sha256 header.s=2026052701 header.b=qMyBFc1g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=zytor.com (client-ip=198.137.202.136; helo=terminus.zytor.com; envelope-from=hpa@zytor.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 839 seconds by postgrey-1.37 at boromir; Sat, 27 Jun 2026 12:22:52 AEST
Received: from terminus.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gnGXr4ryDz2xVK
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jun 2026 12:22:52 +1000 (AEST)
Received: from [IPV6:2601:646:8081:7da1:dcd4:e1f8:5d79:bdb4] ([IPv6:2601:646:8081:7da1:dcd4:e1f8:5d79:bdb4])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 65R0qN0N2285168
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 26 Jun 2026 17:52:24 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 65R0qN0N2285168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026052701; t=1782521550;
	bh=CoKSivJMaQDV2sSkRTRw7olGkcZfQ72Xwmih/Aa0td0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qMyBFc1gnGXRksBwsJ1/rUznZgiE7lPuLPv/lWpmOM+5Q3Fqu1GkBtPV/i01hTsmm
	 FyrrwODPBIMXlAoyCpEVfCiClmUhwPWsNagz78j3LDMf+Ut0XXJAAidVe9l1aTOAut
	 7WQuEQASgzET2NWeiLHKYC5brvZfsPACaGhvlYNW5X1iG8c+02aTJiS4yaJSFbtRty
	 RzVpKhz70FSqCBKm8TK2gLW8sDPukFdgs1lqJ60AGqtpglwDIA/PnerR6f0L+dvu0f
	 tzL0aZnBm0Ed9q+Fj1E4zhVGr5LPAVMhZk4GFV4YP0Rst/9nwzTfe9CuWNPpW58FjU
	 Q8Foj51/YA5sw==
Message-ID: <7d8efc7c-65e3-49f8-9381-910de7affef2@zytor.com>
Date: Fri, 26 Jun 2026 17:52:18 -0700
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
Subject: Re: cleanup the RAID6 P/Q library v3
To: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Dan Williams <dan.j.williams@intel.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Song Liu <song@kernel.org>,
        Yu Kuai <yukuai@alb-78bjiv52429oh8qptp.cn-shenzhen.alb.aliyuncs.com>,
        Li Nan <linan122@huawei.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-raid@vger.kernel.org
References: <20260518051804.462141-1-hch@lst.de>
 <20260518141205.c100f76eec5f58e78bbbf7af@linux-foundation.org>
 <20260519082432.GA14956@lst.de>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20260519082432.GA14956@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-05-19 01:24, Christoph Hellwig wrote:
> 
> raid6: rework registration of optimized algorithms
> 
>  - avx2 instead of avx512 is probably the right thing for no
>    benchmarking, but if it was intentional (it wasn't), that should
>    be document.  So I'll just switch back to the previous version to
>    keep the state of the art

It is unlikely to be the right thing *going forward*, though.

The very unfortunate performance inversion is likely model-specific. It is one
of those things where you largely would have to have a list of quirks :(

	-hpa


