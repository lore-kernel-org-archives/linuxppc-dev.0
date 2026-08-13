Return-Path: <linuxppc-dev+bounces-25811-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32363C5CFDB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Aug 2026 08:20:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLJFv2wz5z2yVd;
	Thu, 13 Aug 2026 18:20:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786609235;
	cv=none; b=IUHkiJUzGygOwOgqXn4/C1iikIhkj3oLw8tka7pocWUyeJuXo2Bt8pFMBpi+03xqulaYVycIwQ1MVHc5nUpLk8XK3hbzSDsTeqyaSLG0clmkUhJzJAIGDNykQOVmjFMmRnsmzLtorjC+0wb1ZGOYHPmF5NLWaM7mQIxBwWpnYIeIecFww+wtFkqmH9jvz4XLZjlzx6pnyS39BFKgtcU5dWV0iJrB9LxIhXeC48XYGNl/gf6uJiqL1Ole9h9QYN/jj5GK0SC7jns/5YGG1Dj4RrENOfNppPsa5ExwTmaLsvjkfxENR/Y+oHBYtIjybEOGM1Qxjg5EPQZkoRw+3eGQxg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786609235; c=relaxed/relaxed;
	bh=BpLKv+HLKMXgHbkxllR3SmVTl3IvJW2Gw7BMJgcyPFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DcG1fT8Xa7chwqr8Nl0u3OP/KItFImFxVZ9ImIJNJ9zUBQ5/nNvZUKwPwdkrV3eFWBatQ7CmqdqArwZqMUVd1FWrOuP6hYLw4stur/Jcw8jKBy7YKR8qUOpPTVZ4A7AXG+c18Uuq5yFgBV/L2+f4Mf+K1DT5FSD4wRQDpkdDRh26hJDpP4ojdF3xxpcr3y38JQP+UEBg7rDSekq3N+RX+Wi9WkuIKK9YHh/ptsHndPj/xKhMOji5v7fq5Oo9nI4PpAC3uX3VOzcD+aM+A1V1daVgs07VOdXqabNBdmMY+YCTjzwbp5u0C5wWqk/B6njkL5jPyYaDq/p9hT94PepBGQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sr0GrUAE; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sr0GrUAE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLJFp2yTsz2ySS
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2026 18:20:30 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B5BC1416ED;
	Thu, 13 Aug 2026 08:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 298EC1F000E9;
	Thu, 13 Aug 2026 08:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786609223;
	bh=BpLKv+HLKMXgHbkxllR3SmVTl3IvJW2Gw7BMJgcyPFA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Sr0GrUAEEZbftQUK6bqsx4JCEi6/OxZSbCKAnwmp0ulLlakrFBFF9Im+T1eSpbBPH
	 KOg5jRqMtEkPMKjV2W6LmMKa/OIEw/G58GQ+N5VxENQJWNF0uGv5DDlxYCf+sSekPo
	 Itn3mkvrqOB/lbkgkAZQmcgKHsTNHN+4IDXOxGey8aEUrSKjY7L+Bw+pniCufBLMsB
	 KJQhq2ZRrNbRrveVG+qe1L/fxu5n5vf77Lh1wvVRqfPpnioneAc6JjJbxVtLfNS5Zg
	 nPSG7/RN2K30ABo9Rkc5BXiKSshs/vfaSox3R6ObCZsXS/7fipmN4yi02xC8TY+0j0
	 V0DpwwZlSz/rg==
Message-ID: <450c036c-71fe-4192-a678-995389b845df@kernel.org>
Date: Thu, 13 Aug 2026 10:20:17 +0200
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
Subject: Re: [axboe:for-7.0/block 19/138] block/blk-crypto-fallback.c:154:17:
 sparse: sparse: cast from restricted blk_status_t
To: Christoph Hellwig <hch@lst.de>, kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, Jens Axboe <axboe@kernel.dk>,
 Eric Biggers <ebiggers@kernel.org>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <202606012339.rZAl6Xq8-lkp@intel.com>
 <20260601152933.GA6444@lst.de>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260601152933.GA6444@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Le 01/06/2026 à 17:29, Christoph Hellwig a écrit :
