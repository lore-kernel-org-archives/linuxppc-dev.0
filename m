Return-Path: <linuxppc-dev+bounces-19696-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C3CF34C53
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Apr 2026 13:46:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvTFz75SPz2ydn;
	Mon, 13 Apr 2026 23:46:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776087975;
	cv=none; b=cRPvZhMW9tTQrj6SChX8UAL1u08e9B2R2IuiugPPDa/rLJylfy5Xp5yq48//tZikjTJMoPzamY/hoPSYygCDxROd9SPQdMvCztto+PL0iMsEtzbDOgnigG431qpvu6k9m7ROWclSjEKygFcJ/fTv2INuWhQVyGi7tvcQK+mxees3M3TNVGcvz0GCuispZodJZpSKCbT3it0iD3IH5lLHJgB7TqTemlhohJhgIG+FC73kZX8CdUKzWPaqvIuYVpctAePV2p3OBLQMhMQiQ55lE/RDKR+cG8ypuSzuq5rY6eSza5OFdtjQsF0O042SrTWHn0niw11tMLHRKRLj/rKdDg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776087975; c=relaxed/relaxed;
	bh=sMs/jbfNU7MLESbr8LuYR5aB9Z4MTrt8GzJAYIUIKOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mX6fRfnwXTbDMqmoRi3IDd5OXQD4mQ8kNYJT1u7k6F2htfUdoIT2tW9uN5b3JMMnspAEuOCQjrPx2BWVfgzzJf8oOinbG3LvgOW5WRgNUDg/MGemH8UyJ1pQxWySGtXixPsNulEDWDSfpFhBSQqgMAtkU/RPpqTlq8DSy2p4vwIfLXYO8KnUUygfr5qYgJTCNhfa4zW2z0fYtMMUDdLPqVoTC77ZkZ3hTbXj/GM4mIZeVDFQB73xWZvGZIExz2cPLst0t54VLcS65UlQa0Xv4kxx0AENET7NcI32/8hJ5FvhVKSoKcT0yzlQpE6EDbUCjhPDnBRy/+/O5Ii742aE+w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=W1c4yYbX; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=vbabka@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=W1c4yYbX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=vbabka@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvTFz2H16z2yS9
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2026 23:46:15 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id F0E7F60180;
	Mon, 13 Apr 2026 13:46:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC1BFC2BCAF;
	Mon, 13 Apr 2026 13:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776087971;
	bh=oJltz7AJrAszH5NkylMptNLavhPpBeWeTGj56+4UuNQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=W1c4yYbXInfelp0eUQAv9gO8+XT0Sbrv81Gm0Adb5EvlP79aa60vW1qyaRs6863hq
	 ywlFwnEXs2N+Csj1t8AT44QeeKBJG/F49Idi2q4rc2RmYot0SX7HMiTlvtWvn/yDH+
	 7trrgahjvxasFZ1G1mSZHuMwpN/FLXdUKO5A3DE4xduSAFmVqypbzmuyI1rt6S5Skg
	 mnVOocE28OqrI3sV0A1xJA4AMsFJUmV+SiC9+WzESG+evlqCHSH4Q/iOf94U+BkWPk
	 AcZh4PrKZrOg/knioNZ+bkeabHdk27YLf4Gl2MWAVIr2/8lUMYASANuBHtyTuYAsV9
	 CyYJUfeUbdazw==
Message-ID: <ed8cf7e9-4271-48ab-a410-d7c0e2832020@kernel.org>
Date: Mon, 13 Apr 2026 15:45:59 +0200
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
Subject: Re: [patch 14/38] slub: Use prandom instead of get_cycles()
Content-Language: en-US
To: hu.shengming@zte.com.cn, harry@kernel.org
Cc: tglx@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 arnd@arndb.de, x86@kernel.org, baolu.lu@linux.intel.com,
 iommu@lists.linux.dev, m.grzeschik@pengutronix.de, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, herbert@gondor.apana.org.au,
 linux-crypto@vger.kernel.org, dwmw2@infradead.org, bernie@plugable.com,
 linux-fbdev@vger.kernel.org, tytso@mit.edu, linux-ext4@vger.kernel.org,
 akpm@linux-foundation.org, urezki@gmail.com, elver@google.com,
 dvyukov@google.com, kasan-dev@googlegroups.com, ryabinin.a.a@gmail.com,
 t.sailer@alumni.ethz.ch, linux-hams@vger.kernel.org, Jason@zx2c4.com,
 richard.henderson@linaro.org, linux-alpha@vger.kernel.org,
 linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
 catalin.marinas@arm.com, chenhuacai@kernel.org, loongarch@lists.linux.dev,
 geert@linux-m68k.org, linux-m68k@lists.linux-m68k.org, dinguyen@kernel.org,
 jonas@southpole.se, linux-openrisc@vger.kernel.org, deller@gmx.de,
 linux-parisc@vger.kernel.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, pjw@kernel.org,
 linux-riscv@lists.infradead.org, hca@linux.ibm.com,
 linux-s390@vger.kernel.org, davem@davemloft.net, sparclinux@vger.kernel.org,
 hao.li@linux.dev, cl@gentwo.org, rientjes@google.com,
 roman.gushchin@linux.dev
References: <20260413210252672ZfdcegJLJtyvlYdFAUBlr@zte.com.cn>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <20260413210252672ZfdcegJLJtyvlYdFAUBlr@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/13/26 15:02, hu.shengming@zte.com.cn wrote:
> Harry wrote:
>> [Resending after fixing broken email headers]
>> 
>> On Fri, Apr 10, 2026 at 02:19:37PM +0200, Thomas Gleixner wrote:
>> > The decision whether to scan remote nodes is based on a 'random' number
>> > retrieved via get_cycles(). get_cycles() is about to be removed.
>> > 
>> > There is already prandom state in the code, so use that instead.
>> > 
>> > Signed-off-by: Thomas Gleixner <tglx@kernel.org>
>> > Cc: Vlastimil Babka <vbabka@kernel.org>
>> > Cc: linux-mm@kvack.org
>> > ---
>> 
>> Acked-by: Harry Yoo (Oracle) <harry@kernel.org>
>> 
>> Is this for this merge window?

I'd say it's not intended for 7.1 as it's not in -next and v1 was posted
just before the merge window.

>> This may conflict with upcoming changes on freelist shuffling [1]
>> (not queued for slab/for-next yet though), but it should be easy to
>> resolve.

Indeed, it's a simple conflict.

> 
> Hi Harry,
> 
> Would you like me to wait for this patch to land linux-next and then
> rebase and send v6 on top?

Just send it now based same as previously so we can finish the reviews, and
we'll deal with it after rc1.


