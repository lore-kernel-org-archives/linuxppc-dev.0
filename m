Return-Path: <SRS0=D6Rn=6F=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC20BC54FC9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2020 14:14:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A60D20679
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2020 14:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HTj4tJC6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A60D20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4965Cl0YvHzDqG0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Apr 2020 00:14:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org;
 envelope-from=peterz@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4964r8378vzDqsm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2020 23:57:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Pp2bG4fEbryHc3bEtGL1LFuRU1cWx4G4+7sc9Othu1I=; b=HTj4tJC67EYOgK0QECIFmCjDq2
 21F8Clxqw+0cNAw8vb5Ch1Z60ErYNeLv3JvecCZTWpnd/y0UHVf2/x3sptdRiRDuLIPfYArRTq0Rh
 UTxf5Y9PYN16bjwvebhPSiX36ouWYtDHwYsqcf1YINvEOjhA9GWtEM35IhAus34CYcKHAYy/Z3Srw
 KTeYWcD8/3tarYix+ekD/Hpx9XbhrqyKDv33lxxl/w/IXk3tjcf7bH/4y6V5NMLLi3+0AQUfmWE5j
 j43DhsWBA67Taj6/B6+RRXxpok6kqcfE2j73Q5djFQJ/XaWu3UOjgIYazNBPQGQ1szPRYOyyO0iJm
 p6eMMAWQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jQtOA-0000CI-6H; Tue, 21 Apr 2020 13:56:38 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B31F5300739;
 Tue, 21 Apr 2020 15:56:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 9906D2BAC7931; Tue, 21 Apr 2020 15:56:35 +0200 (CEST)
Date: Tue, 21 Apr 2020 15:56:35 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Qian Cai <cai@lca.pw>
Subject: Re: [PATCH v2] sched/core: fix illegal RCU from offline CPUs
Message-ID: <20200421135635.GT20730@hirez.programming.kicks-ass.net>
References: <20200401214033.8448-1-cai@lca.pw>
 <87369mt9kf.fsf@mpe.ellerman.id.au>
 <BBA124FA-7924-4782-AC9D-7B1B98BE817F@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BBA124FA-7924-4782-AC9D-7B1B98BE817F@lca.pw>
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
Cc: juri.lelli@redhat.com, "James.Bottomley@hansenpartnership.com"
 <James.Bottomley@HansenPartnership.com>, vincent.guittot@linaro.org,
 linux-parisc@vger.kernel.org, paulmck@kernel.org, deller@gmx.de,
 Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, bsegall@google.com, linux-mm@kvack.org,
 Ingo Molnar <mingo@redhat.com>, mgorman@suse.de, tglx@linutronix.de,
 linuxppc-dev@lists.ozlabs.org, dietmar.eggemann@arm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Apr 17, 2020 at 09:26:56AM -0400, Qian Cai wrote:

> > Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
> 
> Peter, can you take a look at this patch when you have a chance?

Sorry, -ETOOMUCHEMAIL, got it now, thanks!
