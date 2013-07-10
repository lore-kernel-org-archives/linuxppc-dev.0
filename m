Return-Path: <aijazbaig1@gmail.com>
Received: from sam.nabble.com (sam.nabble.com [216.139.236.26])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0EA622C0089
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Jul 2013 00:10:46 +1000 (EST)
Received: from tom.nabble.com ([192.168.236.105])
 by sam.nabble.com with esmtp (Exim 4.72)
 (envelope-from <aijazbaig1@gmail.com>) id 1Uwuqt-0006qx-J0
 for linuxppc-dev@ozlabs.org; Wed, 10 Jul 2013 06:54:39 -0700
Date: Wed, 10 Jul 2013 06:54:39 -0700 (PDT)
From: JiveTalkin <aijazbaig1@gmail.com>
To: linuxppc-dev@ozlabs.org
Message-ID: <1373464479578-73565.post@n7.nabble.com>
Subject: ABI defined register usage within function calls
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello.

I would like to monitor the value of one of the parameters (within the stack
frame) that have been passed as part of a context switch (from process
context to interrupt context). Hence I have been looking at the call flow of
a typical exception (which can be thought of as a synchronous exception
isn't it?).

Since e500 is a 32bit processor, I have been looking at entry_32.S which
contains the context switching code which is the entry point for the
exception handling. As an example, I am looking at how system calls are
handled in the PowerPC architecture in general and e500 in particular. Since
in case of BookE, the MMU is always ON, we are never in real mode and the
interrupt vector can be at arbitrary virtual address.

This defines how a Syscall is going to handled, as per head_fsl_booke.S:
/* System Call Interrupt */
START_EXCEPTION(SystemCall)
NORMAL_EXCEPTION_PROLOG
EXC_XFER_EE_LITE(0x0c00, DoSyscall)

START_EXCEPTION does nothing more than align us to a word (32bit) boundary
(obviously for performance reasons). What I need to understand is the
NORMAL_EXCEPTION_PROLOG. I reproduce it here:


First thing it does it saves r10, r11 and r1(containing the Stack pointer)
into the scratch registers 0,1 and 2 respectively. Correct me if I am wrong,
but as per the older EABI, isn't it recommended for the OS to load SPRG0
with the start address of an area of memory (the stack top) to be used by
the 1st level interrupt handler? Or can these registers be used anyway we
see fit?

Moving on, it seems the kernel folks have decided to use SPRNG3 to point to
the currently running process's thread_struct structure. Is there a document
which recommends so or was it an unanimous decision taken during early
development? Just curios.

Then we go on to check the value of the PR bit from the MSR which has been
copied by the hardware to SRR1. So here we are actually checking whether the
exception occurred when the machine was in user space or kernel space right? 

So once we determine that we've originated in the userspace, as is the case
for SystemCall, we are apparently updating r1 (stack pointer) with (r1 +
THREAD) - THREAD_INFO. Or is it actually r1 + (THREAD_INFO-THREAD)? In
either case, how does this take us to the top of the kernel stack, is
something I am unable to get my head around. May be I do not know some basic
concepts here, which is why this is looking strange to me. Could someone
please elaborate? Some ASCII art would be really nice here.

We then allocate an exception frame to hold the activation record (stack
frame) for the caller. Into this frame, we save the CR. We also save R12 and
R9 (as they are volatile registers and the caller must save them before
calling a function). We then retrieve the earlier stored values of r10 and
r11 and store them into the frame (using r11 as an anchor as it now points
to the top of the stack frame). Then we store the link register.

We retrieve previously stored r1 (previous frame's stack pointer isn't it?),
retrieve SRR0 (which includes the return address and in this case, the
address of the next instruction in case of a syscall from userspace,
correct?). If we have already stored the previous value of R1 then what are
we doing with this:



Please correct me if my understanding is incorrect somewhere in addition to
some of the doubts I have raised with this. I appreciate your help.




--
View this message in context: http://linuxppc.10917.n7.nabble.com/ABI-defined-register-usage-within-function-calls-tp73565.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
