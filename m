Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2D1151A000B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 16:03:42 +1100 (AEDT)
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 65F7514031E
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Feb 2016 16:03:41 +1100 (AEDT)
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 16 Feb 2016 10:33:38 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1G53DL111862428
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Feb 2016 10:33:13 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1G53LCi023197
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Feb 2016 10:33:25 +0530
Date: Tue, 16 Feb 2016 10:32:55 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Cyril Bur <cyrilbur@gmail.com>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, anton@samba.org
Subject: Re: [PATCH v4 1/9] selftests/powerpc: Test the preservation of FPU
 and VMX regs across syscall
Message-ID: <20160216050255.GI2599@naverao1-tp.ibm.com>
References: <1455512850-2543-1-git-send-email-cyrilbur@gmail.com>
 <1455512850-2543-2-git-send-email-cyrilbur@gmail.com>
 <20160215165916.GH2599@naverao1-tp.ibm.com>
 <20160216110625.7b2e8134@camb691>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160216110625.7b2e8134@camb691>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/02/16 11:06AM, Cyril Bur wrote:
> On Mon, 15 Feb 2016 22:29:17 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
> > On 2016/02/15 04:07PM, Cyril Bur wrote:
> > > Test that the non volatile floating point and Altivec registers get
> > > correctly preserved across the fork() syscall.
> > > 
> > > fork() works nicely for this purpose, the registers should be the same for
> > > both parent and child
> > > 
> > > Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> > > ---

<snip>

> > > +
> > > +/* It is very important to note here that _extra is the extra amount of
> > > + * stack space needed.
> > > + * This space must be accessed at sp + 32!  
> > 
> 
> Hi Naveen,
> 
> Thanks for the review.
> 
> > This looks to be specific to ABIv2. Is this series limited to ppc64le?  
> > If so, you might want to ensure this only builds there.
> > 
> 
> Is ABIv1 still in use? Can we still compile for v1? 

Yes, that's the earlier ppc64 BE (I'm assuming these tests can be run 
when booted in LPARs as well)

> 
> This is for series 64bit only, I've not really got any reason to believe this
> is LE only, shouldn't this work BE? The makefile enforces 64bit, I believe it is

This won't work for ABIv1 BE since the stack setup is a bit different. I 
think your patches assume that 32 bytes is the minimum stack size, but 
that's only for ABIv2. Also, the locations of CR and TOC save areas on 
the stack are quite different:

http://refspecs.linuxfoundation.org/ELF/ppc64/PPC-elf64abi-1.9.html#STACK

> ok for kernel selftests to fail to compile if they aren't going to be able to
> run.
> 
> > Also:
> > #define PPC_ABIV2_MIN_STACK_SIZE 32
> > 
> > or just:
> > #define PPC_MIN_STACK	32
> > 
> > ... is helpful. And, you might want to base the rest of your code that 
> > use PUSH_BASIC_STACK() on that. If we ever want to have these tests run 
> > anywhere else, that'll help a lot. (See further below)
> > 
> 
> So I thought about it. I agree that it would be nice, I just worry that I might
> get rabbitholed, I can see it going further and then providing stack accessors
> to abstract out even PPC_MIN_STACK except in a bunch of macros, and that's when
> I know I've gone too far.
> 
> Perhaps I could look at adding this when I write more tests, I have grand plans
> to push way more tests.

Sure - just that if you ever intend to have these for ABIv1, it will be 
way easier to put together macros now rather than later.

- Naveen
