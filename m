Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x230.google.com (mail-pf0-x230.google.com
 [IPv6:2607:f8b0:400e:c00::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sbFk10rDhzDsbP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 22:59:52 +1000 (AEST)
Received: by mail-pf0-x230.google.com with SMTP id z123so27325818pfz.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 05:59:52 -0700 (PDT)
Date: Fri, 16 Sep 2016 22:59:42 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: David Laight <David.Laight@ACULAB.COM>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH][RFC] Implement arch primitives for busywait loops
Message-ID: <20160916225942.449e6e04@roar.ozlabs.ibm.com>
In-Reply-To: <20160916220635.7e6fdbb7@roar.ozlabs.ibm.com>
References: <20160916085736.7857-1-npiggin@gmail.com>
 <063D6719AE5E284EB5DD2968C1650D6DB00FF7D8@AcuExch.aculab.com>
 <20160916215200.2775f252@roar.ozlabs.ibm.com>
 <063D6719AE5E284EB5DD2968C1650D6DB00FF831@AcuExch.aculab.com>
 <20160916220635.7e6fdbb7@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 16 Sep 2016 22:06:35 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> On Fri, 16 Sep 2016 11:57:37 +0000
> David Laight <David.Laight@ACULAB.COM> wrote:
> 
> > From: Nicholas Piggin  
> > > Sent: 16 September 2016 12:52
> > > On Fri, 16 Sep 2016 11:30:58 +0000
> > > David Laight <David.Laight@ACULAB.COM> wrote:
> > >     
> > > > From: Nicholas Piggin    
> > > > > Sent: 16 September 2016 09:58
> > > > > Implementing busy wait loops with cpu_relax() in callers poses
> > > > > some difficulties for powerpc.
> > > > >
> > > > > First, we want to put our SMT thread into a low priority mode for the
> > > > > duration of the loop, but then return to normal priority after exiting
> > > > > the loop.  Dependong on the CPU design, 'HMT_low() ; HMT_medium();' as
> > > > > cpu_relax() does may have HMT_medium take effect before HMT_low made
> > > > > any (or much) difference.
> > > > >
> > > > > Second, it can be beneficial for some implementations to spin on the
> > > > > exit condition with a statically predicted-not-taken branch (i.e.,
> > > > > always predict the loop will exit).
> > > > >
> > > > > This is a quick RFC with a couple of users converted to see what
> > > > > people think. I don't use a C branch with hints, because we don't want
> > > > > the compiler moving the loop body out of line, which makes it a bit
> > > > > messy unfortunately. If there's a better way to do it, I'm all ears.    
> > > >
> > > > I think it will still all go wrong if the conditional isn't trivial.
> > > > In particular if the condition contains || or && it is likely to
> > > > have a branch - which could invert the loop.    
> > > 
> > > I don't know that it will.
> > > 
> > > Yes, if we have exit condition that requires more branches in order to
> > > be computed then we lose our nice property of never taking a branch
> > > miss on loop exit. But we still avoid *this* branch miss, and still
> > > prevent multiple iterations of the wait loop being speculatively
> > > executed concurrently when there's no work to be done.
> > > 
> > > And C doesn't know about the loop, so it can't do any transformation
> > > except to compute the final condition.
> > > 
> > > Or have I missed something?    
> > 
> > Try putting the code inside a conditional or at the bottom of a loop.
> > gcc can replicate code to remove a branch.
> > 
> > So:
> > 	for (;;) {
> > 		a;
> > 		if (b)
> > 			c;
> > 		d;
> > 	}  
> 
> That's not what this patch does though. The loop is purely asm. gcc has
> no idea about it. Only thing gcc knows is to evaluate the condition and
> put it in a register.


Oh you're right course -- can't branch to random location. Sorry, I didn't
know what you meant at first. It does need to use asm goto I guess.

Thanks,
Nick
