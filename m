Return-Path: <SRS0=RHZ4=QV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A2AC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 18:04:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D99720836
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 18:04:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D99720836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 440kmq2762zDqZj
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 05:04:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=will.deacon@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 440kkx1qhpzDqTw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 05:02:48 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65562EBD;
 Thu, 14 Feb 2019 10:02:45 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D806D3F589;
 Thu, 14 Feb 2019 10:02:41 -0800 (PST)
Date: Thu, 14 Feb 2019 18:02:39 +0000
From: Will Deacon <will.deacon@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 2/2] locking/rwsem: Optimize down_read_trylock()
Message-ID: <20190214180239.GI2475@fuggles.cambridge.arm.com>
References: <1550089932-6888-1-git-send-email-longman@redhat.com>
 <1550089932-6888-3-git-send-email-longman@redhat.com>
 <20190214103333.GH32494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214103333.GH32494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
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
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, linux-alpha@vger.kernel.org,
 sparclinux@vger.kernel.org, Waiman Long <longman@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Feb 14, 2019 at 11:33:33AM +0100, Peter Zijlstra wrote:
> On Wed, Feb 13, 2019 at 03:32:12PM -0500, Waiman Long wrote:
> > Modify __down_read_trylock() to optimize for an unlocked rwsem and make
> > it generate slightly better code.
> > 
> > Before this patch, down_read_trylock:
> > 
> >    0x0000000000000000 <+0>:     callq  0x5 <down_read_trylock+5>
> >    0x0000000000000005 <+5>:     jmp    0x18 <down_read_trylock+24>
> >    0x0000000000000007 <+7>:     lea    0x1(%rdx),%rcx
> >    0x000000000000000b <+11>:    mov    %rdx,%rax
> >    0x000000000000000e <+14>:    lock cmpxchg %rcx,(%rdi)
> >    0x0000000000000013 <+19>:    cmp    %rax,%rdx
> >    0x0000000000000016 <+22>:    je     0x23 <down_read_trylock+35>
> >    0x0000000000000018 <+24>:    mov    (%rdi),%rdx
> >    0x000000000000001b <+27>:    test   %rdx,%rdx
> >    0x000000000000001e <+30>:    jns    0x7 <down_read_trylock+7>
> >    0x0000000000000020 <+32>:    xor    %eax,%eax
> >    0x0000000000000022 <+34>:    retq
> >    0x0000000000000023 <+35>:    mov    %gs:0x0,%rax
> >    0x000000000000002c <+44>:    or     $0x3,%rax
> >    0x0000000000000030 <+48>:    mov    %rax,0x20(%rdi)
> >    0x0000000000000034 <+52>:    mov    $0x1,%eax
> >    0x0000000000000039 <+57>:    retq
> > 
> > After patch, down_read_trylock:
> > 
> >    0x0000000000000000 <+0>:	callq  0x5 <down_read_trylock+5>
> >    0x0000000000000005 <+5>:	xor    %eax,%eax
> >    0x0000000000000007 <+7>:	lea    0x1(%rax),%rdx
> >    0x000000000000000b <+11>:	lock cmpxchg %rdx,(%rdi)
> >    0x0000000000000010 <+16>:	jne    0x29 <down_read_trylock+41>
> >    0x0000000000000012 <+18>:	mov    %gs:0x0,%rax
> >    0x000000000000001b <+27>:	or     $0x3,%rax
> >    0x000000000000001f <+31>:	mov    %rax,0x20(%rdi)
> >    0x0000000000000023 <+35>:	mov    $0x1,%eax
> >    0x0000000000000028 <+40>:	retq
> >    0x0000000000000029 <+41>:	test   %rax,%rax
> >    0x000000000000002c <+44>:	jns    0x7 <down_read_trylock+7>
> >    0x000000000000002e <+46>:	xor    %eax,%eax
> >    0x0000000000000030 <+48>:	retq
> > 
> > By using a rwsem microbenchmark, the down_read_trylock() rate (with a
> > load of 10 to lengthen the lock critical section) on a x86-64 system
> > before and after the patch were:
> > 
> >                  Before Patch    After Patch
> >    # of Threads     rlock           rlock
> >    ------------     -----           -----
> >         1           14,496          14,716
> >         2            8,644           8,453
> > 	4            6,799           6,983
> > 	8            5,664           7,190
> > 
> > On a ARM64 system, the performance results were:
> > 
> >                  Before Patch    After Patch
> >    # of Threads     rlock           rlock
> >    ------------     -----           -----
> >         1           23,676          24,488
> >         2            7,697           9,502
> >         4            4,945           3,440
> >         8            2,641           1,603
> 
> Urgh, yes LL/SC is the obvious exception that can actually do better
> here :/
> 
> Will, what say you?

What machine were these numbers generated on and is it using LL/SC or LSE
atomics for arm64? If you stick the microbenchmark somewhere, I can go play
with a broader variety of h/w.

Will
