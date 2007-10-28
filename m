Return-Path: <wangbj@lzu.edu.cn>
Received: from eyou.net (unknown [202.201.0.146])
	by ozlabs.org (Postfix) with SMTP id 1F0C7DDF2D
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Oct 2007 20:05:26 +1100 (EST)
Message-ID: <393624666.03196@eyou.net>
From: "Wang, Baojun" <wangbj@lzu.edu.cn>
To: Nicholas Mc Guire <der.herr@hofr.at>, gdb@sourceware.org,
	linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
Subject: Unable to single step under ppc?
Date: Sun, 28 Oct 2007 17:05:28 +0800
References: <393259296.28502@eyou.net> <393618278.29200@eyou.net>
	<393557867.17823@lzu.edu.cn>
In-Reply-To: <393557867.17823@lzu.edu.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1441946.0FxMqeCmcg";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200710281705.30733.wangbj@lzu.edu.cn>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart1441946.0FxMqeCmcg
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 27 October 2007 07:14:45, you wrote=EF=BC=9A
> >>>        stw     r0,INT_FRAME_SIZE+4(r1)
> >>>
> >>>        stw     r31,INT_FRAME_SIZE+128(r1)
> >>>
> >>>        lwz     r5,EVENTS_USER_ADDR_OFFSET(r4)
> >>>        mr      r31,r5	/* r31 to hold new_domain->events_user_addr */
> >>>
> >>>        cmpwi   r3,0
> >>>        beq     1f
> >>>
> >>>        mtctr   r3
>
>                    ^^^^^ whats in R3 then ? Having 0 in r3 seems plain
>                          wrong !
>
> > hi, If they were not setup properly in tlb, then we should get a
> > DataTLBError/InstructionTLBError, I single stepped(stepi) to the `mtctr'
> > insn, then set a breakpoint at DataTLBError/InstructionTLBError, but bo=
th
> > of them were not triggered. Also, when I was at `mtctr', I could not
> > single step (use stepi) thus unable to debug the program.
>
> If you cant single step over this instruction then the address
> you are loading must have some problem.
>
> hofrat

Hi, I'm using bdi2000/gdb to debug a program which is like a module (the=20
excutable is loaded by myself), but I can not single step while executing=20
`bctrl', where ctr contains the valid address for the _start() function, it=
=20
is valid because I could use `x' or `disas' command to display the contents=
=20
of register `ctr', however when `bctrl' execute, I got unable to access=20
address xxx, what the problem could be? Could somebody give me some hints?=
=20
Thanks very much.


here is a sample debug session:

(gdb) b jump_xm_dom
Breakpoint 1 at 0xc001e694
(gdb) c
Continuing.

