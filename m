Return-Path: <SRS0=v/d1=S3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE6FC10F03
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 12:04:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9D0D2084B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 12:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="itKCf7Um"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D0D2084B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44qbSv0fPKzDqZk
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 22:04:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=infradead.org
 (client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=peterz@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="itKCf7Um"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44qbQr07yvzDqYK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 22:02:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1qJZVo8k8mfgYlmp5TlLC0v12e3deJx7zXBcLuuf09Y=; b=itKCf7UmuYpBuLWRVW2Bbm8gh
 Eu+0cXhmneoXZOnbipmmftF1WjzE0G/wpyQ38Uy9pfrFEaqqWy45fCY+vvi/by/YC31pQj0y/7lHp
 ygA+X46hJbobIbWwVh6nNxJ3sxwS1L3EfifLAgx9ylVR/1bVGwEVa97r7scrmrcquEceVsbF3qbxt
 g1mxIOpaZ362uDYeMnclHAN2Vg/uRhmD/Rh0CAwoRtrxdm4mcXrbyjD7F5e5Ud15VUxrmgYVdIcV8
 VDjlxiZMb+502NldtQH3Jb+AQwTNz0xu+aRZIkb6vN8AiVzusMN98hHOEqkD+os7O1i0Gkd5Apo8u
 +VshWaI7A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hJd55-00010Y-34; Thu, 25 Apr 2019 12:02:23 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 9295A29C22B16; Thu, 25 Apr 2019 14:02:21 +0200 (CEST)
Date: Thu, 25 Apr 2019 14:02:21 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 3/5] kernel/cpu: Allow non-zero CPU to be primary for
 suspend / kexec freeze
Message-ID: <20190425120221.GR4038@hirez.programming.kicks-ass.net>
References: <20190411033448.20842-1-npiggin@gmail.com>
 <20190411033448.20842-4-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411033448.20842-4-npiggin@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: linux-arch@vger.kernel.org, Frederic Weisbecker <fweisbec@gmail.com>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Apr 11, 2019 at 01:34:46PM +1000, Nicholas Piggin wrote:
> This patch provides an arch option, ARCH_SUSPEND_NONZERO_CPU, to
> opt-in to allowing suspend to occur on one of the housekeeping CPUs
> rather than hardcoded CPU0.
> 
> This will allow CPU0 to be a nohz_full CPU with a later change.
> 
> It may be possible for platforms with hardware/firmware restrictions
> on suspend/wake effectively support this by handing off the final
> stage to CPU0 when kernel housekeeping is no longer required. Another
> option is to make housekeeping / nohz_full mask dynamic at runtime,
> but the complexity could not be justified at this time.

Should we not tie this into whatever already allows an achitecture to
hotplug CPU-0? For instance, x86 default disallows this but has
cpu0_hotpluggable to allow this.

Presumably POWER already allows hotplugging CPU-0 ?


