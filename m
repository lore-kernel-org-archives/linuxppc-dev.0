Date: Thu, 8 Aug 2002 21:46:47 +1000
From: Anton Blanchard <anton@samba.org>
To: Peter Bergner <bergner@borg.umn.edu>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxPPC Dev <linuxppc-dev@lists.linuxppc.org>,
	Mike Corrigan <mikejc@us.ibm.com>
Subject: Re: FP save/restore code in ppc32/ppc64 kernels
Message-ID: <20020808114646.GA23964@krispykreme>
References: <20020807162302.GA39680@congo.borg.umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020807162302.GA39680@congo.borg.umn.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Peter,

> Can you describe (if you know/remember since a lot of this code has
> Cort's name on it) how the FP save/restore code is supposed to work?
> I'm wondering why we're clearing the MSR_FE{0,1} bits along with the
> MSR_FP bit.  Is there a reason why they must be cleared when we clear
> the MSR_FP bit?
>
> The reason I ask is that someone was running some userland app that
> explicitly set the fpscr (using asm) and he got an FP exception even
> though gdb showed his MSR_FE{0,1} bits to be zero.  This got me
> looking at the code which seems to be inherited old ppc32 code.  I
> noticed that you've updated the ppc32, so before I update our ppc64
> code, I'd like to understand more about how this is all supposed to
> work.

I sat down with Paul today and he explained what is going on.

Firstly the kernel at the moment always enables FE0 and FE1 each time we
take the FP Unavailable trap (due to the lazy restore).  Paul has a
change in ppc32 2.5 which I have merged into the ppc64 2.5 tree which
creates a prctl to modify the FE0 and FE1 bits. We store it away in
the thread struct. No problems so far.

The first problem Paul found was that glibc uses an awful hack to try
and modify FE0 and FE1. Basically it invokes a signal handler which
modifies the MSR. The sigreturn code allows only FE0 and FE1 to be
changed. Its of course completely bogus because by the time we context
switched out of the process (and saved the FP regs), context switched in
and took the FP Unavailable trap we would set FE0 and FE1 unconditionally.

The good news is glibc seems to set both bits all the time and this
is the old default behaviour (and will continue to be). Since we
have (or will soon) have a prctl to modify FE0 and FE1, there is no
need to allow the MSR hack and so it is disabled. Besides its always
been broken, no one could have been using it to disable either of the
bits.

The final thing to look at is what ptrace returns for the MSR. I
suggested that we should copy in the FE0/FE1 bits out of the thread
struct (since the MSR_FP, FE0 and FE1 bits will always be zero as
ptrace does a giveup_fpu just before reading any FP stuff). Paul
pointed out for completeness we should always set the MSR_FP bit too.

I hope this makes some sense :)

Anton

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