Breakpoint 1, 0xc001e694 in jump_xm_dom ()
Current language:  auto; currently asm
(gdb) disas $pc $pc+32
Dump of assembler code from 0xc001e694 to 0xc001e6b4:
0xc001e694 <jump_xm_dom+16>:    lwz     r5,36(r4)
0xc001e698 <jump_xm_dom+20>:    mr      r31,r5
0xc001e69c <jump_xm_dom+24>:    cmpwi   r3,0
0xc001e6a0 <jump_xm_dom+28>:    beq-    0xc001e6c0 <jump_xm_dom+60>
0xc001e6a4 <jump_xm_dom+32>:    mfmsr   r11
0xc001e6a8 <jump_xm_dom+36>:    stw     r11,240(r1)	/* store old msr */
0xc001e6ac <jump_xm_dom+40>:    andi.   r11,r11,16384	/* drop privilege */
0xc001e6b0 <jump_xm_dom+44>:    mtmsr   r11
End of assembler dump.
(gdb) nexti
0xc001e698 in jump_xm_dom ()
(gdb)
0xc001e69c in jump_xm_dom ()
(gdb)
0xc001e6a0 in jump_xm_dom ()
(gdb)
0xc001e6a4 in jump_xm_dom ()
(gdb)
0xc001e6a8 in jump_xm_dom ()
(gdb)
0xc001e6ac in jump_xm_dom ()
(gdb)
0xc001e6b0 in jump_xm_dom ()
(gdb) disas $pc $pc+32
Dump of assembler code from 0xc001e6b0 to 0xc001e6d0:
0xc001e6b0 <jump_xm_dom+44>:    mtmsr   r11
0xc001e6b4 <jump_xm_dom+48>:    mtctr   r3	/* r3 contains _start() address =
*/
0xc001e6b8 <jump_xm_dom+52>:    bctrl
0xc001e6bc <jump_xm_dom+56>:    li      r3,0
0xc001e6c0 <jump_xm_dom+60>:    lwz     r31,320(r1)	/* restore r31 */
0xc001e6c4 <jump_xm_dom+64>:    lwz     r11,240(r1)	/* restore msr */
0xc001e6c8 <jump_xm_dom+68>:    mtmsr   r11
0xc001e6cc <jump_xm_dom+72>:    lwz     r0,196(r1)
End of assembler dump.
(gdb) nexti
0xc001e6b4 in jump_xm_dom ()
(gdb)
0xc001e6b8 in jump_xm_dom ()
(gdb) info registers
r0             0xc001b908       3221338376
r1             0xd1072e60       3506908768
r2             0xc0549b70       3226770288
r3             0x10000094       268435604
r4             0xd106c000       3506880512
r5             0x2000000        33554432
r6             0xc014033c       3222537020
r7             0xc0240000       3223584768
r8             0x20000  131072
r9             0xc02c0000       3224109056
r10            0x0      0
r11            0x0      0
r12            0x0      0
r13            0x0      0
r14            0x0      0
r15            0x0      0
r16            0x0      0
r17            0x0      0
r18            0x0      0
r19            0x0      0
r20            0x0      0
r21            0x0      0
r22            0x0      0
r23            0x0      0
r24            0x0      0
r25            0x0      0
r26            0x0      0
r27            0x0      0
r28            0x0      0
r29            0xc02c0000       3224109056
r30            0x0      0
r31            0x2000000        33554432
pc             0xc001e6b8       3221350072
cr             0x28000022       671088674
lr             0xc001b908       3221338376
=2D--Type <return> to continue, or q <return> to quit---
ctr            0x10000094       268435604
xer            0x0      0
(gdb) x/32b $r3
0x10000094:     0x94    0x21    0xff    0x40    0x7c    0x08    0x02    0xa6
0x1000009c:     0x90    0x01    0x00    0xc4    0x7f    0xe3    0xfb    0x78
0x100000a4:     0x3d    0x20    0x10    0x01    0x90    0x69    0x07    0xa0
0x100000ac:     0x48    0x00    0x02    0x55    0x80    0x01    0x00    0xc4
(gdb) disas $r3 $r3+32
Dump of assembler code from 0x10000094 to 0x100000b4:
0x10000094:     stwu    r1,-192(r1)
0x10000098:     mflr    r0
0x1000009c:     stw     r0,196(r1)
0x100000a0:     mr      r3,r31
0x100000a4:     lis     r9,4097
0x100000a8:     stw     r3,1952(r9)
0x100000ac:     bl      0x10000300
0x100000b0:     lwz     r0,196(r1)
End of assembler dump.
(gdb) nexti
Cannot access memory at address 0xd1072e60	/* this is the SP address */
(gdb)
0x10000094 in ?? ()
Cannot access memory at address 0x10000094	/* r3 or ctr address */
(gdb)

the address 0x10000094 is accessable before `bctrl' we could see.. Is it=20
because $r3 is just contain a address just for data access not instruction=
=20
access? the page prot is: _PAGE_PRESENT | _PAGE_RW | _PAGE_HWEXEC |=20
_PAGE_WRENABLE | _PAGE_USER, I think it's ready for exec..


  Regards,
Wang
=2D-=20
Wang, Baojun =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0Lanzhou University
Distributed & Embedded System Lab =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0http://dslab.lzu.edu.cn
School of Information Science and Engeneering =C2=A0 =C2=A0 =C2=A0 =C2=A0wa=
ngbj@lzu.edu.cn
Tianshui South Road 222. Lanzhou 730000 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .P.R.China
Tel:+86-931-8912025 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Fax:+86-931-8912022

--nextPart1441946.0FxMqeCmcg
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBHJFDZIuIOr7tpgg0RAkwhAJ4wCTTTt1yUaEwunWU/4lUU3Y1AygCfevxg
nHU2FnYCN+5Aku4Jgzcmoqo=
=495B
-----END PGP SIGNATURE-----

--nextPart1441946.0FxMqeCmcg--
