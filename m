Date: Wed, 27 Oct 1999 22:00:00 -0700
From: Kevin Buettner <kev@primenet.com>
Message-Id: <991028045959.ZM28466@saguaro.lan>
In-Reply-To: Kumar Gala <kumar@chaos.ph.utexas.edu>
        "ptrace" (Oct 27,  1:31pm)
References: <Pine.LNX.4.10.9910271325190.17521-100000@chaos.ph.utexas.edu>
To: Kumar Gala <kumar@chaos.ph.utexas.edu>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: ptrace
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Oct 27,  1:31pm, Kumar Gala wrote:

> Does anyone know why ptrace will only read and write a word at a time.  I
> know libc limits this but is there any reason.
> 
> The reason I ask is it seems from looking at other Unix implementations of
> ptrace that for operations like reading all the registers on a machine,
> or reading writing FP (and now AltiVec registers) that this is a big
> waste.
> 
> ie. if I want to dump all the registers for the a process (GPRs, FPs, VRs)
> It is going to take 224 system calls with the current implementation.
> 
> 32 (for GPRs) + 64 (for FPs) + 128 (for VRs)
> 
> plus additional calls for any status registers (PC, CRn, FPSCR, VSCR,
> etc.)
> 
> rather being able to make a single call to ptrace to dump all the
> registers, 3 calls - one for GPRs, one for FPs, one for VRs would be much
> more efficient.  
> 
> I think it is something that should be fixed, and most likely we could
> maintain the 'IMHO broken' way that things are currently done, and still
> have the nicer features I am taking about.

If you look at the Linux kernel sources, you'll see that i386, m68k,
sparc, sparc64, and sh all implement PTRACE_GETREGS and
PTRACE_SETREGS.  Some of them implement some other variants.  E.g,
i386 also has a PTRACE_GETFPREGS and PTRACE_SETFPREGS as does the
sparc (which has a number of others as well).

I don't think there is any technical reason that would prevent
PTRACE_GETREGS / PTRACE_SETREGS from being implemented for the PPC. 
And I agree with you; gdb could be much more efficient at fetching
and setting registers if these ptrace operations were defined.

Kevin

-- 
Kevin Buettner
kev@primenet.com, kevinb@cygnus.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
