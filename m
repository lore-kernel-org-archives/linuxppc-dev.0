Date: Wed, 15 Dec 1999 13:37:22 +0100
From: Thorsten Kukuk <kukuk@suse.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: new RLIM_INFINITY and binary compatiblity
Message-ID: <19991215133722.A16123@allen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Hi,

In the current kernels, RLIM_INFINITY has changed from signed long
to unsigned long. In the moment this is not the big problem, because
glibc has it's own definition of RLIM_INFINITY.

Now Uli Drepper has made this changes to glibc, too. The problem:
binaries, which are compiled with the new, bigger RLIM_INFINITY
doesn't work correct on old kernels.
My question is: What is planed for the PowerPC port ?

There are 3 possible solutions:
1. The problem will be ignored, and the people have to use a new
   kernel if glibc 2.1.3/2.2 is available (This is the current
   solution for SPARC64)

2. The RLIM_INFINITY will be changed back to the old value
   (This is the solution for ALPHA)

3. linuxppc becomes also the ugetrlimit syscall like Intel has.

I don't know what is planned for the PPC linux kernel, all 3
solutions are possible and easy to solve for me with glibc.
I would prefer 3, because then we have the SUS compatible
RLIM_INFINITY.

Comments ? I would like to fix the current glibc snapshots, so they
build again on other Platforms then Intel (In the moment it could
only be build on Intel correct). So I need an answer.

  Thorsten

-- 
Thorsten Kukuk       http://www.suse.de/~kukuk/       kukuk@suse.de
SuSE GmbH            Schanzaeckerstr. 10            90443 Nuernberg
Linux is like a Vorlon.  It is incredibly powerful, gives terse,
cryptic answers and has a lot of things going on in the background.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
