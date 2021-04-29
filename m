Return-Path: <SRS0=zlGz=J2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E430C43460
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Apr 2021 14:07:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB2B96105A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Apr 2021 14:07:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB2B96105A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FWHQ74BNlz3fcf
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Apr 2021 00:07:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FWHJQ6N0hz3bpD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Apr 2021 00:02:46 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4FWHJQ0JQ5z9tk2; Fri, 30 Apr 2021 00:02:42 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20210421151733.212858-1-npiggin@gmail.com>
References: <20210421151733.212858-1-npiggin@gmail.com>
Subject: Re: [PATCH] powerpc/64s: Fix mm_cpumask memory ordering comment
Message-Id: <161970488318.4033873.11302866055869261844.b4-ty@ellerman.id.au>
Date: Fri, 30 Apr 2021 00:01:23 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 22 Apr 2021 01:17:32 +1000, Nicholas Piggin wrote:
> The memory ordering comment no longer applies, because mm_ctx_id is
> no longer used anywhere. At best always been difficult to follow.
> 
> It's better to consider the load on which the slbmte depends on, which
> the MMU depends on before it can start loading TLBs, rather than a
> store which may or may not have a subsequent dependency chain to the
> slbmte.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/64s: Fix mm_cpumask memory ordering comment
      https://git.kernel.org/powerpc/c/0f197ddce403af33aa7f15af55644549778a9988

cheers
