From: Peter Bergner <bergner@brule.borg.umn.edu>
Date: Tue, 13 Aug 2002 21:20:37 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: Mike Corrigan <mikejc@us.ibm.com>,
	Anton Blanchard <anton@samba.org>,
	linuxPPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: FP save/restore code in ppc32/ppc64 kernels
Message-ID: <20020813212037.A926908@brule.borg.umn.edu>
References: <OFD0ACCC08.6A2BB8EC-ON86256C0F.004C0678@us.ibm.com> <15698.61945.251112.661796@argo.ozlabs.ibm.com> <20020808210927.A870681@brule.borg.umn.edu> <15703.8116.483898.162119@argo.ozlabs.ibm.com> <20020812143430.GA35003@congo.borg.umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020812143430.GA35003@congo.borg.umn.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Peter Bergner wrote:
: Paul Mackerras wrote:
:: Exactly.  We don't.  If we did then we could do as you say and it
:: would work on SMP.  We could do that as long as we are sure we won't
:: ever want to do a UP kernel on ppc64...
:
: Or we could force the UP kernel to act like the SMP kernel and not
: use lazy save.  How big of a "win" is lazy save on UP kernels?
: I will also note that UP kernels haven't worked for nearly 2 years
: on PPC64.


Nevermind.  I came up with an idea where we can keep the FE{0,1}
bits in the MSR (no need to reset them in giveup_fpu() and assuming
we clear the fpscr in giveup_fpu()) and the UP kernel can continue
to do lazy save of the FP state.

Now if we did nothing more than the above, then we can have a problem
of process A with FE{0,1} == 1,1 and fpscr == 0 could see the fpscr
results of process B with FE{0,1} == 0,0 and fpscr != 0 with lazy
save.  However, while switching process A back in, we can check
whether process A's FE{0,1} bits are non zero.  If either of the
bits are set, we can call giveup_fpu() right there.

The problem with the above idea is that currently, all processes
run with a default FE{0,1} == 1,1, so we'd end up calling giveup_fpu()
on each task switch.  OTOH, if we ran with FE{0,1} == 0,0 as default
values, then that would occur only for those processes that explicitly
change their FE{0,1} bits to something other than 0,0.  We can go
further by testing that last_task_math_used != current as well.

As for 0,0 as default values for FE{0,1}, I ran a copy of tomcatv
(spec92) on an sstar processor and was seeing about a 40%-45%
performance regression when running with FE{0,1} == 1,1 versus 0,0
(fpscr set to ignore exceptions in both cases).  I'd like to run
more tests as well as seeing what the results look like across
different processors, particularly on POWER4.  I'll keep you posted.

Peter

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
