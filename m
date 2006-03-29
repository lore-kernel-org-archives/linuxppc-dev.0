Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C08A8679E6
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Mar 2006 15:21:22 +1100 (EST)
Subject: Re: [OT] ppc64 serialization problem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg Smith <gsmith@nc.rr.com>
In-Reply-To: <1143605294.3075.87.camel@localhost.localdomain>
References: <1143597506.3075.53.camel@localhost.localdomain>
	<1143601903.3585.2.camel@localhost.localdomain>
	<1143605294.3075.87.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 29 Mar 2006 15:21:01 +1100
Message-Id: <1143606061.3585.9.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-03-28 at 23:08 -0500, Greg Smith wrote:
> Very fair questions!!
> 
> Actually the code was
> 
>     pthread_mutex_lock(&lock);
>     u32 |= bitB;
>     TRACE("A", u32, ...);
>     TRACE("B", u32, ...);
>     pthread_mutex_unlock(&lock);
> 
> where TRACE is a function call (entering a trace entry to an in-storage
> wrap-around table).  So for the "A" call, u32 could have come directly
> from a register and for "B" from the storage location.  I'll have the
> user (actually a fellow developer) send me the assembly listing to make
> sure.

Could you try to make a small program that reproduces the problem
instead ?

> He has tested SLES9 (kernel 2.6.5, glibc 2.3.3, gcc 3.3.3) and Debian
> (kernel 2.6.16, glibc 2.3.6, gcc 4.0.3).
> 
> The TRACE occurs while the lock is held.
> 
> Now the interesting part.
> 
> I suggested he try u64 instead of u32.  That works!!
> 
> He is suspecting a recent firmware upgrade may have something to do with
> the problem.

I doubt it, but I need more informations.

> Thank you,
> Greg Smith
> 
> On Wed, 2006-03-29 at 14:11 +1100, Benjamin Herrenschmidt wrote:
> > On Tue, 2006-03-28 at 20:58 -0500, Greg Smith wrote:
> > > We have a multi-threaded app running on a p520 in 64 bit mode.
> > > 
> > > Thread A does
> > > 
> > > pthread_mutex_lock(&lock);
> > > u32 &= ~bitA;
> > > pthread_mutex_unlock(&lock);
> > > 
> > > and Thread B does
> > > 
> > > pthread_mutex_lock(&lock);
> > > u32 |= bitB;
> > > A = u32;
> > > B = u32;
> > > pthread_mutex_unlock(&lock);
> > > 
> > > On rare occasions, values A and B will differ!  In the examples that I
> > > have seen, there is contention with `lock'.  This phenomenon does not
> > > occur on ppc32 or a number of other architectures that we support.
> > 
> > How did you actually "look" at A and B ? is that also protected by the
> > lock ?
> > 
> > > I confess I do not know the linux version nor the glibc version nor what
> > > pthreads implementation is being used.  I'll find that out shortly.
> > 
> > That's fairly important to know those yes.
> > 
> > > What I am curious about is where the problem might lie
> > > (kernel/lib/pthreads/app) so I can ask the right people.
> > > 
> > > Thank you for your patience,
> > > Greg Smith
> 
