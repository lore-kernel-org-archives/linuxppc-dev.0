Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 885AFB71AE
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 07:52:20 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1D137DDDA0
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 07:52:18 +1000 (EST)
Subject: Re: [PATCH] RFC: powerpc: expose the multi-bit ops that underlie
	single-bit ops.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geoff Thorpe <Geoff.Thorpe@freescale.com>
In-Reply-To: <4A37AC09.1020200@freescale.com>
References: <1243361946-6771-1-git-send-email-Geoff.Thorpe@freescale.com>
	<1245124418.12400.67.camel@pasglop>  <4A37AC09.1020200@freescale.com>
Content-Type: text/plain
Date: Wed, 17 Jun 2009 07:33:46 +1000
Message-Id: <1245188026.14036.17.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-06-16 at 10:28 -0400, Geoff Thorpe wrote:

> > Hi ! Sorry for the delay, that was on my "have a look one of these days,
> > low priority" list for a bit too long :-)
> 
> NP, optimal throughput often requires a compromise in latency :-)

Hehehe, so true :-)
 
> > I'm not sure it's useful to provide a multi-bit variant of the
> > "lock" and "unlock" primitives. Do other archs do ?
> 
> For clear_bit_unlock(), no they don't appear to. There is a fallback in
> include/asm-generic though, and I notice that it's used in a few places,
> eg. drivers/rtc/rtc-dev. OTOH some other archs appear to provide their
> own test_and_set_bit_lock(), and there's a fallback in
> includes/asm-generic for that too.
> 
> Do you see a reason to isolate either of these and not factor out the
> inner word-based logic?

Don't bother, especially if we are using a macro to generate them, we
may as well make them all look the same.

 .../...

> Yup, believe it or not, I saw this coming but didn't have the guts to
> try proposing something like it up-front (in particular, I was wary of
> botching some subtleties in the assembly).

Fair enough :-)

> > Maybe we can shrink that file significantly (and avoid the risk for
> > typos etc...) by generating them all from a macro.
> > 
> > Something like (typed directly into the mailer :-)
> > 
> > #define DEFINE_BITOP(op, prefix, postfix) \
> > 	asm volatile (			  \
> > 	prefix				  \
> > "1:"    PPC_LLARX "%0,0,%3\n"		  \
> > 	__stringify(op) "%1,%0,%2\n"	  \
> > 	PPC405_ERR77(0,%3)		  \
> > 	PPC_STLCX "%1,0,%3\n"		  \
> > 	"bne- 1b\n"			  \
> > 	postfix				  \
> > 	 : "=&r" (old), "=&r" (t)
> > 	 : "r" (mask), "r" (p)
> > 	 : "cc", "memory")
> > 
> > and so:
> > 
> > static inline void set_bits(unsigned long mask, volatile unsigned long *addr)
> > {
> > 	unsigned long old, t;
> > 
> > 	DEFINE_BITOP(or, "", "");
> > }
> > 
> > static inline void test_and_set_bits(unsigned long mask, volatile unsigned long *addr)
> > {
> > 	unsigned long old, t;
> > 
> > 	DEFINE_BITOP(or, LWSYNC_ON_SMP, ISYNC_ON_SMP);
> > 
> > 	return (old & mask) != 0;
> > }
> > 
> > etc...
> 
> 
> Sounds good, I'll try working this up and I'll send a new patch shortly.

You can also go totally mad and generate the whole function (both -s and
non -s variants) from one macro but I wouldn't go that far :-)

> So can I assume implicitly that changing the set_bits() function to add
> the 'volatile' qualifier to the prototype (and the missing
> PPC405_ERR77() workaround) was OK?

The PPC405_ERR77 workaround is definitely needed. The volatile, well, I
suspect it's useless, but it will remove warnings when callers call
these on something that is declared as volatile in the first place.

Do x86 use volatile there ? If not, then don't do it on powerpc neither,
it could well be an historical remain. It's not functionally useful, the
"memory" clobber in the asm takes care of telling the compiler not to
mess around I believe.

> Also - any opinion on whether the same re-factoring of the asm-generic
> versions should be undertaken? I'm not looking to bite off more than I
> can chew, but I don't know if it's frowned upon to make powerpc-only
> extensions to the API. And if you think an asm-generic patch makes
> sense, could that be taken via linuxppc-dev too or does it need to go
> elsewhere?

I'm not people care -that- much :-) You can always try and post it to
lkml (maybe linux-arch too) and see what comes back... but let's finish
the powerpc variant first :-)

Cheers,
Ben.
