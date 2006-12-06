Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 296A467C59
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Dec 2006 09:57:55 +1100 (EST)
Subject: Re: shared config registers and locking
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Roger Larsson <roger.larsson@norran.net>
In-Reply-To: <200612062257.45153.roger.larsson@norran.net>
References: <1165381847.5469.70.camel@localhost.localdomain>
	<200612062257.45153.roger.larsson@norran.net>
Content-Type: text/plain
Date: Thu, 07 Dec 2006 09:57:45 +1100
Message-Id: <1165445865.5469.130.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 2006-12-06 at 22:57 +0100, Roger Larsson wrote:
> On Wednesday 06 December 2006 06:10, Benjamin Herrenschmidt wrote:
> >
> > On UP configuration, there is no real problem: local_irq_disable/enable
> > around the code tweaking those bits (read/modify/write) is enough and
> > everybody is happy. That's what the current emac code does.
> >
> > However, on SMP, we need spinlocking (or a semaphore, but for simple
> > register accesses like that, spinlocks are probably better).
> >
> It is actually simple.
> 
> You should use
> spin_lock_irq_save()

Thanks you very much for telling me about spinlocks ... I wonder how I
did all these years ... :-)

Now, more seriously, of course the thing will boil down to a spinlock.
My point was what do you guys think about having one shared spinlock
exposed by the powerpc platform code for use by all those little bits
here or there that whack global configuration registers like clock
control things, etc... that we have all over the place on embedded
processors.

Since I don't like exposing a naked data structure though, rather than
exposing the spinlock itself, I was proposing to expose an API of two
functions (just in case we want to do something fancy) though they could
well end up being inline and thus boil down to the same...

Ben.
