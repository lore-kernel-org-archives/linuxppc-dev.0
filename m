Message-ID: <3A142696.AB867F1C@siemens.at>
Date: Thu, 16 Nov 2000 19:25:26 +0100
From: Rainer Kloud <rainer.kloud@siemens.at>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: DSI Exception
References: <Pine.HPX.4.10.10011101235520.19910-100000@gra-ux1.iram.es>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I have further information and questions about my problem.
As mentioned in my last mail my statical linked sash produces
a DSI Exception. Now I think I know the reason:
At the end of _init the program jumps to address 0x1000eea8
(__libc_start_main) but when I dump the memory at this address
the content is not the same as it should be (I have compared it
with the disassembled code of the executable).
When the kernel loads the executable it dumpes the following
addresses:
(start_brk) 1007688c
(start_code) 10000000
(end_code) 100630c8
(start_data) 100730c8
(end_data) 100744d4
(start_stack) 7fffff90
(brk) 1007688c

So I think when I dump the memory from 10000000 to 100630c8
I should see the same instructions as in the disassembled binary,
but I do not.
The content of the memory from 1000000 to 10000ffc is correct,
from 10000ffd to 1000dfff the debugger complains with 'Target
memory access failed' and finally from 1000e000 to 100630c8
I see some random values (not they I supposed to).

When I dump the memory in function load_elf_binary I get the
same result.

What is wrong with my loaded executable?

Thank you for any help.

Best Regards
Rainer

> > I have a problem when executeing the init process.
> >
> > First to the configuration: I use the core of a MPC750
> > which is mapped into a MPC8260 (Motorola Scout Board in
> > Compagnion Mode).
> > Kernel: 2.4.0-test4
> > gcc: 2.95.2
> > glibc: 2.1.3 with ctype.patch
> >
> > I can startup the kernel without problems, but when
> > executeing the first instructions of the init process
> > (statical linked sash) I get a DSI Exception.
> > When I debug the init process I can see, that the exception
> > occoures at the following point:
> >
> > 100000c0 <_start>:
> > 100000c0: 7c 29 0b 78  mr r9,r1
> > 100000c4: 54 21 00 36  rlwinm r1,r1,0,0,27
> > 100000c8: 38 00 00 00  li r0,0
> > 100000cc: 94 21 ff f0  stwu r1,-16(r1)
> > 100000d0: 7c 08 03 a6  mtlr r0
> > 100000d4: 90 01 00 00  stw r0,0(r1)
> > 100000d8: 3d 00 10 06  lis r8,4102
> > 100000dc: 85 a8 92 00  lwzu r13,-28160(r8)
> > 100000e0: 48 00 ed c8  b 1000eea8 <__libc_start_main>
> > ........
> > 1000eea8 <__libc_start_main>:
> > 1000eea8: 94 21 ff e0  stwu r1,-32(r1)
> > 1000eeac: 7c 08 02 a6  mflr r0      <-------- DSI Exception
> > 1000eeb0: 93 61 00 0c  stw r27,12(r1)
>
> Hmm, I suspect that you get the DSI exception on the store (the mflr can't
> generate this exception since it is not a load or store insruction).
>
> >
> > At the beginning of _start GPR1 was 0xb, GPR1 (SP) 0x7fffff90,
>                                 ^
> Huh ?                 Do you truly mean GPR1 ?
>
> > GPR2 0xc0210000 and GPR3 0x0.
> > When the Exception occoures GPR0 has the value zero.
>
> The stack is correct, I don't understand the problem. Probably some info
> is missing. Accesses to the stack are already done and the TLB should
> hold the stack address.
>
> > The DSISR register has the value 0x42000000 which means that
> > a store instruction results in a direct store error
> > exception (correct?). I don't know what that means for me?
>
> No, it means no translation found on a store (bits 1 and 6).
>
> > What have I done (or what haven't I done) that I get these
> > exception?
>
> I dno't know, more info is probably needed.
>
>         Gabriel.

--
Rainer Kloud               mailto:rainer.kloud@siemens.at
Siemens AG, PSE ECT OTN 2, Rampengasse 3-5, A-1190 Vienna
Phone: +43-(0)51707-43873         Fax: +43-(0)51707-53581

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
