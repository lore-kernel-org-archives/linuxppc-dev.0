Date: Fri, 7 Dec 2001 15:23:02 -0700
From: Kevin Buettner <kevinb@redhat.com>
Message-Id: <1011207222302.ZM10835@ocotillo.lan>
In-Reply-To: Kumar Gala <kumar.gala@motorola.com>
        "AltiVec register ptrace support" (Dec  7,  2:57pm)
References: <Pine.GSO.4.40.0112071443310.2903-300000@softail.somerset.sps.mot.com>
To: Kumar Gala <kumar.gala@motorola.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: AltiVec register ptrace support
Cc: gdb@sources.redhat.com, <dmj+@andrew.cmu.edu>,
	<ezannoni@cygnus.com>, <fsirl@kernel.crashing.org>, paulus@samba.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Dec 7,  2:57pm, Kumar Gala wrote:

> I have two different patches to the ptrace mechanism to add support
> for AltiVec registers.
>
> linux-2.4.8-altivec-ptrace.patch:  Adds support similar to existing
> mechanisms to get/set registers via PEEK/POKE calls extending the FPU
> model.
>
> linux-2.4.16-altivec-ptrace.patch: Adds support for new ptrace commands
> that match sparc/x86 PTRACE_{GET,SET}*REGS.  These dump the full register
> state in a single call.
>
> Personally, I would like to see the PTRACE_{GET,SET}*REGS method adopted
> for 2.4.x.  RedHat is trying to push out some GDB changes for AltiVec that
> require closure on this matter.

I would like to better understand your reasons for preferring
PTRACE_{GET,SET}*REGS.  Is it just because that's what x86 does
or do you think that this mechanism improves GDB's performance?

My personal opinion is that GETREGS/SETREGS does not greatly enhance
performance.  Try running strace on gdb debugging itself on x86 and on
PPC and compare the number of PTRACE_PEEKUSR calls on PPC vs.
PTRACE_????  calls on x86.  (The ????  is printed because strace
doesn't know about the various PTRACE_{GET,SET}*REGS calls.) When I
tried it just a moment ago using gdb to debug itself and running to a
breakpoint set on main(), I saw _more_ PTRACE_???? calls on x86 than
PEEKUSR/POKUSR calls on PPC.  Now, I admit that my testing wasn't very
exhaustive, but even if the number of PEEKUSR/POKEUSR calls were
higher, I think you'd find that calls to PEEKTEXT (for prologue
analysis) would dominate.  I.e, the majority of the ptrace() traffic
is due to reading memory, not reading registers.

Furthermore, I think that introducing GETREGS/SETREGS will make
ppc-linux-nat.c (in the GDB sources) more complicated.  We'll need
compile time tests to check for the presence of GETREGS/SETREGS and
use these mechanisms if they exist.  If they don't, this code will
have to fall back to using the old PEEKUSR/POKEUSR mechanism.  Also,
it may be necessary to have runtime tests which attempt to use
GETREGS/SETREGS and fall back to using PEEKUSR/POKEUSR.  In order to
see just how messy it can get, take a look at i386-linux-nat.c.

For the reasons stated above, I prefer your PEEKUSR/POKEUSR patch.

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
