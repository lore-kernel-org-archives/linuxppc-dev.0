Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 797E3DE4DC
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Feb 2008 06:18:43 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Kernel oops while duming user core.
Date: Thu, 31 Jan 2008 13:18:41 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B03EE485C@ismail.innsys.innovsys.com>
In-Reply-To: <FAC79874-50F8-4C14-AE9B-A17BC51E8E87@kernel.crashing.org>
References: <DCEAAC0833DD314AB0B58112AD99B93B03EE44A5@ismail.innsys.innovsys.com><20080131161527.GT14201@localdomain>
	<DCEAAC0833DD314AB0B58112AD99B93B03EE46B8@ismail.innsys.innovsys.com>
	<DCEAAC0833DD314AB0B58112AD99B93B03EE47A4@ismail.innsys.innovsys.com>
	<FAC79874-50F8-4C14-AE9B-A17BC51E8E87@kernel.crashing.org>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Nathan Lynch <ntl@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> This doesn't look like ppc disasm to me :)
>=20

Helps if i use the cross-compiler gdb instead of the x86 native one...
here is the disasembly dump for NIP

(gdb) disassemble 0xc000f0a0
Dump of assembler code for function __flush_dcache_icache:
0xc000f08c <__flush_dcache_icache+0>:   blr
0xc000f090 <__flush_dcache_icache+4>:   rlwinm  r3,r3,0,0,19
0xc000f094 <__flush_dcache_icache+8>:   li      r4,128
0xc000f098 <__flush_dcache_icache+12>:  mtctr   r4
0xc000f09c <__flush_dcache_icache+16>:  mr      r6,r3
0xc000f0a0 <__flush_dcache_icache+20>:  dcbst   r0,r3
0xc000f0a4 <__flush_dcache_icache+24>:  addi    r3,r3,32
0xc000f0a8 <__flush_dcache_icache+28>:  bdnz+   0xc000f0a0
<__flush_dcache_icache+20>
0xc000f0ac <__flush_dcache_icache+32>:  sync
0xc000f0b0 <__flush_dcache_icache+36>:  mtctr   r4
0xc000f0b4 <__flush_dcache_icache+40>:  icbi    r0,r6
0xc000f0b8 <__flush_dcache_icache+44>:  addi    r6,r6,32
0xc000f0bc <__flush_dcache_icache+48>:  bdnz+   0xc000f0b4
<__flush_dcache_icache+40>
0xc000f0c0 <__flush_dcache_icache+52>:  sync
0xc000f0c4 <__flush_dcache_icache+56>:  isync
0xc000f0c8 <__flush_dcache_icache+60>:  blr
End of assembler dump.
(gdb)                =20

registers were:
NIP: c000f0a0 LR: c0011fec CTR: 00000080
REGS: eebe9b70 TRAP: 0300   Tainted: P         (2.6.24-test)
MSR: 00009032 <EE,ME,IR,DR>  CR: 24004442  XER: 00000000
DAR: 48024000, DSISR: 20000000
TASK =3D eeba9780[2554] 'armd_crash' THREAD: eebe8000
GPR00: eea44d00 eebe9c20 eeba9780 48024000 00000080 37a56181 48024000
00000000
GPR08: 37a56181 eea44d00 00000000 c2000000 44004422 10100f38 ef336600
bfffffff
GPR16: eeff0300 00000030 eea44d00 00000000 eebe9cdc 00000011 eebe9cd8
eebca480
GPR24: eea44d00 37a56181 48024000 eebad580 eebad580 37a56181 48024000
c26f4ac0
