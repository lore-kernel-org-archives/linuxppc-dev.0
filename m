Date: Fri, 10 Nov 2000 12:43:31 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Rainer Kloud <rainer.kloud@siemens.at>
cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: DSI Exception
In-Reply-To: <3A0BDA42.C2904194@siemens.at>
Message-ID: <Pine.HPX.4.10.10011101235520.19910-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


	Hi,

> I have a problem when executeing the init process.
>
> First to the configuration: I use the core of a MPC750
> which is mapped into a MPC8260 (Motorola Scout Board in
> Compagnion Mode).
> Kernel: 2.4.0-test4
> gcc: 2.95.2
> glibc: 2.1.3 with ctype.patch
>
> I can startup the kernel without problems, but when
> executeing the first instructions of the init process
> (statical linked sash) I get a DSI Exception.
> When I debug the init process I can see, that the exception
> occoures at the following point:
>
> 100000c0 <_start>:
> 100000c0: 7c 29 0b 78  mr r9,r1
> 100000c4: 54 21 00 36  rlwinm r1,r1,0,0,27
> 100000c8: 38 00 00 00  li r0,0
> 100000cc: 94 21 ff f0  stwu r1,-16(r1)
> 100000d0: 7c 08 03 a6  mtlr r0
> 100000d4: 90 01 00 00  stw r0,0(r1)
> 100000d8: 3d 00 10 06  lis r8,4102
> 100000dc: 85 a8 92 00  lwzu r13,-28160(r8)
> 100000e0: 48 00 ed c8  b 1000eea8 <__libc_start_main>
> ........
> 1000eea8 <__libc_start_main>:
> 1000eea8: 94 21 ff e0  stwu r1,-32(r1)
> 1000eeac: 7c 08 02 a6  mflr r0      <-------- DSI Exception
> 1000eeb0: 93 61 00 0c  stw r27,12(r1)

Hmm, I suspect that you get the DSI exception on the store (the mflr can't
generate this exception since it is not a load or store insruction).

>
> At the beginning of _start GPR1 was 0xb, GPR1 (SP) 0x7fffff90,
                                ^
Huh ?                 Do you truly mean GPR1 ?

> GPR2 0xc0210000 and GPR3 0x0.
> When the Exception occoures GPR0 has the value zero.

The stack is correct, I don't understand the problem. Probably some info
is missing. Accesses to the stack are already done and the TLB should
hold the stack address.

> The DSISR register has the value 0x42000000 which means that
> a store instruction results in a direct store error
> exception (correct?). I don't know what that means for me?

No, it means no translation found on a store (bits 1 and 6).

> What have I done (or what haven't I done) that I get these
> exception?

I dno't know, more info is probably needed.

	Gabriel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
