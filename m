Date: Fri, 17 Aug 2001 07:47:26 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.linuxppc.org,
	linuxppc-commit@source.mvista.com
Subject: Re: Incoming to hostme.bitkeeper.com:/ua/repos/p/ppc/linuxppc_2_4
Message-ID: <20010817074726.C556@cpe-24-221-152-185.az.sprintbbd.net>
References: <20010816172318.F1E97FE57@hostme.bitkeeper.com> <20010816103216.H26735@cpe-24-221-152-185.az.sprintbbd.net> <15228.44957.167444.619604@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <15228.44957.167444.619604@cargo.ozlabs.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Aug 17, 2001 at 03:46:05PM +1000, Paul Mackerras wrote:
> Tom Rini writes:
>
> > > ChangeSet@1.272, 2001-08-16 10:22:52-07:00, trini@opus.bloom.county
> > >   More minor changes to let !CONFIG_6xx compile again, arg!  Who
> > >   knew the _{set,get}_L2CR bits were so heavily embedded? :)
> >
> > Okay.  What I'm about to do in 2_4_devel, is try and rip these out a bit
> > more cleanly.  Right now, outside of platform-specific files, kernel/sysctl.c
>
> Hmmm.  I think this is a situation where you need to realize that
> you're digging yourself into a hole, stop, sit back and think about it
> a bit more.

Well, alright.

> You're wanting to remove code that isn't used on particular
> platforms.  That's fine.  But then you get tripped up in all the
> places where that code could be called.  You are solving that by
> adding #ifdefs everywhere, which is the wrong answer.

Well, I've been trying to remove 'em actually.  What I ended up pushing
added 1 more #ifdef/#endif and removed 2 older ones from ppc_htab.c

> > can make use of L2CR stuffs.  Since we now have a change pending to Linus,
> > I want to make this file only care about proc_dol2crvec on CONFIG_6xx,
> > and likewise only compile in ppc_htab.c on CONFIG_6xx as well.  Right
>
> As for /proc/ppc_htab, that is useful (despite its name) on systems
> that don't use a hash table - there it gives info about TLB misses
> IIRC.  It is also useful on power3/4 as well as 6xx.

Well, if I'm reading the htab code right, we -EFAULT on on !750/74xx.
I could be misinterpreting something, but I don't see it printing out
anything that isn't hashtable related.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
