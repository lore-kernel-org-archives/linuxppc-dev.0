Date: Wed, 27 Oct 1999 13:23:31 -0500 (CDT)
From: Kumar Gala <kumar@chaos.ph.utexas.edu>
To: Gabriel Paubert <paubert@iram.es>
cc: Adrian Cox <apc@agelectronics.co.uk>, Jim Terman <terman@ddi.com>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: question about altivec registers
In-Reply-To: <Pine.HPX.4.10.9910271432490.18743-100000@gra-ux1.iram.es>
Message-ID: <Pine.LNX.4.10.9910271315510.17521-100000@chaos.ph.utexas.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The main purpose of VRSAVE was for apple.  The allocate registers in order
which makes it efficient to use it to decide which AltiVec registers to
save and restore since you only need to determine up to which register to
save.

The ABI for System V, allocates registers similar to GPRs, in that
vr3,vr4,vr5 are used to pass arguments and so on.  These is documented in
the Motorola docs on (AltiVec Programmers Environments Manual on there
website).  The problem then becomes that due to the ABI it is more costly
to determine which vector registers where used and which were not if
VRSAVE is used as a bitmap.  

Also, the current ABI does not state the use of VRSAVE at all and therefor
the non-Apple compilers to not even include it in code generated that uses
AltiVec.

Also, based on how FP is implemented, if the process currently running
does not use AltiVec in its current time slice the registers are not saved
and restored.

As for the cache issues with saving and restoring all the VR registers, I
am looking into this further.

 - kumar


ignorance is bliss.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
