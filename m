Return-Path: <SRS0=i/4Y=5W=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BC2C2BA19
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Apr 2020 13:46:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D8BA23341
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Apr 2020 13:46:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D8BA23341
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48wsK06r5GzDqTh
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Apr 2020 23:46:44 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48wrQ43GNGzDqRy
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Apr 2020 23:06:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 48wrPs5VWNz9sRR; Mon,  6 Apr 2020 23:05:53 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 0c89649a70bed679fd408c1eb82fa99dbe1354a0
In-Reply-To: <20200402121212.1118218-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH] powerpc/64s: Fix doorbell wakeup msgclr optimisation
Message-Id: <48wrPs5VWNz9sRR@ozlabs.org>
Date: Mon,  6 Apr 2020 23:05:53 +1000 (AEST)
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
Cc: Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2020-04-02 at 12:12:12 UTC, Nicholas Piggin wrote:
> Commit 3282a3da25bd ("powerpc/64: Implement soft interrupt replay in C")
> broke the doorbell wakeup optimisation introduced by commit a9af97aa0a12
> ("powerpc/64s: msgclr when handling doorbell exceptions from system
> reset").
> 
> This patch restores it, in C code. It's moved explicitly to the system
> reset wakeup path, rather than the doorbell replay path, because it is
> always the right thing to do in the wakeup case, but it could be rare to
> have a pending message in other cases in which case it's wasted work --
> we would have to be done to see if that was a worthwhile optimisation,
> and I suspect it would not be.
> 
> The results are similar to those in the original commit, test on POWER8
> of context_switch selftests benchmark with polling idle disabled (e.g.,
> always nap, giving cross-CPU IPIs) gives the following results:
> 
>                                     broken           patched
>     Different threads, same core:   317k/s           375k/s    +18.7%
>     Different cores:                280k/s           282k/s     +1.0%
> 
> Fixes: 3282a3da25bd ("powerpc/64: Implement soft interrupt replay in C")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/0c89649a70bed679fd408c1eb82fa99dbe1354a0

cheers
