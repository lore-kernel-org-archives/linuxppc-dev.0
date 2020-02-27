Return-Path: <SRS0=jCWG=4P=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340A5C4BA24
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Feb 2020 12:57:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5063246A4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Feb 2020 12:57:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5063246A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48St3h6HGszDqZV
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Feb 2020 23:57:04 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48SsVJ49GNzDqvH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Feb 2020 23:31:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 48SsVH2qCSz9sRY; Thu, 27 Feb 2020 23:31:34 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: e08658a657f974590809290c62e889f0fd420200
In-Reply-To: <20200222082049.330435-1-ravi.bangoria@linux.ibm.com>
To: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH] powerpc/watchpoint: Don't call dar_within_range() for
 Book3S
Message-Id: <48SsVH2qCSz9sRY@ozlabs.org>
Date: Thu, 27 Feb 2020 23:31:34 +1100 (AEDT)
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
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>, mikey@neuling.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, 2020-02-22 at 08:20:49 UTC, Ravi Bangoria wrote:
> DAR is set to the first byte of overlap between actual access and
> watched range at DSI on Book3S processor. But actual access range
> might or might not be within user asked range. So for Book3S, it
> must not call dar_within_range().
> 
> This revert portion of commit 39413ae00967 ("powerpc/hw_breakpoints:
> Rewrite 8xx breakpoints to allow any address range size.").
> 
> Before patch:
>   # ./tools/testing/selftests/powerpc/ptrace/perf-hwbreak
>   ...
>   TESTED: No overlap
>   FAILED: Partial overlap: 0 != 2
>   TESTED: Partial overlap
>   TESTED: No overlap
>   FAILED: Full overlap: 0 != 2
>   failure: perf_hwbreak
> 
> After patch:
>   TESTED: No overlap
>   TESTED: Partial overlap
>   TESTED: Partial overlap
>   TESTED: No overlap
>   TESTED: Full overlap
>   success: perf_hwbreak
> 
> Fixes: 39413ae00967 ("powerpc/hw_breakpoints: Rewrite 8xx breakpoints to allow any address range size.")
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/e08658a657f974590809290c62e889f0fd420200

cheers
