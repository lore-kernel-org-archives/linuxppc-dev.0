Return-Path: <SRS0=Xeze=HO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B260EC433DB
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Feb 2021 00:43:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C6FC64DE9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Feb 2021 00:43:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C6FC64DE9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DcF9J3YlqzDx1L
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Feb 2021 11:43:32 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DcDfB0fBmzDwnQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2021 11:20:02 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4DcDf96nTTz9sVv; Fri, 12 Feb 2021 11:20:01 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20210123061504.2076317-1-npiggin@gmail.com>
References: <20210123061504.2076317-1-npiggin@gmail.com>
Subject: Re: [PATCH] powerpc/64s: interrupt exit improve bounding of interrupt
 recursion
Message-Id: <161308904891.3606979.13957871996227498134.b4-ty@ellerman.id.au>
Date: Fri, 12 Feb 2021 11:20:01 +1100 (AEDT)
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
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, 23 Jan 2021 16:15:04 +1000, Nicholas Piggin wrote:
> When replaying pending soft-masked interrupts when an interrupt returns
> to an irqs-enabled context, there is a special case required if this was
> an asynchronous interrupt to avoid unbounded interrupt recursion.
> 
> This case was not tested for in the case the asynchronous interrupt hit
> in user context, because a subsequent nested interrupt would by definition
> hit in kernel mode, which then exits via the kernel path which does test
> this case.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/64s: interrupt exit improve bounding of interrupt recursion
      https://git.kernel.org/powerpc/c/c0ef717305f51e29b5ce0c78a6bfe566b3283415

cheers
