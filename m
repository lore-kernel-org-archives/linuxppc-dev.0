From: Paul Mackerras <paulus@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15703.8116.483898.162119@argo.ozlabs.ibm.com>
Date: Mon, 12 Aug 2002 12:38:44 +1000 (EST)
To: Peter Bergner <bergner@brule.borg.umn.edu>
Cc: Mike Corrigan <mikejc@us.ibm.com>,
	Anton Blanchard <anton@samba.org>,
	Peter Bergner <bergner@borg.umn.edu>,
	linuxPPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: FP save/restore code in ppc32/ppc64 kernels
In-Reply-To: <20020808210927.A870681@brule.borg.umn.edu>
References: <OFD0ACCC08.6A2BB8EC-ON86256C0F.004C0678@us.ibm.com>
	<15698.61945.251112.661796@argo.ozlabs.ibm.com>
	<20020808210927.A870681@brule.borg.umn.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Peter Bergner writes:

> But isn't the problem of the trap/interrupt/exception leaking into
> another process only a problem when we are doing lazy save of the
> FP regs?  Since our ppc64 kernels are compiled as SMP, we don't do
> lazy save and the giveup_fpu() code would seem to force the pending
> FP exceptions to complete before the "mffs" in giveup_fpu finishes.

But the exception bits would be set in the FPSCR, waiting until we set
FE0/1 non-zero.

> It might be a good idea to clear the fpscr after saving it out to
> the thread struct though...

Exactly.  We don't.  If we did then we could do as you say and it
would work on SMP.  We could do that as long as we are sure we won't
ever want to do a UP kernel on ppc64...

Regards,
Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
