Date: Tue, 26 Oct 1999 17:43:50 -0500 (CDT)
From: Kumar Gala <kumar@chaos.ph.utexas.edu>
To: Jim Terman <terman@ddi.com>
cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: question about altivec registers
In-Reply-To: <199910262152.OAA02956@sade.ddi.com>
Message-ID: <Pine.LNX.4.10.9910261733160.10102-100000@chaos.ph.utexas.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
> Will the linuxppc kernal as it is right now save the AltiVec registers
> if we enable the MSR VEC bit.  I've been trying to follow the other messages
> on this subject, but I'm not clear.
> 

No, the kernel does not know anything about the AltiVec registers,
unlike the x86 platform on interrupts only two registers and saved and
restored typically.  SRR0 and SRR1, one contains the MSR settings and the
other the PC to return two.  On an rfi values are copied out of these
registers.

The AltiVec registers have to be saved and restore explicitly, if you look
at /arch/ppc/kernel/head.S and look for load_up_fp you will see how the
floating point unit is handled on exceptions.  Essential what is done is
there are some checks done, and a pointer is kept to the last
process using the FP unit (last_task_used_fp) which then if needed the FP
regs are saved in to that processes context and the FPs for the incoming
are restored.

- kumar



ignorance is bliss.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
