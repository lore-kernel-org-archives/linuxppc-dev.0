From: Peter Bergner <bergner@brule.borg.umn.edu>
Date: Thu, 8 Aug 2002 21:09:27 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: Mike Corrigan <mikejc@us.ibm.com>,
	Anton Blanchard <anton@samba.org>,
	Peter Bergner <bergner@borg.umn.edu>,
	linuxPPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: FP save/restore code in ppc32/ppc64 kernels
Message-ID: <20020808210927.A870681@brule.borg.umn.edu>
References: <OFD0ACCC08.6A2BB8EC-ON86256C0F.004C0678@us.ibm.com> <15698.61945.251112.661796@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <15698.61945.251112.661796@argo.ozlabs.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:
: We used to do this (have FE0/1 = 11 for user processes all the time)
: in the 32-bit kernel, but we found we had a situation where random
: processes were occasionally getting spurious SIGFPEs.  What was
: happening was that another process would leave the FPSCR with an
: exception condition enabled and pending.  Then we switched to another
: task which would have MSR.FP=0 and MSR.FE0/1 = 11 and the cpu would
: immediately take a trap (i.e. an interrupt in IBM-speak or an
: exception in Motorola-speak :).
:
: The point is that MSR.FP=0 doesn't disable floating-point exceptions.
: If MSR.FE0/1 != 00 and the FPSCR has both the condition and enable
: bits set for some exception, the cpu will take a trap.  Therefore, if
: the FPSCR doesn't belong to the current process and there is any
: possibility that it could have enabled exception conditions being
: signalled in it, you really want to have FE0/1 = 00.

But isn't the problem of the trap/interrupt/exception leaking into
another process only a problem when we are doing lazy save of the
FP regs?  Since our ppc64 kernels are compiled as SMP, we don't do
lazy save and the giveup_fpu() code would seem to force the pending
FP exceptions to complete before the "mffs" in giveup_fpu finishes.
It might be a good idea to clear the fpscr after saving it out to
the thread struct though...


Peter

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
