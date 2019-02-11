Return-Path: <SRS0=3oxj=QS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09AAFC169C4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 11:00:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77EEA20838
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 11:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0U7b+TSC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77EEA20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43yjWP3J5DzDqKZ
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 22:00:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org;
 envelope-from=peterz@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="0U7b+TSC"; dkim-atps=neutral
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43yjRz14TXzDqQN
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2019 21:57:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=H4FKzYfPZLq064fpvMaxRyPbo6mwWdcW0fXgF0VWycY=; b=0U7b+TSCrog3RuwY+5aIN+sYF
 hv/X24vYbiLjaTad2ObIWMdW7Cp2r/5OoaUpAoXctxc/VYvLlvd8Jg876MzN8pgTjMW8CZ3P1r/K0
 V/l2fLFDfV1pgkRUFU9xzkmvMbliuyWhgYyM+5CQxhzMD875i3oOU3bLFnwzd6Z1n69EGanR7kB8K
 jwNrR1x25pUNYuM1WWMfiO/CFWtHodA2Mmztx2gmUubEivvDlwHAS5qsyCdKdk3uPgvtfWI5OmsKO
 4D+eGwN6yN1S/MmNn/tvUdF/HvrjMc60lzn96bluUcUP+BS/cOvXQ1En41wBhdBg2BY4eZU6c4md3
 EkSdmP65w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt9HI-0007Ng-0y; Mon, 11 Feb 2019 10:57:32 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 535FA20D0E3CF; Mon, 11 Feb 2019 11:57:29 +0100 (CET)
Date: Mon, 11 Feb 2019 11:57:29 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] locking/rwsem: Remove arch specific rwsem files
Message-ID: <20190211105729.GH32534@hirez.programming.kicks-ass.net>
References: <1549850450-10171-1-git-send-email-longman@redhat.com>
 <20190211093601.GT32511@hirez.programming.kicks-ass.net>
 <20190211094044.GG32534@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211094044.GG32534@hirez.programming.kicks-ass.net>
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
Cc: linux-arch@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 Davidlohr Bueso <dave@stgolabs.net>, linux-ia64@vger.kernel.org,
 Tim Chen <tim.c.chen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org, x86@kernel.org,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Feb 11, 2019 at 10:40:44AM +0100, Peter Zijlstra wrote:
> On Mon, Feb 11, 2019 at 10:36:01AM +0100, Peter Zijlstra wrote:
> > On Sun, Feb 10, 2019 at 09:00:50PM -0500, Waiman Long wrote:
> > > +static inline int __down_read_trylock(struct rw_semaphore *sem)
> > > +{
> > > +	long tmp;
> > > +
> > > +	while ((tmp = atomic_long_read(&sem->count)) >= 0) {
> > > +		if (tmp == atomic_long_cmpxchg_acquire(&sem->count, tmp,
> > > +				   tmp + RWSEM_ACTIVE_READ_BIAS)) {
> > > +			return 1;
> > 
> > That really wants to be:
> > 
> > 		if (atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
> > 						    tmp + RWSEM_ACTIVE_READ_BIAS))
> > 
> > > +		}
> > > +	}
> > > +	return 0;
> > > +}
> 
> Also, the is the one case where LL/SC can actually do 'better'. Do you
> have benchmarks for say PowerPC or ARM64 ?

Ah, I see they already used asm-generic/rwsem.h which has similar code
to the above.
