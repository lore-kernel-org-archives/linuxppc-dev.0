From: "David Bryan" <Dave@ThePTRGroup.com>
To: "Rudy Klinksiek" <klink@arlut.utexas.edu>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: RE: "Illegal instruction" traps on smp clients - 2.4.19
Date: Thu, 27 Feb 2003 11:37:06 -0500
Message-ID: <NEBBLKDMGLOGOAOIDAIDOELPEHAA.Dave@ThePTRGroup.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <Pine.SOL.4.05.10302270842190.3567-100000@mamba.arlut.utexas.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Rudy,

We saw problems like this about a year ago when running SMP on dual PPC7400
boards.

There is a I/O signal called SHD between the processors in a multiprocessing
system.  This signal is used to indicate when a reservation is held on an
address.  The lwarx/stcwx instruction pair uses reservations to guarantee
atomicity in SMP systems.  (The lwarx/stcwx instructions are used
extensively in the kernel, particularly in the spinlock routines). To enable
use of the SHD signal, the 7400 has to either be in MESI mode or in MEI mode
with the SHD explicitly enabled.  These modes are controlled by two bits in
the Memory subsystem control register (MSSCR0).  At reset, the MSSCR0
defaults to MEI mode with the SHD signal disabled.  By placing the 7400 in
MESI mode at boot, we solved the problem.

Hope this helps,

Dave
----------------------------------------------
     T h e   P T R   G r o u p,   I n c.
----------------------------------------------
       ->->->->  ->->->->->   ->->->->
             ->     ->               ->
     ->->->->      ->       ->->->->
    ->            ->       ->      ->
   ->            ->       ->       ->
----------------------------------------------
 Embedded, Real-Time Solutions, and Training

David Bryan                www.ThePTRGroup.com
----------------------------------------------



-----Original Message-----
From: owner-linuxppc-dev@lists.linuxppc.org
[mailto:owner-linuxppc-dev@lists.linuxppc.org]On Behalf Of Rudy
Klinksiek
Sent: Thursday, February 27, 2003 9:45 AM
To: linuxppc-dev@lists.linuxppc.org
Subject: "Illegal instruction" traps on smp clients - 2.4.19



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
