From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15228.44957.167444.619604@cargo.ozlabs.ibm.com>
Date: Fri, 17 Aug 2001 15:46:05 +1000 (EST)
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org,
	linuxppc-commit@source.mvista.com
Subject: Re: Incoming to hostme.bitkeeper.com:/ua/repos/p/ppc/linuxppc_2_4
In-Reply-To: <20010816103216.H26735@cpe-24-221-152-185.az.sprintbbd.net>
References: <20010816172318.F1E97FE57@hostme.bitkeeper.com>
	<20010816103216.H26735@cpe-24-221-152-185.az.sprintbbd.net>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini writes:

> > ChangeSet@1.272, 2001-08-16 10:22:52-07:00, trini@opus.bloom.county
> >   More minor changes to let !CONFIG_6xx compile again, arg!  Who
> >   knew the _{set,get}_L2CR bits were so heavily embedded? :)
>
> Okay.  What I'm about to do in 2_4_devel, is try and rip these out a bit
> more cleanly.  Right now, outside of platform-specific files, kernel/sysctl.c

Hmmm.  I think this is a situation where you need to realize that
you're digging yourself into a hole, stop, sit back and think about it
a bit more.

You're wanting to remove code that isn't used on particular
platforms.  That's fine.  But then you get tripped up in all the
places where that code could be called.  You are solving that by
adding #ifdefs everywhere, which is the wrong answer.

The right answer is instead to make it look like the code is there
even when it isn't.  One reasonable approach would be to put something
like this in asm-ppc/system.h:

#ifdef CONFIG_6xx
extern unsigned int _get_L2CR();
extern void _set_L2CR(unsigned int);
#else
#define _get_L2CR()	0
#define _set_L2CR(x)	do { } while (0)
#endif

and now you can call _get/set_L2CR quite safely anywhere without any
ifdefs.

> can make use of L2CR stuffs.  Since we now have a change pending to Linus,
> I want to make this file only care about proc_dol2crvec on CONFIG_6xx,
> and likewise only compile in ppc_htab.c on CONFIG_6xx as well.  Right

As for /proc/ppc_htab, that is useful (despite its name) on systems
that don't use a hash table - there it gives info about TLB misses
IIRC.  It is also useful on power3/4 as well as 6xx.

> now proc_dol2crvec -EFAULT's on CPUs which don't have the feature, so
> this shouldn't be an issue any more (iirc, some other stats had been
> thrown in now and again by other cpu-types).  Do this will also let us
> remove the !8xx && !4xx test in ppc_htab_read.  Does this sound good to
> everyone?

Nope. :)  It could have a better name, though.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
