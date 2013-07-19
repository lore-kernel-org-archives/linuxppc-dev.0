Return-Path: <B07421@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0253.outbound.messaging.microsoft.com [213.199.154.253])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E24722C0099
 for <linuxppc-dev@ozlabs.org>; Sat, 20 Jul 2013 09:49:23 +1000 (EST)
Date: Fri, 19 Jul 2013 18:49:13 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: ABI defined register usage within function calls
To: JiveTalkin <aijazbaig1@gmail.com>
In-Reply-To: <1373464479578-73565.post@n7.nabble.com> (from
 aijazbaig1@gmail.com on Wed Jul 10 08:54:39 2013)
Message-ID: <1374277753.5357.36@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/10/2013 08:54:39 AM, JiveTalkin wrote:
> Hello.
>=20
> I would like to monitor the value of one of the parameters (within =20
> the stack
> frame) that have been passed as part of a context switch (from process
> context to interrupt context).

I don't understand this...  What specifically do you mean by "interrupt =20
context"?  Do you mean syscall context?  Syscall parameters are passed =20
in registers, not in the stack frame.

> START_EXCEPTION does nothing more than align us to a word (32bit) =20
> boundary
> (obviously for performance reasons). What I need to understand is the
> NORMAL_EXCEPTION_PROLOG. I reproduce it here:
>=20
>=20
> First thing it does it saves r10, r11 and r1(containing the Stack =20
> pointer)
> into the scratch registers 0,1 and 2 respectively. Correct me if I am =20
> wrong,
> but as per the older EABI, isn't it recommended for the OS to load =20
> SPRG0
> with the start address of an area of memory (the stack top) to be =20
> used by
> the 1st level interrupt handler? Or can these registers be used =20
> anyway we
> see fit?

Linux doesn't use EABI -- and in any case, I don't see "SPRG" anywhere =20
in the EABI document, and no relevant mention in the SVR4 ABI.  It's up =20
to the OS how SPRGs are used.

> Moving on, it seems the kernel folks have decided to use SPRNG3 to =20
> point to
> the currently running process's thread_struct structure. Is there a =20
> document
> which recommends so or was it an unanimous decision taken during early
> development? Just curios.
>=20
> Then we go on to check the value of the PR bit from the MSR which has =20
> been
> copied by the hardware to SRR1. So here we are actually checking =20
> whether the
> exception occurred when the machine was in user space or kernel space =20
> right?
>=20
> So once we determine that we've originated in the userspace, as is =20
> the case
> for SystemCall, we are apparently updating r1 (stack pointer) with =20
> (r1 +
> THREAD) - THREAD_INFO. Or is it actually r1 + (THREAD_INFO-THREAD)?

Neither; it's the address stored at r10 + (THREAD_INFO-THREAD).

> In
> either case, how does this take us to the top of the kernel stack, is
> something I am unable to get my head around. May be I do not know =20
> some basic
> concepts here, which is why this is looking strange to me. Could =20
> someone
> please elaborate? Some ASCII art would be really nice here.

r10 was loaded from SPRG3, and thus points to the thread struct.  The =20
thread struct (a.k.a. SPRG3, a.k.a. THREAD) and a pointer to the stack =20
are both contained within the task_struct (a.k.a. current).  At the =20
bottom of the stack is the thread_info struct, which is why =20
current->stack is called THREAD_INFO in asm-offsets.c.  Since THREAD =20
and THREAD_INFO are both in the same struct, we can get THREAD_INFO by =20
adding the difference in offsets to the THREAD pointer that we got from =20
SPRG3.

That gets us to the bottom of the stack; ALLOC_STACK_FRAME() adds the =20
size of the stack so that we point to the top and are ready to create a =20
frame.  It's a confusing name since it doesn't actually allocate a =20
frame; that happens in the "subi" instruction that follows.

> We then allocate an exception frame to hold the activation record =20
> (stack
> frame) for the caller. Into this frame, we save the CR. We also save =20
> R12 and
> R9 (as they are volatile registers and the caller must save them =20
> before
> calling a function). We then retrieve the earlier stored values of =20
> r10 and
> r11 and store them into the frame (using r11 as an anchor as it now =20
> points
> to the top of the stack frame). Then we store the link register.
>=20
> We retrieve previously stored r1 (previous frame's stack pointer =20
> isn't it?),
> retrieve SRR0 (which includes the return address and in this case, the
> address of the next instruction in case of a syscall from userspace,
> correct?). If we have already stored the previous value of R1 then =20
> what are
> we doing with this:
>=20
>=20
>=20

What are we doing with what?

The previous value of r1 is still in r1.  At this point r11 holds the =20
new stack pointer.  Did you misread the "stw r1, GPR1(r11)" as a load?

-Scott=
