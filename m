Return-Path: <SRS0=yrNn=K6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE36C4743D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jun 2021 17:05:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E029361400
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jun 2021 17:05:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E029361400
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FxTfj6JCdz3btd
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Jun 2021 03:05:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rgFcUP+T;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=luto@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=rgFcUP+T; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FxTf86kQ9z2ym7
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Jun 2021 03:05:04 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94D00613F8;
 Fri,  4 Jun 2021 17:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622826301;
 bh=+lTqYiNuonGH3BQ6fCG8evBzKzm2s1oLT3TFmNDDrNg=;
 h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
 b=rgFcUP+TeNimMfYqYZ7tgrpJf2TcbGvVtpu2LtAsi6flEd3qrFmpnZpjp5kHN+uYu
 P92ZKwWJa9uWkSo/aNMjGt7pTQcO3j/VmHYBB8eF79zJsTdJEqlQ4QCnaAQTdqHaOu
 iYHSWL/LcCcwOU/6wHNL0cMLR/bA8fUE/mzOIDyg4VcldkQmlc5gSjnB1yrH3d/iAe
 bHVHmAlEG+mpN2wP3sazG79vHWhb38/mEVSXPiJMBzQ5vsVdP08Bl/2+G8y/vSPrnm
 yZ99DVFQOxxjQSr3SX3/ONVXdb6frQbv72p8iU9vemLuZQjXpvUcORzdnBOLC9sxti
 x2sovuO4tQqcg==
Subject: Re: [PATCH v3 0/4] shoot lazy tlbs
From: Andy Lutomirski <luto@kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20210601062303.3932513-1-npiggin@gmail.com>
 <603ffd67-3638-4c47-8067-c1bdfdf65f1b@kernel.org>
Message-ID: <991660c3-c2bf-c303-a55c-7454f0cc45f7@kernel.org>
Date: Fri, 4 Jun 2021 10:05:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <603ffd67-3638-4c47-8067-c1bdfdf65f1b@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: linux-arch@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 6/4/21 9:54 AM, Andy Lutomirski wrote:
> On 5/31/21 11:22 PM, Nicholas Piggin wrote:
>> There haven't been objections to the series since last posting, this
>> is just a rebase and tidies up a few comments minor patch rearranging.
>>
> 
> I continue to object to having too many modes.  I like my more generic
> improvements better.  Let me try to find some time to email again.
> 

Specifically, this:

https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=x86/mm

I, or someone, needs to dust off my membarrier series before any of
these kinds of changes get made.  The barrier situation in the scheduler
is too confusing otherwise.
