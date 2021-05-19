Return-Path: <SRS0=tyeE=KO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485D6C433ED
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 May 2021 10:02:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02890611BF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 May 2021 10:02:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02890611BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FlT1c6gfjz3bTv
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 May 2021 20:02:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=lS+G+OpQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=peterz@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=lS+G+OpQ; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FlT105KbRz2ykH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 May 2021 20:01:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=lrHTtWU2Ja7nq7tAFCmZ0NQCnlRMgHJkSLhsHTyzMuU=; b=lS+G+OpQvvcFXjenkTv1ldJDnr
 B4Q4qVOuxxMhkD2R+LrFAVHJKlytN6en2k2jhVL/kym2Bt7QRjnx194vrRVV2SudHKSPuC0scNVty
 eoxH53MZc2nEtr86TfNBpTRUjPr9nw76ihYoqKyuLF23Lkdqf+5nHou+FLaWtk0H/1SgtVPoWLqtU
 jM43fuW1Fsr1+wIUJ3bg60zzs8Fhp7+FfvbgrGIg5UxYXK7ZoiXUTqMrCd3F5EMjAfmqk4bljvLhi
 5jqHXNFT057VW9tasa1HSTNHGlmeQyPX1uxu4Nj885xew/XxBUAtcOwuU2wOerFHXT+/Cc9n6Y0CK
 pVKxBQdA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1ljIzX-00EpPQ-67; Wed, 19 May 2021 10:00:09 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CFBDE30022C;
 Wed, 19 May 2021 11:59:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 8BECA284C274E; Wed, 19 May 2021 11:59:48 +0200 (CEST)
Date: Wed, 19 May 2021 11:59:48 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: Re: [PATCH v3 5/6] sched/fair: Consider SMT in ASYM_PACKING load
 balance
Message-ID: <YKThlA2yZBT2KuvW@hirez.programming.kicks-ass.net>
References: <20210513154909.6385-1-ricardo.neri-calderon@linux.intel.com>
 <20210513154909.6385-6-ricardo.neri-calderon@linux.intel.com>
 <YJ5HQR943rSFsLxw@hirez.programming.kicks-ass.net>
 <20210515021415.GB14212@ranerica-svr.sc.intel.com>
 <20210518190740.GA15251@ranerica-svr.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518190740.GA15251@ranerica-svr.sc.intel.com>
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
Cc: Juri Lelli <juri.lelli@redhat.com>, Len Brown <len.brown@intel.com>,
 Quentin Perret <qperret@google.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 "Ravi V. Shankar" <ravi.v.shankar@intel.com>, linux-kernel@vger.kernel.org,
 Aubrey Li <aubrey.li@linux.intel.com>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Ricardo Neri <ricardo.neri@intel.com>, Steven Rostedt <rostedt@goodmis.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>,
 linuxppc-dev@lists.ozlabs.org, Mel Gorman <mgorman@suse.de>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 "Joel Fernandes \(Google\)" <joel@joelfernandes.org>,
 Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 Aubrey Li <aubrey.li@intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, May 18, 2021 at 12:07:40PM -0700, Ricardo Neri wrote:
> On Fri, May 14, 2021 at 07:14:15PM -0700, Ricardo Neri wrote:
> > On Fri, May 14, 2021 at 11:47:45AM +0200, Peter Zijlstra wrote:

> > > So I'm thinking that this is a property of having ASYM_PACKING at a core
> > > level, rather than some arch special. Wouldn't something like this be
> > > more appropriate?

> > Thanks Peter for the quick review! This makes sense to me. The only
> > reason we proposed arch_asym_check_smt_siblings() is because we were
> > about breaking powerpc (I need to study how they set priorities for SMT,
> > if applicable). If you think this is not an issue I can post a
> > v4 with this update.
> 
> As far as I can see, priorities in powerpc are set by the CPU number.
> However, I am not sure how CPUs are enumerated? If CPUs in brackets are
> SMT sibling, Does an enumeration looks like A) [0, 1], [2, 3] or B) [0, 2],
> [1, 3]? I guess B is the right answer. Otherwise, both SMT siblings of a
> core would need to be busy before a new core is used.
> 
> Still, I think the issue described in the cover letter may be
> reproducible in powerpc as well. If CPU3 is offlined, and [0, 2] pulled
> tasks from [1, -] so that both CPU0 and CPU2 become busy, CPU1 would not be
> able to help since CPU0 has the highest priority.
> 
> I am cc'ing the linuxppc list to get some feedback.

IIRC the concern with Power is that their Cores can go faster if the
higher SMT siblings are unused.

That is, suppose you have an SMT4 Core with only a single active task,
then if only SMT0 is used it can reach max performance, but if the
active sibling is SMT1 it can not reach max performance, and if the only
active sibling is SMT2 it goes slower still.

So they need to pack the tasks to the lowest SMT siblings, and have the
highest SMT siblings idle (where possible) in order to increase
performance.


