Return-Path: <SRS0=a6W3=DB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187D8C4363D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2020 13:00:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15FD121D24
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2020 13:00:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15FD121D24
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BxwBL1Z3YzDq9y
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2020 23:00:10 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BxvTR73QMzDqZj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2020 22:28:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4BxvTR2YxTz9sV1; Thu, 24 Sep 2020 22:28:10 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>,
 "linux-mm @ kvack . org" <linux-mm@kvack.org>
In-Reply-To: <20200914045219.3736466-1-npiggin@gmail.com>
References: <20200914045219.3736466-1-npiggin@gmail.com>
Subject: Re: [PATCH v2 0/4] more mm switching vs TLB shootdown and lazy tlb
 fixes
Message-Id: <160094999385.26280.16775247303184322384.b4-ty@ellerman.id.au>
Date: Thu, 24 Sep 2020 22:28:10 +1000 (AEST)
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
 Peter Zijlstra <peterz@infradead.org>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S . Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 14 Sep 2020 14:52:15 +1000, Nicholas Piggin wrote:
> This is an attempt to fix a few different related issues around
> switching mm, TLB flushing, and lazy tlb mm handling.
> 
> This will require all architectures to eventually move to disabling
> irqs over activate_mm, but it's possible we could add another arch
> call after irqs are re-enabled for those few which can't do their
> entire activation with irqs disabled.
> 
> [...]

Applied to powerpc/next.

[1/4] mm: fix exec activate_mm vs TLB shootdown and lazy tlb switching race
      https://git.kernel.org/powerpc/c/d53c3dfb23c45f7d4f910c3a3ca84bf0a99c6143
[2/4] powerpc: select ARCH_WANT_IRQS_OFF_ACTIVATE_MM
      https://git.kernel.org/powerpc/c/66acd46080bd9e5ad2be4b0eb1d498d5145d058e
[3/4] sparc64: remove mm_cpumask clearing to fix kthread_use_mm race
      https://git.kernel.org/powerpc/c/bafb056ce27940c9994ea905336aa8f27b4f7275
[4/4] powerpc/64s/radix: Fix mm_cpumask trimming race vs kthread_use_mm
      https://git.kernel.org/powerpc/c/a665eec0a22e11cdde708c1c256a465ebe768047

cheers
