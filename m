Return-Path: <mgalassi@c-cor.com>
Received: from penguin.ncube.com (penguin.ncube.com [134.242.67.78])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B979E67C18
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Dec 2006 10:14:58 +1100 (EST)
Message-Id: <200612062314.kB6NE8iQ083398@penguin.ncube.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: shared config registers and locking 
In-reply-to: <1165445865.5469.130.camel@localhost.localdomain> 
References: <1165381847.5469.70.camel@localhost.localdomain>
	<200612062257.45153.roger.larsson@norran.net>
	<1165445865.5469.130.camel@localhost.localdomain>
Date: Wed, 06 Dec 2006 15:14:08 -0800
From: Michael Galassi <mgalassi@c-cor.com>
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

>Now, more seriously, of course the thing will boil down to a spinlock.
>My point was what do you guys think about having one shared spinlock
>exposed by the powerpc platform code for use by all those little bits
>here or there that whack global configuration registers like clock
>control things, etc... that we have all over the place on embedded
>processors.

GACK!  Many better engineers than any of us have spent countless hours
breaking down locks.  A lock takes nearly no space at all, you're not
proposing to lock any less often, so multiple locks take no less time,
the only thing you stand to gain by protecting multiple data structures
with one lock is the possibility of lock contention.  Please reconsider.

I can envision situations in which you might want to have a lock
protecting more than one item in code which is local to your project,
company, group, whatever, feel free to do do so in that circumstance
but limit this practice to individual, carefully thought out, *LOCAL*
situations, don't allow that to propagate.  Please?  Pretty please?

>Since I don't like exposing a naked data structure though, rather than
>exposing the spinlock itself, I was proposing to expose an API of two
>functions (just in case we want to do something fancy) though they could
>well end up being inline and thus boil down to the same...

Linux needs another api just as much as we need another war in the
middle east or a third term of our commander in chief.  Just say no.

It turns out that any place you have any business manipulating a lock
associated with some data you're probably doing so in preparation to
manipulate that data.  By using a simple, well known interface such as
spin_lock_irqsave/spin_unlock_irqrestore you are actually making clear
what your code is doing, you are alerting the reader that you've
considered locking issues.  This is a good thing.

-michael
