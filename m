Subject: Re: [PATCH] pmac_zilog.c: Fix break handling, add sysrq support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Harald Welte <laforge@gnumonks.org>
Cc: rmk+serial@arm.linux.org.uk,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040808112147.GA31341@obroa-skai.de.gnumonks.org>
References: <20040806104328.GL11638@sunbeam2>
	 <1091789077.5227.236.camel@gaston>
	 <20040808112147.GA31341@obroa-skai.de.gnumonks.org>
Content-Type: text/plain
Message-Id: <1092097456.14100.54.camel@gaston>
Mime-Version: 1.0
Date: Tue, 10 Aug 2004 10:24:17 +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
> Yes, I agree, that sounds way cleaner than just not lock at all in
> console_write().  But then of course you could still runt into a race
> condition where another thread is already spinning for the lock.  As
> soon as we drop the lock, the other thread would grab it... and when
> console_write() is called via handle_sysrq(), it's already too late,
> isn't it?

Ugh ? handle_sysrq() is called from irq, this should be an irqsafe
lock, another thread on another cpu would just cause us to wait a bit...

> I think this is a generic issue that all serial drivers supporting
> sysrq() face.  Instead of putting some special different solution into
> each driver, I'd say the code from sn_sal_console_write() needs to be
> generalized.
>
> Cc'ing the serial maintainer exactly for this reason.
>
> Russell, what is the preferred solution for this deadlock-prone
> situation?
>
> > I'll have a look, thanks much.
> > Ben.
--
Benjamin Herrenschmidt <benh@kernel.crashing.org>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
