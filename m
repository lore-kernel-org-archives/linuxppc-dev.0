Return-Path: <SRS0=CqhW=BD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF3EC433E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2020 15:03:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58BC6206D8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2020 15:03:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58BC6206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BCsrz2q4RzDrgb
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Jul 2020 01:03:15 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BCqgh2y7QzDr9w
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jul 2020 23:25:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4BCqgX2L8qz9sTq; Fri, 24 Jul 2020 23:24:55 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, mpe@ellerman.id.au
In-Reply-To: <20200614083604.302611-1-maddy@linux.ibm.com>
References: <20200614083604.302611-1-maddy@linux.ibm.com>
Subject: Re: [PATCH] powerpc/perf: fix missing is_sier_aviable() during build
Message-Id: <159559696921.1657499.4289618072393865403.b4-ty@ellerman.id.au>
Date: Fri, 24 Jul 2020 23:24:55 +1000 (AEST)
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
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, 14 Jun 2020 14:06:04 +0530, Madhavan Srinivasan wrote:
> Compilation error:
> 
> arch/powerpc/perf/perf_regs.c:80:undefined reference to `.is_sier_available'
> 
> Currently is_sier_available() is part of core-book3s.c.
> But then, core-book3s.c is added to build based on
> CONFIG_PPC_PERF_CTRS. A config with CONFIG_PERF_EVENTS
> and without CONFIG_PPC_PERF_CTRS will have a build break
> because of missing is_sier_available(). Patch adds
> is_sier_available() in asm/perf_event.h to fix the build
> break for configs missing CONFIG_PPC_PERF_CTRS.

Applied to powerpc/next.

[1/1] powerpc/perf: Fix missing is_sier_aviable() during build
      https://git.kernel.org/powerpc/c/3c9450c053f88e525b2db1e6990cdf34d14e7696

cheers
