Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41LLxF1pWSzF1NW
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jul 2018 23:12:01 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe LEROY <christophe.leroy@c-s.fr>,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Segher Boessenkool <segher@kernel.crashing.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: How is this possible - Register r30 contains 0xc2236400 instead
 of 0xc6236400
In-Reply-To: <09ae0460-11e7-c893-5a5f-55e55a3ef372@c-s.fr>
References: <09ae0460-11e7-c893-5a5f-55e55a3ef372@c-s.fr>
Date: Wed, 04 Jul 2018 23:11:59 +1000
Message-ID: <87k1qbkuw0.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe LEROY <christophe.leroy@c-s.fr> writes:

> Kernel Oops at 0xc0334d5c for reading at address 0xc2236450 which=20
> corresponds to r30 + 80
>
> But r30 should contain what's at r3 + 16 that is at 0xc619ec10 so r30=20
> should be c6236400 as shown below (print_hex_dump(regs->gpr[3]) added at=
=20
> end of __die() )
>
> So how can r30 contain 0xc2236400 instead ?

The simplest answer is that memory was modified between the time we
loaded it into r30 and when you print it.

So it did contain 0xc2236400 but has since been modified to now contain
0xc6236400.

The thing that makes me less certain, is that c6 would be the correct
value (I think?), so it's been modified back to the correct value, which
seems lucky.

Mysterious.

cheers