> I think powerpc really need to pick the tricks from other architectures
> to make cmpxchg work on __bitwise fields.

Thanks,

Should be fixed by 
https://lore.kernel.org/all/289a7ffac9cb5b6d26a57fdc26605bf725285302.1786608980.git.chleroy@kernel.org/

Based on commit 212dd8477653 ("arm64: Silence sparse warnings caused by 
the type casting in (cmp)xchg")

Christophe

> 
> On Mon, Jun 01, 2026 at 11:26:16PM +0800, kernel test robot wrote:
>> tree:   https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Faxboe%2Flinux.git&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7Cb09ed76c517f4ac2a96a08debff29913%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639159245835365955%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=SCrQIL52YejLyMbT487%2Fu4y7bDdqD3W0NISJGASlqnI%3D&reserved=0 for-7.0/block
>> head:   72f4d6fca699a1e35b39c5e5dacac2926d254135
>> commit: b37fbce460ad60b0c4449c1c7566cf24f3016713 [19/138] blk-crypto: optimize bio splitting in blk_crypto_fallback_encrypt_bio
>> config: powerpc64-randconfig-r111-20260601 (https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdownload.01.org%2F0day-ci%2Farchive%2F20260601%2F202606012339.rZAl6Xq8-lkp%40intel.com%2Fconfig&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7Cb09ed76c517f4ac2a96a08debff29913%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639159245835742509%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=mcTjhCA7fN2FQAsYEiRRY3xTOyBg%2BNJxAwMqeSERPG4%3D&reserved=0)
>> compiler: powerpc64-linux-gcc (GCC) 8.5.0
>> sparse: v0.6.5-rc1
>> reproduce (this is a W=1 build): (https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdownload.01.org%2F0day-ci%2Farchive%2F20260601%2F202606012339.rZAl6Xq8-lkp%40intel.com%2Freproduce&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7Cb09ed76c517f4ac2a96a08debff29913%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639159245835767299%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3IobnZTPyXIEKog3PvyDf%2Bti4W%2F4jFM8O5QZG%2FVn%2Bkw%3D&reserved=0)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Foe-kbuild-all%2F202606012339.rZAl6Xq8-lkp%40intel.com%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7Cb09ed76c517f4ac2a96a08debff29913%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639159245835785008%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=dkHYbj0M7dRIfeyg8uLlJgQlMYbYi91eHIOx5FZOpJ0%3D&reserved=0
>>
>> sparse warnings: (new ones prefixed by >>)
>>>> block/blk-crypto-fallback.c:154:17: sparse: sparse: cast from restricted blk_status_t
>>>> block/blk-crypto-fallback.c:154:17: sparse: sparse: cast from restricted blk_status_t
>>     block/blk-crypto-fallback.c:154:17: sparse: sparse: cast to restricted blk_status_t
>>
>> vim +154 block/blk-crypto-fallback.c
>>
>>     143	
>>     144	static void blk_crypto_fallback_encrypt_endio(struct bio *enc_bio)
>>     145	{
>>     146		struct bio *src_bio = enc_bio->bi_private;
>>     147		int i;
>>     148	
>>     149		for (i = 0; i < enc_bio->bi_vcnt; i++)
>>     150			mempool_free(enc_bio->bi_io_vec[i].bv_page,
>>     151				     blk_crypto_bounce_page_pool);
>>     152	
>>     153		if (enc_bio->bi_status)
>>   > 154			cmpxchg(&src_bio->bi_status, 0, enc_bio->bi_status);
>>     155	
>>     156		bio_put(enc_bio);
>>     157		bio_endio(src_bio);
>>     158	}
>>     159	
>>
>> --
>> 0-DAY CI Kernel Test Service
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fintel%2Flkp-tests%2Fwiki&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7Cb09ed76c517f4ac2a96a08debff29913%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639159245835802872%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=4Iyio2M%2Fz52Q9ilcjHSE%2Fmy98xR53NJQm%2FzwwXDH1qo%3D&reserved=0
> ---end quoted text---


