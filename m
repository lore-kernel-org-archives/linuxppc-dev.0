Return-Path: <SRS0=AMrL=FT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24C3C4361B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Dec 2020 11:29:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD41C22258
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Dec 2020 11:29:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD41C22258
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CwGHl0XRBzDqH5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Dec 2020 22:29:23 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CwFPF2DVmzDqMf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2020 21:49:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4CwFPD5vB8z9sVt; Tue, 15 Dec 2020 21:49:04 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
In-Reply-To: <20190711022404.18132-1-npiggin@gmail.com>
References: <20190711022404.18132-1-npiggin@gmail.com>
Subject: Re: [PATCH 1/2] powerpc/64s: remplement power4_idle code in C
Message-Id: <160802921170.504444.1308264557037135946.b4-ty@ellerman.id.au>
Date: Tue, 15 Dec 2020 21:49:04 +1100 (AEDT)
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

On Thu, 11 Jul 2019 12:24:03 +1000, Nicholas Piggin wrote:
> This implements the tricky tracing and soft irq handling bits in C,
> leaving the low level bit to asm.
> 
> A functional difference is that this redirects the interrupt exit to
> a return stub to execute blr, rather than the lr address itself. This
> is probably barely measurable on real hardware, but it keeps the link
> stack balanced.
> 
> [...]

Patch 2 applied to powerpc/next.

[2/2] powerpc/64s: Remove idle workaround code from restore_cpu_cpufeatures
      https://git.kernel.org/powerpc/c/02b02ee1b05ef225525835b2d45faf31b3420bdd

cheers
