Date: Thu, 8 Aug 2002 23:18:33 +1000
From: Anton Blanchard <anton@samba.org>
To: Peter Bergner <bergner@borg.umn.edu>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxPPC Dev <linuxppc-dev@lists.linuxppc.org>,
	Mike Corrigan <mikejc@us.ibm.com>
Subject: Re: FP save/restore code in ppc32/ppc64 kernels
Message-ID: <20020808131833.GD23964@krispykreme>
References: <20020807162302.GA39680@congo.borg.umn.edu> <20020808114646.GA23964@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020808114646.GA23964@krispykreme>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



> The final thing to look at is what ptrace returns for the MSR. I
> suggested that we should copy in the FE0/FE1 bits out of the thread
> struct (since the MSR_FP, FE0 and FE1 bits will always be zero as
> ptrace does a giveup_fpu just before reading any FP stuff). Paul
> pointed out for completeness we should always set the MSR_FP bit too.

To follow up, this is what we currently see via ptrace:

./msr
msr = d032

And here is what we see with the above fixes:

./msr
msr = f932

fpemode is a small program from Paulus that changes the FE0 and
FE1 bits via the prctl. This shows:

./fpemode 0 ./msr
msr = f032

./fpemode 1 ./msr
msr = f132

./fpemode 2 ./msr
msr = f832

./fpemode 3 ./msr
msr = f932

Anton

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
