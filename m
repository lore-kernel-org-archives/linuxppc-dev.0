Subject: Re: FP save/restore code in ppc32/ppc64 kernels
To: Anton Blanchard <anton@samba.org>
Cc: Peter Bergner <bergner@borg.umn.edu>,
	linuxPPC Dev <linuxppc-dev@lists.linuxppc.org>,
	Paul Mackerras <paulus@samba.org>
Message-ID: <OFD0ACCC08.6A2BB8EC-ON86256C0F.004C0678@us.ibm.com>
From: Mike Corrigan <mikejc@us.ibm.com>
Date: Thu, 8 Aug 2002 09:01:03 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>







The question we had was why the FE0 and FE1 bits (in the saved MSR) are
zeroed when the FP bit (also in the saved MSR) is zeroed.  And that
question is really why do we need to have FE0 and FE1 zeroed when we run
with FP=0?  If we could just let FE0 and FE1 always have the value asked
for by the process, then we wouldn't have to have a field in the
thread_struct for these bits and wouldn't have to do any special processing
for them.

We couldn't come up with the reason that FE0 and FE1 are zeroed in
giveup_fpu.

Regarding what ptrace returns for the MSR, I agree that the FE0 and FE1
should be the values you've saved in the thread_struct, but I'm not sure
about the FP bit.  The FE0 and FE1 bits give the debugger some information
about the mode in which the process is running, but returning a one for the
FP bit is perhaps misleading.   What would someone make of seeing FP=1 in a
process that never used floating point?  In any event, the FP bit really
means nothing at the user level.

Mike Corrigan
Distinguished Engineer
Server Group; Rochester, MN
T/L 553-5296



|---------+---------------------------->
|         |           Anton Blanchard  |
|         |           <anton@samba.org>|
|         |                            |
|         |           08/08/2002 06:46 |
|         |           AM               |
|         |                            |
|---------+---------------------------->
  >------------------------------------------------------------------------------------------------------------------------------|
  |                                                                                                                              |
  |       To:       Peter Bergner <bergner@borg.umn.edu>                                                                         |
  |       cc:       Paul Mackerras <paulus@samba.org>, linuxPPC Dev <linuxppc-dev@lists.linuxppc.org>, Mike                      |
  |        Corrigan/Rochester/IBM@IBMUS                                                                                          |
  |       Subject:  Re: FP save/restore code in ppc32/ppc64 kernels                                                              |
  |                                                                                                                              |
  |                                                                                                                              |
  >------------------------------------------------------------------------------------------------------------------------------|




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
