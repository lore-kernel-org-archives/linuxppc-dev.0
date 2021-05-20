Return-Path: <SRS0=6/er=KP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17439C433ED
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 May 2021 11:38:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EB2F60E0B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 May 2021 11:38:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EB2F60E0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Fm76J34PWz3bt6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 May 2021 21:38:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=WkE6y0Ir;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=WkE6y0Ir; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fm75p47Dfz2yXs
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 May 2021 21:38:05 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Fm75m5QXnz9sW1;
 Thu, 20 May 2021 21:38:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1621510685;
 bh=jDACQ+OUecqEbfkWRJ1A5nWQI0imbYB/gQMHhKIimck=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=WkE6y0Irju7pJbtIjJ0k2htX7IH/f7MfZ99L8mKsZdRw4rc0gMHjF14PdY8UTYleh
 vgxWztsfok1P/lSA6uK50Rtsu8aBKxTz42K6BqnCCu8WMZrGWbhjClVyMc+DI2LWI+
 mkYWJK5WNojNvOIdRg7AoLOiPKDjfRQlO0l6/E+slxvOOsJazlk/YtUPdLg8go6v5S
 Qxt4lubBJGieSK0mp958unUIGCBKa2nqCzY/p/IA5TxYJgPCuzNG8Zq0IyemE9MPGQ
 qjIg1QFWeuFxIGqAL81qJt07kNG5wNfcxbrBYt61BosdajG+2z2DSRfMqG78H1Cz1p
 ql/N9c8waiedg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Guenter Roeck <linux@roeck-us.net>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH v5 5/9] powerpc/mm/book3s64: Update tlb flush routines
 to take a page walk cache flush argument
In-Reply-To: <969f377f-fddb-c2de-781c-fde37d121a4d@roeck-us.net>
References: <20210422054323.150993-1-aneesh.kumar@linux.ibm.com>
 <20210422054323.150993-6-aneesh.kumar@linux.ibm.com>
 <20210515163525.GA1106462@roeck-us.net>
 <e0eba73a-c2df-71c3-e03d-d4074d908fca@linux.ibm.com>
 <d830fce9-c00a-e879-4115-94a2346a806f@roeck-us.net>
 <87pmxpqxb1.fsf@linux.ibm.com>
 <a7dd34f3-7d79-c933-fb62-eaad5c83d37a@roeck-us.net>
 <87a6ork1qp.fsf@mpe.ellerman.id.au>
 <969f377f-fddb-c2de-781c-fde37d121a4d@roeck-us.net>
Date: Thu, 20 May 2021 21:38:02 +1000
Message-ID: <87wnrtiqjp.fsf@mpe.ellerman.id.au>
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
Cc: npiggin@gmail.com, linux-mm@kvack.org, kaleshsingh@google.com,
 joel@joelfernandes.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Guenter Roeck <linux@roeck-us.net> writes:
> On 5/18/21 5:26 PM, Michael Ellerman wrote:
> [ ... ]
>>>> That was the generic header change in the patch. I was commenting about the
>>>> ppc64 specific change causing build failures.
>>>
>>> Ah, sorry. I wasn't aware that the following is valid C code
>>>
>>> void f1()
>>> {
>>>       return f2();
>>>       ^^^^^^
>>> }
>>>
>>> as long as f2() is void as well. Confusing, but we live and learn.
>> 
>> It might be valid, but it's still bad IMHO.
>> 
>> It's confusing to readers, and serves no useful purpose.
>> 
>
> Agreed, but it is surprisingly wide-spread. Try to run the coccinelle
> script below, just for fun. The script doesn't even catch instances
> in include files, yet there are more than 450 hits.

Yikes, that is a lot.

I guess they're pretty harmless, but would be nice to clean them up
eventually.

Why doesn't the script work for instances in headers?

cheers
