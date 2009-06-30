Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 8EEC5B70BC
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Jun 2009 20:49:13 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C70BBDDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2009 20:49:12 +1000 (EST)
Subject: Re: Inline Assembly queries
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: kernel mailz <kernelmailz@googlemail.com>
In-Reply-To: <abe8a1fd0906292227p15fbfe34r595e80db780b77ca@mail.gmail.com>
References: <abe8a1fd0906271246q920124ard61422d9577e2d09@mail.gmail.com>
	<abe8a1fd0906271249k479e5a87gfe1ee9c02798a234@mail.gmail.com>
	<m3ab3t4623.fsf@google.com>
	<abe8a1fd0906272157j4246e9d3hec2e374535a22c89@mail.gmail.com>
	<abe8a1fd0906290849w1ba6bd33of60a9c2e110c10fd@mail.gmail.com>
	<20090629192722.GA12789@b07421-ec1.am.freescale.net>
	<abe8a1fd0906292227p15fbfe34r595e80db780b77ca@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 30 Jun 2009 20:41:03 +1000
Message-Id: <1246358463.31413.10.camel@pasglop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, gcc-help@gcc.gnu.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-06-30 at 10:57 +0530, kernel mailz wrote:
> Hi Scott,
> I agree with you, kind of understand that it is required.
> But buddy unless you see some construct work or by adding the
> construct a visible difference is there, the concept is just piece of
> theory.

In this case you'd rather get the theory right :-) The problem here is
that doing it wrong won't bite most of the time ... until for some
reason gcc decides to optimize things, for example by moving things
around, and kaboom ! But it may only happen in one out of 100 cases of
the same inline function depending on the surrounding code.

> I am trying all the kernel code inline assembly to find an example
> that works differently with memory.

Well, we recently had an example in the atomic64 code for 32-bit that
Paulus wrote, where we discovered we were missing the memory clobber in
local_irq_restore() iirc. On a base UP build, we did observe the load
and stores within the local_irq_save/restore section being moved to
outside of it by gcc.
 
> For instance take atomic_add , atomic_add_return, while the
> atomic_add_return has the "memory", atomic_add skips it.

There is a reason for the slightly different semantics here.

The base atomic ops such as atomic_add are defined as having no side
effects and to allow re-ordering. Thus atomic_add has an explicit
clobber of the actual variable that's incremented but nothing else and
no other memory barrier instruction.

The variants that -return- something, however, have been granted
stronger semantics, because they have been (ab)used to construct what
effectively is semaphores or locks by callers, and thus we added
stronger memory barriers to avoid re-ordering of loads and stores around
the atomic operation.

Cheers,
Ben.

> -TZ
> 
> On Tue, Jun 30, 2009 at 12:57 AM, Scott Wood<scottwood@freescale.com> wrote:
> > On Mon, Jun 29, 2009 at 09:19:57PM +0530, kernel mailz wrote:
> >> I tried a small example
> >>
> >> int *p = 0x1000;
> >> int a = *p;
> >> asm("sync":::"memory");
> >> a = *p;
> >>
> >> and
> >>
> >> volatile int *p = 0x1000;
> >> int a = *p;
> >> asm("sync");
> >> a = *p
> >>
> >> Got the same assembly.
> >> Which is right.
> >>
> >> So does it mean, if proper use of volatile is done, there is no need
> >> of "memory" ?
> >
> > No.  As I understand it, volatile concerns deletion of the asm statement
> > (if no outputs are used) and reordering with respect to other asm
> > statements (not sure whether GCC will actually do this), while the memory
> > clobber concerns optimization of non-asm loads/stores around the asm
> > statement.
> >
> >> static inline unsigned long
> >> __xchg_u32(volatile void *p, unsigned long val)
> >> {
> >>        unsigned long prev;
> >>
> >>        __asm__ __volatile__(
> >>
> >> "1:     lwarx   %0,0,%2 \n"
> >>
> >> "       stwcx.  %3,0,%2 \n\
> >>        bne-    1b"
> >>
> >>        : "=&r" (prev), "+m" (*(volatile unsigned int *)p)
> >>        : "r" (p), "r" (val)
> >> //        :"memory","cc");
> >>
> >>        return prev;
> >> }
> >> #define ADDR 0x1000
> >> int main()
> >> {
> >>        __xchg_u32((void*)ADDR, 0x2000);
> >>        __xchg_u32((void*)ADDR, 0x3000);
> >>
> >>        return 0;
> >>
> >> }
> >>
> >> Got the same asm, when compiled with O1 , with / without "memory" clobber
> >
> > This isn't a good test case, because there's nothing other than inline
> > asm going on in that function for GCC to optimize.  Plus, it's generally
> > not a good idea, when talking about what the compiler is or isn't allowed
> > to do, to point to a single test case (or even several) and say that it
> > isn't required because you don't notice a difference.  Even if there were
> > no code at all with which it made a difference with GCC version X, it
> > could make a difference with GCC version X+1.
> >
> > -Scott
> >
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
