Return-Path: <SRS0=XZtv=BK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F391C433E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jul 2020 12:27:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88557206FA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jul 2020 12:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="KbZpEbke"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88557206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BJ63T73h1zDqgP
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jul 2020 22:27:01 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BJ5yM1yGHzDqQX
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2020 22:22:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=KbZpEbke; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4BJ5yK6H3Dz9sTj;
 Fri, 31 Jul 2020 22:22:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1596198154;
 bh=Prtm3ZkafGqoaiQ6lU5j4Sn7hFJGfCqYKtzN6e75H/U=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=KbZpEbke43+mqF8Wrlu3oo7mQEHpU414hdIdx+DUlPlL6Kp3bT3j8rxM15zP+FV0A
 +cAW3Fg9FIQKplR0VN++e/ezGqL0lJ5JCRpoMiZBi7FXiaAHnRNGRb1KLrw7uNC/rB
 BDHId0/yzLGFbZj6qbVhsuBpJ1mlRrootLlQBhWtBXCrAb/CcpPEcf92UyzeIcvDbK
 hBa1e5yT6WZR4kY3u54KU8Fe2Csf/AzNYZhbXAS7eTCnwpG34leJeS57G4qDd8dEtB
 pavyyUd8Y+BtEivfjjmXio/Em3P7fb/h5bfC6/J0amjIIOUbTHvZ3wbDwlM4bkzeny
 A1rgxfFm4dRFQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 06/10] powerpc/smp: Generalize 2nd sched domain
In-Reply-To: <20200731092901.GH14603@linux.vnet.ibm.com>
References: <20200727053230.19753-1-srikar@linux.vnet.ibm.com>
 <20200727053230.19753-7-srikar@linux.vnet.ibm.com>
 <875za45dr2.fsf@mpe.ellerman.id.au>
 <20200731092901.GH14603@linux.vnet.ibm.com>
Date: Fri, 31 Jul 2020 22:22:32 +1000
Message-ID: <87lfiz50xj.fsf@mpe.ellerman.id.au>
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
Cc: Nathan Lynch <nathanl@linux.ibm.com>,
 Gautham R Shenoy <ego@linux.vnet.ibm.com>, Michael Neuling <mikey@neuling.org>,
 Peter Zijlstra <peterz@infradead.org>, Jordan Niethe <jniethe5@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 Valentin Schneider <valentin.schneider@arm.com>,
 Oliver O'Halloran <oohall@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Ingo Molnar <mingo@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:
> * Michael Ellerman <mpe@ellerman.id.au> [2020-07-31 17:45:37]:
>
>> Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:
>> > Currently "CACHE" domain happens to be the 2nd sched domain as per
>> > powerpc_topology. This domain will collapse if cpumask of l2-cache is
>> > same as SMT domain. However we could generalize this domain such that it
>> > could mean either be a "CACHE" domain or a "BIGCORE" domain.
>> >
>> > While setting up the "CACHE" domain, check if shared_cache is already
>> > set.
>> 
>> PeterZ asked for some overview of what you're doing and why, you
>> responded to his mail, but I was expecting to see that text incorporated
>> here somewhere.
>> 
>
> Okay, do you want that as part of the code or documentation dir or the
> changelog?

I guess a comment is best, as that's most likely to be seen by people
looking at the code in future.

A little bit of overview in the change log is also good.

>> He also asked for some comments, which I would also like to see.
>> 
>> 
>> I'm also not clear why we want to rename it to "bigcore", that's not a
>> commonly understood term, I don't think it's clear to new readers what
>> it means.
>> 
>> Leaving it as the shared cache domain, and having a comment mentioning
>> that "bigcores" share a cache, would be clearer I think.
>> 
>
> Today, Shared cache is equal to Big Core. However in not too distant future,
> Shared cache domain and Big Core may not be the same. For example lets
> assume that L2 cache were to Shrink per small core with the firmware
> exposing the core as a bigcore. Then with the current design, we have a SMT
> == SHARED CACHE, and a DIE. We would not have any domain at the publicised 8
> thread level. Keeping the Bigcore as a domain and mapping the shared
> cache, (I am resetting the domain name as CACHE if BIGCORE==SHARED_CACHE),
> helps us in this scenario.

Yeah OK.

In that scenario it's not really clear what the 8 thread level domain
expresses, if the two "halves" of the bigcore have separate L2s. But
presumably there is still some benefit to exposing it.

cheers
