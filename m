Return-Path: <SRS0=Efpx=BA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF68CC433E1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2020 15:29:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 600352077D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2020 15:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="RqlkE4zV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 600352077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BB2Zc1ZgrzDqTJ
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2020 01:29:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=efficios.com (client-ip=167.114.26.124; helo=mail.efficios.com;
 envelope-from=compudj@efficios.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256
 header.s=default header.b=RqlkE4zV; dkim-atps=neutral
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BB2Qb2Jv6zDqk7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2020 01:22:31 +1000 (AEST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id B74E72CC666;
 Tue, 21 Jul 2020 11:22:28 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id upMwOGFpg_bC; Tue, 21 Jul 2020 11:22:28 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 5870B2CC665;
 Tue, 21 Jul 2020 11:22:28 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 5870B2CC665
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=default; t=1595344948;
 bh=8uCfUfdQu4oiK+bNjIHkykJf9WIgaALv0rxaHjwJr0E=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=RqlkE4zVklECaxgeEECd1ul22p1CQT7ScOQBrY2/z5PANaX24xgz3b5ttCog1+uvi
 87lYZRgkYGyBlftIRnErWHjpcLipK4MC/HJlE08bJovtVbKPiajoKGtCx3smOBtOZe
 gmqRx/6ufGZy/xt3vJbp4rKPREWlvusJzUgA244/qb0TtUAeXv08r/tzVviS9oCASG
 8xV2/jAxu71lpFnOTRWeH9fZSxLSopk8YPrXq3XcPaxSt/niiCJqtIEIXyFwfxm3R5
 m1OOCxW2+aLYPclYCvGEqN7WdVBhv1b6TNXkE0Y2F0YKAHdybJmQc9gh/FcyHoLpx4
 gHXfyvODcnJSg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id dO6tyL1LYrsh; Tue, 21 Jul 2020 11:22:28 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 481932CC991;
 Tue, 21 Jul 2020 11:22:28 -0400 (EDT)
Date: Tue, 21 Jul 2020 11:22:28 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Peter Zijlstra <peterz@infradead.org>
Message-ID: <2141750915.22379.1595344948206.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200721151947.GD10769@hirez.programming.kicks-ass.net>
References: <1594868476.6k5kvx8684.astroid@bobo.none>
 <1314561373.18530.1594993363050.JavaMail.zimbra@efficios.com>
 <1595213677.kxru89dqy2.astroid@bobo.none>
 <2055788870.20749.1595263590675.JavaMail.zimbra@efficios.com>
 <1595324577.x3bf55tpgu.astroid@bobo.none>
 <20200721150656.GN119549@hirez.programming.kicks-ass.net>
 <616209816.22376.1595344513051.JavaMail.zimbra@efficios.com>
 <20200721151947.GD10769@hirez.programming.kicks-ass.net>
Subject: Re: [RFC PATCH 4/7] x86: use exit_lazy_tlb rather than
 membarrier_mm_sync_core_before_usermode
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3955 (ZimbraWebClient - FF78 (Linux)/8.8.15_GA_3953)
Thread-Topic: x86: use exit_lazy_tlb rather than
 membarrier_mm_sync_core_before_usermode
Thread-Index: 3qMKvpn4CTaC/gUF9DBM4QQjSdBktA==
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
Cc: Jens Axboe <axboe@kernel.dk>, linux-arch <linux-arch@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, Andy Lutomirski <luto@amacapital.net>,
 linux-mm <linux-mm@kvack.org>, Andy Lutomirski <luto@kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

----- On Jul 21, 2020, at 11:19 AM, Peter Zijlstra peterz@infradead.org wrote:

> On Tue, Jul 21, 2020 at 11:15:13AM -0400, Mathieu Desnoyers wrote:
>> ----- On Jul 21, 2020, at 11:06 AM, Peter Zijlstra peterz@infradead.org wrote:
>> 
>> > On Tue, Jul 21, 2020 at 08:04:27PM +1000, Nicholas Piggin wrote:
>> > 
>> >> That being said, the x86 sync core gap that I imagined could be fixed
>> >> by changing to rq->curr == rq->idle test does not actually exist because
>> >> the global membarrier does not have a sync core option. So fixing the
>> >> exit_lazy_tlb points that this series does *should* fix that. So
>> >> PF_KTHREAD may be less problematic than I thought from implementation
>> >> point of view, only semantics.
>> > 
>> > So I've been trying to figure out where that PF_KTHREAD comes from,
>> > commit 227a4aadc75b ("sched/membarrier: Fix p->mm->membarrier_state racy
>> > load") changed 'p->mm' to '!(p->flags & PF_KTHREAD)'.
>> > 
>> > So the first version:
>> > 
>> >  https://lkml.kernel.org/r/20190906031300.1647-5-mathieu.desnoyers@efficios.com
>> > 
>> > appears to unconditionally send the IPI and checks p->mm in the IPI
>> > context, but then v2:
>> > 
>> >  https://lkml.kernel.org/r/20190908134909.12389-1-mathieu.desnoyers@efficios.com
>> > 
>> > has the current code. But I've been unable to find the reason the
>> > 'p->mm' test changed into '!(p->flags & PF_KTHREAD)'.
>> 
>> Looking back at my inbox, it seems like you are the one who proposed to
>> skip all kthreads:
>> 
>> https://lkml.kernel.org/r/20190904124333.GQ2332@hirez.programming.kicks-ass.net
> 
> I had a feeling it might've been me ;-) I just couldn't find the email.
> 
>> > The comment doesn't really help either; sure we have the whole lazy mm
>> > thing, but that's ->active_mm, not ->mm.
>> > 
>> > Possibly it is because {,un}use_mm() do not have sufficient barriers to
>> > make the remote p->mm test work? Or were we over-eager with the !p->mm
>> > doesn't imply kthread 'cleanups' at the time?
>> 
>> The nice thing about adding back kthreads to the threads considered for
>> membarrier
>> IPI is that it has no observable effect on the user-space ABI. No pre-existing
>> kthread
>> rely on this, and we just provide an additional guarantee for future kthread
>> implementations.
>> 
>> > Also, I just realized, I still have a fix for use_mm() now
>> > kthread_use_mm() that seems to have been lost.
>> 
>> I suspect we need to at least document the memory barriers in kthread_use_mm and
>> kthread_unuse_mm to state that they are required by membarrier if we want to
>> ipi kthreads as well.
> 
> Right, so going by that email you found it was mostly a case of being
> lazy, but yes, if we audit the kthread_{,un}use_mm() barriers and add
> any other bits that might be needed, covering kthreads should be
> possible.
> 
> No objections from me for making it so.

I'm OK on making membarrier cover kthreads using mm as well, provided we
audit kthread_{,un}use_mm() to make sure the proper barriers are in place
after setting task->mm and before clearing it.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
