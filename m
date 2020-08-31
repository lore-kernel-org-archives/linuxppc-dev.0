Return-Path: <SRS0=+nHh=CJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59333C433E2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2020 01:57:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08FCF20782
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2020 01:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="TKDhuGbz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08FCF20782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BftcC0t9LzDqSN
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2020 11:56:59 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BftZ05HbNzDqP9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2020 11:55:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=TKDhuGbz; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4BftYy6xJlz9sTW;
 Mon, 31 Aug 2020 11:55:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1598838904;
 bh=Fevkc9YaB+1sYDbeOG8T4LT6GQdE5UvQoFOdg072Pu4=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=TKDhuGbzZwJiCgjOR9K0+Eoiu1N+9y45LmPK2aIISkDfk+UEbKCBwjQ7Qhdpnkfyw
 kyplzaIOzSMtPulaeL074BS0aq/GM4fIN9UBXOvms4bTKzoucGapMzW/Q6L4UP3MA/
 2NqFCcpi9lId2L8nzWPulhyV+5XbgBxZkuoyuYMl6Xex6L7GiaGoI81QWsm/cq9YOY
 yQwrxa6jjC9Whjq4YOzOV/5NyZMdJDF/vbajRMvRTB57SfyVGRYTOxaBigewE1UlCt
 /jvBjUEltBJx4sRKP1ya6z56t8KGzMkjjZNSnRDnADcpFegpCY+uOtR0ngkd4pTDFV
 YD86uNOQfMvWw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] fsldma: fsl_ioread64*() do not need lower_32_bits()
In-Reply-To: <CAHk-=wjDEiWF_DsCVFPFqNa+JCS5SkOygbqeq8_=ZNOrFt7-rg@mail.gmail.com>
References: <20200829105116.GA246533@roeck-us.net>
 <20200829124538.7475-1-luc.vanoostenryck@gmail.com>
 <CAHk-=whH0ApHy0evN0q6AwQ+-a5RK56oMkYkkCJtTMnaq4FrNQ@mail.gmail.com>
 <59cc6c99-9894-08b3-1075-2156e39bfc8e@roeck-us.net>
 <CAHk-=wjDEiWF_DsCVFPFqNa+JCS5SkOygbqeq8_=ZNOrFt7-rg@mail.gmail.com>
Date: Mon, 31 Aug 2020 11:54:58 +1000
Message-ID: <874koj37gt.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
 Joerg Roedel <joerg.roedel@amd.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Li Yang <leoyang.li@nxp.com>, Zhang Wei <zw@zh-kernel.org>,
 Vinod Koul <vkoul@kernel.org>, dma <dmaengine@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Linus Torvalds <torvalds@linux-foundation.org> writes:
> On Sat, Aug 29, 2020 at 1:40 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> Except for
>>
>> CHECK: spaces preferred around that '+' (ctx:VxV)
>> #29: FILE: drivers/dma/fsldma.h:223:
>> +       u32 val_lo = in_be32((u32 __iomem *)addr+1);
>
> Added spaces.
>
>> I don't see anything wrong with it either, so
>>
>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>>
>> Since I didn't see the real problem with the original code,
>> I'd take that with a grain of salt, though.
>
> Well, honestly, the old code was so confused that just making it build
> is clearly already an improvement even if everything else were to be
> wrong.

The old code is not that old, only ~18 months:

a1ff82a9c165 ("dmaengine: fsldma: Adding macro FSL_DMA_IN/OUT implement for ARM platform") (Jan 2019)

So I think it's possible it's never been tested on 32-bit ppc at all.

I did have a 32-bit FSL machine but it lost its network card in a power
outage and now it won't boot (and I can't get to it physically).

> So I committed my "fix". If it turns out there's more wrong in there
> and somebody tests it, we can fix it again. But now it hopefully
> compiles, at least.
>
> My bet is that if that driver ever worked on ppc32, it will continue
> to work whatever we do to that function.
>
> I _think_ the old code happened to - completely by mistake - get the
> value right for the case of "little endian access, with dma_addr_t
> being 32-bit". Because then it would still read the upper bits wrong,
> but the cast to dma_addr_t would then throw those bits away. And the
> lower bits would be right.
>
> But for big-endian accesses or for ARCH_DMA_ADDR_T_64BIT it really
> looks like it always returned a completely incorrect value.
>
> And again - the driver may have worked even with that completely
> incorrect value, since the use of it seems to be very incidental.
>
> In either case ("it didn't work before" or "it worked because the
> value doesn't really matter"), I don't think I could possibly have
> made things worse.

Agreed.

Hopefully someone from NXP can test it.

cheers
