Return-Path: <SRS0=Exvj=A3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 341A1C433E0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jul 2020 13:36:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1175207DD
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jul 2020 13:36:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1175207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B6wJW0RfNzDqyv
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jul 2020 23:36:27 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B6vPr3jyLzDql9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2020 22:56:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4B6vPk4Yqpz9sV5; Thu, 16 Jul 2020 22:55:53 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: "Desnes A. Nunes do Rosario" <desnesn@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20200626164737.21943-1-desnesn@linux.ibm.com>
References: <20200626164737.21943-1-desnesn@linux.ibm.com>
Subject: Re: [PATCH] selftests/powerpc: Purge extra count_pmc() calls of ebb
 selftests
Message-Id: <159490400479.3805857.6584199354470520618.b4-ty@ellerman.id.au>
Date: Thu, 16 Jul 2020 22:55:53 +1000 (AEST)
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
Cc: shuah@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 26 Jun 2020 13:47:37 -0300, Desnes A. Nunes do Rosario wrote:
> An extra count on ebb_state.stats.pmc_count[PMC_INDEX(pmc)] is being per-
> formed when count_pmc() is used to reset PMCs on a few selftests. This
> extra pmc_count can occasionally invalidate results, such as the ones from
> cycles_test shown hereafter. The ebb_check_count() failed with an above
> the upper limit error due to the extra value on ebb_state.stats.pmc_count.
> 
> Furthermore, this extra count is also indicated by extra PMC1 trace_log on
> the output of the cycle test (as well as on pmc56_overflow_test):
> 
> [...]

Applied to powerpc/next.

[1/1] selftests/powerpc: Purge extra count_pmc() calls of ebb selftests
      https://git.kernel.org/powerpc/c/3337bf41e0dd70b4064cdf60acdfcdc2d050066c

cheers
