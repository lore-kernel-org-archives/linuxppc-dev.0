Message-ID: <40335BE0.6090000@jonmasters.org>
Date: Wed, 18 Feb 2004 12:34:40 +0000
From: Jon Masters <jonathan@jonmasters.org>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ml300 boot loader question
References: <20040211214947.87373.qmail@web21110.mail.yahoo.com> <402CEC30.9060503@xilinx.com> <402E2841.9020700@jonmasters.org> <402EA47B.2010600@lucent.com> <402F524C.3020009@jonmasters.org> <403343E6.7090200@jonmasters.org>
In-Reply-To: <403343E6.7090200@jonmasters.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jon Masters wrote:

> Offset in r8 is broken and I am not sure yet whether this is purely a
> hardware corruption of the kernel stack or a subtle kernel bug.

Ho hum... *whistles to self quietly*. Let me clarify stuff.

I am working on an internal project based on my own Virtex II Pro port
and firmware (no redboot or ppcboot) which runs on the Insight Memec rev
3. V2PFG456 board - for those not familiar then this basically is an
FPGA with an IBM 405D processor inside. Something similar to Mind.

Now the problem I am seeing for those who are interested or might have
seen similar problems with EDK6.1 generated hardware:

The port has been working fine running busybox, webservers, a userland
based upon ptxdist and so on et al. This is based upon a hardware
generated using Xilinx EDK3.2 with some custom modules for ethernet and
in house hardware stuff. The system boots from SystemACE etc.

An upgrade to Xilinx EDK6.1 resulted in generated hardware which can no
longer boot a stable Linux environment which does not fall over randomly
in strange and non-deterministic ways which makes debugging difficult.
The Xilinx XMD/EDK software slightly compounds the debugging anyway.

Suspicion lead me to disable the cacheing on the 405D as it was and is
still suspected that there is a problem with the hardware (currently I
am using an automatically generated really simple cut down hardware from
EDK6.1 using its autogeneration tool so that if/when I find this fault I
can make various ascertions about where it might lie). Recent posting
suggesting a problem with mmap was down to me however (see below) but I
am hopefully now back on track with cacheing properly off so I can
continue to look for the original problem again.

Cheers,

Jon.

--- Red faced explanation of mmap r8 issue mentioned ---

Seems I shoved in something along the lines of:

	li	r8,0			/* Load zero */
	iccci	r8,r8
	dccci	r8,r8

This happens during the SystemCall execution path because I am running
with cacheing disabled and I am paranoid so want to force the caches to
be flushed even though I have explicitly modified the iccr and dccr and
page protection bits in _PAGE_BASE to not use cacheing for kernel or
userland ID page frames (but not enough to have seen that I was trashing
the register for mmap). Anyway this means that finally I might be
running as per my original posting and can get back to looking for a
potential memory controller problem.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
