Return-Path: <SRS0=1bSx=7A=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CC2C433DF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2020 06:36:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C01720787
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2020 06:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="E7odeBa2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C01720787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49QTml0YZGzDqVb
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2020 16:36:07 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49QTkm12qpzDqBt
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2020 16:34:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=E7odeBa2; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 49QTkl6NxHz9sRW;
 Mon, 18 May 2020 16:34:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1589783663;
 bh=nnerTi25T+acZVXf76i5Uou97WgIpbwls5IxTMOhr/I=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=E7odeBa2+q1vL2LgZxi6Pz4h2w9w3Eln+hhrbgDFykzpCDiZYJj2q1AnoYu3SyNqd
 A8CzKdzfr9Q7k+IoWPHgVdhXfBCG2tlXn1mfQDmKFtzfHIY6/hWsMXag8bXKYlbqNu
 HvkVrayr8d/8fewmlZazcQP3M7WBPzN9mXEizipaFK+qOLp/PFtGk/DDufeKVyTHlw
 BEZdVaYwl75zu7X6IDAB/JXDQomiHhs286OzWghiIsDh9P62CoBcpsJ5AfvSg05Fot
 zG67Og0dfvFqaJ7VlRIZALXnSv4W/zS6E35ZMB5Evz4rYcEBAnGv6MYsc0FGSHfTy9
 PxIEXotJM5q/Q==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/book3s64/radix/tlb: Determine hugepage flush
 correctly
In-Reply-To: <1589344088.xrvol2hteg.astroid@bobo.none>
References: <20200513030616.152288-1-aneesh.kumar@linux.ibm.com>
 <1589344088.xrvol2hteg.astroid@bobo.none>
Date: Mon, 18 May 2020 16:34:45 +1000
Message-ID: <87ftbxagze.fsf@mpe.ellerman.id.au>
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
Cc: Bharata B Rao <bharata@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Nicholas Piggin <npiggin@gmail.com> writes:
> Excerpts from Aneesh Kumar K.V's message of May 13, 2020 1:06 pm:
>> With a 64K page size flush with start and end value as below
>> (start, end) = (721f680d0000, 721f680e0000) results in
>> (hstart, hend) = (721f68200000, 721f68000000)
>> 
>> Avoid doing a __tlbie_va_range with the wrong hstart and hend value in this
>> case.
>> 
>> __tlbie_va_range will skip the actual tlbie operation for start > end.
>> But we still end up doing the tlbie fixup.
>
> Hm, good catch.
>
>> Reported-by: Bharata B Rao <bharata@linux.ibm.com>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> ---
>>  arch/powerpc/mm/book3s64/radix_tlb.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>> 
>> diff --git a/arch/powerpc/mm/book3s64/radix_tlb.c b/arch/powerpc/mm/book3s64/radix_tlb.c
>> index 758ade2c2b6e..d592f9e1c037 100644
>> --- a/arch/powerpc/mm/book3s64/radix_tlb.c
>> +++ b/arch/powerpc/mm/book3s64/radix_tlb.c
>> @@ -884,10 +884,10 @@ static inline void __radix__flush_tlb_range(struct mm_struct *mm,
>>  		if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
>>  			hstart = (start + PMD_SIZE - 1) & PMD_MASK;
>>  			hend = end & PMD_MASK;
>> -			if (hstart == hend)
>> -				hflush = false;
>> -			else
>> +			if (hstart < hend)
>>  				hflush = true;
>> +			else
>> +				hflush = false;
>
> We can probably get rid of the else part since it is already false.

Yeah I can do that when applying.

cheers
