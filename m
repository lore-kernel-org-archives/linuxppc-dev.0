Date: Thu, 27 Feb 2003 08:44:46 -0600 (CST)
From: Rudy Klinksiek <klink@arlut.utexas.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: "Illegal instruction" traps on smp clients - 2.4.19
Message-ID: <Pine.SOL.4.05.10302270842190.3567-100000@mamba.arlut.utexas.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello:
	This is a message that was posted last week on linux-smp.
	No responses, so I'm rewriting/reposting here.

	Our configuration uses Linux 2.4.19, from Synergy ( derived
	from YellowDog version 2.1). We have several boards
	configd in a server/client relationship. These boards
	contain either 2 or 4 G4 Altived ppc processors.  The
	server has an attached disk, clients are diskless, mounting
	their  root file system over nfs.

	I am seeing frequent "Illegal instruction" traps on clients
	that run an smp kernel.  Other symptoms include failure of
	various daemons	during startup ( syslogd, crond, sshd, etc ).
	Symptoms also occur during rsh/rlogin usage.

	Running a UP kernel on clients works just fine.

	Smp and UP kernels work fine on the "server".

	Has anyone else seen this type of problem or something similar?

        This appears to me to be an smp problem.

	A fix relating to page table/tlb invalidation ordering
	was detailed by Sunil Saxena at
	http://www.cs.helsinki.fi/linux/linux-kernel/2002-20/0756.html
	for the x86 architecture, and these mods seem to have made it
	into 2.4.18 .  The ppc arch was not addressed.  Also have
	noticed this problem being addressed starting in 2.5.16 .

	Its not really practical for me to use 2.5.xx at this point.

	I am hoping that someone familiar with this code and the
	ppc architecture can verify that this is indeed a problem
	for 2.4.19.

	And then, what can I do about it?  I'm willing to try things
	as my time permits.  I have looked at 2.5.60 memory.c/mmap.c
	and related functions, and trying to port the new methods
	back to 2.4.19 seems to be a rather daunting task.

        Comments, suggestions?

        My background involves writing device drivers for VMS,
	Solaris,  and now Linux.

        Any assistance or guidance would be appreciated

	Thanks
	klink


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
