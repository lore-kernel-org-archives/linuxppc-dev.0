Date: Thu, 16 Aug 2001 10:32:16 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc-dev@lists.linuxppc.org
Cc: linuxppc-commit@source.mvista.com
Subject: Re: Incoming to hostme.bitkeeper.com:/ua/repos/p/ppc/linuxppc_2_4
Message-ID: <20010816103216.H26735@cpe-24-221-152-185.az.sprintbbd.net>
References: <20010816172318.F1E97FE57@hostme.bitkeeper.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010816172318.F1E97FE57@hostme.bitkeeper.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Aug 16, 2001 at 10:23:18AM -0700, ppc@bitkeeper.com wrote:

> ChangeSet@1.272, 2001-08-16 10:22:52-07:00, trini@opus.bloom.county
>   More minor changes to let !CONFIG_6xx compile again, arg!  Who
>   knew the _{set,get}_L2CR bits were so heavily embedded? :)

Okay.  What I'm about to do in 2_4_devel, is try and rip these out a bit
more cleanly.  Right now, outside of platform-specific files, kernel/sysctl.c
can make use of L2CR stuffs.  Since we now have a change pending to Linus,
I want to make this file only care about proc_dol2crvec on CONFIG_6xx,
and likewise only compile in ppc_htab.c on CONFIG_6xx as well.  Right
now proc_dol2crvec -EFAULT's on CPUs which don't have the feature, so
this shouldn't be an issue any more (iirc, some other stats had been
thrown in now and again by other cpu-types).  Do this will also let us
remove the !8xx && !4xx test in ppc_htab_read.  Does this sound good to
everyone?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
