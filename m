Return-Path: <SRS0=iZn8=ST=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1A2C282DA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 12:37:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE97420835
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 12:37:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE97420835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44khb96fRCzDqMN
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 22:37:41 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44khXF1y9YzDqM1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 22:35:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 44khX65GM9z9s4V;
 Wed, 17 Apr 2019 22:35:02 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, paulus@samba.org
Subject: Re: [PATCH v3 7/8] powerpc/mm: Consolidate radix and hash address map
 details
In-Reply-To: <1555422365.eio3zgx55b.astroid@bobo.none>
References: <20190416100722.10324-1-aneesh.kumar@linux.ibm.com>
 <20190416100722.10324-8-aneesh.kumar@linux.ibm.com>
 <1555422365.eio3zgx55b.astroid@bobo.none>
Date: Wed, 17 Apr 2019 22:34:57 +1000
Message-ID: <878sw8vmha.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Nicholas Piggin <npiggin@gmail.com> writes:
> Aneesh Kumar K.V's on April 16, 2019 8:07 pm:
>> We now have
>> 
>> 4K page size config
>> 
>>  kernel_region_map_size = 16TB
>>  kernel vmalloc start   = 0xc000100000000000
>>  kernel IO start        = 0xc000200000000000
>>  kernel vmemmap start   = 0xc000300000000000
>> 
>> with 64K page size config:
>> 
>>  kernel_region_map_size = 512TB
>>  kernel vmalloc start   = 0xc008000000000000
>>  kernel IO start        = 0xc00a000000000000
>>  kernel vmemmap start   = 0xc00c000000000000
>
> Hey Aneesh,
>
> I like the series, I like consolidating the address spaces into 0xc,
> and making the layouts match or similar isn't a bad thing. I don't
> see any real reason to force limitations on one layout or another --
> you could make the argument that 4k radix should match 64k radix
> as much as matching 4k hash IMO.

I don't think I agree. The 4K and 64K layouts must be different because
the page size is different and therefore the span of the page tables is
different. (Unless you shrunk the 64K layouts to match 4K but that would
be silly)

On the other hand there's no good reason why hash & radix need to
differ, it's just that radix has a more strictly defined layout and it
didn't match what hash used when we added radix. We really should have
done this realignment of the hash address ranges before we merged radix.


> I wouldn't like to tie them too strongly to the same base defines
> that force them to stay in sync.
>
> Can we drop this patch? Or at least keep the users of the H_ and R_
> defines and set them to the same thing in map.h?

I don't understand why that would be a good thing?

We have all this indirection through variables at the moment, for what
appear to be constants. It makes the code harder to follow and it's less
efficient as well.

cheers
