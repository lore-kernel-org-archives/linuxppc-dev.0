Date: Wed, 27 Oct 1999 13:31:48 -0500 (CDT)
From: Kumar Gala <kumar@chaos.ph.utexas.edu>
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: ptrace
Message-ID: <Pine.LNX.4.10.9910271325190.17521-100000@chaos.ph.utexas.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Does anyone know why ptrace will only read and write a word at a time.  I
know libc limits this but is there any reason.

The reason I ask is it seems from looking at other Unix implementations of
ptrace that for operations like reading all the registers on a machine,
or reading writing FP (and now AltiVec registers) that this is a big
waste.

ie. if I want to dump all the registers for the a process (GPRs, FPs, VRs)
It is going to take 224 system calls with the current implementation.

32 (for GPRs) + 64 (for FPs) + 128 (for VRs)

plus additional calls for any status registers (PC, CRn, FPSCR, VSCR,
etc.)

rather being able to make a single call to ptrace to dump all the
registers, 3 calls - one for GPRs, one for FPs, one for VRs would be much
more efficient.  

I think it is something that should be fixed, and most likely we could
maintain the 'IMHO broken' way that things are currently done, and still
have the nicer features I am taking about.

- kumar



ignorance is bliss.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
