From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15224.38931.44226.806453@cargo.ozlabs.ibm.com>
Date: Tue, 14 Aug 2001 13:16:35 +1000 (EST)
To: Edward Swarthout <swarthou@ibmoto.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: assorted kernel patches
In-Reply-To: <200108131910.f7DJAAd09710@pacific.somerset.sps.mot.com>
References: <200108131910.f7DJAAd09710@pacific.somerset.sps.mot.com>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Edward Swarthout writes:

> There are a small set of patches that we think would be useful to
> merge back into linuxppc_2_4_devel.  What is the procedure to discuss
> these changes, get them reviewed, and merged (if so desired)?

Well the primary thing is to make the actual patches available to us;
post them to the list or post a URL or something.  Since I am the
maintainer you need to persuade me that the patches are interesting
and useful and won't break anything too badly. :)

> 1. Support for hardware breakpoints for process threads.

A good idea in general although I will be interested to see how this
interacts with xmon's and kgdb's use of iabr/dabr.

>    - Add iabr and dabr to the end of the pt_regs structure.

Why save them there rather than in the thread_struct?  Do you change
them on every kernel entry from userspace?

>    - add IABR and DABR register numbers for ptrace

Is this so that gdb can change them?

> 2. Allow superviser (MSR[PR]=0) user threads.

Hmmm, you'll need to explain exactly why this is a good idea and why
it won't break anything.  Without a good strong argument I would be
inclined to reject this.  I don't see what you can do with a "user"
thread running in supervisor mode that you can't do with a kernel
module.

>    indicate this.  A good alternative is MSR[RI].

Huh?  Why is RI good?

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
