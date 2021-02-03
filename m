Return-Path: <SRS0=8mZb=HF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E61C433DB
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 13:43:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C682064F6A
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 13:43:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C682064F6A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DW2vC3xV0zF37k
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Feb 2021 00:43:19 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DW0JF6rTJzDwx2
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Feb 2021 22:46:21 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4DW0JC17kLz9tlX; Wed,  3 Feb 2021 22:46:17 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Raoni Fassina Firmino <raoni@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20210201200505.iz46ubcizipnkcxe@work-tp>
References: <20210201200505.iz46ubcizipnkcxe@work-tp>
Subject: Re: [PATCH] powerpc/64/signal: Fix regression in
 __kernel_sigtramp_rt64 semantics
Message-Id: <161235275273.1521894.16491619294758116162.b4-ty@ellerman.id.au>
Date: Wed,  3 Feb 2021 22:46:17 +1100 (AEDT)
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

On Mon, 1 Feb 2021 17:05:05 -0300, Raoni Fassina Firmino wrote:
> Tested on powerpc64 and powerpc64le, with a glibc build and running the
> affected glibc's testcase[2], inspected that glibc's backtrace() now gives
> the correct result and gdb backtrace also keeps working as before.
> 
> I believe this should be backported to releases 5.9 and 5.10 as userspace
> is affected in this releases.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/64/signal: Fix regression in __kernel_sigtramp_rt64() semantics
      https://git.kernel.org/powerpc/c/24321ac668e452a4942598533d267805f291fdc9

cheers
