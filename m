Return-Path: <SRS0=v/d1=S3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6DDC10F03
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 12:07:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8149218DE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 12:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BCUbp0b7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8149218DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44qbXG5fjCzDqbc
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 22:07:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=infradead.org
 (client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=peterz@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="BCUbp0b7"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44qbTF19DHzDqYK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 22:04:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9wJ4ytdisYG3Dyck/NYmlZhUC8wmWDkB1Sd4twOrgK4=; b=BCUbp0b7fNwqwFex0ZMrd20u+
 oXSQ0/uA2QSTv9f8XvJNfUi3YjLHjVp6UTxcCLgtrOYCatoRdBWkhSO+YocPac3flnAbQ3dVDJP4/
 1U3NPC0Tqc4BhA1UdnX/1hjCJSJaIxN2IGARrQLgUGq/XtVZaHe8VDLLFJBdAFc/WFr0Nyou5+CqX
 EOHJPrwYLzUowMREmdPXtNLYmA1ZoR2PrkcyRQGGKMRO8bMlvHdLo4hpSWqWNwbn1PpjPrRSIyBXN
 copfc6wFzLijXtmqLhc9vhonrn3kq7/wC7J9I3vUyv+IMf85r5lEewpuQ0gzyXJEm2J3GfOMG9OkD
 QriAA21cQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hJd77-000170-0k; Thu, 25 Apr 2019 12:04:29 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 83AAE29C22B17; Thu, 25 Apr 2019 14:04:27 +0200 (CEST)
Date: Thu, 25 Apr 2019 14:04:27 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 0/5] Allow CPU0 to be nohz full
Message-ID: <20190425120427.GS4038@hirez.programming.kicks-ass.net>
References: <20190411033448.20842-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411033448.20842-1-npiggin@gmail.com>
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

On Thu, Apr 11, 2019 at 01:34:43PM +1000, Nicholas Piggin wrote:
> Since last time, I added a compile time option to opt-out of this
> if the platform does not support suspend on non-zero, and tried to
> improve legibility of changelogs and explain the justification
> better.
> 
> I have been testing this on powerpc/pseries and it seems to work
> fine (the firmware call to suspend can be called on any CPU and
> resumes where it left off), but not included here because the
> code has some bitrot unrelated to this series which I hacked to
> fix. I will discuss it and either send an acked patch to go with
> this series if it is small, or fix it in powerpc tree.
> 

Rafael, Frederic, any comments?
