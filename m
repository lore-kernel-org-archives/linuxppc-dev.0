Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9260167BAA
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  2 Jul 2005 00:34:34 +1000 (EST)
Date: Fri, 1 Jul 2005 06:44:38 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Anton =?iso-8859-1?Q?W=F6llert?= <a.woellert@gmail.com>
Message-ID: <20050701094438.GA11121@logos.cnet>
References: <42C1AAC1.4060702@gmail.com> <20050629085913.GA2153@logos.cnet>
	<faba7798050630071347d4ad63@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <faba7798050630071347d4ad63@mail.gmail.com>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: mpc8xx and ld.so problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi Anton,


(moving to ppc-embedded since it might be of interesting for other=20
8xx users)

On Thu, Jun 30, 2005 at 04:13:30PM +0200, Anton W=F6llert wrote:
> Hello Marcelo
>=20
> I suggest you should find out why binaries hang and where.
> >=20
> > You can see where processes are sleeping with:
> >=20
> > ps -axeo "command nwchan"
> >=20
>=20
> thank you for that tip. but i found out (what i should have had to do=20
> before), that the application doesn't hang in kernel-mode. so wchan doe=
sn't=20
> say anything. but with gdb i saw the problem, the application hangs in =
the=20
> function memset at the instruction dcbz, this should be a instruction, =
that=20
> loops until it something is zero or so ( sorry, that i didn't looked up=
 it=20
> yet, i will do that ). and because of the bug of these dcbx instruction=
s on=20
> 8xx i think, that this is the cause. here my gdb-session, i hope you ma=
y=20
> find it helpful or give me an advise how to fix that :
>=20
> awoeller@zwiebel
> :~/ToolChains/new.usr.chain/powerpc-linux-toolchain/src/busybox-1.00$po=
werpc-linux-gdb
> GNU gdb 6.3
> Copyright 2004 Free Software Foundation, Inc.
> GDB is free software, covered by the GNU General Public License, and yo=
u are
> welcome to change it and/or distribute copies of it under certain=20
> conditions.
> Type "show copying" to see the conditions.
> There is absolutely no warranty for GDB. Type "show warranty" for detai=
ls.
> This GDB was configured as "--host=3Di686-linux --target=3Dpowerpc-linu=
x".
> (gdb) set solib-absolute-prefix /tmp/fakelibc=20
> (gdb) file busybox
> Reading symbols from=20
> /home/awoeller/ToolChains/new.usr.chain/powerpc-linux-toolchain/src/bus=
ybox-
> 1.00/busybox...done.
> (gdb) b main
> Breakpoint 1 at 0x1000398c: file=20
> /home/awoeller/ToolChains/new.usr.chain/powerpc-linux-toolchain/src/bus=
ybox-
> 1.00/applets/busybox.c, line 75.
> (gdb) target remote tqm850l:123
> Remote debugging using tqm850l:123
> 0x300103f4 in ?? ()
> (gdb) cont
> Continuing.
> # here i interrupt, because it hangs
> Program received signal SIGINT, Interrupt.
> 0x30013e58 in ?? ()
> (gdb) return
> Make selected stack frame return now? (y or n) y
> #0 0x3000e374 in ?? ()
> (gdb) cont
> Continuing.
>=20
> Breakpoint 1, main (argc=3D1, argv=3D0x7ffffeb4) at=20
> /home/awoeller/ToolChains/new.usr.chain/powerpc-linux-toolchain/src/bus=
ybox-
> 1.00/applets/busybox.c:75
> 75 bb_applet_name =3D argv[0];
>=20
> (gdb) disas 0x30013e58
> Dump of assembler code for function memset:
> 0x30013ba4 <memset+0>: cmplwi cr1,r5,4
> 0x30013ba8 <memset+4>: andi. r7,r3,3
> 0x30013bac <memset+8>: mr r6,r3
> 0x30013bb0 <memset+12>: ble- cr1,0x30013d40 <memset+412>
> 0x30013bb4 <memset+16>: cmplwi cr5,r5,31
> 0x30013bb8 <memset+20>: rlwimi r4,r4,8,16,23
> 0x30013bbc <memset+24>: beq+ 0x30013be0 <memset+60>
> 0x30013bc0 <memset+28>: mtcrf 1,r3
> 0x30013bc4 <memset+32>: subfic r7,r7,4
> 0x30013bc8 <memset+36>: add r6,r6,r7
> 0x30013bcc <memset+40>: subf r5,r7,r5
> 0x30013bd0 <memset+44>: bns+ cr7,0x30013bdc <memset+56>
> 0x30013bd4 <memset+48>: stb r4,0(r3)
> 0x30013bd8 <memset+52>: beq- cr7,0x30013be0 <memset+60>
> 0x30013bdc <memset+56>: sth r4,-2(r6)
> 0x30013be0 <memset+60>: mtcrf 1,r5
> 0x30013be4 <memset+64>: rlwimi r4,r4,16,0,15
> 0x30013be8 <memset+68>: ble- cr5,0x30013d80 <memset+476>
> 0x30013bec <memset+72>: andi. r7,r6,28
> 0x30013bf0 <memset+76>: subfic r7,r7,32
> 0x30013bf4 <memset+80>: beq- 0x30013c34 <memset+144>
> 0x30013bf8 <memset+84>: mtcrf 1,r7
> 0x30013bfc <memset+88>: add r6,r6,r7
> 0x30013c00 <memset+92>: subf r5,r7,r5
> 0x30013c04 <memset+96>: cmplwi cr1,r7,16
> 0x30013c08 <memset+100>: mr r8,r6
> 0x30013c0c <memset+104>: bge- cr7,0x30013c18 <memset+116>
> 0x30013c10 <memset+108>: stw r4,-4(r8)
> 0x30013c14 <memset+112>: stwu r4,-8(r8)
> 0x30013c18 <memset+116>: blt- cr1,0x30013c2c <memset+136>
> 0x30013c1c <memset+120>: stw r4,-4(r8)
> 0x30013c20 <memset+124>: stw r4,-8(r8)
> 0x30013c24 <memset+128>: stw r4,-12(r8)
> 0x30013c28 <memset+132>: stwu r4,-16(r8)
> 0x30013c2c <memset+136>: ble- cr7,0x30013c34 <memset+144>
> 0x30013c30 <memset+140>: stw r4,-4(r8)
> 0x30013c34 <memset+144>: cmplwi cr1,r4,0
> 0x30013c38 <memset+148>: rlwinm. r7,r5,0,0,26
> 0x30013c3c <memset+152>: mtcrf 1,r5
> 0x30013c40 <memset+156>: beq- cr1,0x30013de0 <memset+572>
> 0x30013c44 <memset+160>: rlwinm r0,r7,27,5,31
> 0x30013c48 <memset+164>: mtctr r0
> 0x30013c4c <memset+168>: beq- 0x30013d80 <memset+476>
> 0x30013c50 <memset+172>: clrlwi. r5,r5,27
> 0x30013c54 <memset+176>: add r6,r6,r7
> 0x30013c58 <memset+180>: li r8,-64
> 0x30013c5c <memset+184>: bdz- 0x30013c90 <memset+236>
> 0x30013c60 <memset+188>: dcbtst r8,r6
> 0x30013c64 <memset+192>: stw r4,-4(r6)
> 0x30013c68 <memset+196>: stw r4,-8(r6)
> 0x30013c6c <memset+200>: stw r4,-12(r6)
> 0x30013c70 <memset+204>: stw r4,-16(r6)
> 0x30013c74 <memset+208>: nop
> 0x30013c78 <memset+212>: stw r4,-20(r6)
> 0x30013c7c <memset+216>: stw r4,-24(r6)
> 0x30013c80 <memset+220>: nop
> 0x30013c84 <memset+224>: stw r4,-28(r6)
> 0x30013c88 <memset+228>: stwu r4,-32(r6)
> 0x30013c8c <memset+232>: bdnz+ 0x30013c60 <memset+188>
> 0x30013c90 <memset+236>: stw r4,-4(r6)
> 0x30013c94 <memset+240>: stw r4,-8(r6)
> 0x30013c98 <memset+244>: stw r4,-12(r6)
> 0x30013c9c <memset+248>: stw r4,-16(r6)
> 0x30013ca0 <memset+252>: stw r4,-20(r6)
> 0x30013ca4 <memset+256>: cmplwi cr1,r5,16
> 0x30013ca8 <memset+260>: stw r4,-24(r6)
> 0x30013cac <memset+264>: stw r4,-28(r6)
> 0x30013cb0 <memset+268>: stwu r4,-32(r6)
> 0x30013cb4 <memset+272>: beqlr=20
> 0x30013cb8 <memset+276>: add r6,r6,r7
> 0x30013cbc <memset+280>: b 0x30013d84 <memset+480>
> 0x30013cc0 <memset+284>: nop
> 0x30013cc4 <memset+288>: clrlwi r5,r5,27
> 0x30013cc8 <memset+292>: mtcrf 2,r7
> 0x30013ccc <memset+296>: rlwinm. r0,r7,25,7,31
> ---Type <return> to continue, or q <return> to quit---=20
> 0x30013cd0 <memset+300>: mtctr r0
> 0x30013cd4 <memset+304>: li r7,32
> 0x30013cd8 <memset+308>: li r8,-64
> 0x30013cdc <memset+312>: cmplwi cr1,r5,16
> 0x30013ce0 <memset+316>: bne- cr6,0x30013cec <memset+328>
> 0x30013ce4 <memset+320>: dcbz r0,r6
> 0x30013ce8 <memset+324>: addi r6,r6,32
> 0x30013cec <memset+328>: li r9,-32
> 0x30013cf0 <memset+332>: ble- cr6,0x30013d00 <memset+348>
> 0x30013cf4 <memset+336>: dcbz r0,r6
> 0x30013cf8 <memset+340>: dcbz r7,r6
> 0x30013cfc <memset+344>: addi r6,r6,64
> 0x30013d00 <memset+348>: cmplwi cr5,r5,0
> 0x30013d04 <memset+352>: beq- 0x30013d80 <memset+476>
> 0x30013d08 <memset+356>: dcbz r0,r6
> 0x30013d0c <memset+360>: dcbz r7,r6
> 0x30013d10 <memset+364>: addi r6,r6,128
> 0x30013d14 <memset+368>: dcbz r8,r6
> 0x30013d18 <memset+372>: dcbz r9,r6
> 0x30013d1c <memset+376>: bdnz+ 0x30013d08 <memset+356>
> 0x30013d20 <memset+380>: beqlr cr5
> 0x30013d24 <memset+384>: b 0x30013d84 <memset+480>
> 0x30013d28 <memset+388>: nop
> 0x30013d2c <memset+392>: nop
> 0x30013d30 <memset+396>: nop
> 0x30013d34 <memset+400>: nop
> 0x30013d38 <memset+404>: nop
> 0x30013d3c <memset+408>: nop
> 0x30013d40 <memset+412>: cmplwi cr5,r5,1
> 0x30013d44 <memset+416>: cmplwi cr1,r5,3
> 0x30013d48 <memset+420>: bltlr cr5
> 0x30013d4c <memset+424>: stb r4,0(r6)
> 0x30013d50 <memset+428>: beqlr cr5
> 0x30013d54 <memset+432>: nop
> 0x30013d58 <memset+436>: stb r4,1(r6)
> 0x30013d5c <memset+440>: bltlr cr1
> 0x30013d60 <memset+444>: stb r4,2(r6)
> 0x30013d64 <memset+448>: beqlr cr1
> 0x30013d68 <memset+452>: nop
> 0x30013d6c <memset+456>: stb r4,3(r6)
> 0x30013d70 <memset+460>: blr
> 0x30013d74 <memset+464>: nop
> 0x30013d78 <memset+468>: nop
> 0x30013d7c <memset+472>: nop
> 0x30013d80 <memset+476>: cmplwi cr1,r5,16
> 0x30013d84 <memset+480>: add r6,r6,r5
> 0x30013d88 <memset+484>: bso- cr7,0x30013da8 <memset+516>
> 0x30013d8c <memset+488>: beq- cr7,0x30013db0 <memset+524>
> 0x30013d90 <memset+492>: bgt- cr7,0x30013db8 <memset+532>
> 0x30013d94 <memset+496>: bge- cr1,0x30013dc0 <memset+540>
> 0x30013d98 <memset+500>: bgelr cr7
> 0x30013d9c <memset+504>: stw r4,-4(r6)
> 0x30013da0 <memset+508>: stw r4,-8(r6)
> 0x30013da4 <memset+512>: blr
> 0x30013da8 <memset+516>: stbu r4,-1(r6)
> 0x30013dac <memset+520>: bne- cr7,0x30013d90 <memset+492>
> 0x30013db0 <memset+524>: sthu r4,-2(r6)
> 0x30013db4 <memset+528>: ble- cr7,0x30013d94 <memset+496>
> 0x30013db8 <memset+532>: stwu r4,-4(r6)
> 0x30013dbc <memset+536>: blt- cr1,0x30013dd0 <memset+556>
> 0x30013dc0 <memset+540>: stw r4,-4(r6)
> 0x30013dc4 <memset+544>: stw r4,-8(r6)
> 0x30013dc8 <memset+548>: stw r4,-12(r6)
> 0x30013dcc <memset+552>: stwu r4,-16(r6)
> 0x30013dd0 <memset+556>: bgelr cr7
> 0x30013dd4 <memset+560>: stw r4,-4(r6)
> 0x30013dd8 <memset+564>: stw r4,-8(r6)
> 0x30013ddc <memset+568>: blr
> 0x30013de0 <memset+572>: mflr r0
> 0x30013de4 <memset+576>: beq+ 0x30013d80 <memset+476>
> 0x30013de8 <memset+580>: bl 0x30029000 <_dl_auxv+180>
> 0x30013dec <memset+584>: mflr r9
> 0x30013df0 <memset+588>: lwz r9,1832(r9)
> 0x30013df4 <memset+592>: lwz r8,0(r9)
> 0x30013df8 <memset+596>: mtlr r0
> 0x30013dfc <memset+600>: cmplwi cr1,r8,0
> ---Type <return> to continue, or q <return> to quit---
> 0x30013e00 <memset+604>: beq+ cr1,0x30013c44 <memset+160>
> 0x30013e04 <memset+608>: cmplwi cr1,r8,32
> 0x30013e08 <memset+612>: beq+ cr1,0x30013cc4 <memset+288>
> 0x30013e0c <memset+616>: dcbtst r0,r6
> 0x30013e10 <memset+620>: addi r9,r8,-1
> 0x30013e14 <memset+624>: cmplwi cr1,r5,32
> 0x30013e18 <memset+628>: and. r0,r9,r6
> 0x30013e1c <memset+632>: blt- cr1,0x30013e68 <memset+708>
> 0x30013e20 <memset+636>: beq- 0x30013e50 <memset+684>
> 0x30013e24 <memset+640>: addi r6,r6,32
> 0x30013e28 <memset+644>: addi r5,r5,-32
> 0x30013e2c <memset+648>: stw r4,-32(r6)
> 0x30013e30 <memset+652>: stw r4,-28(r6)
> 0x30013e34 <memset+656>: stw r4,-24(r6)
> 0x30013e38 <memset+660>: stw r4,-20(r6)
> 0x30013e3c <memset+664>: stw r4,-16(r6)
> 0x30013e40 <memset+668>: stw r4,-12(r6)
> 0x30013e44 <memset+672>: stw r4,-8(r6)
> 0x30013e48 <memset+676>: stw r4,-4(r6)
> 0x30013e4c <memset+680>: b 0x30013e14 <memset+624>
> 0x30013e50 <memset+684>: cmplw cr1,r5,r8
> 0x30013e54 <memset+688>: blt- cr1,0x30013e68 <memset+708>
>=20
>=20
> 0x30013e58 <memset+692>: dcbz r0,r6 #<--- the problem
>=20
>=20
> 0x30013e5c <memset+696>: subf r5,r8,r5
> 0x30013e60 <memset+700>: add r6,r6,r8
> 0x30013e64 <memset+704>: b 0x30013e50 <memset+684>
> 0x30013e68 <memset+708>: rlwinm. r7,r5,0,0,26
> 0x30013e6c <memset+712>: b 0x30013c44 <memset+160>
> 0x30013e70 <memset+716>: nop
> 0x30013e74 <memset+720>: nop
> 0x30013e78 <memset+724>: nop
> 0x30013e7c <memset+728>: nop

Can you please examine in more detail what is going on here?=20

What are the contents of the r0 and r6 registers, where exactly is the
task stopped.

I _guess_ it might be some form of "dcbz" misbehaviour, in such case I=20
imagine that either the task would loop forever or execute an invalid
exception/instruction.