> And this is not random, it happens at most if not every startup.
>
> c0334d44 <sock_wfree>:
> c0334d44:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7c 08 02 a6=C2=A0=C2=A0=C2=
=A0=C2=A0 mflr=C2=A0=C2=A0=C2=A0 r0
> c0334d48:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 94 21 ff f0=C2=A0=C2=A0=C2=
=A0=C2=A0 stwu=C2=A0=C2=A0=C2=A0 r1,-16(r1)
> c0334d4c:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bf c1 00 08=C2=A0=C2=A0=C2=
=A0=C2=A0 stmw=C2=A0=C2=A0=C2=A0 r30,8(r1)
> c0334d50:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 90 01 00 14=C2=A0=C2=A0=C2=
=A0=C2=A0 stw=C2=A0=C2=A0=C2=A0=C2=A0 r0,20(r1)
> c0334d54:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 83 c3 00 10=C2=A0=C2=A0=C2=
=A0=C2=A0 lwz=C2=A0=C2=A0=C2=A0=C2=A0 r30,16(r3)
> c0334d58:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 81 23 00 a8=C2=A0=C2=A0=C2=
=A0=C2=A0 lwz=C2=A0=C2=A0=C2=A0=C2=A0 r9,168(r3)
> c0334d5c:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 81 5e 00 50=C2=A0=C2=A0=C2=
=A0=C2=A0 lwz=C2=A0=C2=A0=C2=A0=C2=A0 r10,80(r30)
>
>
> [=C2=A0 152.288237] Unable to handle kernel paging request for data at=20
> address 0xc2236450
> [=C2=A0 152.295444] Faulting instruction address: 0xc0334d5c
> [=C2=A0 152.300369] Oops: Kernel access of bad area, sig: 11 [#1]
> [=C2=A0 152.305665] BE PREEMPT DEBUG_PAGEALLOC CMPC885
> [=C2=A0 152.313630] CPU: 0 PID: 269 Comm: in:imuxsock Not tainted=20
> 4.14.52-00025-g5bada429cf-dirty #36
> [=C2=A0 152.322729] task: c623e100 task.stack: c650c000
> [=C2=A0 152.327202] NIP:=C2=A0 c0334d5c LR: c043602c CTR: c0435fb8
> [=C2=A0 152.332200] REGS: c650dc00 TRAP: 0300=C2=A0=C2=A0 Not tainted=20
> (4.14.52-00025-g5bada429cf-dirty)
> [=C2=A0 152.340699] MSR:=C2=A0 00009032 <EE,ME,IR,DR,RI>=C2=A0 CR: 280028=
22 XER: 20000000
> [=C2=A0 152.347333] DAR: c2236450 DSISR: c0000000
> [=C2=A0 152.347333] GPR00: c043602c c650dcb0 c623e100 c619ec00 c642c060=20
> 00000008 00000018 c650dd4c
> [=C2=A0 152.347333] GPR08: c0435fb8 000002b0 c068d830 00000004 28004822=20
> 100d4208 00000000 7780c848
> [=C2=A0 152.347333] GPR16: 0ff58398 777674b0 1024b050 1024b0a8 1005ddbc=20
> 0ff5a7bc 000003e8 00000000
> [=C2=A0 152.347333] GPR24: 0000008e c5011650 c650deb8 0000008e c619ec00=20
> 00000040 c2236400 c619ec00
> [=C2=A0 152.385015] NIP [c0334d5c] sock_wfree+0x18/0xa4
> [=C2=A0 152.389458] LR [c043602c] unix_destruct_scm+0x74/0x88
> [=C2=A0 152.394399] Call Trace:
> [=C2=A0 152.396868] [c650dcb0] [c006348c] ns_to_timeval+0x4c/0x7c (unreli=
able)
> [=C2=A0 152.403305] [c650dcc0] [c043602c] unix_destruct_scm+0x74/0x88
> [=C2=A0 152.408999] [c650dcf0] [c033a10c] skb_release_head_state+0x8c/0x1=
10
> [=C2=A0 152.415184] [c650dd00] [c033a3c4] skb_release_all+0x18/0x50
> [=C2=A0 152.420690] [c650dd10] [c033a7cc] consume_skb+0x38/0xec
> [=C2=A0 152.425869] [c650dd20] [c0342d7c] skb_free_datagram+0x1c/0x68
> [=C2=A0 152.431535] [c650dd30] [c0435c8c] unix_dgram_recvmsg+0x19c/0x4ac
> [=C2=A0 152.437476] [c650ddb0] [c0331370] ___sys_recvmsg+0x98/0x138
> [=C2=A0 152.442984] [c650deb0] [c0333280] __sys_recvmsg+0x40/0x84
> [=C2=A0 152.448321] [c650df10] [c0333680] SyS_socketcall+0xb8/0x1d4
> [=C2=A0 152.453832] [c650df40] [c000d1ac] ret_from_syscall+0x0/0x38
> [=C2=A0 152.459286] Instruction dump:
> [=C2=A0 152.462225] 41beffac 4bffff58 38800003 4bffffa0 38800001 4bffff98=
=20
> 7c0802a6 9421fff0
> [=C2=A0 152.469881] bfc10008 90010014 83c30010 812300a8 <815e0050> 3bfe00=
e0=20
> 71480200 4082003c
> [=C2=A0 152.477739] c619ec00: 00 00 00 00 00 00 00 00 00 00 00 23 6f d9 b=
1 65
> [=C2=A0 152.484100] c619ec10: c6 23 64 00 00 00 00 00 c6 42 c0 60 00 00 0=
3 e8
> [=C2=A0 152.490471] c619ec20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0=
0 00
> [=C2=A0 152.496837] c619ec30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0=
0 00
> [=C2=A0 152.503205] c619ec40: 00 00 00 00 00 00 00 00 00 00 00 00 c0 43 5=
f b8
> [=C2=A0 152.509575] c619ec50: 00 00 00 00 00 00 00 00 00 00 00 8e 00 00 0=
0 00
> [=C2=A0 152.515943] c619ec60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0=
0 00
> [=C2=A0 152.522311] c619ec70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0=
0 00
> [=C2=A0 152.528680] c619ec80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0=
0 00
> [=C2=A0 152.535048] c619ec90: 00 00 ff ff 00 00 ff ff c6 42 30 8e c6 42 3=
1 50
> [=C2=A0 152.541417] c619eca0: c6 42 30 00 c6 42 30 00 00 00 02 b0 00 00 0=
0 01
> [=C2=A0 152.547781] ---[ end trace 0710a9d231876a27 ]---
>
> Christophe
