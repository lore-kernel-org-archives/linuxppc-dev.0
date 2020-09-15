Return-Path: <SRS0=6Pj3=CY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73960C43461
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2020 11:31:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B064220872
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2020 11:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="EqW4ku7Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B064220872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BrLdg3pbpzDqXf
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2020 21:31:03 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BrLXT1Y2HzDqQG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2020 21:26:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=EqW4ku7Y; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4BrLXQ46X3z9sTN;
 Tue, 15 Sep 2020 21:26:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1600169192;
 bh=4esK02AyElAnyDXkxcmOZ58SrlxD5sLeYfaYLnFksAA=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=EqW4ku7Y8V1CrYGyOReTmatCQO246pQi3XD9hK8QImXa+8kAvrroYZZVLIhB5Cv/L
 1HEJZtQS+acKXCy5mMNetAonLI2gIKpEbZxxPKtbRyxAhp7DbXfXGjBEQew0/9IUzn
 uRXbt4CCQ1FGVyJHUik+SPO4pM7Ori2zZ2q8Sd+rd7hSHtcrPmjcbc39dwb8ouGs30
 Ogk0REO3vpcreFt7pS/TdkFGqXscY4gN+KJ+bOxq48bkRgo6e0daxPDJKsbboli0bK
 vt48IMrpUsOzMpDaqIlp3QryBj7HBTRa4U3hJ9O+w+fwBRbfp40WWPlE48hxMPs7KN
 n614Pr2VN9Jeg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, peterz@infradead.org
Subject: Re: [PATCH v2 1/4] mm: fix exec activate_mm vs TLB shootdown and lazy
 tlb switching race
In-Reply-To: <1600137586.nypnz3sbcl.astroid@bobo.none>
References: <20200914045219.3736466-1-npiggin@gmail.com>
 <20200914045219.3736466-2-npiggin@gmail.com>
 <20200914105617.GP1362448@hirez.programming.kicks-ass.net>
 <1600137586.nypnz3sbcl.astroid@bobo.none>
Date: Tue, 15 Sep 2020 21:26:29 +1000
Message-ID: <87lfhbp9ga.fsf@mpe.ellerman.id.au>
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
Cc: Jens Axboe <axboe@kernel.dk>, linux-arch@vger.kernel.org,
 Dave Hansen <dave.hansen@intel.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
 "linux-mm @ kvack . org" <linux-mm@kvack.org>, sparclinux@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S . Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Nicholas Piggin <npiggin@gmail.com> writes:
> Excerpts from peterz@infradead.org's message of September 14, 2020 8:56 pm:
>> On Mon, Sep 14, 2020 at 02:52:16PM +1000, Nicholas Piggin wrote:
>>> Reading and modifying current->mm and current->active_mm and switching
>>> mm should be done with irqs off, to prevent races seeing an intermediate
>>> state.
...
>>> 
>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> 
>> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> 
>> I'm thinking we want this selected on x86 as well. Andy?
>
> Thanks for the ack. The plan was to take it through the powerpc tree,
> but if you'd want x86 to select it, maybe a topic branch? Although
> Michael will be away during the next merge window so I don't want to
> get too fancy. Would you mind doing it in a follow up merge after
> powerpc, being that it's (I think) a small change?

Or get akpm to take the series, including the x86 change.

cheers
