From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15698.61945.251112.661796@argo.ozlabs.ibm.com>
Date: Fri, 9 Aug 2002 08:34:33 +1000 (EST)
To: Mike Corrigan <mikejc@us.ibm.com>
Cc: Anton Blanchard <anton@samba.org>,
	Peter Bergner <bergner@borg.umn.edu>,
	linuxPPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: FP save/restore code in ppc32/ppc64 kernels
In-Reply-To: <OFD0ACCC08.6A2BB8EC-ON86256C0F.004C0678@us.ibm.com>
References: <OFD0ACCC08.6A2BB8EC-ON86256C0F.004C0678@us.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Mike Corrigan writes:

> The question we had was why the FE0 and FE1 bits (in the saved MSR) are
> zeroed when the FP bit (also in the saved MSR) is zeroed.  And that
> question is really why do we need to have FE0 and FE1 zeroed when we run
> with FP=0?  If we could just let FE0 and FE1 always have the value asked
> for by the process, then we wouldn't have to have a field in the
> thread_struct for these bits and wouldn't have to do any special processing
> for them.

We used to do this (have FE0/1 = 11 for user processes all the time)
in the 32-bit kernel, but we found we had a situation where random
processes were occasionally getting spurious SIGFPEs.  What was
happening was that another process would leave the FPSCR with an
exception condition enabled and pending.  Then we switched to another
task which would have MSR.FP=0 and MSR.FE0/1 = 11 and the cpu would
immediately take a trap (i.e. an interrupt in IBM-speak or an
exception in Motorola-speak :).

The point is that MSR.FP=0 doesn't disable floating-point exceptions.
If MSR.FE0/1 != 00 and the FPSCR has both the condition and enable
bits set for some exception, the cpu will take a trap.  Therefore, if
the FPSCR doesn't belong to the current process and there is any
possibility that it could have enabled exception conditions being
signalled in it, you really want to have FE0/1 = 00.

So an alternative to the current scheme would be to ensure that FPSCR
is set to 0 whenever we return to userspace with MSR.FP = 0.  However,
that means we would need to use a floating-point register inside the
kernel, which gets a bit messy.  It's far simpler just to clear FE0
and FE1 at the point where we clear FP.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
