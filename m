Return-Path: <srs0=qsk2=3o=arm.com=will.deacon@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vzPnt2vd1zDqHJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 00:13:38 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vzPnt29Hzz8stc
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 00:13:38 +1000 (AEST)
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by ozlabs.org (Postfix) with ESMTP id 3vzPnt0P2Yz9s9Y
 for <linuxppc-dev@ozlabs.org>; Fri,  7 Apr 2017 00:13:37 +1000 (AEST)
Date: Thu, 6 Apr 2017 15:13:53 +0100
From: Will Deacon <will.deacon@arm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: David Miller <davem@davemloft.net>, torvalds@linux-foundation.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 anton@samba.org, linuxppc-dev@ozlabs.org, peterz@infradead.org
Subject: Re: [RFC][PATCH] spin loop arch primitives for busy waiting
Message-ID: <20170406141352.GF18204@arm.com>
References: <20170404095001.664718b8@roar.ozlabs.ibm.com>
 <CA+55aFzdUMZHzXtn9PyhJg7GjYNQ5fy6=LzBNJx==Ab=U=YYjw@mail.gmail.com>
 <20170404130233.1f45115b@roar.ozlabs.ibm.com>
 <20170405.070157.871721909352646302.davem@davemloft.net>
 <20170406105958.196c6977@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170406105958.196c6977@roar.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Nick,

On Thu, Apr 06, 2017 at 10:59:58AM +1000, Nicholas Piggin wrote:
> On Wed, 05 Apr 2017 07:01:57 -0700 (PDT)
> David Miller <davem@davemloft.net> wrote:
> 
> > From: Nicholas Piggin <npiggin@gmail.com>
> > Date: Tue, 4 Apr 2017 13:02:33 +1000
> > 
> > > On Mon, 3 Apr 2017 17:43:05 -0700
> > > Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > >   
> > >> But that depends on architectures having some pattern that we *can*
> > >> abstract. Would some "begin/in-loop/end" pattern like the above be
> > >> sufficient?  
> > > 
> > > Yes. begin/in/end would be sufficient for powerpc SMT priority, and
> > > for x86, and it looks like sparc64 too. So we could do that if you
> > > prefer.  
> > 
> > Sparc64 has two cases, on older chips we can induce a cpu thread yield
> > with a special sequence of instructions, and on newer chips we have
> > a bonafide pause instruction.
> > 
> > So cpu_relax() all by itself pretty much works for us.
> > 
> 
> Thanks for taking a look. The default spin primitives should just
> continue to do the right thing for you in that case.
> 
> Arm has a yield instruction, ia64 has a pause... No unusual
> requirements that I can see.

Yield tends to be implemented as a NOP in practice, since it's in the
architecture for SMT CPUs and most ARM CPUs are single-threaded. We do have
the WFE instruction (wait for event) which is used in our implementation of
smp_cond_load_acquire, but I don't think we'd be able to use it with the
proposals here.

WFE can stop the clock for the CPU until an "event" is signalled by
another CPU. This could be done by an explicit SEV (send event) instruction,
but that tends to require heavy barriers on the signalling side. Instead,
the preferred way to generate an event is to clear the exclusive monitor
reservation for the CPU executing the WFE. That means that the waiter
does something like:

	LDXR x0, [some_address]	// Load exclusive from some_address
	CMP  x0, some value	// If the value matches what I want
	B.EQ out		// then we're done
	WFE			// otherwise, wait

at this point, the waiter will stop on the WFE until its monitor is cleared,
which happens if another CPU writes to some_address.

We've wrapped this up in the arm64 code as __cmpwait, and we use that
to build smp_cond_load_acquire. It would be nice to use the same machinery
for the conditional spinning here, unless you anticipate that we're only
going to be spinning for a handful of iterations anyway?

Cheers,

Will
