Date: Sun, 8 Aug 2004 13:21:47 +0200
From: Harald Welte <laforge@gnumonks.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: rmk+serial@arm.linux.org.uk,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [PATCH] pmac_zilog.c: Fix break handling, add sysrq support
Message-ID: <20040808112147.GA31341@obroa-skai.de.gnumonks.org>
References: <20040806104328.GL11638@sunbeam2> <1091789077.5227.236.camel@gaston>
Mime-Version: 1.0
In-Reply-To: <1091789077.5227.236.camel@gaston>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Aug 06, 2004 at 08:44:38PM +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2004-08-06 at 20:43, Harald Welte wrote:
> > This patch fixes the BREAK handling in pmac_zilog.c, and also adds
> > support for SYSRQ via BREAK.
> >
> > Please note that I had to remove locking in pmz_consolw_write(),
> > since it is called from handle_sysrq(), which is in turn called from
> > pmz_receive_chars(), which is called from with the lock held...
> >
> > while trying to find out how other drivers handle this problem, I
> > found out that sn_sal_console_write() has some elaborate code that
> > tries to steal the lock, etc.
>
> I noticed some locking bugs in other drivers too... it may be better
> to drop the lock when calling handle_sysrq, no ?

Yes, I agree, that sounds way cleaner than just not lock at all in
console_write().  But then of course you could still runt into a race
condition where another thread is already spinning for the lock.  As
soon as we drop the lock, the other thread would grab it... and when
console_write() is called via handle_sysrq(), it's already too late,
isn't it?

I think this is a generic issue that all serial drivers supporting
sysrq() face.  Instead of putting some special different solution into
each driver, I'd say the code from sn_sal_console_write() needs to be
generalized.

Cc'ing the serial maintainer exactly for this reason.

Russell, what is the preferred solution for this deadlock-prone
situation?

> I'll have a look, thanks much.
> Ben.
--
- Harald Welte <laforge@gnumonks.org>               http://www.gnumonks.org/
============================================================================
Programming is like sex: One mistake and you have to support it your lifetime

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
