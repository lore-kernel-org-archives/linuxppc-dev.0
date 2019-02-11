Return-Path: <SRS0=3oxj=QS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A17C169C4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 17:07:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 577242075D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 17:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y1t9jigP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 577242075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ysdw2ttPzDqXr
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 04:07:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org;
 envelope-from=peterz@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="Y1t9jigP"; dkim-atps=neutral
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ysbq64nrzDqWw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 04:05:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NtW9vSG4B9Be8vJJa6zgqc1RANLcAk+oi8MXCzEZ4VU=; b=Y1t9jigPcJQuy+6ZytUPMdcDk
 kcvDhn9nybF03iEbknI0N3tbXAJlxaMQ2f6hJJfcJ6nYjsb0mO6pFvJgvVcvg+WeF8wDpZM3f1X+z
 iWxU6HJcRAJk1vF4EYdkZ7xocFwYoxXdu6WhXvyAJjKjlJkCtRNnv/Ijacgdg8srcrA2e5seoeB5Y
 Es7vmJ4Sxt/Ju+G9LYnA/ldItYVsc0snS1g9tmYGKizi4qgSHMPPXL7DWLlVsDBUmO3t4dxN62tet
 s7fJVp83EP8E3d+AoPoyc5/lfn2kbFNJDfFojVXdj5DgdHACuzvIQDzx4K4qy9TGHKQf6sJrEbT9S
 auJ3b59SA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtF0k-0005pj-Bv; Mon, 11 Feb 2019 17:04:50 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 5DC0D20D0E3C8; Mon, 11 Feb 2019 18:04:47 +0100 (CET)
Date: Mon, 11 Feb 2019 18:04:47 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] locking/rwsem: Remove arch specific rwsem files
Message-ID: <20190211170447.GO32477@hirez.programming.kicks-ass.net>
References: <1549850450-10171-1-git-send-email-longman@redhat.com>
 <20190211115833.GY32511@hirez.programming.kicks-ass.net>
 <e470384d-fb7b-132d-253b-23c495e7c285@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e470384d-fb7b-132d-253b-23c495e7c285@redhat.com>
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

On Mon, Feb 11, 2019 at 11:35:24AM -0500, Waiman Long wrote:
> On 02/11/2019 06:58 AM, Peter Zijlstra wrote:
> > Which is clearly worse. Now we can write that as:
> >
> >   int __down_read_trylock2(unsigned long *l)
> >   {
> > 	  long tmp = READ_ONCE(*l);
> >
> > 	  while (tmp >= 0) {
> > 		  if (try_cmpxchg(l, &tmp, tmp + 1))
> > 			  return 1;
> > 	  }
> >
> > 	  return 0;
> >   }
> >
> > which generates:
> >
> >   0000000000000030 <__down_read_trylock2>:
> >   30:   48 8b 07                mov    (%rdi),%rax
> >   33:   48 85 c0                test   %rax,%rax
> >   36:   78 18                   js     50 <__down_read_trylock2+0x20>
> >   38:   48 8d 50 01             lea    0x1(%rax),%rdx
> >   3c:   f0 48 0f b1 17          lock cmpxchg %rdx,(%rdi)
> >   41:   75 f0                   jne    33 <__down_read_trylock2+0x3>
> >   43:   b8 01 00 00 00          mov    $0x1,%eax
> >   48:   c3                      retq
> >   49:   0f 1f 80 00 00 00 00    nopl   0x0(%rax)
> >   50:   31 c0                   xor    %eax,%eax
> >   52:   c3                      retq
> >
> > Which is a lot better; but not quite there yet.
> >
> >
> > I've tried quite a bit, but I can't seem to get GCC to generate the:
> >
> > 	add $1,%rdx
> > 	jle
> >
> > required; stuff like:
> >
> > 	new = old + 1;
> > 	if (new <= 0)
> >
> > generates:
> >
> > 	lea 0x1(%rax),%rdx
> > 	test %rdx, %rdx
> > 	jle
> 
> Thanks for the suggested code snippet. So you want to replace "lea
> 0x1(%rax), %rdx" by "add $1,%rdx"?
> 
> I think the compiler is doing that so as to use the address generation
> unit for addition instead of using the ALU. That will leave the ALU
> available for doing other arithmetic operation in parallel. I don't
> think it is a good idea to override the compiler and force it to use
> ALU. So I am not going to try doing that. It is only 1 or 2 more of
> codes anyway.

Yeah, I was trying to see what I could make it do.. #2 really should be
good enough, but you know how it is once you're poking at it :-)
