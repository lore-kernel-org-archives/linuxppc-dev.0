Return-Path: <SRS0=eY2C=2C=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F02C43603
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Dec 2019 20:56:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1C5D21556
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Dec 2019 20:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1DvaJyLX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1C5D21556
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47YmLV4nhrzDr8L
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Dec 2019 07:56:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=205.233.59.134; helo=merlin.infradead.org;
 envelope-from=peterz@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="1DvaJyLX"; dkim-atps=neutral
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47YmJ21T1SzDr7g
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Dec 2019 07:54:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HBHzOqueNtH+ssOdsRD8zcTYEQlTe6HFVq8El7WjNb0=; b=1DvaJyLXzd4+WcJoPgRVXM5Bp
 plm+iR073nzyuInoVL2P5XI6uOfap7UFGgTybaX8UZtjYf8vQCV8QGKFRJDlsElcmnKJ+bm1Z7QvW
 D5BamErHBSX9fNXxAdNhttTlFYKyxnz454Zt0hacv7YPvWD/tDMo2XTUSve+91Mourry1ICaa95S2
 zLtTCY7s/BTcK+5/3EK4+S22erSDjA6g632Cg9m35sHN5mmqiZLTBF07tEVvCQZs/NBeISHkMUj1P
 KB6y7aWGWc6UIzfD6Z0Y3rPb/gnmDA4MCC/j9wljuFCgwH2cIMzSVe6eniB9VumjCYiidRWYBzb6S
 JDJcSoWHQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=worktop.programming.kicks-ass.net)
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ifVSv-00082P-PB; Thu, 12 Dec 2019 20:53:42 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
 id 6275F980CCD; Thu, 12 Dec 2019 21:53:38 +0100 (CET)
Date: Thu, 12 Dec 2019 21:53:38 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Will Deacon <will@kernel.org>
Subject: Re: READ_ONCE() + STACKPROTECTOR_STRONG == :/ (was Re: [GIT PULL]
 Please pull powerpc/linux.git powerpc-5.5-2 tag (topic/kasan-bitops))
Message-ID: <20191212205338.GB11802@worktop.programming.kicks-ass.net>
References: <20191206131650.GM2827@hirez.programming.kicks-ass.net>
 <875zimp0ay.fsf@mpe.ellerman.id.au>
 <20191212080105.GV2844@hirez.programming.kicks-ass.net>
 <20191212100756.GA11317@willie-the-truck>
 <20191212104610.GW2827@hirez.programming.kicks-ass.net>
 <CAHk-=wjUBsH0BYDBv=q36482G-U7c=9bC89L_BViSciTfb8fhA@mail.gmail.com>
 <20191212180634.GA19020@willie-the-truck>
 <CAHk-=whRxB0adkz+V7SQC8Ac_rr_YfaPY8M2mFDfJP2FFBNz8A@mail.gmail.com>
 <20191212193401.GB19020@willie-the-truck>
 <20191212202157.GD11457@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212202157.GD11457@worktop.programming.kicks-ass.net>
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
Cc: linux-arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Mark Rutland <mark.rutland@arm.com>, linuxppc-dev@lists.ozlabs.org,
 dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Dec 12, 2019 at 09:21:57PM +0100, Peter Zijlstra wrote:
> On Thu, Dec 12, 2019 at 07:34:01PM +0000, Will Deacon wrote:
> > void ool_store_release(volatile unsigned long *ptr, unsigned long val)
> > {
> > 	smp_store_release(ptr, val);
> > }
> > 
> > 0000000000000000 <ool_store_release>:
> >    0:   a9be7bfd        stp     x29, x30, [sp, #-32]!
> >    4:   90000002        adrp    x2, 0 <__stack_chk_guard>
> >    8:   91000042        add     x2, x2, #0x0
> >    c:   910003fd        mov     x29, sp
> >   10:   f9400043        ldr     x3, [x2]
> >   14:   f9000fa3        str     x3, [x29, #24]
> >   18:   d2800003        mov     x3, #0x0                        // #0
> >   1c:   c89ffc01        stlr    x1, [x0]
> >   20:   f9400fa1        ldr     x1, [x29, #24]
> >   24:   f9400040        ldr     x0, [x2]
> >   28:   ca000020        eor     x0, x1, x0
> >   2c:   b5000060        cbnz    x0, 38 <ool_store_release+0x38>
> >   30:   a8c27bfd        ldp     x29, x30, [sp], #32
> >   34:   d65f03c0        ret
> >   38:   94000000        bl      0 <__stack_chk_fail>
> > 
> > It's a mess, and fixing READ_ONCE() doesn't help this case, which is why
> > I was looking at getting rid of volatile where it's not strictly needed.
> > I'm certainly open to other suggestions, I just haven't managed to think
> > of anything else.
> 
> We could move the kernel to C++ and write:
> 
> 	std::remove_volatile<typeof(p)>::type __p = (p);
> 
> /me runs like hell...

Also, the GCC __auto_type thing strips _Atomic and const qualifiers but
for some obscure raisin forgets to strip volatile :/

  https://gcc.gnu.org/ml/gcc-patches/2013-11/msg01378.html

Now, looking at the current GCC source:

  https://github.com/gcc-mirror/gcc/blob/97d7270f894395e513667a031a0c309d1819d05e/gcc/c/c-parser.c#L3707

it seems that __typeof__() is supposed to strip all qualifiers from
_Atomic types. That lead me to try:

	typeof(_Atomic typeof(p)) __p = (p);

But alas, I still get the same junk you got for ool_store_release() :/
