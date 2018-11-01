Return-Path: <SRS0=OEx3=NM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19CAC0044C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 17:21:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 542B42064C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 17:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gnSJ9EM5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 542B42064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42mBnz21lszF3H4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Nov 2018 04:21:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="gnSJ9EM5";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org;
 envelope-from=peterz@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="gnSJ9EM5"; dkim-atps=neutral
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42mBlJ1rXSzDrPw
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Nov 2018 04:19:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=O9mYa/rmeeVfQNGgOPaQg2kcrK4it59yo1d7DnPkWvE=; b=gnSJ9EM5OrIgQqirgYJiYUGPW
 ZTUjNSVtiZfsDPD7k2VzCoOuc63jfeMQ+7Om7om4QYvA3mGK+Tf6EKXSBFKD327whbDDZfDtUv/76
 RW9hP+f70jeSU14Q6HqvgdMAwc2Ac+iYyv0Z9Z8ag+bVzW2Kv2LLK7rWerl24sxsevwu0GwXhlx1g
 t6oPj61yh20X9yiGhZvKsrwaf691UPi6G9/eb9QLkpB/gjw5e4A4bZ42+40qLQ8z8Oa0g5H4pt5oH
 DYLPE19C9NKBMU52eQkJhXN4fCgZePofw3qK6ojxe4YkvgvDHIIFf6HSA5F8TWIo6Qr4xggWlelC7
 Wfpz+litg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gIGcL-0005sn-Bi; Thu, 01 Nov 2018 17:18:49 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 001322029F9FF; Thu,  1 Nov 2018 18:18:46 +0100 (CET)
Date: Thu, 1 Nov 2018 18:18:46 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [RFC PATCH] lib: Introduce generic __cmpxchg_u64() and use it
 where needed
Message-ID: <20181101171846.GI3178@hirez.programming.kicks-ass.net>
References: <1541015538-11382-1-git-send-email-linux@roeck-us.net>
 <20181031213240.zhh7dfcm47ucuyfl@pburton-laptop>
 <20181031220253.GA15505@roeck-us.net>
 <20181031233235.qbedw3pinxcuk7me@pburton-laptop>
 <4e2438a23d2edf03368950a72ec058d1d299c32e.camel@hammerspace.com>
 <20181101131846.biyilr2msonljmij@lakrids.cambridge.arm.com>
 <20181101145926.GE3178@hirez.programming.kicks-ass.net>
 <f38e272f7a96e983549e4281aa9fd02833a4277a.camel@hammerspace.com>
 <20181101163212.GF3159@hirez.programming.kicks-ass.net>
 <20181101170146.GQ4170@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181101170146.GQ4170@linux.ibm.com>
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "bfields@fieldses.org" <bfields@fieldses.org>,
 "paulus@samba.org" <paulus@samba.org>,
 Trond Myklebust <trondmy@hammerspace.com>,
 "jhogan@kernel.org" <jhogan@kernel.org>, aryabinin@virtuozzo.com,
 "linux@roeck-us.net" <linux@roeck-us.net>, "arnd@arndb.de" <arnd@arndb.de>,
 "boqun.feng@gmail.com" <boqun.feng@gmail.com>, dvyukov@google.com,
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

On Thu, Nov 01, 2018 at 10:01:46AM -0700, Paul E. McKenney wrote:
> On Thu, Nov 01, 2018 at 05:32:12PM +0100, Peter Zijlstra wrote:
> > On Thu, Nov 01, 2018 at 03:22:15PM +0000, Trond Myklebust wrote:
> > > On Thu, 2018-11-01 at 15:59 +0100, Peter Zijlstra wrote:
> > > > On Thu, Nov 01, 2018 at 01:18:46PM +0000, Mark Rutland wrote:
> > 
> > > > > > My one question (and the reason why I went with cmpxchg() in the
> > > > > > first place) would be about the overflow behaviour for
> > > > > > atomic_fetch_inc() and friends. I believe those functions should
> > > > > > be OK on x86, so that when we overflow the counter, it behaves
> > > > > > like an unsigned value and wraps back around.  Is that the case
> > > > > > for all architectures?
> > > > > > 
> > > > > > i.e. are atomic_t/atomic64_t always guaranteed to behave like
> > > > > > u32/u64 on increment?
> > > > > > 
> > > > > > I could not find any documentation that explicitly stated that
> > > > > > they should.
> > > > > 
> > > > > Peter, Will, I understand that the atomic_t/atomic64_t ops are
> > > > > required to wrap per 2's-complement. IIUC the refcount code relies
> > > > > on this.
> > > > > 
> > > > > Can you confirm?
> > > > 
> > > > There is quite a bit of core code that hard assumes 2s-complement.
> > > > Not only for atomics but for any signed integer type. Also see the
> > > > kernel using -fno-strict-overflow which implies -fwrapv, which
> > > > defines signed overflow to behave like 2s-complement (and rids us of
> > > > that particular UB).
> > > 
> > > Fair enough, but there have also been bugfixes to explicitly fix unsafe
> > > C standards assumptions for signed integers. See, for instance commit
> > > 5a581b367b5d "jiffies: Avoid undefined behavior from signed overflow"
> > > from Paul McKenney.
> > 
> > Yes, I feel Paul has been to too many C/C++ committee meetings and got
> > properly paranoid. Which isn't always a bad thing :-)
> 
> Even the C standard defines 2s complement for atomics.  

Ooh good to know.

> Just not for
> normal arithmetic, where yes, signed overflow is UB.  And yes, I do
> know about -fwrapv, but I would like to avoid at least some copy-pasta
> UB from my kernel code to who knows what user-mode environment.  :-/
> 
> At least where it is reasonably easy to do so.

Fair enough I suppose; I just always make sure to include the same
-fknobs for the userspace thing when I lift code.

> And there is a push to define C++ signed arithmetic as 2s complement,
> but there are still 1s complement systems with C compilers.  Just not
> C++ compilers.  Legacy...

*groan*; how about those ancient hardwares keep using ancient compilers
and we all move on to the 70s :-)

> > But for us using -fno-strict-overflow which actually defines signed
> > overflow, I myself am really not worried. I'm also not sure if KASAN has
> > been taught about this, or if it will still (incorrectly) warn about UB
> > for signed types.
> 
> UBSAN gave me a signed-overflow warning a few days ago.  Which I have
> fixed, even though 2s complement did the right thing.  I am also taking
> advantage of the change to use better naming.

Oh too many *SANs I suppose; and yes, if you can make the code better,
why not.

> > > Anyhow, if the atomic maintainers are willing to stand up and state for
> > > the record that the atomic counters are guaranteed to wrap modulo 2^n
> > > just like unsigned integers, then I'm happy to take Paul's patch.
> > 
> > I myself am certainly relying on it.
> 
> Color me confused.  My 5a581b367b5d is from 2013.  Or is "Paul" instead
> intended to mean Paul Mackerras, who happens to be on CC?

Paul Burton I think, on a part of the thread before we joined :-)
