Return-Path: <SRS0=OEx3=NM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270B2C0044C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 21:48:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7283C20657
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 21:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ls+xdu4o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7283C20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42mJjZ1VlRzF3P7
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Nov 2018 08:48:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="ls+xdu4o";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org;
 envelope-from=peterz@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="ls+xdu4o"; dkim-atps=neutral
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42mJfl4XJpzF3P3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Nov 2018 08:45:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MEJyokPYI7oa2A6Ix9ONUmGbnct/Kvmgb/sJnQOStxc=; b=ls+xdu4ozQ7c4yvsm9ovqZ/4f
 fiFuSHac7Q2elKhmdle5qz3kdC0phtzafFsg4Fo2K2xfxrjjRsDtWE8XnThq8D8sZp3qGvjfpHNYJ
 KPaE2XjSwPvKGaCuIvf0YpWpc37Hen7TUH95ZQP0r4vzo5jp+Nq2MzUx1YnyYOG061j3OHyzTmnlr
 s4Jw3VZyfp0csnbleNLXSg2xp268RVktS0DawCGK+9p+MdaTrMQynXvZgyztm7d70YjSIr84TKOug
 92DT3I1mDBUZhew+WI6z8TpS90qReNeQaT3Sba2tf1zJwoV+RlbOUgr7lAc/5xwwbeYpK4YRYEmbD
 9zqkC8MRw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop)
 by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gIKmR-00079A-Uh; Thu, 01 Nov 2018 21:45:32 +0000
Received: by worktop (Postfix, from userid 1000)
 id 4A4CE6E07D9; Thu,  1 Nov 2018 22:45:29 +0100 (CET)
Date: Thu, 1 Nov 2018 22:45:29 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [RFC PATCH] lib: Introduce generic __cmpxchg_u64() and use it
 where needed
Message-ID: <20181101214529.GB3339@worktop.programming.kicks-ass.net>
References: <20181031220253.GA15505@roeck-us.net>
 <20181031233235.qbedw3pinxcuk7me@pburton-laptop>
 <4e2438a23d2edf03368950a72ec058d1d299c32e.camel@hammerspace.com>
 <20181101131846.biyilr2msonljmij@lakrids.cambridge.arm.com>
 <20181101145926.GE3178@hirez.programming.kicks-ass.net>
 <f38e272f7a96e983549e4281aa9fd02833a4277a.camel@hammerspace.com>
 <20181101163212.GF3159@hirez.programming.kicks-ass.net>
 <20181101170146.GQ4170@linux.ibm.com>
 <20181101171846.GI3178@hirez.programming.kicks-ass.net>
 <CACT4Y+aC45BtS88DXarn3A+LV2RRRsPQoSs_3_DnKjU4O3AMHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+aC45BtS88DXarn3A+LV2RRRsPQoSs_3_DnKjU4O3AMHQ@mail.gmail.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 "jhogan@kernel.org" <jhogan@kernel.org>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "bfields@fieldses.org" <bfields@fieldses.org>,
 "paulus@samba.org" <paulus@samba.org>,
 "Paul E. McKenney" <paulmck@linux.ibm.com>,
 Trond Myklebust <trondmy@hammerspace.com>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>,
 "linux@roeck-us.net" <linux@roeck-us.net>, "arnd@arndb.de" <arnd@arndb.de>,
 "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "jlayton@kernel.org" <jlayton@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "ralf@linux-mips.org" <ralf@linux-mips.org>,
 "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
 "paul.burton@mips.com" <paul.burton@mips.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "davem@davemloft.net" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Nov 01, 2018 at 06:46:50PM +0100, Dmitry Vyukov wrote:
> If there is a warning that we don't want to see at all, then we can
> disable it. It supposed to be a useful tool, rather than a thing in
> itself that lives own life. We already I think removed 1 particularly
> noisy warning and made another optional via a config.

> But the thing with overflows is that, even if it's defined, it's not
> necessary the intended behavior. For example, take allocation size
> calculation done via unsigned size_t. If it overflows it does not help
> if C defines result or not, it still gives a user controlled write
> primitive. We've seen similar cases with timeout/deadline calculation
> in kernel, we really don't want it to just wrap modulo-2, right. Some
> user-space projects even test with unsigned overflow warnings or
> implicit truncation warnings, which are formally legal, but frequently
> bugs.

Sure; but then don't call it UB.

If we want to have an additional integer over/underflow checker (ideally
with a gcc plugin that has explicit annotations like __wrap to make it
go away) that is fine; and it can be done on unsigned and signed.


