Message-Id: <4.3.2.20010130074919.00bb0a80@falcon.si.com>
Date: Tue, 30 Jan 2001 08:26:45 -0500
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: Initial stack frame 
In-Reply-To: <3A75DB0F.29DC7C96@bluewin.ch>
References: <524rylvl3d.fsf@love-boat.topspincom.com>
 <3A722CA1.3EAE82AF@mvista.com>
 <52u26iut9s.fsf@love-boat.topspincom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 10:05 PM 1/29/01 +0100, Wolfgang Grandegger wrote:

>Hello,
>
>I'm currently debugging a task stack initialization problem in RTAI
>on MPC8xx. The task is switched by calling rt_startup() via "blr"
>(or "rfi" in RTLinux). The objdump of rtai_sched.o shows the following
>function prolog:
>
>rtai_sched.o:     file format elf32-powerpc
>
>Disassembly of section .text:
>
>00000000 <rt_startup>:
>        0:       94 21 ff f0     stwu    r1,-16(r1)
>        4:       7c 08 02 a6     mflr    r0
>        8:       93 c1 00 08     stw     r30,8(r1)
>        c:       93 e1 00 0c     stw     r31,12(r1)
>       10:       90 01 00 14     stw     r0,20(r1)
>       14:       3c e0 00 00     lis     r7,0
>       18:       81 67 00 00     lwz     r11,0(r7)
>
>This means that it will save on the stack:
>
>         SP    Contents
>        -16 -> initial r1 (back chain)
>        -12
>         -8 -> r30
>         -4 -> r31
>          0 ->
>         +4 -> LR
>
>Note that the initial stack pointer (SP) stored in r1 is at 0
>pointing to the end of the stack buffer (kmalloc + stack_size).
>This means that data behind the stack gets overwritten.
>
>I realized that an empty initial stack frame is missing and also a
>16-byte alignment is mandatory. At least that's what I understood
>from the PowerPC Application Binary Interface supplement. There
>should be an initial stack frame initialized as follows:
>
>    Address    Contents
>          0 -> 0 (back chain for first stack frame)
>         +4 ->
>         +8 ->
>        +12 ->
>
>It would be nice is somebody could clarify this. Is the alignment
>really mandatory?
>
>Thanks for any comments in advance.
>
>
>-- Wolfgang

You need to get the ABI and EABI spec
http://www.esofta.com/softspecs.html (also available on the IBM web
site somewhere).

One of the differences between the ABI and EABI is that the EABI
requires 8 byte alignment of the stack and the ABI requires 16 byte
alignment (EABI, p.28).

The ABI illustrates the stack on page 3-44.  Note that the link
register and back chain are saved on what traditional processors would
call the previous stack (most/all CISC processors pre-decrement the
stack pointer so offset 0 and +4 in your illustrations above would be
"previous stack" locations).  This is odd and confusing to us
traditionalists, but all properly written functions make provisions for
it so it works just fine.

The bottom line is that I don't see anything wrong with what you have
shown above in your stacks.

Your statement about "blr" vs. "rfi" as if they were interchangeable is
somewhat confusing since they are not at all interchangeable.  I
presume you were glossing over a lot of details.  Doing a "rfi" on a
PowerPC requires a very delicate and elaborate dance of instructions
and control register bits.  Ultimately, it returns to the location in
the SRR0 register, not to any location stored on the stack.

gvb


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
