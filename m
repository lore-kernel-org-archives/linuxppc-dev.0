Return-Path: <SRS0=5aIK=N3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271D1C43441
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 10:08:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A537E2089D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 10:08:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A537E2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42xDT55ByXzF3SY
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 21:08:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42xDQy00XyzF3Gp
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Nov 2018 21:06:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42xDQx0jRsz9sBQ;
 Fri, 16 Nov 2018 21:06:33 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sabyasachi Gupta <sabyasachi.linux@gmail.com>, benh@kernel.crashing.org,
 paulus@samba.org, joe@perches.com, darren@stevens-zone.net,
 christophe.leroy@c-s.fr, geoff@infradead.org
Subject: Re: [PATCH] arch/powerpc: Use dma_zalloc_coherent
In-Reply-To: <CAJr6mf1nOouU31WF_xb_46wDebPQ-7+NTCiSKBjLyQta2mny6w@mail.gmail.com>
References: <5bdfb8db.1c69fb81.c8f62.9586@mx.google.com>
 <CAJr6mf1nOouU31WF_xb_46wDebPQ-7+NTCiSKBjLyQta2mny6w@mail.gmail.com>
Date: Fri, 16 Nov 2018 21:06:32 +1100
Message-ID: <87sh012v6f.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, Souptick Joarder <jrdr.linux@gmail.com>,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Sabyasachi Gupta <sabyasachi.linux@gmail.com> writes:

> On Mon, Nov 5, 2018 at 8:58 AM Sabyasachi Gupta
> <sabyasachi.linux@gmail.com> wrote:
>>
>> Replaced dma_alloc_coherent + memset with dma_zalloc_coherent
>>
>> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
>
> Any comment on this patch?

Wait longer :)

I'm still chasing bugs in 4.20-rc2, I haven't started merging many
patches for 4.21 yet.

Your patches are tracked in patchwork here:
  https://patchwork.ozlabs.org/project/linuxppc-dev/list/?submitter=75253


If they're still in "new" state around rc5 then feel free to ping me
again.

cheers


>> diff --git a/arch/powerpc/platforms/pasemi/dma_lib.c b/arch/powerpc/platforms/pasemi/dma_lib.c
>> index 53384eb..d18d164 100644
>> --- a/arch/powerpc/platforms/pasemi/dma_lib.c
>> +++ b/arch/powerpc/platforms/pasemi/dma_lib.c
>> @@ -255,15 +255,13 @@ int pasemi_dma_alloc_ring(struct pasemi_dmachan *chan, int ring_size)
>>
>>         chan->ring_size = ring_size;
>>
>> -       chan->ring_virt = dma_alloc_coherent(&dma_pdev->dev,
>> +       chan->ring_virt = dma_zalloc_coherent(&dma_pdev->dev,
>>                                              ring_size * sizeof(u64),
>>                                              &chan->ring_dma, GFP_KERNEL);
>>
>>         if (!chan->ring_virt)
>>                 return -ENOMEM;
>>
>> -       memset(chan->ring_virt, 0, ring_size * sizeof(u64));
>> -
>>         return 0;
>>  }
>>  EXPORT_SYMBOL(pasemi_dma_alloc_ring);
>> --
>> 2.7.4
>>
